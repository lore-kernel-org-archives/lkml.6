Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F4CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F720643
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T7OgYSec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbeLQFXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:23:01 -0500
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:22752
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731417AbeLQFW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTfFLATUZ5DdEDm5zYDFTks/IHZ5CXEDNT1k3iM1XzM=;
 b=T7OgYSecEMY2uy9P1bwEIxsPejKGpGKqqapB7FQbtvSKXaUHVIBQpkg1XDSp1Tm++kJ3fves7fqCYGnG7I0I7RSRMcdRHxRI7PCsT77znmi6qGl0GzrcnSgQhkA27dEKt6s/nQEbT7409GH1PybCCEx1siBg5E1jytDfG2/6Fy0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3868.eurprd04.prod.outlook.com (52.134.71.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Mon, 17 Dec 2018 05:22:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 05:22:55 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "preid@electromag.com.au" <preid@electromag.com.au>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 2/2] iio: accell: mma8452: add vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V5 2/2] iio: accell: mma8452: add vdd/vddio regulator
 operation support
Thread-Index: AQHUlciQRfsfmhNcskivcdwy3uXBGA==
Date:   Mon, 17 Dec 2018 05:22:55 +0000
Message-ID: <1545023805-31250-2-git-send-email-Anson.Huang@nxp.com>
References: <1545023805-31250-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1545023805-31250-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::13) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3868;6:a+LhoCFOaJiqOW5e4ak3mds5ssP7XF2VFCfYBUugglOv9R6wOGxhh7mLX6Ppgm2puopxt8oRm7R0Vevz/Sa7PHjAyF7GpOJtbhoD9CmgZdvSRd2be2ahv/7H2TDUJPoLf46nn+wbUVDDEpgwGNPam+JHMCe9S+jak2gPPokIE+prkueh0FS4xEJfWdk+gywyV1tNO0QZVM7FeNZ+JS5vbbtkwSgqGQ6RTFhwiNIrdyQN+FrfZRgMdpl2hbvMT2AxAZVmb9eHU9ORAGOL5HMQGxdjhZqWGjyCGM6YjlcJhn+vBwEqJmr9q8JOxBn69rKKXXJa4rW83ga7kVY8IAjXCa+3dpWRJFut05Tc58YXhbSCC42Zkltv6OzAQc9ubxO1KLxkrIbEwXafyOgQ2azAHf2z0kJeLqRQdfsMKBS8QnNVbnv6GAifYZa/VD+C6L2DAbwxWrnrui0B7dyK1F+3uw==;5:f30ksu2qm0ZD7+VcYA/kM3UlehqtY6rTGIdwILARdVtWAiN47wdtGLTqi2YnO80LVisSOG7wsdf/8nn2ZR5RZ3a4g+c2Crluoeso2Ktl8Hm12rlf56pbGVbCpuP9W60+88vybanw8gsHoFGUrRNo6SLCNGbXZ3+G3FPI44H/fl0=;7:YmvLxv1cxlqtemVu56maaqTDWsXmt8TLaG5jApSuGfN8srsW5Jcod7SjAPH76jyCDhPctLo4rFhloSeXq/gPWlAulUC0H7H3moEMBKEBrA2OT0MBthd9qFHONKn9IUW/vs8VmFFH1c0AiMcih5E5bQ==
x-ms-office365-filtering-correlation-id: ea43164a-4ce0-4a06-ec43-08d663dfb33b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3868;
x-ms-traffictypediagnostic: DB3PR0402MB3868:
x-microsoft-antispam-prvs: <DB3PR0402MB3868AA2669D0DABE704AF979F5BC0@DB3PR0402MB3868.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3868;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3868;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(54534003)(189003)(199004)(256004)(386003)(99286004)(6116002)(3846002)(5660300001)(66066001)(6436002)(76176011)(53936002)(575784001)(2906002)(52116002)(14444005)(68736007)(2616005)(86362001)(50226002)(6486002)(2501003)(476003)(8936002)(486006)(7416002)(2201001)(8676002)(97736004)(81166006)(81156014)(25786009)(316002)(106356001)(446003)(110136005)(71200400001)(11346002)(4326008)(186003)(36756003)(14454004)(105586002)(6512007)(305945005)(7736002)(102836004)(39060400002)(71190400001)(478600001)(26005)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3868;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 63a+pdGbh16+aQh2qX3YJ2kPdw0hxLvvPhpXMNfZ0nisgXy1g9lMv40Pg4VXlpYWlygm9Z9YVtt6l04hZV2mT0fvOL17RGVZpclkG2vvCmjoDx7153Wzvq1roWy6ecD1J/vEFZBpr1oCHLyJRJEUb/NZuXVfO3Bd10rdJb1PasZVbCBlawyXPLbrNZPZJfWZJJFuwPWmv0Y3C1RwJtv85D8jVOWESNw1q2b61MTMEw/+6oCNZTNA2auwW94FVuqx8zb0s8BEOYnXZPy4Sre/VBwY8haKpbqCS8XTKDjqHkSkgRofCeu+oSAVOsaxWYbM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea43164a-4ce0-4a06-ec43-08d663dfb33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 05:22:55.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3868
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supply could be controllable on some
platforms, such as i.MX6Q-SABRESD board, the mma8451's power supplies
are controlled by a GPIO fixed regulator, need to make sure the
regulators are enabled before any communication with mma8451, this
patch adds vdd/vddio regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Martin Kepplinger <martink@posteo.de>
---
ChangeLog since V4:
    - using devm_regulator_get() instead of devm_regulator_get_optional() s=
