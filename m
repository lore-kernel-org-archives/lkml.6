Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D136C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1352022507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bxuNqRYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1352022507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732947AbeKMVQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35569 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbeKMVQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so5550214pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6bCnCXGvGb+WTYYXJyM90jNCA/shvWQ1MA/BQWovloI=;
        b=bxuNqRYpBAu9VCBSV2xKdby2vjCbZApxF6VWE7g3P467rZugpyPtHfEDsxU0jUeASu
         rs4BsJMNOfE/oqoBhzcE9jJwSUfu6iIJhC6PvIznSYG6+RFzecUfAGh2KpajM6waxJji
         XPAt7fUtRnuS5ZDB/EaLB7A8l2FAUaEgv9H7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6bCnCXGvGb+WTYYXJyM90jNCA/shvWQ1MA/BQWovloI=;
        b=mh0fWyasBKzVhhAAxUEIH7quFisxMqgVifp/0eLp6WaTAPwEYsO+TAQznnCafZ05qd
         zM30D8c4aEdnVsVrMFM9A3T883NtifvI+FXzG94Tp/kYnebUS4HQ4Ub6gMbdXZpEUy1H
         VL56kl+4PW8VfNc2is/k6Gr5uRCanyV+xWWYQf5bXzT9rx4+3+QKwOxAH1LVjupI3PHx
         vk3gqrF9k/3Sws7PrFek6cF0IC/DnqinQmctVbBhgKCYYjSw1OTsVoF8RP0/J9ekBiw/
         jJS5/0CKwXhQMFoPnbyCb403OtgLDhmEOhbDkfBOuKGQo5ybejfmbALM3AUxYgToHofj
         8Edg==
X-Gm-Message-State: AGRZ1gJDP2HTTKOnR8qkj7pqWb3UeaXN6I7IvrxEOzMRZ4CZmyTM2MKD
        UCFhK0d1elZu10pqeaceCiqapA==
X-Google-Smtp-Source: AJdET5eaF1s0sTZp6ao9W52tLpPWrw8U7gFiJUfLK07iH+OQgequAz4aORnm+trYbFgKmqBjhOmZFA==
X-Received: by 2002:a62:7687:: with SMTP id r129mr2444437pfc.17.1542107948545;
        Tue, 13 Nov 2018 03:19:08 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:19:08 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 22/26] clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
Date:   Tue, 13 Nov 2018 16:46:29 +0530
Message-Id: <20181113111633.20189-23-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manual noted to use PLL_MIPI rate 500MHz to 1.4GHz,
but lowering the min rate by 300MHz can result proper
working nkms divider with the help of desired dclock
rate from panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 019d67bf97c4..5a3a5b821f8b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -167,6 +167,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,		/* Actual rate is 500MHz */
+	.max_rate	= 1400000000UL,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3

