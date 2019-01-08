Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5EB206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfAHOv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:51:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41384 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfAHOvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:51:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 57AFC209C2; Tue,  8 Jan 2019 15:51:16 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 11359206DC;
        Tue,  8 Jan 2019 15:51:16 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 4/4] drm/vc4: Add a debugfs entry to disable/enable the load tracker
Date:   Tue,  8 Jan 2019 15:50:56 +0100
Message-Id: <20190108145056.2276-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
References: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
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
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes since v3 (of the standalone patch):
* Added a comment for the load_tracker_enabled field;
* Moved the ->load_tracker_enabled initialization in vc4_kms_load();
* Moved the if (vc4->load_tracker_enabled) check in
  vc4_load_tracker_atomic_check();
* Renamed the debugfs node to hvs_load_tracker to match hvs_underrun.

Changes since v2:
* Used the standard debugfs_create_bool instead of reinventing it.

Changes since v1:
* Moved all the debugfs-related functions and structure to vc4_debugfs.c.
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
index 30cde58be737..4ba05c955787 100644
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
index 695ec793d429..48f07f371e63 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -435,6 +435,10 @@ static int vc4_load_tracker_atomic_check(struct drm_atomic_state *state)
 		}
 	}
 
+	/* Don't check the load when the tracker is disabled. */
+	if (!vc4->load_tracker_enabled)
+		return 0;
+
 	/* The absolute limit is 2Gbyte/sec, but let's take a margin to let
 	 * the system work when other blocks are accessing the memory.
 	 */
@@ -507,6 +511,11 @@ int vc4_kms_load(struct drm_device *dev)
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

