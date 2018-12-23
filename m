Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EFBC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA3021905
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ga4d835M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeLWGrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 01:47:18 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:30176
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeLWGrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 01:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE5wYQmsLONpyTy+/BfadbGY8fCIPfe8gcsuGYeqUa8=;
 b=Ga4d835MFjabs9rOT3qpYirtGcMKZwKzyUc/m9HfmhuP2Q7GSUYW+qHhuULKzQgmrs1i4Wld1Vvwyj8kBgztCCnUntmE1thmqv5AgYzmgmi73vSdZGEZsJ5LkBPVn4Ip5GYxN2SYcxcOHjDbrX2hdpgHwzuB5JRmzurXhTWyylo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Sun, 23 Dec 2018 06:46:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%5]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 06:46:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V8] iio: light: isl29018: add vcc regulator operation support
Thread-Topic: [PATCH V8] iio: light: isl29018: add vcc regulator operation
 support
Thread-Index: AQHUmos93wSvgiqCGEmCwFK1MbfS4A==
Date:   Sun, 23 Dec 2018 06:46:32 +0000
Message-ID: <1545547310-22203-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3641;6:VqS0YgOqgrUSO4ojvxTjwA0s02x0GvcwD1603i/ULoNDbYTJymACRVUcyl0Ao5h1xdfCZ0QHWimeeVPYfIyFRJjHiaUl0OlKt0FaWC9F1vrCxmZ+HZ6X3z1Eh3wAOHCOMVGW5mPAKzt546Ao+YvrlBNytCb+hq7cQQY+EuZMvgI5eabxzNWXuy/4janxBlEvi/2faAVv5yT1qt4nDe0mMGuoju0erFMXP7Q+jy3osD0nSG/D5MqFhGIQLsfSx+gMQZ+AD4JUqGwYJNeXEuZntXizmw5LNFu7FUEs9CcjKrUqcZSitrNxP32/OMKuH5DRIWY6+kjsLH9+mpT2xejneuePkaUuuopuA64TzKLSgp/mNx2QOvxphCNG0Tu2twaoecTFHauewJnTVdQb/g0jlevAZEl7sHc686mphVPrYnVL2xOl7HVtQTNrXRxyW1l3fNgRWq27kNbjFg9jC1zi3g==;5:oaZ0vMdqkEsPJh18cosZyW7MSmwVuIERZWl/ShPgP/YwKSjp170d4ewnS5TOaxUhk/+LoZ9AmRImgZ9w3rD2A6pPI+d1FBZjefgPtt8rrqimaaYPF5oLKmF6f2KATiEsq/b3hKUbA0/yyLFUK89ZVITnNognYePKKG7VCN9oxys=;7:rX9p3THGOD3CnjFjSzr6iAeeA/hM7GgzCWAMjD4Mq6JCxELzA8f71tb9AZEioaYdlmYf2DsJuMiRzWcSomvtNSoIgKNosM51+OlXpGx5SBtx6xBekw5WjA++GHFpebrVDyNoxNV2+4O8G4LxSXXjQQ==
x-ms-office365-filtering-correlation-id: f88e5839-0aa0-49dd-9d86-08d668a26023
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3641;
x-ms-traffictypediagnostic: DB3PR0402MB3641:
x-microsoft-antispam-prvs: <DB3PR0402MB364157FB27DA78207514A886F5BA0@DB3PR0402MB3641.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3641;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3641;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(396003)(39860400002)(199004)(189003)(54534003)(97736004)(110136005)(105586002)(66066001)(106356001)(99286004)(2906002)(36756003)(476003)(14454004)(2616005)(316002)(478600001)(25786009)(3846002)(6116002)(5660300001)(26005)(50226002)(486006)(71190400001)(71200400001)(4326008)(52116002)(186003)(8676002)(2501003)(81156014)(81166006)(6436002)(68736007)(305945005)(6506007)(386003)(102836004)(6486002)(8936002)(53936002)(256004)(14444005)(7736002)(86362001)(6512007)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E62D80YVdudl5epJdX3hx+I5LdT1RrctH1CihqCkVSwtv9oU/g2UVUuL1ZP6RqL0juXL1d3y5Afkdwd9d602cBJfy0Dt2/Njr7BvHJl1kmuBMDtQ1phdDJHKKuRPZYqQcktwCnERDufgjxuGuhspW20Fl3U8dk/wJzIGH1IeS2s+Ujn5cihXsSq51lk/P3LfKN57l05XOh7XYpXEACyl/CKA+yyt6LwWDTAHRDc6mvKntx9CfNH8f/GgePdKlYRXsf8c7I2IxMP1pVJmbSke94PJ9vIojo+LpiyFLEXZNpa6crG4VlmHah2HL2xUdYZ6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88e5839-0aa0-49dd-9d86-08d668a26023
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 06:46:32.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The light sensor's power supply could be controllable by regulator
on some platforms, such as i.MX6Q-SABRESD board, the light sensor
isl29023's power supply is controlled by a GPIO fixed regulator,
need to make sure the regulator is enabled before any operation of
sensor, this patch adds vcc regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog Since V7:
    - move devm_add_action to before devm_regmap_init_i2c call to save code=
 of disabling regulator;
    - simply the error check logic in isl29018_suspend.
