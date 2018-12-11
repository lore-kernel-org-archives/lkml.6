Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B5EC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377BC20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdkwwaEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377BC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbeLKFN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:13:27 -0500
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:34208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbeLKFN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLNkFe9xAxVfVlxW3BihdzjowuzzfrIZWGNtZ6iqDbE=;
 b=WdkwwaEJgHUt80R9iL8OYFV2g5LqT9OBe2+PY1o/g5f+I+xtEaRBNTKWx4IUVKCTfDxWdJY42ae2kHyMTqKoEzwg64Sp9YTTIeH7oiLQKiK9WsDQ6iFTwlL+M95Ujs/+fOQa2gKjDkatK9WW1pW97DgWXt/gJcRVQ+o3yHHtJeY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 05:13:20 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 05:13:20 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 2/2] iio: accell: mma8452: add optional vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V4 2/2] iio: accell: mma8452: add optional vdd/vddio
 regulator operation support
Thread-Index: AQHUkRA7HSMNTWQlP0OmsN+xMiTx6Q==
Date:   Tue, 11 Dec 2018 05:13:20 +0000
Message-ID: <1544504839-10958-2-git-send-email-Anson.Huang@nxp.com>
References: <1544504839-10958-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544504839-10958-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3642;6:5YcdXtl22V7GP5UaEoW+IjGt1Cxbm2/J61EB/AMkczkk01rn5+1+i7m+Gf9h0VLTGjelA0CcwQ/2oORed9W955a6FqDsLgSTTYdvAFoELFovbStjX0B1zqR+EFgpfFC+/QfQs492zEoqDkSlDg2yVc5q6SBDCg3CKCW+gR80s48XN3Efl4YGytpmceD4mAa80MrTMywztRG2UoEgniAJa3S5YYY3Uz+nLtKcaBVwD71wtRbMsws795Wxs2wkb3lNNuUDKJpi4XpquDKLaodBa8XNV9u/1M77JJmebwBZFoNP/nEZkVEHpZNlSlpFZmPXo9DfIqyx2YnzQ0qT9sP27vunsLwohHNsD1K5bhFGinvonDPVG8sk/xebEbNT2TiRr20TJHPZ1tfVszWgQQFxdu11xurMyjWlVmEBVfZRjAnGd7DlkLg10/MclB1apOEwRNalhamMbRfVZnX401z7Qw==;5:SKxV3nxXpGCKec75ed6I5VK8ThiOcHa44AUBcrll7VugYngDpGP7rNTAK/kPF8F/D/qG9itTofPDW0S7QRylt58my7jIY5x3vcDKZpeuZaArEu8ywqQegZrKwuXawUP7dnr4Hffd1U+477zE2NO2iUU9SjSOvwFmMGxRtzC/Ezk=;7:YYo4p7/vGtrQ8mqVJU2wL9yjqoqObfaeeQzFRqvtCNANlUIh+J247qo4eX8US5+mUzea3pmDbXc0Ro1vjAGgF3iQ/PaB7v7FnCyCdG3zW/vgiEU4v27qq9o+kNpLNBb4LperAq7JIg1TrQRmL37+zw==
x-ms-office365-filtering-correlation-id: 423ff9df-84ae-4a3f-2f6b-08d65f275df2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-antispam-prvs: <DB3PR0402MB3642CE66A2D86D7474E2336FF5A60@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3642;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3642;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(39860400002)(376002)(54534003)(189003)(199004)(2616005)(66066001)(316002)(11346002)(102836004)(476003)(52116002)(6506007)(8936002)(50226002)(7416002)(186003)(76176011)(386003)(486006)(575784001)(8676002)(3846002)(86362001)(2201001)(6116002)(97736004)(6436002)(26005)(478600001)(99286004)(446003)(68736007)(2501003)(81156014)(81166006)(25786009)(6486002)(36756003)(6512007)(14444005)(53936002)(256004)(4326008)(5660300001)(39060400002)(71200400001)(71190400001)(7736002)(2906002)(105586002)(305945005)(110136005)(106356001)(14454004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L32KF745gDgyxJeTC/1pOzDAOh7n24wMPnjZkdTCO6LHjqrkDwpKPmW8X4qFHdYFXf4oEIJSfQjf/sKnTkHflNwxq4+mRVM7hqfXZkekAncXdXH9JmGS6CwKGki9duG751yBkyhhe1ZUqVdwG77zVLjzCOeQBqs1htaY3htSpA+KlUXHFXM6APtStIAnlG/26g23NBn12iszM6yDxrFnA0jsfcOTKVz8OmbXNPo3cwSoTaK5bpEMytzTB8WM1CM6mT84OkPwtyt5i4g7riQP+8G3bncFdy+k0NfLoIn5V9so9k+OJPT6hvh4pqKN5jIG
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423ff9df-84ae-4a3f-2f6b-08d65f275df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 05:13:20.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the mma8451's
power supply is controlled by a GPIO fixed regulator, need to make
sure the regulator is enabled before any communication with mma8451,
this patch adds optional vdd/vddio regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Martin Kepplinger <martink@posteo.de>
---
ChangeLog since V3:
	- add disabling vdd regulator in vddio error path;
	- improve regulator enable/disable sequence.
---
 drivers/iio/accel/mma8452.c | 186 ++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 176 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 421a0a8..590a95d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -31,6 +31,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
=20
 #define MMA8452_STATUS				0x00
 #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
@@ -107,6 +108,8 @@ struct mma8452_data {
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
+	struct regulator *vdd_reg;
+	struct regulator *vddio_reg;
 };
=20
  /**
@@ -1533,10 +1536,35 @@ static int mma8452_probe(struct i2c_client *client,
 	data->client =3D client;
 	mutex_init(&data->lock);
 	data->chip_info =3D match->data;
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
=20
 	ret =3D i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	switch (ret) {
 	case MMA8451_DEVICE_ID:
@@ -1549,7 +1577,8 @@ static int mma8452_probe(struct i2c_client *client,
 			break;
 		/* else: fall through */
 	default:
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto disable_regulators;
 	}
