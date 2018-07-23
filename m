Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BC7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F032320779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="JglGGp6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F032320779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=castello.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeGWFcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:32:17 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.24]:28429 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbeGWFcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:32:16 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id D33D2414FE6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:09:31 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id hSA7fB5IFSjJAhSA7fx81H; Sun, 22 Jul 2018 23:09:31 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Oq8DE0ZVL8MkaMAaSb3QYKeaXhdbQxIhDYODtJiW/II=; b=JglGGp6jdj9K9Kd/MC82W5zbb
        k24S/fuytkZUbsqLhxBnVKyh/p25mcW2zcyKLrTCLD1rDMD8GDT/wUn/NMqQ2uFCgXfq3ZdMS0iY8
        kDRj52PXMX9lYcqRurybTfPuVaLUmNUgqoOsNKlmpdZpSfcVo0wFYl+Twk/Clz1iuyGIQwtWCQx+7
        qpP1JsTcjB/t0qFc401jwTWCHeBzmh+NvkqJn+OJaWPCpoddGnRy4tdHnE04tTo678BSdHFRGv1xi
        fpWkfnZCjxm4XC3knZX8daOcK0j+m2rqVmpkxBn0FmutNSQZuof030aTkSti7uqEJASN1JhqR4BjP
        +u+IZf5eQ==;
Received: from [191.189.20.114] (port=7927 helo=localhost.localdomain)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1fhSA6-001oyu-Um; Mon, 23 Jul 2018 01:09:31 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 1/4] power: supply: max17040: Add IRQ handler for low SOC alert
Date:   Mon, 23 Jul 2018 00:08:13 -0400
Message-Id: <20180723040816.19455-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.20.114
X-Source-L: No
X-Exim-ID: 1fhSA6-001oyu-Um
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.20.114]:7927
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 8
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According datasheet max17040 has a pin for alert host for low SOC.
This pin can be used as external interrupt, so we need to check for
interrupts assigned for device and handle it.

In hadler we are checking and storing fuel gauge registers values
and send an uevent to notificate user space, so user space can decide
save work or turn off since the alert demonstrate that the battery may
no have the power to keep the system turned on for much longer.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 33c40f79d23d..6e54e58814a9 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/max17040_battery.h>
 #include <linux/slab.h>
@@ -179,6 +180,24 @@ static void max17040_work(struct work_struct *work)
 			   MAX17040_DELAY);
 }
 
+static irqreturn_t max17040_thread_handler(int id, void *dev)
+{
+	struct max17040_chip *chip = dev;
+	struct i2c_client *client = chip->client;
+
+	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	/* read registers */
+	max17040_get_vcell(chip->client);
+	max17040_get_soc(chip->client);
+	max17040_get_online(chip->client);
+	max17040_get_status(chip->client);
+
+	/* send uevent */
+	power_supply_changed(chip->battery);
+
+	return IRQ_HANDLED;
+}
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -200,6 +219,8 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	int ret;
+	unsigned int flags;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -221,6 +242,24 @@ static int max17040_probe(struct i2c_client *client,
 		return PTR_ERR(chip->battery);
 	}
 
+	/* check interrupt */
+	if (client->irq) {
+		dev_info(&client->dev, "IRQ: enabled\n");
+		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						max17040_thread_handler, flags,
+						chip->battery->desc->name,
+						chip);
+		if (ret) {
+			client->irq = 0;
+			if (ret != -EBUSY)
+				dev_warn(&client->dev,
+					"Failed to get IRQ err %d \n", ret);
+		}
+	}
+
 	max17040_reset(client);
 	max17040_get_version(client);
 
@@ -248,6 +287,12 @@ static int max17040_suspend(struct device *dev)
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
 	cancel_delayed_work(&chip->work);
+
+	if (chip->client->irq) {
+		disable_irq(chip->client->irq);
+		enable_irq_wake(chip->client->irq);
+	}
+
 	return 0;
 }
 
@@ -258,6 +303,12 @@ static int max17040_resume(struct device *dev)
 
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
+
+	if (chip->client->irq) {
+		disable_irq_wake(chip->client->irq);
+		enable_irq(chip->client->irq);
+	}
+
 	return 0;
 }
 
-- 
2.13.3

