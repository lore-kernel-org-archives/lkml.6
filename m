Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7128AECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBF02075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="KujOtdXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBF02075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbeGRKRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:17:21 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:33962 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730910AbeGRKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:17:21 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id A7116B007CB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:40:18 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=x-mailer:message-id:date:date:subject:subject:to:from:from;
         s=dkim; t=1531906818; x=1532770819; bh=WSd/9wvzx+t7T41QY3yKInol
        V8cyC+RL5+TKQjyvhRo=; b=KujOtdXRchk83w9XarzjwLBv5QbmO0nBErJUacdV
        gREP7wy9FrbVu/aT0MdBMrSqm/ooJjvKJHbfmwJu3asokpOEwsJWnB+sTN+y8SVo
        MQN8ycSLY08R+aAsuz3JlsQ6nrYrL1fLtsx4MF5gR6C5ghnPpy2NfevG1fvdRfQK
        T5I=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J5i-uGd031XL for <linux-kernel@vger.kernel.org>;
        Wed, 18 Jul 2018 11:40:18 +0200 (CEST)
Received: from localhost.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id D6A9EB0018C;
        Wed, 18 Jul 2018 11:40:16 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 2/4] rtc: ds1307: support m41t11 variant
Date:   Wed, 18 Jul 2018 11:40:03 +0200
Message-Id: <20180718094006.105675-1-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index aa4a161bae98..0162a600ff1b 100644
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
@@ -227,6 +228,11 @@ static const struct chip_desc chips[last_ds_type] = {
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
@@ -249,6 +255,7 @@ static const struct i2c_device_id ds1307_id[] = {
 	{ "ds3231", ds_3231 },
 	{ "m41t0", m41t0 },
 	{ "m41t00", m41t00 },
+	{ "m41t11", m41t11 },
 	{ "mcp7940x", mcp794xx },
 	{ "mcp7941x", mcp794xx },
 	{ "pt7c4338", ds_1307 },
@@ -305,6 +312,10 @@ static const struct of_device_id ds1307_of_match[] = {
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
@@ -347,6 +358,7 @@ static const struct acpi_device_id ds1307_acpi_ids[] = {
 	{ .id = "DS3231", .driver_data = ds_3231 },
 	{ .id = "M41T0", .driver_data = m41t0 },
 	{ .id = "M41T00", .driver_data = m41t00 },
+	{ .id = "M41T11", .driver_data = m41t11 },
 	{ .id = "MCP7940X", .driver_data = mcp794xx },
 	{ .id = "MCP7941X", .driver_data = mcp794xx },
 	{ .id = "PT7C4338", .driver_data = ds_1307 },
@@ -1576,6 +1588,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case ds_1307:
 	case m41t0:
 	case m41t00:
+	case m41t11:
 		/* clock halted?  turn it on, so clock can tick. */
 		if (tmp & DS1307_BIT_CH) {
 			regmap_write(ds1307->regmap, DS1307_REG_SECS, 0);
@@ -1641,6 +1654,7 @@ static int ds1307_probe(struct i2c_client *client,
 	case ds_1340:
 	case m41t0:
 	case m41t00:
+	case m41t11:
 		/*
 		 * NOTE: ignores century bits; fix before deploying
 		 * systems that will run through year 2100.
-- 
2.17.1

