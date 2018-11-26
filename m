Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40082C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1D521479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnWOn091"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1D521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbeKZVxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbeKZVxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DBF21473;
        Mon, 26 Nov 2018 10:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229987;
        bh=JeYs4pU/f7LJ3j4g7eIq66ZHHfsomK3uDyMaJzeEtDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnWOn091QNZV1ZBv7Cd6MvTkDw9rfe0U5D8tjvJAIt6pmOd3yowJ9REtAnnmKM9iP
         5bwUYxK55XPFAF+uTxzBfwLxgUxhrFLSxb3lg1sbsKVGwnKZhrTJDN972B30soyMIy
         B5W2xr+ERKHolmTRsIsB0p3ZzXgbXjlZiBfUCRqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/62] Revert "drm/exynos/decon5433: implement frame counter"
Date:   Mon, 26 Nov 2018 11:51:09 +0100
Message-Id: <20181126105053.067192913@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



