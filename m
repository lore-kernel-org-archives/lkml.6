Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeFENye (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:54:34 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:40782 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeFENyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:25 -0400
X-Google-Smtp-Source: ADUXVKLT6EU+sesEqEbvFTkyNtPVtUgUkFy8GQz2+tUjhq7ygjBdQ/w+TSwkYBq/jPzxK7jWXVEkdg==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 2/7] drm: add hook to print encoder status
Date: Tue,  5 Jun 2018 15:54:02 +0200
Message-Id: <20180605135407.20214-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if encoders don't have state it could be useful to get information
from them when dumping of the other elements state.
Add an optional hook in drm_encoder_funcs structure and call it after crtc
print state.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/drm_atomic.c | 15 +++++++++++++++
 include/drm/drm_encoder.h    | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index cd1d677617c8..6a9f5be01172 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -28,6 +28,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_print.h>
 #include <linux/sync_file.h>
@@ -1799,6 +1800,15 @@ int drm_atomic_nonblocking_commit(struct drm_atomic_state *state)
 }
 EXPORT_SYMBOL(drm_atomic_nonblocking_commit);
 
+static void drm_atomic_encoder_print(struct drm_printer *p,
+				     struct drm_encoder *encoder)
+{
+	drm_printf(p, "encoder[%u]: %s\n", encoder->base.id, encoder->name);
+
+	if (encoder->funcs->atomic_print)
+		encoder->funcs->atomic_print(p, encoder);
+}
+
 static void drm_atomic_print_state(const struct drm_atomic_state *state)
 {
 	struct drm_printer p = drm_info_printer(state->dev->dev);
@@ -1828,6 +1838,7 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 	struct drm_mode_config *config = &dev->mode_config;
 	struct drm_plane *plane;
 	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter conn_iter;
 
@@ -1850,6 +1861,10 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 			drm_modeset_unlock(&crtc->mutex);
 	}
 
+	drm_for_each_encoder(encoder, dev) {
+		drm_atomic_encoder_print(p, encoder);
+	}
+
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	if (take_locks)
 		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index fb299696c7c4..b847dad817b0 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -80,6 +80,18 @@ struct drm_encoder_funcs {
 	 * before data structures are torndown.
 	 */
 	void (*early_unregister)(struct drm_encoder *encoder);
+
+	/**
+	 * @atomic_print
+	 *
+	 * If driver could implement this optional hook for printing
+	 * additional driver specific information.
+	 *
+	 * Do not call this directly, use drm_atomic_encoder_print()
+	 * instead.
+	 */
+	void (*atomic_print)(struct drm_printer *p,
+			     struct drm_encoder *encoder);
 };
 
 /**
-- 
2.15.0
