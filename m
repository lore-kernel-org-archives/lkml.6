Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934467AbeE2NPn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:15:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53417 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934505AbeE2NKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:43 -0400
X-Google-Smtp-Source: AB8JxZpTDT+XSm6ZilV9mxdner1OllvW3tcSs5dCkjQP1GfHyxD4BGFMWey1oxles7XETmBl11P8tw==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 06/19] serdev: Support bus matching with modalias field
Date: Tue, 29 May 2018 15:10:01 +0200
Message-Id: <20180529131014.18641-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match devices to drivers by their modalias when the ACPI and the OF
match fails.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index df93b727e984..2c79f47fc0db 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -79,8 +79,23 @@ static const struct device_type serdev_ctrl_type = {
 	.release	= serdev_ctrl_release,
 };
 
+static int serdev_match_id(const struct serdev_device_id *id,
+			   const struct serdev_device *sdev)
+{
+	while (id->name[0]) {
+		if (!strcmp(sdev->modalias, id->name))
+			return 1;
+		id++;
+	}
+
+	return 0;
+}
+
 static int serdev_device_match(struct device *dev, struct device_driver *drv)
 {
+	const struct serdev_device *sdev = to_serdev_device(dev);
+	const struct serdev_device_driver *sdrv = to_serdev_device_driver(drv);
+
 	if (!is_serdev_device(dev))
 		return 0;
 
@@ -88,7 +103,13 @@ static int serdev_device_match(struct device *dev, struct device_driver *drv)
 	if (acpi_driver_match_device(dev, drv))
 		return 1;
 
-	return of_driver_match_device(dev, drv);
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (sdrv->id_table)
+		return serdev_match_id(sdrv->id_table, sdev);
+
+	return strcmp(sdev->modalias, drv->name) == 0;
 }
 
 /**
-- 
2.17.0
