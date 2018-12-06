Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B60C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E208220878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MwQOcziZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E208220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeLFFEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:04:31 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:60928
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728489AbeLFFEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yMI0MOEd+kzBBGULO11/7goxSIpkRtopH8X8KW1ECY=;
 b=MwQOcziZ4jMLGlhCYbfZdVmxaI0lxy0A97hkGvrsDkqq8w48VCttg8C+nYZA6jwZ/EvRMRGk3vx0fdJEnlX1vEKYtc4jDc+HePY8slE8nSV03kSZ3SA4MJau0jbsPrnaN+yrVoxBga2qmbbdik0XNq46dHZWqrreNXa7zc3eZj8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3804.eurprd04.prod.outlook.com (52.134.73.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 05:03:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 05:03:46 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] iio: magnetometer: mag3110: add optional vcc regulator
 operation support
Thread-Topic: [PATCH] iio: magnetometer: mag3110: add optional vcc regulator
 operation support
Thread-Index: AQHUjSER+Ji9XAJzL0q2bdJrOs0hTQ==
Date:   Thu, 6 Dec 2018 05:03:46 +0000
Message-ID: <1544072280-26932-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3804;6:1pemgqbSKlAj4xT8W/65f7biOcubr1uU/RK7ZIA9OwCCYJK3BgwQbwnFYib7gsPw6/42sFYF2PFr/QKip1n9eGsZaCm+i9WFV+uxGsTfdIw0U5OjIMYdz0wOkfJuhTmnNF1CIBvR0Cs+3o7pAsG5OvVCob1wkbEIU6/oAyNjrs9xdJz991O3xUV5QyI8SDIjsQDNfr2PeAz41GyUBwgPn63RzquALobmujC5XMdisff2L9IbKnXOP3vHHPMFjA86DdlTjP71BUxLFEfvPykjaj/LFvEMpGL/3fhs0+/gk53t/Bh+bgAnp8uOIcR2ArLuFCNjuw+nIrFsueOai4QVOxo4Q+gLhA2L4gQ/BOsHAkJj1Eg9U4MXB+iTtbygVYPpSUkZ1P/rsEAKhyw5OJn0B8Ryr7ViyHpvWmEo7MEPuRENYdp7/72rrPwQJJZ1Mufwi+NnCWMcu6alaqqQobztNg==;5:z1N1R9l95XfBuaYiG6yhGaH2lcbQG5Rtfkhs1mBTthtIkNFcdNZ496dqvROTvSVkfvQoNNYRTzABjN1TN3AYCCcJDdx8A0EbSSwkwNit39sbMIoJt2udfhptHzMqDB199jMZcYRa5QpzJawmglKxQLFqtCFDZd/kFAwxZnWBkcE=;7:iH1XrW8xyAgfX1t3/+TOqp4WomItyyuYIjb5LOKSt92+I2IJqza2xjmPxNyrPk9L7v4YQpAbxmamPCE1i5RebfCcndmoyqynUizkK7dzCJ+P+ZBQlqnkpc5V/y4WfhZO9Ube8foYMP0UUfKE5vpFBw==
x-ms-office365-filtering-correlation-id: 57fc5e40-9402-4134-25de-08d65b3833dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3804;
x-ms-traffictypediagnostic: DB3PR0402MB3804:
x-microsoft-antispam-prvs: <DB3PR0402MB38041FF7F73F06BA29919E95F5A90@DB3PR0402MB3804.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3804;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3804;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(478600001)(26005)(5660300001)(386003)(6506007)(2501003)(7736002)(110136005)(316002)(68736007)(4326008)(2906002)(256004)(97736004)(14444005)(25786009)(102836004)(3846002)(14454004)(8936002)(6512007)(476003)(305945005)(6486002)(71190400001)(53936002)(71200400001)(486006)(52116002)(36756003)(105586002)(81156014)(2201001)(66066001)(106356001)(186003)(6116002)(81166006)(86362001)(2616005)(99286004)(50226002)(6436002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3804;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JIKq++84mK0RNSs/1fPG0oNqwKUHYZGdC2LCFaKM79zzwjbSdZ5EqWLVu2B0pi6OLNgXsuqlnOCV+bjUVPc7aY+CYABIZQMhdDpS154wDwmARZVZu+QIqKvX5XpHjq45BUIrLn+SNdf7ZaeRtflSI2jhkdow0ab3A4F3EHD6xuVznKDvP8xDWs9s1789shZoJTfqE0+6yM4t/ABn3KaFIQj+u+lWaSIIndZrc4PoVtOOaVRP/oRUuJJOHEi8o+bYhSCxUr18Gns17+QgVipY4/NSVi5elUXMgNbifLHWQTZldNbaZdlVdwUTGFmMoWoM02aWcJ1/2qdcEJDVTI51GJQ5NwthzvIDXYHwxsKHSDs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fc5e40-9402-4134-25de-08d65b3833dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 05:03:46.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3804
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magnetometer's power supply could be controlled by regulator
on some platforms, such as i.MX6Q-SABRESD board, the mag3110's
power supply is controlled by a GPIO fixed regulator, need to make
sure the regulator is enabled before any communication with mag3110,
this patch adds optional vcc regulator operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/iio/magnetometer/mag3110.c | 49 +++++++++++++++++++++++++++++++++-=
----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..e2d5b22 100644
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
@@ -56,6 +57,7 @@ struct mag3110_data {
 	struct mutex lock;
 	u8 ctrl_reg1;
 	int sleep_val;
+	struct regulator *vcc_reg;
 };
=20
 static int mag3110_request(struct mag3110_data *data)
@@ -469,17 +471,27 @@ static int mag3110_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
=20
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(indio_dev);
+
+	data->vcc_reg =3D devm_regulator_get_optional(&client->dev, "vcc");
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_enable(data->vcc_reg);
+		if (ret) {
+			dev_err(&client->dev, "failed to enable VCC regulator\n");
+			return ret;
+		}
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
@@ -537,14 +549,39 @@ static int mag3110_remove(struct i2c_client *client)
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
 static int mag3110_resume(struct device *dev)
 {
 	struct mag3110_data *data =3D iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
+	int ret;
+
+	if (!IS_ERR(data->vcc_reg)) {
+		ret =3D regulator_enable(data->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to enable VCC regulator\n");
+			return ret;
+		}
+	}
=20
 	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
--=20
2.7.4

