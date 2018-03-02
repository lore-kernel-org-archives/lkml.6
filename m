Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELvZuDyLmt8ymr1/6ofrlf2jcHPuZVonu4AWKpIP9D0KnX/ZD2IuW5exijYgL9I4ZG/LMPWa
ARC-Seal: i=1; a=rsa-sha256; t=1519986081; cv=none;
        d=google.com; s=arc-20160816;
        b=qg/RqAFdbOKK6lo0Qc8QButxWVOjKEtnaQV4oggl/KThDIhok6+kMGOrPqqdW7U5xh
         prXLLf5bnZVRYJ6cyH+ottMUd5ho5R8uFfpy3KE7sSCh1yfyL8FOTrpBU0Qt8uxi1t/3
         T7tbRLd59XsK2cQvCsTDDpQuhTJjIwF4qWavgVYKdxGCvubNE36P8CQdnz1i7a/huzQH
         4/QkNsobngF/m+Qszle09JZmsks9mw0J0trQczGiFQBOfh+g33DQtA7/hehvJWBh/ySY
         418HTWm1A/HCzQSZfN3/KnFRnit4bXrivZKRLzYGDExrlpS/kbR4o8B8Hb10829qonzI
         g72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=SR8MG3eD8Lb7E9RC9Jmdl6SDp7TXg/VpBg43PO0U/Ac=;
        b=kcACqSdFCcwqfgqKDxf6e0VmiHRQPRJPozwKVRjx5ufA221uP7LgS9GNIcINTru2mI
         0MyxypDUBJHlkUnMAZKKVgNPCYYr/gp3gFgN16LiQp9Wzkuh6vs2Q6IYj8FpZw9ixZni
         6wTuSE7Nth7QGsdR9W8trihuD1J72Bq3EaIStUYsDDHedCzk4MbKzm1dXDfo4AU9Cqyr
         Btjip71UZclQWmW2EBeRm/y+2Ciazeo1VlLS97YSEA93lyAJy8NrHgULZ2YE0KeepP91
         Nu54xSsBmZXSTU2MVehnVbkG/l8PzoS/c4MOsH/9DUIaHf8qumuA0Gt+3i8skW5VG88q
         T/XQ==
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
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v6 11/12] platform/x86: intel_cht_int33fe: Add device connections for the Type-C port
Date: Fri,  2 Mar 2018 11:20:56 +0100
Message-Id: <20180302102057.8917-12-hdegoede@redhat.com>
In-Reply-To: <20180302102057.8917-1-hdegoede@redhat.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593820925434792660?=
X-GMAIL-MSGID: =?utf-8?q?1593820925434792660?=
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
