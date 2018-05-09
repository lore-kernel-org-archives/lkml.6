Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934254AbeEIJoi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:44:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44297 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933938AbeEIJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:44:33 -0400
X-Google-Smtp-Source: AB8JxZqvQVaim+9zGV2L3GdHTdl8UwG4hHXIx+xDGyjx3wXF4/1vj8QFE6OP1zmuMcxDmwXX0yYdzA==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] serdev: add controller runtime PM support
Date: Wed,  9 May 2018 11:44:18 +0200
Message-Id: <20180509094419.13470-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controller runtime power management to serdev core. This
is needed to allow slave drivers to manage the runtime PM state of the
underlying serial controller when its driver, in turn, implements more
aggressive runtime power management (e.g. using autosuspend).

For some applications, for example, where loss off initial data after a
remote-wakeup event is acceptable or where rx is not used at all,
aggressive serial controller runtime PM may be used without further
involvement of the slave driver. But when this is not the case, the
slave driver must be able to indicate when incoming data is expected in
order to avoid data loss.

To facilitate the common case, where the serial controller power state
is active whenever the port is open (which is the case with just about
every serial driver), and where data loss is not acceptable and cannot
even be prevented by explicit controller runtime power management, an
RPM reference is taken in serdev open and put again at close. This
reference can later be balanced by any serdev driver which wants and/or
can handle aggressive controller runtime PM.

Note that the .ignore_children flag is set for the serdev controller to
allow the underlying hardware to idle when no I/O is expected, regardless
of the slave device RPM state.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index df93b727e984..e5e84303faca 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 
@@ -143,11 +144,28 @@ EXPORT_SYMBOL_GPL(serdev_device_remove);
 int serdev_device_open(struct serdev_device *serdev)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
+	int ret;
 
 	if (!ctrl || !ctrl->ops->open)
 		return -EINVAL;
 
-	return ctrl->ops->open(ctrl);
+	ret = ctrl->ops->open(ctrl);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_sync(&ctrl->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&ctrl->dev);
+		goto err_close;
+	}
+
+	return 0;
+
+err_close:
+	if (ctrl->ops->close)
+		ctrl->ops->close(ctrl);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(serdev_device_open);
 
@@ -158,6 +176,8 @@ void serdev_device_close(struct serdev_device *serdev)
 	if (!ctrl || !ctrl->ops->close)
 		return;
 
+	pm_runtime_put(&ctrl->dev);
+
 	ctrl->ops->close(ctrl);
 }
 EXPORT_SYMBOL_GPL(serdev_device_close);
@@ -416,6 +436,9 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 
 	dev_set_name(&ctrl->dev, "serial%d", id);
 
+	pm_runtime_no_callbacks(&ctrl->dev);
+	pm_suspend_ignore_children(&ctrl->dev, true);
+
 	dev_dbg(&ctrl->dev, "allocated controller 0x%p id %d\n", ctrl, id);
 	return ctrl;
 
@@ -547,20 +570,23 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 	if (ret)
 		return ret;
 
+	pm_runtime_enable(&ctrl->dev);
+
 	ret_of = of_serdev_register_devices(ctrl);
 	ret_acpi = acpi_serdev_register_devices(ctrl);
 	if (ret_of && ret_acpi) {
 		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
 			ret_of, ret_acpi);
 		ret = -ENODEV;
-		goto out_dev_del;
+		goto err_rpm_disable;
 	}
 
 	dev_dbg(&ctrl->dev, "serdev%d registered: dev:%p\n",
 		ctrl->nr, &ctrl->dev);
 	return 0;
 
-out_dev_del:
+err_rpm_disable:
+	pm_runtime_disable(&ctrl->dev);
 	device_del(&ctrl->dev);
 	return ret;
 };
@@ -591,6 +617,7 @@ void serdev_controller_remove(struct serdev_controller *ctrl)
 
 	dummy = device_for_each_child(&ctrl->dev, NULL,
 				      serdev_remove_device);
+	pm_runtime_disable(&ctrl->dev);
 	device_del(&ctrl->dev);
 }
 EXPORT_SYMBOL_GPL(serdev_controller_remove);
-- 
2.17.0
