Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbeDBKMz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:12:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36058 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbeDBKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:12:53 -0400
X-Google-Smtp-Source: AIpwx4+n6sf9l1T62xNfbe8BOR/ih6WF1jp/WXpYIDnNErSggzXJLuBKVs3sSRujQzTc1o8VMvbiHw==
Date: Mon, 2 Apr 2018 12:12:50 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/timers changes for v4.17
Message-ID: <20180402101250.2sci73cz3bvgev6v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-timers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

   # HEAD: ea89c065482179b2bf9f9b6788b06a6e0c68a73b x86/tsc: Get rid of rdtscll()

Two changes: add the new convert_art_ns_to_tsc() API for upcoming Intel Goldmont+ 
drivers, and remove the obsolete rdtscll() API.


 Thanks,

	Ingo

------------------>
Rajvi Jingar (1):
      x86/tsc: Convert ART in nanoseconds to TSC

Thomas Gleixner (1):
      x86/tsc: Get rid of rdtscll()


 arch/x86/events/msr.c                   |  3 ++-
 arch/x86/include/asm/msr.h              |  3 ---
 arch/x86/include/asm/tsc.h              |  1 +
 arch/x86/kernel/cpu/mcheck/mce-inject.c |  2 +-
 arch/x86/kernel/tsc.c                   | 39 +++++++++++++++++++++++++++++++++
 5 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 18e2628e2d8f..e7edf19e64c2 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -188,10 +188,11 @@ static inline u64 msr_read_counter(struct perf_event *event)
 	if (event->hw.event_base)
 		rdmsrl(event->hw.event_base, now);
 	else
-		rdtscll(now);
+		now = rdtsc_ordered();
 
 	return now;
 }
+
 static void msr_event_update(struct perf_event *event)
 {
 	u64 prev, now;
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 30df295f6d94..392f05d57e78 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -218,9 +218,6 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	return rdtsc();
 }
 
-/* Deprecated, keep it for a cycle for easier merging: */
-#define rdtscll(now)	do { (now) = rdtsc_ordered(); } while (0)
-
 static inline unsigned long long native_read_pmc(int counter)
 {
 	DECLARE_ARGS(val, low, high);
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index cf5d53c3f9ea..2701d221583a 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -31,6 +31,7 @@ static inline cycles_t get_cycles(void)
 }
 
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
+extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
 extern void tsc_early_delay_calibrate(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index 231ad23b24a9..475cb4f5f14f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -491,7 +491,7 @@ static void do_inject(void)
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
 
-	rdtscll(i_mce.tsc);
+	i_mce.tsc = rdtsc_ordered();
 
 	if (i_mce.misc)
 		i_mce.status |= MCI_STATUS_MISCV;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fb4302738410..ef32297ff17e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1179,6 +1179,45 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
 
+/**
+ * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
+ * @art_ns: ART (Always Running Timer) in unit of nanoseconds
+ *
+ * PTM requires all timestamps to be in units of nanoseconds. When user
+ * software requests a cross-timestamp, this function converts system timestamp
+ * to TSC.
+ *
+ * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
+ * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
+ * that this flag is set before conversion to TSC is attempted.
+ *
+ * Return:
+ * struct system_counterval_t - system counter value with the pointer to the
+ *	corresponding clocksource
+ *	@cycles:	System counter value
+ *	@cs:		Clocksource corresponding to system counter value. Used
+ *			by timekeeping code to verify comparibility of two cycle
+ *			values.
+ */
+
+struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
+{
+	u64 tmp, res, rem;
+
+	rem = do_div(art_ns, USEC_PER_SEC);
+
+	res = art_ns * tsc_khz;
+	tmp = rem * tsc_khz;
+
+	do_div(tmp, USEC_PER_SEC);
+	res += tmp;
+
+	return (struct system_counterval_t) { .cs = art_related_clocksource,
+					      .cycles = res};
+}
+EXPORT_SYMBOL(convert_art_ns_to_tsc);
+
+
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
