Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034713AbeEXWHJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:07:09 -0400
Received: from gloria.sntech.de ([95.129.55.99]:43056 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966031AbeEXWHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:07:03 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?=
        <enric.balletbo@collabora.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.co.uk>,
        Robin Murphy <robin.murphy@arm.com>, jcliang@chromium.org,
        xxm@rock-chips.com, tfiga@chromium.org,
        linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/rockchip: vop: fix irq disabled after vop driver probed
Date: Fri, 25 May 2018 00:06:39 +0200
Message-ID: <25470133.K8n9sLBzRS@diego>
In-Reply-To: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com>
References: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandy Huang <hjc@rock-chips.com>

The vop irq is shared between vop and iommu and irq probing in the
iommu driver moved to the probe function recently. This can in some
cases lead to a stall if the irq is triggered while the vop driver
still has it disabled.

But there is no real need to disable the irq, as the vop can simply
also track its enabled state and ignore irqs in that case.

So remove the enable/disable handling and add appropriate condition
to the irq handler.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
[added an actual commit message]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Hi Ezequiel,

this patch came from a discussion I had with Rockchip people over the
iommu changes and resulting issues back in april, but somehow was
forgotten and not posted to the lists. Correcting that now.

So removing the enable/disable voodoo on the shared interrupt is
the preferred way.

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 510cdf0..61493d4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)
 
 	spin_unlock(&vop->reg_lock);
 
-	enable_irq(vop->irq);
-
 	drm_crtc_vblank_on(crtc);
 
 	return 0;
@@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	vop_dsp_hold_valid_irq_disable(vop);
 
-	disable_irq(vop->irq);
-
 	vop->is_enabled = false;
 
 	/*
@@ -1168,6 +1164,13 @@ static irqreturn_t vop_isr(int irq, void *data)
 	int ret = IRQ_NONE;
 
 	/*
+	 * since the irq is shared with iommu, iommu irq is enabled before vop
+	 * enable, so before vop enable we do nothing.
+	 */
+	if (!vop->is_enabled)
+		return IRQ_NONE;
+
+	/*
 	 * interrupt register has interrupt status, enable and clear bits, we
 	 * must hold irq_lock to avoid a race with enable/disable_vblank().
 	*/
@@ -1586,9 +1588,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_disable_pm_runtime;
 
-	/* IRQ is initially disabled; it gets enabled in power_on */
-	disable_irq(vop->irq);
-
 	return 0;
 
 err_disable_pm_runtime:
-- 
2.7.4
