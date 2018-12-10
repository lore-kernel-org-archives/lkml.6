Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F9EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76B6205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DNZa7suE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76B6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbeLJHLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:11:30 -0500
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:52880
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbeLJHL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCCN26aWuMqb6zynJYqqyvwDMsQ+lPUpcZOy0S3J+eY=;
 b=DNZa7suE+JjB0eALaEyAVHlDpxshu4+oor8Wu1BYRT5wMAVUnoAp9AX55n50vFSXFK1PTdP8NnRx3klOKq+NTOPcM17EK/fIltpImjXgFl/C/Ghw6euSghQyiK7iFQsD0IyxARVLC4sOpW6PrRYDTHpnMdIGWr12UwfszmW93aw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3690.eurprd04.prod.outlook.com (52.134.70.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Mon, 10 Dec 2018 07:11:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 07:11:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V3 2/2] iio: light: isl29018: add optional vdd/vdda regulator
 operation support
Thread-Topic: [PATCH V3 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
Thread-Index: AQHUkFeOXAJ625mhG0uxMVEOV8h94Q==
Date:   Mon, 10 Dec 2018 07:11:23 +0000
Message-ID: <1544425521-775-2-git-send-email-Anson.Huang@nxp.com>
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3690;6:krV063J6NzQ1i5erKzS3DXzrPWuzfnihmM8xolhUKDLG2mdTOVV9A3GDISIasfud/rvM6nNGFqiD5KgYI2eilkfEti7V+fGKtM2Wk7ddPbs0yv9OIDDYsxhlA91xAEybYPjC4F6NI/RQoc+QP2kEmmuJmJoy0KraCC64h4r7boO44RIUaQkojnOMvRfR2/CH6UH2SWgI5buuS/MYBCNZK/6+kcstE59DI98E8gt9+nujBXEWsIcC28ve048ElY2cV0jNS79XjPrl9gXBGsR2k6M7Yfv+I5vZ48nlhZGEskJx8R3LHzAHRnN6ubOIRqlrbxbv14fxoK36uhHTtWyqsAraL7GHCeYd5hSnIMpIkMMz9pK2dcea0ETXUA4OkSB3oDA9r26sD3ydDTbYTL9FgccZKIE7xUboKBv0N5jNbYSjcZenyVpNYt/OzlRyJLacFIPnnORPVl29jScdbBi6LQ==;5:s55c+zf926INEdPBWj9e/IjVbq+BHhFazrqnvQalEab3jX6u1euzmljo1Aoy5R69NZzis3vGHvrJrR2GnJKLlz0MJRIRBLEnfUPmGVJ/86lJrwrNlulqzd2mEtc9Xc5vfbK7kSiWWiIfjP4UeHCCoBLAw3XDIxtTa//hgqtxEJw=;7:ttbAwN7ik/xb3qHjBkgQW9Pn8JcpIzvT8DunzBtRtee625ARSIk6l8ip2CrYo6U0eWFkJtjW20dNRaYBR9SlQkBminLcsBbGzcQatn3NUydWc37qwBQgpCxCTe9mPyx1iTV982uECkJZvIrFEUA6qw==
x-ms-office365-filtering-correlation-id: 51feea45-5bd5-4649-a965-08d65e6eb0fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3690;
x-ms-traffictypediagnostic: DB3PR0402MB3690:
x-microsoft-antispam-prvs: <DB3PR0402MB3690B9025B726D1EB3E7E502F5A50@DB3PR0402MB3690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3690;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3690;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(136003)(396003)(199004)(189003)(54534003)(25786009)(76176011)(8676002)(386003)(66066001)(316002)(86362001)(486006)(102836004)(5660300001)(36756003)(52116002)(68736007)(256004)(14444005)(14454004)(6506007)(2201001)(110136005)(105586002)(305945005)(71200400001)(53936002)(71190400001)(2501003)(6116002)(476003)(81156014)(81166006)(6486002)(99286004)(7736002)(4326008)(50226002)(2616005)(186003)(11346002)(6436002)(26005)(97736004)(478600001)(106356001)(3846002)(2906002)(6512007)(8936002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3690;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9Mm0PZs5NaFZPdbRr5CBc2Md01RW7+3ZyqHT13ivuI/E2DWcxK38/2yCz3+yUJFQ9mvlYV4GnbqBf0wRVrPNVZTf8hkB4OIIOAg7HR+Q2JrqzhdGJRzSWQ5BdNbmzbTqE8v6N+YHhladaK2w5FmHr058XTeiwzZznGeYAb1G4JJc6BJ9Q1bSWVHA3crZoQkRhIBXZErmpwNDRHzuuNB4wHIZbNmdVjMeAao6N89WAYjbzGNDsIUpGRLiNG+YJdcv0tYLiEDGnc01pGhGhwLwSk7iVrLECXqpExY0eqvvq1kxGqTjjPPMpcCDdjoG/eql
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51feea45-5bd5-4649-a965-08d65e6eb0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 07:11:23.0506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3690
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
ChangeLog since V2:
    - Add defer_probe check if the return value from devm_regulator_get_opt=
ional is ERR_PTR(-EPROBE_DEFER);
    - Replace the "vcc" with "vdd" according to datasheet, and add optional=
 "vdda" supply as well since
      isl29018 also has a vdda supply.
---
 drivers/iio/light/isl29018.c | 59 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..477eb95 100644
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
@@ -735,6 +738,28 @@ static int isl29018_probe(struct i2c_client *client,
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
+	} else if (chip->vdd_reg =3D=3D ERR_PTR(-EPROBE_DEFER)) {
+		return -EPROBE_DEFER;
+	}
+
+	chip->vdda_reg =3D devm_regulator_get_optional(&client->dev, "vdda");
+	if (!IS_ERR(chip->vdda_reg)) {
+		err =3D regulator_enable(chip->vdda_reg);
+		if (err) {
+			dev_err(&client->dev, "failed to enable VDDA regulator\n");
+			return err;
+		}
+	} else if (chip->vdda_reg =3D=3D ERR_PTR(-EPROBE_DEFER)) {
+		return -EPROBE_DEFER;
+	}
+
 	chip->type =3D dev_id;
 	chip->calibscale =3D 1;
 	chip->ucalibscale =3D 0;
@@ -768,6 +793,7 @@ static int isl29018_probe(struct i2c_client *client,
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,6 +803,22 @@ static int isl29018_suspend(struct device *dev)
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
@@ -790,6 +832,23 @@ static int isl29018_resume(struct device *dev)
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

