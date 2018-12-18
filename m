Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC55C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A72921871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JT/ZsqfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeLRV3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55290 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeLRV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so4087825wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+kk49u2E8Mo1JNxE8BrR9oOARp9WmK1DmRN/2CO3j/8=;
        b=JT/ZsqfQLVVSX+jbMOMwvdmTraAUh2j/2iIoSl0jGXgA15MSLhzzoSfM9jCn+rNy9i
         k0FnfddkVZjRaa3CS8Q2P9eoYYMhlpkT6CslTRnZ7GLniqwBtx4ehL/B93ISFzEMf//6
         fG7g3U/ReKJQHa6S/EMTgVhtGkPbKfd0r9bC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+kk49u2E8Mo1JNxE8BrR9oOARp9WmK1DmRN/2CO3j/8=;
        b=KKkV3cuvjnkxSbMvMidKBKFY4TKZZjaxNbg2wGA3uDbS9UoHDeSMzJbOK3X92yLJ3I
         287YW/VeG/6PXWa8HZDpzUEoPmQh8ETHKcDpV+S64V9oxV8hG2XejsVYE76YGR/TmKfs
         rZYXAhRplCZB0465YrgPUX3moKR1Vr6IkieJqHATxliPOtuYtQ6QuchT9sWgo1B8xvXZ
         v0y8VM0nw9g1dTqUp5o1WJvmz1l7JwWiQtmmEru6kNcuV0Rxwsssqa2N8oT6zqsFsIyL
         ms0R6wvQtArFPTUavhOXN6nEcJj2aBQMgEhih5/xXMcypj1aj8f8FLLboA/gVdiX2e4S
         9bDA==
X-Gm-Message-State: AA+aEWY5lH1RBxYrfdMwjsm76pZ6jW9gXoKow6aIJQhaXo1dOh/o4QMu
        TxngHLuTbmvpkeWH9WsQYkIJmA==
X-Google-Smtp-Source: AFSGD/XiEeq+vDeKGNZkt57dLzm/xXk4gUU9JTvpHHo4mRvG7y+KrZgN/UlfX6m1Ak8NNfX0sYi5hg==
X-Received: by 2002:a1c:ae88:: with SMTP id x130mr4442834wme.91.1545168559808;
        Tue, 18 Dec 2018 13:29:19 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support)
Subject: [PATCH 07/25] clocksource/drivers/meson6_timer: Implement the ARM delay timer
Date:   Tue, 18 Dec 2018 22:28:25 +0100
Message-Id: <20181218212844.30445-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Implement an ARM delay timer to be used for udelay(). This allows us to
skip the delay loop calibration at boot.

With this patch udelay() is now independent of CPU frequency changes.
This is a good thing on Meson8, Meson8b and Meson8m2 because changing
the CPU frequency requires running the CPU clock off the XTAL while
changing the PLL or it's dividers. After changing the CPU clocks we need
to wait a few usecs for the clock to become stable. So having an
udelay() implementation that doesn't depend on the CPU frequency is
beneficial.

Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/meson6_timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 23c7638e2bb3..84bd9479c3f8 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -22,6 +22,10 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#ifdef CONFIG_ARM
+#include <linux/delay.h>
+#endif
+
 #define MESON_ISA_TIMER_MUX					0x00
 #define MESON_ISA_TIMER_MUX_TIMERD_EN				BIT(19)
 #define MESON_ISA_TIMER_MUX_TIMERC_EN				BIT(18)
@@ -54,6 +58,18 @@
 
 static void __iomem *timer_base;
 
+#ifdef CONFIG_ARM
+static unsigned long meson6_read_current_timer(void)
+{
+	return readl_relaxed(timer_base + MESON_ISA_TIMERE);
+}
+
+static struct delay_timer meson6_delay_timer = {
+	.read_current_timer = meson6_read_current_timer,
+	.freq = 1000 * 1000,
+};
+#endif
+
 static u64 notrace meson6_timer_sched_read(void)
 {
 	return (u64)readl(timer_base + MESON_ISA_TIMERE);
@@ -192,6 +208,12 @@ static int __init meson6_timer_init(struct device_node *node)
 
 	clockevents_config_and_register(&meson6_clockevent, USEC_PER_SEC,
 					1, 0xfffe);
+
+#ifdef CONFIG_ARM
+	/* Also use MESON_ISA_TIMERE for delays */
+	register_current_timer_delay(&meson6_delay_timer);
+#endif
+
 	return 0;
 }
 TIMER_OF_DECLARE(meson6, "amlogic,meson6-timer",
-- 
2.17.1

