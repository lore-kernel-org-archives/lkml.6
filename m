Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05CC20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05CC20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeK1Wtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:49:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:50648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbeK1WrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:47:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="95262412"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2018 03:45:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 052E86BA; Wed, 28 Nov 2018 13:45:36 +0200 (EET)
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
Subject: [PATCH v5 11/15] platform/x86: i2c-multi-instantiate: Distinguish IRQ resource type
Date:   Wed, 28 Nov 2018 13:45:31 +0200
Message-Id: <20181128114535.80223-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory patch switch the driver to distinguish IRQ resource type.
For now, only GpioInt() is supported.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 27 +++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index d99bbaed0ca2..99db3e336718 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -14,9 +15,14 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
+#define IRQ_RESOURCE_NONE	0
+#define IRQ_RESOURCE_GPIO	1
+
 struct i2c_inst_data {
 	const char *type;
-	int gpio_irq_idx;
+	unsigned int flags;
+	int irq_idx;
 };
 
 struct i2c_multi_inst_data {
@@ -88,16 +94,19 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 		snprintf(name, sizeof(name), "%s-%s", match->id,
 			 inst_data[i].type);
 		board_info.dev_name = name;
-		board_info.irq = 0;
-		if (inst_data[i].gpio_irq_idx != -1) {
-			ret = acpi_dev_gpio_irq_get(adev,
-						    inst_data[i].gpio_irq_idx);
+		switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
+		case IRQ_RESOURCE_GPIO:
+			ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
 			if (ret < 0) {
 				dev_err(dev, "Error requesting irq at index %d: %d\n",
-					inst_data[i].gpio_irq_idx, ret);
+					inst_data[i].irq_idx, ret);
 				goto error;
 			}
 			board_info.irq = ret;
+			break;
+		default:
+			board_info.irq = 0;
+			break;
 		}
 		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
 		if (IS_ERR(multi->clients[i])) {
@@ -135,9 +144,9 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
 }
 
 static const struct i2c_inst_data bsg1160_data[]  = {
-	{ "bmc150_accel", 0 },
-	{ "bmc150_magn", -1 },
-	{ "bmg160", -1 },
+	{ "bmc150_accel", IRQ_RESOURCE_GPIO, 0 },
+	{ "bmc150_magn" },
+	{ "bmg160" },
 	{}
 };
 
-- 
2.19.2

