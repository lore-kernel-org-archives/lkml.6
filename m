Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D1220875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D1220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeGXMrV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:47:21 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:61312 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388256AbeGXMrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:47:20 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,397,1526335200"; 
   d="scan'208";a="34467531"
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
Subject: [PATCH v5 4/5] rtc: isl1208: set ev-evienb bit from device tree
Thread-Topic: [PATCH v5 4/5] rtc: isl1208: set ev-evienb bit from device tree
Thread-Index: AQHUI0HYlN5vLmSop0OQEh24l8R1pw==
Date:   Tue, 24 Jul 2018 11:31:21 +0000
Message-ID: <20180724095437.6016-5-Denis.Osterland@diehl.com>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
In-Reply-To: <20180724095437.6016-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc3S+cPOwesVRp3YOtqJ1nLGzDTCHgOUEK+Oxjt5YvNJU
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Osterland <Denis.Osterland@diehl.com>

Add support to disable event in pull-up.

Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-isl1208.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 0812a14c2d5c..fa744c7ad5b3 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -44,6 +44,7 @@
 #define ISL1208_REG_INT_IM     (1<<7)   /* interrupt/alarm mode */
 #define ISL1219_REG_EV  0x09
 #define ISL1219_REG_EV_EVEN    (1<<4)   /* event detection enable */
+#define ISL1219_REG_EV_EVIENB  (1<<7)   /* event in pull-up disable */
 #define ISL1208_REG_ATR 0x0a
 #define ISL1208_REG_DTR 0x0b
 
@@ -777,8 +778,22 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			 "please set clock.\n");
 
 	if (id->driver_data == TYPE_ISL1219) {
-		rc = i2c_smbus_write_byte_data(client, ISL1219_REG_EV,
-							ISL1219_REG_EV_EVEN);
+		struct device_node *np = client->dev.of_node;
+		u32 evienb;
+
+		rc = i2c_smbus_read_byte_data(client, ISL1219_REG_EV);
+		if (rc < 0) {
+			dev_err(&client->dev, "failed to read EV reg\n");
+			return rc;
+		}
+		rc |= ISL1219_REG_EV_EVEN;
+		if (!of_property_read_u32(np, "isil,ev-evienb", &evienb)) {
+			if (evienb)
+				rc |= ISL1219_REG_EV_EVIENB;
+			else
+				rc &= ~ISL1219_REG_EV_EVIENB;
+		}
+		rc = i2c_smbus_write_byte_data(client, ISL1219_REG_EV, rc);
 		if (rc < 0) {
 			dev_err(&client->dev, "could not enable tamper detection\n");
 			return rc;
@@ -786,7 +801,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		rc = rtc_add_group(rtc, &isl1219_rtc_sysfs_files);
 		if (rc)
 			return rc;
-		evdet_irq = of_irq_get_byname(client->dev.of_node, "evdet");
+		evdet_irq = of_irq_get_byname(np, "evdet");
 	}
 
 	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
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
