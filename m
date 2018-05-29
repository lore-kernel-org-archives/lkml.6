Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934515AbeE2NKn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:10:43 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50928 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934475AbeE2NKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:34 -0400
X-Google-Smtp-Source: AB8JxZqBzJOw7Xgn1Eva7A+bo3YsEzz88MFmB85HkfOyzCQboLDFtfTgD7RzI0EUEFS3W6y3Ag2/yg==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/19] serdev: Add id_table to serdev_device_driver
Date: Tue, 29 May 2018 15:09:56 +0200
Message-Id: <20180529131014.18641-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, serdev device driver can only be used with devices that are
nodes of a device tree, or are part of the ACPI table.

Id_table will be used for devices that are created at runtime or that
are not part of the device tree nor the ACPI table.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 include/linux/mod_devicetable.h | 10 ++++++++++
 include/linux/serdev.h          |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 7d361be2e24f..1877a4e43f1b 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -448,6 +448,16 @@ struct pci_epf_device_id {
 	kernel_ulong_t driver_data;
 };
 
+/* serdev */
+
+#define SERDEV_NAME_SIZE	32
+#define SERDEV_MODULE_PREFIX	"serdev:"
+
+struct serdev_device_id {
+	char name[SERDEV_NAME_SIZE];
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
 /* spi */
 
 #define SPI_NAME_SIZE	32
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index f153b2c7f0cd..62f1b085a794 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -15,6 +15,7 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
 
@@ -68,6 +69,7 @@ static inline struct serdev_device *to_serdev_device(struct device *d)
  * @remove:	unbinds this driver from the serdev device.
  */
 struct serdev_device_driver {
+	const struct serdev_device_id *id_table;
 	struct device_driver driver;
 	int	(*probe)(struct serdev_device *);
 	void	(*remove)(struct serdev_device *);
-- 
2.17.0
