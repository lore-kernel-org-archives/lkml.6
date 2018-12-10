Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C070CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AACA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wSAD6RXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AACA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLJHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:25:34 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:20400
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbeLJHZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QvhXRQPCCpndtGk1uzpCcDRU3N5xsPaMI3EtpGWSo0=;
 b=wSAD6RXwJ/xcXPxiF7SC504NQxpvY3d+MeDCaL1yIrX5v0cCWw1DVWk4GIXtboHE1zouDmMf26ZliZklkFTjRplI92JkmaDjkUaYnkQBID29qqI2D36P4+56ti81EgziCSNcRU77Ms2FckGUwrJSe7qnXIHbH15xMXN6Ej7HYgQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 07:25:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 07:25:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/2] iio: accell: mma8452: add optional vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V2 2/2] iio: accell: mma8452: add optional vdd/vddio
 regulator operation support
Thread-Index: AQHUkFmG8lbE6zLokESHut9HIV3twg==
Date:   Mon, 10 Dec 2018 07:25:28 +0000
Message-ID: <1544426368-16415-2-git-send-email-Anson.Huang@nxp.com>
References: <1544426368-16415-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544426368-16415-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:203:2f::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3931;6:T1Esb93+kh5Xsjatd6iqX/UAtMc25KA6nHrsQF4Iq6kFqFP0JSZrkVfwp5kp6xSXfNwzbEGveprw4JXFZXlQ/1Oq18WXYXUc0qKz+Rbxi1/oc5NHyAWNnpHoiXF8+nrejCZICyobO+vYeGeQzXJ7lgWAT+RnJG9VrM2PcZ1YorT48IQs51ywgS1rZDkmnj8zIriiT3KO7EYiuDOh/a+E+NSXSMpG9ZHC84qXEA/C5dUj7GDJ0q7cmYP7VfVGgpdtOeb57tiXafSB8oUZ/K7PXh6udWtn73VGtMcLg8AoDurPjCJPC8UA8lWzRjkC7x8gA1KvICU53gQq006ePNJoEMfbgl1wtpKxlDT2wu4xIL71vhc98EksJYXYs2Yg3h3lVUf/u1a3jOo/FEEZNe847zO1CNlk1gWmUD0Q7JV30Qq9le2y2AVyMR2vGgShsCI7QOqKbHpf/EUuRtFNPrSLhw==;5:w13f0rlAEi7LZarL1INQPiPKE0BV9DNCVm7dVHvobJDRcv7e0smQwKiVaoPjvZxQrjc/Cy7bxOlNP1WTzDfMzEU/zvHVWU+hH8koF04gT2zX/QpmKM4ni2U7Fj+kpp2aGYFbgag3fcijln318qTGgXybLsSv0YGMT6f+ujQW3oU=;7:TopKdANfEzzKz/u66/H+mf+e9+9KD8yX9DB2LZQw31dUHR+582ScvLFIIP+dIzPSVZYr0ryzOYH2EEIbXMA+mUkWz8zmyDJdxwb9UpuLutT1FPw+B7QqQslvYsn8B3MIWPKARyDjZtnKjCtFq0hNFQ==
x-ms-office365-filtering-correlation-id: 43d6d475-dbb5-4c8d-d7a5-08d65e70a8ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:
x-microsoft-antispam-prvs: <DB3PR0402MB3931B27D5FF51DA77168B87DF5A50@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3931;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3931;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(54534003)(8676002)(2201001)(6512007)(86362001)(575784001)(53936002)(5660300001)(14444005)(6486002)(256004)(478600001)(316002)(8936002)(106356001)(7416002)(50226002)(2906002)(25786009)(4326008)(2501003)(486006)(81156014)(2616005)(81166006)(476003)(97736004)(105586002)(39060400002)(446003)(110136005)(11346002)(71190400001)(71200400001)(52116002)(186003)(14454004)(26005)(66066001)(6506007)(102836004)(386003)(76176011)(7736002)(6116002)(3846002)(68736007)(36756003)(99286004)(305945005)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DK+Y+C2ATvAdXOvrwFP8b9yp6vDDl6xLYHNZC/iIgt5ht1Z8sBzAQvbASK6H1fxUuVdMOydGiaWJYP+8laVisflFHiSFoOPYXEvqBHbCg7eYdIn7q+wV/3ou3s8G6RqPG3ZlrxEeNYJx1l7gVQ9LruiL47QPZH+RArFXYe3wKgIs8Nsbvaybwiyl8b/Pl7ATzuMNQvwJ+VGTDvDTYTw37nJFmFDfbTM8EjBFADKkP18tF39yPpN+DsRiTyOf5RgCsmojQYYnaOsy7nvMgxknJBbCKcvuEfaCUfJ6Ye3i+q31vxRa/4kh3mKCQ4xvoNAC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d6d475-dbb5-4c8d-d7a5-08d65e70a8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 07:25:28.5728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
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
---
ChangeLog since V1:
    - Add defer_probe check if the return value from devm_regulator_get_opt=
ional is ERR_PTR(-EPROBE_DEFER);
    - Replace the "vcc" with "vdd" according to datasheet, and add optional=
 "vddio" supply as well since
      mma8452 also has a vddio supply.
---
 drivers/iio/accel/mma8452.c | 151 ++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 149 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 421a0a8..18dcf33 100644
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
@@ -1533,6 +1536,27 @@ static int mma8452_probe(struct i2c_client *client,
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
=20
 	ret =3D i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
@@ -1667,6 +1691,8 @@ static int mma8452_probe(struct i2c_client *client,
 static int mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct mma8452_data *data =3D iio_priv(indio_dev);
+	int ret;
=20
 	iio_device_unregister(indio_dev);
=20
@@ -1678,6 +1704,21 @@ static int mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
=20
+	if (!IS_ERR(data->vdd_reg)) {
+		ret =3D regulator_disable(data->vdd_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to disable VDD regulator\n");
+			return ret;
+		}
+	}
+	if (!IS_ERR(data->vddio_reg)) {
+		ret =3D regulator_disable(data->vddio_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to disable VDDIO regulator\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
=20
@@ -1696,6 +1737,21 @@ static int mma8452_runtime_suspend(struct device *de=
v)
 		return -EAGAIN;
 	}
=20
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
 	return 0;
 }
=20
@@ -1705,6 +1761,21 @@ static int mma8452_runtime_resume(struct device *dev=
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
+			return ret;
+		}
+	}
+
 	ret =3D mma8452_active(data);
 	if (ret < 0)
 		return ret;
@@ -1723,14 +1794,90 @@ static int mma8452_runtime_resume(struct device *de=
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
+			return ret;
+		}
+	}
+
+	ret =3D mma8452_standby(iio_priv(i2c_get_clientdata(
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
+			return ret;
+		}
+	}
+
+	ret =3D mma8452_active(iio_priv(i2c_get_clientdata(
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
 #endif
=20
--=20
2.7.4

