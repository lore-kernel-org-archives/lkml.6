Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC88C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA482082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TOiwM0JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA482082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbeKCTUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41102 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeKCTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id e22-v6so2149932pfn.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQSE4iVIjSLPAOzYcXE68LFT+STvGBf+GZnuz/7y4Xw=;
        b=TOiwM0JMmbK7vtIijOmnwYjzx5D0EO0nsNkW20gDvVyOOCaIW5ZhYSXiZZYkjMvrYI
         Agu7/3Kc95wzAAnUQpz9Y0v9crxF/nSY4hBE2wxuYkgYCvxSHuasR8Zc2KEq6hgZFTBo
         5J9ETI5UpaiEK0hDKxKP0ZAJlAQdk413N5A/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQSE4iVIjSLPAOzYcXE68LFT+STvGBf+GZnuz/7y4Xw=;
        b=UZGh/mprTafHwBrlo5YS8OKTv9wxdS7wrkNn58f+czeQkhJwW2n8NC2NVt3rQ0j3N8
         Y3P5gb6SKetul4SwZT3Pv18pydYgmY0eIrFrlu+8qgBOLyEs40ZurYAb8gJmMVeHUZwo
         B07PMx89VjRlXjBwxPjpN04F765+JUNyKWB6b9rBhYkJhdqETVJQnzBvXd4UleLf4xEl
         ADneRhTndF+nkHWu/38VjPndTPcJ4HVmVEVukRRD/sgTzQ44L9FwJYhPQWCG7tFHZLlG
         6BtWLF1/7FZKRgXIz8NDtNPRqyXsZi2916RaTo/JKztvMyknebnzleUWm7c/Wotv9tAe
         9AQw==
X-Gm-Message-State: AGRZ1gLzz+aQckY9QFNSxidVVz0sR1EDwZhlt3w3cW7QrJQ7cWlFCQcm
        IiBNIUN08cthtQW49YuTA/2MDg==
X-Google-Smtp-Source: AJdET5cNgvDVUuusDs+G7JmDnvpBakvSWoLJPbtp4UZaeGzbvI4QqSOFKMxQqLsfpjQbsY3XHlx7Ug==
X-Received: by 2002:a62:5d89:: with SMTP id n9-v6mr15519867pfj.54.1541239806197;
        Sat, 03 Nov 2018 03:10:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:10:05 -0700 (PDT)
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
Subject: [PATCH 06/10] drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
Date:   Sat,  3 Nov 2018 15:38:56 +0530
Message-Id: <20181103100900.30313-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 4-lane, burst mode panels would need to enable 2byte trail_fill
along with filling trail_env in dsi base control register.

Similar reference code avialable in BSP
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index b18a01361f11..2d34e5f48d29 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -33,6 +33,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -424,6 +426,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3

