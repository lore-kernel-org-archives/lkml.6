Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0330C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B883D20684
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lcFeO38E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B883D20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390227AbeKQCx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:53:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42069 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390049AbeKQCx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:53:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so8680267pln.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrO967p/LnLVx88kJuV1gNk2tEKJ/CRJkfeL25hLlO0=;
        b=lcFeO38EkuHtEVZZxHqTYGwWbEsj+75OqWcZaVmAKsEwLbTfkmEcl5G5dj6Zw4K9ll
         t6NDSDov3dzCN2Kj1wgscpqPD9X341bZOTpz3LNAfnP4+kV8YWIfpzYMIDB33jxcq1LD
         pb3U3EH2Xx5jYwVBivKe39kFaNdYpW1wYAoG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrO967p/LnLVx88kJuV1gNk2tEKJ/CRJkfeL25hLlO0=;
        b=suuzu1k43+/OD1F0xUpoqGF+rIdFX4JE7XYosezr32MS04XsmcDGr+KokL4Z2P/dpH
         wbFmaazkbZXu6Mfh56Eap9lsD6cN5eawqRCvLTdK14ZU8yA79K1Uqsnz/DhCL/hikTBK
         SUFc+QOkTc2ATUXrhW5w9QokJ18Qzp3xAenyeB3jlTzSQfKji848QQNwxytQTaA/7PhZ
         DZ52qKZtTFIux3KuSomVW/dlG+rks7Syj5//2QEuopA7cRv7GIJD9R3d+sXlqOXwqU9K
         335mDxli+Oc1BcCR1O1Y0hLj8YMcZuaFyVbQdSLHfQB53W48CnJhkDpzzJ8DAnXTjI7M
         L1Fw==
X-Gm-Message-State: AGRZ1gIFjBCn95FbUqDd+TG1ubwnMqwueVFz9WFhPZfk91mkRsCdER1V
        M7bgJnk9sbiULoNqaHx4tjHpFQ==
X-Google-Smtp-Source: AJdET5erv9h7lRt09RuyLXuV0IN625iih7tW9lkD9ZmbQJ+pj6wI8ScTUsFiB7XriP8o+Rid3dmxmA==
X-Received: by 2002:a17:902:8608:: with SMTP id f8-v6mr11311783plo.95.1542386422513;
        Fri, 16 Nov 2018 08:40:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:40:22 -0800 (PST)
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
Subject: [PATCH v2 06/12] drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
Date:   Fri, 16 Nov 2018 22:09:10 +0530
Message-Id: <20181116163916.29621-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe tcon0 during dsi_bind, so-that the tcon attributes like
divider value, clock rate can get whenever it need.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index d60955880c43..66a01061e51d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -25,6 +25,7 @@
 #include <drm/drm_panel.h>
 
 #include "sun4i_drv.h"
+#include "sun4i_tcon.h"
 #include "sun6i_mipi_dsi.h"
 
 #include <video/mipi_display.h>
@@ -1007,6 +1008,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
 	int ret;
 
 	if (!dsi->panel)
@@ -1014,6 +1016,11 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->drv = drv;
 
+	if (!tcon0)
+		return -EPROBE_DEFER;
+
+	dsi->tcon = tcon0;
+
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 0df60f84bab3..3c532e83958d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -40,6 +40,7 @@ struct sun6i_dsi {
 
 	struct device		*dev;
 	struct sun4i_drv	*drv;
+	struct sun4i_tcon	*tcon;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
 	const struct sun6i_dsi_variant	*variant;
-- 
2.18.0.321.gffc6fa0e3

