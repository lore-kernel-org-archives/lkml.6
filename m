Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B090520672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wLL8/OI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbeLKD3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:29:10 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:1120
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeLKD3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bKgzDad34eWvO7hgmn7LygevSBp6j1O916ugdOWoaE=;
 b=wLL8/OI6EAEySzRB+kwH9ouAKVCoqpkuVm3PPvuHutas6y6tMCJmhrUlc9jSzD+7KUxBzZp5Z6/OGTRFX04Tl1cG/9DBfjMArU70iwFYIZFIF+FQt4bpmdfctqfY376m49FRmOtNfeKwZhzkjBQh1ErQilgNRVt40GTwZIBNyCg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Tue, 11 Dec 2018 03:29:03 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:29:03 +0000
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
Subject: [PATCH V3] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Thread-Topic: [PATCH V3] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Thread-Index: AQHUkQGpKTF8HPdmxEG4gZUKwuf97Q==
Date:   Tue, 11 Dec 2018 03:29:03 +0000
Message-ID: <1544498589-2785-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3833;6:ibe8juvg+U1cz1N8AUb2x4fbHypE5M9f2343P4547/neLdJEQyBe/NFAP+mARzdLcEmv6RTpMai//mDo5HXBxQf3i+f/kQV3n19bMoojkFlzMyNobix6SAToERnBsVouusf9EbJBNWNpHo7r4Ks0leg3tOWc5mbvILBR+nLPae+moLoOIpjJCPwC0ieU6kcNndKVpIehuRNDxfYfsZdr62sbgXLYk773+s/bvzguXgibOPDAsj7fpBqXcuIN2DBum8jxkTQ8AxqzqSoJtOsEFgt52gN0kCQ4n5vxTVFfIx53lhuNL81Q0GxiHRl70dBVE6RhtTaphj9mbxq/LRxqLEFG/Ob76uD5+QdgfwdN/0oarqzr4WOpcIlnYG6wW1ICCQ5oUhNxOX1Q9tQnAq6+HgwGEUuWZUS+TzHZa20yx9RwvSmC4geFtGfGMCocKDSAyXyVF1UEiIST4l3Jv701zg==;5:hIN7XHuLLXEtfZqDE6wHe4fuKxsGDgZgcC/dqz316wn5p/uE9MzJWFLAf2e8zcyVrpEO+CDHK203Tx2tUrES02Vb5AMBqjdIT5daYM6e8IMefMmzTC3oocmE5pyHApbbVFIvxVVoRQ2z123lqxvbW4ETEhb9/ZjssOjw/kPV10E=;7:eXlmX5Sd5f2UbLbBahNhhDSYyBoBnboi2yU0iZs9+HZjsMYUczOs8O35vHsp99fNS/B7t+AN6cMFubrLzosxdod7TbrIGOc5AHkx3alglptu6p0DMau2ve6qn8Og+jqDwtvmovZysrJQObO0ISQvGA==
x-ms-office365-filtering-correlation-id: 71d8bdc9-46f0-4a1b-2191-08d65f18cc16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-antispam-prvs: <DB3PR0402MB383330A1072BF79748BA3520F5A60@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3833;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3833;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(54534003)(189003)(199004)(386003)(105586002)(71190400001)(71200400001)(68736007)(14454004)(110136005)(25786009)(316002)(6116002)(3846002)(2906002)(97736004)(99286004)(2501003)(6436002)(36756003)(6486002)(2201001)(81156014)(86362001)(8936002)(50226002)(256004)(8676002)(14444005)(81166006)(52116002)(102836004)(53936002)(4326008)(305945005)(7736002)(26005)(476003)(2616005)(66066001)(5660300001)(186003)(6512007)(39060400002)(478600001)(106356001)(6506007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9g1l3/rM2yxbvfXFuVBs7GhTci5hfWulQhcmI1suUJBa+ajZ+5IITdsXoiof2Wlsms6kqvnDFkpgzuLM8p3oy/H2F/53tzeITT8/MY9eYGM8wjpRnLRhkmgpvXQumrxh+4vQPKOYzDN62FS6foWFi7onK+HTuS9Z3CjczZdd/nRLqJfiqdjgaUPIfZm1Qi+/aSoGRQt/qhRUiNSsXPZpG0m/SuIJSHMnsgWPzvgzRi+skTjTq68qo6k4rPfCep7HrtpiDrLr3J2q294i4f7XBI6USBPji6GHQn/eicABv5iey20XwRgAn/4uc8My+a/R
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d8bdc9-46f0-4a1b-2191-08d65f18cc16
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:29:03.1613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
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
ChangeLog since V2:
	- improve the error handling of devm_regulator_get_optional;
	- make sure regulators are disabled in error path.
---
 drivers/iio/magnetometer/mag3110.c | 97 ++++++++++++++++++++++++++++++++++=
----
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..120f383 100644
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
@@ -469,17 +472,48 @@ static int mag3110_probe(struct i2c_client *client,
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
+			if (!IS_ERR(data->vdd_reg))
+				regulator_disable(data->vdd_reg);
+			return ret;
+		}
+	} else {
+		ret =3D PTR_ERR(data->vddio_reg);
+		if (ret !=3D -ENODEV)
+			return ret;
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
@@ -499,7 +533,7 @@ static int mag3110_probe(struct i2c_client *client,
=20
 	ret =3D mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	ret =3D i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
 		MAG3110_CTRL_AUTO_MRST_EN);
@@ -520,6 +554,12 @@ static int mag3110_probe(struct i2c_client *client,
 	iio_triggered_buffer_cleanup(indio_dev);
 standby_on_error:
 	mag3110_standby(iio_priv(indio_dev));
+disable_regulators:
+	if (!IS_ERR(data->vdd_reg))
+		regulator_disable(data->vdd_reg);
+	if (!IS_ERR(data->vddio_reg))
+		regulator_disable(data->vddio_reg);
+
 	return ret;
 }
=20
@@ -537,14 +577,55 @@ static int mag3110_remove(struct i2c_client *client)
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
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_disable(data->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			return ret;
+		}
+	}
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_disable(data->vddio_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDDIO regulator\n");
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

