Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8372C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D38B2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x4ieIxYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAHJJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:09:44 -0500
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:2112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbfAHJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oacLkzwQqnK2GOFn6qeyO8tStJXGUnggmZWIQabxQTg=;
 b=x4ieIxYbpMwTTLvW9H4LmSdcJ/5UxEQYzaT7h/Fw9B5vflGmHuqdatr4tfApfMoMlxNW0kJEPB/AEq9/3u9WumzGykc8p6skytcbK3gqsmgWaTNOdySIUoVJefXbUPjbW82zY1LZJ04HVCelJXlmhYphmjEJo87n71KFzoDy3QY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 8 Jan 2019 09:09:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::59d2:55a0:dbe3:2a97%6]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 09:09:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V9] iio: light: isl29018: add vcc regulator operation support
Thread-Topic: [PATCH V9] iio: light: isl29018: add vcc regulator operation
 support
Thread-Index: AQHUpzHiMzfl5aSTU0WD0yCbYNkZqg==
Date:   Tue, 8 Jan 2019 09:09:39 +0000
Message-ID: <1546938294-26888-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3852;6:IaVBvtaUPEpXBaaD820kII3fp118Mx/IniLqgwOc3Jr2NPprzT8TIdRK6DCnL+E8VkiYuFRdqrBdr7jAiaxF+RqN3yWE8/0WXd6zInXmKMnpaiCJxufVytIT+4dpiroePBH7hazGkCSqNpuEF85h55mtj4NFfC/Y2MWxzlbh8hl+eHUxnugNy5k35jHSlTAXYdv3nzrI/tniK2C6ZpxCJBZqiuEw+pmMv2cJlbHbsH+GBLeLJo+EUV5eISIZextJNE9xatWcU/8AM+0irMrSJ9GCzisV2IIeysXiDwsQrz6b1edGEphH1wQfSeCA3omH2dcJJUIc+1mw6BrvayvGpw53cesRfmRQZZSvjaTBI2huSt77vmnCDJCdo36DDSa1dJ5BAbJJo6kePOZQh6X9ppNA7fCNUeXHeombihl1yy3Bd3IReQ5vbIOnkQtBZ+wwxH8492SttlfMyHcM/Zi8jw==;5:0pDmJCBre7ll6IsEo2z4Wvd9/WlVQZcdzbsjqdSDdUnJeq/ZBGxP8dVQXMRnbTd93cBv+VlcqhaGzAvuBageES6+OY9gqqov9iGA+1tjWpr9PcoMfxZAKY61LwYkz13DoiWdZ9ZzVh5qb2Mjk2owxeNZb385qlhGNII25Kq1JZlBEUSDJX2qtUPRXlSENUTBdg2GCYkTtOe987QGI10ikg==;7:oba+QUyWART7XIosWTdFgw4kOFslXe6AdxvahdO7lnF8Gi2oPQuKBtdmqe0r5d3kOjHcWtN/e7RdZG4OM6mQ657A0w93jEjUolH94kw+c6Aqvh73WCuu4rO0oOmHd52HGjKaaUuGWqgp/7wdjPBVqA==
x-ms-office365-filtering-correlation-id: 0cfc1f43-72c3-4233-e77a-08d675490438
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3852;
x-ms-traffictypediagnostic: DB3PR0402MB3852:
x-microsoft-antispam-prvs: <DB3PR0402MB3852B92B4CB9D625DFD21353F58A0@DB3PR0402MB3852.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3852;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3852;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(54534003)(189003)(199004)(5660300001)(68736007)(106356001)(2501003)(105586002)(71200400001)(97736004)(66066001)(2906002)(71190400001)(486006)(305945005)(256004)(14444005)(6436002)(186003)(8936002)(316002)(7736002)(26005)(6512007)(99286004)(14454004)(8676002)(476003)(2616005)(81156014)(81166006)(110136005)(50226002)(478600001)(6486002)(52116002)(86362001)(36756003)(4326008)(3846002)(386003)(6506007)(25786009)(102836004)(2201001)(53936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HDsMjx9UGJg3U9GWHYee6APiK3bDKGL+farWTWTSQPsdQDlxoo4La513UpB13t15/U4Q6lKkb/FFQSvWoXYXIwz9YdMHS2OghHNJdFcas7CZM56yUpT9m2Xs/z7Dcefdgfx2APoVn/BaAHM8Fl9liWPJmHE6vJmcsTq22b4dmo8NyE+oLUBbFJcQWmuTCsAYzurEs69XEUG8B052StCJZ6wO584sWn6JmD/P43VdvfPcWkPe56McxZ6JuD7tAArO21nuAY7FbtVnFeSEV9hqgAm03JhYtnh3ngdVDX7v0GnA7D5ofo0ftpzu2kK4DY8o
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfc1f43-72c3-4233-e77a-08d675490438
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:09:35.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
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
ChangeLog since V8:
  - use devm_add_action_or_reset instead of devm_add_action to avoid callin=
g regulator disable when failed;
---
 drivers/iio/light/isl29018.c | 46 ++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..846df4d 100644
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
@@ -742,6 +754,27 @@ static int isl29018_probe(struct i2c_client *client,
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
+	err =3D devm_add_action_or_reset(&client->dev, isl29018_disable_regulator=
_action,
+				 chip);
+	if (err) {
+		dev_err(&client->dev, "failed to setup regulator cleanup action!\n");
+		return err;
+	}
+
 	chip->regmap =3D devm_regmap_init_i2c(client,
 				isl29018_chip_info_tbl[dev_id].regmap_cfg);
 	if (IS_ERR(chip->regmap)) {
@@ -768,6 +801,7 @@ static int isl29018_probe(struct i2c_client *client,
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,10 +811,13 @@ static int isl29018_suspend(struct device *dev)
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
@@ -790,6 +827,13 @@ static int isl29018_resume(struct device *dev)
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

