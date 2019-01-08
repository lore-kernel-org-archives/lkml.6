Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380CC206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfAHOvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:51:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41369 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfAHOvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:51:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E2B0E20A08; Tue,  8 Jan 2019 15:51:15 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 935A7206DC;
        Tue,  8 Jan 2019 15:51:15 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 2/4] drm/vc4: Report underrun errors
Date:   Tue,  8 Jan 2019 15:50:54 +0100
Message-Id: <20190108145056.2276-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

The DRM framework provides a generic way to report underrun errors.
Let's implement the necessary hooks to support it in the VC4 driver.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v3:
- Generic underrun report function has been dropped, adjust the
  code accordingly

Changes in v2:
- New patch
---
 drivers/gpu/drm/vc4/vc4_debugfs.c |  1 +
 drivers/gpu/drm/vc4/vc4_drv.h     | 10 ++++
 drivers/gpu/drm/vc4/vc4_hvs.c     | 87 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c     |  4 ++
 drivers/gpu/drm/vc4/vc4_regs.h    | 46 ++++------------
 5 files changed, 113 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 7a0003de71ab..64021bcba041 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -23,6 +23,7 @@ static const struct drm_info_list vc4_debugfs_list[] = {
 	{"vec_regs", vc4_vec_debugfs_regs, 0},
 	{"txp_regs", vc4_txp_debugfs_regs, 0},
 	{"hvs_regs", vc4_hvs_debugfs_regs, 0},
+	{"hvs_underrun",  vc4_hvs_debugfs_underrun, 0},
 	{"crtc0_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)0},
 	{"crtc1_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)1},
 	{"crtc2_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)2},
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 955f157f5ad0..619fb8bec428 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -184,6 +184,13 @@ struct vc4_dev {
 	/* Bitmask of the current bin_alloc used for overflow memory. */
 	uint32_t bin_alloc_overflow;
 
+	/* Incremented when an underrun error happened after an atomic commit.
+	 * This is particularly useful to detect when a specific modeset is too
+	 * demanding in term of memory or HVS bandwidth which is hard to guess
+	 * at atomic check time.
+	 */
+	atomic_t underrun;
+
 	struct work_struct overflow_mem_work;
 
 	int power_refcount;
@@ -773,6 +780,9 @@ extern struct platform_driver vc4_hvs_driver;
 void vc4_hvs_dump_state(struct drm_device *dev);
 int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
 void vc4_hvs_sync_dlist(struct drm_device *dev);
+int vc4_hvs_debugfs_underrun(struct seq_file *m, void *unused);
+void vc4_hvs_unmask_underrun(struct drm_device *dev);
+void vc4_hvs_mask_underrun(struct drm_device *dev);
 
 /* vc4_kms.c */
 int vc4_kms_load(struct drm_device *dev);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 1ba60b8e0c2d..3095fad2ff8b 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -22,6 +22,7 @@
  * each CRTC.
  */
 
+#include <drm/drm_atomic_helper.h>
 #include <linux/component.h>
 #include "vc4_drv.h"
 #include "vc4_regs.h"
@@ -102,6 +103,18 @@ int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused)
 
 	return 0;
 }
+
+int vc4_hvs_debugfs_underrun(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	drm_printf(&p, "%d\n", atomic_read(&vc4->underrun));
+
+	return 0;
+}
 #endif
 
 /* The filter kernel is composed of dwords each containing 3 9-bit
@@ -183,6 +196,62 @@ void vc4_hvs_sync_dlist(struct drm_device *dev)
 	}
 }
 
+void vc4_hvs_mask_underrun(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 dispctrl = HVS_READ(SCALER_DISPCTRL);
+
+	dispctrl &= ~(SCALER_DISPCTRL_DSPEISLUR(0) |
+		      SCALER_DISPCTRL_DSPEISLUR(1) |
+		      SCALER_DISPCTRL_DSPEISLUR(2));
+
+	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
+}
+
+void vc4_hvs_unmask_underrun(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 dispctrl = HVS_READ(SCALER_DISPCTRL);
+
+	dispctrl |= SCALER_DISPCTRL_DSPEISLUR(0) |
+		    SCALER_DISPCTRL_DSPEISLUR(1) |
+		    SCALER_DISPCTRL_DSPEISLUR(2);
+
+	HVS_WRITE(SCALER_DISPSTAT,
+		  SCALER_DISPSTAT_EUFLOW(0) |
+		  SCALER_DISPSTAT_EUFLOW(1) |
+		  SCALER_DISPSTAT_EUFLOW(2));
+	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
+}
+
+static void vc4_hvs_report_underrun(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	atomic_inc(&vc4->underrun);
+	DRM_DEV_ERROR(dev->dev, "HVS underrun\n");
+}
+
+static irqreturn_t vc4_hvs_irq_handler(int irq, void *data)
+{
+	struct drm_device *dev = data;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	u32 status;
+
+	status = HVS_READ(SCALER_DISPSTAT);
+
+	if (status &
+	    (SCALER_DISPSTAT_EUFLOW(0) | SCALER_DISPSTAT_EUFLOW(1) |
+	     SCALER_DISPSTAT_EUFLOW(2))) {
+		vc4_hvs_mask_underrun(dev);
+		vc4_hvs_report_underrun(dev);
+	}
+
+	HVS_WRITE(SCALER_DISPSTAT, status);
+
+	return status ? IRQ_HANDLED : IRQ_NONE;
+}
+
 static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -236,15 +305,33 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 	dispctrl = HVS_READ(SCALER_DISPCTRL);
 
 	dispctrl |= SCALER_DISPCTRL_ENABLE;
+	dispctrl |= SCALER_DISPCTRL_DSPEISLUR(0) | SCALER_DISPCTRL_DISPEIRQ(0) |
+		    SCALER_DISPCTRL_DSPEISLUR(1) | SCALER_DISPCTRL_DISPEIRQ(1) |
+		    SCALER_DISPCTRL_DSPEISLUR(2) | SCALER_DISPCTRL_DISPEIRQ(2);
 
 	/* Set DSP3 (PV1) to use HVS channel 2, which would otherwise
 	 * be unused.
 	 */
 	dispctrl &= ~SCALER_DISPCTRL_DSP3_MUX_MASK;
+	dispctrl &= ~(SCALER_DISPCTRL_DMAEIRQ |
+		      SCALER_DISPCTRL_SLVWREIRQ |
+		      SCALER_DISPCTRL_SLVRDEIRQ |
+		      SCALER_DISPCTRL_DSPEIEOF(0) |
+		      SCALER_DISPCTRL_DSPEIEOF(1) |
+		      SCALER_DISPCTRL_DSPEIEOF(2) |
+		      SCALER_DISPCTRL_DSPEIEOLN(0) |
+		      SCALER_DISPCTRL_DSPEIEOLN(1) |
+		      SCALER_DISPCTRL_DSPEIEOLN(2) |
+		      SCALER_DISPCTRL_SCLEIRQ);
 	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_DSP3_MUX);
 
 	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
 
+	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
+			       vc4_hvs_irq_handler, 0, "vc4 hvs", drm);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 2d66a2b57a91..a28e801aeae2 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -139,6 +139,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 	struct drm_device *dev = state->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 
+	vc4_hvs_mask_underrun(dev);
+
 	drm_atomic_helper_wait_for_fences(dev, state, false);
 
 	drm_atomic_helper_wait_for_dependencies(state);
@@ -157,6 +159,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 
 	vc4_hvs_sync_dlist(dev);
 
+	vc4_hvs_unmask_underrun(dev);
+
 	drm_atomic_helper_wait_for_flip_done(dev, state);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 50c653309aec..7e2692e9a83e 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -217,8 +217,6 @@
 #define SCALER_DISPCTRL                         0x00000000
 /* Global register for clock gating the HVS */
 # define SCALER_DISPCTRL_ENABLE			BIT(31)
-# define SCALER_DISPCTRL_DSP2EISLUR		BIT(15)
-# define SCALER_DISPCTRL_DSP1EISLUR		BIT(14)
 # define SCALER_DISPCTRL_DSP3_MUX_MASK		VC4_MASK(19, 18)
 # define SCALER_DISPCTRL_DSP3_MUX_SHIFT		18
 
@@ -226,45 +224,25 @@
  * SCALER_DISPSTAT_IRQDISP0.  Note that short frame contributions are
  * always enabled.
  */
-# define SCALER_DISPCTRL_DSP0EISLUR		BIT(13)
-# define SCALER_DISPCTRL_DSP2EIEOLN		BIT(12)
-# define SCALER_DISPCTRL_DSP2EIEOF		BIT(11)
-# define SCALER_DISPCTRL_DSP1EIEOLN		BIT(10)
-# define SCALER_DISPCTRL_DSP1EIEOF		BIT(9)
+# define SCALER_DISPCTRL_DSPEISLUR(x)		BIT(13 + (x))
 /* Enables Display 0 end-of-line-N contribution to
  * SCALER_DISPSTAT_IRQDISP0
  */
-# define SCALER_DISPCTRL_DSP0EIEOLN		BIT(8)
+# define SCALER_DISPCTRL_DSPEIEOLN(x)		BIT(8 + ((x) * 2))
 /* Enables Display 0 EOF contribution to SCALER_DISPSTAT_IRQDISP0 */
-# define SCALER_DISPCTRL_DSP0EIEOF		BIT(7)
+# define SCALER_DISPCTRL_DSPEIEOF(x)		BIT(7 + ((x) * 2))
 
 # define SCALER_DISPCTRL_SLVRDEIRQ		BIT(6)
 # define SCALER_DISPCTRL_SLVWREIRQ		BIT(5)
 # define SCALER_DISPCTRL_DMAEIRQ		BIT(4)
-# define SCALER_DISPCTRL_DISP2EIRQ		BIT(3)
-# define SCALER_DISPCTRL_DISP1EIRQ		BIT(2)
 /* Enables interrupt generation on the enabled EOF/EOLN/EISLUR
  * bits and short frames..
  */
-# define SCALER_DISPCTRL_DISP0EIRQ		BIT(1)
+# define SCALER_DISPCTRL_DISPEIRQ(x)		BIT(1 + (x))
 /* Enables interrupt generation on scaler profiler interrupt. */
 # define SCALER_DISPCTRL_SCLEIRQ		BIT(0)
 
 #define SCALER_DISPSTAT                         0x00000004
-# define SCALER_DISPSTAT_COBLOW2		BIT(29)
-# define SCALER_DISPSTAT_EOLN2			BIT(28)
-# define SCALER_DISPSTAT_ESFRAME2		BIT(27)
-# define SCALER_DISPSTAT_ESLINE2		BIT(26)
-# define SCALER_DISPSTAT_EUFLOW2		BIT(25)
-# define SCALER_DISPSTAT_EOF2			BIT(24)
-
-# define SCALER_DISPSTAT_COBLOW1		BIT(21)
-# define SCALER_DISPSTAT_EOLN1			BIT(20)
-# define SCALER_DISPSTAT_ESFRAME1		BIT(19)
-# define SCALER_DISPSTAT_ESLINE1		BIT(18)
-# define SCALER_DISPSTAT_EUFLOW1		BIT(17)
-# define SCALER_DISPSTAT_EOF1			BIT(16)
-
 # define SCALER_DISPSTAT_RESP_MASK		VC4_MASK(15, 14)
 # define SCALER_DISPSTAT_RESP_SHIFT		14
 # define SCALER_DISPSTAT_RESP_OKAY		0
@@ -272,23 +250,23 @@
 # define SCALER_DISPSTAT_RESP_SLVERR		2
 # define SCALER_DISPSTAT_RESP_DECERR		3
 
-# define SCALER_DISPSTAT_COBLOW0		BIT(13)
+# define SCALER_DISPSTAT_COBLOW(x)		BIT(5 + (((x) + 1) * 8))
 /* Set when the DISPEOLN line is done compositing. */
-# define SCALER_DISPSTAT_EOLN0			BIT(12)
+# define SCALER_DISPSTAT_EOLN(x)		BIT(4 + (((x) + 1) * 8))
 /* Set when VSTART is seen but there are still pixels in the current
  * output line.
  */
-# define SCALER_DISPSTAT_ESFRAME0		BIT(11)
+# define SCALER_DISPSTAT_ESFRAME(x)		BIT(3 + (((x) + 1) * 8))
 /* Set when HSTART is seen but there are still pixels in the current
  * output line.
  */
-# define SCALER_DISPSTAT_ESLINE0		BIT(10)
+# define SCALER_DISPSTAT_ESLINE(x)		BIT(2 + (((x) + 1) * 8))
 /* Set when the the downstream tries to read from the display FIFO
  * while it's empty.
  */
-# define SCALER_DISPSTAT_EUFLOW0		BIT(9)
+# define SCALER_DISPSTAT_EUFLOW(x)		BIT(1 + (((x) + 1) * 8))
 /* Set when the display mode changes from RUN to EOF */
-# define SCALER_DISPSTAT_EOF0			BIT(8)
+# define SCALER_DISPSTAT_EOF(x)			BIT(((x) + 1) * 8)
 
 /* Set on AXI invalid DMA ID error. */
 # define SCALER_DISPSTAT_DMA_ERROR		BIT(7)
@@ -300,12 +278,10 @@
  * SCALER_DISPSTAT_RESP_ERROR is not SCALER_DISPSTAT_RESP_OKAY.
  */
 # define SCALER_DISPSTAT_IRQDMA			BIT(4)
-# define SCALER_DISPSTAT_IRQDISP2		BIT(3)
-# define SCALER_DISPSTAT_IRQDISP1		BIT(2)
 /* Set when any of the EOF/EOLN/ESFRAME/ESLINE bits are set and their
  * corresponding interrupt bit is enabled in DISPCTRL.
  */
-# define SCALER_DISPSTAT_IRQDISP0		BIT(1)
+# define SCALER_DISPSTAT_IRQDISP(x)		BIT(1 + (x))
 /* On read, the profiler interrupt.  On write, clear *all* interrupt bits. */
 # define SCALER_DISPSTAT_IRQSCL			BIT(0)
 
-- 
2.20.1

