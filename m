Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273322147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBTPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:52:12 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57201 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBTPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:52:10 -0500
X-Originating-IP: 90.88.23.190
Received: from localhost.localdomain (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 3DF42FF804;
        Wed, 20 Feb 2019 15:52:07 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v5 3/3] drm/vc4: Add a debugfs entry to disable/enable the load tracker
Date:   Wed, 20 Feb 2019 16:51:24 +0100
Message-Id: <20190220155124.25022-4-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220155124.25022-1-paul.kocialkowski@bootlin.com>
References: <20190220155124.25022-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to test whether the load tracker is working as expected, we
need the ability to compare the commit result with the underrun
indication. With the load tracker always enabled, commits that are
expected to trigger an underrun are always rejected, so userspace
cannot get the actual underrun indication from the hardware.

Add a debugfs entry to disable/enable the load tracker, so that a DRM
commit expected to trigger an underrun can go through with the load
tracker disabled. The underrun indication is then available to
userspace and can be checked against the commit result with the load
tracker enabled.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_debugfs.c | 9 +++++++++
 drivers/gpu/drm/vc4/vc4_drv.h     | 3 +++
 drivers/gpu/drm/vc4/vc4_kms.c     | 9 +++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 64021bcba041..59cdad89f844 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -36,6 +36,15 @@ static const struct drm_info_list vc4_debugfs_list[] = {
 int
 vc4_debugfs_init(struct drm_minor *minor)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(minor->dev);
+	struct dentry *dentry;
+
+	dentry = debugfs_create_bool("hvs_load_tracker", S_IRUGO | S_IWUSR,
+				     minor->debugfs_root,
+				     &vc4->load_tracker_enabled);
+	if (!dentry)
+		return -ENOMEM;
+
 	return drm_debugfs_create_files(vc4_debugfs_list, VC4_DEBUGFS_ENTRIES,
 					minor->debugfs_root, minor);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index bbab084911f3..7a3c093e7443 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -195,6 +195,9 @@ struct vc4_dev {
 
 	int power_refcount;
 
+	/* Set to true when the load tracker is active. */
+	bool load_tracker_enabled;
+
 	/* Mutex controlling the power refcount. */
 	struct mutex power_lock;
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 6e20604573de..5160cad25fce 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -439,6 +439,10 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
 		}
 	}
 
+	/* Don't check the load when the tracker is disabled. */
+	if (!vc4->load_tracker_enabled)
+		return 0;
+
 	/* The absolute limit is 2Gbyte/sec, but let's take a margin to let
 	 * the system work when other blocks are accessing the memory.
 	 */
@@ -511,6 +515,11 @@ int vc4_kms_load(struct drm_device *dev)
 	struct vc4_load_tracker_state *load_state;
 	int ret;
 
+	/* Start with the load tracker enabled. Can be disabled through the
+	 * debugfs load_tracker file.
+	 */
+	vc4->load_tracker_enabled = true;
+
 	sema_init(&vc4->async_modeset, 1);
 
 	/* Set support for vblank irq fast disable, before drm_vblank_init() */
-- 
2.20.1

