Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0AE20660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0AE20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeK1WrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:47:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:50067 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbeK1WrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:47:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 03:45:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="278185017"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2018 03:45:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6B9DD1D1; Wed, 28 Nov 2018 13:45:36 +0200 (EET)
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
Subject: [PATCH v5 02/15] platform/x86: intel_cht_int33fe: Accept errors of i2c_acpi_new_device()
Date:   Wed, 28 Nov 2018 13:45:22 +0200
Message-Id: <20181128114535.80223-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the future i2c_acpi_new_device() will return error pointer in some cases.
Prepare intel_cht_int33fe driver to support that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 28 +++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 431151d4e611..367d6e304ade 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -168,8 +168,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		board_info.dev_name = "max17047";
 		board_info.properties = max17047_props;
 		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
-		if (!data->max17047)
-			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+		if (IS_ERR(data->max17047))
+			ret = PTR_ERR(data->max17047);
+		else if (!data->max17047)
+			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+		else
+			ret = 0;
+		if (ret)
+			return ret;
 	}
 
 	data->connections[0].endpoint[0] = "port0";
@@ -194,7 +200,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
-	if (!data->fusb302)
+	if (IS_ERR(data->fusb302))
+		ret = PTR_ERR(data->fusb302);
+	else if (!data->fusb302)
+		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	else
+		ret = 0;
+	if (ret)
 		goto out_unregister_max17047;
 
 	memset(&board_info, 0, sizeof(board_info));
@@ -202,7 +214,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
-	if (!data->pi3usb30532)
+	if (IS_ERR(data->pi3usb30532))
+		ret = PTR_ERR(data->pi3usb30532);
+	else if (!data->pi3usb30532)
+		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	else
+		ret = 0;
+	if (ret)
 		goto out_unregister_fusb302;
 
 	platform_set_drvdata(pdev, data);
@@ -217,7 +235,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	device_connections_remove(data->connections);
 
-	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	return ret;
 }
 
 static int cht_int33fe_remove(struct platform_device *pdev)
-- 
2.19.2

