Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELssN67b/A4Cg143TWHyw5Sm2Z+VmFJ0CgeTazAYsRGsJcwpV2eUw9hoU1ICZtOE0WdZ5AaW
ARC-Seal: i=1; a=rsa-sha256; t=1519670384; cv=none;
        d=google.com; s=arc-20160816;
        b=tJ07pbYlIJuVZpm/4waz0xSb5+7Gpq+oV8TI6AbXUS9FWhOBKu9V4WO1I2gF9S3GhB
         RYFoNqpH2fq/4LIb8ZRDUJSsO/Dw9NppS1Hl0A+NPMgi0q95Y2+Spzifzf/T4H1OYzym
         ccPs8CZ0wotvx0yo+O4kY9N9amxUTwD61IDMNZBVh+vMZLx8iFUT8qpUxQ9stiJlZH8d
         h53ZbpKNlSkxLf65lxfYa1VpzI3AWIgaxx/4Vra9RnBoavIzMooDrRnriIRTDJcP7cyP
         lcB7kXu+TCzUiE6k9nh1NAvIYrqFbP2oVZpivNK4h4QEZ6QDVkH6vHFHeay/Xhnv2XT3
         61fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=SR8MG3eD8Lb7E9RC9Jmdl6SDp7TXg/VpBg43PO0U/Ac=;
        b=s3/FYCTvP0t3QgtzSWrZ4f9diccHNjUghwlHN7EhaeOlZqM0FjAfLTgJVMWRa+G8cg
         vSJxxKDUNzHzedVfktddv5Nb8IsRxtWBKu+Pnu1VaWeduJjFypHXr6tRUIha/ZCQ5vmo
         oAivwvNA+d+jAyF7xkakly6hREMjAuyloFgavPkYVlNYwiloL9Qau9Nidc+LU9bwSqtV
         TqmqJmqbLyMxaF3Z+cvjmM6tiLcr5icabbx1Udla4CJJhYIWEh1Km1FHwRv+cUvKr5O6
         j/q7wT/ER8m24iKtdOjijxLsGPO4idVZYKcbm1OCOs2vOCpSxjXnFE9YsV7uwAmlUyCD
         T0FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v4 11/12] platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
Date: Mon, 26 Feb 2018 19:39:18 +0100
Message-Id: <20180226183919.24353-12-hdegoede@redhat.com>
In-Reply-To: <20180226183919.24353-1-hdegoede@redhat.com>
References: <20180226183919.24353-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454038760444546?=
X-GMAIL-MSGID: =?utf-8?q?1593489893109373678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We need to add device-connections for the Type-C mux/switch and usb-role
code to be able to find the PI3USB30532 Type-C cross-switch and the
device/host role-switch integrated in the CHT SoC.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-Replace Andy's Acked-by with his Reviewed-by

Changes in v2:
-Add Andy's Acked-by
-Add Heikki's Reviewed-by
---
 drivers/platform/x86/intel_cht_int33fe.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 380ef7ec094f..a3f8674f14da 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/connection.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -33,6 +34,8 @@ struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
+	/* Contain a list-head must be per device */
+	struct devcon connections[3];
 };
 
 /*
@@ -172,6 +175,20 @@ static int cht_int33fe_probe(struct i2c_client *client)
 			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
 	}
 
+	data->connections[0].endpoint[0] = "i2c-fusb302";
+	data->connections[0].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[0].id = "typec-switch";
+	data->connections[1].endpoint[0] = "i2c-fusb302";
+	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
+	data->connections[1].id = "typec-mux";
+	data->connections[2].endpoint[0] = "i2c-fusb302";
+	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
+	data->connections[2].id = "usb-role-switch";
+
+	add_device_connection(&data->connections[0]);
+	add_device_connection(&data->connections[1]);
+	add_device_connection(&data->connections[2]);
+
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
@@ -201,6 +218,10 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
+	remove_device_connection(&data->connections[2]);
+	remove_device_connection(&data->connections[1]);
+	remove_device_connection(&data->connections[0]);
+
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
 
@@ -213,6 +234,10 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
 	if (data->max17047)
 		i2c_unregister_device(data->max17047);
 
+	remove_device_connection(&data->connections[2]);
+	remove_device_connection(&data->connections[1]);
+	remove_device_connection(&data->connections[0]);
+
 	return 0;
 }
 
-- 
2.14.3