---
 drivers/iio/light/isl29018.c | 47 ++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..ec6ce89 100644
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
@@ -95,6 +96,7 @@ struct isl29018_chip {
 	struct isl29018_scale	scale;
 	int			prox_scheme;
 	bool			suspended;
+	struct regulator	*vcc_reg;
 };
=20
 static int isl29018_set_integration_time(struct isl29018_chip *chip,
@@ -708,6 +710,16 @@ static const char *isl29018_match_acpi_device(struct d=
evice *dev, int *data)
 	return dev_name(dev);
 }
=20
+static void isl29018_disable_regulator_action(void *_data)
+{
+	struct isl29018_chip *chip =3D _data;
+	int err;
+
+	err =3D regulator_disable(chip->vcc_reg);
+	if (err)
+		pr_err("failed to disable isl29018's VCC regulator!\n");
+}
+
 static int isl29018_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -742,6 +754,28 @@ static int isl29018_probe(struct i2c_client *client,
 	chip->scale =3D isl29018_scales[chip->int_time][0];
 	chip->suspended =3D false;
=20
+	chip->vcc_reg =3D devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(chip->vcc_reg)) {
+		err =3D PTR_ERR(chip->vcc_reg);
+		if (err !=3D -EPROBE_DEFER)
+			dev_err(&client->dev, "failed to get VCC regulator!\n");
+		return err;
+	}
+
+	err =3D regulator_enable(chip->vcc_reg);
+	if (err) {
+		dev_err(&client->dev, "failed to enable VCC regulator!\n");
+		return err;
+	}
+
+	err =3D devm_add_action(&client->dev, isl29018_disable_regulator_action,
+				 chip);
+	if (err) {
+		isl29018_disable_regulator_action(chip);
+		dev_err(&client->dev, "failed to setup regulator cleanup action!\n");
+		return err;
+	}
+
 	chip->regmap =3D devm_regmap_init_i2c(client,
 				isl29018_chip_info_tbl[dev_id].regmap_cfg);
 	if (IS_ERR(chip->regmap)) {
@@ -768,6 +802,7 @@ static int isl29018_probe(struct i2c_client *client,
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,10 +812,13 @@ static int isl29018_suspend(struct device *dev)
 	 * So we do not have much to do here.
 	 */
 	chip->suspended =3D true;
+	ret =3D regulator_disable(chip->vcc_reg);
+	if (ret)
+		dev_err(dev, "failed to disable VCC regulator\n");
=20
 	mutex_unlock(&chip->lock);
=20
-	return 0;
+	return ret;
 }
=20
 static int isl29018_resume(struct device *dev)
@@ -790,6 +828,13 @@ static int isl29018_resume(struct device *dev)
=20
 	mutex_lock(&chip->lock);
=20
+	err =3D regulator_enable(chip->vcc_reg);
+	if (err) {
+		dev_err(dev, "failed to enable VCC regulator\n");
+		mutex_unlock(&chip->lock);
+		return err;
+	}
+
 	err =3D isl29018_chip_init(chip);
 	if (!err)
 		chip->suspended =3D false;
--=20
2.7.4

