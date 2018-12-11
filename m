Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A91C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2EA20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bcAXsOzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2EA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeLKD1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:27:09 -0500
Received: from mail-eopbgr140049.outbound.protection.outlook.com ([40.107.14.49]:59105
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbeLKD1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:27:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaUnRcLWtNN5JE7WZgOcq8+ePfJFL312uKH1i2g3Bow=;
 b=bcAXsOzcmFaoLrS23/8nU/5zsvgDhN8xsZf8BAYsjuz2mrRdG2jLrCM6a+f3dHEwckqCrEcxj19w8XeRjtmjIoIT7MqAALnQzz17aIadq17cv3VF0+h99CNkEHwvGFJPe7B5BLg/2/ps+QxxAMUtp14Hi8k0zxemRRUsXjgW0wk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3786.eurprd04.prod.outlook.com (52.134.71.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 03:24:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:24:10 +0000
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
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda regulator
 operation support
Thread-Topic: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
Thread-Index: AQHUkQD7YnUpJgt5iEONteRFHRrUpA==
Date:   Tue, 11 Dec 2018 03:24:10 +0000
Message-ID: <1544498291-2716-2-git-send-email-Anson.Huang@nxp.com>
References: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3786;6:TII0+9m00aWuwbReDIyXDUwv/t1bpsSfuw02MJjQk4wNEOJYTwuoQbvwDE4fIb6fPQT83LRSFC6tfmS2F3XzFc/hof8zeupKMT9LQWfIcetfW5lsa7Y9eVpfmSoTy8Ux0jCoCI/7df2dG0nyj5qQOyztZzZsGLApHq3poD5U/DxkO66OH2g7D5VcRQRNijS/ZA282gO30lxz+P9CHEizxEUzpTWiRl7jYsNBlHfW7YkVMDm6ALZCRTmY/qCecyRygQCxe4sdxcjfuwnZgnCCku+xb+/2EfPIdIdgRzzwcGaXdSALuQ4JBlnTGADqepJDPrx+0ntEQYSKcL3tqazE14YskPi2PMykSYMOfHHuDQXxbD43sV+36AZqP8IZj9IcJfPiMSrSZnGf4vrdaE/m/kTH32kKD96TfG+BXfELmBMneccBoGrnLS7RstPxcdkBeTqMlRx4MAZ7en2bPET3WQ==;5:d9hY98vFjuBWE7HV+OAOMAqUs7kvWym7donihx0TNhTL2kHYWDNwyCuBOetuMzY34I5j4ZCubUlRKhfBolXnp+iwuSLrvAUaq1D0cgtrnlfn4e8EoeS81Swrbxw4nsQfs8XP8hqNVJNUDh3rBXZUinMhmB4RG0Agdbbr0q1a8eo=;7:SzEOsWO5jhUfR2gwIr2sx37F4QzNmagYdyuHTu5ACCf/rEskcQsNRTLExm8F67elIM72kCa9s8eQoQ8W6eP90VYrNAwWviFoaLiV6obN+cWkztsAkJ+yhRi+TE+h3J+LOXjiF+Ye5HkgzlC4nXIrCA==
x-ms-office365-filtering-correlation-id: 2bdf4f2c-5638-4961-fd25-08d65f181ddc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3786;
x-ms-traffictypediagnostic: DB3PR0402MB3786:
x-microsoft-antispam-prvs: <DB3PR0402MB378638BAA7868FEBD44E528CF5A60@DB3PR0402MB3786.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3786;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3786;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(189003)(199004)(54534003)(478600001)(2501003)(6486002)(446003)(14454004)(305945005)(97736004)(3846002)(6512007)(2201001)(5660300001)(86362001)(7416002)(11346002)(4326008)(2616005)(39060400002)(36756003)(71200400001)(7736002)(71190400001)(6116002)(316002)(186003)(476003)(2906002)(8676002)(386003)(106356001)(25786009)(105586002)(26005)(66066001)(50226002)(102836004)(6506007)(110136005)(81156014)(52116002)(6436002)(99286004)(14444005)(256004)(486006)(53936002)(8936002)(81166006)(68736007)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3786;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1WLb9zIiA6HYK0GOmUNWbzKqBNgwAG9v6k4rI7c0L9nxfPuQrOev2CjNBtTkYoDcOyFZfEskrZiWKZdVM7mH0p6WnHB6YAU3M1VbjFF3HpmKQ6Smh3mjg2GrEfDw6jirybmfoGxWUdG45eGgK+cCORmNOnX/q4acxGnTg6mlWyZQam/M9Yrl3HOvMyi4U5pAW9ukthiymHEPdf0NH9qYw/2fHXKWScKXrartsKvsJ+sPsYR1SCE+gPkWNQXFyPA2wyqGsQyX17NO+QOjSufjd+Z/EQMt9F+x1TeW60QvqKAYAft6AtjzV2LKu44AxBh8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdf4f2c-5638-4961-fd25-08d65f181ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:24:10.7271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The light sensor's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the light sensor
isl29023's power supply is controlled by a GPIO fixed regulator,
need to make sure the regulator is enabled before any operation of
sensor, this patch adds optional vdd/vdda regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V3:
	- improve the error handling of devm_regulator_get_optional;
	- make sure regulators are disabled in error path.
---
 drivers/iio/light/isl29018.c | 83 ++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..a21652b 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -95,6 +96,8 @@ struct isl29018_chip {
 	struct isl29018_scale	scale;
 	int			prox_scheme;
 	bool			suspended;
+	struct regulator	*vdd_reg;
+	struct regulator	*vdda_reg;
 };
=20
 static int isl29018_set_integration_time(struct isl29018_chip *chip,
@@ -735,6 +738,34 @@ static int isl29018_probe(struct i2c_client *client,
=20
 	mutex_init(&chip->lock);
=20
+	chip->vdd_reg =3D devm_regulator_get_optional(&client->dev, "vdd");
+	if (!IS_ERR(chip->vdd_reg)) {
+		err =3D regulator_enable(chip->vdd_reg);
+		if (err) {
+			dev_err(&client->dev, "failed to enable VDD regulator\n");
+			return err;
+		}
+	} else {
+		err =3D PTR_ERR(chip->vdd_reg);
+		if (err !=3D -ENODEV)
+			return err;
+	}
+
+	chip->vdda_reg =3D devm_regulator_get_optional(&client->dev, "vdda");
+	if (!IS_ERR(chip->vdda_reg)) {
+		err =3D regulator_enable(chip->vdda_reg);
+		if (err) {
+			dev_err(&client->dev, "failed to enable VDDA regulator\n");
+			if (!IS_ERR(chip->vdd_reg))
+				regulator_disable(chip->vdd_reg);
+			return err;
+		}
+	} else {
+		err =3D PTR_ERR(chip->vdda_reg);
+		if (err !=3D -ENODEV)
+			return err;
+	}
+
 	chip->type =3D dev_id;
 	chip->calibscale =3D 1;
 	chip->ucalibscale =3D 0;
@@ -747,12 +778,12 @@ static int isl29018_probe(struct i2c_client *client,
 	if (IS_ERR(chip->regmap)) {
 		err =3D PTR_ERR(chip->regmap);
 		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
-		return err;
+		goto disable_regulators;
 	}
=20
 	err =3D isl29018_chip_init(chip);
 	if (err)
-		return err;
+		goto disable_regulators;
=20
 	indio_dev->info =3D isl29018_chip_info_tbl[dev_id].indio_info;
 	indio_dev->channels =3D isl29018_chip_info_tbl[dev_id].channels;
@@ -761,13 +792,24 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->dev.parent =3D &client->dev;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
=20
-	return devm_iio_device_register(&client->dev, indio_dev);
+	err =3D devm_iio_device_register(&client->dev, indio_dev);
+	if (!err)
+		return 0;
+
+disable_regulators:
+	if (!IS_ERR(chip->vdd_reg))
+		regulator_disable(chip->vdd_reg);
+	if (!IS_ERR(chip->vdda_reg))
+		regulator_disable(chip->vdda_reg);
+
+	return err;
 }
=20
 #ifdef CONFIG_PM_SLEEP
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,6 +819,22 @@ static int isl29018_suspend(struct device *dev)
 	 * So we do not have much to do here.
 	 */
 	chip->suspended =3D true;
+	if (!IS_ERR(chip->vdd_reg)) {
+		ret =3D regulator_disable(chip->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
+	}
+	if (!IS_ERR(chip->vdda_reg)) {
+		ret =3D regulator_disable(chip->vdda_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDDA regulator\n");
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
+	}
=20
 	mutex_unlock(&chip->lock);
=20
@@ -790,6 +848,25 @@ static int isl29018_resume(struct device *dev)
=20
 	mutex_lock(&chip->lock);
=20
+	if (!IS_ERR(chip->vdd_reg)) {
+		err =3D regulator_enable(chip->vdd_reg);
+		if (err) {
+			dev_err(dev, "failed to enable VDD regulator\n");
+			mutex_unlock(&chip->lock);
+			return err;
+		}
+	}
+	if (!IS_ERR(chip->vdda_reg)) {
+		err =3D regulator_enable(chip->vdda_reg);
+		if (err) {
+			dev_err(dev, "failed to enable VDDA regulator\n");
+			if (!IS_ERR(chip->vdd_reg))
+				regulator_disable(chip->vdd_reg);
+			mutex_unlock(&chip->lock);
+			return err;
+		}
+	}
+
 	err =3D isl29018_chip_init(chip);
 	if (!err)
 		chip->suspended =3D false;
--=20
2.7.4

