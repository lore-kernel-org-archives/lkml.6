Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB3DC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727F6206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727F6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeJCEgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:36:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46108 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeJCEgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:36:39 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 0257201a98df0369; Tue, 2 Oct 2018 23:51:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 5/6] cpuidle: menu: Avoid computations for very close timers
Date:   Tue, 02 Oct 2018 23:46:28 +0200
Message-ID: <2753018.aK9edJ7Dvu@aspire.rjw.lan>
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

If the next timer event (with the tick excluded) is closer than the
target residency of the second state or the PM QoS latency constraint
is below its exit latency, state[0] will be used regardless of any
other factors, so skip the computations in menu_select() then and
return 0 straight away from it.

Still, do that after the bucket has been determined to avoid
disturbing the wakeup statistics in general.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -309,6 +309,18 @@ static int menu_select(struct cpuidle_dr
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
 
+	if (unlikely(drv->state_count <= 1) ||
+	    ((data->next_timer_us < drv->states[1].target_residency ||
+	      latency_req < drv->states[1].exit_latency) &&
+	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
+		/*
+		 * In this case state[0] will be used no matter what, so return
+		 * it right away and keep the tick running.
+		 */
+		*stop_tick = false;
+		return 0;
+	}
+
 	/*
 	 * Force the result of multiplication to be 64 bits even if both
 	 * operands are 32 bits.

