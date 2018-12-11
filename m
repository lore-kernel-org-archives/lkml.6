Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C95C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B78820672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ci6jfHw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B78820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeLKFG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:06:27 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:62559
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeLKFG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwGTJ8oDc45RhnG671W2QqGXtkDz/H8US349Pl2n40I=;
 b=Ci6jfHw+FUgdJTJILEem68VlgW/z4NGxwC7SYmK72AW3X1e4oa/df+5EjUT5dP81oKc0yOAfPggQkIkzZVSlhHYwDwTKjEWTevC14UNbY4BvkORtJegvPTenzuUX+cyPfyhiOxaw23HXj0oIn8iedQXwxA90Z1zmyNwJXQdBBMQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 05:06:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:06:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Thread-Topic: [PATCH V4] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Thread-Index: AQHUkQ9BQPTulc+XakyYDtaou/4xQA==
Date:   Tue, 11 Dec 2018 05:06:20 +0000
Message-ID: <1544504426-30335-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0029.apcprd03.prod.outlook.com
 (2603:1096:203:2f::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3868;6:uedsEPNPBoamN1zS9ZcAsqFJdJK1RdLxyiIBly8jnN4ILYPYoRogNgnyB3cm75pOu040VBPMhVDJw3GPGKufSKNfT/uT5TNN1tNMJCN5n8pB178EtNsj+NkXHgi2cQiIxMjPjQqWzKUvdX1K5wgVB0XIeqVzJZlwzlbyE3waOdl/F+BDovx78fcPmL3W9mDBzo7dxyBPpCAuIIlM/zew9DtU1yoac3d3k/DirS7Sf3EqkHr8g6+/xJTrEj35pae2zKVh9iZIPJWByAyWOd2lnuvExRQI89LA9BZX82Rm3wE/cZwIEtT6R0thlUhe4G4cLfOCQr3eeJon+2GluWg5GtMlF+rlGqtMrOmMIutW1ylYIHWFNggcVjuV9Cu3D/YdJ1vXZa8XdxsSFnJ/bkFjY07jdfldex6NqioHhl8awL1sVW4BDtyAsYYE5/D5rjNEw3OPiNz/3j3XoOWO9TQn0Q==;5:vntKrTp9AJYx1BjTcSKgK9muBEMpyptqRCDilCvHljOkPrtPt2gh+p6EUjfbG7ysi30agmNKtZxx0ajcdtTUJjfytNw8lGBE90idBzbdZyAOrQAwTtsdPFL7xuviL9LrivsZevQOhm08BPB9iFxbJJe7PskL5AlheFYlwW6P6/s=;7:6j83tBJ1iT6lRx9mbt1VlOTWcKs6T8uOqkA+zHiv9vQPDekwJApXcsEKBpe3/sLX+5GC9isuOmJQefZzy08FGn/vff52U0glCY1eejEp7JFcwQ754kJUH1ynAwVX32fEGy1yd+oHeyAphelLV/xVvQ==
x-ms-office365-filtering-correlation-id: f97122a7-3e7b-4054-0c58-08d65f2663c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3868;
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-microsoft-antispam-prvs: <DB3PR0402MB38684D35F5A82579D87762EAF5A60@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3868;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3868;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(54534003)(316002)(110136005)(39060400002)(66066001)(386003)(5660300001)(25786009)(6506007)(4326008)(105586002)(106356001)(486006)(36756003)(52116002)(7736002)(53936002)(2501003)(305945005)(99286004)(476003)(6512007)(2616005)(6486002)(97736004)(14444005)(256004)(6436002)(14454004)(186003)(8676002)(2201001)(68736007)(81166006)(81156014)(2906002)(71190400001)(50226002)(26005)(3846002)(102836004)(8936002)(86362001)(575784001)(478600001)(6116002)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1qNyngoL0YZjy546tD+LFDcsOWq9WE6nBo0JgVWqHHLDUULozKJ2a957IGncGNvFbEchvBWPI75TLt3q2HJ3puIUf0A7h217WGt/W/X2kVxG49aO/FqR/7qWeG4ZweQdGDOSlO6+lcykYQI6CHfbml8/Sm6QE+G7YNRHQmAZNnGJtUY5V4O6YdrariNYv8sig/QyH8g5SF0O/vbogPH2WfUOmrG6wp+h92gRnQq8DQMLf/57jVagggzPoJUNpIP3kyvYTHdXULpjJX4z1EnN53T9+eaX2JKk5DeyVHl1jGbK+TpApmyeWdkdTmrcZ7o3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97122a7-3e7b-4054-0c58-08d65f2663c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:06:20.9047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magnetometer's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the mag3110's
power supply is controlled by a GPIO fixed regulator, need to make
sure the regulator is enabled before any communication with mag3110,
this patch adds optional vdd/vddio regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V3:
	- add disabling vdd in vddio error path;
	- improve the regulator enable/disable sequence.
---
 drivers/iio/magnetometer/mag3110.c | 96 ++++++++++++++++++++++++++++++++++=
----
 1 file changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..328c0c4 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -20,6 +20,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
=20
 #define MAG3110_STATUS 0x00
 #define MAG3110_OUT_X 0x01 /* MSB first */
@@ -56,6 +57,8 @@ struct mag3110_data {
 	struct mutex lock;
 	u8 ctrl_reg1;
 	int sleep_val;
+	struct regulator *vdd_reg;
+	struct regulator *vddio_reg;
 };
=20
 static int mag3110_request(struct mag3110_data *data)
@@ -469,17 +472,46 @@ static int mag3110_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
=20
-	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
-	if (ret < 0)
-		return ret;
-	if (ret !=3D MAG3110_DEVICE_ID)
-		return -ENODEV;
-
 	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
=20
 	data =3D iio_priv(indio_dev);
+
+	data->vdd_reg =3D devm_regulator_get_optional(&client->dev, "vdd");
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_enable(data->vdd_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VDD regulator\n");
+			return ret;
+		}
+	} else {
+		ret =3D PTR_ERR(data->vdd_reg);
+		if (ret !=3D -ENODEV)
+			return ret;
+	}
+
+	data->vddio_reg =3D devm_regulator_get_optional(&client->dev, "vddio");
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_enable(data->vddio_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VDDIO regulator\n");
+			goto disable_regulator_vdd;
+		}
+	} else {
+		ret =3D PTR_ERR(data->vddio_reg);
+		if (ret !=3D -ENODEV)
+			goto disable_regulator_vdd;
+	}
+
+	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
+	if (ret < 0)
+		goto disable_regulators;
+	if (ret !=3D MAG3110_DEVICE_ID) {
+		ret =3D -ENODEV;
+		goto disable_regulators;
+	}
+
 	data->client =3D client;
 	mutex_init(&data->lock);
