Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965494AbeEITeF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:34:05 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:33658 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEITeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:34:02 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v3 2/4] rtc: ds1307: support m41t11 variant
Date: Wed,  9 May 2018 21:33:53 +0200
Message-Id: <20180509193355.49466-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509193355.49466-1-giulio.benetti@micronovasrl.com>
References: <20180509193355.49466-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m41t11 variant is very similar to the already supported m41t00 and
m41t0, but it has also 56 bytes of NVRAM.

Add it to driver taking into account NVRAM section.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../devicetree/bindings/rtc/rtc-ds1307.txt         |  1 +
 drivers/rtc/rtc-ds1307.c                           | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
index d28d6e7f6ae8..ce6469c1a516 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
@@ -13,6 +13,7 @@ Required properties:
 	"maxim,ds3231",
 	"st,m41t0",
 	"st,m41t00",
+	"st,m41t11",
 	"microchip,mcp7940x",
 	"microchip,mcp7941x",
 	"pericom,pt7c4338",
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 32aadcbc377f..0ab0c166da83 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -44,6 +44,7 @@ enum ds_type {
 	ds_3231,
 	m41t0,
 	m41t00,
+	m41t11,
 	mcp794xx,
 	rx_8025,
 	rx_8130,
@@ -226,6 +227,11 @@ static const struct chip_desc chips[last_ds_type] = {
 		.irq_handler = rx8130_irq,
 		.rtc_ops = &rx8130_rtc_ops,
 	},
+	[m41t11] = {
+		/* this is battery backed SRAM */
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+	},
 	[mcp794xx] = {
 		.alarm		= 1,
 		/* this is battery backed SRAM */
@@ -248,6 +254,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds3231", ds_3231 },
 	{ "m41t0", m41t0 },
 	{ "m41t00", m41t00 },
+	{ "m41t11", m41t11 },
 	{ "mcp7940x", mcp794xx },
 	{ "mcp7941x", mcp794xx },
 	{ "pt7c4338", ds_1307 },
@@ -304,6 +311,10 @@ static const struct of_device_id ds1307_of_match[] = {
 		.compatible = "st,m41t00",
 		.data = (void *)m41t00
 	},
+	{
+		.compatible = "st,m41t11",
+		.data = (void *)m41t11
+	},
 	{
 		.compatible = "microchip,mcp7940x",
 		.data = (void *)mcp794xx
@@ -346,6 +357,7 @@ static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "DS3231", .driver_data = ds_3231 },
 	{ .id = "M41T0", .driver_data = m41t0 },
 	{ .id = "M41T00", .driver_data = m41t00 },
+	{ .id = "M41T11", .driver_data = m41t11 },
 	{ .id = "MCP7940X", .driver_data = mcp794xx },
 	{ .id = "MCP7941X", .driver_data = mcp794xx },
 	{ .id = "PT7C4338", .driver_data = ds_1307 },
@@ -1574,6 +1586,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case ds_1307:
 	case m41t0:
 	case m41t00:
+	case m41t11:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH) {
 			regmap_write(ds1307->regmap, DS1307_REG_SECS, 0);
@@ -1639,6 +1652,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case ds_1340:
 	case m41t0:
 	case m41t00:
+	case m41t11:
 		/*
 		 * NOTE: ignores century bits; fix before deploying
 		 * systems that will run through year 2100.
-- 
2.17.0
