Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA6FD60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeFFTFB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:05:01 -0400
Received: from anholt.net ([50.246.234.109]:50104 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752398AbeFFTEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:04:36 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/3] drm/bridge: Allow DSI encoders to decide when to call bridge funcs.
Date: Wed,  6 Jun 2018 12:04:30 -0700
Message-Id: <20180606190431.1833-2-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180606190431.1833-1-eric@anholt.net>
References: <20180606190431.1833-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DSI, we want to pre_enable once the DSI link is up but before
video packets are being sent, and similarly we want to be able to
post_disable while the link is still up but after video has stopped.

Given that with drm_panels we've had issues with drivers missing calls
to one of the hooks, include some checks in the atomic helpers that
the driver got it right.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/drm_atomic_helper.c | 32 +++++++++++++++++++++++++----
 drivers/gpu/drm/drm_bridge.c        | 12 +++++++++++
 include/drm/drm_bridge.h            | 21 +++++++++++++++++++
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 130da5195f3b..2950ddcc9013 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -950,7 +950,13 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call disable hooks twice.
 		 */
-		drm_bridge_disable(encoder->bridge);
+		if (encoder->bridge) {
+			encoder->bridge->post_disable_called = false;
+			encoder->bridge->disable_called = false;
+
+			if (!encoder->bridge->disable_midlayer_calls)
+				drm_bridge_disable(encoder->bridge);
+		}
 
 		/* Right function depends upon target state. */
 		if (funcs) {
@@ -962,7 +968,13 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 				funcs->dpms(encoder, DRM_MODE_DPMS_OFF);
 		}
 
-		drm_bridge_post_disable(encoder->bridge);
+		if (encoder->bridge) {
+			if (!encoder->bridge->disable_midlayer_calls)
+				drm_bridge_post_disable(encoder->bridge);
+
+			WARN_ON(!encoder->bridge->post_disable_called);
+			WARN_ON(!encoder->bridge->disable_called);
+		}
 	}
 
 	for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
@@ -1240,7 +1252,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		 * Each encoder has at most one connector (since we always steal
 		 * it away), so we won't call enable hooks twice.
 		 */
-		drm_bridge_pre_enable(encoder->bridge);
+		if (encoder->bridge) {
+			encoder->bridge->pre_enable_called = false;
+			encoder->bridge->enable_called = false;
+
+			if (!encoder->bridge->disable_midlayer_calls)
+				drm_bridge_pre_enable(encoder->bridge);
+		}
 
 		if (funcs) {
 			if (funcs->enable)
@@ -1249,7 +1267,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 				funcs->commit(encoder);
 		}
 
-		drm_bridge_enable(encoder->bridge);
+		if (encoder->bridge) {
+			if (!encoder->bridge->disable_midlayer_calls)
+				drm_bridge_enable(encoder->bridge);
+
+			WARN_ON(!encoder->bridge->pre_enable_called);
+			WARN_ON(!encoder->bridge->enable_called);
+		}
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..847c4209da60 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -153,6 +153,8 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	bridge->disable_midlayer_calls = false;
+
 	bridge->dev = NULL;
 }
 
@@ -248,6 +250,8 @@ void drm_bridge_disable(struct drm_bridge *bridge)
 	if (!bridge)
 		return;
 
+	bridge->disable_called = true;
+
 	drm_bridge_disable(bridge->next);
 
 	if (bridge->funcs->disable)
@@ -270,6 +274,9 @@ void drm_bridge_post_disable(struct drm_bridge *bridge)
 	if (!bridge)
 		return;
 
+	WARN_ON(!bridge->disable_called);
+	bridge->post_disable_called = true;
+
 	if (bridge->funcs->post_disable)
 		bridge->funcs->post_disable(bridge);
 
@@ -319,6 +326,8 @@ void drm_bridge_pre_enable(struct drm_bridge *bridge)
 	if (!bridge)
 		return;
 
+	bridge->pre_enable_called = true;
+
 	drm_bridge_pre_enable(bridge->next);
 
 	if (bridge->funcs->pre_enable)
@@ -341,6 +350,9 @@ void drm_bridge_enable(struct drm_bridge *bridge)
 	if (!bridge)
 		return;
 
+	WARN_ON(!bridge->pre_enable_called);
+	bridge->enable_called = true;
+
 	if (bridge->funcs->enable)
 		bridge->funcs->enable(bridge);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bd850747ce54..ba0a227c96b7 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -294,6 +294,27 @@ struct drm_bridge {
 	const struct drm_bridge_funcs *funcs;
 	/** @driver_private: pointer to the bridge driver's internal context */
 	void *driver_private;
+
+	/**
+	 * @disable_midlayer_calls:
+	 *
+	 * disables the calls from the DRM atomic helpers into the
+	 * bridge, leaving them to be performed by the driver.  This
+	 * may be useful for encoders such as DSI, where the
+	 * pre_enable/post_disable hooks want to be called while the
+	 * bus is still enabled but before/after video packets are
+	 * being sent.
+	 */
+	bool disable_midlayer_calls : 1;
+
+	/* private: flags for atomic helpers to check that the driver
+	 * called the bridge functions properly if
+	 * @disable_midlayer_calls was set.
+	 */
+	bool pre_enable_called : 1;
+	bool enable_called : 1;
+	bool disable_called : 1;
+	bool post_disable_called : 1;
 };
 
 void drm_bridge_add(struct drm_bridge *bridge);
-- 
2.17.0
