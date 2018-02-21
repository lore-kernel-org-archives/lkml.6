Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeBUIEA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:04:00 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37373 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBUID4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:03:56 -0500
X-Google-Smtp-Source: AH8x226LVoCGFVg//M1LNjSaukAPPnpvfI1uwfHDkinWWWZjdLbCQRgoQPAx/4Kg+b9Acjdculo8jA==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc: andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 2/9] drm/xen-front: Implement Xen bus state handling
Date: Wed, 21 Feb 2018 10:03:35 +0200
Message-Id: <1519200222-20623-3-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
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
 drivers/gpu/drm/xen/xen_drm_front.h |  26 ++++++++
 2 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index fd372fb464a1..d0306f9d660d 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -24,19 +24,141 @@
 
 #include <xen/interface/io/displif.h>
 
+#include "xen_drm_front.h"
+
+static void xen_drv_remove_internal(struct xen_drm_front_info *front_info)
+{
+}
+
+static int backend_on_initwait(struct xen_drm_front_info *front_info)
+{
+	return 0;
+}
+
+static int backend_on_connected(struct xen_drm_front_info *front_info)
+{
+	return 0;
+}
+
+static void backend_on_disconnected(struct xen_drm_front_info *front_info)
+{
+	xenbus_switch_state(front_info->xb_dev, XenbusStateInitialising);
+}
+
 static void backend_on_changed(struct xenbus_device *xb_dev,
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
+		backend_on_disconnected(front_info);
+		break;
+
+	case XenbusStateInitWait:
+		/* recovering after backend unexpected closure */
+		backend_on_disconnected(front_info);
+		if (xb_dev->state != XenbusStateInitialising)
+			break;
+
+		ret = backend_on_initwait(front_info);
+		if (ret < 0)
+			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
+		else
+			xenbus_switch_state(xb_dev, XenbusStateInitialised);
+		break;
+
+	case XenbusStateConnected:
+		if (xb_dev->state != XenbusStateInitialised)
+			break;
+
+		ret = backend_on_connected(front_info);
+		if (ret < 0)
+			xenbus_dev_fatal(xb_dev, ret, "initializing DRM driver");
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
+		backend_on_disconnected(front_info);
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
+	if (!front_info) {
+		xenbus_dev_fatal(xb_dev, -ENOMEM, "allocating device memory");
+		return -ENOMEM;
+	}
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
index 000000000000..8af46850f126
--- /dev/null
+++ b/drivers/gpu/drm/xen/xen_drm_front.h
@@ -0,0 +1,26 @@
+/*
+ *  Xen para-virtual DRM device
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
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
