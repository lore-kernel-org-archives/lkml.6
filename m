Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C668C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1FD21AA7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZsUsFz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1FD21AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeHIIKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:10:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34979 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbeHIIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:10:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so5140563wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WIsl0h13VvWgunA2GMo3QFAUpzp4UHDQ6cgFDpgCvp0=;
        b=XZsUsFz+y5KjQMs7nefOqEpkS2w5fl6+py9zFfsugJt09pw4K84SMWg6fo4vEF/4Re
         IPVI6S4mRZwWaGkoSjR+DVWyP5enGtWDqTaM9q/UlKk6Eem5QUa6PRzl7Rm4w/wACw2u
         ItYzzCJoGZ1Dt4AKleveQdcchrd8g9YLXHkEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WIsl0h13VvWgunA2GMo3QFAUpzp4UHDQ6cgFDpgCvp0=;
        b=LT/RCcbl+mfonBLolpnFeHci4V8b9tSXDoJTfl8ed94ZYx3VLVG2NDxQnJxJmvgG4y
         90WfQv/Vw3gJrVF69XYKANucfB2GHPzeedHilwLdZKVmKHCv56v50MWs2u6ig/OhYHjS
         37p/0LfIF3O7q5qeMCpSIkejixLguwPAw93YKoeqfOouDY/v3jlANksMFuOjSFLrlgd9
         9g0rjIVYgGMFn4V/5DA6JxhpmR/4d/R4/tyPijN+2wQjbaHq54a///CC0hjxImrerrg7
         I0ULuHD+Mbffy4f0sGS827fZKfJRx+ZRozCD2/le+HlJT62/4uG6Raeb1fGEn8t27vlP
         HEHQ==
X-Gm-Message-State: AOUpUlExJvII0TrXHASmAT9Cs6G7d/tpJerC+eW+WO/x79S3rYmU8slK
        ldx8CJ6wl0iXRcZCDFU6RxSFOQ==
X-Google-Smtp-Source: AA+uWPwEVJ1SVZNUNbIw7ioZ6dttrzvFitQRgP5i5v4UMcqYlgr0eGF1vw/OUMi/wcJTpScWxtV7fQ==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr623357wme.125.1533793665484;
        Wed, 08 Aug 2018 22:47:45 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id x62-v6sm1437612wmg.1.2018.08.08.22.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 22:47:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Date:   Thu,  9 Aug 2018 13:47:27 +0800
Message-Id: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle loop stops tick by respecting the decision from cpuidle
framework, if the condition 'need_resched()' is false without any task
scheduling, the CPU keeps running in the loop in do_idle() and it has no
chance call tick_nohz_idle_exit() to enable the tick.  This results in
the idle loop cannot reenable sched tick afterwards, if the idle
governor selects a shallow state, thus the powernightmares issue can
occur again.

This issue can be easily reproduce with the case on Arm Hikey board: use
CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
function it start a hrtimer with 4ms, so the 4ms timer delta value can
let 'menu' governor to choose deepest state in the next entering idle
time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
10 times, so this can utilize the typical pattern in 'menu' governor to
have prediction for 1ms duration, finally idle governor is easily to
select a shallow state, on Hikey board it usually is to select CPU off
state.  From then on, CPU7 stays in this shallow state for long time
until there have other interrupts on it.

C2: cluster off; C1: CPU off

Idle state:           C2    C2    C2    C2    C2    C2    C2    C1
            --------------------------------------------------------->
Interrupt:   ^        ^     ^     ^     ^     ^     ^     ^     ^
            IPI      Timer Timer Timer Timer Timer Timer Timer Timer
	             4ms   1ms   1ms   1ms   1ms   1ms   1ms   1ms

To fix this issue, the idle loop needs to support reenabling sched tick.
This patch checks the conditions 'stop_tick' is false when the tick is
stopped, this condition indicates the cpuidle governor asks to reenable
the tick and we can use tick_nohz_idle_restart_tick() for this purpose.

A synthetic case is used to to verify this patch, we use CPU0 to send
IPI to wake up CPU7 with 50ms interval, CPU7 generate a series hrtimer
events (the first interval is 4ms, then the sequential 10 timer events
are 1ms interval, same as described above).  We do statistics for idle
states duration, the unit is second (s), the testing result shows the
C2 state (deepest state) staying time can be improved significantly for
CPU7 (+7.942s for 10s execution time on CPU7) and all CPUs wide
(+13.360s for ~80s of all CPUs execution time).

       Without patches         With patches         Difference
     --------------------  --------------------  -----------------------
CPU    C0     C1      C2     C0     C1      C2      C0      C1       C2
0    0.000  0.027   9.941  0.055  0.038   9.700  +0.055  +0.010   -0.240
1    0.045  0.000   9.964  0.019  0.000   9.943  -0.026  +0.000   -0.020
2    0.002  0.003  10.007  0.035  0.053   9.916  +0.033  +0.049   -0.090
3    0.000  0.023   9.994  0.024  0.246   9.732  +0.024  +0.222   -0.261
4    0.032  0.000   9.985  0.015  0.007   9.993  -0.016  +0.007   +0.008
5    0.001  0.000   9.226  0.039  0.000   9.971  +0.038  +0.000   +0.744
6    0.000  0.000   0.000  0.036  0.000   5.278  +0.036  +0.000   +5.278
7    1.894  8.013   0.059  1.509  0.026   8.002  -0.384  -7.987   +7.942
All  1.976  8.068  59.179  1.737  0.372  72.539  -0.239  -7.695  +13.360

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 kernel/sched/idle.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 1a3e9bd..802286e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -190,10 +190,18 @@ static void cpuidle_idle_call(void)
 		 */
 		next_state = cpuidle_select(drv, dev, &stop_tick);
 
-		if (stop_tick)
+		if (stop_tick) {
 			tick_nohz_idle_stop_tick();
-		else
+		} else {
+			/*
+			 * The cpuidle framework says to not stop tick but
+			 * the tick has been stopped yet, so restart it.
+			 */
+			if (tick_nohz_tick_stopped())
+				tick_nohz_idle_restart_tick();
+
 			tick_nohz_idle_retain_tick();
+		}
 
 		rcu_idle_enter();
 
-- 
2.7.4

