Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE234C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72169208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72169208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeKUC3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:29:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:25307 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbeKUC3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:29:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 07:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="282706104"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2018 07:59:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AFDDF973; Tue, 20 Nov 2018 17:59:25 +0200 (EET)
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
Subject: [PATCH v1 08/15] i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
Date:   Tue, 20 Nov 2018 17:59:17 +0200
Message-Id: <20181120155924.10773-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides current two users one more is coming. Definitely makes sense to
introduce a helper.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 31 +++++++++++++++++++------------
 include/linux/acpi.h        | 11 +++++++++++
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 99553b1469b4..59b8b191d752 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -45,6 +45,23 @@ struct i2c_acpi_lookup {
 	u32 min_speed;
 };
 
+bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
+			       struct acpi_resource_i2c_serialbus **i2c)
+{
+	struct acpi_resource_i2c_serialbus *sb;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return false;
+
+	sb = &ares->data.i2c_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+		return false;
+
+	*i2c = sb;
+	return true;
+}
+EXPORT_SYMBOL_GPL(i2c_acpi_get_i2c_resource);
+
 static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 {
 	struct i2c_acpi_lookup *lookup = data;
@@ -52,11 +69,7 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	struct acpi_resource_i2c_serialbus *sb;
 	acpi_status status;
 
-	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
-		return 1;
-
-	sb = &ares->data.i2c_serial_bus;
-	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+	if (info->addr || !i2c_acpi_get_i2c_resource(ares, &sb))
 		return 1;
 
 	if (lookup->index != -1 && lookup->n++ != lookup->index)
@@ -529,13 +542,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 		goto err;
 	}
 
-	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-		ret = AE_BAD_PARAMETER;
-		goto err;
-	}
-
-	sb = &ares->data.i2c_serial_bus;
-	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
+	if (!value64 || !i2c_acpi_get_i2c_resource(ares, &sb)) {
 		ret = AE_BAD_PARAMETER;
 		goto err;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed80f147bd50..6afc6e3c4c5c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1054,6 +1054,17 @@ static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 }
 #endif
 
+#if defined(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
+bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
+			       struct acpi_resource_i2c_serialbus **i2c);
+#else
+static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
+					     struct acpi_resource_i2c_serialbus **i2c)
+{
+	return false;
+}
+#endif
+
 /* Device properties */
 
 #ifdef CONFIG_ACPI
-- 
2.19.1

