Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55DAC6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3462086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Nwjm6K6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfASSVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:21:52 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:35042 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfASSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oq8pbeodEGapo8/OP8tFkoTtqrzNU++EUaZZseNpc5k=; b=Nwjm6K6E/QhFkjAkUwngfyiEQ
        ZZXudGlhodfrpEVbaH9z6hBwE4a0dx98hN+2TqMiMV+f6kqPL1EzxXxZ2kOSDTT0S89y8MrCdpjL4
        KtQYaLsc/QY6QGOh2+60EotssY5tnsIinktmYk9xqAIS08s7vpJ11mL2nd6Mtzg1v827s=;
Received: from p200300ccfbfb41001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbfb:4100:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkvFU-0002M8-MY; Sat, 19 Jan 2019 19:21:40 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gkvFT-0002Sz-PD; Sat, 19 Jan 2019 19:21:39 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] drm/omap: panel-tpo-td028ttec1: add backlight support
Date:   Sat, 19 Jan 2019 19:21:30 +0100
Message-Id: <20190119182131.9341-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190119182131.9341-1-andreas@kemnade.info>
References: <20190119182131.9341-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel has a backlight, so fetch it from devicetree using the
as documented in panel-common.txt. It is implemented the same way as in
panel-dpi.c
This ensures the backlight is also disabled when the display is
turned off like when doing xset dpms force off.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c    | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index 7ddc8c574a61..f326ba9dcf62 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -35,6 +35,8 @@ struct panel_drv_data {
 
 	struct videomode vm;
 
+	struct backlight_device *backlight;
+
 	struct spi_device *spi_dev;
 };
 
@@ -268,6 +270,8 @@ static int td028ttec1_panel_enable(struct omap_dss_device *dssdev)
 
 	r |= jbt_ret_write_0(ddata, JBT_REG_DISPLAY_ON);
 
+	backlight_enable(ddata->backlight);
+
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 transfer_err:
@@ -283,6 +287,8 @@ static void td028ttec1_panel_disable(struct omap_dss_device *dssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
 
+	backlight_disable(ddata->backlight);
+
 	dev_dbg(dssdev->dev, "td028ttec1_panel_disable()\n");
 
 	jbt_ret_write_0(ddata, JBT_REG_DISPLAY_OFF);
@@ -321,6 +327,15 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s\n", __func__);
 
+	ddata = devm_kzalloc(&spi->dev, sizeof(*ddata), GFP_KERNEL);
+	if (ddata == NULL)
+		return -ENOMEM;
+
+	ddata->backlight = devm_of_find_backlight(&spi->dev);
+
+	if (IS_ERR(ddata->backlight))
+		return PTR_ERR(ddata->backlight);
+
 	spi->bits_per_word = 9;
 	spi->mode = SPI_MODE_3;
 
@@ -330,9 +345,6 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
 		return r;
 	}
 
-	ddata = devm_kzalloc(&spi->dev, sizeof(*ddata), GFP_KERNEL);
-	if (ddata == NULL)
-		return -ENOMEM;
 
 	dev_set_drvdata(&spi->dev, ddata);
 
-- 
2.11.0

