Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033867AbeEXQmZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:42:25 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59879 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1030846AbeEXQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:41:22 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>, Rob Clark <robdclark@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v9 3/3] drm: writeback: Add client capability for exposing writeback connectors
Date: Thu, 24 May 2018 17:41:03 +0100
Message-Id: <20180524164103.8378-4-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524164103.8378-1-Liviu.Dudau@arm.com>
References: <20180524164103.8378-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the fact that writeback connectors behave in a special way
in DRM (they always report being disconnected) we might confuse some
userspace. Add a client capability for writeback connectors that will
filter them out for clients that don't understand the capability.

Changelog:
 - only accept the capability if the client has already set the
DRM_CLIENT_CAP_ATOMIC one.
 - update the capability number to fix conflict with the aspect ratio

Reviewed-by: Eric Anholt <eric@anholt.net>
Re-requested-by: Sean Paul <seanpaul@chromium.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_ioctl.c       | 7 +++++++
 drivers/gpu/drm/drm_mode_config.c | 5 +++++
 include/drm/drm_file.h            | 7 +++++++
 include/uapi/drm/drm.h            | 9 +++++++++
 4 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 0d4cfb232576f..fe49fb0356b5a 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -334,6 +334,13 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->aspect_ratio_allowed = req->value;
 		break;
+	case DRM_CLIENT_CAP_WRITEBACK_CONNECTORS:
+		if (!file_priv->atomic)
+			return -EINVAL;
+		if (req->value > 1)
+			return -EINVAL;
+		file_priv->writeback_connectors = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index e5c653357024d..21e353bd3948e 100644
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
index 027ac16da3d15..26485acc51d79 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -192,6 +192,13 @@ struct drm_file {
 	 */
 	unsigned aspect_ratio_allowed:1;
 
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
index 9c660e1688abe..300f336633f28 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -687,6 +687,15 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_ASPECT_RATIO    4
 
+/**
+ * DRM_CLIENT_CAP_WRITEBACK_CONNECTORS
+ *
+ * If set to 1, the DRM core will expose special connectors to be used for
+ * writing back to memory the scene setup in the commit. Depends on client
+ * also supporting DRM_CLIENT_CAP_ATOMIC
+ */
+#define DRM_CLIENT_CAP_WRITEBACK_CONNECTORS	5
+
 /** DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.17.0
