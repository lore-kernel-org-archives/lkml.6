Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeBTNBb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:01:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42666 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbeBTNB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:01:29 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/rockchip: Clear all interrupts before requesting the IRQ
Date: Tue, 20 Feb 2018 13:01:18 +0000
Message-Id: <20180220130120.5254-2-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220130120.5254-1-marc.zyngier@arm.com>
References: <20180220130120.5254-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling request_irq() followed by disable_irq() is usually a bad idea,
specially if the interrupt can be pending, and you're not yet in a
position to handle it.

This is exactly what happens on my kevin system when rebooting in a
second kernel using kexec: Some interrupt is left pending from
the previous kernel, and we take it too early, before disable_irq()
could do anything.

Let's clear the pending interrupts as we initialize the HW, and move
the interrupt request after that point. This ensures that we're in
a sane state when the interrupt is requested.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ba7505292b78..7b224e08cbf1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1414,6 +1414,9 @@ static int vop_initial(struct vop *vop)
 	usleep_range(10, 20);
 	reset_control_deassert(ahb_rst);
 
+	VOP_INTR_SET_TYPE(vop, clear, INTR_MASK, 1);
+	VOP_INTR_SET_TYPE(vop, enable, INTR_MASK, 0);
+
 	memcpy(vop->regsbak, vop->regs, vop->len);
 
 	VOP_REG_SET(vop, misc, global_regdone_en, 1);
@@ -1569,17 +1572,9 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	mutex_init(&vop->vsync_mutex);
 
-	ret = devm_request_irq(dev, vop->irq, vop_isr,
-			       IRQF_SHARED, dev_name(dev), vop);
-	if (ret)
-		return ret;
-
-	/* IRQ is initially disabled; it gets enabled in power_on */
-	disable_irq(vop->irq);
-
 	ret = vop_create_crtc(vop);
 	if (ret)
-		goto err_enable_irq;
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -1590,13 +1585,19 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		goto err_disable_pm_runtime;
 	}
 
+	ret = devm_request_irq(dev, vop->irq, vop_isr,
+			       IRQF_SHARED, dev_name(dev), vop);
+	if (ret)
+		goto err_disable_pm_runtime;
+
+	/* IRQ is initially disabled; it gets enabled in power_on */
+	disable_irq(vop->irq);
+
 	return 0;
 
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 	vop_destroy_crtc(vop);
-err_enable_irq:
-	enable_irq(vop->irq); /* To balance out the disable_irq above */
 	return ret;
 }
 
-- 
2.14.2
