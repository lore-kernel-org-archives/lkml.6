Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C25C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBCD2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="l6nVF+8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBCD2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeGYSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:38:55 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:37928 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeGYSiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:38:55 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 7B1AAB008F3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:26:17 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:to:from:from; s=dkim; t=1532539577; x=1533403578; bh=qe
        31YqFxT3xR2/x5Z+7smUqFTcNFpQfXYEb/Fm+3N1Y=; b=l6nVF+8XsCWHh0tzic
        tck28K3yj3lhHKsPZlHI7Lw8sFm7Y/gTLB7NlFqCizrF8SsyHlrdhLsRpT+k/dtw
        Ob4biLV1ylZCe/t8wYmwKd8mumnFXfg9n2MoiPyHinJjF9mwFGT27H/KfTSg0S+6
        FIxnf8Rh0/mQPVbfZy2DFYdVA=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3afwx1vml44I for <linux-kernel@vger.kernel.org>;
        Wed, 25 Jul 2018 19:26:17 +0200 (CEST)
Received: from ubuntu.localdomain (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id B7BF4B00749;
        Wed, 25 Jul 2018 19:26:15 +0200 (CEST)
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
To:     alexandre.belloni@bootlin.com
Cc:     a.zummo@towertech.it, andy.shevchenko@gmail.com, robh@kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v11 2/4] rtc: ds1307: support m41t11 variant
Date:   Wed, 25 Jul 2018 19:26:03 +0200
Message-Id: <20180725172605.108040-2-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
References: <20180725172605.108040-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The m41t11 variant is very similar to the already supported m41t00 and
m41t0, but it has also 56 bytes of NVRAM.

Add it to driver taking into account NVRAM section.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
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

