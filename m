Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEBBC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DDD20675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mn8OH9P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfBWNIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45642 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfBWNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so5159136wrn.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/dC9KlJ2HFYdYmnw3hP+wmPZpOjWjCgiVR8KWlL9Mw=;
        b=mn8OH9P9jFUIYYwT9kiZtDMLsfnnQog8op/FqCeDhCxl6cce6Vdd7Wdw0vWCXytVew
         hQeeJLFOnoeZCo8i2xzI+sz5g1qnpuMF+XI/9+zCUPrmBLZtbCwkPLkHSVUq8rFdeGIK
         cl3vcKrLW0+SABVcEQV2OQXJvISPjid22tkKM8zpoemfCNLcg3OUzjwvKgDH0SM+4yhh
         vmqo+WCEMY9XWvavr4uBlUrV86W0LyHBRRN2RRHpT0HrgyBnE9rRaPGbsF20BIf7e35z
         0EI9Cpc6sz27ZX98jLWYmEF2uFvI1l2JdY1ljjyAVPGKcU3BKI+PmuCmndRPYDbxn7Qm
         RYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/dC9KlJ2HFYdYmnw3hP+wmPZpOjWjCgiVR8KWlL9Mw=;
        b=Vnc4eU1aKYezpGeuryPAJHZEgOLI3kIj0I+H3Axhewjg3V2VIzMiPhASML15zhREIM
         EgUPWrTNINNFxoVeYnaNj6G9TqRqwWS5MaWIxNaALaOStA3XKKyXSnZIqd7YO5VwZv0u
         3fX/A+PQK9I+763Nb1uMdpQk3uO3nX82C3lT6myVyqB2JbqJC3gYzOJSvIyTqJYVi1Ki
         oe41JhRc+ICfu8JCfvo7m+QvhM99rd1p8lFdcuTd0AYH+gjGZfhzirSwJRx5DiT5il9I
         yYjvMByQGYFsZmhkGdwgoDS3GW3+fiYOTFH4idTBshrRjWTkuJdNISKQt11LXgc9CGJI
         gG6Q==
X-Gm-Message-State: AHQUAuatKWJL/QffejZHl/zUYiOC9K3DKVvdqxJaKHPFStuyHc5xLHI8
        zz+oy1XrHZSHZ6d5gjQ3Il6cFQ==
X-Google-Smtp-Source: AHgI3IYrtIY9J9dmnkdasoQHFpCzIooEdynI8zgiDvf+ZmHsNPrBbuzx6F/oElnuqwV3ijzRVwBF5g==
X-Received: by 2002:adf:f845:: with SMTP id d5mr6886036wrq.113.1550927286421;
        Sat, 23 Feb 2019 05:08:06 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:05 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (moderated list:ARM/SAMSUNG EXYNOS
        ARM ARCHITECTURES)
Subject: [PATCH 08/18] clocksource/drivers/exynos_mct: Remove dead code
Date:   Sat, 23 Feb 2019 14:06:56 +0100
Message-Id: <20190223130707.16704-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

Exynos Multi-Core Timer driver is used only on device-tree based
systems, so remove non-dt related code. In case of !CONFIG_OF
the code is anyway equal because of_irq_count() has a stub
returning 0. Device node pointer is always provided when driver
has been probed from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index d55c30f6981d..647ea9fc752f 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -508,13 +508,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	int err, cpu;
 	struct clk *mct_clk, *tick_clk;
 
-	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
-				clk_get(NULL, "fin_pll");
+	tick_clk = of_clk_get_by_name(np, "fin_pll");
 	if (IS_ERR(tick_clk))
 		panic("%s: unable to determine tick clock rate\n", __func__);
 	clk_rate = clk_get_rate(tick_clk);
 
-	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
+	mct_clk = of_clk_get_by_name(np, "mct");
 	if (IS_ERR(mct_clk))
 		panic("%s: unable to retrieve mct clock instance\n", __func__);
 	clk_prepare_enable(mct_clk);
@@ -582,11 +581,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	 * timer irqs are specified after the four global timer
 	 * irqs are specified.
 	 */
-#ifdef CONFIG_OF
 	nr_irqs = of_irq_count(np);
-#else
-	nr_irqs = 0;
-#endif
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
-- 
2.17.1

