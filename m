Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A008C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EFC2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EFC2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH1VDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:03:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbeH1VDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:03:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D044FC7C3;
        Tue, 28 Aug 2018 17:10:57 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D5FE1049469;
        Tue, 28 Aug 2018 17:10:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm/dp_mst: Add dp_mst_status debugfs node for all drivers
Date:   Tue, 28 Aug 2018 13:10:29 -0400
Message-Id: <20180828171036.25943-4-lyude@redhat.com>
In-Reply-To: <20180828171036.25943-1-lyude@redhat.com>
References: <20180828171036.25943-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 17:10:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 28 Aug 2018 17:10:57 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally I was just going to be adding dp_mst_status for nouveau until
Daniel Stone pointed out that we should probably just make this so it's
magically added for every DRM driver that's using the DRM DP MST
helpers. So, let's do that!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Stone <daniel@fooishbar.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 106 ++++++++++++++++++++++++++
 include/drm/drm_dp_mst_helper.h       |  14 ++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index acb7633f3f70..a6a2c03af62a 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/i2c.h>
+#include <linux/debugfs.h>
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/drmP.h>
 
@@ -3154,6 +3155,104 @@ struct drm_dp_mst_topology_state *drm_atomic_get_mst_topology_state(struct drm_a
 }
 EXPORT_SYMBOL(drm_atomic_get_mst_topology_state);
 
+#ifdef CONFIG_DEBUG_FS
+static int drm_dp_mst_debugfs_state_show(struct seq_file *m, void *data)
+{
+	drm_dp_mst_dump_topology(m, m->private);
+	return 0;
+}
+
+static int drm_dp_mst_debugfs_state_open(struct inode *inode,
+					 struct file *file)
+{
+	struct drm_dp_mst_topology_mgr *mgr = inode->i_private;
+
+	return single_open(file, drm_dp_mst_debugfs_state_show, mgr);
+}
+
+static const struct file_operations drm_dp_mst_debugfs_state_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_dp_mst_debugfs_state_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+struct drm_dp_mst_debugfs_init_data {
+	struct drm_dp_mst_topology_mgr *mgr;
+	char *connector_name;
+};
+
+static void
+drm_dp_mst_debugfs_init(void *data)
+{
+	struct drm_dp_mst_debugfs_init_data *init_data = data;
+	struct drm_dp_mst_topology_mgr *mgr = init_data->mgr;
+	struct drm_minor *minor = mgr->dev->primary;
+	struct dentry *root;
+	bool put_ref = false;
+
+	/* Create the dp_mst directory for this device if it doesn't exist
+	 * already
+	 */
+	root = debugfs_lookup("dp_mst", minor->debugfs_root);
+	if (root) {
+		put_ref = true;
+	} else {
+		root = debugfs_create_dir("dp_mst", minor->debugfs_root);
+		if (!root || IS_ERR(root))
+			return;
+	}
+
+	mgr->debugfs = debugfs_create_dir(init_data->connector_name, root);
+	if (!mgr->debugfs)
+		goto out_dput;
+
+	debugfs_create_file("state", 0444, mgr->debugfs, mgr,
+			    &drm_dp_mst_debugfs_state_fops);
+
+out_dput:
+	if (put_ref)
+		dput(root);
+}
+
+static void
+drm_dp_mst_debugfs_cleanup_cb(void *data)
+{
+	struct drm_dp_mst_debugfs_init_data *init_data = data;
+
+	init_data->mgr->debugfs_init_cb = NULL;
+	kfree(init_data->connector_name);
+	kfree(init_data);
+}
+
+static void
+drm_dp_mst_debugfs_register(struct drm_dp_mst_topology_mgr *mgr,
+			    struct drm_connector *connector)
+{
+	struct drm_dp_mst_debugfs_init_data *init_data;
+
+	if (!connector)
+		return;
+
+	init_data = kmalloc(sizeof(*init_data), GFP_KERNEL);
+	if (!init_data)
+		return;
+
+	init_data->mgr = mgr;
+	init_data->connector_name = kstrdup(connector->name, GFP_KERNEL);
+	if (!init_data->connector_name) {
+		kfree(init_data);
+		return;
+	}
+
+	drm_debugfs_register_callback(mgr->dev->primary,
+				      drm_dp_mst_debugfs_init,
+				      drm_dp_mst_debugfs_cleanup_cb,
+				      init_data, &mgr->debugfs_init_cb);
+}
+#endif
+
 /**
  * drm_dp_mst_topology_mgr_init - initialise a topology manager
  * @mgr: manager struct to initialise
@@ -3214,6 +3313,9 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	drm_atomic_private_obj_init(&mgr->base,
 				    &mst_state->base,
 				    &mst_state_funcs);
+#ifdef CONFIG_DEBUG_FS
+	drm_dp_mst_debugfs_register(mgr, connector);
+#endif
 
 	return 0;
 }
@@ -3225,6 +3327,10 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_init);
  */
 void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
 {
+#ifdef CONFIG_DEBUG_FS
+	drm_debugfs_unregister_callback(mgr->dev->primary,
+					mgr->debugfs_init_cb);
+#endif
 	flush_work(&mgr->work);
 	flush_work(&mgr->destroy_connector_work);
 	mutex_lock(&mgr->payload_lock);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index ef8ba093ae8a..c70b81cd78b1 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -25,6 +25,7 @@
 #include <linux/types.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_debugfs.h>
 
 struct drm_dp_mst_branch;
 
@@ -568,6 +569,19 @@ struct drm_dp_mst_topology_mgr {
 	 * avoid locking inversion.
 	 */
 	struct work_struct destroy_connector_work;
+#ifdef CONFIG_DEBUG_FS
+	/**
+	 * @debugfs_init_cb: Pending debugfs callback for initializing the
+	 * debugfs files for this topology.
+	 */
+	struct drm_debugfs_callback *debugfs_init_cb;
+
+	/**
+	 * @debugfs_entry: dentry for dp_mst_status located in connector's
+	 * debugfs directory.
+	 */
+	struct dentry *debugfs;
+#endif
 };
 
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
-- 
2.17.1

