Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E5C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6C821726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kYXku2+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfAXUAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:00:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44322 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbfAXUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so3510612pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUFV3EbRWTylHEUKUIeOqSoI6gTTKiS0hGHS2pg+s1g=;
        b=kYXku2+URiPTdGUN0CnytsHS0hqAI82ylfs+dKmCWQEKJ+BdxgbLh8PPphfZPGNePq
         /96+rmiOaEGSTphtezeUvV1cBmZLCTvSe8ZnniWkfWch6nY6PK715P0JCMiHKchP0yFq
         XLJ8t7+p4LPR665DNVYy0yxzgsbmTfwwiQJkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUFV3EbRWTylHEUKUIeOqSoI6gTTKiS0hGHS2pg+s1g=;
        b=OQRe3p3McRxBcGWj66r6rYG5tbtQr55sgjJT1yTPHtHZb2D0mbtOfy5GtXIpE6PtrK
         7Oygj5Awr7vGA1X5wWkdKqtU6JocMeIDbQcltryCpNIokoCNNIc3/gjTRD6UxShhh7bK
         KTNKXo17b7bXaalkKS5QhH6M/qDCqe0Xpu/pTguF/4UoeKpdky0UL4WIOSRIwCGbe5H0
         svnPYB5snFATJpmYjnRVD+1OVHlrROFXFUHNb3FZbfFjCBv9m8s3dSmnQE8VMRirFSEA
         AW4LhSup1bTcZqZoXSApEPjjj31liKhb4kgFLYclHmhm2/EvTOz6B2SWZZmV5c9p8kGs
         p5lQ==
X-Gm-Message-State: AJcUukcE1VLaF1UoYihrr2/GUjE/AZ8OudlzhLLfwJpdqfk9O+sUFEbM
        utT6dqU4ygMFUwZIGj8tzz467w==
X-Google-Smtp-Source: ALg8bN5RmRe8ODy7m+XM46GYuK17hUEAO1Y4XOThFEHBmaFLnaGq3Qms+U0Xep8wBNGFIGPxjc1hGw==
X-Received: by 2002:a63:e950:: with SMTP id q16mr7211887pgj.138.1548360017678;
        Thu, 24 Jan 2019 12:00:17 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:17 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 11/22] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
Date:   Fri, 25 Jan 2019 01:28:49 +0530
Message-Id: <20190124195900.22620-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimum PLL used for MIPI is 500MHz, as per manual, but
lowering the min rate by 300MHz can result proper working
nkms divider with the help of desired dclock rate from
panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 932836d26e2b..296d489aad6e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3

