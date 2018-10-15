Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8434C71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B4F2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B4F2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeJOTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:42:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51748 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJOTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:42:21 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 5406878f5dbf0e8d; Mon, 15 Oct 2018 13:57:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 1/2] cpuidle: menu: Drop redundant comparison
Date:   Mon, 15 Oct 2018 13:51:45 +0200
Message-ID: <2211415.LkLqNA7itZ@aspire.rjw.lan>
In-Reply-To: <9077862.OKK49htnqA@aspire.rjw.lan>
References: <9077862.OKK49htnqA@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since the correction factor cannot be greater than RESOLUTION * DECAY,
the result of the predicted_us computation in menu_select() cannot be
greater than data->next_timer_us, so it is not necessary to compare
the "typical interval" value coming from get_typical_interval() with
data->next_timer_us separately.

It is sufficient to copmare predicted_us with the return value of
get_typical_interval() directly, so do that and drop the now
redundant expected_interval variable.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -287,7 +287,6 @@ static int menu_select(struct cpuidle_dr
 	int i;
 	int idx;
 	unsigned int interactivity_req;
-	unsigned int expected_interval;
 	unsigned int predicted_us;
 	unsigned long nr_iowaiters, cpu_load;
 	ktime_t delta_next;
@@ -323,14 +322,10 @@ static int menu_select(struct cpuidle_dr
 	predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
 					 data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
-
-	expected_interval = get_typical_interval(data);
-	expected_interval = min(expected_interval, data->next_timer_us);
-
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
-	predicted_us = min(predicted_us, expected_interval);
+	predicted_us = min(predicted_us, get_typical_interval(data));
 
 	if (tick_nohz_tick_stopped()) {
 		/*

