Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671FDC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224DA20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A4/SQ8k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224DA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeLMGSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:18:14 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:51744
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeLMGSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBuouQq9oX/xhf4zhpnNd0flUFxnOkJf8oAZ7I9nGc4=;
 b=A4/SQ8k1PqxltWgSUwQZye2kTxIc0YBkal5hXHwNSZdgGgC6BlwiJRxJ+8Zwdp5wfyY5KFrPhSW5HUiQmJaRqcRmTzjLfrzeOOFvgTNqQ4O4Y+ZBwk//GSUqEVwYxFq/C47VxEc037uFrAGvoXSwYA9MPgf8czAogjokdBx0nWY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 06:18:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 06:18:07 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V6] iio: light: isl29018: add optional vcc regulator operation
 support
Thread-Topic: [PATCH V6] iio: light: isl29018: add optional vcc regulator
 operation support
Thread-Index: AQHUkqud8y4XSsxEr0uoMW5Daqk9NQ==
Date:   Thu, 13 Dec 2018 06:18:07 +0000
Message-ID: <1544681529-22268-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3929;6:iv/LfId60lqePx4l+ObfopSAIWSu8tTxcluBoE76d/k3E1XNHxdj5xNrk5IaKIEC4f4L52Fm68tKYgRh9O9T2itF7ALUbGrOQhWwCzmvaFSPOzPs2/k5GVEnS0+NvEOwqw3oGcVIPABfe9Tvq3TyYO0gLRh+dbh80pia5z+P//gOdTcrXbzredc2V7OCSeo8ia4Hd3qCjUQzxvFYNsxcqGLlrO1Pd9dsvAirw7M7DyH4j8wLG7RRE5lrDpm0YYfeJapiRh3thrVnHngM+h8wsi45LThOPULBPVmVrKJkcAN2GZsqCsuBIbmPh50zUNLKHj9LV14dO/g5eFrqlj5BiVmqxCZCZEqlDyrjquxwSfKHWYrSLN7JchR1+NxSrmmqFx+2S55ePZMjeJeM8NfDZCS8yn+7aFlhU8RbXCoBC782w6VyYE8ONp+j8umL24ZvVG9xPMIOZ3LY7Pflxrhb5A==;5:d62GA53JBQnnNNpLq0QkiWAebEkpy9vLnBulN6gnZJuktwdY5VIpztOSFIFwmRhV86P8du1+Ealk4CE5yVUqEUblRP6/pKnncyuwY5izKV1kL+uGnGwmghCf0ufZGHPXa61mAmwmBQnxALLv+j4ZYJaSq2EsbsKKWz1xBFRah/I=;7:F8PFRApdOdn0AodpfLBcKGJOfKdCeIJ7hAzr76tmK5eVr+FSa2bOHyxvxqlRsnHqAlnTkqQPsx2HaXH+WsqT71+7Om+UBqOeKFyICBdwJc28O9lxL4szx3xS+yNODEjWlY4V5SOny7XZtAp7mWWC+w==
x-ms-office365-filtering-correlation-id: a6c05300-c4a1-466c-93c9-08d660c2bf82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB3929A112D57B16D997EECBB0F5A00@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3929;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3929;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(54534003)(189003)(199004)(486006)(53936002)(6436002)(99286004)(6512007)(8676002)(478600001)(81166006)(4326008)(97736004)(81156014)(105586002)(6486002)(8936002)(316002)(39060400002)(86362001)(25786009)(50226002)(71190400001)(36756003)(476003)(71200400001)(110136005)(2501003)(106356001)(2616005)(66066001)(102836004)(2906002)(52116002)(14444005)(256004)(186003)(26005)(68736007)(14454004)(3846002)(7736002)(6116002)(2201001)(6506007)(386003)(305945005)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dP6tvD81YyeiB8xW0h71J+ornVS5wLftEdF08Mi1CPhQ7O7tB8cMMwum86IVjFXnIF2H1FE/52h1/PJTZ5pPiRxEosqv5SaMM85zS4Y8HfVEQcmXKSXtWhHbKN8cBFKFXh3jPIh6KzI+RdSoYU9LtENtmBaiqefKhb2JQio7oWzOYZW8KFCNmvg8YU+m57CLDcIDATZQ4IDVEYOMa3x/GjtNpG6Gehjov9IvpBoxowp7W0CRBPsVySq/wz1k8oP3WwzQUWo8zPPdIRzg9piqy7kAs+9zi0pfebMvRiU6Vw22mPj/qOGyR8Va6FW+00vS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c05300-c4a1-466c-93c9-08d660c2bf82
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 06:18:07.6585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The light sensor's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the light sensor
isl29023's power supply is controlled by a GPIO fixed regulator,
need to make sure the regulator is enabled before any operation of
sensor, this patch adds optional vcc regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog since V5:
	Since the dt-binding doc states the power supply name is "vdd" and many dt=
