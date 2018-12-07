Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3818C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678FB20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678FB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLGNs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:48:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58286 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeLGNs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:48:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4549D20CC3; Fri,  7 Dec 2018 14:48:24 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id ED84F20745;
        Fri,  7 Dec 2018 14:48:13 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3] drm/vc4: Add a debugfs entry to disable/enable the load tracker
Date:   Fri,  7 Dec 2018 14:47:57 +0100
Message-Id: <20181207134757.32437-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
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
This patch is based upon Boris Brezillon's series:
  drm/vc4: Add a load tracker

Changes since v2:
* Used the standard debugfs_create_bool instead of reinventing it.

Changes since v1:
* Moved all the debugfs-related functions and structure to vc4_debugfs.c.

 drivers/gpu/drm/vc4/vc4_debugfs.c | 9 +++++++++
 drivers/gpu/drm/vc4/vc4_drv.c     | 2 ++
 drivers/gpu/drm/vc4/vc4_drv.h     | 2 ++
 drivers/gpu/drm/vc4/vc4_kms.c     | 6 +++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 7a0003de71ab..7c23f5209f6d 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -35,6 +35,15 @@ static const struct drm_info_list vc4_debugfs_list[] = {
 int
 vc4_debugfs_init(struct drm_minor *minor)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(minor->dev);
+	struct dentry *dentry;
+
+	dentry = debugfs_create_bool("load_tracker", S_IRUGO | S_IWUSR,
+				     minor->debugfs_root,
+				     &vc4->load_tracker_enabled);
+	if (!dentry)
+		return -ENOMEM;
+
 	return drm_debugfs_create_files(vc4_debugfs_list, VC4_DEBUGFS_ENTRIES,
 					minor->debugfs_root, minor);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 7195a0bcceb3..12ac971d24d6 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -290,6 +290,8 @@ static int vc4_drm_bind(struct device *dev)
 
 	drm_fbdev_generic_setup(drm, 32);
 
+	vc4->load_tracker_enabled = true;
+
 	return 0;
 
 unbind_all:
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index a0fb888604d6..8837d2416aae 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -188,6 +188,8 @@ struct vc4_dev {
 
 	int power_refcount;
 
+	bool load_tracker_enabled;
+
 	/* Mutex controlling the power refcount. */
 	struct mutex power_lock;
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index f3fd34faa812..e80b1ad5c938 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -479,6 +479,7 @@ static const struct drm_private_state_funcs vc4_load_tracker_state_funcs = {
 static int
 vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 {
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	int ret;
 
 	ret = vc4_ctm_atomic_check(dev, state);
@@ -489,7 +490,10 @@ vc4_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 	if (ret)
 		return ret;
 
-	return vc4_load_tracker_atomic_check(state);
+	if (vc4->load_tracker_enabled)
+		return vc4_load_tracker_atomic_check(state);
+
+	return 0;
 }
 
 static const struct drm_mode_config_funcs vc4_mode_funcs = {
-- 
2.19.2

