Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F95C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121A821903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 03:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oWelxNgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390915AbeLUDjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 22:39:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45640 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbeLUDjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 22:39:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so1831414pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 19:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bJ2V06NMTy+xKzXTskQidTBx2BRu4+3E8mCUEpdOR+s=;
        b=oWelxNgjhzxb9CH3SM9kmZLNNk3YZnTmvwzHlCduSXmLYSn5ysFLKCS/OAMvVzzQ41
         9UzPZHPRDEuRbDAS09VAIdYWRbb91zncq9Co8rwQsJlQIfoXqy7kj87Cmy0ybMXi000p
         2crPikdG69GrDRp6RQq7V9GI50XTuCZL0Z2Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bJ2V06NMTy+xKzXTskQidTBx2BRu4+3E8mCUEpdOR+s=;
        b=DsMpvnsSpM2iedb4TLGSi6jszvTra07ENzk6EepQ3r6LmeycD4z71nc3qrOajKALsG
         BspDreqxEgHtAqx/Pq3gPIcI0KLJS9jXlTxoClY6iNLfPf60iZdpcwbwv9XjAqpZ3rTj
         MpsbfcZRzdfW6Y2bXf5utwjlXgudOO1frfi+Sf4zuFe5rcABF7/nNEQcdyxg92SJuA2F
         ZzIJZmy/qZvpWQK2mYthZxQPDR0t0R1vBUv7Zy4ZWdlPn3on7HWz4oc1CuogL0/18Pre
         4d0vMKWrN1REtsBqWbwenBUiTfiEto2QsrE8Cq0WBaB+kbiYeKBuDIejgN8tKIdMs74W
         owRQ==
X-Gm-Message-State: AJcUukfwNvtLa1GiadxI7haZripbGTtpcn2M4zrqVHIynelYG4nub+st
        bkMNdg6pXEwu2JCjeY2efT2a1A==
X-Google-Smtp-Source: ALg8bN7APAmFGqjomZcpt/9bqbSIfcH852JAUIrOH7tvP7UpwbiMu8MQJtgnZ0perF/JjfgCCrVlQg==
X-Received: by 2002:a63:451a:: with SMTP id s26mr852194pga.150.1545363592366;
        Thu, 20 Dec 2018 19:39:52 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id v184sm32063902pfb.182.2018.12.20.19.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 19:39:51 -0800 (PST)
From:   "Hsin-Yi, Wang" <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] panel-innolux: set display off in innolux_panel_unprepare
Date:   Fri, 21 Dec 2018 11:39:25 +0800
Message-Id: <20181221033925.42179-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mipi_dsi_dcs_set_display_off() from innolux_panel_disable()
to innolux_panel_unprepare(), so they are consistent with
innolux_panel_enable() and innolux_panel_prepare().

This also fixes some mode check and irq timeout issue in MTK dsi code.

Since some dsi code (e.g. mtk_dsi) have following call trace:
1. drm_panel_disable(), which calls innolux_panel_disable()
2. switch to cmd mode
3. drm_panel_unprepare(), which calls innolux_panel_unprepare()

However, mtk_dsi needs to be in cmd mode to be able to send commands
(e.g. mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_enter_sleep_mode()),
so we need these functions to be called after the switch to cmd mode happens,
i.e. in innolux_panel_unprepare.


Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index ca4ae45dd307..8e5724b63f1f 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -70,18 +70,12 @@ static inline struct innolux_panel *to_innolux_panel(struct drm_panel *panel)
 static int innolux_panel_disable(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err;
 
 	if (!innolux->enabled)
 		return 0;
 
 	backlight_disable(innolux->backlight);
 
-	err = mipi_dsi_dcs_set_display_off(innolux->link);
-	if (err < 0)
-		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
-			      err);
-
 	innolux->enabled = false;
 
 	return 0;
@@ -95,6 +89,11 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	if (!innolux->prepared)
 		return 0;
 
+	err = mipi_dsi_dcs_set_display_off(innolux->link);
+	if (err < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      err);
+
 	err = mipi_dsi_dcs_enter_sleep_mode(innolux->link);
 	if (err < 0) {
 		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
-- 
2.18.1

