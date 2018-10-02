Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738FC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F092720C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F092720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeJCEgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:36:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55625 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbeJCEgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:36:40 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 14404f7a6bc23072; Tue, 2 Oct 2018 23:51:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from menu_select()
Date:   Tue, 02 Oct 2018 23:44:06 +0200
Message-ID: <4130376.2FFt7p4687@aspire.rjw.lan>
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

Rearrange the code in menu_select() so that the loop over idle states
always starts from 0 and get rid of the first_idx variable.

While at it, add two empty lines to separate conditional statements
one another.

No intentional behavior changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -285,7 +285,6 @@ static int menu_select(struct cpuidle_dr
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int latency_req = cpuidle_governor_latency_req(dev->cpu);
 	int i;
-	int first_idx;
 	int idx;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
@@ -348,36 +347,33 @@ static int menu_select(struct cpuidle_dr
 			latency_req = interactivity_req;
 	}
 
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
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
 	idx = -1;
-	for (i = first_idx; i < drv->state_count; i++) {
+	for (i = 0; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable)
 			continue;
+
 		if (idx == -1)
 			idx = i; /* first enabled state */
+
 		if (s->target_residency > predicted_us) {
+			/*
+			 * Use a physical idle state, not busy polling, unless
+			 * a timer is going to trigger really really soon.
+			 */
+			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+			    i == idx + 1 && latency_req > s->exit_latency &&
+			    data->next_timer_us > max_t(unsigned int, 20,
+							s->target_residency)) {
+				idx = i;
+				break;
+			}
 			if (predicted_us < TICK_USEC)
 				break;
 

