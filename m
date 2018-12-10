Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF90C67838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C046520865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iKwr9BQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C046520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbeLJHRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:17:07 -0500
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:50352
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbeLJHRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujFNc4BCa/BAmt6XymWh/sZMCnZVbAnRh7M8ko8M1pA=;
 b=iKwr9BQ/vPtU0PWm7gaTeuMkpdOI9RRyCcWRFxqnvCG+5rGv6ro5pm1UZjHvITkruhoWLZAGpBFEW1FFm9AIFJ4nyJCrqjFY0WrhZxOo88/r7f18ipQiLSqX2+JAD4poCMfNda5UY4/tv9916t6xkbqAiAlZrtgf64J+9xiD4ss=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3657.eurprd04.prod.outlook.com (52.134.69.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 07:17:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 07:17:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Thread-Topic: [PATCH V2] iio: magnetometer: mag3110: add optional vdd/vddio
 regulator operation support
Thread-Index: AQHUkFhYV4kgMq86u06OIBfOddtmhg==
Date:   Mon, 10 Dec 2018 07:17:02 +0000
Message-ID: <1544425869-8188-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0038.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3657;6:Xsg9CwURbbxoiiGSI0OZEPaaheyyVg3NFK6dVsyrJVOCA2NhGut0l2z4fTO/ZzpPDmViCtXmckg1MxZ7Nwlj7jF4kPmPzeyJz/hjO9GnneCDdAgWBMoinQ2ug5dmtZIbEno6uYhE8NEhVB9zWQRdfCYyuBgmOUn7IdN/qO6khSpcVgVOOc9GgYBEyR3Bu/AnNZIgsD6Gm1kNm0ytUdyAky6l7TE7QfE4lK947RwMdOsh9Q3qeaD+dgiWNApeoz1gTmxypXBAlXUhXC03yXhWLToZz1VdGiY9rgP/g0dDm0xp7V6YkbBPPjgh369jnnqbJXmtnmT1KhjZrxiioxKFrquNO9W5p394+QIJXMyBu6eyIKxTyLiZaO8n+48kbLbpQQOk/qHHxTBWE1UAweUsBpMSIa8VT5lyMsLlr/Bu97bw2hUzVfHnK7XNk9+OSI3ovxlHds07MxB2d5hedQaNqg==;5:bANKPS8S190mcu+2K6FRfmXtuZaA/VIzedVRKuAG8SufZ0IYD7Q6nxIfsTkPED1O4BP7ma+zobIoZUR0sqhpZ0dSc3/3HWj6Fd5vDIyiotyFHovjZwyqB/smrjX9Xz0xxRcftXtXpTzyxLutbKUdUuBu/U3EL6ZODPTUpsmhkN8=;7:BKmsxQBYOAKj7NGcaDQU76BD5BBl8Hk1NPvRI67+6RnvoMEcAGVGhddWzySd5SLV4GA4ApCdLRMzfgb4AN3r5nGR8g7kcrmw/yutKwahvALdjKAjtcr4ftf5XXs9A6yrm/HRLY8g2aIdHVTmuKDVFQ==
x-ms-office365-filtering-correlation-id: cdc6776e-d8b0-4763-af51-08d65e6f7b26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3657;
x-ms-traffictypediagnostic: DB3PR0402MB3657:
x-microsoft-antispam-prvs: <DB3PR0402MB365719581141077458490DF1F5A50@DB3PR0402MB3657.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231472)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3657;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3657;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(136003)(346002)(199004)(189003)(54534003)(256004)(14444005)(305945005)(25786009)(99286004)(478600001)(110136005)(6486002)(316002)(6436002)(7416002)(4326008)(105586002)(106356001)(71190400001)(2501003)(97736004)(53936002)(71200400001)(6512007)(39060400002)(86362001)(50226002)(476003)(2616005)(8936002)(81166006)(81156014)(2201001)(68736007)(486006)(36756003)(8676002)(14454004)(52116002)(6116002)(186003)(66066001)(5660300001)(7736002)(3846002)(2906002)(6506007)(386003)(102836004)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3657;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WRzo+gHhnWYIl8AVmRZoz92MBUqwmszm3ziAlJaYNC3Pf09LPSwjNZjzTl6IlsEap4oovghbHh32KWcBTVKo4H21C5clZWJNFoF+RJ+zlW4Q+rCQPCLshweIs4xHmDY1DsSlVzn1VkWlhtlU1qWlu7e9HaLrWJv05nLxvwkmXAvxtJ8YVYfpffcmtapcEd0lFbXpNC2nG0tspWUCloA1FdepvHfeEwXb5mvfsTIYUZNdIpX7ipDbAHSbubbgs2N/+KYLQFrItAW8nxfJXYIS4P9ylgyehTdF3BH9VXVMTT1b6mMYV2rveAt3SyVdYu9/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc6776e-d8b0-4763-af51-08d65e6f7b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 07:17:02.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3657
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
ChangeLog since V1:
    - Add defer_probe check if the return value from devm_regulator_get_opt=
ional is ERR_PTR(-EPROBE_DEFER);
    - Replace the "vcc" with "vdd" according to datasheet, and add optional=
 "vddio" supply as well since
      mag3110 also has a vddio power supply.
---
 drivers/iio/magnetometer/mag3110.c | 77 ++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..6308b7f 100644
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
@@ -469,17 +472,40 @@ static int mag3110_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
=20
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(indio_dev);
+
+	data->vdd_reg =3D devm_regulator_get_optional(&client->dev, "vdd");
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_enable(data->vdd_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VDD regulator\n");
+			return ret;
+		}
+	} else if (data->vdd_reg =3D=3D ERR_PTR(-EPROBE_DEFER)) {
+		return -EPROBE_DEFER;
+	}
+
+	data->vddio_reg =3D devm_regulator_get_optional(&client->dev, "vddio");
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_enable(data->vddio_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VDDIO regulator\n");
+			return ret;
+		}
+	} else if (data->vddio_reg =3D=3D ERR_PTR(-EPROBE_DEFER)) {
+		return -EPROBE_DEFER;
+	}
+
 	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
 	if (ret < 0)
 		return ret;
 	if (ret !=3D MAG3110_DEVICE_ID)
 		return -ENODEV;
=20
-	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	data =3D iio_priv(indio_dev);
 	data->client =3D client;
 	mutex_init(&data->lock);
=20
@@ -537,14 +563,53 @@ static int mag3110_remove(struct i2c_client *client)
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
+			return ret;
+		}
+	}
=20
 	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
--=20
2.7.4

