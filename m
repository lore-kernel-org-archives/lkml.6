Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032897AbeE0Pqc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:46:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032786AbeE0PqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741082"
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
Subject: [RFC PATCH 07/16] x86/split_lock: Handle suspend/hibernate and resume
Date: Sun, 27 May 2018 08:45:56 -0700
Message-Id: <1527435965-202085-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend or hibernation, system enters firmware. To avoid potential
firmware issue that may generate #AC exception for split locked accesses,
handle the #AC as fatal exception, and block suspend or hibernation,
the setting of #AC for split lock is restored to firmware setting during
suspend or hibernation. When resuming from suspend or hibernation, the
split lock setting is restored to kernel setting.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/include/asm/cpu.h     |  2 ++
 arch/x86/kernel/cpu/test_ctl.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 45fec729c470..f2ca84deccc6 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -45,6 +45,7 @@ void detect_split_lock_ac(void);
 bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
 void setup_split_lock(void);
 void restore_split_lock_ac_firmware(void);
+void restore_split_lock_ac_kernel(void);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline void detect_split_lock_ac(void) {}
 static inline bool
@@ -55,5 +56,6 @@ do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 
 static inline void setup_split_lock(void) {}
 static inline void restore_split_lock_ac_firmware(void) {}
+static inline void restore_split_lock_ac_kernel(void) {}
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 9e47f8174a47..82440740b2b9 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -16,6 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/mm.h>
 #include <linux/reboot.h>
+#include <linux/syscore_ops.h>
 #include <asm/msr.h>
 
 #define DISABLE_SPLIT_LOCK_AC		0
@@ -112,6 +113,15 @@ void restore_split_lock_ac_firmware(void)
 	restore_split_lock_ac(split_lock_ac_firmware);
 }
 
+/* Restore kernel setting for #AC enable bit for split lock. */
+void restore_split_lock_ac_kernel(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_AC))
+		return;
+
+	restore_split_lock_ac(split_lock_ac_kernel);
+}
+
 static void split_lock_cpu_reboot(void *unused)
 {
 	restore_split_lock_ac_firmware();
@@ -247,11 +257,29 @@ static int split_lock_online(unsigned int cpu)
 
 static int split_lock_offline(unsigned int cpu)
 {
+	restore_split_lock_ac_firmware();
 	cancel_delayed_work(&per_cpu(reenable_delayed_work, cpu));
 
 	return 0;
 }
 
+static int split_lock_bsp_suspend(void)
+{
+	restore_split_lock_ac_firmware();
+
+	return 0;
+}
+
+static void split_lock_bsp_resume(void)
+{
+	restore_split_lock_ac_kernel();
+}
+
+static struct syscore_ops split_lock_syscore_ops = {
+	.suspend	= split_lock_bsp_suspend,
+	.resume		= split_lock_bsp_resume,
+};
+
 static int __init split_lock_init(void)
 {
 	int ret;
@@ -264,6 +292,8 @@ static int __init split_lock_init(void)
 	if (ret < 0)
 		return ret;
 
+	register_syscore_ops(&split_lock_syscore_ops);
+
 	register_reboot_notifier(&split_lock_reboot_nb);
 
 	return 0;
-- 
2.5.0