=20
@@ -499,7 +531,7 @@ static int mag3110_probe(struct i2c_client *client,
=20
 	ret =3D mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	ret =3D i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
 		MAG3110_CTRL_AUTO_MRST_EN);
@@ -520,6 +552,13 @@ static int mag3110_probe(struct i2c_client *client,
 	iio_triggered_buffer_cleanup(indio_dev);
 standby_on_error:
 	mag3110_standby(iio_priv(indio_dev));
+disable_regulators:
+	if (!IS_ERR(data->vddio_reg))
+		regulator_disable(data->vddio_reg);
+disable_regulator_vdd:
+	if (!IS_ERR(data->vdd_reg))
+		regulator_disable(data->vdd_reg);
+
 	return ret;
 }
=20
@@ -537,14 +576,55 @@ static int mag3110_remove(struct i2c_client *client)
 #ifdef CONFIG_PM_SLEEP
 static int mag3110_suspend(struct device *dev)
 {
-	return mag3110_standby(iio_priv(i2c_get_clientdata(
+	struct mag3110_data *data =3D iio_priv(i2c_get_clientdata(
+		to_i2c_client(dev)));
+	int ret;
+
+	ret =3D mag3110_standby(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
+	if (ret)
+		return ret;
+
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_disable(data->vddio_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDDIO regulator\n");
+			return ret;
+		}
+	}
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_disable(data->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			return ret;
+		}
+	}
+
+	return 0;
 }
=20
 static int mag3110_resume(struct device *dev)
 {
 	struct mag3110_data *data =3D iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
+	int ret;
+
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_enable(data->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to enable VDD regulator\n");
+			return ret;
+		}
+	}
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_enable(data->vddio_reg);
+		if (ret) {
+			dev_err(dev, "failed to enable VDDIO regulator\n");
+			if (!IS_ERR(data->vdd_reg))
+				regulator_disable(data->vdd_reg);
+			return ret;
+		}
+	}
=20
 	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
--=20
2.7.4

