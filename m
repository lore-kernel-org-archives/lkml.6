Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937116AbeE3DR5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 23:17:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38333 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935796AbeE3DRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 23:17:48 -0400
X-Google-Smtp-Source: ADUXVKJKw7QKUKoK0FuxQC2SvPV/uffOw+mJNwdp3zz2D8hrCHKw/eVmFtbynuzmevUyJ7WYngL4Wg==
From: Fabien Parent <fparent@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com, gpain@baylibre.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/3] power: supply: cros: add support for dedicated port
Date: Tue, 29 May 2018 20:17:03 -0700
Message-Id: <20180530031704.18597-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530031704.18597-1-fparent@baylibre.com>
References: <20180530031704.18597-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChromeOS devices can have one optional dedicated port.
The Dedicated port is unique and similar to the USB PD ports
except that it doesn't support as many properties.

The presence of a dedicated port is determined from whether the
EC's charger port count is equal to 'number of USB PD port' + 1.
The dedicated port ID is always the last valid port ID.

This commit keeps compatibility with Embedded Controllers that do not
support the new EC_CMD_CHARGE_PORT_COUNT command by setting
the number of charger port to be equal to the number of USB PD port
when this command fails.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/power/supply/cros_usbpd-charger.c | 115 +++++++++++++++++++---
 1 file changed, 101 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 3a0c96fd1bc1..808688a6586c 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -12,8 +12,12 @@
 #include <linux/power_supply.h>
 #include <linux/slab.h>
 
-#define CHARGER_DIR_NAME			"CROS_USBPD_CHARGER%d"
-#define CHARGER_DIR_NAME_LENGTH			sizeof(CHARGER_DIR_NAME)
+#define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
+#define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
+#define CHARGER_DIR_NAME_LENGTH		(sizeof(CHARGER_USBPD_DIR_NAME) >= \
+					 sizeof(CHARGER_DEDICATED_DIR_NAME) ? \
+					 sizeof(CHARGER_USBPD_DIR_NAME) : \
+					 sizeof(CHARGER_DEDICATED_DIR_NAME))
 #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
 #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
 
@@ -42,6 +46,7 @@ struct charger_data {
 	struct cros_ec_dev *ec_dev;
 	struct cros_ec_device *ec_device;
 	int num_charger_ports;
+	int num_usbpd_ports;
 	int num_registered_psy;
 	struct port_data *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block notifier;
@@ -58,6 +63,12 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
 	POWER_SUPPLY_PROP_USB_TYPE
 };
 
+static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
 static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_UNKNOWN,
 	POWER_SUPPLY_USB_TYPE_SDP,
@@ -69,6 +80,11 @@ static enum power_supply_usb_type cros_usbpd_charger_usb_types[] = {
 	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID
 };
 
