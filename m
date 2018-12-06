Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF81C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C742082D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qmi6vsLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C742082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeLFDPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:15:54 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:6400
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727514AbeLFDPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzW3x7nOr37PKTIA8/6JnMeJ9W02uKApG0A+azLa08k=;
 b=qmi6vsLaUBuC2KNujqFfpQSYzHzndR6PuhliXrQMV+4YQDpXdrh2vvRwMmkYWjd2jmkHh7N2PRXRfKPQFmZa4bywn6JpxqlPFBWjJAZEYuJYLHRSTHaqNjNPWDcE3I3znhTB6G/m3MB3HuW5ccK6C2aQZhwdo/rjUDxq7qEyPSE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3802.eurprd04.prod.outlook.com (52.134.71.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 03:15:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 03:15:48 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] iio: light: isl29018: add optional vcc regulator operation
 support
Thread-Topic: [PATCH] iio: light: isl29018: add optional vcc regulator
 operation support
Thread-Index: AQHUjRH8CfSZy5OH8ESc4x40JN2bLA==
Date:   Thu, 6 Dec 2018 03:15:48 +0000
Message-ID: <1544065798-4465-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0066.apcprd03.prod.outlook.com
 (2603:1096:203:52::30) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3802;6:jTSiKxhVFLoHkbEYlhNmJL0v9oyhEF7zglN4zZq6jTUUhQluW/IVHJcOtcsOwLUevDHg2BTKDa8zTMJxFX676PjDplCpOmQtnvbTWIhrU04iF5QrD332S7FNwrbXvo6YkIDVYiESpUQCXPLYetdPw5nInWaA9845kR+uXSILb3vTronQOgQeJ85aylZo9qDAOXp0fxsnjiivxFUhQOChdNHjYlIOuhMcf2L+cnJrSfd+QySzi48AHezGTT83tGjgyXRMf+698WYPdai3MpWrAIl0gg/5Yi2betB9ZpdHBbCpeuIuZn5to8p2y1wjQ6c9+OZc44oLr/4QbVMYjWALXTasC0vcM9qVvWD0zr73htDAsHjUJwG8RpIQm0GA3A/w/ISt1N7ZcpV1mnXwCiMl58zKOWOv0PNyLFS7I46fXlt5MBQAuLrohZo1/UqReQHuR9H8UKzm62SVKPqfvGRKOA==;5:k/pngTcP5uUD25POHgm8QwUs0wcca2hO1VUI8EH2ykQPNbQmiWwysyMov0VmeI0C5CEHjkFwIpnwHQvatFFHrFuM+waxusGdrGFdQK5PW/eW3L7SMu6/7hIeei58ln9BT+34HECyVjXVL6etMLcMlVbfcyodnN8O6GIaqEIOMu0=;7:qXbnwVZwptFODwKTPVckhEIeJCQPwnOiS+vES0sX7lw7oyXFGilg6f041A4hGSPINl9/tpBDuWnr682w33FbeVegNEs3B+2fWkRRtNvTUx322aeBekhtwOPfJHForPj/j46Of4XmoWodfnSh0MQWZg==
x-ms-office365-filtering-correlation-id: ec8c6f82-d50c-4b89-061c-08d65b291e71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3802;
x-ms-traffictypediagnostic: DB3PR0402MB3802:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB380284ABE98DE2F019781D00F5A90@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3802;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3802;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(376002)(136003)(346002)(189003)(199004)(99286004)(26005)(106356001)(6116002)(6486002)(52116002)(97736004)(386003)(6436002)(25786009)(6506007)(102836004)(5660300001)(68736007)(110136005)(105586002)(186003)(3846002)(71200400001)(53936002)(14454004)(256004)(6512007)(71190400001)(8936002)(86362001)(14444005)(4326008)(66066001)(2906002)(36756003)(316002)(8676002)(81156014)(81166006)(305945005)(476003)(7736002)(2616005)(50226002)(486006)(2501003)(478600001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3802;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1D/3SLyDLMe1KnQS5v0fQp4+6sXLH6IpIVBpv5XR+qJLegNGh+osVYNHXopCfVPMKEhdQKbqOwhzL0Xtrt1KuCAlEp9KL0EXT0nfBO3nrQchrCSaBTG7FP2135ELcvk1Gt3bGtmnHgElezWTM4Aq8HR/lLtqqx6DoCBvcTa+CWzjOL72xADWBxmlvbZddCfLy9LttbDvVH1ZDsG5cAnuKbD9erppxQTwKD7qZskidGVFCXeqAxR7DUhzcm7CGc4QnnJQhLkKJ06AoZSF8WRhF3DuvryChQMGbl92CbnodGAX19Snof9qrx+zSpAKSzmDTchX+1GaSHangag3pHqq6bYkfpBLlAvaN30KScjnOfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8c6f82-d50c-4b89-061c-08d65b291e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 03:15:48.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
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
 drivers/iio/light/isl29018.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..47a55c8 100644
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
@@ -735,6 +737,15 @@ static int isl29018_probe(struct i2c_client *client,
=20
 	mutex_init(&chip->lock);
=20
+	chip->vcc_reg =3D devm_regulator_get_optional(&client->dev, "vcc");
+	if (!IS_ERR(chip->vcc_reg)) {
+		err =3D regulator_enable(chip->vcc_reg);
+		if (err) {
+			dev_err(&client->dev, "failed to enable VDD regulator\n");
+			return err;
+		}
+	}
+
 	chip->type =3D dev_id;
 	chip->calibscale =3D 1;
 	chip->ucalibscale =3D 0;
@@ -768,6 +779,7 @@ static int isl29018_probe(struct i2c_client *client,
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip =3D iio_priv(dev_get_drvdata(dev));
+	int ret;
=20
 	mutex_lock(&chip->lock);
=20
@@ -777,6 +789,14 @@ static int isl29018_suspend(struct device *dev)
 	 * So we do not have much to do here.
 	 */
 	chip->suspended =3D true;
+	if (!IS_ERR(chip->vcc_reg)) {
+		ret =3D regulator_disable(chip->vcc_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			mutex_unlock(&chip->lock);
+			return ret;
+		}
+	}
=20
 	mutex_unlock(&chip->lock);
=20
@@ -790,6 +810,15 @@ static int isl29018_resume(struct device *dev)
=20
 	mutex_lock(&chip->lock);
=20
+	if (!IS_ERR(chip->vcc_reg)) {
+		err =3D regulator_enable(chip->vcc_reg);
+		if (err) {
+			dev_err(dev, "failed to enable VDD regulator\n");
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