ince the regulator is
      there always, if dtb does NOT specify one, regulator framework will a=
ssign dummy regulator for it.
---
 drivers/iio/accel/mma8452.c | 183 ++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 172 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 421a0a8..9a52426 100644
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
@@ -1534,9 +1537,37 @@ static int mma8452_probe(struct i2c_client *client,
 	mutex_init(&data->lock);
 	data->chip_info =3D match->data;
=20
+	data->vdd_reg =3D devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		ret =3D PTR_ERR(data->vdd_reg);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&client->dev, "failed to get VDD regulator!\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDD regulator!\n");
+		return ret;
+	}
+
+	data->vddio_reg =3D devm_regulator_get(&client->dev, "vddio");
+	if (IS_ERR(data->vddio_reg)) {
+		ret =3D PTR_ERR(data->vddio_reg);
+		if (ret !=3D -EPROBE_DEFER)
+			dev_err(&client->dev, "failed to get VDDIO regulator!\n");
+		goto disable_regulator_vdd;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
+		goto disable_regulator_vdd;
+	}
+
 	ret =3D i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	switch (ret) {
 	case MMA8451_DEVICE_ID:
@@ -1549,7 +1580,8 @@ static int mma8452_probe(struct i2c_client *client,
 			break;
 		/* else: fall through */
 	default:
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto disable_regulators;
 	}
=20
 	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
@@ -1566,13 +1598,13 @@ static int mma8452_probe(struct i2c_client *client,
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
@@ -1581,7 +1613,7 @@ static int mma8452_probe(struct i2c_client *client,
 	ret =3D i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
 					MMA8452_TRANSIENT_THS_MASK);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	if (client->irq) {
 		int irq2;
@@ -1595,7 +1627,7 @@ static int mma8452_probe(struct i2c_client *client,
 						MMA8452_CTRL_REG5,
 						data->chip_info->all_events);
 			if (ret < 0)
-				return ret;
+				goto disable_regulators;
=20
 			dev_dbg(&client->dev, "using interrupt line INT1\n");
 		}
@@ -1604,11 +1636,11 @@ static int mma8452_probe(struct i2c_client *client,
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
@@ -1661,12 +1693,20 @@ static int mma8452_probe(struct i2c_client *client,
 trigger_cleanup:
 	mma8452_trigger_cleanup(indio_dev);
=20
+disable_regulators:
+	regulator_disable(data->vddio_reg);
+
+disable_regulator_vdd:
+	regulator_disable(data->vdd_reg);
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
@@ -1678,6 +1718,18 @@ static int mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
=20
+	ret =3D regulator_disable(data->vddio_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to disable VDDIO regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_disable(data->vdd_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to disable VDD regulator\n");
+		return ret;
+	}
+
 	return 0;
 }
=20
@@ -1696,6 +1748,18 @@ static int mma8452_runtime_suspend(struct device *de=
v)
 		return -EAGAIN;
 	}
=20
+	ret =3D regulator_disable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDDIO regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_disable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDD regulator\n");
+		return ret;
+	}
+
 	return 0;
 }
=20
@@ -1705,9 +1769,22 @@ static int mma8452_runtime_resume(struct device *dev=
)
 	struct mma8452_data *data =3D iio_priv(indio_dev);
 	int ret, sleep_val;
=20
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDD regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDDIO regulator\n");
+		regulator_disable(data->vdd_reg);
+		return ret;
+	}
+
 	ret =3D mma8452_active(data);
 	if (ret < 0)
-		return ret;
+		goto runtime_resume_failed;
=20
 	ret =3D mma8452_get_odr_index(data);
 	sleep_val =3D 1000 / mma8452_samp_freq[ret][0];
@@ -1717,20 +1794,104 @@ static int mma8452_runtime_resume(struct device *d=
ev)
 		msleep_interruptible(sleep_val);
=20
 	return 0;
+
+runtime_resume_failed:
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
+
+	return ret;
 }
 #endif
=20
 #ifdef CONFIG_PM_SLEEP
 static int mma8452_suspend(struct device *dev)
 {
-	return mma8452_standby(iio_priv(i2c_get_clientdata(
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct mma8452_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDD regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDDIO regulator\n");
+		regulator_disable(data->vdd_reg);
+		return ret;
+	}
+
+	ret =3D mma8452_standby(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
+	if (ret)
+		goto suspend_failed;
+
+	ret =3D regulator_disable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDDIO regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_disable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDD regulator\n");
+		return ret;
+	}
+
+	return 0;
+
+suspend_failed:
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
+
+	return ret;
 }
=20
 static int mma8452_resume(struct device *dev)
 {
-	return mma8452_active(iio_priv(i2c_get_clientdata(
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct mma8452_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDD regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to enable VDDIO regulator\n");
+		regulator_disable(data->vdd_reg);
+		return ret;
+	}
+
+	ret =3D mma8452_active(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
+	if (ret)
+		goto resume_failed;
+
+	ret =3D regulator_disable(data->vddio_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDDIO regulator\n");
+		return ret;
+	}
+
+	ret =3D regulator_disable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "failed to disable VDD regulator\n");
+		return ret;
+	}
+
+	return 0;
+
+resume_failed:
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
+
+	return ret;
 }
 #endif
=20
--=20
2.7.4

