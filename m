Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC6C206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfAHOvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:51:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41360 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfAHOvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:51:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A0D68209EF; Tue,  8 Jan 2019 15:51:15 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5AC0F2078C;
        Tue,  8 Jan 2019 15:51:15 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 1/4] drm/vc4: Wait for display list synchronization when completing commit
Date:   Tue,  8 Jan 2019 15:50:53 +0100
Message-Id: <20190108145056.2276-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During an atomic commit, the HVS is configured with a display list
for the channel matching the associated CRTC. The Pixel Valve (CRTC)
and encoder are also configured for the new setup at that time.
While the Pixel Valve and encoder are reconfigured synchronously, the
HVS is only reconfigured after the display list address (DISPLIST) has
been updated to the current display list address (DISPLACTX), which is
the responsibility of the hardware.

The time frame during which the HVS is still running on its previous
configuration but the CRTC and encoder have been reconfigured already
can lead to a number of synchronization issues. They will eventually
cause errors reported on the FIFOs, such as underruns.

With underrun detection enabled (from Boris Brezillon's series), this
leads to unreliable underrun detection with random false positives.

To ensure a coherent state, wait for each enabled channel of the HVS
to synchronize its current display list address. This fixes the issue
of random underrun reporting on commits.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h  |  1 +
 drivers/gpu/drm/vc4/vc4_hvs.c  | 17 +++++++++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c  |  2 ++
 drivers/gpu/drm/vc4/vc4_regs.h |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index c24b078f0593..955f157f5ad0 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -772,6 +772,7 @@ void vc4_irq_reset(struct drm_device *dev);
 extern struct platform_driver vc4_hvs_driver;
 void vc4_hvs_dump_state(struct drm_device *dev);
 int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
+void vc4_hvs_sync_dlist(struct drm_device *dev);
 
 /* vc4_kms.c */
 int vc4_kms_load(struct drm_device *dev);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 5d8c749c9749..1ba60b8e0c2d 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -166,6 +166,23 @@ static int vc4_hvs_upload_linear_kernel(struct vc4_hvs *hvs,
 	return 0;
 }
 
+void vc4_hvs_sync_dlist(struct drm_device *dev)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < SCALER_CHANNELS_COUNT; i++) {
+		if (!(HVS_READ(SCALER_DISPCTRLX(i)) & SCALER_DISPCTRLX_ENABLE))
+			continue;
+
+		ret = wait_for(HVS_READ(SCALER_DISPLACTX(i)) ==
+			       HVS_READ(SCALER_DISPLISTX(i)), 1000);
+		WARN(ret, "Timeout waiting for channel %d display list sync\n",
+		     i);
+	}
+}
+
 static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 0490edb192a1..2d66a2b57a91 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -155,6 +155,8 @@ vc4_atomic_complete_commit(struct drm_atomic_state *state)
 
 	drm_atomic_helper_commit_hw_done(state);
 
+	vc4_hvs_sync_dlist(dev);
+
 	drm_atomic_helper_wait_for_flip_done(dev, state);
 
 	drm_atomic_helper_cleanup_planes(dev, state);
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 931088014272..50c653309aec 100644
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

