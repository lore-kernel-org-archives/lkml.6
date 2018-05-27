Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032879AbeE0Pqa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:46:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:28381 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032700AbeE0PqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741079"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 06/16] x86/split_lock: Save #AC setting for split lock in firmware in boot time and restore the setting in reboot
Date: Sun, 27 May 2018 08:45:55 -0700
Message-Id: <1527435965-202085-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware may contain split locked instructions. #AC handler in firmware may
treat split lock as fatal fault and stop execution. If kernel enables
#AC exception for split locked accesses and then kernel returns to
firmware during reboot, the firmware reboot code may hit #AC exception and
block the reboot. This issue happens in reality.

Instead of debugging the buggy firmware, setting of #AC for split lock is
restored to original firmware setting to hide the potential firmware issue
and allow kernel reboot succeed.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h     |  2 ++
 arch/x86/kernel/cpu/test_ctl.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 00f453fd44ac..45fec729c470 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int sig);
 void detect_split_lock_ac(void);
 bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
 void setup_split_lock(void);
+void restore_split_lock_ac_firmware(void);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline void detect_split_lock_ac(void) {}
 static inline bool
@@ -53,5 +54,6 @@ do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 }
 
 static inline void setup_split_lock(void) {}
+static inline void restore_split_lock_ac_firmware(void) {}
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index c72c0517c6ab..9e47f8174a47 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -15,6 +15,7 @@
 #include <linux/workqueue.h>
 #include <linux/cpu.h>
 #include <linux/mm.h>
+#include <linux/reboot.h>
 #include <asm/msr.h>
 
 #define DISABLE_SPLIT_LOCK_AC		0
@@ -29,6 +30,7 @@ static unsigned long disable_split_lock_jiffies;
 static DEFINE_MUTEX(reexecute_split_lock_mutex);
 
 static int split_lock_ac_kernel = DISABLE_SPLIT_LOCK_AC;
+static int split_lock_ac_firmware = DISABLE_SPLIT_LOCK_AC;
 
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_split_lock_ac(void)
@@ -62,6 +64,12 @@ void detect_split_lock_ac(void)
 	 * before leaving.
 	 */
 	wrmsrl(MSR_TEST_CTL, orig_val);
+
+	/* Get previous firmware setting. */
+	if (orig_val & MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK)
+		split_lock_ac_firmware = ENABLE_SPLIT_LOCK_AC;
+	else
+		split_lock_ac_firmware = DISABLE_SPLIT_LOCK_AC;
 }
 
 static void _setup_split_lock(int split_lock_ac_val)
@@ -86,6 +94,41 @@ static void _setup_split_lock(int split_lock_ac_val)
 	wrmsrl(MSR_TEST_CTL, val);
 }
 
+static void restore_split_lock_ac(int split_lock_ac_val)
+{
+	_setup_split_lock(split_lock_ac_val);
+}
+
+/* Restore firmware setting for #AC exception for split lock. */
+void restore_split_lock_ac_firmware(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_AC))
+		return;
+
+	/* Don't restore the firmware setting if kernel didn't change it. */
+	if (split_lock_ac_kernel == split_lock_ac_firmware)
+		return;
+
+	restore_split_lock_ac(split_lock_ac_firmware);
+}
+
+static void split_lock_cpu_reboot(void *unused)
+{
+	restore_split_lock_ac_firmware();
+}
+
+static int split_lock_reboot_notify(struct notifier_block *nb,
+				    unsigned long code, void *unused)
+{
+	on_each_cpu_mask(cpu_online_mask, split_lock_cpu_reboot, NULL, 1);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block split_lock_reboot_nb = {
+	.notifier_call = split_lock_reboot_notify,
+};
+
 void setup_split_lock(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_AC))
@@ -221,6 +264,8 @@ static int __init split_lock_init(void)
 	if (ret < 0)
 		return ret;
 
+	register_reboot_notifier(&split_lock_reboot_nb);
+
 	return 0;
 }
 
-- 
2.5.0
