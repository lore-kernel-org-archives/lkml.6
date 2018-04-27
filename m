Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759123AbeD0RCZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:02:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:53190 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758866AbeD0Q5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:57:32 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 04/11] drm: rcar-du: Allow DU groups to work with hardware indexing
Date: Fri, 27 Apr 2018 17:57:15 +0100
Message-Id: <20180427165722.19445-5-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180427165722.19445-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The group objects assume linear indexing, and more so always assume that
channel 0 of any active group is used.

Now that the CRTC objects support non-linear indexing, adapt the groups
to remove assumptions that channel 0 is utilised in each group by using
the channel mask provided in the device structures.

Finally ensure that the RGB routing is determined from the index of the
CRTC object (which represents the hardware DU channel index).

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---
v2:
 - channel_mask -> channels_mask
---
 drivers/gpu/drm/rcar-du/rcar_du_group.c | 14 +++++++++-----
 drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 ++
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   |  5 ++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index eead202c95c7..d539cb290a35 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -46,9 +46,12 @@ void rcar_du_group_write(struct rcar_du_group *rgrp, u32 reg, u32 data)
 
 static void rcar_du_group_setup_pins(struct rcar_du_group *rgrp)
 {
-	u32 defr6 = DEFR6_CODE | DEFR6_ODPM02_DISP;
+	u32 defr6 = DEFR6_CODE;
 
-	if (rgrp->num_crtcs > 1)
+	if (rgrp->channels_mask & BIT(0))
+		defr6 |= DEFR6_ODPM02_DISP;
+
+	if (rgrp->channels_mask & BIT(1))
 		defr6 |= DEFR6_ODPM12_DISP;
 
 	rcar_du_group_write(rgrp, DEFR6, defr6);
@@ -80,10 +83,11 @@ static void rcar_du_group_setup_defr8(struct rcar_du_group *rgrp)
 		 * On Gen3 VSPD routing can't be configured, but DPAD routing
 		 * needs to be set despite having a single option available.
 		 */
-		u32 crtc = ffs(possible_crtcs) - 1;
+		unsigned int rgb_crtc = ffs(possible_crtcs) - 1;
+		struct rcar_du_crtc *crtc = &rcdu->crtcs[rgb_crtc];
 
-		if (crtc / 2 == rgrp->index)
-			defr8 |= DEFR8_DRGBS_DU(crtc);
+		if (crtc->index / 2 == rgrp->index)
+			defr8 |= DEFR8_DRGBS_DU(crtc->index);
 	}
 
 	rcar_du_group_write(rgrp, DEFR8, defr8);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
index 5e3adc6b31b5..42105aedecc8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
@@ -25,6 +25,7 @@ struct rcar_du_device;
  * @dev: the DU device
  * @mmio_offset: registers offset in the device memory map
  * @index: group index
+ * @channels_mask: bitmask of populated DU channels in this group
  * @num_crtcs: number of CRTCs in this group (1 or 2)
  * @use_count: number of users of the group (rcar_du_group_(get|put))
  * @used_crtcs: number of CRTCs currently in use
@@ -39,6 +40,7 @@ struct rcar_du_group {
 	unsigned int mmio_offset;
 	unsigned int index;
 
+	unsigned int channels_mask;
 	unsigned int num_crtcs;
 	unsigned int use_count;
 	unsigned int used_crtcs;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index dae47c856400..28f0173e1c2d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -598,7 +598,10 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		rgrp->dev = rcdu;
 		rgrp->mmio_offset = mmio_offsets[i];
 		rgrp->index = i;
-		rgrp->num_crtcs = min(rcdu->num_crtcs - 2 * i, 2U);
+		/* Extract the channel mask for this group only. */
+		rgrp->channels_mask = (rcdu->info->channels_mask >> (2 * i))
+				   & GENMASK(1, 0);
+		rgrp->num_crtcs = hweight8(rgrp->channels_mask);
 
 		/*
 		 * If we have more than one CRTCs in this group pre-associate
-- 
2.17.0
