Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78CC20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAc5B7k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfBWNJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:09:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37836 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfBWNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so4238017wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e7WizLNdunmkgpvUZcueZ9x7MQ1ttRLHdGjFtWenvEw=;
        b=XAc5B7k3LFdets0XOM7Vv1NwuvRTyprMF4KE1poem0QeAOBRSZaEkvXLvvMElE88UJ
         wZ+mJwCm0WJSRKSMlAzUeCt4HxQjin9Mf8yftyPSOlDVUpX0ZUO/hKWwuvDAJ/U9A9+f
         WWchtkd39iAka+FjXizc+PLkcA+mRkDq5yqzYSGIooAPzGssecRFkemdCPG1atmPDguZ
         OlanMP5QjHDkVZagrbFRyPHGXCv+KL7wHinLBt3X+x95Qut8Qa4QOdoKjFWgFyetK70t
         0xBUBYJZidOCdUfWFIbu+Dfx83Py97vk6qCDFJ4FEgtDKMwxpseVVy4m80hQ5ZS9uLMy
         9afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e7WizLNdunmkgpvUZcueZ9x7MQ1ttRLHdGjFtWenvEw=;
        b=oF5K82AN2zZAZwqW9I9vuK7FU3PRv6cLiiNy/Ngu6om6cL+rr12SM4CW9tXmwLyFxg
         9zEeNGikgIUZ7sCFnL9b03x0dn32iBmCZya4MrcvI/+12gS0yReDriroItXsGNvDvSix
         v7Ek/ql6biBVYw3G3525bXsLVqJG8Krh2gm4u7lYxe/7GBFI4UTgb+c1QbHjE9f3iH6U
         lfMvdym02r60HSiobAbNMROTlek0i0QPneX2QgMt6YjpRRRHTrWqHS8sS0Sx9P+t+Uob
         cRCHAPW3b1kH7JzqzX16OCgWkIvjWkYVrwdueTT4v47HSCmi1L/L/HB4AwXcWCOKRZ7l
         IJGw==
X-Gm-Message-State: AHQUAuYo1t3u0Ebq+7P9cIme1B0svucVacZHt8xmO1jQk1ZA+yI0WbOz
        d+8f9prOb+nLFDGRN/eoYIXvpA==
X-Google-Smtp-Source: AHgI3IZfB+oU90sDNEEorOPR/AmE5MOzpO4tRZz02pgmczh9FCuhWNQ56ReilC8uTjWJ9aQRTwRq1Q==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr5675795wme.93.1550927277877;
        Sat, 23 Feb 2019 05:07:57 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:07:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES)
Subject: [PATCH 03/18] clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR
Date:   Sat, 23 Feb 2019 14:06:51 +0100
Message-Id: <20190223130707.16704-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

When a timer tick occurs and the clock is in one-shot mode, the timer
needs to be stopped to prevent it triggering subsequent interrupts.
Currently this code is in exynos4_mct_tick_clear(), but as it is
only needed when an ISR occurs move it into exynos4_mct_tick_isr(),
leaving exynos4_mct_tick_clear() just doing what its name suggests it
should.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org # v4.3+
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..1e325f89d408 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -388,6 +388,13 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
 }
 
+static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+{
+	/* Clear the MCT tick interrupt */
+	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
+		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+}
+
 static int exynos4_tick_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
@@ -420,8 +427,11 @@ static int set_state_periodic(struct clock_event_device *evt)
 	return 0;
 }
 
-static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
+static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
 {
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = &mevt->evt;
+
 	/*
 	 * This is for supporting oneshot mode.
 	 * Mct would generate interrupt periodically
@@ -430,16 +440,6 @@ static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 	if (!clockevent_state_periodic(&mevt->evt))
 		exynos4_mct_tick_stop(mevt);
 
-	/* Clear the MCT tick interrupt */
-	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
-		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-}
-
-static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
-{
-	struct mct_clock_event_device *mevt = dev_id;
-	struct clock_event_device *evt = &mevt->evt;
-
 	exynos4_mct_tick_clear(mevt);
 
 	evt->event_handler(evt);
-- 
2.17.1

