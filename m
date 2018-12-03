Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DCEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A0B20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tBwy2PKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A0B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLCIjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:39:43 -0500
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:46500
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbeLCIjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVb917QJ421eqGqalMUSYshHGI+tMy1pGRkQ0aFbBQA=;
 b=tBwy2PKW2SdXoN12djdMAbF0OLkD2o9advJK3PPPa5RhShUzIvEfVNo65TOGkK+x9mssANQF5eJ+geDfPlO7iJt13eXkb69I+HnMnNIlTMysBThAj53gowQhGuryw1SrHJimgn9OkbNUcXv4DJzb2jtMktQfCFKuZ94396GqNPM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB1470.eurprd04.prod.outlook.com (10.163.166.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 3 Dec 2018 08:39:31 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%4]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 08:39:31 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v5 5/7] mtd: m25p80: add support of octal mode I/O transfer
Thread-Topic: [PATCH v5 5/7] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Index: AQHUiuO17akHSyxjLkG7oUtpm1hInw==
Date:   Mon, 3 Dec 2018 08:39:31 +0000
Message-ID: <1543826226-30898-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0143.apcprd04.prod.outlook.com
 (2603:1096:3:16::27) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1470;6:/0VRiW/IjdpPKECuDYGm4K8s0vRstHfK4l7LMCgcqGqp1xxRQcspjxfAwoSw5fuPAzrs2++e7pHSoItmYIjLMgoYDLCgbpx1IO/dlGs38hJEWSyoyx/VL+m744g9BZ+TIaEIcRupGlfmMzt8UsHjLiha7D682ydVj7N+VStzwYQdWfTvEQa9uoRI7JuBijMfb+IF/Tt6BFXAfM8eopc3ELwrL6dNdFp9sg1l+zCqMxVZLrwimOUuIUnIYoON8HhBScktFU1ePIf4SDAKs9Cj356JhDKuDjd/8FOANB2MwlobbSrhuWDCs78JORnFaKWM0pqELuWkXIHsM5rvwMgPQxPLM047k3Rs3ygWGwgWKetIQ+uDcc+5a5S/2fBucWWUutVeDU2/Xku9RVAnBRFsIfyjFYhPqZiqi3mydXQ8PZx8t7+XW0D3+sTcRwmn/DpGdPTZT0qp1I7uzpOEbuKXeQ==;5:DaYsxwCmqwXymW903NyVmnEMljcHOYCT2hFdx5UUtqWYJU8poh+va4aP25PpjxA0ua5OWwpvm3Dfrnn9wo8PpMP3HHYB3Z2hLxK4eCH8+f4p2ngFtkC1pz7ow10Mhw5F6ejrnqBEH1T0YmGUV9Qg0YrAHE3EVrVKXfOlD8RgYeE=;7:OxVGbq7a38koMzjKtPIKCsb0hOY2DKjN7d6iJGLTVY9K+dJoGSmL9nJigwCMj+P7+gR3Y6w7TnKwSna2wJM1Xax1QqACSepheSvghX/zTiIpf1qsCZ2AYotD06SYWCh6pkBW1RQE5cwG2fd6YgLMZg==
x-ms-office365-filtering-correlation-id: aab57540-8599-4c36-68c8-08d658fad7dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1470;
x-ms-traffictypediagnostic: VI1PR04MB1470:
x-microsoft-antispam-prvs: <VI1PR04MB14701FDE771A9A7CB1A3342A99AE0@VI1PR04MB1470.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB1470;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1470;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(39860400002)(366004)(396003)(136003)(189003)(199004)(55236004)(2501003)(105586002)(76176011)(5660300001)(7736002)(54906003)(14454004)(6116002)(110136005)(386003)(6506007)(99286004)(2906002)(52116002)(7416002)(316002)(3846002)(305945005)(68736007)(25786009)(2201001)(478600001)(97736004)(86362001)(14444005)(256004)(36756003)(66066001)(81156014)(81166006)(8676002)(78486014)(8936002)(6512007)(53936002)(6486002)(6436002)(476003)(446003)(106356001)(486006)(2616005)(186003)(11346002)(71200400001)(26005)(102836004)(4326008)(71190400001)(39060400002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1470;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VLzuT13e0+XwLU+f1EJPbltVLxKBrOOLQakWZC2a6t32LeWhWsBOaln0yXY6BBewVsvu0l7xJ0Ae3hIfoJvW2cOBY9ep07vF6meC6sVC+yJZ+xhmhXKKHLQ1bd2R9IW5i4wRrCsJ05RLL+BtSa9igHckS7VPgQXZac8cES7PxwFJ87d8MWBMJpizGYfHNuwAsE043FDC4ltIAI5BQXxHoj3qIFuewX1Cl31wP6QORa9x3vi2h0EitsRxy2JWegDh0pofbFO0v0kJ5hoyEh0zoZLJ0J5rDpMaFcY9o52Onr/bcMWvJbp+jnDcKe8fJOCRScBkcZhpaEn5YIGC+n6NyJeWcydx1IlVP5z9Lp/RWzc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab57540-8599-4c36-68c8-08d658fad7dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 08:39:31.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octal transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v5:
- Modified string 'octo' with 'octal'.
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04..651bab6 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -195,7 +195,14 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem =3D spimem;
=20
-	if (spi->mode & SPI_RX_QUAD) {
+	if (spi->mode & SPI_RX_OCTAL) {
+		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+
+		if (spi->mode & SPI_TX_OCTAL)
+			hwcaps.mask |=3D (SNOR_HWCAPS_READ_1_8_8 |
+					SNOR_HWCAPS_PP_1_1_8 |
+					SNOR_HWCAPS_PP_1_8_8);
+	} else if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4;
=20
 		if (spi->mode & SPI_TX_QUAD)
--=20
2.7.4

