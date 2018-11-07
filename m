Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46804C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003122085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QCnqJgkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003122085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeKGTQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:16:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+HzIgUkaRqTrFGzIf1Wq2oWnE2vpTQOAcycmpwADPzw=; b=QCnqJgkxGN+eOrSZy7jX0vlYZ
        Vr086iaPSo2+PDCZ4c374jdO9PTb0gqYJZsENwCTK+NQQad7Vb0yplBOv+DVJgbSoWqXjFGjAzh2L
        9GeZhey+jwnCTLeKRjIDMpa2vvb7v9NogfTG0QCg4cmsJsCVkLJ02l8r5Jw48JJyERjd+ySCmkKKN
        KrrRX0ObEe+LlCCjc16Mc0f4j42z9wCwfFLGLOSQKnbCF/y/JNwHlYx+SQ5fSimjugydD3QVFeKA2
        4TNcigSJQv9KMQKnjzL8awco6gbF3wUnWh0Mtnzkao+3xBLiTVF5mCsCNkRe0afylNeM4QrE6xNlh
        ylC5B8tTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKKPr-0002YF-6U; Wed, 07 Nov 2018 09:46:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8605520284C61; Wed,  7 Nov 2018 10:46:24 +0100 (CET)
Date:   Wed, 7 Nov 2018 10:46:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] irq/timings: Fix model validity
Message-ID: <20181107094624.GB9828@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107085936.GI9781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 09:59:36AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:

> > In general, however, I need to be convinced that interrupts that
> > didn't wake up the CPU from idle are relevant for next wakeup
> > prediction.  I see that this may be the case, but to what extent is
> > rather unclear to me and it looks like calling
> > irq_timings_next_event() would add considerable overhead.
> 
> How about we add a (debug) knob so that people can play with it for now?
> If it turns out to be useful, we'll learn.

That said; Daniel, I think there is a problem with how irqs_update()
sets irqs->valid. We seem to set valid even when we're still training.

---
Subject: irq/timings: Fix model validity

The per IRQ timing predictor will produce a 'valid' prediction even if
the model is still training. This should not happen.

Fix this by moving the actual training (online stddev algorithm) up a
bit and returning early (before predicting) when we've not yet reached
the sample threshold.

A direct concequence is that the predictor will only ever run with at
least that many samples, which means we can remove one branch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/irq/timings.c | 66 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 1e4cb63a5c82..5d22fd5facd5 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -28,6 +28,13 @@ struct irqt_stat {
 	int	valid;
 };
 
+/*
+ * The rule of thumb in statistics for the normal distribution
+ * is having at least 30 samples in order to have the model to
+ * apply.
+ */
+#define SAMPLE_THRESHOLD	30
+
 static DEFINE_IDR(irqt_stats);
 
 void irq_timings_enable(void)
@@ -101,7 +108,6 @@ void irq_timings_disable(void)
  * distribution appears when the number of samples is 30 (it is the
  * rule of thumb in statistics, cf. "30 samples" on Internet). When
  * there are three consecutive anomalies, the statistics are resetted.
- *
  */
 static void irqs_update(struct irqt_stat *irqs, u64 ts)
 {
@@ -146,11 +152,38 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
 	 */
 	diff = interval - irqs->avg;
 
+	/*
+	 * Online average algorithm:
+	 *
+	 *  new_average = average + ((value - average) / count)
+	 *
+	 * The variance computation depends on the new average
+	 * to be computed here first.
+	 *
+	 */
+	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
+
+	/*
+	 * Online variance algorithm:
+	 *
+	 *  new_variance = variance + (value - average) x (value - new_average)
+	 *
+	 * Warning: irqs->avg is updated with the line above, hence
+	 * 'interval - irqs->avg' is no longer equal to 'diff'
+	 */
+	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
+
 	/*
 	 * Increment the number of samples.
 	 */
 	irqs->nr_samples++;
 
+	/*
+	 * If we're still training the model, we can't make any predictions yet.
+	 */
+	if (irqs->nr_samples < SAMPLE_THRESHOLD)
+		return;
+
 	/*
 	 * Online variance divided by the number of elements if there
 	 * is more than one sample.  Normally the formula is division
@@ -158,16 +191,12 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
 	 * more than 32 and dividing by 32 instead of 31 is enough
 	 * precise.
 	 */
-	if (likely(irqs->nr_samples > 1))
-		variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
+	variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
 
 	/*
-	 * The rule of thumb in statistics for the normal distribution
-	 * is having at least 30 samples in order to have the model to
-	 * apply. Values outside the interval are considered as an
-	 * anomaly.
+	 * Values outside the interval are considered as an anomaly.
 	 */
-	if ((irqs->nr_samples >= 30) && ((diff * diff) > (9 * variance))) {
+	if ((diff * diff) > (9 * variance)) {
 		/*
 		 * After three consecutive anomalies, we reset the
 		 * stats as it is no longer stable enough.
@@ -191,27 +220,6 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
 	 */
 	irqs->valid = 1;
 
-	/*
-	 * Online average algorithm:
-	 *
-	 *  new_average = average + ((value - average) / count)
-	 *
-	 * The variance computation depends on the new average
-	 * to be computed here first.
-	 *
-	 */
-	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
-
-	/*
-	 * Online variance algorithm:
-	 *
-	 *  new_variance = variance + (value - average) x (value - new_average)
-	 *
-	 * Warning: irqs->avg is updated with the line above, hence
-	 * 'interval - irqs->avg' is no longer equal to 'diff'
-	 */
-	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
-
 	/*
 	 * Update the next event
 	 */
