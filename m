Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeB1M4G convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:56:06 -0500
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:35782 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752622AbeB1Mzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:55:50 -0500
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.47,405,1515452400";
   d="scan'";a="45685405"
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mgr@pengutronix.de" <mgr@pengutronix.de>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v2 1/4] rtc: isl1208: enable interrupt after context
 preparation
Thread-Topic: [PATCH v2 1/4] rtc: isl1208: enable interrupt after context
 preparation
Thread-Index: AQHTsJIOlRXXklFeYk+7pIdbC4Mhpw==
Date: Wed, 28 Feb 2018 12:45:47 +0000
Message-ID: <1519821214-22379-2-git-send-email-Denis.Osterland@diehl.com>
References: <1519821214-22379-1-git-send-email-Denis.Osterland@diehl.com>
In-Reply-To: <1519821214-22379-1-git-send-email-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.153.3.249]
MIME-Version: 1.0
X-GBS-PROC: PkB65aL1SqtESF35r/jQn9k356gkD1odrp1gEtdakkC6EsA+9AWzXKSEZWp+VRdu
X-MIMETrack: Itemize by SMTP Server on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:48,
        Serialize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:48,
        Serialize complete at 28.02.2018 13:45:48,
        Itemize by ntm_grab.EXE on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:48,
        Serialize by Router on DIGNS29/SRV/DIEHL-HUB(Release 9.0.1FP10 HF66|February
 09, 2018) at 28.02.2018 13:45:48
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

The interrupt handler got enabled very early. If the interrupt cause is
triggering immediately before the context is fully prepared. This can
lead to undefined behaviour. Therefor we move the interrupt enable code
to the end of the probe function.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-isl1208.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index c8b4953..a13a4ba 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -635,23 +635,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (isl1208_i2c_validate_client(client) < 0)
 		return -ENODEV;
 
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
-
 	rtc = devm_rtc_device_register(&client->dev, isl1208_driver.driver.name,
 				  &isl1208_rtc_ops,
 				  THIS_MODULE);
@@ -674,6 +657,23 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rc)
 		return rc;
 
+	if (client->irq > 0) {
+		rc = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					       isl1208_rtc_interrupt,
+					       IRQF_SHARED | IRQF_ONESHOT,
+					       isl1208_driver.driver.name,
+					       client);
+		if (!rc) {
+			device_init_wakeup(&client->dev, 1);
+			enable_irq_wake(client->irq);
+		} else {
+			dev_err(&client->dev,
+				"Unable to request irq %d, no alarm support\n",
+				client->irq);
+			client->irq = 0;
+		}
+	}
+
 	return 0;
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
