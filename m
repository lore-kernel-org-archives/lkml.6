Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeBIVNu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:13:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeBIVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:13:02 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com
Subject: [PATCH v10 6/7] x86/tsc: use tsc early
Date: Fri,  9 Feb 2018 16:11:42 -0500
Message-Id: <20180209211143.16215-7-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209211143.16215-1-pasha.tatashin@oracle.com>
References: <20180209211143.16215-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds early clock feature to x86 platforms.

tsc_early_init():
Determines offset, shift and multiplier for the early clock based on the
TSC frequency.

tsc_early_fini()
Implement the finish part of early tsc feature, prints message about the
offset, which can be useful to find out how much time was spent in post and
boot manager (if TSC starts from 0 during boot)

sched_clock_early():
TSC based implementation of early clock and is called from sched_clock().

start_early_clock():
Calls tsc_early_init(), and makes sched_clock() to use early boot clock

set_final_clock():
Sets the final clock which is either platform specific or
native_sched_clock(). Also calls tsc_early_fini() if early clock was
previously initialized.

Call start_early_clock() to start using early boot time stamps
functionality on the supported x86 platforms, and call set_final_clock() to
finish this feature and switch back to the default clock. The supported x86
systems are those where TSC frequency is determined early in boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/paravirt.h |  2 +-
 arch/x86/kernel/tsc.c           | 98 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 892df375b615..17b04919c71a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -171,7 +171,7 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
 
 static inline unsigned long long paravirt_sched_clock(void)
 {
-	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
+	return PVOP_CALL0(unsigned long long, pv_time_ops.active_sched_clock);
 }
 
 struct static_key;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 700a61cbafa5..d492f5dcea67 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -182,6 +182,84 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
 	local_irq_restore(flags);
 }
 
+static struct cyc2ns_data  cyc2ns_early;
+
+static u64 sched_clock_early(void)
+{
+	u64 ns = mul_u64_u32_shr(rdtsc(), cyc2ns_early.cyc2ns_mul,
+				 cyc2ns_early.cyc2ns_shift);
+	return ns + cyc2ns_early.cyc2ns_offset;
+}
+
+/*
+ * Initialize clock for early time stamps
+ */
+static void __init tsc_early_init(unsigned int khz)
+{
+	clocks_calc_mult_shift(&cyc2ns_early.cyc2ns_mul,
+			       &cyc2ns_early.cyc2ns_shift,
+			       khz, NSEC_PER_MSEC, 0);
+	cyc2ns_early.cyc2ns_offset = -sched_clock_early();
+}
+
+/*
+ * Finish clock for early time stamps, and hand over to permanent clock by
+ * setting __sched_clock_offset appropriately for continued time keeping.
+ */
+static void __init tsc_early_fini(void)
+{
+	unsigned long long t;
+	unsigned long r;
+
+	t = -cyc2ns_early.cyc2ns_offset;
+	r = do_div(t, NSEC_PER_SEC);
+
+	__sched_clock_offset = sched_clock_early() - sched_clock();
+	pr_info("early sched clock is finished, offset [%lld.%09lds]\n", t, r);
+}
+
+#ifdef CONFIG_PARAVIRT
+static inline void __init start_early_clock(void)
+{
+	tsc_early_init(tsc_khz);
+	pv_time_ops.active_sched_clock = sched_clock_early;
+}
+
+static inline void __init set_final_clock(void)
+{
+	pv_time_ops.active_sched_clock = pv_time_ops.sched_clock;
+
+	/* We did not have early sched clock if multiplier is 0 */
+	if (cyc2ns_early.cyc2ns_mul)
+		tsc_early_fini();
+}
+#else /* CONFIG_PARAVIRT */
+/*
+ * For native clock we use two switches static and dynamic, the static switch is
+ * initially true, so we check the dynamic switch, which is initially false.
+ * Later  when early clock is disabled, we can alter the static switch in order
+ * to avoid branch check on every sched_clock() call.
+ */
+static bool __tsc_early;
+static DEFINE_STATIC_KEY_TRUE(__tsc_early_static);
+
+static inline void __init start_early_clock(void)
+{
+	tsc_early_init(tsc_khz);
+	__tsc_early = true;
+}
+
+static inline void __init set_final_clock(void)
+{
+	__tsc_early = false;
+	static_branch_disable(&__tsc_early_static);
+
+	/* We did not have early sched clock if multiplier is 0 */
+	if (cyc2ns_early.cyc2ns_mul)
+		tsc_early_fini();
+}
+#endif /* CONFIG_PARAVIRT */
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -194,6 +272,13 @@ u64 native_sched_clock(void)
 		return cycles_2_ns(tsc_now);
 	}
 
+#ifndef CONFIG_PARAVIRT
+	if (static_branch_unlikely(&__tsc_early_static)) {
+		if (__tsc_early)
+			return sched_clock_early();
+	}
+#endif /* !CONFIG_PARAVIRT */
+
 	/*
 	 * Fall back to jiffies if there's no TSC available:
 	 * ( But note that we still use it if the TSC is marked
@@ -1313,6 +1398,7 @@ void __init tsc_early_delay_calibrate(void)
 	lpj = tsc_khz * 1000;
 	do_div(lpj, HZ);
 	loops_per_jiffy = lpj;
+	start_early_clock();
 }
 
 void __init tsc_init(void)
@@ -1322,7 +1408,7 @@ void __init tsc_init(void)
 
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
+		goto final_sched_clock;
 	}
 
 	cpu_khz = x86_platform.calibrate_cpu();
@@ -1341,7 +1427,7 @@ void __init tsc_init(void)
 	if (!tsc_khz) {
 		mark_tsc_unstable("could not calculate TSC khz");
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
-		return;
+		goto final_sched_clock;
 	}
 
 	pr_info("Detected %lu.%03lu MHz processor\n",
@@ -1389,6 +1475,14 @@ void __init tsc_init(void)
 
 	clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
 	detect_art();
+final_sched_clock:
+	/*
+	 * Final sched clock is either platform specific clock when
+	 * CONFIG_PARAVIRT is defined, or native_sched_clock() with disabled
+	 * static branch for early tsc clock. We must call this function even if
+	 * start_early_clock() was never called.
+	 */
+	set_final_clock();
 }
 
 #ifdef CONFIG_SMP
-- 
2.16.1
