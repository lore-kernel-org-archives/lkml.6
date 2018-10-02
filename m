Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE3BC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0AF2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0AF2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeJCEi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:38:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53069 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJCEi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:38:59 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id ddcee91b4fd972b8; Tue, 2 Oct 2018 23:53:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: poll_state: Revise loop termination condition
Date:   Tue, 02 Oct 2018 23:50:30 +0200
Message-ID: <3981163.1RDrRiq2Iz@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If need_resched() returns "false", breaking out of the loop in
poll_idle() will cause a new idle state to be selected, so in fact
usually it doesn't make sense to spin in it longer than the target
residency of the second state.  [Note that the "polling" state is
used only if there is at least one "real" state defined in addition
to it.]  On the other hand, breaking out of it early (say in case
the next state is disabled) shouldn't hurt as it is polling anyway.

For this reason, make the loop in poll_idle() break if the CPU has
been spinning longer than the target residency of the second state
(the "polling" state can only be state[0]).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/poll_state.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -9,7 +9,6 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 
-#define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
 #define POLL_IDLE_RELAX_COUNT	200
 
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
@@ -21,6 +20,7 @@ static int __cpuidle poll_idle(struct cp
 
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
+		u64 limit = (u64)drv->states[1].target_residency * NSEC_PER_USEC;
 		unsigned int loop_count = 0;
 
 		while (!need_resched()) {
@@ -29,7 +29,7 @@ static int __cpuidle poll_idle(struct cp
 				continue;
 
 			loop_count = 0;
-			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT) {
+			if (local_clock() - time_start > limit) {
 				dev->poll_time_limit = true;
 				break;
 			}

