Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE60C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F0B2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F0B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJJTlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:41:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57288 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:41:44 -0400
Received: from 79.184.255.62.ipv4.supernova.orange.pl (79.184.255.62) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id e65db51c9d47b533; Wed, 10 Oct 2018 14:19:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: menu: Simplify checks related to the polling state
Date:   Wed, 10 Oct 2018 14:16:38 +0200
Message-ID: <1902472.jET4SC7PGT@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After some recent menu governor changes, the promotion of the
"polling" state to a physical one is mostly controlled by the
latency limit (resulting from the "interactivity" factor) and
not by the time to the closest timer event, so it should be
sufficient to check the exit latency of that state for this
purpose (of course, its target residency still needs to be
within the next timer event range for energy-efficiency).

Also, the physical state the "polling" one is promoted to need not
be the next one in principle (in case the next state is disabled,
for example).

For these reasons, simplify the checks made to decide whether or
not to promote the "polling" state to a physical one and update
the target idle duration when it is promoted in case the residency
of the new state turns out to be above the tick boundary (in which
case there is no reason to stop the tick).

Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -371,12 +371,12 @@ static int menu_select(struct cpuidle_dr
 		if (s->target_residency > predicted_us) {
 			/*
 			 * Use a physical idle state, not busy polling, unless
-			 * a timer is going to trigger really really soon.
+			 * a timer is going to trigger soon enough.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    i == idx + 1 && latency_req > s->exit_latency &&
-			    data->next_timer_us > max_t(unsigned int, 20,
-							s->target_residency)) {
+			    s->exit_latency <= latency_req &&
+			    s->target_residency <= data->next_timer_us) {
+				predicted_us = s->target_residency;
 				idx = i;
 				break;
 			}

