Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF922089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WEUpEx40"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfAHJQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:13 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:52899
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728366AbfAHJQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVmlZpVpat/Q5WpWQbgzkW94soesUoPMPXmcrNZjAWs=;
 b=WEUpEx40nBF1xmFqk9NoNdkAAet9faMDGc4F+9au6nakS25TaOyqC9PKRaX3+SoOW/HmJGp3hQ4fVxpWXWo7D1+9j23gEaoesLJKcAALpfoRepZVkQg+zVOREKNHlVJsFtpYKK0k/q8yQhsNJYhep0ECIE9Vbf/kmZPAfQ7qKYs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Tue, 8 Jan 2019 09:16:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:16:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "rtresidd@electromag.com.au" <rtresidd@electromag.com.au>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V7] iio: magnetometer: mag3110: add vdd/vddio regulator
 operation support
Thread-Topic: [PATCH V7] iio: magnetometer: mag3110: add vdd/vddio regulator
 operation support
Thread-Index: AQHUpzLHxhHxIt0idk61kdQPBHQnuw==
Date:   Tue, 8 Jan 2019 09:16:04 +0000
Message-ID: <1546938681-27028-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3787;6:wfpNIk/1qs5QTNzlXyThKp68VDMt8BR7hqzCx67dDbYUwwWyET8XN2Tlw/WhttFH7KKX484t2qYlrrJ6DKcXoaG+O5Y3nH5uJetEzjEvlFo45dqMPCWDZsFnLLnSYTW/2IzJjgajU/BEsSiaA+fFAzV3yRWkvVsA0hmchhDZNYEz+1AusLWA/fFPuKZm/Sc2naUXWUwCsbwN1hCo5xqsyddccuRLVE9cljf2aABIIz8pPXFCSHF1SLJvrCwmgK8YCa2iB1SJ39xe/gTyO2uazFTZ0ipXZKc+I0x6OZbbpKNVKynSH8BVs88ttAbauE+LBKnNc/kxZ/yURjIBMRHDJYAiahdfbjsMklS2LAEEI11Gm5ij71QVJ1FxqmRD1lpRrYsUqZzObZX+aR97Mtik+Ht1RBG95Dw5Q5iiCkvbNFqfTp7+eCgw55soUW0xg9PzpwUnaG9pQPBqrq8WkpBKvw==;5:Det+hIn7wgQmtauBhPu9dXhbI9bqAHSu9knSElsQpHDOl0BIOqEdjT8mYcgnBOQlFuOb34sKMq6TrE2sAW4/l4eCoFS8P4/Ki9oe5FW6qa0fKop+jmjGTZKAp4LHXZ3dFRBXA4V5fJPrS7bwfs0kTKKCDsIa5txQwke9vDamcIndm/aad7dSAsu3pbxVh3igne3TTxneS+7i//tnrSuYkA==;7:evFbxBXEJhMC4J1FKJicPvKInhTkpYvzClJj47shwcpdsPiP0mq/G/z9QT57fkgpMJEprubqAiPk9Kb+4C0tvDbIykLFPWV/+NGpotFhT1BYfuJEZ6Ur2omMU6PXiMzTr9GCBVWb73CDSgAspazkKw==
x-ms-office365-filtering-correlation-id: 4c701cd5-309e-42cb-1f12-08d67549ea2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB3787F1A17677BEA84B9F2470F58A0@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3787;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3787;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(54534003)(199004)(189003)(8936002)(6436002)(50226002)(68736007)(6486002)(110136005)(81166006)(36756003)(106356001)(66066001)(105586002)(86362001)(14444005)(256004)(97736004)(476003)(2616005)(99286004)(2201001)(305945005)(52116002)(102836004)(478600001)(186003)(53936002)(486006)(2501003)(7736002)(14454004)(6116002)(71190400001)(71200400001)(316002)(81156014)(8676002)(3846002)(6506007)(386003)(4326008)(26005)(25786009)(6512007)(5660300001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 27SqnCaC8yjSCpi+muPr6oq8BiyCSuPa+tBVT40IBir/TIMs3PYcaefGzcjM9IhlKUdWaVbW+P+kFdK7IsGarGlc3QVVuK9gtabE19y2H0zziDe+5xouzhOMcNbcIg7scLTm2wC5m4hqLlrBCf6kzrGCHICsnezIEQn30f6wu/Th5eQ9PVPWwlYyIPmGDKiquRImFHZia5cmSYLyj/BadZ+pAW9e0gq4FXZWzymKpOH1vgoT2OelkSJRFBBptc4JHNpO+PkeRzOEASF/RhdAGkMCVs6iyfBNz+Fymq51XczBssekEZBWTaIyP2IP9r1k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c701cd5-309e-42cb-1f12-08d67549ea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:16:01.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The magnetometer's power supplies could be controllable on some platforms,
such as i.MX6Q-SABRESD board, the mag3110's power supplies are controlled
by a GPIO fixed regulator, need to make sure the regulators are enabled
before any communication with mag3110, this patch adds vdd/vddio regulator
operation support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
ChangeLog Since V6:
  - separate the error handling of regulators get to make code easy to read=
.
---
 drivers/iio/magnetometer/mag3110.c | 94 ++++++++++++++++++++++++++++++++++=
----
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/=
mag3110.c
index f063355..dd990cd 100644
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
@@ -469,17 +472,50 @@ static int mag3110_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret;
=20
-	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
-	if (ret < 0)
-		return ret;
-	if (ret !=3D MAG3110_DEVICE_ID)
-		return -ENODEV;
-
 	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
=20
 	data =3D iio_priv(indio_dev);
+
+	data->vdd_reg =3D devm_regulator_get(&client->dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		if (PTR_ERR(data->vdd_reg) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_err(&client->dev, "failed to get VDD regulator!\n");
+		return PTR_ERR(data->vdd_reg);
+	}
+
+	data->vddio_reg =3D devm_regulator_get(&client->dev, "vddio");
+	if (IS_ERR(data->vddio_reg)) {
+		if (PTR_ERR(data->vddio_reg) =3D=3D -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_err(&client->dev, "failed to get VDDIO regulator!\n");
+		return PTR_ERR(data->vddio_reg);
+	}
+
+	ret =3D regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDD regulator!\n");
+		return ret;
+	}
+
+	ret =3D regulator_enable(data->vddio_reg);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
+		goto disable_regulator_vdd;
+	}
+
+	ret =3D i2c_smbus_read_byte_data(client, MAG3110_WHO_AM_I);
+	if (ret < 0)
+		goto disable_regulators;
+	if (ret !=3D MAG3110_DEVICE_ID) {
+		ret =3D -ENODEV;
+		goto disable_regulators;
+	}
+
 	data->client =3D client;
 	mutex_init(&data->lock);
=20
@@ -499,7 +535,7 @@ static int mag3110_probe(struct i2c_client *client,
=20
 	ret =3D mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
 	if (ret < 0)
-		return ret;
+		goto disable_regulators;
=20
 	ret =3D i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG2,
 		MAG3110_CTRL_AUTO_MRST_EN);
@@ -520,16 +556,24 @@ static int mag3110_probe(struct i2c_client *client,
 	iio_triggered_buffer_cleanup(indio_dev);
 standby_on_error:
 	mag3110_standby(iio_priv(indio_dev));
+disable_regulators:
+	regulator_disable(data->vddio_reg);
+disable_regulator_vdd:
+	regulator_disable(data->vdd_reg);
+
 	return ret;
 }
=20
 static int mag3110_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+	struct mag3110_data *data =3D iio_priv(indio_dev);
=20
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	mag3110_standby(iio_priv(indio_dev));
+	regulator_disable(data->vddio_reg);
+	regulator_disable(data->vdd_reg);
=20
 	return 0;
 }
@@ -537,14 +581,48 @@ static int mag3110_remove(struct i2c_client *client)
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
 }
=20
 static int mag3110_resume(struct device *dev)
 {
 	struct mag3110_data *data =3D iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
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
=20
 	return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
 		data->ctrl_reg1);
--=20
2.7.4

