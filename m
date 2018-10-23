Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8079FC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DC320665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ldbXb9NS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DC320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeJXAVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:21:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37930 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeJXAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:21:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id p7-v6so843868plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3aFHpTKU3qefOsg4DLfdoXMokwXsPOj3/DyH66KHsQ=;
        b=ldbXb9NSJR/oBGl3iWn7edmu7K4HF556Hw+3Q+IwzUwE3FCFDrPgZ9fQBgxta2OrWV
         hXdbIVTCuADXIJif6Eddf9jHKg7jUuks+im6ISs/hYvchijHH9L+EeRDIcpaFx+kph7o
         0HXCH16UojRJIcqeUMobFlNCmu39Kj4lT1CUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3aFHpTKU3qefOsg4DLfdoXMokwXsPOj3/DyH66KHsQ=;
        b=IbBnlwZQku4g32Vsh77/CyjOc8YXAi/XW4lEFdCwy1yGEVWO3V2GgINeHlQberPznx
         sJ9CbUP0/9ECeZnjmchqRe1MFxzH3LRsryTzqZ7KZ5kftFtgOePnifULL5q9/FmzWbSC
         4ixtrIWkdu+N/YVIVi/LyfoEWigxhf54WwzcuUoiZKAmFNDf/mbnJxsu7NQjvMeBaMs4
         cEPX6vT5ozvE/Ihtd85mS7Qz6bb0X+YqPOdIa6thwwt2rZU90jHUxWLrasUaU+uxVb4+
         fLXzqlARsuGpNdeh7Zg0xO5XYp/ShB/LWsDGiavsxKm8yvtZWKD3vDQdl3HwqpzbWj0M
         0ktg==
X-Gm-Message-State: AGRZ1gJi2YqWAQZ9wMxdqinYF1FtOyAXYLfuUY/Ez45bXdjLnkNflOf7
        LZXd24gTvxWWRBErbV0tMm7Tng==
X-Google-Smtp-Source: AJdET5dY3Vn603+mhxfsCVrhLjKWDf/O2JY2s2e/G3Zqdqs6/N5+xKqCwtfjQFXEM1X5PRe4A4nNQw==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr1786970pli.250.1540310266533;
        Tue, 23 Oct 2018 08:57:46 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id l2-v6sm2207609pgp.20.2018.10.23.08.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:57:45 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 2/4] arm64: defconfig: Enable DRM_SUN8I_MIXER
Date:   Tue, 23 Oct 2018 21:27:25 +0530
Message-Id: <20181023155727.9383-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155727.9383-1-jagan@amarulasolutions.com>
References: <20181023155727.9383-1-jagan@amarulasolutions.com>
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

