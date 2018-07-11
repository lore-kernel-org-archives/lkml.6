Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A5BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1A320835
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1A320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeGKL2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:28:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732586AbeGKL2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFBD380D;
        Wed, 11 Jul 2018 04:24:46 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.210.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 776F63F589;
        Wed, 11 Jul 2018 04:24:45 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: [PATCH 1/3] clocksource: drivers: set clockevent device cpumask to cpu_possible_mask
Date:   Wed, 11 Jul 2018 12:24:22 +0100
Message-Id: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, quite a few clockevent devices have cpumask set to
cpu_all_mask which should be fine. However, cpu_possible_mask is more
accurate and if there are any other clockevent devices in the system
which have cpumask set to cpu_possible_mask, then having cpu_all_mask
may result in issues (mostly boot hang with forever loops in
clockevents_notify_released).

So, lets replace all the clockevent device cpu_all_mask to
cpu_possible_mask in order to prevent above mentioned possible issue.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/tegra20_timer.c   | 2 +-
 drivers/clocksource/timer-atcpit100.c | 2 +-
 drivers/clocksource/timer-keystone.c  | 2 +-
 drivers/clocksource/zevio-timer.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a8100a7b..dabf0a103567 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -230,7 +230,7 @@ static int __init tegra20_init_timer(struct device_node *np)
 		return ret;
 	}

-	tegra_clockevent.cpumask = cpu_all_mask;
+	tegra_clockevent.cpumask = cpu_possible_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_config_and_register(&tegra_clockevent, 1000000,
 					0x1, 0x1fffffff);
diff --git a/drivers/clocksource/timer-atcpit100.c b/drivers/clocksource/timer-atcpit100.c
index 5e23d7b4a722..b4bd2f5b801d 100644
--- a/drivers/clocksource/timer-atcpit100.c
+++ b/drivers/clocksource/timer-atcpit100.c
@@ -185,7 +185,7 @@ static struct timer_of to = {
 		.set_state_oneshot = atcpit100_clkevt_set_oneshot,
 		.tick_resume = atcpit100_clkevt_shutdown,
 		.set_next_event = atcpit100_clkevt_next_event,
-		.cpumask = cpu_all_mask,
+		.cpumask = cpu_possible_mask,
 	},

 	.of_irq = {
diff --git a/drivers/clocksource/timer-keystone.c b/drivers/clocksource/timer-keystone.c
index 0eee03250cfc..f5b2eda30bf3 100644
--- a/drivers/clocksource/timer-keystone.c
+++ b/drivers/clocksource/timer-keystone.c
@@ -211,7 +211,7 @@ static int __init keystone_timer_init(struct device_node *np)
 	event_dev->set_state_shutdown = keystone_shutdown;
 	event_dev->set_state_periodic = keystone_set_periodic;
 	event_dev->set_state_oneshot = keystone_shutdown;
-	event_dev->cpumask = cpu_all_mask;
+	event_dev->cpumask = cpu_possible_mask;
 	event_dev->owner = THIS_MODULE;
 	event_dev->name = TIMER_NAME;
 	event_dev->irq = irq;
diff --git a/drivers/clocksource/zevio-timer.c b/drivers/clocksource/zevio-timer.c
index a6a0338eea77..f74689334f7c 100644
--- a/drivers/clocksource/zevio-timer.c
+++ b/drivers/clocksource/zevio-timer.c
@@ -162,7 +162,7 @@ static int __init zevio_timer_add(struct device_node *node)
 		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
 		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
 		timer->clkevt.rating		= 200;
-		timer->clkevt.cpumask		= cpu_all_mask;
+		timer->clkevt.cpumask		= cpu_possible_mask;
 		timer->clkevt.features		= CLOCK_EVT_FEAT_ONESHOT;
 		timer->clkevt.irq		= irqnr;

--
2.7.4

