Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1780BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3D2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF3D2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbeJQQyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:54:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbeJQQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:54:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1428F368E7;
        Wed, 17 Oct 2018 08:59:34 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-246.ams2.redhat.com [10.36.116.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82E721713E;
        Wed, 17 Oct 2018 08:59:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / scan: Create platform device for INT33FE ACPI nodes
Date:   Wed, 17 Oct 2018 10:59:28 +0200
Message-Id: <20181017085928.13406-2-hdegoede@redhat.com>
In-Reply-To: <20181017085928.13406-1-hdegoede@redhat.com>
References: <20181017085928.13406-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 17 Oct 2018 08:59:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bay and Cherry Trail devices with a Dollar Cove or Whiskey Cove PMIC
have an ACPI node with a HID of INT33FE which is a "virtual" battery
device implementing a standard ACPI battery interface which depends upon
a proprietary, undocument OpRegion called BMOP. Since we do have docs
for the actual fuel-gauges used on these boards we instead use native
fuel-gauge drivers talking directly to the fuel-gauge ICs on boards which
rely on this INT33FE device for their battery monitoring.

On boards with a Dollar Cove PMIC the INT33FE device's resources (_CRS)
describe a non-existing I2C client at address 0x6b with a bus-speed of
100KHz. This is a problem on some boards since there are actual devices
on that same bus which need a speed of 400KHz to function properly.

This commit adds the INT33FE HID to the list of devices with I2C resources
which should be enumerated as a platform-device rather then letting the
i2c-core instantiate an i2c-client matching the first I2C resource,
so that its bus-speed will not influence the max speed of the I2C bus.
This fixes e.g. the touchscreen not working on the Teclast X98 II Plus.

The INT33FE device on boards with a Whiskey Cove PMIC is somewhat special.
Its first I2C resource is for a secondary I2C address of the PMIC itself,
which is already described in an ACPI device with an INT34D3 HID.

But it has 3 more I2C resources describing 3 other chips for which we do
need to instantiate I2C clients and which need device-connections added
between them for things to work properly. This special case is handled by
the drivers/platform/x86/intel_cht_int33fe.c code.

Before this commit that code was binding to the i2c-client instantiated
for the secondary I2C address of the PMIC, since we now instantiate a
platform device for the INT33FE device instead, this commit also changes
the intel_cht_int33fe driver from an i2c driver to a platform driver.

This also brings the intel_cht_int33fe drv inline with how we instantiate
multiple i2c clients from a single ACPI device in other cases, as done
by the drivers/platform/x86/i2c-multi-instantiate.c code.

Reported-and-tested-by: Alexander Meiler <alex.meiler@protonmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c                      |  1 +
 drivers/platform/x86/intel_cht_int33fe.c | 24 +++++++++---------------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e1b6231cfa1c..1dcc48b9d33c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1550,6 +1550,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 */
 	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
 		{"BSG1160", },
+		{"INT33FE", },
 		{}
 	};
 
diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index a26f410800c2..f40b1c192106 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -88,9 +89,9 @@ static const struct property_entry fusb302_props[] = {
 	{ }
 };
 
-static int cht_int33fe_probe(struct i2c_client *client)
+static int cht_int33fe_probe(struct platform_device *pdev)
 {
-	struct device *dev = &client->dev;
+	struct device *dev = &pdev->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
 	struct i2c_client *max17047;
@@ -207,7 +208,7 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (!data->pi3usb30532)
 		goto out_unregister_fusb302;
 
-	i2c_set_clientdata(client, data);
+	platform_set_drvdata(pdev, data);
 
 	return 0;
 
@@ -223,9 +224,9 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 }
 
-static int cht_int33fe_remove(struct i2c_client *i2c)
+static int cht_int33fe_remove(struct platform_device *pdev)
 {
-	struct cht_int33fe_data *data = i2c_get_clientdata(i2c);
+	struct cht_int33fe_data *data = platform_get_drvdata(pdev);
 
 	i2c_unregister_device(data->pi3usb30532);
 	i2c_unregister_device(data->fusb302);
@@ -237,29 +238,22 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static const struct i2c_device_id cht_int33fe_i2c_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, cht_int33fe_i2c_id);
-
 static const struct acpi_device_id cht_int33fe_acpi_ids[] = {
 	{ "INT33FE", },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
 
-static struct i2c_driver cht_int33fe_driver = {
+static struct platform_driver cht_int33fe_driver = {
 	.driver	= {
 		.name = "Intel Cherry Trail ACPI INT33FE driver",
 		.acpi_match_table = ACPI_PTR(cht_int33fe_acpi_ids),
 	},
-	.probe_new = cht_int33fe_probe,
+	.probe = cht_int33fe_probe,
 	.remove = cht_int33fe_remove,
-	.id_table = cht_int33fe_i2c_id,
-	.disable_i2c_core_irq_mapping = true,
 };
 
-module_i2c_driver(cht_int33fe_driver);
+module_platform_driver(cht_int33fe_driver);
 
 MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver");
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-- 
2.19.0

