Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeBVGdt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:33:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:55370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752503AbeBVGde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:33:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="31891782"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [v2 3/3] x86/microcode: Quiesce all threads before a microcode update.
Date: Wed, 21 Feb 2018 22:33:25 -0800
Message-Id: <1519281205-58951-4-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microcode updates during OS load always assumed the other hyper-thread
was "quiet", but Linux never really did this. We've recently received
several issues on this, where things did not go well at scale
deployments, and the Intel microcode team asked us to make sure the
system is in a quiet state during these updates. Such updates are
rare events, so we use stop_machine() to ensure the whole system is
quiet.

The most robust solution is to have all the CPUs wait in
stop_machine() rendezvous before ucode update, and ensure we stay there
until all the CPUs have completed the microcode load. stop_machine ensures
that interrupts are disabled while waiting, and a spin_lock serializes
that only 1 cpu can perform the update.

Remember microcode resources are shared between the HT siblings of the same
core. So updating microcode on one thread automatically is good enough for the
sibling thread. Microcode update ensures that the version being updated is
greater than what is reported by the CPU. This ensures we do not perform a
redundant load on the HT sibling when one isn't necessary.

During early boot, we bring up one CPU at a time. Hence we only end up
loading for one of the sibling thread and subsequent sibling would already have
the latest copy of the microcode.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Boris Petkov <bp@suse.de>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>

Changes from V1:
- Check for return code of stop_machine
- When microcode file load fails, stop on first error.
- If any of the present CPUs are offline, then stop reload.
- Added more comments in commitlog and inline in file.
- split some functionality from reload_store() per Boris's comments.

What's not done from review: TBD:
- Load microcode file only once.
- Removing ucd->errors. (Gives a count of failed loads)
---
 arch/x86/kernel/cpu/microcode/core.c  | 207 ++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/microcode/intel.c |   1 +
 2 files changed, 183 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index aa1b9a4..20d2cbb 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -31,6 +31,10 @@
 #include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/nmi.h>
+#include <linux/stop_machine.h>
+#include <linux/delay.h>
+#include <linux/topology.h>
 
 #include <asm/microcode_intel.h>
 #include <asm/cpu_device_id.h>
