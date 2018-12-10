Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC7FC67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244E520672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oMpl0ALA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244E520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeLJQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39759 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeLJQSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so11841621wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SS22PqBK8tWsdyn/FHAwZUavV4dNBBIV2/QUJd77h4k=;
        b=oMpl0ALA9vxGolpUGRPXPTFTlEuGqt8XU2UW+J1+kRVNZR+UkFW6NZi54Y1+q4yANF
         A5ShHj6CNV/Moj5lVh3DVAF17KqVl1oKB01MPypxImmzV+qjVOFe5y4+34Tn/DBLWaIC
         OYOnhYgZcZaax7fueoKLt1tiXL60i45TtsUgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SS22PqBK8tWsdyn/FHAwZUavV4dNBBIV2/QUJd77h4k=;
        b=JsfEIWNLOA5CdxwyF8s4apPFdJNPI55+TwUUik2/GfLnuMsYhhGPI/ysAOtjv9n+/A
         Xp2nEwAr8OpjIyby81YTy0lIf7C8pDNXSJQtuNBQmE56YH5iGpH+NXDg1g6oJFoDTwgd
         GQ2YGX3CQms0Og6r1RU2JED5B19My4FXeWGJJAlSQQhE6yGs7zb28sAB+D9hnvrAhiYc
         LLZlt0++rFeGkQzhn7Ny8rDrwKtTtqhW3EAt9oYNcz70/gxDvMLNFUFiM8yNx/F33jzE
         sP43X4m8RDGZ0kvozArNiXrsXS2pRQJ2dR8KcJJZIPfMkneVXUXgqKoQBHcAmnvSEszR
         R8Ow==
X-Gm-Message-State: AA+aEWZ/HN9t800iSW9zEk0kOJ9rNLw0yTblBwBfpI5rdPZvz8wtyS6Q
        qE3yhepyIg6L8BZZ5piObWHXKQ==
X-Google-Smtp-Source: AFSGD/UkunrLdyF1uFFqybjHZqBmchG32sEgRXZF3wFvzKBtIfF3Z3WDnTjOxaEb/dtfoyprq4epaA==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr11710901wme.106.1544458690275;
        Mon, 10 Dec 2018 08:18:10 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:09 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 15/17] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
Date:   Mon, 10 Dec 2018 21:47:27 +0530
Message-Id: <20181210161729.29720-16-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
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
index 181b599dc163..b623c8150b4f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,		/* Actual rate is 500MHz */
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3

