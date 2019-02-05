Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA08BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00692175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfBETDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:03:23 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40569 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfBETDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:03:23 -0500
X-Originating-IP: 91.192.165.7
Received: from pc.localdomain (unknown [91.192.165.7])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F3B0D240009;
        Tue,  5 Feb 2019 19:03:18 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/2] power: supply: gpio-charger: Add support for charger status.
Date:   Tue,  5 Feb 2019 20:03:16 +0100
Message-Id: <20190205190316.19296-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205190316.19296-1-contact@artur-rojek.eu>
References: <20190205190316.19296-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce optional support of POWER_SUPPLY_PROP_STATUS for chargers
which provide charging status GPIO.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/power/supply/gpio-charger.c | 53 +++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 7e4f11d5a230..ebe986f09472 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -29,11 +29,13 @@
 
 struct gpio_charger {
 	unsigned int irq;
+	unsigned int status_irq;
 	bool wakeup_enabled;
 
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *gpiod;
+	struct gpio_desc *status;
 };
 
 static irqreturn_t gpio_charger_irq(int irq, void *devid)
@@ -59,6 +61,12 @@ static int gpio_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = gpiod_get_value_cansleep(gpio_charger->gpiod);
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (gpiod_get_value_cansleep(gpio_charger->status))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -93,8 +101,29 @@ static enum power_supply_type gpio_charger_get_type(struct device *dev)
 	return POWER_SUPPLY_TYPE_UNKNOWN;
 }
 
+static int gpio_charger_get_irq(struct device *dev, void *dev_id,
+				struct gpio_desc *gpio)
+{
+	int ret, irq = gpiod_to_irq(gpio);
+
+	if (irq > 0) {
+		ret = devm_request_any_context_irq(dev, irq, gpio_charger_irq,
+						   IRQF_TRIGGER_RISING |
+						   IRQF_TRIGGER_FALLING,
+						   dev_name(dev),
+						   dev_id);
+		if (ret < 0) {
+			dev_warn(dev, "Failed to request irq: %d\n", ret);
+			irq = 0;
+		}
+	}
+
+	return irq;
+}
+
 static enum power_supply_property gpio_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS /* Must always be last in the array. */
 };
 
 static int gpio_charger_probe(struct platform_device *pdev)
@@ -105,7 +134,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	struct gpio_charger *gpio_charger;
 	struct power_supply_desc *charger_desc;
 	unsigned long flags;
-	int irq, ret;
+	int ret;
 
 	if (!pdata && !dev->of_node) {
 		dev_err(dev, "No platform data\n");
@@ -151,9 +180,16 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_charger->gpiod);
 	}
 
+	gpio_charger->status = devm_gpiod_get_optional(dev, "status", GPIOD_IN);
+	if (IS_ERR(gpio_charger->status))
+		return PTR_ERR(gpio_charger->status);
+
 	charger_desc = &gpio_charger->charger_desc;
 	charger_desc->properties = gpio_charger_properties;
 	charger_desc->num_properties = ARRAY_SIZE(gpio_charger_properties);
+	/* Remove POWER_SUPPLY_PROP_STATUS from the supported properties. */
+	if (!gpio_charger->status)
+		charger_desc->num_properties -= 1;
 	charger_desc->get_property = gpio_charger_get_property;
 
 	psy_cfg.of_node = dev->of_node;
@@ -180,16 +216,11 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	irq = gpiod_to_irq(gpio_charger->gpiod);
-	if (irq > 0) {
-		ret = devm_request_any_context_irq(dev, irq, gpio_charger_irq,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(dev), gpio_charger->charger);
-		if (ret < 0)
-			dev_warn(dev, "Failed to request irq: %d\n", ret);
-		else
-			gpio_charger->irq = irq;
-	}
+	gpio_charger->irq = gpio_charger_get_irq(dev, gpio_charger->charger,
+						 gpio_charger->gpiod);
+	gpio_charger->status_irq = gpio_charger_get_irq(dev,
+							gpio_charger->charger,
+							gpio_charger->status);
 
 	platform_set_drvdata(pdev, gpio_charger);
 
-- 
2.20.1

