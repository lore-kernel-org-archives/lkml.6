Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A11FC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A65820651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oej0KrcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A65820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJXLQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:16:40 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:39072
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbeJXLQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMqcG8HxAo5tzkjSma36S1jp+5q7CEA+KepNm3sRMXQ=;
 b=oej0KrcBZdk9x+wNuLpHwn/LXDsedO97aUmrLcu/i0KFMTBn/ayDKeY3vRe8nJ1ku/oRPaWR43hodPJ3Lw8NENdvqox7dajtSF8yLI4UIiFO/GPoJNnytKsI1yI7YcNJ6m5DzLrx3ToUN4kE+Fsgstx8dpvLU+4v9THyilndTpQ=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4358.eurprd04.prod.outlook.com (52.135.169.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Wed, 24 Oct 2018 02:50:27 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 02:50:27 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Thread-Topic: [PATCH 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Thread-Index: AQHUa0RR75oCoPPs2UaL+eidUUdJxw==
Date:   Wed, 24 Oct 2018 02:50:27 +0000
Message-ID: <20181024024808.14485-3-xiaoning.wang@nxp.com>
References: <20181024024808.14485-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024024808.14485-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0110.apcprd06.prod.outlook.com
 (2603:1096:1:1d::12) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4358;6:WW9ug8sYSuN4oPhAGKdCtxBV4zQq63vFP3p91qf4KLy9+RwKN1ChPXZP/m1PEOtoWnNiviGC7cerJyyWaSjDxWzEyoPMWuH9gppjFLqL15vkZfT0S2Py1Z8QlKvYj1dvBtfB4CYmkXaEwWJIj6VXbUBjgeVMBwngHn33lE1oafbEkrJ8a78PvRr+V8W2Rw/cngifRXwCBiVVKPX8CFpr3oHdjYJg+9mPG76t3NIp/9lryc3SRb0qjtyU6ndOFqmfLq4Fsu00x7Ti1O8hvl0FkCBzYZMU0oP5KOC+eHfQjpWHwPBY5BxCJTMH3moA3J+E0jNv/I3Dd1KTtAlYra984MYuq3jpz57hzieG296enpINsZnPHD5SqWFwne05f2xxNikixyhz+mB4fPeiSCxdqWJBwEymOv+9oQvNLLTsYhNgXlmEyzjbTunxX5cx37nvjR3FsKNTDYQFK9NbFhXddQ==;5:Y0CdhPyTN/Qyt1f8cKqJV1Sy8Mhgir/sAqvZZCY6yuImKnA86pVMdHzJK8GGxLpIrtK3euA3mV4vgfDriAags0ONTxFCie8Ci0I7gq86jwLEg8IA0bqFOjR5XsmNCBPO9TIhsUa7Sfi4HGhqXg81+dhkEOCD9mFtjfq1vGujjO8=;7:OCIU0Xv9OzT7Ap3mMBERo6B82RpEZ2DBjfQoQPqtMX/mQpGkqxZvlEooivUHcEGXYkiisjRPl34VwOxf02K/ISicKztgY+Rx5USr9v70YOIcXX5WpbHi1mx7GA6IoDc8cP7sRyEEEK/LE7CK8PNzfWVS7VnZQvitN37z1j4PltDR8MF7AMpjNy4/Yi7HpIzMskmhr3kzWw9lhlTbQ9v3gEeZS9L/CYfotTqdc1JkPiEyl8f2UpfRKma/6hr2VVdZ
x-ms-office365-filtering-correlation-id: 5db99734-5f0d-4bae-7a33-08d6395b7405
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4358;
x-ms-traffictypediagnostic: AM6PR04MB4358:
x-microsoft-antispam-prvs: <AM6PR04MB4358D50EB3FF3B66224DB3B7F3F60@AM6PR04MB4358.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4358;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4358;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(575784001)(36756003)(53936002)(105586002)(71190400001)(99286004)(256004)(386003)(6506007)(71200400001)(102836004)(8936002)(14454004)(7736002)(4326008)(305945005)(1730700003)(81156014)(316002)(106356001)(5640700003)(81166006)(2351001)(2501003)(478600001)(6436002)(54906003)(3846002)(5660300001)(476003)(8676002)(6116002)(11346002)(66066001)(6916009)(26005)(486006)(446003)(68736007)(76176011)(25786009)(6512007)(6486002)(2900100001)(2616005)(2906002)(97736004)(86362001)(1076002)(52116002)(186003)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4358;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PyInJFs5HguArOGApMmoDSmNjr+KFqeOTyhZyfJ9tW79AdxdgM+Ggwhld+UNcq0t1w7exYQ5ok7rfqjgaTd+fGaZR2EnhdShq2CWYuHCLZWUDmK1aHLPKaZ0QVF2gtqA4xQvGpZIRyM9T5jjRwItDLJfR3P9C/sBwfIOp6INSnXr9kO2k42A0l2cCA9VFqV6B8V7kYdeumJ2fsJobv62exvNdL4wIrTbESRofnbn6n05Q9h7ojgRQdCR23V3nxDXBq+aNYdbkObfkHg0UV18kyEYN4uIotmlsts3TibJstvwVgagA6+3z+nIlmxjL7ELns7qP1xc1cRjraFWnDjB9kzVBbxkl8mCCDPUIN/o4d0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db99734-5f0d-4bae-7a33-08d6395b7405
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 02:50:27.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4358
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 58397acbce2f..a4ad3e881a5e 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -82,7 +82,8 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	bool is_slave;
=20
 	void *rx_buf;
@@ -149,8 +150,19 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+		return ret;
+	}
=20
-	return clk_prepare_enable(fsl_lpspi->clk);
+	return 0;
 }
=20
 static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller=
)
@@ -158,7 +170,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
=20
 	return 0;
 }
@@ -242,7 +255,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	unsigned int perclk_rate, scldiv;
 	u8 prescale;
=20
-	perclk_rate =3D clk_get_rate(fsl_lpspi->clk);
+	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -508,15 +521,30 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	fsl_lpspi->clk =3D devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(fsl_lpspi->clk)) {
-		ret =3D PTR_ERR(fsl_lpspi->clk);
+	fsl_lpspi->clk_per =3D devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(fsl_lpspi->clk_per)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_per);
+		goto out_controller_put;
+	}
+
+	fsl_lpspi->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk_ipg)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_ipg);
+		goto out_controller_put;
+	}
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk);
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
 	if (ret) {
-		dev_err(&pdev->dev, "can't enable lpspi clock, ret=3D%d\n", ret);
+		dev_err(&pdev->dev,
+			"can't enable lpspi per clock, ret=3D%d\n", ret);
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
 		goto out_controller_put;
 	}
=20
@@ -524,7 +552,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
@@ -546,7 +575,8 @@ static int fsl_lpspi_remove(struct platform_device *pde=
v)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	return 0;
 }
--=20
2.17.1

