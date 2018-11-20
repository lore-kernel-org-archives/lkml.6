Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8CBC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6162320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6162320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeKUCac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:30:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:58105 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbeKUC3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:29:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 07:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="106214826"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2018 07:59:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0EB65FF8; Tue, 20 Nov 2018 17:59:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Presser <steve@pressers.name>
Subject: [PATCH v1 14/15] ACPI / scan: Create platform device for BOSC0200 ACPI nodes
Date:   Tue, 20 Nov 2018 17:59:23 +0200
Message-Id: <20181120155924.10773-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some laptops the ACPI device with BOSC0200 _HID is representing
two accelerometers under one node.

We add an ID to the I2C multi instantiate list to enumerate
all I2C slaves correctly.

For reference here is the relevant DSDT blurb from the Yoga 11e:

Device (ACC)
{
	Name (_ADR, Zero)  // _ADR: Address
	Name (_HID, "BOSC0200")  // _HID: Hardware ID
	Name (_CID, "BOSC0200")  // _CID: Compatible ID
	Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
	Name (_UID, One)  // _UID: Unique ID
	Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
	{
		Name (RBUF, ResourceTemplate ()
		{
			I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
				0x00, ResourceConsumer, , Exclusive,
			)
			I2cSerialBusV2 (0x0018, ControllerInitiated, 0x00061A80,
				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
				0x00, ResourceConsumer, , Exclusive,
			)
		})
		Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
	}

Reported-by: Jeremy Cline <jeremy@jcline.org>
Cc: Steven Presser <steve@pressers.name>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c                          | 1 +
 drivers/iio/accel/bmc150-accel-i2c.c         | 1 -
 drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e9eda5558c1f..e46c877fa9f1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1539,6 +1539,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * which i2c_device_id to use for each resource.
 	 */
 	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
+		{"BOSC0200", },
 		{"BSG1160", },
 		{"INT33FE", },
 		{"INT3515", },
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 8ffc308d5fd0..9d22a4d9d568 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -64,7 +64,6 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMA250E",	bma250e},
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
-	{"BOSC0200"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index efaf34cbbc7b..c90137d30a98 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -151,6 +151,12 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct i2c_inst_data bosc0200_data[]  = {
+	{ "bmc150_accel" },
+	{ "bmc150_accel" },
+	{}
+};
+
 static const struct i2c_inst_data bsg1160_data[]  = {
 	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
 	{ "bmc150_magn" },
@@ -171,6 +177,7 @@ static const struct i2c_inst_data int3515_data[]  = {
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
 static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
+	{ "BOSC0200", (unsigned long)bosc0200_data },
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ "INT3515", (unsigned long)int3515_data },
 	{ }
-- 
2.19.1

