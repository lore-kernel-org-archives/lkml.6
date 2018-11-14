Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400F920868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0SpdAFKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400F920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388958AbeKOIaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:30:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388944AbeKOIao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:30:44 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 402D022530;
        Wed, 14 Nov 2018 22:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234339;
        bh=7qD8qJ410/2mx5wfpPD7qk4XfpNCYCBgM6h0ckYRfg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SpdAFKx5PkT+jfcEbTXqD/979ghwoCtdSrRki50BHg8JL7Cqr74wRbyQKJbnN76T
         MKhL+SNSd9e/gEvvq7FaglA6bnjwl+KRT912/EkcPJty9LQ29JUisYaQK9KhTuscvk
         cPfHuAxSfquhJhGykbitwDQ7i7q75P0gY0ebkO+s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Inki Dae <inki.dae@samsung.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 13/27] Revert "drm/exynos/decon5433: implement frame counter"
Date:   Wed, 14 Nov 2018 17:25:02 -0500
Message-Id: <20181114222520.99926-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222520.99926-1-sashal@kernel.org>
References: <20181114222520.99926-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inki Dae <inki.dae@samsung.com>

[ Upstream commit 6ca469e22a30992b4478d2ab88737c70667c1e00 ]

This reverts commit 0586feba322e1de05075700eb4b835c8b683e62b

This patch makes it to need get_vblank_counter callback in crtc
to get frame counter from decon driver.

However, drm_dev->max_vblank_count is a member unique to
vendor's DRM driver but in case of ARM DRM, some CRTC devices
don't provide the frame counter value. As a result, this patch
made extension and clone mode not working.

Instead of this patch, we may need separated max_vblank_count
which belongs to each CRTC device, or need to implement frame
counter emulation for them who don't support HW frame counter.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c |  9 ---------
 drivers/gpu/drm/exynos/exynos_drm_crtc.c      | 11 -----------
 drivers/gpu/drm/exynos/exynos_drm_drv.h       |  1 -
 3 files changed, 21 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index f905c214fdd0..5a5b3535411f 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -160,13 +160,6 @@ static u32 decon_get_frame_count(struct decon_context *ctx, bool end)
 	return frm;
 }
 
-static u32 decon_get_vblank_counter(struct exynos_drm_crtc *crtc)
-{
-	struct decon_context *ctx = crtc->ctx;
-
-	return decon_get_frame_count(ctx, false);
-}
-
 static void decon_setup_trigger(struct decon_context *ctx)
 {
 	if (!ctx->crtc->i80_mode && !(ctx->out_type & I80_HW_TRG))
@@ -532,7 +525,6 @@ static const struct exynos_drm_crtc_ops decon_crtc_ops = {
 	.disable		= decon_disable,
 	.enable_vblank		= decon_enable_vblank,
 	.disable_vblank		= decon_disable_vblank,
-	.get_vblank_counter	= decon_get_vblank_counter,
 	.atomic_begin		= decon_atomic_begin,
 	.update_plane		= decon_update_plane,
 	.disable_plane		= decon_disable_plane,
@@ -550,7 +542,6 @@ static int decon_bind(struct device *dev, struct device *master, void *data)
 	int ret;
 
 	ctx->drm_dev = drm_dev;
-	drm_dev->max_vblank_count = 0xffffffff;
 
 	for (win = ctx->first_win; win < WINDOWS_NR; win++) {
 		int tmp = (win == ctx->first_win) ? 0 : win;
diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 6ce0821590df..4787560bf93e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -147,16 +147,6 @@ static void exynos_drm_crtc_disable_vblank(struct drm_crtc *crtc)
 		exynos_crtc->ops->disable_vblank(exynos_crtc);
 }
 
-static u32 exynos_drm_crtc_get_vblank_counter(struct drm_crtc *crtc)
-{
-	struct exynos_drm_crtc *exynos_crtc = to_exynos_crtc(crtc);
-
-	if (exynos_crtc->ops->get_vblank_counter)
-		return exynos_crtc->ops->get_vblank_counter(exynos_crtc);
-
-	return 0;
-}
-
 static const struct drm_crtc_funcs exynos_crtc_funcs = {
 	.set_config	= drm_atomic_helper_set_config,
 	.page_flip	= drm_atomic_helper_page_flip,
@@ -166,7 +156,6 @@ static const struct drm_crtc_funcs exynos_crtc_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank = exynos_drm_crtc_enable_vblank,
 	.disable_vblank = exynos_drm_crtc_disable_vblank,
-	.get_vblank_counter = exynos_drm_crtc_get_vblank_counter,
 };
 
 struct exynos_drm_crtc *exynos_drm_crtc_create(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index f8bae4cb4823..d228b5148dbc 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -133,7 +133,6 @@ struct exynos_drm_crtc_ops {
 	void (*disable)(struct exynos_drm_crtc *crtc);
 	int (*enable_vblank)(struct exynos_drm_crtc *crtc);
 	void (*disable_vblank)(struct exynos_drm_crtc *crtc);
-	u32 (*get_vblank_counter)(struct exynos_drm_crtc *crtc);
 	enum drm_mode_status (*mode_valid)(struct exynos_drm_crtc *crtc,
 		const struct drm_display_mode *mode);
 	int (*atomic_check)(struct exynos_drm_crtc *crtc,
-- 
2.17.1

