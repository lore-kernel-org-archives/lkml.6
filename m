Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E2CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E0820663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E0820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeK0CDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:03:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:40719 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeK0CDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:03:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 07:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="90385747"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2018 07:09:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 420B483B; Mon, 26 Nov 2018 17:08:59 +0200 (EET)
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
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 13/13] iio: inv_mpu6050: Use i2c_acpi_get_i2c_resource() helper
Date:   Mon, 26 Nov 2018 17:08:58 +0200
Message-Id: <20181126150858.16901-14-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI provides a generic helper to get I2C Serial Bus resources.
Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index d78a10403bac..a961b5a06fe6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -91,18 +91,14 @@ static int asus_acpi_get_sensor_info(struct acpi_device *adev,
 
 static int acpi_i2c_check_resource(struct acpi_resource *ares, void *data)
 {
+	struct acpi_resource_i2c_serialbus *sb;
 	u32 *addr = data;
 
-	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-		struct acpi_resource_i2c_serialbus *sb;
-
-		sb = &ares->data.i2c_serial_bus;
-		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
-			if (*addr)
-				*addr |= (sb->slave_address << 16);
-			else
-				*addr = sb->slave_address;
-		}
+	if (i2c_acpi_get_i2c_resource(ares, &sb)) {
+		if (*addr)
+			*addr |= (sb->slave_address << 16);
+		else
+			*addr = sb->slave_address;
 	}
 
 	/* Tell the ACPI core that we already copied this address */
-- 
2.19.1

