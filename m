Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D75C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDA9207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GlLFn/k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDA9207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbeJWSAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:25 -0400
Received: from mail-he1eur01on0070.outbound.protection.outlook.com ([104.47.0.70]:21493
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728540AbeJWSAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrUMl5JWNpVfog1oDt0xvjozcc5pGrc5tm3PgwG7bqs=;
 b=GlLFn/k/yo68QP9pAshny6iUs1LQRQKDoZba1VGF4Ui7NuVHwouD9oHH45Y/yexY1gXxzYlWhoV98nzYYSXtPsJfMc9SF3auQKy5GXKadMwsuh3COW5oPZzDIaPGFsEZ7wi2gC3/3N6hJymsVzttEzG75VA8UmINTzXb57Ghls4=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:32 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:32 +0000
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
Subject: [PATCH v3 5/7] mtd: m25p80: add support of octo mode I/O transfer
Thread-Topic: [PATCH v3 5/7] mtd: m25p80: add support of octo mode I/O
 transfer
Thread-Index: AQHUarQFKUSi3S8l40SMwx6fJIUHGw==
Date:   Tue, 23 Oct 2018 09:37:32 +0000
Message-ID: <1540287311-1572-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0141.apcprd04.prod.outlook.com
 (2603:1096:3:16::25) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:zf/FeTiMVin9Qn8wfpcXQS2Gy78FMg4HZqK85qPl+MPE2DvrFBefDtMUXT3eSEsnyXFBHsNXoJy1i58Y0//8brkBTUdoQjwk0ngM8OW5KII8DySrdUWtXexE4XQobvzz2z9X14QU2NSlN+yXdCLc6r+gRN8jmj/PZpFbQo8WgdbCUPU4vKoIQPWgmfrgiF/qiuIzMeLbRj7m2pLHxobVIaovhLzb0SSbdV07Hv2pmcQq5lH42922cmcaEumaktM+7IOgJ/IMx9IR3nkey5fcbRiFo5xrqFhWNmmuUPLa5Doa0Hd3ZF0ES4k9fbS3A35ab2poKXZNDpdKT5NNKqpu+Tv9CzQ3Biz+BHT9WMON1wmUndJn60I7B6mf8oS9AGxZAUY3i0FHpZ3hGdLvtZ8mzipjE6TVHqn3UEyP18sz7W0+hxa1zZ1wbb1ApMNTjJUYhebISEusntbE7d5iRNIL9Q==;5:O9lOHC3XJ+cjcUNXN7EOLcc6RRbXVP3SBLlSr6TZM1kZFP8vzpI2DZ9rLbTBvGcXLYjcFKhH29I0LOUCI3neAVU0tlx9Qir+M1+p5/Yd3w6yjfPMIwp+X+s94dAyZG7325rWpxJnqQSGRZH18IpnTwtQzpIYt+hgo2Dy8D7mGmc=;7:LDSpLw/2iUTYzV8phQyxHg4YB6euLIiuUDNuA/h6oNvSb0tgGTJdD18udBsug5260rcI3lXfXU6ScjMpmeQAkNsUAmk/cq4ZQD9Z4VsSN0gvT6V9Jmr190cQh21Cj4yAftz7AOzupBd90nef65Tn+JrM4ckwq9xF4/6eCfwjURnij4JQRveSC4nJRSsTWKbVBbcVC0TNU1mksEiA+32QVYgB/eS0TJw7hcBpVbzSg+WUOYLCIa6q0QCvXSWiFZag
x-ms-office365-filtering-correlation-id: 80993390-66be-4e62-33b5-08d638cb27e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB5022C89A14E6D22CD844CB4099F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(14444005)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IGbew9nwttbqZeByoUJC3nMQR8QFg8CndbWI7iie7vQC8mP5Tu1MKodTY/NlQ+Xi+2yh6MM6NaMMkCCU+3BPBiTqB8SWquGfbqtZ1mOlSpir3c+FX9IasNaEogJ35i0x8tnLdOYvw75rB9WWdywBQ3mF6TrF37WIavvncOmX0az7OcCARlhMBaPrEHPIyHnv4lay7yZ5j2N58fVnctusXbO5jb7tZlWj8pcjxfICVqygps03S/q/NWJhWnhjmBrq6GbO9GgeII2KUthE3gldu/WwvSeB/d7zWjgOo+oRsklkQceRDiXceSHpuz/vxhAzBp6BH0FQlmRHxl7R2WghdlO1TZK0n6W0mGrjIsB0acA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80993390-66be-4e62-33b5-08d638cb27e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:32.5344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octo mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octo transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index cb14cf9..7d5c3a1 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -175,7 +175,14 @@ static int m25p_probe(struct spi_mem *spimem)
 	spi_mem_set_drvdata(spimem, flash);
 	flash->spimem =3D spimem;
=20
-	if (spi->mode & SPI_RX_QUAD) {
+	if (spi->mode & SPI_RX_OCTO) {
+		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+
+		if (spi->mode & SPI_TX_OCTO)
+			hwcaps.mask |=3D (SNOR_HWCAPS_READ_1_8_8 |
+					SNOR_HWCAPS_PP_1_1_8 |
+					SNOR_HWCAPS_PP_1_8_8);
+	} else if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4;
=20
 		if (spi->mode & SPI_TX_QUAD)
--=20
2.7.4

