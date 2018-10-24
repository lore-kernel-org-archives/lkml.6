Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4233C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF2D206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TX9ihuLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF2D206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeJXQZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:25:37 -0400
Received: from mail-ve1eur01on0053.outbound.protection.outlook.com ([104.47.1.53]:60224
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbeJXQZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fgebMENYL1d6tOomUkpPWHNAcQunyODZ5bY0LRMGso=;
 b=TX9ihuLhpzasjssWhLv6OClGAISzSRWfnMOa2HurkSQ3EesBoFPkDY4KQN/zcMv2qnqp9S9ppRHyTc28ly2gNhPhsIZfBKQn4WjdE5CccC5C+tawysjlJqGRxJOZkmiJWRL9lDJIk/Ft/D3HjJbx3Kg/44+jmAbRTwE418OgLBg=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5176.eurprd04.prod.outlook.com (20.177.35.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Wed, 24 Oct 2018 07:58:27 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 07:58:27 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Thread-Topic: [PATCH V2 3/5] spi: lpspi: Add 8qm/qxp support for lpspi
Thread-Index: AQHUa29YWF8F9DrbMk2ruJ2hkKXRbA==
Date:   Wed, 24 Oct 2018 07:58:27 +0000
Message-ID: <20181024075617.19548-3-xiaoning.wang@nxp.com>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
In-Reply-To: <20181024075617.19548-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0127.apcprd06.prod.outlook.com
 (2603:1096:1:1d::29) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5176;6:bZ7gQam66jQE2j0uMuYxhR2VD4p8MD3GgoKkj35+CQEGB/Er/nZIjfvH7YyJDK7tRJ5qouekmtvuKQblucPRBh0T4U5wmYbUszboykTQ9/X4AXUrIDRZ5FUNGFT5N7fd/GinOWR+K1FLk9KF1klfo1v/QZhAcyXomV+ckk3KUiIdMMJkd3VPxETwKZbeAP+dbIO2r9x3ZQTNKBeOZOAeht5Gyz3IjPkUJpJSMgiTp/zK3hfNdIn7FdgkRMKLh5AbHIm//7FABFqRURKCobR2jGNStd7PG/AJuJlPRQJ28G/M+LzDK5UDrVDxfwXitejRbCKDMofvRLAfMG4GJY2Um7cZxO409qaiWvUd7JoGzXzO/kqvmN03SC2xwYGy98lCNkxMBgCHAy/gkGVhojntDFRLCnafNJ6i8XDrAVplf0Tgi5nYOTkloMbob9j4Ia/BmcN/PE1okCTFhe2lIaLcQA==;5:C6C0AqBTvcNGkMow3EpoC5/d8G/sIGJC7hYBGFLXzH+zruas7owl0d6xb9Fzbt68c0R8Eq3ps/VUdccnpwt+pk6xKVQN25+YfKU/vO1RFgEcQxrbszA96PhpFZLVfDhiE56QZJ2CiePBQSG3ZcK/TFNmShJ1673ouNl65UABzEk=;7:YF7xIqtr5werA9BEeD07+j/CjovbW9RIcYde6ASDGz5omMoCKTTeQxhv9ZspIxOuvvRFase4kWt3ivbbrrgR+qqmHIjXP2GeJxxQogD0XVvimc5PhtQnkvOUMV/T6JShQmHfx0JwoVsuCyORhRHh6w==
x-ms-office365-filtering-correlation-id: 26e91cf2-c802-4daa-c9f4-08d639867b23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5176;
x-ms-traffictypediagnostic: AM6PR04MB5176:
x-microsoft-antispam-prvs: <AM6PR04MB5176B30DEA50F781B6AA1D37F3F60@AM6PR04MB5176.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5176;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5176;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(189003)(199004)(6512007)(26005)(71190400001)(5640700003)(36756003)(6916009)(68736007)(71200400001)(256004)(4326008)(6486002)(6436002)(53936002)(305945005)(7736002)(25786009)(102836004)(81166006)(81156014)(1730700003)(14454004)(6506007)(386003)(2501003)(2900100001)(54906003)(97736004)(8676002)(8936002)(5250100002)(476003)(86362001)(76176011)(575784001)(186003)(486006)(2616005)(2906002)(52116002)(446003)(3846002)(6116002)(478600001)(11346002)(105586002)(106356001)(66066001)(316002)(99286004)(2351001)(1076002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5176;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nxMZYdU8BSYtkPap/XTXspMUQUbzTBc2DOFL5Uh43H+aNFeX/L56zPFFCIcA/G+2aBbBgb/YkQ3h3NXfQmOwDmqo8rwcTAlP1xLQgIjPXZ2nJRsfIgf1muXUREZ3rx/lkq4PE9P3aJNbFVkrBFd0IPoSYLi9xOOx5X6obUkWzMhFW7BU7+8S0wNDsG3wRNxoYVsEhuS+LxmSM+Ilnrt+9U7iNDhhYPWkd2hv2Drii560+bt3aNckUOPZkn6x+gmA1x7rOwc6eGsXxnKT5YOZ25eDk6ZrcfIeHYpf1BoglFA1KYDJb2WgVVSG62pO+lbQym9eL22IKJ29WlGgAowmAQVZPunX7aGIXq6XiPhs8bE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e91cf2-c802-4daa-c9f4-08d639867b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 07:58:27.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
V2:
 - No changes.
---
 drivers/spi/spi-fsl-lpspi.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 79a3d4a82628..b51746c2de00 100644
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
@@ -504,15 +517,30 @@ static int fsl_lpspi_probe(struct platform_device *pd=
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
@@ -520,7 +548,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
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
@@ -542,7 +571,8 @@ static int fsl_lpspi_remove(struct platform_device *pde=
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

