Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934552AbeCEKoT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:44:19 -0500
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:7526 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934392AbeCEKoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:44:04 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,426,1515452400";
   d="scan'208";a="29824913"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v3 4/4] rtc: isl1208: Add "evdet" interrupt source for
 isl1219.
Thread-Topic: [PATCH v3 4/4] rtc: isl1208: Add "evdet" interrupt source for
 isl1219.
Thread-Index: AQHTtG7alK4E3pvwxUuvtLwEu1aLQA==
Date: Mon, 5 Mar 2018 10:43:52 +0000
Message-ID: <1520246373-19023-5-git-send-email-Denis.Osterland@diehl.com>
References: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
In-Reply-To: <1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc4Q+xc9r/a6t2HuWj6Nw2bXcmazuc7spiDLdOZo4ghGb
X-MIMETrack: Itemize by SMTP Server on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:44:01,
        Serialize by ntm_grab.EXE on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:44:01,
        Serialize complete at 05.03.2018 11:44:01,
        Itemize by ntm_grab.EXE on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:44:01,
        Serialize by Router on DIGNS28/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 05.03.2018 11:44:02,
        Serialize complete at 05.03.2018 11:44:02
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/rtc/rtc-isl1208.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 164371b..f2f148b 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -14,6 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/bcd.h>
 #include <linux/rtc.h>
+#include <linux/of_irq.h>
 
 /* Register map */
 /* rtc section */
@@ -79,6 +80,7 @@ enum {
 struct isl1208 {
 	struct rtc_device *rtc;
 	const struct attribute_group *sysfs_files;
+	int evdet_irq;
 };
 
 /* block read */
@@ -730,6 +732,24 @@ static const struct attribute_group isl1219_rtc_sysfs_files = {
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
@@ -772,6 +792,8 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 			return rc;
 		}
 		isl1208->sysfs_files = &isl1219_rtc_sysfs_files;
+		isl1208->evdet_irq = of_irq_get_byname(client->dev.of_node,
+								"evdet");
 	} else {
 		isl1208->sysfs_files = &isl1208_rtc_sysfs_files;
 	}
@@ -780,22 +802,15 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
+	if (isl1208->evdet_irq > 0 && isl1208->evdet_irq != client->irq)
+		rc = isl1208_setup_irq(client, isl1208->evdet_irq);
+	if (rc)
+		return rc;
 
 	return rtc_register_device(isl1208->rtc);
 }
-- 
2.7.4


Diehl AKO Stiftung & Co. KG, Pfannerstraße 75-83, 88239 Wangen im Allgäu
Bereichsvorstand: Dr.-Ing. Michael Siedentop (Sprecher), Josef Fellner (Mitglied)
Sitz der Gesellschaft: Wangen i.A. – Registergericht: Amtsgericht Ulm HRA 620609 – Persönlich haftende Gesellschafterin: Diehl Verwaltungs-Stiftung – Sitz: Nürnberg – Registergericht: Amtsgericht Nürnberg HRA 11756 –
Vorstand: Dr.-Ing. E.h. Thomas Diehl (†) (Vorsitzender), Herr Dipl.-Wirtsch.-Ing. Wolfgang Weggen (stellvertretender Vorsitzender), Dipl.-Kfm. Claus Günther, Dipl.-Kfm. Frank Gutzeit, Dr.-Ing. Heinrich Schunk, Dr.-Ing. Michael Siedentop , Dipl.-Kfm. Dr.-Ing. Martin Sommer, Dipl.-Ing. (FH) Rainer von Borstel, Vorsitzender des Aufsichtsrates: Dr. Klaus Maier
___________________________________________________________________________________________________
Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht. Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.
