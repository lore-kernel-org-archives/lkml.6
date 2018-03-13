Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933004AbeCMNbX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:31:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36388 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbeCMNbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:31:20 -0400
X-Google-Smtp-Source: AG47ELvSuIvBhXvXXNidmvmzcueQU75BowgSSIsE5L9SZNsz5dQtbroxRKKrhofWENqPBhevyNlc9g==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 2/8] drm/xen-front: Implement Xen bus state handling
Date: Tue, 13 Mar 2018 15:31:01 +0200
Message-Id: <1520947867-32514-3-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520947867-32514-1-git-send-email-andr2000@gmail.com>
References: <1520947867-32514-1-git-send-email-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Initial handling for Xen bus states: implement
Xen bus state machine for the frontend driver according to
the state diagram and recovery flow from display para-virtualized
protocol: xen/interface/io/displif.h.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front.c | 124 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xen/xen_drm_front.h |  18 ++++++
 2 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 03bc50b128fd..520b5b34520b 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -16,19 +16,141 @@
 
 #include <xen/interface/io/displif.h>
 
+#include "xen_drm_front.h"
+
+static void xen_drv_remove_internal(struct xen_drm_front_info *front_info)
+{
+}
+
+static int displback_initwait(struct xen_drm_front_info *front_info)
+{
+	return 0;
+}
+
+static int displback_connect(struct xen_drm_front_info *front_info)
+{
+	return 0;
+}
+
+static void displback_disconnect(struct xen_drm_front_info *front_info)
+{
+	xenbus_switch_state(front_info->xb_dev, XenbusStateInitialising);
+}
+
 static void displback_changed(struct xenbus_device *xb_dev,
 		enum xenbus_state backend_state)
 {
+	struct xen_drm_front_info *front_info = dev_get_drvdata(&xb_dev->dev);
+	int ret;
+
+	DRM_DEBUG("Backend state is %s, front is %s\n",
+			xenbus_strstate(backend_state),
+			xenbus_strstate(xb_dev->state));
+
+	switch (backend_state) {
+	case XenbusStateReconfiguring:
+		/* fall through */
+	case XenbusStateReconfigured:
+		/* fall through */
+	case XenbusStateInitialised:
+		break;
+
+	case XenbusStateInitialising:
+		/* recovering after backend unexpected closure */
+		displback_disconnect(front_info);
+		break;
+
+	case XenbusStateInitWait:
+		/* recovering after backend unexpected closure */
+		displback_disconnect(front_info);
+		if (xb_dev->state != XenbusStateInitialising)
+			break;
+
+		ret = displback_initwait(front_info);
+		if (ret < 0)
+			xenbus_dev_fatal(xb_dev, ret,
+					"initializing frontend");
+		else
+			xenbus_switch_state(xb_dev, XenbusStateInitialised);
+		break;
+
+	case XenbusStateConnected:
+		if (xb_dev->state != XenbusStateInitialised)
+			break;
+
+		ret = displback_connect(front_info);
+		if (ret < 0)
+			xenbus_dev_fatal(xb_dev, ret,
+					"initializing DRM driver");
+		else
+			xenbus_switch_state(xb_dev, XenbusStateConnected);
+		break;
+
+	case XenbusStateClosing:
+		/*
+		 * in this state backend starts freeing resources,
+		 * so let it go into closed state, so we can also
+		 * remove ours
+		 */
+		break;
+
+	case XenbusStateUnknown:
+		/* fall through */
+	case XenbusStateClosed:
+		if (xb_dev->state == XenbusStateClosed)
+			break;
+
+		displback_disconnect(front_info);
+		break;
+	}
 }
 
 static int xen_drv_probe(struct xenbus_device *xb_dev,
 		const struct xenbus_device_id *id)
 {
-	return 0;
+	struct xen_drm_front_info *front_info;
+
+	front_info = devm_kzalloc(&xb_dev->dev,
+			sizeof(*front_info), GFP_KERNEL);
+	if (!front_info)
+		return -ENOMEM;
+
+	front_info->xb_dev = xb_dev;
+	dev_set_drvdata(&xb_dev->dev, front_info);
+	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
 }
 
 static int xen_drv_remove(struct xenbus_device *dev)
 {
+	struct xen_drm_front_info *front_info = dev_get_drvdata(&dev->dev);
+	int to = 100;
+
+	xenbus_switch_state(dev, XenbusStateClosing);
+
+	/*
+	 * On driver removal it is disconnected from XenBus,
+	 * so no backend state change events come via .otherend_changed
+	 * callback. This prevents us from exiting gracefully, e.g.
+	 * signaling the backend to free event channels, waiting for its
+	 * state to change to XenbusStateClosed and cleaning at our end.
+	 * Normally when front driver removed backend will finally go into
+	 * XenbusStateInitWait state.
+	 *
+	 * Workaround: read backend's state manually and wait with time-out.
+	 */
+	while ((xenbus_read_unsigned(front_info->xb_dev->otherend,
+			"state", XenbusStateUnknown) != XenbusStateInitWait) &&
+			to--)
+		msleep(10);
+
+	if (!to)
+		DRM_ERROR("Backend state is %s while removing driver\n",
+			xenbus_strstate(xenbus_read_unsigned(
+					front_info->xb_dev->otherend,
+					"state", XenbusStateUnknown)));
+
+	xen_drv_remove_internal(front_info);
+	xenbus_frontend_closed(dev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
new file mode 100644
index 000000000000..8b8d4d1e0816
--- /dev/null
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+/*
+ *  Xen para-virtual DRM device
+ *
+ * Copyright (C) 2016-2018 EPAM Systems Inc.
+ *
+ * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
+ */
+
+#ifndef __XEN_DRM_FRONT_H_
+#define __XEN_DRM_FRONT_H_
+
+struct xen_drm_front_info {
+	struct xenbus_device *xb_dev;
+};
+
+#endif /* __XEN_DRM_FRONT_H_ */
-- 
2.7.4
