Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93687ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482CF208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5EHPTFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482CF208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeJRRDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:03:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54586 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:03:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so4622394wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iQLz88+wZZd5cdAI+8Myn1hInALg31FoxZ/kx4qxmeo=;
        b=Q5EHPTFRuy9z1iFSXu0y04cOnASr0MNsXePi3ugnKuywxEUUSeEWNH5xClEelHQBld
         RfA3/EUnW4R75k03HRWkw/ZkFK8hYFbDZQIcMJgJ0YSxrzBwPeIAqBjG+0vkpFgRRYW7
         6E1yQk+RUmAcFjpXgOsffD/v0if5OG1RbxL14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQLz88+wZZd5cdAI+8Myn1hInALg31FoxZ/kx4qxmeo=;
        b=CTqR1yx7H6C61R5z1yZmKcwhP5lBj9sjNg6c5tymWYeJd8vqoQ1uRcrIKsIj53dx9A
         QfDPH2+dLBkY6La3G0bnGYr28T4oLvymgQTbTPMrrlpwlpV0gea7iDCLj+sOGq1FRwAl
         4u4aK0Euj1S+NFxxkTQhVTn1OuU3Oiz+QuSq+EI3hCeHqTZ4CEaDxIh42Ctwa8O2ZY9Y
         tf8rbGc6e+hOgKaCNlYX17XVzu7Xs4mgWtTfaeIGkWheckt7Fh9IzSGlRdb50kdysjAl
         0mIiVMI+uw6VgP+kJNvXAe6rpKDXdeZq2ehlicWVQl4JQT2fIHVRWVtIWSuMJpeI9ypV
         +gZg==
X-Gm-Message-State: ABuFfojHKqYSOqRqftR7CVXsvo7ny3L1XTPigPgOdD1Ae3e1ZGlLOOmU
        kRTe2Vc0+A7jHFpumMuS/RKZyqxVgf0=
X-Google-Smtp-Source: ACcGV63SDWxLoB0aE9amubRyJR5qA4YggW2IYRIRM+ufcYla05mdCohl7KBCXYgXACtqJBvdPWJM1g==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr6681129wmk.49.1539853421794;
        Thu, 18 Oct 2018 02:03:41 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:10d8:47c8:b43b:a5c:781c:87c3])
        by smtp.gmail.com with ESMTPSA id b71-v6sm5500775wma.13.2018.10.18.02.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 02:03:41 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v2] drm/sti: clean up after drm_atomic_helper_shutdown rework
Date:   Thu, 18 Oct 2018 11:03:32 +0200
Message-Id: <20181018090332.15141-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since drm_atomic_helper_shutdown() rework it is possible to do additional
clean up in sti driver: custom plane destroy functions become useless and
clean up encoder is no more needed.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
version 2:
- try to be more smart when unbinding tvout.

 drivers/gpu/drm/sti/sti_cursor.c |  9 +--------
 drivers/gpu/drm/sti/sti_gdp.c    |  9 +--------
 drivers/gpu/drm/sti/sti_hqvdp.c  |  9 +--------
 drivers/gpu/drm/sti/sti_tvout.c  | 24 ++++++++----------------
 4 files changed, 11 insertions(+), 40 deletions(-)

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
index ea4a3b87fa55..1a64bcad9630 100644
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
@@ -819,8 +804,15 @@ static void sti_tvout_unbind(struct device *dev, struct device *master,
 	void *data)
 {
 	struct sti_tvout *tvout = dev_get_drvdata(dev);
+	struct drm_device *drm_dev = data;
+	struct drm_encoder *encoder;
 
-	sti_tvout_destroy_encoders(tvout);
+	drm_for_each_encoder(encoder, drm_dev) {
+		drm_encoder_cleanup(encoder);
+	}
+	tvout->hdmi = NULL;
+	tvout->hda = NULL;
+	tvout->dvo = NULL;
 }
 
 static const struct component_ops sti_tvout_ops = {
-- 
2.15.0

