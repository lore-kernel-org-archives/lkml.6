Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 753AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A47208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A47208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934100AbeFLNxh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:53:37 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:18121 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933574AbeFLNxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:53:36 -0400
Received: from e110455-lin.cambridge.arm.com (e110455-lin.cambridge.arm.com [10.2.131.61])
        by cam-smtp0.cambridge.arm.com (8.13.8/8.13.8) with ESMTP id w5CDqX1o016479;
        Tue, 12 Jun 2018 14:52:35 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Gustavo Padovan <gustavo@padovan.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v10 3/3] drm: writeback: Add client capability for exposing writeback connectors
Date:   Tue, 12 Jun 2018 14:52:33 +0100
Message-Id: <20180612135233.18575-4-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612135233.18575-1-Liviu.Dudau@arm.com>
References: <20180612135233.18575-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the fact that writeback connectors behave in a special way
in DRM (they always report being disconnected) we might confuse some
userspace. Add a client capability for writeback connectors that will
filter them out for clients that don't understand the capability.

Changelog:
 - only accept the capability if the client has already set the
DRM_CLIENT_CAP_ATOMIC one.

Cc: Sean Paul <seanpaul@chromium.org>
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
2.17.1

