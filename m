Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeENSyR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:54:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:55031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752044AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244641"
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
Subject: [PATCH 07/15] x86/split_lock: Handle suspend/hibernate and resume
Date: Mon, 14 May 2018 11:52:17 -0700
Message-Id: <1526323945-211107-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend or hibernation, system enters BIOS. To avoid potential
BIOS issue that may generate #AC exception for split locked accesses,
handle the #AC as fatal exception, and block suspend or hibernation,
the split lock setting is restored to BIOS setting. When resuming
from suspend or hibernation, the split lock setting is restored to
kernel setting.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h       |  2 ++
 arch/x86/kernel/cpu/split_lock.c | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 0b00033b6fa8..89d62d7051fa 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -45,11 +45,13 @@ int __init enumerate_split_lock(void);
 void setup_split_lock(void);
 bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
 bool restore_split_lock_ac_bios(int *enable);
+bool restore_split_lock_ac_kernel(int *enable);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline int enumerate_split_lock(void) { return 0; }
 static inline void setup_split_lock(void) {}
 static inline bool
 do_split_lock_exception(struct pt_regs *regs, unsigned long error_code) {}
 static inline bool restore_split_lock_ac_bios(int *enable) { return true; }
+static inline bool restore_split_lock_ac_kernel(int *enable) { return true; }
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index d2735259800b..5187a9c6cea6 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/cpu.h>
 #include <linux/reboot.h>
+#include <linux/syscore_ops.h>
 #include <asm/msr.h>
 
 static bool split_lock_ac_supported;
@@ -143,6 +144,15 @@ bool restore_split_lock_ac_bios(int *enable)
 	return restore_split_lock_ac(split_lock_ac_bios);
 }
 
+/* Restore kernel setting for #AC enable bit for split lock. */
+bool restore_split_lock_ac_kernel(int *enable)
+{
+	if (enable)
+		*enable = split_lock_ac == ENABLE_SPLIT_LOCK_AC ?  1 : 0;
+
+	return restore_split_lock_ac(split_lock_ac);
+}
+
 static void split_lock_cpu_reboot(void *unused)
 {
 	restore_split_lock_ac_bios(NULL);
@@ -223,11 +233,55 @@ bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 	return true;
 }
 
+static int split_lock_offline(unsigned int cpu)
+{
+	int enable;
+
+	if (restore_split_lock_ac_bios(&enable))
+		pr_info("%s split lock on CPU%d\n",
+			enable ? "enable" : "disable", smp_processor_id());
+
+	return 0;
+}
+
+static int split_lock_bsp_suspend(void)
+{
+	restore_split_lock_ac_bios(NULL);
+
+	return 0;
+}
+
+static void split_lock_bsp_resume(void)
+{
+	restore_split_lock_ac_kernel(NULL);
+}
+
+static struct syscore_ops split_lock_syscore_ops = {
+	.suspend	= split_lock_bsp_suspend,
+	.resume		= split_lock_bsp_resume,
+};
+
 static int __init split_lock_init(void)
 {
+	int ret;
+
+	if (!split_lock_ac_supported)
+		return -ENODEV;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"x86/split_lock:online:",
+				NULL, split_lock_offline);
+	if (ret < 0)
+		goto out_fail;
+
+	register_syscore_ops(&split_lock_syscore_ops);
+
 	register_reboot_notifier(&split_lock_reboot_nb);
 
 	return 0;
+
+out_fail:
+	return ret;
 }
 
 late_initcall(split_lock_init);
-- 
2.5.0
