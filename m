Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C4BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC5A2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1V/+lTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC5A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJZG4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:56:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34454 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbeJZG4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:56:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so4692782pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10BVyy4o/nnNTuseCYU3plL0bCCn/tw0RLzPJVkyKRc=;
        b=H1V/+lTJrK3gkHL0ufphYEaj9kDUJRpjDlzionDcUCrYXR7w1M3yueNz9qO6Zwh0WY
         AvTHZlduNw6sA+bZXTwnKkvpybZxA6c5x4UUvoEQ16edaxAo5yOIHff3gEYFWAWdZ5Db
         xZnAYanMKM6R/ZGRiVkKDc/y+W5eY/PiOmjUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10BVyy4o/nnNTuseCYU3plL0bCCn/tw0RLzPJVkyKRc=;
        b=gSD2RtiIn7JPBJup+Z5riX3JLMGpVkA/6NqZz0r7121OqPxWvVCK3IgQwGHJCZENiD
         yH29Wg/xI15+W9cZCDZvhybkx5JRCIU5PUiNCvwcWWTWRyDhytyfpIcmGPYSnjrFXkZH
         tEPYYHYfn7RyIM5nF8SSvBwswoepnkNV9AsDKt/p8sTbTAqFIy2l9+BGgGxxA6diO7iV
         ugRPuTPZuSjTIdB+mxYEHw3695WjExCxfw8elEh6465jsbr2BkBiwfW3Ke4YNYYKkxAp
         jJcfMj9T/hVWDjrjxlXzH7P5GN3QHGDBpVi1VBSxzjDmutQmxhKkJrMJmpoPD5s4qP2s
         ZVTQ==
X-Gm-Message-State: AGRZ1gLe/0hGse8HEOZgKeIEKaCuFLVugMDUdzKnXRJdbBDjNEuYb8Js
        zq13S6x2l1jbsm5RRT12VpRZam1UZHU=
X-Google-Smtp-Source: AJdET5csPAFX3Wdl3ImPp9rZFIaCrBRRhRyvL2msAO6v/HOlJAYTLREkM+CllxyyPYDoCrpHlM9Rtw==
X-Received: by 2002:a63:455e:: with SMTP id u30-v6mr944989pgk.30.1540506134690;
        Thu, 25 Oct 2018 15:22:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id x73-v6sm19813778pfk.139.2018.10.25.15.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 15:22:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1
Date:   Thu, 25 Oct 2018 15:21:34 -0700
Message-Id: <20181025222134.174583-6-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025222134.174583-1-dianders@chromium.org>
References: <20181025222134.174583-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I can tell the panel that was added in commit da50bd4258db
("drm/panel: simple: Add Innolux TV123WAM panel driver support")
wasn't actually an Innolux TV123WAM but was actually an Innolux
P120ZDG-BF1.

As far as I can tell the Innolux TV123WAM isn't a real panel and but
it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
Let's unmosh.

Here's my evidence:

* Searching for TV123WAM on the Internet turns up a TI panel.  While
  it's possible that an Innolux panel has the same model number as the
  TI Panel, it seems a little doubtful.  Looking up the datasheet from
  the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.

* As far as I know, the patch adding the Innolux Panel was supposed to
  be for the board that's sitting in front of me as I type this
  (support for that board is not yet upstream).  On the back of that
  panel I see Innolux P120ZDZ-EZ1 rev B1.

* Someone pointed me at a datasheet that's supposed to be for the
  panel in front of me (sorry, I can't share the datasheet).  That
  datasheet has the string "p120zdg-bf1"

* If I search for "P120ZDG-BF1" on the Internet I get hits for panels
  that are 2160x1440.  They don't have datasheets, but the fact that
  the resolution matches is a good sign.

In any case, let's update the name and also the physical size to match
the correct panel.

Fixes: da50bd4258db ("drm/panel: simple: Add Innolux TV123WAM panel driver support")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Cc: Sandeep Panda <spanda@codeaurora.org>
---

Changes in v2: None

 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 88592f9a0018..a04ffb3b2174 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1373,7 +1373,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
 	},
 };
 
-static const struct drm_display_mode innolux_tv123wam_mode = {
+static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
 	.clock = 206016,
 	.hdisplay = 2160,
 	.hsync_start = 2160 + 48,
@@ -1387,13 +1387,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
 	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
-static const struct panel_desc innolux_tv123wam = {
-	.modes = &innolux_tv123wam_mode,
+static const struct panel_desc innolux_p120zdg_bf1 = {
+	.modes = &innolux_p120zdg_bf1_mode,
 	.num_modes = 1,
 	.bpc = 8,
 	.size = {
-		.width = 259,
-		.height = 173,
+		.width = 254,
+		.height = 169,
 	},
 	.delay = {
 		.hpd_absent_delay = 200,
@@ -2456,8 +2456,8 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "innolux,n156bge-l21",
 		.data = &innolux_n156bge_l21,
 	}, {
-		.compatible = "innolux,tv123wam",
-		.data = &innolux_tv123wam,
+		.compatible = "innolux,p120zdg-bf1",
+		.data = &innolux_p120zdg_bf1,
 	}, {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
-- 
2.19.1.568.g152ad8e336-goog

