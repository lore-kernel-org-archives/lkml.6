Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD2E2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="CgOQxGuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfBEGig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:38:36 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:56048 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfBEGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ixtXd3A7S8cs1XIloIyjhLexjPOytNDIeIZC/fQA2k=; b=CgOQxGuqGaZ7Vdh/O+32QxyMD
        w2QuIX2pN0JcY9AFfcm8xyUSbmsRmFuHZ+3l2XK1LcsjxSHYidG4M/EMzWoQYgoBlfLxtZLcxiFaM
        ip5cSg7b5xX8cOkauxcCFqeqa1GV62OrQ1jwkRrjPUubxfXfmmD2q48eOrC/Gd5bKFzac=;
Received: from hsvpn34.hotsplots.net ([176.74.57.181] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gquNF-0005Aa-Lo; Tue, 05 Feb 2019 07:38:25 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gquNE-0003sm-EL; Tue, 05 Feb 2019 07:38:24 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/2] drm/omap: panel-tpo-td028ttec1: add backlight support
Date:   Tue,  5 Feb 2019 07:38:12 +0100
Message-Id: <20190205063813.14873-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190205063813.14873-1-andreas@kemnade.info>
References: <20190205063813.14873-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel has a backlight, so fetch it from devicetree using the
corresponding property as documented in panel-common.txt. It is
implemented the same way as in panel-dpi.c
This ensures the backlight is also disabled when the display is
turned off like when doing xset dpms force off.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2: 
 - do not reorder initialisation
 - fix commit message

 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index 7ddc8c574a61..1db8740f3c21 100644
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
@@ -334,6 +340,10 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
 	if (ddata == NULL)
 		return -ENOMEM;
 
+	ddata->backlight = devm_of_find_backlight(&spi->dev);
+	if (IS_ERR(ddata->backlight))
+		return PTR_ERR(ddata->backlight);
+
 	dev_set_drvdata(&spi->dev, ddata);
 
 	ddata->spi_dev = spi;
-- 
2.11.0

