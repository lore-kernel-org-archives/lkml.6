Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E706C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC45208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfBSMAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:00:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:38297 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfBSMAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:00:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 04:00:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="148009291"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2019 04:00:02 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
Date:   Tue, 19 Feb 2019 14:59:58 +0300
Message-Id: <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI, and now also in DT, the USB connectors usually have
their own device nodes. In case of USB Type-C, those
connector (port) nodes are child nodes of the controller or
PHY device, in our case the fusb302. The software fwnodes
allow us to create a similar child node for fusb302 that
represents the connector also on Intel CHT.

This makes it possible replace the fusb302 specific device
properties which were deprecated with the common USB
connector properties that tcpm.c is able to use directly.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 48 ++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 6fa3cced6f8e..4857a57cfff5 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/usb/pd.h>
 
 #define EXPECTED_PTYPE		4
 
@@ -31,6 +32,8 @@ struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
+	struct fwnode_handle *port_node;
+	struct fwnode_handle *fusb302_node;
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
 };
@@ -80,9 +83,29 @@ static const struct property_entry max17047_props[] = {
 
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
+	{ }
+};
+
+#define PDO_FIXED_FLAGS \
+	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
+
+static const u32 src_pdo[] = {
+	PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
+};
+
+static const u32 snk_pdo[] = {
+	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
+	PDO_VAR(5000, 12000, 3000),
+};
+
+static const struct property_entry usb_connector_props[] = {
+	PROPERTY_ENTRY_STRING("name", "connector"),
+	PROPERTY_ENTRY_STRING("data-role", "dual"),
+	PROPERTY_ENTRY_STRING("power-role", "dual"),
+	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
+	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
+	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 36000000),
 	{ }
 };
 
@@ -151,6 +174,19 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	/* Node for the FUSB302 controller */
+	data->fusb302_node = fwnode_create_software_node(fusb302_props, NULL);
+	if (IS_ERR(data->fusb302_node))
+		return PTR_ERR(data->fusb302_node);
+
+	/* Node for the connector (FUSB302 is the parent) */
+	data->port_node = fwnode_create_software_node(usb_connector_props,
+						      data->fusb302_node);
+	if (IS_ERR(data->port_node)) {
+		fwnode_remove_software_node(data->fusb302_node);
+		return PTR_ERR(data->port_node);
+	}
+
 	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
 	max17047 = cht_int33fe_find_max17047();
 	if (max17047) {
@@ -187,7 +223,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
-	board_info.properties = fusb302_props;
+	board_info.fwnode = data->fusb302_node;
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -217,6 +253,8 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	fwnode_remove_software_node(data->port_node);
+	fwnode_remove_software_node(data->fusb302_node);
 
 	return ret;
 }
@@ -230,6 +268,8 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	fwnode_remove_software_node(data->port_node);
+	fwnode_remove_software_node(data->fusb302_node);
 
 	return 0;
 }
-- 
2.20.1

