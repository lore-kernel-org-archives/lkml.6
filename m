Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510EDC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D6D2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iMvvWPRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D6D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeKCTUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46814 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKCTUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so2137043pfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBoHpvI+yjf+sOpHt/smPITCJdlWMb7A2BR5EeBkj9A=;
        b=iMvvWPRh/PdJ5rtKtCdSpfgbDPVzDn/8c4ZPlOrvAWDzuKwIpoAR2hxmnUl4yB6mYy
         tM9DByFgKieSQWbZo4ian3Uc9mwNM8hHNbJyIKBg9WB2hz7wBK0HyMFrM/s/+MCVei0O
         rYXMZROP/2yYMI0VBrABhOSgPHlynieKKnFOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBoHpvI+yjf+sOpHt/smPITCJdlWMb7A2BR5EeBkj9A=;
        b=BFkZ/MOCyETU2pxt4+gTWdmrFBW1xJadf8guDxH1TahiE9A81sPbZ1DnE9DmnXt/fG
         m7/PLN61g1IwkOU0kMTAI8RJmRaRUt4R7UKoFXwK8VSPx79Q/C5g8L+pFPf6yVoHL9fY
         RGUetWaK7zPEOL8xUSaZsYqHn80Bo3cpprzQjlMeTxsUWj4ixpJ4oWwgtMNPPkZlF8d0
         8kOXqUvviTZpONz5S/W8FfPi3mrdpC7GF6wafDdgaHs9DLl7Mc482ICRm3dxDhCQycS/
         1JV6BZivW47+/jLWORa8vz1zlyY7JLPSHLHGZyoRmHFpkzxXG82wjzBjLYjNtNyKSNcR
         cMnw==
X-Gm-Message-State: AGRZ1gKrRDNgNwSGzcjCPsXZaCOJ/KhlXYLc6H/EdmZasordnb4uKzW4
        /D8Ob+gVaGG/0QD7+qKTeQ/+pw==
X-Google-Smtp-Source: AJdET5fvkLH/Lzgeh3GeP6t+bSHKP1D/+JGthSpCBYjf7HluzjfCeocHOInlOwAvJHC2dzASgahvVg==
X-Received: by 2002:a63:460a:: with SMTP id t10-v6mr13818801pga.197.1541239799315;
        Sat, 03 Nov 2018 03:09:59 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:09:58 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 05/10] drm/sun4i: sun6i_mipi_dsi: Enable burst mode
Date:   Sat,  3 Nov 2018 15:38:55 +0530
Message-Id: <20181103100900.30313-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable video_mode_burst bit from dsi base control register
for burst mode display panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b6c01891df36..b18a01361f11 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -421,6 +421,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	regmap_write(dsi->regs, SUN6I_DSI_BURST_LINE_REG,
 		     SUN6I_DSI_BURST_LINE_NUM(line_num) |
 		     SUN6I_DSI_BURST_LINE_SYNC_POINT(sync_point));
+
+	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
 static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
-- 
2.18.0.321.gffc6fa0e3

