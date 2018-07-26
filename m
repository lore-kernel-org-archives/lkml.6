Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDF0C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44F620671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4aft561"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44F620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbeGZLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:32:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52689 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbeGZLcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:32:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so1396845wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZok4+MHcZ2Rmmvuy9wXzlMzMAeBIWyc64eLlpaY/ps=;
        b=f4aft561/IOAdqJnFPamXdJqu9t25NHwcBW8/SopBLaT9zJrBGIGb6Dfzs8S7FNdHC
         PMjEKVQ3YQnoFdGw4TYpJkGKVbh7XFyMPBI/fyBd4M2AdrFSvK/Wdbl1yVV9ESJL+cRm
         OLe0s0UsDWvkmNOgy4W8XhchgzeWaheK9IutE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZok4+MHcZ2Rmmvuy9wXzlMzMAeBIWyc64eLlpaY/ps=;
        b=UEY3ybafnOkpgzcXBvrRPAJx4kfOeHnneqoBeZwLt4HC9QHSyfuLwxGTOIBsxlNJI/
         q0Givkq3lJXL375/jKVFfBWxYd1Guut4VzQwsY44b2nbffJAbVuQhw80GF9AipEcEIVL
         8eUPuZzkD2z5zAegOx2hcEF86iftZAcskSHe60HNyxyVUQvOYlYIsBO1+pKjSoE4r8Tq
         DARvVptraomiKbRbACJbfxxdcU2UkE/pe61aHZmttbQ8WzDDvL6mRvV/tE58wFlH8VC7
         xkjKUQnru0xDeeuLslD8jtRSzMQGLuFlEEtQnWCmHjFWF4xngb+uU0UvPQplud7dJnCg
         G2iw==
X-Gm-Message-State: AOUpUlGgEVp7XJN5jI+uS8cm3kfi1gq0MizmAVS4RYJMPZMbgOO9FDYf
        NasnYs1ojhQD431uxFmk8loScA==
X-Google-Smtp-Source: AAOMgpdFnFoi86dxU3XzRSReRmKX3YX8VBRtAnsvXZCvfATEBlWSBSxJHOMpNeC18/VkTh/F1qY3JQ==
X-Received: by 2002:a1c:80b:: with SMTP id 11-v6mr1204834wmi.125.1532600188821;
        Thu, 26 Jul 2018 03:16:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:35bd:fbdf:74b5:3f51])
        by smtp.gmail.com with ESMTPSA id f6-v6sm957303wrp.30.2018.07.26.03.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 03:16:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, stanley.chu@mediatek.com,
        baolin.wang@linaro.org, Sudeep.Holla@arm.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 7/7] clocksource/drivers/sprd: Register one always-on timer to compensate suspend time
Date:   Thu, 26 Jul 2018 12:15:30 +0200
Message-Id: <1532600131-28168-7-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Since the clocksource framework has introduced one suspend clocksource to
compensate the suspend time, this patch registers one always-on timer as
the suspend clocksource.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sprd.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index ef9ebea..430cb99 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -156,4 +156,54 @@ static int __init sprd_timer_init(struct device_node *np)
 	return 0;
 }
 
+static struct timer_of suspend_to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
+static u64 sprd_suspend_timer_read(struct clocksource *cs)
+{
+	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_LO) & cs->mask;
+}
+
+static int sprd_suspend_timer_enable(struct clocksource *cs)
+{
+	sprd_timer_update_counter(timer_of_base(&suspend_to),
+				  TIMER_VALUE_LO_MASK);
+	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+
+	return 0;
+}
+
+static void sprd_suspend_timer_disable(struct clocksource *cs)
+{
+	sprd_timer_disable(timer_of_base(&suspend_to));
+}
+
+static struct clocksource suspend_clocksource = {
+	.name	= "sprd_suspend_timer",
+	.rating	= 200,
+	.read	= sprd_suspend_timer_read,
+	.enable = sprd_suspend_timer_enable,
+	.disable = sprd_suspend_timer_disable,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static int __init sprd_suspend_timer_init(struct device_node *np)
+{
+	int ret;
+
+	ret = timer_of_init(np, &suspend_to);
+	if (ret)
+		return ret;
+
+	clocksource_register_hz(&suspend_clocksource,
+				timer_of_rate(&suspend_to));
+
+	return 0;
+}
+
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
+TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
+		 sprd_suspend_timer_init);
-- 
2.7.4

