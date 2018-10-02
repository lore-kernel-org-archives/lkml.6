Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C5BC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E211206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E211206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeJCEgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:36:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61741 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbeJCEgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:36:41 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 05e43e960ec524cb; Tue, 2 Oct 2018 23:51:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/6] cpuidle: menu: Compute first_idx when latency_req is known
Date:   Tue, 02 Oct 2018 23:42:56 +0200
Message-ID: <2172591.2D0LTaJpaX@aspire.rjw.lan>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since menu_select() can only set first_idx to 1 if the exit latency
of the second state is not greater than the latency limit, it should
first determine that limit.  Thus first_idx should be computed after
the "interactivity" factor has been taken into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -322,22 +322,6 @@ static int menu_select(struct cpuidle_dr
 	expected_interval = get_typical_interval(data);
 	expected_interval = min(expected_interval, data->next_timer_us);
 
-	first_idx = 0;
-	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
-		struct cpuidle_state *s = &drv->states[1];
-		unsigned int polling_threshold;
-
-		/*
-		 * Default to a physical idle state, not to busy polling, unless
-		 * a timer is going to trigger really really soon.
-		 */
-		polling_threshold = max_t(unsigned int, 20, s->target_residency);
-		if (data->next_timer_us > polling_threshold &&
-		    latency_req > s->exit_latency && !s->disabled &&
-		    !dev->states_usage[1].disable)
-			first_idx = 1;
-	}
-
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
@@ -364,6 +348,22 @@ static int menu_select(struct cpuidle_dr
 			latency_req = interactivity_req;
 	}
 
+	first_idx = 0;
+	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
+		struct cpuidle_state *s = &drv->states[1];
+		unsigned int polling_threshold;
+
+		/*
+		 * Default to a physical idle state, not to busy polling, unless
+		 * a timer is going to trigger really really soon.
+		 */
+		polling_threshold = max_t(unsigned int, 20, s->target_residency);
+		if (data->next_timer_us > polling_threshold &&
+		    latency_req > s->exit_latency && !s->disabled &&
+		    !dev->states_usage[1].disable)
+			first_idx = 1;
+	}
+
 	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.

