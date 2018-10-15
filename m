Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB909C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852E820881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xEaWlWaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852E820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJOTdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:33:19 -0400
Received: from mail-he1eur01on0080.outbound.protection.outlook.com ([104.47.0.80]:64448
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbeJOTdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNrPP8gxwgeFL/C95rIJq/E6CiOo7cfDlO+xOSX8phQ=;
 b=xEaWlWaR8zvN6QATLoma8ppEdfPn1aDlSVHS1KHDSRD5hqego9Wb9V0jmUE36954vAW20OaQYuP+7Fr5GhDIgmc1oQpLGZSxXOUluiDOvXxR2mFpip/1H3+pjRX4VKjQwPIJSpuYxJZ/hLlDYsB2nAeGIDsnt/H5PHvsM24+LZE=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (10.164.84.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 11:48:19 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 11:48:19 +0000
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
Subject: [PATCH v2 4/7] mtd: m25p80: add support of octal I/O transfer
Thread-Topic: [PATCH v2 4/7] mtd: m25p80: add support of octal I/O transfer
Thread-Index: AQHUZHz3yd+54e3bMUCmj/xMT+gPbQ==
Date:   Mon, 15 Oct 2018 11:48:19 +0000
Message-ID: <1539603969-21076-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1539603969-21076-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1616;6:e3b8spW8h3m0+GgJ1o0+OQIaJ8j/S/0LooxYAjdFCiEhjiW2+PhqZkdRQx95BDXLMdaeeI8SNZ2MXz6A7XkZnhMXYo6258Nqzg4ysI9bwA7lgTigGTZ0rvpNYF7/BSsxh59cax79ueELMU1Pbc5cRcSUCuPQ3ddtePDHOpYWIQbWI//RGDqLtcMfnKEn4LWHAqR5iZkcsFfIeB7UTpUp/ziOTLSxqpirrn/e0bDNCKpFYasZqaE27N8GOanCYHW7eLcmXCeKvAJnnCFIcWCfRHkVxE1ho1Ogxma1gBawMjh/hP2q+2jHip7nX6rqQlMo1bB8EhvM7+yq7NkW2XBjoeAe1rdlYSvlUJaDmd3DzHbI5AKwZcplC5c/gwb34BeqK9/4b6hjO2kxl52OijWNb5Q13ZQkEE4pZ1Txb5iCna8Z3JPF0/hYQyZsZ58SxM2De/LNfLowX43/Fu2jSZOrt9PuXvPD6IAcq0+ItPoXx8g=;5:e9PVa3023vQ4lHZXFf+K4/KWE4hzH/sf/TXSCim9O5godG7uZ1l/tEQyNFt34OFpTK0gr19UdBItzzSNUZSptdMcydd7w5kxcwHTT0cgyUR9/o5sI2Bv3A4Tm15ABI7HoX6HHl+Mj8zdlM6xs4yTyA1ETK/6grohGik9+aDAMVk=;7:fU4yEckDdirqn509xEm2U8vWRet3azbCNyF6yj3oKqhN3GXCKUE72SJFCsKfY59rVQFh5Z7yLh8VwN+K4J6mek2pXtIsNlSYfn6TBf7psEWxVLLCvVPhKDfH+dhUplru/aFdc1oWnOFaVJPznKAxWBPD6vSxosPGV2cEoB4vsTJcMWvFHIPcxgdYy8Pu31CcTyUi5gfptPe0PqCi1XXbBJoFGqu4ynyBcJbAZH/nfed/1OGWWfmsvAlqbz2LsABa
x-ms-office365-filtering-correlation-id: f27d7d72-08c1-460b-9988-08d63294198e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
x-ms-traffictypediagnostic: VI1PR04MB1616:
x-microsoft-antispam-prvs: <VI1PR04MB1616831EFF38079125E307BE99FD0@VI1PR04MB1616.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991067);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7416002)(8936002)(4326008)(2501003)(316002)(66066001)(5250100002)(2201001)(53936002)(7736002)(256004)(14444005)(6512007)(25786009)(6486002)(6436002)(86362001)(68736007)(5660300001)(305945005)(52116002)(2906002)(6116002)(3846002)(54906003)(110136005)(76176011)(99286004)(39060400002)(2900100001)(478600001)(476003)(11346002)(2616005)(486006)(446003)(14454004)(106356001)(36756003)(186003)(26005)(55236004)(71200400001)(102836004)(386003)(71190400001)(6506007)(105586002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NUzhtO5WbdPZvKFsk67Wn28KZGUrMBxCExlz4cREoNW6vn/1JvP1uHyZuSA2GEaUmw4zCL+o3uUm6h5gYvs8ibZ1Ip6nPkrZn8gZpROZxjRtq1C+7KZE0/qRy9MnGVqmB73XsdquxZlA2FVSeLQkqia6PJBUIZmSuL01bg3Ig13Vd7ssgxGc3etwf3IKQW22CdfmfVT7jyr9ZpXWAC1rXbb2uoofYNoKXwJEDQDSKe3vDEp5rFkeZxTA4bIy8n/PICj7z3t6bYTcC9mEP04VL8bFpuy4F2XeBfk4NR/8N8T2kTgs+EoBOs3s+pX8+N/HbWM6lu2vRUU1dygMIAYelR34g0nYqBZ10x17Gi/IrMY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27d7d72-08c1-460b-9988-08d63294198e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 11:48:19.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
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

