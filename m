Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B62C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B5220827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B5220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeKFCbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:31:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbeKFCbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:31:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43E0CC058CA8;
        Mon,  5 Nov 2018 17:11:14 +0000 (UTC)
Received: from slurm.brq.redhat.com (dhcp-27-164.brq.redhat.com [10.34.27.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29C945DD72;
        Mon,  5 Nov 2018 17:11:06 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Daniel Vacek <neelx@redhat.com>
Subject: [PATCH v2] x86/tsc: make calibration refinement more robust
Date:   Mon,  5 Nov 2018 18:10:40 +0100
Message-Id: <1541437840-29293-1-git-send-email-neelx@redhat.com>
In-Reply-To: <1541085133-32534-1-git-send-email-neelx@redhat.com>
References: <1541085133-32534-1-git-send-email-neelx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 05 Nov 2018 17:11:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The threshold in tsc_read_refs() is constant which may favor slower CPUs
but may not be optimal for simple reading of reference on faster ones.
Hence make it proportional to tsc_khz when available to compensate for
this. The threshold guards against any disturbance like IRQs, NMIs, SMIs
or CPU stealing by host on guest systems so rename it accordingly and
fix comments as well.

Also on some systems there is noticeable DMI bus contention at some point
during boot keeping the readout failing (observed with about one in ~300
boots when testing). In that case retry also the second readout instead of
simply bailing out unrefined. Usually the next second the readout returns
fast just fine without any issues.

v2: keep using the constant early when the tsc_khz is not available yet
    as suggested by tglx

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 arch/x86/kernel/tsc.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

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
 
@@ -1268,7 +1269,7 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
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
-- 
2.19.1

