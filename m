Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92023C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E6822360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p7huWozS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E6822360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbeKMWNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:13:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42477 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732905AbeKMWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:13:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id x21-v6so3207358pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUgDlnUAaJL306eODgf+h9EXG9jD+4haGZANNglyJ1U=;
        b=p7huWozS8Zz34RdGWN1yuH2asWWBeyteLOh164AH1wnqmVC9/PPjBpB0KMAZPkJmVk
         PrWetah3XCnCqSZFwVEpk46ry7IWL6hhbdwnsWsuQ6pwlJhIdrxIg19lFiTu5M0kJEXd
         /1qosAABW0q0LCJtgzcBcOR2wmy3UhK5c4CDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUgDlnUAaJL306eODgf+h9EXG9jD+4haGZANNglyJ1U=;
        b=gObKmeQ8riZR5cutCrlKBWWnc6bzPY+FjNpSDZGWgf1nJMUlF+jIluejHpe4xbIYm/
         NXU0zB3WD/XnKH9QQvj12XjR5NZRbu9uoAApKdRYkbLQagvH4EgzVOzC3mxHx8OzULxT
         +VvYwlTsM9y1ScALwkoO2+rrcgr5nhyc1ON+aIIQSg79KB1nW1kw6jM7mSnFaWLk2Lh4
         uE3Ll9E2FxuXZmJV7qZXpq35o3buH0FxAWM+sqA2iO+eXrGyanCZ4UNPomB5EElOMMyr
         95Ogl2pVcvv6R25HdSrVtbDTxZYcQMN0P3zhga9CpZyqpFsfuVNs0A78FnAT1MljBmdc
         tJrg==
X-Gm-Message-State: AGRZ1gKvhJZvrRvHiLVrARxCn4xwu0RM20xl+WMG0Rnm5k7S6FHNkKNr
        Gqy+ice5R/QEjD8yY3fAOfGF6A==
X-Google-Smtp-Source: AJdET5dXyzEW6S/jir8OfYO3MY6LuxP0HrVvEH8dAc9+9jwsV4ebVMosH2S3S0AhCL5oErusgrUO/Q==
X-Received: by 2002:a17:902:768b:: with SMTP id m11mr2593881pll.80.1542111361597;
        Tue, 13 Nov 2018 04:16:01 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id g65sm14312614pfa.63.2018.11.13.04.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:16:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
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
Subject: [PATCH v6 2/4] arm64: defconfig: Enable DRM_SUN8I_MIXER
Date:   Tue, 13 Nov 2018 17:45:33 +0530
Message-Id: <20181113121535.24137-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113121535.24137-1-jagan@amarulasolutions.com>
References: <20181113121535.24137-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner Display Engine 2.0 Mixer is need for ARM64
Allwinner SoC's, build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v6:
- none
Changes for v5:
- Enable it on defconfig
Changes for v4, v3:
- none
Changes for v2:
- Enable for SUN8I

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4b3844480a77..7f271178d421 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -446,6 +446,7 @@ CONFIG_DRM_EXYNOS_HDMI=y
 CONFIG_DRM_EXYNOS_MIC=y
 CONFIG_DRM_ROCKCHIP=m
 CONFIG_DRM_SUN4I=m
+CONFIG_DRM_SUN8I_MIXER=m
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
-- 
2.18.0.321.gffc6fa0e3

