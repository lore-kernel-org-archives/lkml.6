Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEADCC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1273820663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RvH9u8uJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1273820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeJWFJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:09:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34230 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbeJWFIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:08:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so14731755pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9Cvmd97hzPoKYeufhgQkK5oC81R8IRAXT0JDJr89KA=;
        b=RvH9u8uJARk1S44xEIRKxALSbovNo5XFmOshZSI9Jz2ni7dsraioZ2FNQzBoCJoMq2
         6MQCQiPmdRdzzAE3TXUqC9crY0TMaMxn/Sk50s30OYpCsbKc7Acjy41y20E1OGcYch6t
         94ub8/cDcN2D5pKDVCOhgdpK0d++dUwQVSvu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9Cvmd97hzPoKYeufhgQkK5oC81R8IRAXT0JDJr89KA=;
        b=a5sKFKO5gCG3WQhv6sNYquOHNMJOX51bqb8XQWUnUBIEAmwNE5tmkhZ3OJyu2gHodQ
         lyj10PQt8YSZcZsLOruNQbTzT0KkZnA0PneCM0zjpX3qJz2IvZ21EKuspBNO3OprkkpD
         jZZBhm+CZQ5zypH1sq+2JPJ/lNvOhnjz8lFlAbiMs11P2Fy6gxAiBUAuGZPu3uQwWtRB
         1Nv+jMDpYsXcqsb8an3wvFXMXMScwbPmUUOnNOoEC2DDtviaHPM2WD5nDl9NQKwa7v57
         wjFIJAulM8AAuIxkMxuoiNCxce8TN4ysX0c+qliH5ukW3u81GsKTfe6PudQkM9w+BM1j
         wo+w==
X-Gm-Message-State: ABuFfojcW/fdX5aNlqzCcZU06YxC0YUugqOkHSvcGRS/z93YCYWJLUIV
        x2g11RYrf/O0PwBAjEDFkMC2/w==
X-Google-Smtp-Source: ACcGV63rM84RHpSTX0awUvLQG8+SWYLJHFlF22qPDkaehSFieAHM/Mhx/O39fzpq3a4lNqfU8O6f1A==
X-Received: by 2002:a62:120b:: with SMTP id a11-v6mr46934708pfj.165.1540241325796;
        Mon, 22 Oct 2018 13:48:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id y144-v6sm47483001pfb.81.2018.10.22.13.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:48:45 -0700 (PDT)
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
Subject: [PATCH 5/6] drm/panel: simple: Innolux TV123WAM is actually P120ZDG-BF1
Date:   Mon, 22 Oct 2018 13:46:38 -0700
Message-Id: <20181022204639.8558-5-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181022204639.8558-1-dianders@chromium.org>
References: <20181022204639.8558-1-dianders@chromium.org>
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
Cc: Sandeep Panda <spanda@codeaurora.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 937e97490c30..7ee1abc5d81b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1370,7 +1370,7 @@ static const struct panel_desc innolux_n156bge_l21 = {
 	},
 };
 
-static const struct drm_display_mode innolux_tv123wam_mode = {
+static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
 	.clock = 206016,
 	.hdisplay = 2160,
 	.hsync_start = 2160 + 48,
@@ -1384,13 +1384,13 @@ static const struct drm_display_mode innolux_tv123wam_mode = {
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
 		.prepare = 200,
@@ -2454,8 +2454,8 @@ static const struct of_device_id platform_of_match[] = {
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