s files already using
	"vcc" as the power supply name, althoug it does NOT match the datasheet wh=
ich has "vdd", to make
	it NOT breaking existing dtb files, just use "vcc" as the regulator name.
---
 drivers/iio/light/isl29018.c | 47 ++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..76c3a48 100644
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
@@ -735,6 +737,19 @@ static int isl29018_probe(struct i2c_client *client,
=20
 	mutex_init(&chip->lock);
=20
+	chip->vcc_reg =3D devm_regulator_get_optional(&client->dev, "vcc");
+	if (!IS_ERR(chip->vcc_reg)) {
+		err =3D regulator_enable(chip->vcc_reg);
+		if (err) {
+			dev_err(&client->dev, "failed to enable VCC regulator\n");
+			return err;
+		}
+	} else {
+		err =3D PTR_ERR(chip->vcc_reg);
+		if (err !=3D -ENODEV)
+			return err;
+	}
+
 	chip->type =3D dev_id;
 	chip->calibscale =3D 1;
 	chip->ucalibscale =3D 0;
@@ -747,12 +762,12 @@ static int isl29018_probe(struct i2c_client *client,
 	if (IS_ERR(chip->regmap)) {
 		err =3D PTR_ERR(chip->regmap);
 		dev_err(&client->dev, "regmap initialization fails: %d\n", err);
-		return err;
+		goto disable_regulator;
 	}
=20
 	err =3D isl29018_chip_init(chip);
 	if (err)
-		return err;
+		goto disable_regulator;
=20
 	indio_dev->info =3D isl29018_chip_info_tbl[dev_id].indio_info;
 	indio_dev->channels =3D isl29018_chip_info_tbl[dev_id].channels;
@@ -761,13 +776,22 @@ static int isl29018_probe(struct i2c_client *client,
 	indio_dev->dev.parent =3D &client->dev;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
=20
-	return devm_iio_device_register(&client->dev, indio_dev);
+	err =3D devm_iio_device_register(&client->dev, indio_dev);
+	if (!err)
+		return 0;
+
+disable_regulator:
+	if (!IS_ERR(chip->vcc_reg))
+		regulator_disable(chip->vcc_reg);
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
@@ -777,6 +801,14 @@ static int isl29018_suspend(struct device *dev)
 	 * So we do not have much to do here.
 	 */
 	chip->suspended =3D true;
+	if (!IS_ERR(chip->vcc_reg)) {
+		ret =3D regulator_disable(chip->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VCC regulator\n");
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
+	}
=20
 	mutex_unlock(&chip->lock);
=20
@@ -790,6 +822,15 @@ static int isl29018_resume(struct device *dev)
=20
 	mutex_lock(&chip->lock);
=20
+	if (!IS_ERR(chip->vcc_reg)) {
+		err =3D regulator_enable(chip->vcc_reg);
+		if (err) {
+			dev_err(dev, "failed to enable VCC regulator\n");
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

