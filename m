Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BDCC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF47C2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4h7CBrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF47C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeLFDda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:33:30 -0500
Received: from mail-eopbgr70089.outbound.protection.outlook.com ([40.107.7.89]:10560
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbeLFDd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxXT2dpS/udP/+alHa8tm+NK2uTVAjQW3bKey97mxkw=;
 b=E4h7CBrZUT+3ll6h85+8XWZYYhfmTEOj0DsywMgibDSGCk3+KHsHAiPaf5uNryzMb6P3ZKUlhqlIRoCBzUiA2evMDmBNu3VnauAMLn+uUng1VD6deNNvKUl6N7XLXw0wtitVB0SSjZWaTkte27mb8mAtHFV0+AuLvVvGlmsOkmw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 03:33:17 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 03:33:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] iio: light: isl29018: add optional vcc regulator operation
 support
Thread-Topic: [PATCH V2] iio: light: isl29018: add optional vcc regulator
 operation support
Thread-Index: AQHUjRRtd25dX/BzdEGxoNl5ggpGpA==
Date:   Thu, 6 Dec 2018 03:33:16 +0000
Message-ID: <1544066850-22617-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3929;6:YT2mJwPAbXCG6NIh4okpHZSRvZ7mvUjShJfzSnCT7Z4z9w0FkZj/QlaOGVv3jlN6vVXFgpEjWAmzZA14j0kh4YvKtcK1U7mk5lrIXbcGaw5/CiLIZlL+0j53+czEDznVjZ52soFQWb92C6bBsnO1ClkxtPKWi2yxroSkEDJRpaCWEoqZL3v91ECI1LFu2Un+T6xIroL6mnjN+AwMsFapqERMiapFc2dMNCTRoSf16FzAiI3ziCZ8oufNg30quYfeMI+Iz1XIjhXiRU45eYRzYKZRSA274YxumwAkD0pHyP2cKZ+OGx9PAUfUXW12hhuviZcXER9FOnaMLBsAoNQs6S+1QfUgkYi+nBmtgaXIQXqAuyrsFas9a1L2DyQHau/NXCta/E7GuX5tZNJHSY8BbpN9/NpiMj8mZ1lqlEL4mXd/arfVHASl/OuQOYqufydyfAbSb84umj86JCifSc2cxQ==;5:HSh9m8b+eFCtqt9r4pjv9uj+V7Kb/QHmIArVPHrecvG/LTnDfQX/xN1GaQfTaW8BBlMyCv7ZDDccxamvtpxGtdPwpIbBvNkP2MYbLLnYTIRW8TIqLOzK6yFWWzz3mPj88PsO9XM/PDCkN6loZyIOOxM5nlzZ25KNd0veJxTWgq8=;7:Qvayyn8dmjmm/X3obEGsfnLGKOJCISPtxzdi64tRqwZc6zolXR9uAC031y1c6agvX2v4nJP5vSCTN/yCMnQe3FNnsjSqhtU2ODYUls7XNl7oaLkyigFKlnHPugFOllEjAAT/nLjK50MAB7QGzdKFcQ==
x-ms-office365-filtering-correlation-id: 48728984-64a1-4e37-9152-08d65b2b8f6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39292C6C5624FFADC2017FBEF5A90@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3929;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3929;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(54534003)(6506007)(4326008)(102836004)(68736007)(486006)(476003)(2616005)(50226002)(386003)(36756003)(97736004)(71200400001)(256004)(71190400001)(6512007)(53936002)(186003)(81156014)(86362001)(26005)(81166006)(8936002)(8676002)(478600001)(25786009)(2201001)(52116002)(66066001)(99286004)(5660300001)(14444005)(14454004)(6116002)(106356001)(3846002)(7736002)(305945005)(110136005)(6486002)(6436002)(2906002)(2501003)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JK1ss3io5+uPmgYHtCviimaD0zavoRTpMmqmmqDA5/LHJpLb15RPIRCfh0zD4ccoe89Dw/xghZ/b6V0mlevv0i8mJJmECn5py8ty0FHGo8Ya1TqJn2F0BntSkak1JJJ3CMPcISoQ0FqGGHz+ls0jtiL792N8CUv8VnqqNEM5mPiuMiBtEVaZuUURtkarnqI82dr7NB5CwpboRBodLhU7soa0blNYUwtZ9f62ktyuzlDtj3B02a1Jn9DdqTZx5wyQR7YMpW03vC1uNWq7TgfuXIj7BrHeBtZIErdljWlPCUljnGf7rjyZVeh+q78DQBUCwUzSbHHKiPz0OLXhyP+rirNPx3EBh2rELsYLPgGEpsE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48728984-64a1-4e37-9152-08d65b2b8f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 03:33:16.9989
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
ChangeLog:
	replace "VDD" with "VCC" since the regulator name is vcc_reg.
---
 drivers/iio/light/isl29018.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index b45400f..87dcbce 100644
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
+			dev_err(&client->dev, "failed to enable VCC regulator\n");
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
+			dev_err(dev, "failed to disable VCC regulator\n");
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

