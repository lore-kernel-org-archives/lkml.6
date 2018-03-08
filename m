Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965304AbeCHJ2T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:28:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935057AbeCHJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:28:16 -0500
Date: Thu, 8 Mar 2018 01:28:02 -0800
From: tip-bot for Ashok Raj <tipbot@zytor.com>
Message-ID: <tip-a5321aec6412b20b5ad15db2d6b916c05349dbff@git.kernel.org>
Cc: arjan.van.de.ven@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        bp@suse.de, ashok.raj@intel.com, thomas.lendacky@amd.com
Reply-To: ashok.raj@intel.com, bp@suse.de, thomas.lendacky@amd.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        arjan.van.de.ven@intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180228102846.13447-8-bp@alien8.de>
References: <20180228102846.13447-8-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode: Synchronize late microcode loading
Git-Commit-ID: a5321aec6412b20b5ad15db2d6b916c05349dbff
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a5321aec6412b20b5ad15db2d6b916c05349dbff
Gitweb:     https://git.kernel.org/tip/a5321aec6412b20b5ad15db2d6b916c05349dbff
Author:     Ashok Raj <ashok.raj@intel.com>
AuthorDate: Wed, 28 Feb 2018 11:28:46 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:19:26 +0100

x86/microcode: Synchronize late microcode loading

Original idea by Ashok, completely rewritten by Borislav.

Before you read any further: the early loading method is still the
preferred one and you should always do that. The following patch is
improving the late loading mechanism for long running jobs and cloud use
cases.

Gather all cores and serialize the microcode update on them by doing it
one-by-one to make the late update process as reliable as possible and
avoid potential issues caused by the microcode update.

[ Borislav: Rewrite completely. ]

Co-developed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-8-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/core.c | 118 +++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 5dd157d48606..70ecbc8099c9 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -22,13 +22,16 @@
 #define pr_fmt(fmt) "microcode: " fmt
 
 #include <linux/platform_device.h>
+#include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
 #include <linux/firmware.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/cpu.h>
+#include <linux/nmi.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 
@@ -64,6 +67,11 @@ LIST_HEAD(microcode_cache);
  */
 static DEFINE_MUTEX(microcode_mutex);
 
+/*
+ * Serialize late loading so that CPUs get updated one-by-one.
+ */
+static DEFINE_SPINLOCK(update_lock);
+
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -486,6 +494,19 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
+/*
+ * Late loading dance. Why the heavy-handed stomp_machine effort?
+ *
+ * - HT siblings must be idle and not execute other code while the other sibling
+ *   is loading microcode in order to avoid any negative interactions caused by
+ *   the loading.
+ *
+ * - In addition, microcode update on the cores must be serialized until this
+ *   requirement can be relaxed in the future. Right now, this is conservative
+ *   and good.
+ */
+#define SPINUNIT 100 /* 100 nsec */
+
 static int check_online_cpus(void)
 {
 	if (num_online_cpus() == num_present_cpus())
@@ -496,23 +517,85 @@ static int check_online_cpus(void)
 	return -EINVAL;
 }
 
-static enum ucode_state reload_for_cpu(int cpu)
+static atomic_t late_cpus;
+
+/*
+ * Returns:
+ * < 0 - on error
+ *   0 - no update done
+ *   1 - microcode was updated
+ */
+static int __reload_late(void *info)
 {
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	unsigned int timeout = NSEC_PER_SEC;
+	int all_cpus = num_online_cpus();
+	int cpu = smp_processor_id();
+	enum ucode_state err;
+	int ret = 0;
 
-	if (!uci->valid)
-		return UCODE_OK;
+	atomic_dec(&late_cpus);
+
+	/*
+	 * Wait for all CPUs to arrive. A load will not be attempted unless all
+	 * CPUs show up.
+	 * */
+	while (atomic_read(&late_cpus)) {
+		if (timeout < SPINUNIT) {
+			pr_err("Timeout while waiting for CPUs rendezvous, remaining: %d\n",
+				atomic_read(&late_cpus));
+			return -1;
+		}
+
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+
+		touch_nmi_watchdog();
+	}
+
+	spin_lock(&update_lock);
+	apply_microcode_local(&err);
+	spin_unlock(&update_lock);
+
+	if (err > UCODE_NFOUND) {
+		pr_warn("Error reloading microcode on CPU %d\n", cpu);
+		ret = -1;
+	} else if (err == UCODE_UPDATED) {
+		ret = 1;
+	}
 
-	return apply_microcode_on_target(cpu);
+	atomic_inc(&late_cpus);
+
+	while (atomic_read(&late_cpus) != all_cpus)
+		cpu_relax();
+
+	return ret;
+}
+
+/*
+ * Reload microcode late on all CPUs. Wait for a sec until they
+ * all gather together.
+ */
+static int microcode_reload_late(void)
+{
+	int ret;
+
+	atomic_set(&late_cpus, num_online_cpus());
+
+	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	if (ret < 0)
+		return ret;
+	else if (ret > 0)
+		microcode_check();
+
+	return ret;
 }
 
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	int cpu, bsp = boot_cpu_data.cpu_index;
 	enum ucode_state tmp_ret = UCODE_OK;
-	bool do_callback = false;
+	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
 	ssize_t ret = 0;
 
@@ -534,30 +617,13 @@ static ssize_t reload_store(struct device *dev,
 		goto put;
 
 	mutex_lock(&microcode_mutex);
-
-	for_each_online_cpu(cpu) {
-		tmp_ret = reload_for_cpu(cpu);
-		if (tmp_ret > UCODE_NFOUND) {
-			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-
-			/* set retval for the first encountered reload error */
-			if (!ret)
-				ret = -EINVAL;
-		}
-
-		if (tmp_ret == UCODE_UPDATED)
-			do_callback = true;
-	}
-
-	if (!ret && do_callback)
-		microcode_check();
-
+	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
 
 put:
 	put_online_cpus();
 
-	if (!ret)
+	if (ret >= 0)
 		ret = size;
 
 	return ret;
