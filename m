Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB9C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8508420880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfBTOBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:01:18 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:29386 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfBTOBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:01:07 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE10EqX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:01:00 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] iio: accel: bma180: convert to devm
Date:   Wed, 20 Feb 2019 15:00:52 +0100
Message-Id: <900f59b94ef2e1b5559b363c0d1af4fefccd0366.1550671256.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code a little.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/accel/bma180.c | 56 ++++++++++++++------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 248be67e4f41..3f5ee2d495d3 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -738,7 +738,7 @@ static int bma180_probe(struct i2c_client *client,
 
 	ret = data->part_info->chip_config(data);
 	if (ret < 0)
-		goto err_chip_disable;
+		goto err;
 
 	mutex_init(&data->mutex);
 	indio_dev->dev.parent = &client->dev;
@@ -748,12 +748,25 @@ static int bma180_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bma180_info;
 
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+			bma180_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
+		goto err;
+	}
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto err;
+	}
+
 	if (client->irq > 0) {
-		data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
-			indio_dev->id);
+		data->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+			indio_dev->name, indio_dev->id);
 		if (!data->trig) {
 			ret = -ENOMEM;
-			goto err_chip_disable;
+			goto err;
 		}
 
 		ret = devm_request_irq(&client->dev, client->irq,
@@ -761,7 +774,7 @@ static int bma180_probe(struct i2c_client *client,
 			"bma180_event", data->trig);
 		if (ret) {
 			dev_err(&client->dev, "unable to request IRQ\n");
-			goto err_trigger_free;
+			goto err;
 		}
 
 		data->trig->dev.parent = &client->dev;
@@ -769,34 +782,14 @@ static int bma180_probe(struct i2c_client *client,
 		iio_trigger_set_drvdata(data->trig, indio_dev);
 		indio_dev->trig = iio_trigger_get(data->trig);
 
-		ret = iio_trigger_register(data->trig);
+		ret = devm_iio_trigger_register(&client->dev, data->trig);
 		if (ret)
-			goto err_trigger_free;
-	}
-
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-			bma180_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
-		goto err_trigger_unregister;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "unable to register iio device\n");
-		goto err_buffer_cleanup;
+			goto err;
 	}
 
 	return 0;
 
-err_buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-err_trigger_unregister:
-	if (data->trig)
-		iio_trigger_unregister(data->trig);
-err_trigger_free:
-	iio_trigger_free(data->trig);
-err_chip_disable:
+err:
 	data->part_info->chip_disable(data);
 
 	return ret;
@@ -807,13 +800,6 @@ static int bma180_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct bma180_data *data = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (data->trig) {
-		iio_trigger_unregister(data->trig);
-		iio_trigger_free(data->trig);
-	}
-
 	mutex_lock(&data->mutex);
 	data->part_info->chip_disable(data);
 	mutex_unlock(&data->mutex);
-- 
2.19.1