+static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
+{
+	return port->port_number >= port->charger->num_usbpd_ports;
+}
+
 static int cros_usbpd_charger_ec_command(struct charger_data *charger,
 					 unsigned int version,
 					 unsigned int command,
@@ -102,6 +118,23 @@ static int cros_usbpd_charger_ec_command(struct charger_data *charger,
 }
 
 static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
+{
+	struct ec_response_charge_port_count resp;
+	int ret;
+
+	ret = cros_usbpd_charger_ec_command(charger, 0,
+					    EC_CMD_CHARGE_PORT_COUNT,
+					    NULL, 0, &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_err(charger->dev,
+			"Unable to get the number of ports (err:0x%x)\n", ret);
+		return ret;
+	}
+
+	return resp.port_count;
+}
+
+static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
 {
 	struct ec_response_usb_pd_ports resp;
 	int ret;
@@ -246,7 +279,10 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 		port->psy_usb_type = POWER_SUPPLY_USB_TYPE_SDP;
 	}
 
-	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
+	if (cros_usbpd_charger_port_is_dedicated(port))
+		port->psy_desc.type = POWER_SUPPLY_TYPE_MAINS;
+	else
+		port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 
 	dev_dbg(dev,
 		"Port %d: type=%d vmax=%d vnow=%d cmax=%d clim=%d pmax=%d\n",
@@ -281,7 +317,8 @@ static int cros_usbpd_charger_get_port_status(struct port_data *port,
 	if (ret < 0)
 		return ret;
 
-	ret = cros_usbpd_charger_get_discovery_info(port);
+	if (!cros_usbpd_charger_port_is_dedicated(port))
+		ret = cros_usbpd_charger_get_discovery_info(port);
 	port->last_update = jiffies;
 
 	return ret;
@@ -425,17 +462,56 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 
 	platform_set_drvdata(pd, charger);
 
+	/*
+	 * We need to know the number of USB PD ports in order to know whether
+	 * there is a dedicated port. The dedicated port will always be
+	 * after the USB PD ports, and there should be only one.
+	 */
+	charger->num_usbpd_ports =
+		cros_usbpd_charger_get_usbpd_num_ports(charger);
+	if (charger->num_usbpd_ports <= 0) {
+		/*
+		 * This can happen on a system that doesn't support USB PD.
+		 * Log a message, but no need to warn.
+		 */
+		dev_info(dev, "No USB PD charging ports found\n");
+	}
+
 	charger->num_charger_ports = cros_usbpd_charger_get_num_ports(charger);
-	if (charger->num_charger_ports <= 0) {
+	if (charger->num_charger_ports < 0) {
 		/*
 		 * This can happen on a system that doesn't support USB PD.
 		 * Log a message, but no need to warn.
+		 * Older ECs do not support the above command, in that case
+		 * let's set up the number of charger ports equal to the number
+		 * of USB PD ports
+		 */
+		dev_info(dev, "Could not get charger port count\n");
+		charger->num_charger_ports = charger->num_usbpd_ports;
+	}
+
+	if (charger->num_charger_ports <= 0) {
+		/*
+		 * This can happen on a system that doesn't support USB PD and
+		 * doesn't have a dedicated port.
+		 * Log a message, but no need to warn.
 		 */
 		dev_info(dev, "No charging ports found\n");
 		ret = -ENODEV;
 		goto fail_nowarn;
 	}
 
+	/*
+	 * Sanity checks on the number of ports:
+	 *  there should be at most 1 dedicated port
+	 */
+	if (charger->num_charger_ports < charger->num_usbpd_ports ||
+	    charger->num_charger_ports > (charger->num_usbpd_ports + 1)) {
+		dev_err(dev, "Unexpected number of charge port count\n");
+		ret = -EPROTO;
+		goto fail_nowarn;
+	}
+
 	for (i = 0; i < charger->num_charger_ports; i++) {
 		struct power_supply_config psy_cfg = {};
 
@@ -447,22 +523,33 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
 
 		port->charger = charger;
 		port->port_number = i;
-		sprintf(port->name, CHARGER_DIR_NAME, i);
 
 		psy_desc = &port->psy_desc;
-		psy_desc->name = port->name;
-		psy_desc->type = POWER_SUPPLY_TYPE_USB;
 		psy_desc->get_property = cros_usbpd_charger_get_prop;
 		psy_desc->external_power_changed =
 					cros_usbpd_charger_power_changed;
-		psy_desc->properties = cros_usbpd_charger_props;
-		psy_desc->num_properties =
-					ARRAY_SIZE(cros_usbpd_charger_props);
-		psy_desc->usb_types = cros_usbpd_charger_usb_types;
-		psy_desc->num_usb_types =
-				ARRAY_SIZE(cros_usbpd_charger_usb_types);
 		psy_cfg.drv_data = port;
 
+		if (cros_usbpd_charger_port_is_dedicated(port)) {
+			sprintf(port->name, CHARGER_DEDICATED_DIR_NAME);
+			psy_desc->type = POWER_SUPPLY_TYPE_MAINS;
+			psy_desc->properties =
+				cros_usbpd_dedicated_charger_props;
+			psy_desc->num_properties =
+				ARRAY_SIZE(cros_usbpd_dedicated_charger_props);
+		} else {
+			sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
+			psy_desc->type = POWER_SUPPLY_TYPE_USB;
+			psy_desc->properties = cros_usbpd_charger_props;
+			psy_desc->num_properties =
+				ARRAY_SIZE(cros_usbpd_charger_props);
+			psy_desc->usb_types = cros_usbpd_charger_usb_types;
+			psy_desc->num_usb_types =
+				ARRAY_SIZE(cros_usbpd_charger_usb_types);
+		}
+
+		psy_desc->name = port->name;
+
 		psy = devm_power_supply_register_no_ws(dev, psy_desc,
 						       &psy_cfg);
 		if (IS_ERR(psy)) {
-- 
2.17.0
