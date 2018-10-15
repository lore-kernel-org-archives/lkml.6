Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A78C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2ED2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2ED2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOTmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:42:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47634 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:42:20 -0400
Received: from 79.184.253.168.ipv4.supernova.orange.pl (79.184.253.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id d46cfa9caa594898; Mon, 15 Oct 2018 13:57:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 2/2] cpuidle: menu: Avoid computations when result will be discarded
Date:   Mon, 15 Oct 2018 13:53:25 +0200
Message-ID: <3958974.INltPUcQCY@aspire.rjw.lan>
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

If the minimum interval taken into account in the average computation
loop in get_typical_interval() is less than the expected idle
duration determined so far, the resultant average cannot be greater
than that value as well and the entire return result of the function
is going to be discarded anyway going forward.

In that case, it is a waste of time to carry out the remaining
computations in get_typical_interval(), so avoid that by returning
early if the minimum interval is not below the expected idle duration.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -196,10 +196,11 @@ static void menu_update(struct cpuidle_d
  * of points is below a threshold. If it is... then use the
  * average of these 8 points as the estimated value.
  */
-static unsigned int get_typical_interval(struct menu_device *data)
+static unsigned int get_typical_interval(struct menu_device *data,
+					 unsigned int predicted_us)
 {
 	int i, divisor;
-	unsigned int max, thresh, avg;
+	unsigned int min, max, thresh, avg;
 	uint64_t sum, variance;
 
 	thresh = UINT_MAX; /* Discard outliers above this value */
@@ -207,6 +208,7 @@ static unsigned int get_typical_interval
 again:
 
 	/* First calculate the average of past intervals */
+	min = UINT_MAX;
 	max = 0;
 	sum = 0;
 	divisor = 0;
@@ -217,8 +219,19 @@ again:
 			divisor++;
 			if (value > max)
 				max = value;
+
+			if (value < min)
+				min = value;
 		}
 	}
+
+	/*
+	 * If the result of the computation is going to be discarded anyway,
+	 * avoid the computation altogether.
+	 */
+	if (min >= predicted_us)
+		return UINT_MAX;
+
 	if (divisor == INTERVALS)
 		avg = sum >> INTERVAL_SHIFT;
 	else
@@ -325,7 +338,7 @@ static int menu_select(struct cpuidle_dr
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
-	predicted_us = min(predicted_us, get_typical_interval(data));
+	predicted_us = min(predicted_us, get_typical_interval(data, predicted_us));
 
 	if (tick_nohz_tick_stopped()) {
 		/*

