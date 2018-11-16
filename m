Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2FC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D943C2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IHk+yUcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D943C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbeKQCw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:52:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42723 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390128AbeKQCw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:52:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so7181010pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xfw1G45o1zFW41lhUipKSvIxM7Mirg3j/ORexArSSOI=;
        b=IHk+yUcwy3Tn5b7VhPIG+abilk0SHU+XJTb+kQZB4JwjlIALKaSnSDFcFKT4Y1E5IS
         1/iepKrht5bJ0uOzBOX2bu81ePe+5Gduq0hdM7KgN7/DzCU1n7Lr85e7wS/OfmtfaeSM
         p/XcPpRXMqLoZ2JMGLUPoDpsvvfw/3Uce716Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xfw1G45o1zFW41lhUipKSvIxM7Mirg3j/ORexArSSOI=;
        b=c3Yo7Bt2Hwe4SWIE59GQ9lHaj1O8LCQowedLefqLHpIJ4uDX4Jeb3evxkLaqxKf8n3
         /eKZT+Tqkow0SN+IVIyJEHFActeWCjQUIMq1FU9i1X9eA0CFbjtREssvBslVfuFy2bwc
         LK84nPWsS2B71xMXf5IZCw9YhpCJVnwRAdrZIyQt2pHL3nUCac8tFarWhQf6fAkfcrPT
         /o9Omh1vnuHYp/ljokrAuCFChssMW0Ef1mcxnwWAZSjlnFtxpD3ndHHQ3bw3A5thOk4i
         14WPhAS/BmeBt28fnnjLdXPsr9iRYauq5mc7tPZ++mgHvN7HtQ3/gahNf3mChtZaVlud
         pgRw==
X-Gm-Message-State: AGRZ1gL0ovQ0EtjTYexFnO/XIFwlCE4XDRsIDVF3ngFUeK7TgM8KVfl7
        NeCOIh5nnBPSoZ+AfeD4QZJ4TQ==
X-Google-Smtp-Source: AJdET5eOeBxmHRxMRv1dqm7bRxnMebtegzdvCjb6YXE5S3cuHLbQKjZ7d6YXgTvk+/tMRQ0dVsu/Fw==
X-Received: by 2002:a62:6241:: with SMTP id w62-v6mr11758075pfb.69.1542386393003;
        Fri, 16 Nov 2018 08:39:53 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:39:52 -0800 (PST)
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 02/12] drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
Date:   Fri, 16 Nov 2018 22:09:06 +0530
Message-Id: <20181116163916.29621-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction loop selection would require before writing
loop number registers, so enable idle, LP11 bits on
loop selection register.

Reference code available in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

(dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
	3<<(4*DSI_INST_ID_DLY);

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 43ab7127d428..3ac002c4d8b3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -438,6 +438,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 {
 	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+		     DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
+		     DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
 		     SUN6I_DSI_INST_LOOP_NUM_N1(delay));
-- 
2.18.0.321.gffc6fa0e3

