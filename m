Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E47C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C654218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgvaPnVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfAaT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36981 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbfAaT0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so3710825ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hSApVq0lkej11t7eOC2rQqaI8goDoIiswcuiFGx/tvU=;
        b=QgvaPnVUC3gXyCFmOuqMz2Zj++ySs3r6Xitszu+zcryUUGIZAh9DjMn9mKmbOtWMCF
         G7WaaEvdwL7/YHLANzq4YTnedANO89joDbUuGvNdQ7vz0MpLaJsWHCl/sPLXiZ+pHl73
         g57FrcZooGGRuKY+PJ9JV7M02/AmYqVrEq8jkTlBabrQoAtngtKngCJ5APLTXisQqiQp
         iQQrZVby5azd0FijVowqordsj3yjPR+BJPyt9LKk7gT91m3qJ27VHqwoYSXcg3xI8Mw6
         nvR/wEGy/+jDfLuvqSP3OfVFIFO+XfFUe670c1wdEKi4ECrnqv91Wjg1YoxgpBoZ1Yzd
         GbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=hSApVq0lkej11t7eOC2rQqaI8goDoIiswcuiFGx/tvU=;
        b=j8f3WsmEgxnT7KgPNDCmanJzFWXdeW5nRZhJrX2b73bN90tRbzVa5c1+XN8dtsQGjA
         PCDshA+Y8MDBU0mabcK6CWxu16lrtogMxvMJ71yRRD77IQEXB1iy38elOrCSUbsw3IxF
         3nyybv/80na5cftOQVYRlNkyLyrOrDpL3loaJFEVVAkK0oviJseXdfN/vvTCi/YGRyKP
         XJuH5N7ss1UvbKhxF13+A6rVaXcHqmyatX6abQXBJHI3eANmBA1JUjn4glGHn2NkCO2a
         XdToc0n3CG7ALBRpsGM3k0A6dFolEgU088+3kn6Zk2RSYnqR/SmW6mKiMzYmPr8z0JLT
         db4Q==
X-Gm-Message-State: AJcUuketkoXG8WH7lFf5bX9FjP8cNwqGGgSn9OfjLJ3VLqSo9McExmdu
        LWq6Bv4XwYpN7O1tw7KcoSU=
X-Google-Smtp-Source: ALg8bN7799Sk4oOdvvA0xmt8ZNxLjXhYdWZnB1wYCqN8mrw7JE38hWMsyImcmN06jYp0t2KMj5BtyQ==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr28561467lja.58.1548962805508;
        Thu, 31 Jan 2019 11:26:45 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:44 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 11/19] drm/panel: lvds: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:11 +0100
Message-Id: <20190131192619.9763-12-sam@ravnborg.org>
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
---
 drivers/gpu/drm/panel/panel-lvds.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 833aeb47065b..2aa0555f78ac 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -18,6 +18,7 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
@@ -81,8 +82,8 @@ static int panel_lvds_prepare(struct drm_panel *panel)
 
 		err = regulator_enable(lvds->supply);
 		if (err < 0) {
-			dev_err(lvds->dev, "failed to enable supply: %d\n",
-				err);
+			DRM_DEV_ERROR(lvds->dev,
+				      "failed to enable supply: %d\n", err);
 			return err;
 		}
 	}
@@ -154,14 +155,16 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 
 	ret = of_property_read_u32(np, "width-mm", &lvds->width);
 	if (ret < 0) {
-		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
-			np, "width-mm");
+		DRM_DEV_ERROR(lvds->dev,
+			      "%pOF: invalid or missing %s DT property\n",
+			      np, "width-mm");
 		return -ENODEV;
 	}
 	ret = of_property_read_u32(np, "height-mm", &lvds->height);
 	if (ret < 0) {
-		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
-			np, "height-mm");
+		DRM_DEV_ERROR(lvds->dev,
+			      "%pOF: invalid or missing %s DT property\n",
+			      np, "height-mm");
 		return -ENODEV;
 	}
 
@@ -169,8 +172,9 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 
 	ret = of_property_read_string(np, "data-mapping", &mapping);
 	if (ret < 0) {
-		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
-			np, "data-mapping");
+		DRM_DEV_ERROR(lvds->dev,
+			      "%pOF: invalid or missing %s DT property\n",
+			      np, "data-mapping");
 		return -ENODEV;
 	}
 
@@ -181,8 +185,9 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	} else if (!strcmp(mapping, "vesa-24")) {
 		lvds->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
 	} else {
-		dev_err(lvds->dev, "%pOF: invalid or missing %s DT property\n",
-			np, "data-mapping");
+		DRM_DEV_ERROR(lvds->dev,
+			      "%pOF: invalid or missing %s DT property\n",
+			      np, "data-mapping");
 		return -EINVAL;
 	}
 
@@ -213,8 +218,9 @@ static int panel_lvds_probe(struct platform_device *pdev)
 
 		if (ret != -ENODEV) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(lvds->dev, "failed to request regulator: %d\n",
-					ret);
+				DRM_DEV_ERROR(lvds->dev,
+					      "failed to request regulator: %d\n",
+					      ret);
 			return ret;
 		}
 
@@ -226,8 +232,8 @@ static int panel_lvds_probe(struct platform_device *pdev)
 						     GPIOD_OUT_LOW);
 	if (IS_ERR(lvds->enable_gpio)) {
 		ret = PTR_ERR(lvds->enable_gpio);
-		dev_err(lvds->dev, "failed to request %s GPIO: %d\n",
-			"enable", ret);
+		DRM_DEV_ERROR(lvds->dev, "failed to request %s GPIO: %d\n",
+			      "enable", ret);
 		return ret;
 	}
 
@@ -235,8 +241,8 @@ static int panel_lvds_probe(struct platform_device *pdev)
 						     GPIOD_OUT_HIGH);
 	if (IS_ERR(lvds->reset_gpio)) {
 		ret = PTR_ERR(lvds->reset_gpio);
-		dev_err(lvds->dev, "failed to request %s GPIO: %d\n",
-			"reset", ret);
+		DRM_DEV_ERROR(lvds->dev, "failed to request %s GPIO: %d\n",
+			      "reset", ret);
 		return ret;
 	}
 
-- 
2.12.0

