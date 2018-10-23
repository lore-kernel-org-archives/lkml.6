Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71B3C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2A620665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mDLpNihe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2A620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeJXAV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:21:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40115 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbeJXAVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:21:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so516153pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5vmeLba4HzhTYd2yYqFFjmhy3hncek3olOFgWxzbz+U=;
        b=mDLpNihen5X5f0NEll/ZhsDKhs+FTjUoFS3Hl4pX1Iq0R1O6BAz+C26SoTM2AEt7/j
         LF3zwamIBLjwwg1OyhaDdU50f2Ds1zxQiGyaqy81Fdy10diBGJr+i+wwtphldCHDoDa6
         6RzLwxZBQCDJZPvg35nKgKsHr7ysEzhf8kyOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5vmeLba4HzhTYd2yYqFFjmhy3hncek3olOFgWxzbz+U=;
        b=kl1ExNPa4V7SnjOKVPMye2r79KXJcLBg4ZmIsVOKyZbrxdP7da0Zj1n3ibu2Qo5OUi
         8j82muqqSAFY1zAwRC1vBjkj2aHNJm/wILSV6Nd+nFBbxeyzrFmMcRVPPEgrZnke5sJJ
         YnVAY2RBlYi2rh9I33zZVHJS8yISRDGMXosWYdEhyB19LJv4S7WqJ6O7SdQzW7trJteN
         1qofy3Qy8SSm3Fysr9cDNL85BGUSCZ0VVlvR7QDt8QHOJ3y1ArvW6Bs3Uia9uY6+mMCh
         oj1nhdNZQ8s/RKTm8inrOGnrdvVsNtB2kYkhmsd4ys3TLkDRSj4cQY0z2hc5wb1f+k9Q
         yP4g==
X-Gm-Message-State: AGRZ1gJEDuhHUzqvLYaAV/vRM29l6Qd8nxWnshO3UNU5GN5btbdwbS/5
        Y9+6WlkhTzg6h0NvjFgOVLuVvA==
X-Google-Smtp-Source: AJdET5e4oEbD1kWJFcXlUikfKIRobr3bKDES/iJoFMIwdQYyD7/5qhCENCZpEqSo/DNUzSnT+r7bKw==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3-v6mr2708711plo.162.1540310277261;
        Tue, 23 Oct 2018 08:57:57 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id l2-v6sm2207609pgp.20.2018.10.23.08.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:57:56 -0700 (PDT)
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
Subject: [PATCH v5 4/4] arm64: defconfig: Enable PWM_SUN4I
Date:   Tue, 23 Oct 2018 21:27:27 +0530
Message-Id: <20181023155727.9383-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155727.9383-1-jagan@amarulasolutions.com>
References: <20181023155727.9383-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner PWM support need for ARM64 Allwinner SoC's
which used pwms, builds it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb614bd70716..dfdbc0646472 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -648,6 +648,7 @@ CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
+CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
-- 
2.18.0.321.gffc6fa0e3