@@ -489,30 +493,185 @@ static void __exit microcode_dev_exit(void)
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
-static enum ucode_state reload_for_cpu(int cpu)
+static struct ucode_update_param {
+	spinlock_t ucode_lock;	/* Serialize microcode updates */
+	atomic_t   count;  	/* # of CPUs that attempt to load ucode */
+	atomic_t   errors; 	/* # of CPUs ucode load failed */
+	atomic_t   enter;  	/* ucode rendezvous count */
+	int	   timeout;	/* Timeout to wait for all cpus to enter */
+} uc_data;
+
+static int do_ucode_update(int cpu, struct ucode_update_param *ucd)
 {
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	enum ucode_state ustate;
+	enum ucode_state retval = 0;
 
-	if (!uci->valid)
-		return UCODE_OK;
+	spin_lock(&ucd->ucode_lock);
+	retval = microcode_ops->apply_microcode(cpu);
+	spin_unlock(&ucd->ucode_lock);
+	if (retval > UCODE_NFOUND) {
+		atomic_inc(&ucd->errors);
+		pr_warn("microcode update to CPU %d failed\n", cpu);
+	}
+	atomic_inc(&ucd->count);
+
+	return retval;
+}
+
+/*
+ * Wait for upto 1sec for all CPUs
+ * to show up in the rendezvous function
+ */
+#define MAX_UCODE_RENDEZVOUS	1000000000 /* nanosec */
+#define SPINUNIT		100	   /* 100ns */
+
+/*
+ * Each cpu waits for 1sec max.
+ */
+static int microcode_wait_timedout(int *time_out, void *data)
+{
+	struct ucode_update_param *ucd = data;
+	if (*time_out < SPINUNIT) {
+		pr_err("Not all CPUs entered ucode update handler %d CPUs missed rendezvous\n",
+			(num_online_cpus() - atomic_read(&ucd->enter)));
+		return 1;
+	}
+	*time_out -= SPINUNIT;
+	touch_nmi_watchdog();
+	return 0;
+}
+
+/*
+ * All cpus enter here before a ucode load upto 1 sec.
+ * If not all cpus showed up, we abort the ucode update
+ * and return. ucode update is serialized with the spinlock
+ */
+static int microcode_load_rendezvous(void *data)
+{
+	int cpu = smp_processor_id();
+	struct ucode_update_param *ucd = data;
+	int timeout = MAX_UCODE_RENDEZVOUS;
+	int total_cpus = num_online_cpus();
+
+	/*
+	 * Wait for all cpu's to arrive
+	 */
+	atomic_dec(&ucd->enter);
+	while(atomic_read(&ucd->enter)) {
+		if (microcode_wait_timedout(&timeout, ucd))
+			return 1;
+		ndelay(SPINUNIT);
+	}
+
+	do_ucode_update(cpu, ucd);
+
+	/*
+	 * Wait for all cpu's to complete
+	 * ucode update
+	 */
+	while (atomic_read(&ucd->count) != total_cpus)
+		cpu_relax();
+	return 0;
+}
+
+/*
+ * If any of the cpu's present are offline, we avoid loading microcode
+ * to the rest of the system. This is simply to avoid having some CPUs with older
+ * microcode. In theory we would update for the upcoming CPU during early_load.
+ * but we want to be *PARANOID* and avoid such situations.
+ * What if some CPUs are offlined and with older microcode. There are two 
+ * senarios: 
+ *    1: Both CPUs are of a core are offline: We skip the update now, but
+ *       If they are onlined later, we will do an update then. Online operations
+ *       are serialized, so we will update one thread when the other is still
+ *       offline. When the second CPU is onlined, it already has the updated
+ *       microcode, since its sibling was updated earlier.
+ *    2: One CPU of the core is offline when we did the update. This is not
+ *       a problem, since when we online the sibling it already has a copy 
+ *       since its sibling was already updated.
+ */
+static int check_online_cpus(void)
+{
+	if (cpumask_equal(cpu_online_mask, cpu_present_mask))
+		return 0;
+	pr_err("Not all CPUs online, please online all CPUs before reloading microcode\n");
+	return 1;
+}
+
+/*
+ * when loading microcode, its important for the HT sibling to be
+ * idle, otherwise there can be some bad interaction between the sibling
+ * executing code and the microcode update process on its thread sibling.
+ * To make this less * complicated we simply park all the cpus with a
+ * stop_machine(). This * gaurantees that all cpus are spinning with
+ * interrupts disabled.
+ * - Wait for all cpus to arrive.
+ * - serialize ucode updates, to avoid 2 cpus from updating ucode at the
+ *   same time. This is required since microcode/intel.c also has some static
+ *   variables that need protection otherwise. This serves both purposes.
+ * - After updates are completed, wait for all CPUs to complete before
+ *   returing back to reload_store.
+ */
+static int perform_microcode_reload(struct ucode_update_param *ucd)
+{
+	int ret;
 
-	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
-	if (ustate != UCODE_OK)
-		return ustate;
+	memset(ucd, 0, sizeof(struct ucode_update_param));
+	spin_lock_init(&ucd->ucode_lock);
+	atomic_set(&ucd->enter, num_online_cpus());
+	/*
+	 * Wait for a 1 sec
+	 */
+	ucd->timeout = USEC_PER_SEC;
+	ret = stop_machine(microcode_load_rendezvous, ucd, cpu_online_mask);
 
-	return apply_microcode_on_target(cpu);
+	pr_debug("Total CPUS = %d unable to load on %d CPUs\n",
+		atomic_read(&ucd->count), atomic_read(&ucd->errors));
+
+	if (!(ret || atomic_read(&ucd->errors)))
+		return 0;
+
+	pr_warn("Update failed for %d CPUs\n", atomic_read(&ucd->errors));
+	return 1;
+}
+
+/*
+ * loads microcode files for all cpus.
+ * TBD: We load for each cpu which is useful
+ * if we support hetero cores. We really don't yet
+ * support hetero, so we could optimize this in future to load
+ * just for 1 cpu and reuse the same image for other cpus.
+ */
+static int reload_microcode_files(void)
+{
+	int cpu, ret = 0;
+
+	/*
+	 * First load the microcode file for all cpu's
+	 */
+	for_each_online_cpu(cpu) {
+		ret = microcode_ops->request_microcode_fw(cpu,
+				&microcode_pdev->dev, true);
+		if (ret > UCODE_NFOUND) {
+			pr_warn("Error reloading microcode file for CPU %d\n", cpu);
+
+			/*
+			 * set retval for the first encountered reload error
+			 * stop further processing of ucode loads.
+			 */
+			if (!ret)
+				ret = -EINVAL;
+			break;
+		}
+	}
+	return ret;
 }
 
 static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t size)
 {
-	enum ucode_state tmp_ret = UCODE_OK;
-	bool do_callback = false;
 	unsigned long val;
 	ssize_t ret = 0;
-	int cpu;
 
 	ret = kstrtoul(buf, 0, &val);
 	if (ret)
@@ -523,26 +682,24 @@ static ssize_t reload_store(struct device *dev,
 
 	get_online_cpus();
 	mutex_lock(&microcode_mutex);
-	for_each_online_cpu(cpu) {
-		tmp_ret = reload_for_cpu(cpu);
-		if (tmp_ret > UCODE_NFOUND) {
-			pr_warn("Error reloading microcode on CPU %d\n", cpu);
 
-			/* set retval for the first encountered reload error */
-			if (!ret)
-				ret = -EINVAL;
-		}
+	ret = check_online_cpus();
+	if (ret)
+		goto fail;
 
-		if (tmp_ret == UCODE_UPDATED)
-			do_callback = true;
-	}
+	ret = reload_microcode_files();
+	if (ret)
+		goto fail;
+
+	pr_debug("Done loading microcode file for all CPUs\n");
 
-	if (!ret && do_callback)
+	ret = perform_microcode_reload(&uc_data);
+	if (!ret)
 		microcode_check();
 
+fail:
 	mutex_unlock(&microcode_mutex);
 	put_online_cpus();
-
 	if (!ret)
 		ret = size;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 50e48c4..3d55f0b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -833,6 +833,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
+	pr_debug("ucode loading for cpu %d done\n", cpu);
 
 	rev = intel_get_microcode_revision();
 
-- 
2.7.4