=20
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
@@ -1566,13 +1595,13 @@ static int mma8452_probe(struct i2c_client *client,
=20
 	ret =3D mma8452_reset(client);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	data->data_cfg =3D MMA8452_DATA_CFG_FS_2G;
 	ret =3D i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
 					data->data_cfg);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	/*
 	 * By default set transient threshold to max to avoid events if
@@ -1581,7 +1610,7 @@ static int mma8452_probe(struct i2c_client *client,
 	ret =3D i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
 					MMA8452_TRANSIENT_THS_MASK);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	if (client->irq) {
 		int irq2;
@@ -1595,7 +1624,7 @@ static int mma8452_probe(struct i2c_client *client,
 						MMA8452_CTRL_REG5,
 						data->chip_info->all_events);
 			if (ret < 0)
-				return ret;
+				goto disable_regulators;
=20
 			dev_dbg(&client->dev, "using interrupt line INT1\n");
 		}
@@ -1604,11 +1633,11 @@ static int mma8452_probe(struct i2c_client *client,
 					MMA8452_CTRL_REG4,
 					data->chip_info->enabled_events);
 		if (ret < 0)
-			return ret;
+			goto disable_regulators;
=20
 		ret =3D mma8452_trigger_setup(indio_dev);
 		if (ret < 0)
-			return ret;
+			goto disable_regulators;
 	}
=20
 	data->ctrl_reg1 =3D MMA8452_CTRL_ACTIVE |
@@ -1661,12 +1690,22 @@ static int mma8452_probe(struct i2c_client *client,
 trigger_cleanup:
 	mma8452_trigger_cleanup(indio_dev);
=20
+disable_regulators:
+	if (!IS_ERR(data->vddio_reg))
+		regulator_disable(data->vddio_reg);
+
+disable_regulator_vdd:
+	if (!IS_ERR(data->vdd_reg))
+		regulator_disable(data->vdd_reg);
+
 	return ret;
 }
=20
 static int mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct mma8452_data *data =3D iio_priv(indio_dev);
+	int ret;
=20
 	iio_device_unregister(indio_dev);
=20
@@ -1678,6 +1717,21 @@ static int mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
=20
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_disable(data->vddio_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to disable VDDIO regulator\n");
+			return ret;
+		}
+	}
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_disable(data->vdd_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to disable VDD regulator\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
=20
@@ -1696,6 +1750,21 @@ static int mma8452_runtime_suspend(struct device *de=
v)
 		return -EAGAIN;
 	}
=20
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
 	return 0;
 }
=20
@@ -1705,6 +1774,23 @@ static int mma8452_runtime_resume(struct device *dev=
)
 	struct mma8452_data *data =3D iio_priv(indio_dev);
 	int ret, sleep_val;
=20
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
+
 	ret =3D mma8452_active(data);
 	if (ret < 0)
 		return ret;
@@ -1723,14 +1809,94 @@ static int mma8452_runtime_resume(struct device *de=
v)
 #ifdef CONFIG_PM_SLEEP
 static int mma8452_suspend(struct device *dev)
 {
-	return mma8452_standby(iio_priv(i2c_get_clientdata(
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct mma8452_data *data =3D iio_priv(indio_dev);
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
+
+	ret =3D mma8452_standby(iio_priv(i2c_get_clientdata(
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
 static int mma8452_resume(struct device *dev)
 {
-	return mma8452_active(iio_priv(i2c_get_clientdata(
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct mma8452_data *data =3D iio_priv(indio_dev);
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
+
+	ret =3D mma8452_active(iio_priv(i2c_get_clientdata(
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
 #endif
=20
--=20
2.7.4

