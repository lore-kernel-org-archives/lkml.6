Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E17DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B3218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csrbOzkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeLZVFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:05:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeLZVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so14690639lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NRozyeLiWHpg/hx5SA4kgSLG5KuwqMNqVkRPL1Epp5c=;
        b=csrbOzkkAmJGLZwpYSApshe3oqsnut4F0JBShmOg+21FyjihWJOtoQ5DS/Nmk9N9jb
         J8lXNGu5u1qSMvYGugoXpLEwT2inM+fz5/3vKDt4/OlnxwM+Ho0wEFr6vFp+thCJwNIy
         f7DZowLmNitXVt3330athP67glRUVztHmHFmOjWeXAQJ4lq+hsq811L+rd+Ukj5Cw00C
         zcWvabWOLpEB9E/mVhOLeu7fQvONORJWtCEMdOC+hyeYST/KKKs37wLcdCx3rDpxTkcs
         vY/+bTg8rI4LAHJAK4scD+QZBNoEreIWNYB7QSUM5EHGHKXH/biOF/DF4r9g/KobNras
         1KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NRozyeLiWHpg/hx5SA4kgSLG5KuwqMNqVkRPL1Epp5c=;
        b=R+c56SFJgxI9NyK+WCq5b/8mcRbklCzv4k0OEJLHYBEwLy0xwkpasQgyY8jBmcMWDc
         +CtsZDYlPrqeptZdf+UcQFkYA4hALLdY+ZRbhfm8Kp2e9J0BpkpJWckStzArkO5WK4g7
         Ujtdg7/1jJzIBEdFhq63fM4eElmtm60GsIX3rGJwv8y4xdJBSbkojVfQxkfXaXfvtdSb
         7i2qh8MSsyWgSMO9h7hhKQ36xNiYOYsXAW0opcxRDqQY8laRHVGluXYNE2omu5Q+n11r
         Y+BhGkLGMYtp/3h0ffFQsdRroM9HJsrae5wTt1rEuq0nIJWimGPzDuVjx78Ogog9SXHD
         2afg==
X-Gm-Message-State: AA+aEWaNxy5Bql2FQ6uCWtjomu7d41LHiXMDAqRuWGIr9xaU4/DZKLb8
        ONdtm1d6klJgIZjEi/e7d6k=
X-Google-Smtp-Source: AFSGD/VC69C34X3ccV1MIOiiBWM+M3UK4GmcJ62tGLrx20s9n+6vx3QTUbFMrCyLGxnhMUHrSb8rlw==
X-Received: by 2002:a2e:5654:: with SMTP id k81-v6mr11762622ljb.48.1545858279261;
        Wed, 26 Dec 2018 13:04:39 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:38 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v1 4/7] drm: remove include of drmP.h from bridge/dw_hdmi.h
Date:   Wed, 26 Dec 2018 22:03:50 +0100
Message-Id: <20181226210353.13993-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing includes in dw_hdmi.h and
fix fallout in drivers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 4 ++++
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c              | 1 +
 include/drm/bridge/dw_hdmi.h                        | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 8f9c8a6b46de..c61ec4caaa84 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -8,6 +8,10 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+
 #include <drm/bridge/dw_hdmi.h>
 
 #include <sound/hdmi-codec.h>
diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
index 75490a3e0a2a..f5b07a2e3f59 100644
--- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #include <drm/bridge/dw_hdmi.h>
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index ccb5aa8468e0..b0218ee75a65 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -10,7 +10,10 @@
 #ifndef __DW_HDMI__
 #define __DW_HDMI__
 
-#include <drm/drmP.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_modes.h>
 
 struct dw_hdmi;
 
-- 
2.12.0

