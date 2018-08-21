Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE9BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E4A21581
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E4A21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeHUMFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:05:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50947 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHUMFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:05:44 -0400
Received: from 79.184.253.33.ipv4.supernova.orange.pl (79.184.253.33) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 25013b0cdf134190; Tue, 21 Aug 2018 10:46:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Date:   Tue, 21 Aug 2018 10:44:10 +0200
Message-ID: <34910476.pgRhNDWo5t@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The case addressed by commit 5ef499cd571c (cpuidle: menu: Handle
stopped tick more aggressively) in the stopped tick case is present
when the tick has not been stopped yet too.  Namely, if only two CPU
idle states, shallow state A with target residency significantly
below the tick boundary and deep state B with target residency
significantly above it, are available and the predicted idle
duration is above the tick boundary, but below the target residency
of state B, state A will be selected and the CPU may spend indefinite
amount of time in it, which is not quite energy-efficient.

However, if the tick has not been stopped yet and the governor is
about to select a shallow idle state for the CPU even though the idle
duration predicted by it is above the tick boundary, it should be
fine to wake up the CPU early, so the tick can be retained then and
the governor will have a chance to select a deeper state when it runs
next time.

[Note that when this really happens, it will make the idle duration
 predictor believe that the CPU might be idle longer than predicted,
 which will make it more likely to predict longer idle durations going
 forward, but that will also cause deeper idle states to be selected
 going forward, on average, which is what's needed here.]

Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit 5ef499cd571c (cpuidle: menu: Handle stopped tick more aggressively) is
in linux-next only at this point.

---
 drivers/cpuidle/governors/menu.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -379,9 +379,20 @@ static int menu_select(struct cpuidle_dr
 		if (idx == -1)
 			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us) {
-			if (!tick_nohz_tick_stopped())
+			if (data->predicted_us < TICK_USEC)
 				break;
 
+			if (!tick_nohz_tick_stopped()) {
+				/*
+				 * If the state selected so far is shallow,
+				 * waking up early won't hurt, so retain the
+				 * tick in that case and let the governor run
+				 * again in the next iteration of the loop.
+				 */
+				expected_interval = drv->states[idx].target_residency;
+				break;
+			}
+
 			/*
 			 * If the state selected so far is shallow and this
 			 * state's target residency matches the time till the

