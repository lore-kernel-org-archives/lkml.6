Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8FC24FB0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EAlBGgGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8FC24FB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932097AbeGBSMy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:12:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47298 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeGBSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62ICJUB021213;
        Mon, 2 Jul 2018 13:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530555139;
        bh=8dSTKhrLAxjwZbEM0vByHtuyhwXB+A2b0Dnf/FadgIg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EAlBGgGkC+KthjIrb+AlFH4EtYaezRbNkTuu04J8xqGjnKJce/RBE8TYaUzn8mpV9
         maVKVCyPQTQkleTpkdainFNiFNaZJ9TeI3HVx2kzxTMw01dWomgdIgg2x0DnoA6TGN
         mqA+HxwctKqENVzismaqu/G9zmEoOAYvW2inaunw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62ICJa9025277;
        Mon, 2 Jul 2018 13:12:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 13:12:18 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 13:12:18 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62ICIYH017666;
        Mon, 2 Jul 2018 13:12:18 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.180.30])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w62ICIx02911;
        Mon, 2 Jul 2018 13:12:18 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <andy.shevchenko@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/4] leds: lm3692x: Change DT calls to fwnode calls
Date:   Mon, 2 Jul 2018 13:12:14 -0500
Message-ID: <20180702181216.19660-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180702181216.19660-1-dmurphy@ti.com>
References: <20180702181216.19660-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the code to use the fwnode calls as opposed
to ARM DT node api's.

This allows the device to be used with either DT
configurations or ACPI definitions.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3692x.c | 38 ++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 1a06d8c97789..ade4abfceb46 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -267,30 +267,15 @@ static int lm3692x_init(struct lm3692x_led *led)
 static int lm3692x_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	int ret;
+	struct fwnode_handle *child = NULL;
 	struct lm3692x_led *led;
-	struct device_node *np = client->dev.of_node;
-	struct device_node *child_node;
 	const char *name;
+	int ret;
 
 	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
 		return -ENOMEM;
 
-	for_each_available_child_of_node(np, child_node) {
-		led->led_dev.default_trigger = of_get_property(child_node,
-						    "linux,default-trigger",
-						    NULL);
-
-		ret = of_property_read_string(child_node, "label", &name);
-		if (!ret)
-			snprintf(led->label, sizeof(led->label),
-				 "%s:%s", id->name, name);
-		else
-			snprintf(led->label, sizeof(led->label),
-				 "%s::backlight_cluster", id->name);
-	};
-
 	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
 						   "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(led->enable_gpio)) {
@@ -323,6 +308,25 @@ static int lm3692x_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	child = device_get_next_child_node(&led->client->dev, child);
+	if (!child) {
+		dev_err(&led->client->dev, "No LED Child node\n");
+		return ret;
+	}
+
+	fwnode_property_read_string(child, "linux,default-trigger",
+				    &led->led_dev.default_trigger);
+
+	ret = fwnode_property_read_string(child, "label", &name);
+	if (ret)
+		snprintf(led->label, sizeof(led->label),
+			"%s::", led->client->name);
+	else
+		snprintf(led->label, sizeof(led->label),
+			 "%s:%s", led->client->name, name);
+
+	led->led_dev.dev->of_node = to_of_node(child);
+
 	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
 	if (ret) {
 		dev_err(&client->dev, "led register err: %d\n", ret);
-- 
2.17.0.582.gccdcbd54c

