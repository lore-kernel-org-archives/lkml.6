Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbeENSz3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:55:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:55033 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751954AbeENSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244624"
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
Subject: [PATCH 02/15] x86/split_lock: Set up #AC exception for split locked accesses
Date: Mon, 14 May 2018 11:52:12 -0700
Message-Id: <1526323945-211107-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bit 29 is set in Test Control MSR register 0x33, #AC exception
is generated for split locked accesses at all CPL.

By default, kernel inherits the bit setting from BIOS.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/cpu.h       |  2 ++
 arch/x86/kernel/cpu/common.c     |  2 ++
 arch/x86/kernel/cpu/split_lock.c | 54 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index c73b6d369047..b4fe6496bb15 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -42,7 +42,9 @@ unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
 #ifdef CONFIG_SPLIT_LOCK_AC
 int __init enumerate_split_lock(void);
+void setup_split_lock(void);
 #else /* CONFIG_SPLIT_LOCK_AC */
 static inline int enumerate_split_lock(void) { return 0; }
+static inline void setup_split_lock(void) {}
 #endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 7684e82e254f..daff18ef4f8f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1304,6 +1304,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
+	setup_split_lock();
+
 	select_idle_routine(c);
 
 #ifdef CONFIG_NUMA
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
index 2ab28419e080..98bbfb176cf4 100644
--- a/arch/x86/kernel/cpu/split_lock.c
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -15,6 +15,11 @@
 
 static bool split_lock_ac_supported;
 
+#define	DISABLE_SPLIT_LOCK_AC		0
+#define	ENABLE_SPLIT_LOCK_AC		1
+
+static int split_lock_ac = DISABLE_SPLIT_LOCK_AC;
+
 /*
  * On processors not supporting #AC exception for split lock feature,
  * MSR_TEST_CTL may not exist or MSR_TEST_CTL exists but the bit 29 is
@@ -58,5 +63,54 @@ void __init enumerate_split_lock(void)
 	 */
 	wrmsr(MSR_TEST_CTL, l_orig, h);
 
+	/* Initialize split lock setting from previous BIOS setting. */
+	if (l_orig & MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK)
+		split_lock_ac = ENABLE_SPLIT_LOCK_AC;
+	else
+		split_lock_ac = DISABLE_SPLIT_LOCK_AC;
+
 	pr_info("#AC exception for split locked accesses is supported\n");
 }
+
+static bool _setup_split_lock(int split_lock_ac_val)
+{
+	u32 l, h;
+
+	rdmsr(MSR_TEST_CTL, l, h);
+
+	/* No need to update MSR if same value. */
+	if ((l >> MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT & 0x1) ==
+	    split_lock_ac_val)
+		goto out;
+
+	if (split_lock_ac_val == ENABLE_SPLIT_LOCK_AC)
+		/* Set the split lock bit to enable the feature. */
+		l |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	else if (split_lock_ac_val == DISABLE_SPLIT_LOCK_AC)
+		/* Clear the split lock bit to disable the feature. */
+		l &= ~MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+	else
+		return false;
+
+	wrmsr(MSR_TEST_CTL, l, h);
+out:
+	return true;
+}
+
+void setup_split_lock(void)
+{
+	if (!split_lock_ac_supported)
+		return;
+
+	if (!_setup_split_lock(split_lock_ac))
+		goto out_fail;
+
+	pr_info_once("split lock #AC is %sd\n",
+		     split_lock_ac == ENABLE_SPLIT_LOCK_AC ? "enable"
+		     : "disable");
+
+	return;
+
+out_fail:
+	pr_warn("fail to set split lock #AC\n");
+}
-- 
2.5.0
