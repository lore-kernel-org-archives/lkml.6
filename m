Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeBLIxM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:53:12 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37994 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeBLIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:53:05 -0500
X-Google-Smtp-Source: AH8x227BPGJHLH7ngRLSmK5WeG110u//LcKvxHN2REy1QqZanf2kjLqwN+tBx6QORr1+TllbCEEkrQ==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: daniel.vetter@intel.com, gustavo@padovan.org, airlied@linux.ie,
        seanpaul@chromium.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 2/4] drm/mxsfb: Do not use deprecated drm_driver.{enable|disable)_vblank
Date: Mon, 12 Feb 2018 10:52:52 +0200
Message-Id: <1518425574-32671-3-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
References: <1518425574-32671-1-git-send-email-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Do not use deprecated drm_driver.{enable|disable)_vblank callbacks,
but use drm_simple_kms_helpe's pipe callbacks instead.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 54 ++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 1207ffe36250..5cae8db9dcd4 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -131,11 +131,37 @@ static int mxsfb_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
 	return drm_gem_fb_prepare_fb(&pipe->plane, plane_state);
 }
 
+static int mxsfb_pipe_enable_vblank(struct drm_simple_display_pipe *pipe)
+{
+	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+
+	/* Clear and enable VBLANK IRQ */
+	mxsfb_enable_axi_clk(mxsfb);
+	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
+	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
+	mxsfb_disable_axi_clk(mxsfb);
+
+	return 0;
+}
+
+static void mxsfb_pipe_disable_vblank(struct drm_simple_display_pipe *pipe)
+{
+	struct mxsfb_drm_private *mxsfb = drm_pipe_to_mxsfb_drm_private(pipe);
+
+	/* Disable and clear VBLANK IRQ */
+	mxsfb_enable_axi_clk(mxsfb);
+	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
+	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
+	mxsfb_disable_axi_clk(mxsfb);
+}
+
 static struct drm_simple_display_pipe_funcs mxsfb_funcs = {
 	.enable		= mxsfb_pipe_enable,
 	.disable	= mxsfb_pipe_disable,
 	.update		= mxsfb_pipe_update,
 	.prepare_fb	= mxsfb_pipe_prepare_fb,
+	.enable_vblank	= mxsfb_pipe_enable_vblank,
+	.disable_vblank	= mxsfb_pipe_disable_vblank,
 };
 
 static int mxsfb_load(struct drm_device *drm, unsigned long flags)
@@ -274,33 +300,11 @@ static void mxsfb_lastclose(struct drm_device *drm)
 	drm_fbdev_cma_restore_mode(mxsfb->fbdev);
 }
 
-static int mxsfb_enable_vblank(struct drm_device *drm, unsigned int crtc)
-{
-	struct mxsfb_drm_private *mxsfb = drm->dev_private;
-
-	/* Clear and enable VBLANK IRQ */
-	mxsfb_enable_axi_clk(mxsfb);
-	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
-	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_SET);
-	mxsfb_disable_axi_clk(mxsfb);
-
-	return 0;
-}
-
-static void mxsfb_disable_vblank(struct drm_device *drm, unsigned int crtc)
+static void mxsfb_irq_preinstall(struct drm_device *drm)
 {
 	struct mxsfb_drm_private *mxsfb = drm->dev_private;
 
-	/* Disable and clear VBLANK IRQ */
-	mxsfb_enable_axi_clk(mxsfb);
-	writel(CTRL1_CUR_FRAME_DONE_IRQ_EN, mxsfb->base + LCDC_CTRL1 + REG_CLR);
-	writel(CTRL1_CUR_FRAME_DONE_IRQ, mxsfb->base + LCDC_CTRL1 + REG_CLR);
-	mxsfb_disable_axi_clk(mxsfb);
-}
-
-static void mxsfb_irq_preinstall(struct drm_device *drm)
-{
-	mxsfb_disable_vblank(drm, 0);
+	mxsfb_pipe_disable_vblank(&mxsfb->pipe);
 }
 
 static irqreturn_t mxsfb_irq_handler(int irq, void *data)
@@ -333,8 +337,6 @@ static struct drm_driver mxsfb_driver = {
 	.irq_handler		= mxsfb_irq_handler,
 	.irq_preinstall		= mxsfb_irq_preinstall,
 	.irq_uninstall		= mxsfb_irq_preinstall,
-	.enable_vblank		= mxsfb_enable_vblank,
-	.disable_vblank		= mxsfb_disable_vblank,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
 	.dumb_create		= drm_gem_cma_dumb_create,
-- 
2.7.4
