Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC2C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8666206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8666206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeJCEgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:36:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62429 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJCEgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:36:39 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 337d95c3ba8ca9ae; Tue, 2 Oct 2018 23:51:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6/6] cpuidle: menu: Move the latency_req == 0 special case check
Date:   Tue, 02 Oct 2018 23:47:43 +0200
Message-ID: <9002841.GWJsep0FYb@aspire.rjw.lan>
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

It is better to always update data->bucket before returning from
menu_select() so as to prevent disturbing the wakeup statistics
collected by the governor, so combine the latency_req == 0 special
check with the more general check below.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -297,19 +297,13 @@ static int menu_select(struct cpuidle_dr
 		data->needs_update = 0;
 	}
 
-	/* Special case when user has set very strict latency requirement */
-	if (unlikely(latency_req == 0)) {
-		*stop_tick = false;
-		return 0;
-	}
-
 	/* determine the expected residency time, round up */
 	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
 
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
 
-	if (unlikely(drv->state_count <= 1) ||
+	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
 	    ((data->next_timer_us < drv->states[1].target_residency ||
 	      latency_req < drv->states[1].exit_latency) &&
 	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {

