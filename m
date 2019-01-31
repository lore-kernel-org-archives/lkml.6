Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C5DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E05D20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPzDhHkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfAaT0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38231 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfAaT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so3695029lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OzYRfWRAb2KKmOH22539kqwCxbsuO0TMethjfVC3960=;
        b=vPzDhHkL+hXDWyPoURwm9HjWrysQ0B181hztMuTK6vmVOBDlWmUo5I0obT/pGoidKe
         DTrk3kmVpeXTvKHaCJ1Y68e8fiN8HfPzKnJGGjD+/x8Ehlxr4Ve/mfqB7fzeSK7cArwJ
         iU2AVxRFjvFIf7xgpwos78BX7h4u3tpNrNYJIy+8CuvQeLUy9cfYGKC4mIu73CS3FenY
         XE1cYw1LxUUrKqPCx/wRJKiK+/pmzeMJU3sFCTyCGkO8HioUZbm7eD3xl5A2U9TBS7Oz
         qdGxohXacHM2jUM0n2sJD9r9W8RygtgtCD2EmZLnEyd4B2QYD7hIHd0wG0FsXV4DW3e8
         y1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OzYRfWRAb2KKmOH22539kqwCxbsuO0TMethjfVC3960=;
        b=V8l0xnB+NtyyZxd56q4Pa8KaTnL0+PGCHEpblt5G0t7DR26vSbIBCk2iPd5X8S7fkv
         QMVd6c5UNPF6/ZSdNVBJfNw+o3LPycp1JmYDLWEU8g9KsZbjoKitCAFRm6ftJtJ4PMwv
         7CaHgxvkaIlLa4MHocIysuHGAy4Aa7yhNU3w56qArw+QIeN+h/flChFIxymG+Oq0UqTK
         ivckwNTsrmzMn/FDf/oMDvIHdaxHStqrPAGBnMTw9A5t8wbDCOYSmvlMMzvQbl9Tl6EG
         kx2kY10iitY9vo7RC4Si74iFLvlWl49c75lIawYrfMTjsLFiNxziWmc6mP7NaIxzt+Gb
         F8Jg==
X-Gm-Message-State: AJcUukd1Wr/F99eUGV9W/Ngc0qAxErewKAvc7wTPucNqINSgYmf9Zx+p
        41Woa+j6QaC5uW18feVhzduGPu18
X-Google-Smtp-Source: ALg8bN45KWnidsp5HCyQUdvemX09JsTLKwEU/qZkRnSH4vJkmDcaO+cFabttcDuqZuT1vHRpp+VwWQ==
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr29289187ljc.131.1548962798638;
        Thu, 31 Jan 2019 11:26:38 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:38 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 04/19] drm/panel: arm-versatile: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:04 +0100
Message-Id: <20190131192619.9763-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/gpu/drm/panel/panel-arm-versatile.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index 0ed8ee4673eb..d7139b7aff7d 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -27,6 +27,7 @@
  */
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <linux/bitops.h>
 #include <linux/init.h>
@@ -233,7 +234,7 @@ static int versatile_panel_disable(struct drm_panel *panel)
 
 	/* If we're on an IB2 daughterboard, turn off display */
 	if (vpanel->ib2_map) {
-		dev_dbg(vpanel->dev, "disable IB2 display\n");
+		DRM_DEV_DEBUG(vpanel->dev, "disable IB2 display\n");
 		regmap_update_bits(vpanel->ib2_map,
 				   IB2_CTRL,
 				   IB2_CTRL_LCD_MASK,
@@ -249,7 +250,7 @@ static int versatile_panel_enable(struct drm_panel *panel)
 
 	/* If we're on an IB2 daughterboard, turn on display */
 	if (vpanel->ib2_map) {
-		dev_dbg(vpanel->dev, "enable IB2 display\n");
+		DRM_DEV_DEBUG(vpanel->dev, "enable IB2 display\n");
 		regmap_update_bits(vpanel->ib2_map,
 				   IB2_CTRL,
 				   IB2_CTRL_LCD_MASK,
@@ -300,12 +301,12 @@ static int versatile_panel_probe(struct platform_device *pdev)
 
 	parent = dev->parent;
 	if (!parent) {
-		dev_err(dev, "no parent for versatile panel\n");
+		DRM_DEV_ERROR(dev, "no parent for versatile panel\n");
 		return -ENODEV;
 	}
 	map = syscon_node_to_regmap(parent->of_node);
 	if (IS_ERR(map)) {
-		dev_err(dev, "no regmap for versatile panel parent\n");
+		DRM_DEV_ERROR(dev, "no regmap for versatile panel parent\n");
 		return PTR_ERR(map);
 	}
 
@@ -315,7 +316,7 @@ static int versatile_panel_probe(struct platform_device *pdev)
 
 	ret = regmap_read(map, SYS_CLCD, &val);
 	if (ret) {
-		dev_err(dev, "cannot access syscon regs\n");
+		DRM_DEV_ERROR(dev, "cannot access syscon regs\n");
 		return ret;
 	}
 
@@ -333,11 +334,11 @@ static int versatile_panel_probe(struct platform_device *pdev)
 
 	/* No panel detected or VGA, let's leave this show */
 	if (i == ARRAY_SIZE(versatile_panels)) {
-		dev_info(dev, "no panel detected\n");
+		DRM_DEV_INFO(dev, "no panel detected\n");
 		return -ENODEV;
 	}
 
-	dev_info(dev, "detected: %s\n", vpanel->panel_type->name);
+	DRM_DEV_INFO(dev, "detected: %s\n", vpanel->panel_type->name);
 	vpanel->dev = dev;
 	vpanel->map = map;
 
@@ -348,7 +349,8 @@ static int versatile_panel_probe(struct platform_device *pdev)
 		if (IS_ERR(vpanel->ib2_map))
 			vpanel->ib2_map = NULL;
 		else
-			dev_info(dev, "panel mounted on IB2 daughterboard\n");
+			DRM_DEV_INFO(dev,
+				     "panel mounted on IB2 daughterboard\n");
 	}
 
 	drm_panel_init(&vpanel->panel);
-- 
2.12.0

