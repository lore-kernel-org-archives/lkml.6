Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032861AbeE0PqZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:46:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032721AbeE0PqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741069"
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
Subject: [RFC PATCH 03/16] x86/split_lock: Set up #AC exception for split locked accesses on all CPUs
Date: Sun, 27 May 2018 08:45:52 -0700
Message-Id: <1527435965-202085-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#AC for split lock is set up when each CPU is brought up. By default,
kernel disables the feature bit 29 in TEST_CTL MSR on each CPU.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h     |  3 +++
 arch/x86/kernel/cpu/common.c   |  2 ++
 arch/x86/kernel/cpu/test_ctl.c | 14 ++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 083ef6d05c45..00f453fd44ac 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -43,6 +43,7 @@ unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_SPLIT_LOCK_AC
 void detect_split_lock_ac(void);
 bool do_split_lock_exception(struct pt_regs *regs, unsigned long error_code);
+void setup_split_lock(void);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline void detect_split_lock_ac(void) {}
 static inline bool
@@ -50,5 +51,7 @@ do_split_lock_exception(struct pt_regs *regs, unsigned long error_code)
 {
 	return false;
 }
+
+static inline void setup_split_lock(void) {}
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b02d90320ec6..af3f23170503 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1382,6 +1382,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
+	setup_split_lock();
+
 	select_idle_routine(c);
 
 #ifdef CONFIG_NUMA
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
index 82f110759662..c72c0517c6ab 100644
--- a/arch/x86/kernel/cpu/test_ctl.c
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -28,6 +28,8 @@ static DEFINE_PER_CPU(struct delayed_work, reenable_delayed_work);
 static unsigned long disable_split_lock_jiffies;
 static DEFINE_MUTEX(reexecute_split_lock_mutex);
 
+static int split_lock_ac_kernel = DISABLE_SPLIT_LOCK_AC;
+
 /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
 void detect_split_lock_ac(void)
 {
@@ -84,6 +86,18 @@ static void _setup_split_lock(int split_lock_ac_val)
 	wrmsrl(MSR_TEST_CTL, val);
 }
 
+void setup_split_lock(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SPLIT_LOCK_AC))
+		return;
+
+	_setup_split_lock(split_lock_ac_kernel);
+
+	pr_info_once("#AC execption for split lock is %sd\n",
+		     split_lock_ac_kernel == ENABLE_SPLIT_LOCK_AC ? "enable"
+		     : "disable");
+}
+
 static void wait_for_reexecution(void)
 {
 	while (time_before(jiffies, disable_split_lock_jiffies +
-- 
2.5.0
