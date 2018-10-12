Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6325B2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWGYq7d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6325B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeJLRSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:18:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38204 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbeJLRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:18:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so12255392wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SvUgnSZ7UmEYGPl6h1IzPsk3T6xbJ7bdK2bxRgd9mMs=;
        b=aWGYq7d52D0la3UVdYBpxYsXc7BHle8jlhcuF1CXtpQNe6m+Mk6vGjFyegcgc8toUn
         aHusziHV41bfKd1ln48jqgMvCaH9jXCibi25CjQXLz2Tip2DJ9j5bsM+a/LafbfdTVOv
         SAIMuJN3jk2efKuSWFbE3mP5JMZiT+g4DDIQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SvUgnSZ7UmEYGPl6h1IzPsk3T6xbJ7bdK2bxRgd9mMs=;
        b=sjfZ6xw5S/0rxnHjQ3YV9elEwBWq2Ahk5PXm/Rr4yM6dMSpq5aPdVKtAPXwePeIqna
         Ft00XTm+2sg/1wDv3Xad3WUZq5HL8Ulb9d80lWhCoTx2f+9oZsXG2MBE2D7vkZjfVpmD
         LdmhcGNAUu05sYtElJ7KZHA3X5vrNnWnLu+GclIQrFgWIbSyy49TTDZ2ONoq6y/nzFbY
         8WzKOz31QGYs06wHk3x+Dsuj2a4EL9rKH4uL8lFEkpTaE3fQM6Rhrfw7gSM5Iq4acOwP
         RVxcPcFOqftp68zAm4Aeio5+Vvc2A84/nzHinmvhSOrlRt+RwUNQVvet5cjZeDgheIeg
         QXlw==
X-Gm-Message-State: ABuFfoiXhloZNZVT9whPkQt5spFqI74ID2/X/ykiBFn3UIsKxIh1yzR6
        ugcdJU6UrLvOHaIsOHx6MaR/pw==
X-Google-Smtp-Source: ACcGV60Ghw5kkvAKMC+BjoV3OpArd3LUxwzAYv7XXjFT0KVJy0BD/pu9kiW1hxxSaA5tNr67BJbTCw==
X-Received: by 2002:a1c:ee0c:: with SMTP id m12-v6mr4860067wmh.112.1539337628088;
        Fri, 12 Oct 2018 02:47:08 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1087:9ad4:c93a:12ce:b821:38d7])
        by smtp.gmail.com with ESMTPSA id s7-v6sm8430203wmd.0.2018.10.12.02.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 02:47:07 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] drm/sti: clean up after drm_atomic_helper_shutdown rework
Date:   Fri, 12 Oct 2018 11:46:39 +0200
Message-Id: <20181012094639.1585-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
References: <20181012094639.1585-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since drm_atomic_helper_shutdown() rework it is possible to do additional
clean up in sti driver: custom plane destroy functions become useless and
clean up encoder is no more needed.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/sti/sti_cursor.c |  9 +--------
 drivers/gpu/drm/sti/sti_gdp.c    |  9 +--------
 drivers/gpu/drm/sti/sti_hqvdp.c  |  9 +--------
 drivers/gpu/drm/sti/sti_tvout.c  | 24 ------------------------
 4 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index bc908453ffb3..e1ba253055c7 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -328,13 +328,6 @@ static const struct drm_plane_helper_funcs sti_cursor_helpers_funcs = {
 	.atomic_disable = sti_cursor_atomic_disable,
 };
 
-static void sti_cursor_destroy(struct drm_plane *drm_plane)
-{
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_plane_cleanup(drm_plane);
-}
-
 static int sti_cursor_late_register(struct drm_plane *drm_plane)
 {
 	struct sti_plane *plane = to_sti_plane(drm_plane);
@@ -346,7 +339,7 @@ static int sti_cursor_late_register(struct drm_plane *drm_plane)
 static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = sti_cursor_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = sti_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 3c19614d3f75..87b50451afd7 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -879,13 +879,6 @@ static const struct drm_plane_helper_funcs sti_gdp_helpers_funcs = {
 	.atomic_disable = sti_gdp_atomic_disable,
 };
 
-static void sti_gdp_destroy(struct drm_plane *drm_plane)
-{
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_plane_cleanup(drm_plane);
-}
-
 static int sti_gdp_late_register(struct drm_plane *drm_plane)
 {
 	struct sti_plane *plane = to_sti_plane(drm_plane);
@@ -897,7 +890,7 @@ static int sti_gdp_late_register(struct drm_plane *drm_plane)
 static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = sti_gdp_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = sti_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 23565f52dd71..065a5b08a702 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1256,13 +1256,6 @@ static const struct drm_plane_helper_funcs sti_hqvdp_helpers_funcs = {
 	.atomic_disable = sti_hqvdp_atomic_disable,
 };
 
-static void sti_hqvdp_destroy(struct drm_plane *drm_plane)
-{
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_plane_cleanup(drm_plane);
-}
-
 static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
 {
 	struct sti_plane *plane = to_sti_plane(drm_plane);
@@ -1274,7 +1267,7 @@ static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
 static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = sti_hqvdp_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = sti_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index ea4a3b87fa55..4dc3b2ec40eb 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -788,21 +788,6 @@ static void sti_tvout_create_encoders(struct drm_device *dev,
 	tvout->dvo = sti_tvout_create_dvo_encoder(dev, tvout);
 }
 
-static void sti_tvout_destroy_encoders(struct sti_tvout *tvout)
-{
-	if (tvout->hdmi)
-		drm_encoder_cleanup(tvout->hdmi);
-	tvout->hdmi = NULL;
-
-	if (tvout->hda)
-		drm_encoder_cleanup(tvout->hda);
-	tvout->hda = NULL;
-
-	if (tvout->dvo)
-		drm_encoder_cleanup(tvout->dvo);
-	tvout->dvo = NULL;
-}
-
 static int sti_tvout_bind(struct device *dev, struct device *master, void *data)
 {
 	struct sti_tvout *tvout = dev_get_drvdata(dev);
@@ -815,17 +800,8 @@ static int sti_tvout_bind(struct device *dev, struct device *master, void *data)
 	return 0;
 }
 
-static void sti_tvout_unbind(struct device *dev, struct device *master,
-	void *data)
-{
-	struct sti_tvout *tvout = dev_get_drvdata(dev);
-
-	sti_tvout_destroy_encoders(tvout);
-}
-
 static const struct component_ops sti_tvout_ops = {
 	.bind	= sti_tvout_bind,
-	.unbind	= sti_tvout_unbind,
 };
 
 static int sti_tvout_probe(struct platform_device *pdev)
-- 
2.15.0

