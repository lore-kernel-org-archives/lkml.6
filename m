Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F1C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1871B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfAWIOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:14:16 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.91]:15366 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbfAWIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:14:16 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id ADAF5400CEF48
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:14:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mDfrgxbHFYTGMmDfrggAds; Wed, 23 Jan 2019 02:14:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=47798 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmDfp-003gWW-R1; Wed, 23 Jan 2019 02:14:15 -0600
Date:   Wed, 23 Jan 2019 02:14:13 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] time: Mark expected switch fall-throughs
Message-ID: <20190123081413.GA3949@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmDfp-003gWW-R1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:47798
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

kernel/time/hrtimer.c: In function ‘hrtimer_fixup_activate’:
./include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
 # define unlikely(x) __builtin_expect(!!(x), 0)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:125:2: note: in expansion of macro ‘unlikely’
  unlikely(__ret_warn_on);     \
  ^~~~~~~~
kernel/time/hrtimer.c:366:3: note: in expansion of macro ‘WARN_ON’
   WARN_ON(1);
   ^~~~~~~
kernel/time/hrtimer.c:368:2: note: here
  default:
  ^~~~~~~

kernel/time/timer.c: In function ‘timer_fixup_activate’:
./include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
 # define unlikely(x) __builtin_expect(!!(x), 0)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:125:2: note: in expansion of macro ‘unlikely’
  unlikely(__ret_warn_on);     \
  ^~~~~~~~
kernel/time/timer.c:649:3: note: in expansion of macro ‘WARN_ON’
   WARN_ON(1);
   ^~~~~~~
kernel/time/timer.c:651:2: note: here
  default:
  ^~~~~~~

kernel/time/tick-broadcast.c: In function ‘tick_broadcast_control’:
kernel/time/tick-broadcast.c:377:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
   tick_broadcast_forced = 1;
   ~~~~~~~~~~~~~~~~~~~~~~^~~
kernel/time/tick-broadcast.c:378:2: note: here
  case TICK_BROADCAST_ON:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/time/hrtimer.c        | 1 +
 kernel/time/tick-broadcast.c | 1 +
 kernel/time/timer.c          | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0f5f96075110..5fc8c8add815 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -364,6 +364,7 @@ static bool hrtimer_fixup_activate(void *addr, enum debug_obj_state state)
 	switch (state) {
 	case ODEBUG_STATE_ACTIVE:
 		WARN_ON(1);
+		/* fall through */
 
 	default:
 		return false;
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 803fa67aace9..ee834d4fb814 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -375,6 +375,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
 	switch (mode) {
 	case TICK_BROADCAST_FORCE:
 		tick_broadcast_forced = 1;
+		/* fall through */
 	case TICK_BROADCAST_ON:
 		cpumask_set_cpu(cpu, tick_broadcast_on);
 		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_mask)) {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 6eb7cc4b6d52..b1425b7d84d5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -647,6 +647,7 @@ static bool timer_fixup_activate(void *addr, enum debug_obj_state state)
 
 	case ODEBUG_STATE_ACTIVE:
 		WARN_ON(1);
+		/* fall through */
 
 	default:
 		return false;
-- 
2.20.1

