Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617E020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617E020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbeGXMr1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:47:27 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:61312 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388417AbeGXMr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:47:26 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,397,1526335200"; 
   d="scan'208";a="34467534"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v5 3/5] rtc: isl1208: Add "evdet" interrupt source for
 isl1219.
Thread-Topic: [PATCH v5 3/5] rtc: isl1208: Add "evdet" interrupt source for
 isl1219.
Thread-Index: AQHUI0HYyinCarqjR0ey3Ma/gWTNfw==
Date:   Tue, 24 Jul 2018 11:31:21 +0000
Message-ID: <20180724095437.6016-4-Denis.Osterland@diehl.com>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180724095437.6016-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc3S+cPOwesVRp3YOtqJ1nLGxRkIgAaoKJEzjYB8Fub9+
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Osterland <Denis.Osterland@diehl.com>

Add support for "evdet" named interrupt source.

The check if i2c client irq matches evdet irq is needed
for the case that there is only one interrupt named "evdet".
In this case i2c client code handles this like an unnamed
interrupt souce and assigns the value.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/rtc/rtc-isl1208.c | 46 +++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 3150ebdcb179..0812a14c2d5c 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -15,6 +15,7 @@
 #include <linux/bcd.h>
 #include <linux/rtc.h>
 #include "rtc-core.h"
+#include <linux/of_irq.h>
 
 /* Register map */
 /* rtc section */
@@ -725,11 +726,30 @@ static const struct attribute_group isl1219_rtc_sysfs_files = {
 	.attrs	= isl1219_rtc_attrs,
 };
 
+static int isl1208_setup_irq(struct i2c_client *client, int irq)
+{
+	int rc = devm_request_threaded_irq(&client->dev, irq, NULL,
+					isl1208_rtc_interrupt,
+					IRQF_SHARED | IRQF_ONESHOT,
+					isl1208_driver.driver.name,
+					client);
+	if (!rc) {
+		device_init_wakeup(&client->dev, 1);
+		enable_irq_wake(irq);
+	} else {
+		dev_err(&client->dev,
+			"Unable to request irq %d, no alarm support\n",
+			irq);
+	}
+	return rc;
+}
+
 static int
 isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int rc = 0;
 	struct rtc_device *rtc;
+	int evdet_irq = -1;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -766,28 +786,22 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		rc = rtc_add_group(rtc, &isl1219_rtc_sysfs_files);
 		if (rc)
 			return rc;
+		evdet_irq = of_irq_get_byname(client->dev.of_node, "evdet");
 	}
 
 	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
 	if (rc)
 		return rc;
 
-	if (client->irq > 0) {
-		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-					       isl1208_rtc_interrupt,
-					       IRQF_SHARED | IRQF_ONESHOT,
-					       isl1208_driver.driver.name,
-					       client);
-		if (!rc) {
-			device_init_wakeup(&client->dev, 1);
-			enable_irq_wake(client->irq);
-		} else {
-			dev_err(&client->dev,
-				"Unable to request irq %d, no alarm support\n",
-				client->irq);
-			client->irq = 0;
-		}
-	}
+	if (client->irq > 0)
+		rc = isl1208_setup_irq(client, client->irq);
+	if (rc)
+		return rc;
+
+	if (evdet_irq > 0 && evdet_irq != client->irq)
+		rc = isl1208_setup_irq(client, evdet_irq);
+	if (rc)
+		return rc;
 
 	return rtc_register_device(rtc);
 }
-- 
2.18.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
