Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E351C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BDC2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfBFOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:50:39 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:34427 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfBFOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:50:36 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 020D0100008;
        Wed,  6 Feb 2019 14:50:32 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v4 4/4] drm/vc4: Add a debugfs entry to disable/enable the load tracker
Date:   Wed,  6 Feb 2019 15:49:06 +0100
Message-Id: <20190206144906.24304-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206144906.24304-1-paul.kocialkowski@bootlin.com>
References: <20190206144906.24304-1-paul.kocialkowski@bootlin.com>
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
index a6ed55da0d10..a7a50c4a62bc 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -203,6 +203,9 @@ struct vc4_dev {
 
 	int power_refcount;
 
+	/* Set to true when the load tracker is active. */
+	bool load_tracker_enabled;
+
 	/* Mutex controlling the power refcount. */
 	struct mutex power_lock;
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 8c9341bee5ce..476bf746b014 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -433,6 +433,10 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
 		}
 	}
 
+	/* Don't check the load when the tracker is disabled. */
+	if (!vc4->load_tracker_enabled)
+		return 0;
+
 	/* The absolute limit is 2Gbyte/sec, but let's take a margin to let
 	 * the system work when other blocks are accessing the memory.
 	 */
@@ -505,6 +509,11 @@ int vc4_kms_load(struct drm_device *dev)
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

