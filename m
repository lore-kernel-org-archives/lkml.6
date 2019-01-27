Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CFCC282C9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8C82184E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfA0LFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:05:20 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40062 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfA0LFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:05:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gniFP-0001sE-Lm; Sun, 27 Jan 2019 12:05:07 +0100
Subject: [GIT pull] x86/timer updates for 5.0
From:   Thomas Gleixner <tglx@linutronix.de>
Message-ID: <154858670614.17124.11558077810916024944.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <154858670614.17124.729797537033859836.tglx@nanos.tec.linutronix.de>
Date:   Sun, 27 Jan 2019 12:05:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-timers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

Two commits which were missed to be sent during the merge window.

 - The TSC calibration fix turns out to be more urgent as recent Skylake-X
   systems seem to have massive trouble with calibration disturbance. This
   should go back into stable for that reason and it the risk of breakage
   is rather low.

 - Drop an unused define

Thanks,

	tglx

------------------>
Daniel Vacek (1):
      x86/tsc: Make calibration refinement more robust

Roland Dreier (1):
      x86/hpet: Remove unused FSEC_PER_NSEC define


 arch/x86/kernel/hpet.c |  4 ----
 arch/x86/kernel/tsc.c  | 30 ++++++++++++++++--------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index b0acb22e5a46..dfd3aca82c61 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -21,10 +21,6 @@
 
 #define HPET_MASK			CLOCKSOURCE_MASK(32)
 
-/* FSEC = 10^-15
-   NSEC = 10^-9 */
-#define FSEC_PER_NSEC			1000000L
-
 #define HPET_DEV_USED_BIT		2
 #define HPET_DEV_USED			(1 << HPET_DEV_USED_BIT)
 #define HPET_DEV_VALID			0x8
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index e9f777bfed40..3fae23834069 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -297,15 +297,16 @@ static int __init tsc_setup(char *str)
 
 __setup("tsc=", tsc_setup);
 
-#define MAX_RETRIES     5
-#define SMI_TRESHOLD    50000
+#define MAX_RETRIES		5
+#define TSC_DEFAULT_THRESHOLD	0x20000
 
 /*
- * Read TSC and the reference counters. Take care of SMI disturbance
+ * Read TSC and the reference counters. Take care of any disturbances
  */
 static u64 tsc_read_refs(u64 *p, int hpet)
 {
 	u64 t1, t2;
+	u64 thresh = tsc_khz ? tsc_khz >> 5 : TSC_DEFAULT_THRESHOLD;
 	int i;
 
 	for (i = 0; i < MAX_RETRIES; i++) {
@@ -315,7 +316,7 @@ static u64 tsc_read_refs(u64 *p, int hpet)
 		else
 			*p = acpi_pm_read_early();
 		t2 = get_cycles();
-		if ((t2 - t1) < SMI_TRESHOLD)
+		if ((t2 - t1) < thresh)
 			return t2;
 	}
 	return ULLONG_MAX;
@@ -703,15 +704,15 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 	 * zero. In each wait loop iteration we read the TSC and check
 	 * the delta to the previous read. We keep track of the min
 	 * and max values of that delta. The delta is mostly defined
-	 * by the IO time of the PIT access, so we can detect when a
-	 * SMI/SMM disturbance happened between the two reads. If the
+	 * by the IO time of the PIT access, so we can detect when
+	 * any disturbance happened between the two reads. If the
 	 * maximum time is significantly larger than the minimum time,
 	 * then we discard the result and have another try.
 	 *
 	 * 2) Reference counter. If available we use the HPET or the
 	 * PMTIMER as a reference to check the sanity of that value.
 	 * We use separate TSC readouts and check inside of the
-	 * reference read for a SMI/SMM disturbance. We dicard
+	 * reference read for any possible disturbance. We dicard
 	 * disturbed values here as well. We do that around the PIT
 	 * calibration delay loop as we have to wait for a certain
 	 * amount of time anyway.
@@ -744,7 +745,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 		if (ref1 == ref2)
 			continue;
 
-		/* Check, whether the sampling was disturbed by an SMI */
+		/* Check, whether the sampling was disturbed */
 		if (tsc1 == ULLONG_MAX || tsc2 == ULLONG_MAX)
 			continue;
 
@@ -1268,7 +1269,7 @@ static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
  */
 static void tsc_refine_calibration_work(struct work_struct *work)
 {
-	static u64 tsc_start = -1, ref_start;
+	static u64 tsc_start = ULLONG_MAX, ref_start;
 	static int hpet;
 	u64 tsc_stop, ref_stop, delta;
 	unsigned long freq;
@@ -1283,14 +1284,15 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	 * delayed the first time we expire. So set the workqueue
 	 * again once we know timers are working.
 	 */
-	if (tsc_start == -1) {
+	if (tsc_start == ULLONG_MAX) {
+restart:
 		/*
 		 * Only set hpet once, to avoid mixing hardware
 		 * if the hpet becomes enabled later.
 		 */
 		hpet = is_hpet_enabled();
-		schedule_delayed_work(&tsc_irqwork, HZ);
 		tsc_start = tsc_read_refs(&ref_start, hpet);
+		schedule_delayed_work(&tsc_irqwork, HZ);
 		return;
 	}
 
@@ -1300,9 +1302,9 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (ref_start == ref_stop)
 		goto out;
 
-	/* Check, whether the sampling was disturbed by an SMI */
-	if (tsc_start == ULLONG_MAX || tsc_stop == ULLONG_MAX)
-		goto out;
+	/* Check, whether the sampling was disturbed */
+	if (tsc_stop == ULLONG_MAX)
+		goto restart;
 
 	delta = tsc_stop - tsc_start;
 	delta *= 1000000LL;

