Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2697C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FFA2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gAlbxGSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FFA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeLFGXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:23:40 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:11712
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbeLFGXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XCAX+9S3/akn4R/gzqaOpw5bQ3hu7T1lVqAnVqhgWA=;
 b=gAlbxGSwoj78GXPaNreg0CwaXDZxX46an+zHtb9y6BCIp+jvMJdL13fQcw0axcnL7UVro5aDrPBaC/FLMZGDRP+tiP34YWUU9U+Lwra1mzkiDJroW0rGi+mX60CICkYQuS4dSDpGeUZDt7CSJ0KLcJk3Ebp+L3+q4KoURW9TWO8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3723.eurprd04.prod.outlook.com (52.134.72.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Thu, 6 Dec 2018 06:23:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 06:23:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "harinath922@gmail.com" <harinath922@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martink@posteo.de" <martink@posteo.de>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] iio: accell: mma8452: add optional vcc regulator
 operation support
Thread-Topic: [PATCH 2/2] iio: accell: mma8452: add optional vcc regulator
 operation support
Thread-Index: AQHUjSw2pmxaQ3VShki+vNVORHwxOw==
Date:   Thu, 6 Dec 2018 06:23:33 +0000
Message-ID: <1544077059-4471-2-git-send-email-Anson.Huang@nxp.com>
References: <1544077059-4471-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544077059-4471-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::17) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3723;6:ZuJo9Vtdaeh94Mo9R2w6j/J++V6RzFHmD4KxtciiW3LzRkwzgmFynMctFishrgtGi/BLcK5m+773RtO4Sce5Y7vT/cnkq3GJW0tkQNcoeZDd5CiJH+sUyveBrmgY11K0BmqxcPb2TVNwNtjE919aAqc0NeMzbXz9ZYJ/sAKiUF1oy0KFdu3Ji3mYIkfNI0G9xCtHmDYT621aSvIrvbAUuOEVt6TAfpamNbXwlnGkz7AAEBeEMUT6oKfGKd7ld3ieI3SJsyEuHHbI1M82GHcC4xge9lw9wDZaRNQ+QvVReZeB84P8xzPXaOZnfxBtJS+NxaTYXEugrajJdWd6tBM5M2xBCHtg5Sf+FH6OsPmw4v4FM1CDLbyaA7vBIbbHnthMwVPfN6K4XPpNdAUX8i8biB4IwgfP9C8P3bSWCgUOxc8jDZJAH7zv1dUa/uWiU23/OBzBtckZvXP0xp9oCEW97g==;5:awAyR/1kQ2D8sPvzwZ8ZMVB8QMPHXVthjywdAKv9nGXQlbFXGVBix2mS58DxwfNNrBOI+hcOeJ1c/tIlD3rYQ07/6in8s9Z504mxhMEHFCFzMpxv0rQ8PUvoUWvbZLhnDywuq4tKFgBZrJkZGWQM8gYteNpLITE9eMJ84rhcNDE=;7:aytBK861ZTkXNdFjAppWhR+dtlE6tWV4Za+B0JmH/bYBkmiA6hdkwl+RQq6o721gUwDKMwbJIFdE7Vl7CohibEIETzitYM/CAbnw6/Hwul1WVE2rYSxTzVzXMoHxhKgnFtqxeuffjESYXkyjlh9OnQ==
x-ms-office365-filtering-correlation-id: ffc19380-aaff-4a1b-3522-08d65b435940
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3723;
x-ms-traffictypediagnostic: DB3PR0402MB3723:
x-microsoft-antispam-prvs: <DB3PR0402MB3723EFF544A80AC61205DC9EF5A90@DB3PR0402MB3723.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3723;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3723;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(14444005)(256004)(6486002)(52116002)(386003)(6506007)(76176011)(86362001)(575784001)(14454004)(81166006)(81156014)(8676002)(8936002)(102836004)(186003)(2201001)(26005)(71190400001)(71200400001)(6436002)(99286004)(446003)(2501003)(486006)(476003)(11346002)(2616005)(5660300001)(6512007)(7416002)(305945005)(53936002)(36756003)(39060400002)(4326008)(7736002)(110136005)(66066001)(68736007)(2906002)(316002)(6116002)(50226002)(25786009)(106356001)(3846002)(478600001)(97736004)(105586002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3723;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: V1+omgJWh0tS40/EmAHXgJ6SdXfRN6SKIFdwukI3RwpmiOU7Z5NRNDHnHNHxBz4ILS+iBq3mJHtHcumUHkvSTeb5yiKI7cth+T8WINgDDKl+Mlpod14bZfanHBSxDJz0krUt8qcxjVt+bapVZFFd8Y3k9W984vSxxgTAAjzKSdP38/XHrsHCstsX3x4GFAAn9Yyd3QxjxCuAzMjFc1UPz7UENbNT0VuACcuEUpineIPR3eXgxEe+0d3cR1miyPnvq3ETU6UEQt+HbflN16h7AaIa8FHvxCZO88mrayqmOAaO5ZIQXp+kJuYjICRqw4ZXr4zwXyI/81zzvg33PrD5OGq5OcSb1hcQ7JTzFxPQrcQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc19380-aaff-4a1b-3522-08d65b435940
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 06:23:33.9991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accelerometer's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the mma8451's
power supply is controlled by a GPIO fixed regulator, need to make
sure the regulator is enabled before any communication with mma8451,
this patch adds optional vcc regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/iio/accel/mma8452.c | 88 +++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 421a0a8..8f6123f 100644
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
@@ -107,6 +108,7 @@ struct mma8452_data {
 	u8 data_cfg;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
+	struct regulator *vcc_reg;
 };
=20
  /**
@@ -1533,6 +1535,14 @@ static int mma8452_probe(struct i2c_client *client,
 	data->client =3D client;
 	mutex_init(&data->lock);
 	data->chip_info =3D match->data;
+	data->vcc_reg =3D devm_regulator_get_optional(&client->dev, "vcc");
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_enable(data->vcc_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VCC regulator\n");
+			return ret;
+		}
+	}
=20
 	ret =3D i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
 	if (ret < 0)
@@ -1667,6 +1677,8 @@ static int mma8452_probe(struct i2c_client *client,
 static int mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct mma8452_data *data =3D iio_priv(indio_dev);
+	int ret;
=20
 	iio_device_unregister(indio_dev);
=20
@@ -1678,6 +1690,14 @@ static int mma8452_remove(struct i2c_client *client)
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
=20
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_disable(data->vcc_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to disable VCC regulator\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
=20
@@ -1696,6 +1716,14 @@ static int mma8452_runtime_suspend(struct device *de=
v)
 		return -EAGAIN;
 	}
=20
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_disable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VCC regulator\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
=20
@@ -1705,6 +1733,14 @@ static int mma8452_runtime_resume(struct device *dev=
)
 	struct mma8452_data *data =3D iio_priv(indio_dev);
 	int ret, sleep_val;
=20
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_enable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to enable VCC regulator\n");
+			return ret;
+		}
+	}
+
 	ret =3D mma8452_active(data);
 	if (ret < 0)
 		return ret;
@@ -1723,14 +1759,62 @@ static int mma8452_runtime_resume(struct device *de=
v)
 #ifdef CONFIG_PM_SLEEP
 static int mma8452_suspend(struct device *dev)
 {
-	return mma8452_standby(iio_priv(i2c_get_clientdata(
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
+	struct mma8452_data *data =3D iio_priv(indio_dev);
+	int ret;
+
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_enable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to enable VCC regulator\n");
+			return ret;
+		}
+	}
+
+	ret =3D mma8452_standby(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
+	if (ret)
+		return ret;
+
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_disable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VCC regulator\n");
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
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_enable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to enable VCC regulator\n");
+			return ret;
+		}
+	}
+
+	ret =3D mma8452_active(iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev))));
+	if (ret)
+		return ret;
+
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_disable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VCC regulator\n");
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

