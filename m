Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF265C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945A620671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiu38j8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945A620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeGZLcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:32:25 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39997 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbeGZLcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:32:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so1428784wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s9ggIHlFjOX1GmAyyDslj8PkwmNwq5DhXl20UHGcAF8=;
        b=kiu38j8ghlbuHgRXPBTkxa0q3f3oYEDFjIYba/QumdUgE60hlluZOpleJg1gKDi2QM
         Jaq8+tO/aejAEuSpfb9bEFlW2zj1O+CcOxMhY5+PElt65EBOrYpsNMjJivnXLQnAIUwi
         lw7/R8KsyXpO1GY/EWKg2MBAeGpm7BVmZzIx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s9ggIHlFjOX1GmAyyDslj8PkwmNwq5DhXl20UHGcAF8=;
        b=JF32nW12uifkygoduohMANWmqL56PpOkrnPQJCt4JoCErz5UWAMsrpajTFVsFiIzkG
         7XkWX+gWdXUP4mp9Bmcql2j1xCI4a9QLqOmNuWlTyAn3UwcAZxCuZYYzEs+h5CVLrND9
         JjBA4xrUNU9ONYKMi/j6s6YFcwJD5GnHWqqnM9s5m7T+pDoeAcKb4O7FMLmXg/PeSeoc
         lgiL/Uo/T0jZh21UTyXzbJOvkvFKJdBuKAXRfA/geXLRxV7Q/LD9lmg4vHOmM4wXIe2N
         UH3UjxwJ2zS5ji57+NGOOU3BXrA48RPwu8ec4IJAnn0Z/k7N2HUUXtR49BYDWOuxyoVB
         ltTA==
X-Gm-Message-State: AOUpUlHBqGuoIDLhHoxZUYkqRBXs3HKcsoNgpViQnGi8KoO1hbHG2GMO
        TqbUa8my9Qj3sB2QrDDxN5w55Q==
X-Google-Smtp-Source: AAOMgpdVyDT8+lW+GPheJToa29JriWOfM0MW27zRd9E9IqCpauZakaOIer1enTsP3dgNvnXB28TkrQ==
X-Received: by 2002:a1c:1943:: with SMTP id 64-v6mr1098030wmz.89.1532600173921;
        Thu, 26 Jul 2018 03:16:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:35bd:fbdf:74b5:3f51])
        by smtp.gmail.com with ESMTPSA id f6-v6sm957303wrp.30.2018.07.26.03.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 03:16:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, stanley.chu@mediatek.com,
        baolin.wang@linaro.org, Sudeep.Holla@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS
        INSTRUMENT KEYSTONE ClOCKSOURCE)
Subject: [PATCH 1/7] clocksource/drivers: Set clockevent device cpumask to cpu_possible_mask
Date:   Thu, 26 Jul 2018 12:15:24 +0200
Message-Id: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

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
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tegra20_timer.c   | 2 +-
 drivers/clocksource/timer-atcpit100.c | 2 +-
 drivers/clocksource/timer-keystone.c  | 2 +-
 drivers/clocksource/zevio-timer.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a81..dabf0a1 100644
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
index 5e23d7b..b4bd2f5 100644
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
index 0eee032..f5b2eda 100644
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
index a6a0338..f746893 100644
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

