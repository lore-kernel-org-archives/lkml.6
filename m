Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E035EC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D4F2083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wJAcWNiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D4F2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeJOT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:35 -0400
Received: from mail-db5eur01on0070.outbound.protection.outlook.com ([104.47.2.70]:3040
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOT7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNrPP8gxwgeFL/C95rIJq/E6CiOo7cfDlO+xOSX8phQ=;
 b=wJAcWNiXDneo4s3tJ6VH+x9Rv+kZVQJfGbOEQILv/NJJvqVyx0XKoGUSfdNdNwJgj9z47+0j2xCvKRGgrmvmNKNMDjns0eMsO4KvA73i/iN7DecaxLggcHWDjcO2y44V71N3Z06z1QwsGt+Ru3PF2n/bhNuEp1iPGvrbzoE9/Vk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:14:28 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:28 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
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
Subject: [PATCH v2 5/7] mtd: m25p80: add support of octal I/O transfer
Thread-Topic: [PATCH v2 5/7] mtd: m25p80: add support of octal I/O transfer
Thread-Index: AQHUZICeK4t/3D3pX0Kd13n0ub7g1w==
Date:   Mon, 15 Oct 2018 12:14:27 +0000
Message-ID: <1539605534-22302-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539605534-22302-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:5IsBGR1AYzNFrLrcC/wk7Cm4h2Qu4aMHYQEvpig1PvPqTiQBK7+Muy9XuY/AB/R9ziiiFvhrhd/kJN+7kuFSyDbzjbGrWCeu0OcyR0lI8bSMLUtgej41zLrnq6EMXUVHENCYOhygdYBjLnkAsDq0tbfLJCeHS0GrNJKulAvqX7FBPsPYelFfJOJ1ioxqvxTE9sD6JA4rGAP6TB2r5PVfHzeqwPX8wbbO22yzaCcQggXux7W444wFxart46lJThjJ8e3XdlfF9A4K+8jr+uAbqXjP3IxMzJMnfx5hhle1uFb+RjRq2nQ51CpKWMXfxi+XHXJMAfqAwl7lhsrv0OnCUTrbk9nMPKTV43F0gvAcY2Jlhreg89f15ixNumoizL/jUx78YyQwGG+U+7Fh3+31FC9Exlqs5be3OUlJqt0y9WnKzTXxcWUqdaOwfBv+DDNqljDbJH9D188aTz1LozZlzA==;5:m14qVKo3TSDo+T9hCRzRg4DjBjnOAOneC8e4CB0/xi5JaWBXifpPC0AqHGK969AJ5MVob75hACH3Sfk9nyYWTxm+nZgA3DDkdbNUjMbFfKWlG+sF2/i3u6zStiT7cukPCdZ+nU1uhI7q0l16OSZD2NWIdsXpJSc6WgELsluzRrg=;7:TO/Iwfq86Mqq0UgO+y6GDstjYAsff4P+IZBaKrSdrASQj1Q6/TqtXzmoOwRZ6I877lNz3xPu7VEzsd9lTFDfG4YmcDaoT/Cprh1zaJM1HedabUwCQ1tuPjADV8geUQErq5nCvPX62YtNqUZLplTJ+P6lBEZXhMz7kmz7KNRf17gAhR5/o4Ci4nWHQZlsYZHFtlxpkJJVrJixDM/rIhVxRtrrepM+8MSiLvC2l7+vWKGCtg9BMQ1NlQurtMHAJ1HD
x-ms-office365-filtering-correlation-id: df2e6c7d-4175-4b50-7a51-08d63297c0a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB4240A227D6D2947AC4AF21FE99FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(446003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(11346002)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(76176011)(478600001)(4326008)(5250100002)(36756003)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(386003)(14444005)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M9RfJbkXyovgXuPUVXnfgKzkqEjC6lmJ+5RYxefSW6S36N5UcvthexTlw1zE97i+OzDZsHv5kwBhM2wLPgYjK2RRETIv7gyjVfrGBCWuco2cqLTfirzHuVWv2yJuQ6PIse+dTRrer7MdoIIdGl152J/bFEZhUB2C9VrBMMNpjOpC3721PJZppU+VR5OKkPAC45jxJeVjt/fzjB6BusryTrG4yQyzFHzO5CI1fYDj6hojWLD0Ohpbm+K6EVdNl5fEqFGA6MP0JlNBbmH5d9Y+5K0goXYDulqJl8wGoxBPUnLu7AUC9f7oCo20YM+nl3x5HuygN9mQ4nG6zuDJi/1tFJmt+ZFg/8JK3hDyRIFJmTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2e6c7d-4175-4b50-7a51-08d63297c0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:27.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octal transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index cb14cf9..e5e632c 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -175,7 +175,14 @@ static int m25p_probe(struct spi_mem *spimem)
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

