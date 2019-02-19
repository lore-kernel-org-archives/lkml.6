Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfBSMAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:00:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:38297 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbfBSMAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:00:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 04:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="148009350"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2019 04:00:04 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: intel_cht_int33fe: Create fwnode for max17047
Date:   Tue, 19 Feb 2019 14:59:59 +0300
Message-Id: <20190219115959.55553-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating a software node for max17047 when ACPI tables don't
have a device node for it.

While here, moving max17047 handling to its own function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 86 +++++++++++++++---------
 1 file changed, 53 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 4857a57cfff5..81721976b00c 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,6 +34,7 @@ struct cht_int33fe_data {
 	struct i2c_client *pi3usb30532;
 	struct fwnode_handle *port_node;
 	struct fwnode_handle *fusb302_node;
+	struct fwnode_handle *max17047_node;
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
 };
@@ -66,14 +67,6 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
 	return 1;
 }
 
-static struct i2c_client *cht_int33fe_find_max17047(void)
-{
-	struct i2c_client *max17047 = NULL;
-
-	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
-	return max17047;
-}
-
 static const char * const max17047_suppliers[] = { "bq24190-charger" };
 
 static const struct property_entry max17047_props[] = {
@@ -81,6 +74,43 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+static int
+cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
+{
+	struct i2c_client *max17047 = NULL;
+	struct i2c_board_info board_info;
+	int ret;
+
+	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
+	if (max17047) {
+		/* Pre-existing i2c-client for the max17047, add device-props */
+		ret = device_add_properties(&max17047->dev, max17047_props);
+		if (ret)
+			return ret;
+		/* And re-probe to get the new device-props applied. */
+		ret = device_reprobe(&max17047->dev);
+		if (ret)
+			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
+		return 0;
+	}
+
+	data->max17047_node = fwnode_create_software_node(max17047_props, NULL);
+	if (IS_ERR(data->max17047_node))
+		return PTR_ERR(data->max17047_node);
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+	board_info.dev_name = "max17047";
+	board_info.fwnode = data->max17047_node;
+	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+	if (IS_ERR(data->max17047)) {
+		fwnode_remove_software_node(data->max17047_node);
+		return PTR_ERR(data->max17047);
+	}
+
+	return 0;
+}
+
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
 	{ }
@@ -114,7 +144,6 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
-	struct i2c_client *max17047;
 	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
@@ -174,38 +203,25 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
+	ret = cht_int33fe_max17047(dev, data);
+	if (ret)
+		return ret;
+
 	/* Node for the FUSB302 controller */
 	data->fusb302_node = fwnode_create_software_node(fusb302_props, NULL);
-	if (IS_ERR(data->fusb302_node))
-		return PTR_ERR(data->fusb302_node);
+	if (IS_ERR(data->fusb302_node)) {
+		ret = PTR_ERR(data->fusb302_node);
+		goto out_remove_max17047_node;
+	}
 
 	/* Node for the connector (FUSB302 is the parent) */
 	data->port_node = fwnode_create_software_node(usb_connector_props,
 						      data->fusb302_node);
 	if (IS_ERR(data->port_node)) {
 		fwnode_remove_software_node(data->fusb302_node);
-		return PTR_ERR(data->port_node);
-	}
-
-	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
-	max17047 = cht_int33fe_find_max17047();
-	if (max17047) {
-		/* Pre-existing i2c-client for the max17047, add device-props */
-		ret = device_add_properties(&max17047->dev, max17047_props);
-		if (ret)
-			return ret;
-		/* And re-probe to get the new device-props applied. */
-		ret = device_reprobe(&max17047->dev);
-		if (ret)
-			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
-	} else {
-		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
-		board_info.dev_name = "max17047";
-		board_info.properties = max17047_props;
-		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
-		if (IS_ERR(data->max17047))
-			return PTR_ERR(data->max17047);
+		ret = PTR_ERR(data->port_node);
+		goto out_remove_max17047_node;
 	}
 
 	data->connections[0].endpoint[0] = "port0";
@@ -256,6 +272,9 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	fwnode_remove_software_node(data->port_node);
 	fwnode_remove_software_node(data->fusb302_node);
 
+out_remove_max17047_node:
+	fwnode_remove_software_node(data->max17047_node);
+
 	return ret;
 }
 
@@ -270,6 +289,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	device_connections_remove(data->connections);
 	fwnode_remove_software_node(data->port_node);
 	fwnode_remove_software_node(data->fusb302_node);
+	fwnode_remove_software_node(data->max17047_node);
 
 	return 0;
 }
-- 
2.20.1

