Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBTNBe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:01:34 -0500
Received: from foss.arm.com ([217.140.101.70]:42680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbeBTNBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:01:31 -0500
From: Marc Zyngier <marc.zyngier@arm.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/rockchip: Do not use memcpy for MMIO addresses
Date: Tue, 20 Feb 2018 13:01:19 +0000
Message-Id: <20180220130120.5254-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220130120.5254-1-marc.zyngier@arm.com>
References: <20180220130120.5254-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcpy is only meant to be used for memory, and only that.
MMIO accessors should be used to access MMIO regions, preferably
the ones that correspond to the size of the register accessed.

Let's convert the bulk register copy to writel/readl_relaxed,
which is the correct API.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 7b224e08cbf1..f2bde1c76bbe 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -528,7 +528,10 @@ static int vop_enable(struct drm_crtc *crtc)
 		goto err_disable_aclk;
 	}
 
-	memcpy(vop->regs, vop->regsbak, vop->len);
+	spin_lock(&vop->reg_lock);
+	for (i = 0; i < vop->len; i += 4)
+		writel_relaxed(vop->regsbak[i / 4], vop->regs + i);
+
 	/*
 	 * We need to make sure that all windows are disabled before we
 	 * enable the crtc. Otherwise we might try to scan from a destroyed
@@ -538,10 +541,9 @@ static int vop_enable(struct drm_crtc *crtc)
 		struct vop_win *vop_win = &vop->win[i];
 		const struct vop_win_data *win = vop_win->data;
 
-		spin_lock(&vop->reg_lock);
 		VOP_WIN_SET(vop, win, enable, 0);
-		spin_unlock(&vop->reg_lock);
 	}
+	spin_unlock(&vop->reg_lock);
 
 	vop_cfg_done(vop);
 
@@ -1417,7 +1419,8 @@ static int vop_initial(struct vop *vop)
 	VOP_INTR_SET_TYPE(vop, clear, INTR_MASK, 1);
 	VOP_INTR_SET_TYPE(vop, enable, INTR_MASK, 0);
 
-	memcpy(vop->regsbak, vop->regs, vop->len);
+	for (i = 0; i < vop->len; i += sizeof(u32))
+		vop->regsbak[i / 4] = readl_relaxed(vop->regs + i);
 
 	VOP_REG_SET(vop, misc, global_regdone_en, 1);
 	VOP_REG_SET(vop, common, dsp_blank, 0);
-- 
2.14.2
