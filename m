Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9253BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580E12075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfBFOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:50:36 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:41483 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfBFOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:50:35 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2ADD1100007;
        Wed,  6 Feb 2019 14:50:30 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 3/4] drm/vc4: Detect and ignore underruns caused by out-of-sync dlists
Date:   Wed,  6 Feb 2019 15:49:05 +0100
Message-Id: <20190206144906.24304-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206144906.24304-1-paul.kocialkowski@bootlin.com>
References: <20190206144906.24304-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pipeline is reconfigured with a different mode, changes take
effect immediately for the CRTC and encoder while the HVS takes some
time to switch the active display list. This results in a period of
time where the pipeline is out of sync, that is very likely to cause
an underrun to be reported. Because the underrun is not related to the
new configuration, reporting it to userspace is a false positive.

Since this only concerns the first frame and we have no immediate fix
to avoid this situation, detect and work around it.

A helper is introduced to return whether the enabled display channels
have their display list in sync. This hint is set when unmasking the
underrun interrupt and it is updated in the interrupt itself.

With that, underrun reports that happen when the display list is out of
sync are ignored. The interrupt is kept enabled so that proper underrun
indications can be pick up as soon as the new display list takes over.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h  |  8 ++++++++
 drivers/gpu/drm/vc4/vc4_hvs.c  | 35 ++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index ea596791231d..a6ed55da0d10 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -192,6 +192,13 @@ struct vc4_dev {
 	 */
 	atomic_t underrun;
 
+	/* Stores whether the display lists were syncronized when unmasking the
+	 * underrun IRQ. This is used to skip underruns reported when the
+	 * pipeline was reconfigured but the previous display list is still
+	 * active.
+	 */
+	bool underrun_dlist_sync;
+
 	struct work_struct overflow_mem_work;
 
 	int power_refcount;
@@ -792,6 +799,7 @@ extern struct platform_driver vc4_hvs_driver;
 void vc4_hvs_dump_state(struct drm_device *dev);
 int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
 int vc4_hvs_debugfs_underrun(struct seq_file *m, void *unused);
+bool vc4_hvs_check_dlist_sync(struct drm_device *dev);
 void vc4_hvs_unmask_underrun(struct drm_device *dev);
 void vc4_hvs_mask_underrun(struct drm_device *dev);
 
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index d5bc3bcd3e51..53ba24aed8fd 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -179,6 +179,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_hvs *hvs,
 	return 0;
 }
 
+bool vc4_hvs_check_dlist_sync(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	unsigned int i;
+
+	for (i = 0; i < SCALER_CHANNELS_COUNT; i++) {
+		if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
+			continue;
+
+		if (HVS_READ(SCALER_DISPLACTX(i)) !=
+		    HVS_READ(SCALER_DISPLISTX(i)))
+			return false;
+	}
+
+	return true;
+}
+
 void vc4_hvs_mask_underrun(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
@@ -196,6 +213,9 @@ void vc4_hvs_unmask_underrun(struct drm_device *dev)
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	u32 dispctrl = HVS_READ(SCALER_DISPCTRL);
 
+	/* An underrun will occur when the display lists are out of sync. */
+	vc4->underrun_dlist_sync = vc4_hvs_check_dlist_sync(dev);
+
 	dispctrl |= SCALER_DISPCTRL_DSPEISLUR(0) |
 		    SCALER_DISPCTRL_DSPEISLUR(1) |
 		    SCALER_DISPCTRL_DSPEISLUR(2);
@@ -220,19 +240,30 @@ static irqreturn_t vc4_hvs_irq_handler(int irq, void *data)
 	struct drm_device *dev = data;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	irqreturn_t irqret = IRQ_NONE;
+	bool dlist_sync;
 	u32 status;
 
+	dlist_sync = vc4_hvs_check_dlist_sync(dev);
 	status = HVS_READ(SCALER_DISPSTAT);
 
 	if (status & (SCALER_DISPSTAT_EUFLOW(0) |
 		      SCALER_DISPSTAT_EUFLOW(1) |
 		      SCALER_DISPSTAT_EUFLOW(2))) {
-		vc4_hvs_mask_underrun(dev);
-		vc4_hvs_report_underrun(dev);
+		/* An underrun will be reported when the current display list
+		 * was not yet updated by the hardware to the requested one and
+		 * the other elements of the pipeline were already reconfigured.
+		 * Ignore it in that case.
+		 */
+		if (vc4->underrun_dlist_sync && dlist_sync) {
+			vc4_hvs_mask_underrun(dev);
+			vc4_hvs_report_underrun(dev);
+		}
 
 		irqret = IRQ_HANDLED;
 	}
 
+	vc4->underrun_dlist_sync = dlist_sync;
+
 	HVS_WRITE(SCALER_DISPSTAT, SCALER_DISPSTAT_IRQMASK(0) |
 				   SCALER_DISPSTAT_IRQMASK(1) |
 				   SCALER_DISPSTAT_IRQMASK(2));
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index e0834de8410f..c0c5fadaf7e3 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -212,6 +212,8 @@
 
 #define PV_HACT_ACT				0x30
 
+#define SCALER_CHANNELS_COUNT			3
+
 #define SCALER_DISPCTRL                         0x00000000
 /* Global register for clock gating the HVS */
 # define SCALER_DISPCTRL_ENABLE			BIT(31)
-- 
2.20.1

