Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeBTNBj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:01:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbeBTNBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:01:33 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/rockchip: Don't use spin_lock_irqsave in interrupt context
Date: Tue, 20 Feb 2018 13:01:20 +0000
Message-Id: <20180220130120.5254-4-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220130120.5254-1-marc.zyngier@arm.com>
References: <20180220130120.5254-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip DRM driver is quite careful to disable interrupts
when taking a lock that is also taken in interrupt context,
which is a good thing.

What is a bit over the top is to use spin_lock_irqsave when
already in interrupt context, as you cannot take another
interrupt again, and disabling interrupt is just pure
overhead.

Switching to the non _irqsave version in interrupt context is
more logical, and less heavy handed.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index f2bde1c76bbe..48d27f6fb16d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1160,15 +1160,14 @@ static void vop_handle_vblank(struct vop *vop)
 {
 	struct drm_device *drm = vop->drm_dev;
 	struct drm_crtc *crtc = &vop->crtc;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm->event_lock, flags);
+	spin_lock(&drm->event_lock);
 	if (vop->event) {
 		drm_crtc_send_vblank_event(crtc, vop->event);
 		drm_crtc_vblank_put(crtc);
 		vop->event = NULL;
 	}
-	spin_unlock_irqrestore(&drm->event_lock, flags);
+	spin_unlock(&drm->event_lock);
 
 	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
 		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
@@ -1179,21 +1178,20 @@ static irqreturn_t vop_isr(int irq, void *data)
 	struct vop *vop = data;
 	struct drm_crtc *crtc = &vop->crtc;
 	uint32_t active_irqs;
-	unsigned long flags;
 	int ret = IRQ_NONE;
 
 	/*
 	 * interrupt register has interrupt status, enable and clear bits, we
 	 * must hold irq_lock to avoid a race with enable/disable_vblank().
 	*/
-	spin_lock_irqsave(&vop->irq_lock, flags);
+	spin_lock(&vop->irq_lock);
 
 	active_irqs = VOP_INTR_GET_TYPE(vop, status, INTR_MASK);
 	/* Clear all active interrupt sources */
 	if (active_irqs)
 		VOP_INTR_SET_TYPE(vop, clear, active_irqs, 1);
 
-	spin_unlock_irqrestore(&vop->irq_lock, flags);
+	spin_unlock(&vop->irq_lock);
 
 	/* This is expected for vop iommu irqs, since the irq is shared */
 	if (!active_irqs)
-- 
2.14.2
