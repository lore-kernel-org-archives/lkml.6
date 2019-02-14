Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23933222D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YR4mdKif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439798AbfBNTdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:33:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34193 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405793AbfBNTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:33:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id j18so3602022pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvbRbLJNQrsLfwewB47cDz1+x+w3diwoF9YMEG+Lj2w=;
        b=YR4mdKifcOd155tlUu0XmyU8rruftlI51Kjs+rpvMbzCLOanKN7+Zm5SEIYoSPn0AD
         OYiFaiLBugYD2TndvL1ZHsEL5XyHwzRSMZSscmrHyVCwbhah+TgL2n14TCXsgLQF6rzf
         X1Csi3MkYq4O1WgnGF2Ikw+VrM2Fn/wHPhGyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvbRbLJNQrsLfwewB47cDz1+x+w3diwoF9YMEG+Lj2w=;
        b=fJCLKcVWdRTSKfwquJcHHjLahOZiCGjkpQDkk15i/Lt88//Ud1OQzNkVjBX0OCODeW
         cZJNohf8D/BabhA6R7pfHiswn3sxMgiSD4V1mD9YyT07LGsfZlBOovagQVko1LhQLlFO
         TLpcehZZ+6a1Q5RK2OXKkUvhqgSVH5tRhDbk1Edhonx1mCYPNmcCc3rIQ8GyvBcmeaf/
         BSIV82OigCW3C2vpanSk78diLZIQ8OgvM+oIjoUr8QTfE+HxXk0llCKUusOdhBJASiUj
         +AUD/zvCAbj2SS23VOtOQNzFnh2Wgb0daSse4EXjovFsZJhYqJCz6t5uQvY8AcOVSaVH
         nlug==
X-Gm-Message-State: AHQUAub5AMbu2Vr9HOBWUVu1/us59BA4QK/k0GMqv56Kf2U1JOgnD3DU
        Ho01KuSuNWMnPlxSVW7KwEs3cw==
X-Google-Smtp-Source: AHgI3IaXLCw5eOUQoSanll7LQS8yH4nSacOv4VCAnqLTy0+Ye++cPlgHKZ8Fr/lYbgeuA/sqStqOcQ==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr5869683pfc.135.1550172784895;
        Thu, 14 Feb 2019 11:33:04 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id o23sm10808832pfa.140.2019.02.14.11.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:33:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 04/10] drm/sun4i: sun6i_mipi_dsi: Fix TCON DRQ set bits
Date:   Fri, 15 Feb 2019 01:02:31 +0530
Message-Id: <20190214193236.7504-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190214193236.7504-1-jagan@amarulasolutions.com>
References: <20190214193236.7504-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON DRQ for non-burst DSI mode can computed based on horizontal
front porch value, but the current driver trying to include sync
timings along with front porch resulting wrong drq.

This patch is trying to update the drq by subtracting hsync_start
with hdisplay, which is horizontal front porch.

Current code:
------------
mode->hsync_end - mode->hdisplay => horizontal front porch + sync

With this patch:
----------------
mode->hsync_start - mode->hdisplay => horizontal front porch

BSP code form BPI-M64-bsp is computing TCON DRQ set bits
for non-burts as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

=> panel->lcd_ht -    panel->lcd_x - panel->lcd_hbp
=> (timmings->hor_front_porch + panel->lcd_hbp + panel->lcd_x)
   - panel->lcd_x - panel->hbp
=> timmings->hor_front_porch
=> mode->hsync_start - mode->hdisplay

So, update the DRQ set bits accordingly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4362d9df1da6..a4360aed17bf 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -402,9 +402,9 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	struct mipi_dsi_device *device = dsi->device;
 	u32 val = 0;
 
-	if ((mode->hsync_end - mode->hdisplay) > 20) {
+	if ((mode->hsync_start - mode->hdisplay) > 20) {
 		/* Maaaaaagic */
-		u16 drq = (mode->hsync_end - mode->hdisplay) - 20;
+		u16 drq = (mode->hsync_start - mode->hdisplay) - 20;
 
 		drq *= mipi_dsi_pixel_format_to_bpp(device->format);
 		drq /= 32;
-- 
2.18.0.321.gffc6fa0e3

