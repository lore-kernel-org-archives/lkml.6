Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D98C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43862082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43862082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbeKBAQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728372AbeKBAQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:16:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A17C03086252;
        Thu,  1 Nov 2018 15:13:12 +0000 (UTC)
Received: from slurm.brq.redhat.com (dhcp-27-164.brq.redhat.com [10.34.27.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29D4E101E597;
        Thu,  1 Nov 2018 15:13:04 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Daniel Vacek <neelx@redhat.com>
Subject: [PATCH] tsc: make calibration refinement more robust
Date:   Thu,  1 Nov 2018 16:12:13 +0100
Message-Id: <1541085133-32534-1-git-send-email-neelx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 01 Nov 2018 15:13:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The threshold in tsc_read_refs() is constant which may favor slower CPUs
but may not be optimal for simple reading of reference on faster ones.
Hence make it proportional to tsc_khz to compensate for this. The threshold
guards against any disturbance like IRQs, NMIs, SMIs or CPU stealing by
host on guest systems so rename it accordingly and fix comments as well.

Also on some systems there is noticeable DMI bus contention at some point
during boot keeping the readout failing (observed with about one in ~300
boots when testing). In that case retry also the second readout instead of
simply bailing out unrefined. Usually the next second the readout returns
fast just fine without any issues.

Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 arch/x86/kernel/tsc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6d5dc5dabfd7..7812cd7bd45b 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -297,11 +297,11 @@ static int __init tsc_setup(char *str)
 
 __setup("tsc=", tsc_setup);
 
-#define MAX_RETRIES     5
-#define SMI_TRESHOLD    50000
+#define MAX_RETRIES	5
+#define TSC_THRESHOLD	(tsc_khz >> 5)
 
 /*
- * Read TSC and the reference counters. Take care of SMI disturbance
+ * Read TSC and the reference counters. Take care of any disturbances
  */
 static u64 tsc_read_refs(u64 *p, int hpet)
 {
@@ -315,7 +315,7 @@ static u64 tsc_read_refs(u64 *p, int hpet)
 		else
 			*p = acpi_pm_read_early();
 		t2 = get_cycles();
-		if ((t2 - t1) < SMI_TRESHOLD)
+		if ((t2 - t1) < TSC_THRESHOLD)
 			return t2;
 	}
 	return ULLONG_MAX;
@@ -1268,7 +1268,7 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
  */
 static void tsc_refine_calibration_work(struct work_struct *work)
 {
-	static u64 tsc_start = -1, ref_start;
+	static u64 tsc_start = ULLONG_MAX, ref_start;
 	static int hpet;
 	u64 tsc_stop, ref_stop, delta;
 	unsigned long freq;
@@ -1283,14 +1283,15 @@ static void tsc_refine_calibration_work(struct work_struct *work)
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
 
@@ -1300,9 +1301,9 @@ static void tsc_refine_calibration_work(struct work_struct *work)
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

