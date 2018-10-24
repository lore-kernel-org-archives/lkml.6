Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E86EC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F017020651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F017020651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeJXLPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:15:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:41763 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbeJXLPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:15:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 19:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="102098586"
Received: from jhli-desk1.jf.intel.com ([10.7.198.167])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2018 19:22:28 -0700
From:   Juston Li <juston.li@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     lyude@redhat.com, clinton.a.taylor@intel.com,
        nathan.d.ciobanu@intel.com, mario.limonciello@dell.com,
        jared_dominguez@dell.com, linux-kernel@vger.kernel.org,
        Lyude <cpaul@redhat.com>, stable@vger.kernel.org,
        Juston Li <juston.li@intel.com>
Subject: [RESEND PATCH v2 1/2] drm/dp/mst: Reprobe EDID for MST ports on resume
Date:   Tue, 23 Oct 2018 19:19:24 -0700
Message-Id: <20181024021925.27026-2-juston.li@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181024021925.27026-1-juston.li@intel.com>
References: <20181024021925.27026-1-juston.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude <cpaul@redhat.com>

As observed with the latest ThinkPad docks, we unfortunately can't rely
on docks keeping us updated with hotplug events that happened while we
were suspended. On top of that, even if the number of connectors remains
the same between suspend and resume it's still not safe to assume that
there were no hotplugs, since a different monitor might have been
plugged into a port another monitor previously occupied. As such, we
need to go through all of the MST ports and check whether or not their
EDIDs have changed.

In addition to that, we also now return -EINVAL from
drm_dp_mst_topology_mgr_resume to indicate to callers that they need to
reset the MST connection, and that they can't rely on any other method
of reprobing.

Cc: stable@vger.kernel.org
Signed-off-by: Lyude <cpaul@redhat.com>
Signed-off-by: Juston Li <juston.li@intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 94 ++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 5ff1d79b86c4..88abebe52021 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -29,6 +29,7 @@
 #include <linux/i2c.h>
 #include <drm/drm_dp_mst_helper.h>
 #include <drm/drmP.h>
+#include <drm/drm_edid.h>
 
 #include <drm/drm_fixed.h>
 #include <drm/drm_atomic.h>
@@ -2201,6 +2202,64 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
 
+static bool drm_dp_mst_edids_changed(struct drm_dp_mst_topology_mgr *mgr,
+				     struct drm_dp_mst_port *port)
+{
+	struct drm_device *dev;
+	struct drm_connector *connector;
+	struct drm_dp_mst_port *dport;
+	struct drm_dp_mst_branch *mstb;
+	struct edid *current_edid, *cached_edid;
+	bool ret = false;
+
+	port = drm_dp_get_validated_port_ref(mgr, port);
+	if (!port)
+		return false;
+
+	mstb = drm_dp_get_validated_mstb_ref(mgr, port->mstb);
+	if (mstb) {
+		list_for_each_entry(dport, &port->mstb->ports, next) {
+			ret = drm_dp_mst_edids_changed(mgr, dport);
+			if (ret)
+				break;
+		}
+
+		drm_dp_put_mst_branch_device(mstb);
+		if (ret)
+			goto out;
+	}
+
+	connector = port->connector;
+	if (!connector || !port->aux.ddc.algo)
+		goto out;
+
+	dev = connector->dev;
+	mutex_lock(&dev->mode_config.mutex);
+
+	current_edid = drm_get_edid(connector, &port->aux.ddc);
+	if (connector->edid_blob_ptr)
+		cached_edid = (void *)connector->edid_blob_ptr->data;
+	else
+		return false;
+
+	if ((current_edid && cached_edid && memcmp(current_edid, cached_edid,
+						   sizeof(struct edid)) != 0) ||
+	    (!current_edid && cached_edid) || (current_edid && !cached_edid)) {
+		ret = true;
+		DRM_DEBUG_KMS("EDID on %s changed, reprobing connectors\n",
+			      connector->name);
+	}
+
+	mutex_unlock(&dev->mode_config.mutex);
+
+	kfree(current_edid);
+
+out:
+	drm_dp_put_port(port);
+
+	return ret;
+}
+
 /**
  * drm_dp_mst_topology_mgr_resume() - resume the MST manager
  * @mgr: manager to resume
@@ -2210,9 +2269,15 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
  *
  * if the device fails this returns -1, and the driver should do
  * a full MST reprobe, in case we were undocked.
+ *
+ * if the device can no longer be trusted, this returns -EINVAL
+ * and the driver should unconditionally disconnect and reconnect
+ * the dock.
  */
 int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
 {
+	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_mst_port *port;
 	int ret = 0;
 
 	mutex_lock(&mgr->lock);
@@ -2246,8 +2311,35 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
 		drm_dp_check_mstb_guid(mgr->mst_primary, guid);
 
 		ret = 0;
-	} else
+
+		/*
+		 * Some hubs also forget to notify us of hotplugs that happened
+		 * while we were in suspend, so we need to verify that the edid
+		 * hasn't changed for any of the connectors. If it has been,
+		 * we unfortunately can't rely on the dock updating us with
+		 * hotplug events, so indicate we need a full reconnect.
+		 */
+
+		/* MST's I2C helpers can't be used while holding this lock */
+		mutex_unlock(&mgr->lock);
+
+		mstb = drm_dp_get_validated_mstb_ref(mgr, mgr->mst_primary);
+		if (mstb) {
+			list_for_each_entry(port, &mstb->ports, next) {
+				if (drm_dp_mst_edids_changed(mgr, port)) {
+					ret = -EINVAL;
+					break;
+				}
+			}
+
+			drm_dp_put_mst_branch_device(mstb);
+		}
+	} else {
 		ret = -1;
+		mutex_unlock(&mgr->lock);
+	}
+
+	return ret;
 
 out_unlock:
 	mutex_unlock(&mgr->lock);
-- 
2.17.2

