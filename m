Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3CC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B2A20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 04:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kEcjPAUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfBBEHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 23:07:46 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:63649 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfBBEHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 23:07:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,550,1539673200"; 
   d="scan'208";a="27191417"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 01 Feb 2019 21:07:43 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 1 Feb 2019 21:07:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y3Uibd1NZX0+3oHC7U/Wkfpo4Ng9m/CQ/smEtm7FHI=;
 b=kEcjPAUdGMlILaie8DvayNddlnWxiYA6CtZuVVRkWXQYrx2KLi9ZOyFUGS37K31r/0zakKtL57NmEHaxh3MoPAY/deFjoohezRO8Aw+tGFbSE0Xqk5SMmggUpQVb+GOz0cZg5uWQtaSpJ1T8OBsuhWV/vZAQKfMh8ZrBPe4uwOY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.33.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 04:07:41 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 04:07:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v3 11/13] spi: atmel-quadspi: add support for named peripheral
 clock
Thread-Topic: [PATCH v3 11/13] spi: atmel-quadspi: add support for named
 peripheral clock
Thread-Index: AQHUuqzXSgm7woYfP0qoJQpPc0NVWQ==
Date:   Sat, 2 Feb 2019 04:07:41 +0000
Message-ID: <20190202040653.1217-12-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190202040653.1217-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0062.eurprd09.prod.outlook.com
 (2603:10a6:802:28::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1987;6:nv4/9FTtBPgPM/Z1RONY5tfbVKGCi+HrzbqJHsdgAPlQ5Qr2Z6uWl1XTLHMowHYGRXKFM1cdX8MUccmlH4sG15q7xYxJtJpMVkhYqsgFIuglDXoDGDF3gEVl4j7JG/P9P7glVK8RuDso9CRKVrI8/XaYGUrLjbDdM715OauloXyBmo/LSicwdAjnhecT4SmXvzAWtR/KNBrkrkec5U4M3kVR1fMKPesgYgAQjFlobnSqwYwJKKLmBUeQ5mjr6L/4QSTSm3LnyqvzD7m9eyhKuCorm0/kU5s+VpF64hXiOhnoSjz+abqU4UqoGI+JyeeAdA9hVjDP+Vq6D6hpZCsvkIUI4SEz6mk7EXP6xUuY3eUJ4M+zZTnw/wthpg0vse1uXenT/kWYys7UlIv6NlElhq22Yt7pJtGFVpVXQRIw4/VPr4Z1NivEj2mZFfpqL5A/E0w5FyMoivS2t4xWP/32Cg==;5:2JNv3Xwbln1/CRPbKfNDHj2MTvGuOvcu4SteiIKYEY46V0/qo81dpsxQzzHu6uZAJ0JBmx0wYMI+WHCzx6l5itY9Vh0ieE5q9i7rXszeaHfiWx9ralHtt8L6G11WKhQEXIFMwQeJs4d1AVQW8fkTagLeVzbmpKkr5ZfWNDiUrZGQuUyC0SupHu2ncaXdbvK3eaNAdcxRkKH9K7rTRjoCPg==;7:fiCTDMRtEuFPr8xIaS8dkqiPAtegcCziJuoIb1eEZS/foefAyD7QVRbIoIk3G40ObdrM2PdJ+aJWennb7KkcHUP/pyx/UyTAh4lm7oxIrI3o4xwn53mC3aEK5Jk9WW5sc8VtfMjnDYltpTvC6ZeJCw==
x-ms-office365-filtering-correlation-id: 50829745-8dfc-4938-66a7-08d688c3f9fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1987;
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB1987B7CCC4DCEAC6915ADF03F0930@BN6PR11MB1987.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(97736004)(76176011)(4326008)(1076003)(106356001)(50226002)(66066001)(6506007)(386003)(53936002)(52116002)(107886003)(105586002)(2616005)(72206003)(71200400001)(39060400002)(446003)(6436002)(14444005)(71190400001)(99286004)(256004)(8936002)(186003)(2906002)(25786009)(86362001)(11346002)(305945005)(14454004)(36756003)(8676002)(3846002)(6486002)(2501003)(7416002)(81166006)(478600001)(54906003)(81156014)(6116002)(486006)(476003)(110136005)(68736007)(102836004)(7736002)(26005)(316002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1987;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8X4BtiSF5drvCccinWA9S8Mag+BVQg3p/S1mVeK8pPBMPpGOyjiFdKUkgxf6SjL8DJLu06XDpOW3B5Bmy065yJts0L4LfTQAdlo/FqoOWglWgOQ7WhJOkYAYCXNvM4rliCfiFZZlVmaz+enD1zGfR16KafL3745hMAmxHvFW1jMBJxFid/LSSU4VbKxbvgacXiBags7JJwOb7oAKCMcUgBtzXC3XmJcGxeTYNPSrl0lbSspHPwMHcBZGKLjQQlpJq5nBiaSqwSL3n0e6dXNwYp7U1VKz4qJPuKJLw4y3ezvo1BLNI7Sa2GH0XYp0zMjfF3KpNXJgttJHeTLlIGDQENYHdYj2CTDWmFCKcV1RlD+XBrU9Sk8h/VlHukYg3PQ4iBX79AOj2eJ6M23fNJpTsXFw4czDaNR9a7895JqU+LE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 50829745-8dfc-4938-66a7-08d688c3f9fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 04:07:39.3185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Naming clocks is a good practice. Keep supporting unnamed
peripheral clock, to be backward compatible with old DTs.
While here, rename clk to pclk, to indicate that it is a
peripheral clock.

Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: new patch

 drivers/spi/atmel-quadspi.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index bfa5f5e92d96..c9548942535a 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -136,7 +136,7 @@
 struct atmel_qspi {
 	void __iomem		*regs;
 	void __iomem		*mem;
-	struct clk		*clk;
+	struct clk		*pclk;
 	struct platform_device	*pdev;
 	u32			pending;
 	u32			smm;
@@ -338,7 +338,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
=20
-	src_rate =3D clk_get_rate(aq->clk);
+	src_rate =3D clk_get_rate(aq->pclk);
 	if (!src_rate)
 		return -EINVAL;
=20
@@ -429,15 +429,18 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 	}
=20
 	/* Get the peripheral clock */
-	aq->clk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(aq->clk)) {
+	aq->pclk =3D devm_clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(aq->pclk))
+		aq->pclk =3D devm_clk_get(&pdev->dev, NULL);
+
+	if (IS_ERR(aq->pclk)) {
 		dev_err(&pdev->dev, "missing peripheral clock\n");
-		err =3D PTR_ERR(aq->clk);
+		err =3D PTR_ERR(aq->pclk);
 		goto exit;
 	}
=20
 	/* Enable the peripheral clock */
-	err =3D clk_prepare_enable(aq->clk);
+	err =3D clk_prepare_enable(aq->pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
 		goto exit;
@@ -448,25 +451,25 @@ static int atmel_qspi_probe(struct platform_device *p=
dev)
 	if (irq < 0) {
 		dev_err(&pdev->dev, "missing IRQ\n");
 		err =3D irq;
-		goto disable_clk;
+		goto disable_pclk;
 	}
 	err =3D devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
 			       0, dev_name(&pdev->dev), aq);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
=20
 	err =3D atmel_qspi_init(aq);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
=20
 	err =3D spi_register_controller(ctrl);
 	if (err)
-		goto disable_clk;
+		goto disable_pclk;
=20
 	return 0;
=20
-disable_clk:
-	clk_disable_unprepare(aq->clk);
+disable_pclk:
+	clk_disable_unprepare(aq->pclk);
 exit:
 	spi_controller_put(ctrl);
=20
@@ -480,7 +483,7 @@ static int atmel_qspi_remove(struct platform_device *pd=
ev)
=20
 	spi_unregister_controller(ctrl);
 	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
-	clk_disable_unprepare(aq->clk);
+	clk_disable_unprepare(aq->pclk);
 	return 0;
 }
=20
@@ -488,7 +491,7 @@ static int __maybe_unused atmel_qspi_suspend(struct dev=
ice *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
-	clk_disable_unprepare(aq->clk);
+	clk_disable_unprepare(aq->pclk);
=20
 	return 0;
 }
@@ -497,7 +500,7 @@ static int __maybe_unused atmel_qspi_resume(struct devi=
ce *dev)
 {
 	struct atmel_qspi *aq =3D dev_get_drvdata(dev);
=20
-	clk_prepare_enable(aq->clk);
+	clk_prepare_enable(aq->pclk);
=20
 	return atmel_qspi_init(aq);
 }
--=20
2.9.5

