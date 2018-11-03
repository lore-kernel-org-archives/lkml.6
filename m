Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C2FC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF432082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IuayEq9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF432082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeKCTUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33134 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeKCTUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so2148428pln.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YhcdTaqekiJ1IH3Njt5SqmOCHXO4U7AWqNWukgHaAi8=;
        b=IuayEq9Mi2zYv8/dp6myAo9m7HW6XJn0ek+T5xJ6m0nkYrh346GYdNIWNFp2wlsoW+
         nG7ilT87uzYUe003AtMPfKOhq56hL4iHBdRB8RXExUenLrWwfc6QqjmXv7t7rBgS3dw8
         XD2qsilVWkCmBRDz5lTRUtcThl+Ye3jaVioGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YhcdTaqekiJ1IH3Njt5SqmOCHXO4U7AWqNWukgHaAi8=;
        b=bzjEukjBs8mYZg225BOvNfF5y841PO27Tjas59bypXpD18/OKXldOfpKz9f0Dom3P4
         Pq8ss3rjhVZeVuoi9qVWM/i/H5i+1k9uILI9g+MfXd/ys4xdMuTTv2Fmg2wRiFQhbUux
         bDMDdKn99od+8euC7PQBKeby+kEc8vbQLa80VJb/JSFVcU82ygkunQ36rupLh7UgP1O7
         OpjrZXpLuvDWJEEggXrBE36HzpOzfdhxBHmj96e5XoU6e5EZ5b8yVw/UsCr0eF0oIN4L
         er9/tklnu1kzizsUTArmWo7CYXE/UXCFT+ONY/A7DNZWgAk2SJW5B4cJz6c5s8JP0UrB
         p8rQ==
X-Gm-Message-State: AGRZ1gKbrdEiH2X8I64jtxoNxTEsbaA2CchGXzG1M9clvJYDWXBCMQHE
        8zKaDAS0Eu8AlDIzljceUolAmQ==
X-Google-Smtp-Source: AJdET5fUxfrFit8SCslEnOy9JQ2bunA85HTt2862WrZQENW8wd5fo1Lk7lp2wBJKv5WizrufHateGA==
X-Received: by 2002:a17:902:a9c5:: with SMTP id b5-v6mr14826077plr.340.1541239776608;
        Sat, 03 Nov 2018 03:09:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:09:36 -0700 (PDT)
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
Subject: [PATCH 02/10] drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
Date:   Sat,  3 Nov 2018 15:38:52 +0530
Message-Id: <20181103100900.30313-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction loop selection would require before writing
loop number registers, so enable idle, LP11 bits on
loop selection register.

Reference code available in BSP
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
(dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
	3<<(4*DSI_INST_ID_DLY);

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index da152c21ec62..077b57ec964c 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -397,6 +397,10 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	u16 delay;
 
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+		     DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
+		     DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
+
 	if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST)
 		delay = (((mode->htotal - mode->hdisplay) * 150) /
 			((mode->clock / 1000) * 8)) - 50;
-- 
2.18.0.321.gffc6fa0e3

