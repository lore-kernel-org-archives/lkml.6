Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934399AbeE2NPG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:15:06 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53433 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934521AbeE2NKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:46 -0400
X-Google-Smtp-Source: AB8JxZrJvEyP0buAEw7JdC6dj/zYS6OOhMpeFe7ZHHmLvfOsZ6T+wVGYHpih8Liy0VthJJ8PW0ZcTg==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 08/19] serdev: Provide modalias attribute for modalias devices
Date: Tue, 29 May 2018 15:10:03 +0200
Message-Id: <20180529131014.18641-9-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create modalias sysfs attribute for modalias devices.
This is required by modprobe/udev to autoload the serdev driver.

Eg:
root@qt5022:~# cat /sys/bus/serial/devices/serial1-0/modalias
serdev:ttydev

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index e695fa649a6d..a9c935f68076 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -23,12 +23,17 @@ static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	int len;
+	struct serdev_device *serdev = to_serdev_device(dev);
 
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
-	return of_device_modalias(dev, buf, PAGE_SIZE);
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	return sprintf(buf, "%s%s\n", SERDEV_MODULE_PREFIX, serdev->modalias);
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.17.0
