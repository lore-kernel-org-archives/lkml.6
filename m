Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92522C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1EA2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFyWBkO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1EA2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbeHGQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:42:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43841 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:42:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so15961035wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQeOn7z2zgtAWzzjccDSf6WarhVnTGNmsaV0jykRFsI=;
        b=FFyWBkO4mnuuNLywipWC8gaY1wDIF6KFi8+g60KsIXFLf6aA3WgSdIBNIWdXrlZcFq
         IYThJczA0SONEWaiWLAjQUKYyyJtux0WpQZCOsH7ciohXTdIgQ2ToPtcN6RwnWcuDzvy
         bUbWJ3duihUwKsVsaQft8BeZobd5XjSw+UiT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQeOn7z2zgtAWzzjccDSf6WarhVnTGNmsaV0jykRFsI=;
        b=paxVxf6ZImFCQSwChVUijM9JCROdbbsTDwC8aQ193t5LIED5uTi4AE3vKvJyMnnEAj
         s65uwwGSw6W8ZLXUWWQUTTLN+9TURZl8IFyFyuQ1FU+rlJCflgLf0ZKTDIc5FJpDT1J/
         4t1CZi0lNTR55spNfDPomaipWHtUjNfITtqhAO/X79BzcLjQwKzi2gHmwVyL10qKs1gg
         gTnADEIXn6DgAvfmoPogQsNP4iS1KKG/G9sfzdfyuBSFd+HCZVvqGbD860fgCnT+pLQc
         gPRHn4+jsa4KScN0wtbeiS6WmtYcQqUFuD+TEJSbv5Q6HBf2gbUZs9zJzZHUP3GuwV4w
         S3eg==
X-Gm-Message-State: AOUpUlH0Fu9Xk9t+E21e6qxjGdviZvi0H1C0ObkN7QFfFRXGh0Y8oSMD
        n0c8nPEEDwEi2Q+pFG9FFyC6Mw==
X-Google-Smtp-Source: AAOMgpf2PQGJ5ZtaIG9RGiwA/wUCrD6H1ifCV12OFNrc/GlmBDz+58uXKY9a0fTZjt2MOkzw37qx2g==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr12617063wro.264.1533652054795;
        Tue, 07 Aug 2018 07:27:34 -0700 (PDT)
Received: from localhost.localdomain ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id t13-v6sm1478787wrr.74.2018.08.07.07.27.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 07:27:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] cpuidle: menu: Correct the criteria for stopping tick
Date:   Tue,  7 Aug 2018 22:27:03 +0800
Message-Id: <1533652024-19078-2-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533652024-19078-1-git-send-email-leo.yan@linaro.org>
References: <1533652024-19078-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The criteria for keeping tick running is the prediction duration is less
than TICK_USEC, the mainline kernel configures HZ=250 so TICK_USEC equals
to 4000us, so any prediction is less than 4000us will not stop tick and
the idle state will be fixed up to one shallow state.  On the other hand,
let's use 96boards Hikey (CA53 octa-CPUs) as an example, the platform has
the deepest C-state is cluster off state which its 'target_residency' is
2700us, if the 'menu' governor predicts the next idle duration is any
value fallen into the range [2700us, 4000us), then the 'menu' governor
will keep sched tick running and and roll back to a shallow CPU off state
rather than cluster off state.  Finally we can see the CPU has much less
chance to run into deepest state when a task repeatedly running on it
with 5000us period and 40% duty cycle (so the task runs for 2000us and
then sleep for 3000us in every period).  In theory, we should permit the
CPU to stay in cluster off state due the CPU sleeping time 3000us is
over its 'target_residency' 2700us.

This issue is caused by the 'menu' governor's criteria for decision if
need to enable tick and roll back to shallow state, the criteria is:
'expected_interval < TICK_USEC'.  This criteria is only considering from
tick aspect, but it doesn't consider idle state residency so misses
better choice for deeper idle state; e.g., the deepest idle state
'target_residency' is less than TICK_USEC, which is quite common on Arm
platforms.

To fix this issue, this patch is to add one extra variable
'stop_tick_point' to help decision if need to stop tick or not.  If
prediction is longer than 'stop_tick_point' then we can stop tick,
otherwise it will keep tick running.

For 'stop_tick_point', except we need to compare prediction period with
TICK_USEC, we also need consider from the perspective of deepest idle
state 'target_residency'.  Finally, 'stop_tick_point' is coming from the
minimum value within the deepest idle state 'target_residency' and
TICK_USEC.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/cpuidle/governors/menu.c | 41 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 30ab759..2ce4068 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -294,6 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
 	ktime_t delta_next;
+	unsigned int stop_tick_point;
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -406,11 +407,47 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		idx = 0; /* No states enabled. Must use 0. */
 
 	/*
+	 * Decide the time point for tick stopping, if the prediction is before
+	 * this time point it's better to keep the tick enabled and after the
+	 * time point it means the CPU can stay in idle state for enough long
+	 * time so should stop the tick.  This point needs to consider two
+	 * factors: the first one is tick period and the another factor is the
+	 * maximum target residency.
+	 *
+	 * We can divide into below cases:
+	 *
+	 * The first case is the prediction is shorter than the maximum target
+	 * residency and also shorter than tick period, this means the
+	 * prediction isn't to use deepest idle state and it's suppose the CPU
+	 * will be waken up within tick period, for this case we should keep
+	 * the tick to be enabled;
+	 *
+	 * The second case is the prediction is shorter than the maximum target
+	 * residency and longer than tick period, for this case the idle state
+	 * selection has already based on the prediction for shallow state and
+	 * we will expect some events can arrive later than tick to wake up the
+	 * CPU; another thinking for this case is the CPU is likely to stay in
+	 * the expected idle state for long while (which should be longer than
+	 * tick period), so it's reasonable to stop the tick.
+	 *
+	 * The third case is the prediction is longer than the maximum target
+	 * residency, but weather it's longer or shorter than tick period; for
+	 * this case we have selected the deepest idle state so it's pointless
+	 * to enable tick to wake up CPU from deepest state.
+	 *
+	 * To summary upper cases, we use the value of min(TICK_USEC,
+	 * maximum_target_residency) as the critical point to decide if need to
+	 * stop tick.
+	 */
+	stop_tick_point = min_t(unsigned int, TICK_USEC,
+			drv->states[drv->state_count-1].target_residency);
+
+	/*
 	 * Don't stop the tick if the selected state is a polling one or if the
-	 * expected idle duration is shorter than the tick period length.
+	 * expected idle duration is shorter than the estimated stop tick point.
 	 */
 	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    expected_interval < TICK_USEC) {
+	    expected_interval < stop_tick_point) {
 		unsigned int delta_next_us = ktime_to_us(delta_next);
 
 		*stop_tick = false;
-- 
2.7.4

