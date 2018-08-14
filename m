Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2FDC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FB9214DC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FB9214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbeHNNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:23:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59780 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeHNNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:23:27 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 34b0ae24b41ac507; Tue, 14 Aug 2018 12:36:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
Date:   Tue, 14 Aug 2018 12:34:40 +0200
Message-ID: <1572343.jWaXB8XNF1@aspire.rjw.lan>
In-Reply-To: <1582055.9b67urWYFa@aspire.rjw.lan>
References: <1951009.1jlQfyrxio@aspire.rjw.lan> <1754612.IcCR94pSYR@aspire.rjw.lan> <1582055.9b67urWYFa@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
with stopped tick) missed the case when the target residencies of
deep idle states of CPUs are above the tick boundary which may cause
the CPU to get stuck in a shallow idle state for a long time.

Say there are two CPU idle states available: one shallow, with the
target residency much below the tick boundary and one deep, with
the target residency significantly above the tick boundary.  In
that case, if the tick has been stopped already and the expected
next timer event is relatively far in the future, the governor will
assume the idle duration to be equal to TICK_USEC and it will select
the idle state for the CPU accordingly.  However, that will cause the
shallow state to be selected even though it would have been more
energy-efficient to select the deep one.

To address this issue, modify the governor to always use the time
till the closest timer event instead of the predicted idle duration
if the latter is less than the tick period length and the tick has
been stopped already.  Also make it extend the search for a matching
idle state if the tick is stopped to avoid settling on a shallow
state if deep states with target residencies above the tick period
length are available.

In addition, make it always indicate that the tick should be stopped
if it has been stopped already for consistency.

Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
-> v2: Initialize first_idx properly in the stopped tick case.
 
v2 -> v3: Compute data->bucket before checking whether or not the tick has been
          stopped already to prevent it from becoming stale.

v3 -> v4: Allow the usual state selection to be carried out if the tick has been
          stopped in case the predicted idle duration is greater than the tick
          period length and a matching state can be found without overriding
          the prediction result.

v4 -> v5: Rework code to be more straightforward.  Functionally, it should
          behave like the v4.
---
 drivers/cpuidle/governors/menu.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -349,14 +349,12 @@ static int menu_select(struct cpuidle_dr
 		 * If the tick is already stopped, the cost of possible short
 		 * idle duration misprediction is much higher, because the CPU
 		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and try
-		 * to force the CPU into a state for which we would have stopped
-		 * the tick, unless a timer is going to expire really soon
-		 * anyway.
+		 * result of it.  In that case say we might mispredict and use
+		 * the known time till the closest timer event for the idle
+		 * state selection.
 		 */
 		if (data->predicted_us < TICK_USEC)
-			data->predicted_us = min_t(unsigned int, TICK_USEC,
-						   ktime_to_us(delta_next));
+			data->predicted_us = ktime_to_us(delta_next);
 	} else {
 		/*
 		 * Use the performance multiplier and the user-configurable
@@ -381,8 +379,22 @@ static int menu_select(struct cpuidle_dr
 			continue;
 		if (idx == -1)
 			idx = i; /* first enabled state */
-		if (s->target_residency > data->predicted_us)
-			break;
+		if (s->target_residency > data->predicted_us) {
+			if (!tick_nohz_tick_stopped())
+				break;
+
+			/*
+			 * If the state selected so far is shallow and this
+			 * state's target residency matches the time till the
+			 * closest timer event, select this one to avoid getting
+			 * stuck in the shallow one for too long.
+			 */
+			if (drv->states[idx].target_residency < TICK_USEC &&
+			    s->target_residency <= ktime_to_us(delta_next))
+				idx = i;
+
+			goto out;
+		}
 		if (s->exit_latency > latency_req) {
 			/*
 			 * If we break out of the loop for latency reasons, use
@@ -403,14 +415,13 @@ static int menu_select(struct cpuidle_dr
 	 * Don't stop the tick if the selected state is a polling one or if the
 	 * expected idle duration is shorter than the tick period length.
 	 */
-	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC) {
+	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
+	     expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
 
-		if (!tick_nohz_tick_stopped() && idx > 0 &&
-		    drv->states[idx].target_residency > delta_next_us) {
+		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
 			/*
 			 * The tick is not going to be stopped and the target
 			 * residency of the state to be returned is not within
@@ -429,6 +440,7 @@ static int menu_select(struct cpuidle_dr
 		}
 	}
 
+out:
 	data->last_state_idx = idx;
 
 	return data->last_state_idx;

