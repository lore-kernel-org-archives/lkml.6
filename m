Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeENS4K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:56:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:45332 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeENSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244638"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 06/15] x86/split_lock: Save #AC setting for split lock in BIOS in boot time and restore the setting in reboot
Date: Mon, 14 May 2018 11:52:16 -0700
Message-Id: <1526323945-211107-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BIOS may contain split locked instructions. #AC handler in BIOS may
treat split lock as fatal fault and stop execution. If kernel enables
#AC exception for split locked accesses and then kernel returns to BIOS,
the BIOS reboot code may hit #AC exception and block the reboot.

Instead of debugging the buggy BIOS, #AC setting for split lock is
restored to original BIOS setting to hide the potential BIOS issue and
allow kernel reboot succeed.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h       |  2 ++
 arch/x86/kernel/cpu/split_lock.c | 56 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 80dc27d73e81..0b00033b6fa8 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -44,10 +44,12 @@ unsigned int x86_stepping(unsigned int sig);
 int __init enumerate_split_lock(void);
 void setup_split_lock(void);
 bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
+bool restore_split_lock_ac_bios(int *enable);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline int enumerate_split_lock(void) { return 0; }
 static inline void setup_split_lock(void) {}
 static inline bool
 do_split_lock_exception(struct pt_regs *regs, unsigned long error_code) {}
+static inline bool restore_split_lock_ac_bios(int *enable) { return true; }
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index efe6f39353d1..d2735259800b 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -13,6 +13,7 @@
 #include <linux/printk.h>
 #include <linux/workqueue.h>
 #include <linux/cpu.h>
+#include <linux/reboot.h>
 #include <asm/msr.h>
 
 static bool split_lock_ac_supported;
@@ -21,6 +22,7 @@ static bool split_lock_ac_supported;
 #define	ENABLE_SPLIT_LOCK_AC		1
 
 static int split_lock_ac = DISABLE_SPLIT_LOCK_AC;
+static int split_lock_ac_bios = DISABLE_SPLIT_LOCK_AC;
 
 static DEFINE_SPINLOCK(sl_lock);
 
@@ -71,10 +73,13 @@ void __init enumerate_split_lock(void)
 	wrmsr(MSR_TEST_CTL, l_orig, h);
 
 	/* Initialize split lock setting from previous BIOS setting. */
-	if (l_orig & MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK)
+	if (l_orig & MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK) {
+		split_lock_ac_bios = ENABLE_SPLIT_LOCK_AC;
 		split_lock_ac = ENABLE_SPLIT_LOCK_AC;
-	else
+	} else {
+		split_lock_ac_bios = DISABLE_SPLIT_LOCK_AC;
 		split_lock_ac = DISABLE_SPLIT_LOCK_AC;
+	}
 
 	pr_info("#AC exception for split locked accesses is supported\n");
 }
@@ -117,6 +122,44 @@ static bool _setup_split_lock(int split_lock_ac_val)
 	return false;
 }
 
+static bool restore_split_lock_ac(int split_lock_ac_val)
+{
+	if (!_setup_split_lock(split_lock_ac_val))
+		return false;
+
+	return true;
+}
+
+/* Restore BIOS setting for #AC exception for split lock. */
+bool restore_split_lock_ac_bios(int *enable)
+{
+	/* Don't restore the BIOS setting if kernel didn't change it. */
+	if (split_lock_ac == split_lock_ac_bios)
+		return false;
+
+	if (enable)
+		*enable = split_lock_ac_bios == ENABLE_SPLIT_LOCK_AC ? 1 : 0;
+
+	return restore_split_lock_ac(split_lock_ac_bios);
+}
+
+static void split_lock_cpu_reboot(void *unused)
+{
+	restore_split_lock_ac_bios(NULL);
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
 	if (!split_lock_ac_supported)
@@ -179,3 +222,12 @@ bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 
 	return true;
 }
+
+static int __init split_lock_init(void)
+{
+	register_reboot_notifier(&split_lock_reboot_nb);
+
+	return 0;
+}
+
+late_initcall(split_lock_init);
-- 
2.5.0
