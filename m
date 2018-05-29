Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeE2NPZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:15:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37342 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934516AbeE2NKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:44 -0400
X-Google-Smtp-Source: ADUXVKJyJH5SDXxh6XxM+19E0CFJYjxS9dTOxgzF9N4erumQJHZ2yGWXeXUmWCPlCvBFj0IyyH5lhw==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 07/19] serdev: Allows dynamic creation of devices via sysfs
Date: Tue, 29 May 2018 15:10:02 +0200
Message-Id: <20180529131014.18641-8-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow creating and deleting devices via sysfs. Devices created will be
matched to serdev drivers via modalias (the string provided by the user)
and deleted via their name. Eg:

 # Create device
root@qt5022:~# echo ttydev > /sys/bus/serial/devices/serial0/new_device

 # Delete device
root@qt5022:~#
	echo serial0-0 > /sys/bus/serial/devices/serial0/delete_device

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 60 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 2c79f47fc0db..e695fa649a6d 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -75,7 +75,67 @@ static void serdev_ctrl_release(struct device *dev)
 	kfree(ctrl);
 }
 
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	struct serdev_device *serdev;
+	int err;
+	char *nline;
+
+	serdev = serdev_device_alloc(ctrl);
+	if (!serdev)
+		return -ENOMEM;
+
+	nline = strchr(buf, '\n');
+	if (nline)
+		*nline = '\0';
+
+	strncpy(serdev->modalias, buf, SERDEV_NAME_SIZE);
+
+	err = serdev_device_add(serdev);
+	if (err) {
+		serdev_device_put(serdev);
+		return err;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct serdev_controller *ctrl = to_serdev_controller(dev);
+	struct serdev_device *serdev = ctrl->serdev;
+	char *nline;
+
+	nline = strchr(buf, '\n');
+	if (nline)
+		*nline = '\0';
+
+	if (!ctrl->serdev ||
+	    strncmp(dev_name(&serdev->dev), buf, SERDEV_NAME_SIZE))
+		return -ENODEV;
+
+	serdev_device_remove(serdev);
+
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
+				  delete_device_store);
+
+static struct attribute *serdev_ctrl_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(serdev_ctrl);
+
 static const struct device_type serdev_ctrl_type = {
+	.groups		= serdev_ctrl_groups,
 	.release	= serdev_ctrl_release,
 };
 
-- 
2.17.0
