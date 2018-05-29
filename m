Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934686AbeE2NLK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:11:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34724 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934660AbeE2NLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:11:04 -0400
X-Google-Smtp-Source: ADUXVKI5vlHgVWgUOgscN77s5wliegxsoMYl3DKdVQ8R2+Bi1l/ZqCA4dTZnpWDJ812S9ZP5qm85lA==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 19/19] serdev: Instantiate a ttydev serdev if acpi and of fails
Date: Tue, 29 May 2018 15:10:14 +0200
Message-Id: <20180529131014.18641-20-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a serdev ttyport controller does not have an acpi nor an of child,
create a ttydev as a child of that controller.

Doing this allows the removal, addition and replacement of ttydev devices
at runtime.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 9414700e6442..34295dacfb84 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -619,6 +619,27 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
 }
 #endif /* CONFIG_ACPI */
 
+
+#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
+static int serdev_controller_add_ttydev(struct serdev_controller *ctrl)
+{
+	struct serdev_device *serdev;
+	int err;
+
+	serdev = serdev_device_alloc(ctrl);
+	if (!serdev)
+		return -ENOMEM;
+
+	strcpy(serdev->modalias, "ttydev");
+
+	err = serdev_device_add(serdev);
+	if (err)
+		serdev_device_put(serdev);
+
+	return err;
+}
+#endif
+
 /**
  * serdev_controller_add() - Add an serdev controller
  * @ctrl:	controller to be registered.
@@ -628,7 +649,7 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
  */
 int serdev_controller_add(struct serdev_controller *ctrl)
 {
-	int ret_of, ret_acpi, ret;
+	int ret_of, ret_acpi, ret, ret_tty = -ENODEV;
 
 	/* Can't register until after driver model init */
 	if (WARN_ON(!is_registered))
@@ -640,9 +661,16 @@ int serdev_controller_add(struct serdev_controller *ctrl)
 
 	ret_of = of_serdev_register_devices(ctrl);
 	ret_acpi = acpi_serdev_register_devices(ctrl);
-	if (ret_of && ret_acpi) {
-		dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
-			ret_of, ret_acpi);
+
+#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
+	if (ret_of && ret_acpi && ctrl->is_ttyport)
+		ret_tty = serdev_controller_add_ttydev(ctrl);
+#endif
+
+	if (ret_of && ret_acpi && ret_tty) {
+		dev_dbg(&ctrl->dev,
+			"no devices registered: of:%d acpi:%d tty:%d\n",
+			ret_of, ret_acpi, ret_tty);
 		ret = -ENODEV;
 		goto out_dev_del;
 	}
-- 
2.17.0
