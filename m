Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeB1QvO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:51:14 -0500
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:52816 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753059AbeB1QvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:51:10 -0500
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: DRI-devel <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v6 3/3] drm: writeback: Add client capability for exposing writeback connectors
Date: Wed, 28 Feb 2018 16:50:57 +0000
Message-Id: <20180228165057.26856-4-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228165057.26856-1-Liviu.Dudau@arm.com>
References: <20180228165057.26856-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the fact that writeback connectors behave in a special way
in DRM (they always report being disconnected) we might confuse some
userspace. Add a client capability for writeback connectors that will
filter them out for clients that don't understand the capability.

Re-requested-by: Sean Paul <seanpaul@chromium.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_ioctl.c       | 5 +++++
 drivers/gpu/drm/drm_mode_config.c | 5 +++++
 include/drm/drm_file.h            | 7 +++++++
 include/uapi/drm/drm.h            | 9 +++++++++
 4 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 02ffa0e8d77b..48895a469963 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -322,6 +322,11 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 		file_priv->atomic = req->value;
 		file_priv->universal_planes = req->value;
 		break;
+	case DRM_CLIENT_CAP_WRITEBACK_CONNECTORS:
+		if (!file_priv->atomic || !drm_core_check_feature(dev, DRIVER_ATOMIC))
+			return -EINVAL;
+		file_priv->writeback_connectors = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index e5c653357024..21e353bd3948 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -145,6 +145,11 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
 	count = 0;
 	connector_id = u64_to_user_ptr(card_res->connector_id_ptr);
 	drm_for_each_connector_iter(connector, &conn_iter) {
+		/* only expose writeback connectors if userspace understands them */
+		if (!file_priv->writeback_connectors &&
+		    (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK))
+			continue;
+
 		if (drm_lease_held(file_priv, connector->base.id)) {
 			if (count < card_res->count_connectors &&
 			    put_user(connector->base.id, connector_id + count)) {
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 5176c3797680..2a09b3c8965c 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -181,6 +181,13 @@ struct drm_file {
 	/** @atomic: True if client understands atomic properties. */
 	unsigned atomic:1;
 
+	/**
+	 * @writeback_connectors:
+	 *
+	 * True if client understands writeback connectors
+	 */
+	unsigned writeback_connectors:1;
+
 	/**
 	 * @is_master:
 	 *
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 6fdff5945c8a..59f27ea928b4 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -680,6 +680,15 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ATOMIC	3
 
+/**
+ * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
+ *
+ * If set to 1, the DRM core will expose special connectors to be used for
+ * writing back to memory the scene setup in the commit. Depends on client
+ * also supporting DRM_CLIENT_CAP_ATOMIC
+ */
+#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	4
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.16.2
