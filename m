Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43189C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CEB20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QJJ7DyCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CEB20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbeKVPwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:52:41 -0500
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:1281
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVPwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iha3/v8Unuz6gsDMk51ecqOZOKXxD/Kl3uHaX/5n508=;
 b=QJJ7DyCwVw2bU6A+ICxsuXDsVX4be6wZ3AX5nSjSnXDBka87iY8E59lOlBsSTQLAyCKVAfGnFStp4ylXIv1WG5G/akgp0+Vd4ggmIyYEHvOuo6xqmY7dAGs9XRgubUYtgp/ClRuboF+/UkFM9vOOBhDWWebx/IGyIH1b10oeYH8=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB3055.eurprd04.prod.outlook.com (10.170.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 05:14:54 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::595a:9890:8397:5d51%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 05:14:54 +0000
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
Subject: [PATCH v4 5/7] mtd: m25p80: add support of octo mode I/O transfer
Thread-Topic: [PATCH v4 5/7] mtd: m25p80: add support of octo mode I/O
 transfer
Thread-Index: AQHUgiJNSdkh7a1cb0+RXLQlwhw+uw==
Date:   Thu, 22 Nov 2018 05:14:54 +0000
Message-ID: <1542863544-21257-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1542863544-21257-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::32) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3055;6:a69qq/RqxVwIgXtz/vdmAQBWHxyNkOk98W/FkRVZzQhFhVSNEvP4VF8s+YTFyEqkLNG0Xj0D6MCd9G33bD2GMNdm0HzRebiyRCmSWFtfjH9K9Kk3TOcPUmcdQ7F5bgjfWXQPK3AP/gI6fPSncQwy5oz8i7guKGSZ3gdhR/V19xFTp55YUaBMhL2Q68vnP3zq43I+kQyvm8C/K14deU2ACodHPMZsikjuFnVl3D8kxkOPMo4iPQZrWGKKr6aCDBX3Ioj9r1fJcAzMWKCmjkxLG2TPTisbpDdybRbGSC1R8WzqjrzvyLPpazFPIcFEHJBWew7M/rIt9nvLFKxqOypk1JDYSCaKi0UYxaYI173/2378OTny2RxvMeA0DONn/a5EE4eZl3kSx/dk32nKWZoSVmacbX4qTBU3ibV/NIGZNckwY+CzJv2v2nB8c99lePqpkUmwxVeEpky76jR1B+reJA==;5:pYLfACefKkHWhtoQUb3eN7/i3xKBl3u+ILRLqO9nQUH9Lcw6gaKDn2PQ6vQQ/uoyaLjPsWqJsWnl+cXa7elUjp1vswjZR7TU04zSlCaKlNznL2t2bxm2YUEQgJ4JQfm35iuK2ectc+aosaMSMMArxkc+Iqsje8Q1AhJ+6pDk3Tw=;7:8+mSkVFdGU97+ZAJ0NLQf0+2kTnnyBiKY6FW+aYxSOfV54tvhQI72AMttKlO7Xch/9N0+6uDSVYHKEkMWOP4deiHyU3USFsXmSdVuVH5K7Tq3kc+YRvtBljgZfSk5q1ktthwV3ndN/JaCn1p4s1P5g==
x-ms-office365-filtering-correlation-id: 45aa75b9-b85f-476e-fa6b-08d650397024
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3055;
x-ms-traffictypediagnostic: VI1PR04MB3055:
x-microsoft-antispam-prvs: <VI1PR04MB3055FC9A4110126D1841E99499DB0@VI1PR04MB3055.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB3055;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3055;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(8936002)(25786009)(105586002)(316002)(2906002)(106356001)(52116002)(76176011)(4326008)(14454004)(6436002)(6512007)(6486002)(53936002)(39060400002)(68736007)(2616005)(476003)(486006)(99286004)(478600001)(11346002)(446003)(36756003)(102836004)(54906003)(71190400001)(71200400001)(386003)(6506007)(66066001)(6116002)(3846002)(110136005)(26005)(256004)(186003)(14444005)(5660300001)(55236004)(81156014)(78486014)(97736004)(2900100001)(81166006)(8676002)(2201001)(2501003)(305945005)(86362001)(7736002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3055;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4cFXj5D5CtwPhzVPtuLdEsheehFCAcrwfa2ekLnxy6KA2BgAThyPFSCqpnOiRyX24bj4s6+51oULvDsK4fH+jHXvdek8qbNfzAlYTLgAatQ4jJqBAReK+f8+mEr8nT4kLqFXutNvaQY8BNDRR9Wafsg69+dAbrRJGepKv8DAIWuDNIX7mPDugJILE9O9zieIxSkTSEQCXT25I9LZkGOY8DV661ZCBS1Nj1MDp9xAM6ym+S2onUeCcEO2O/uIvARA6Mxg8zWbX/ij7R35Z/IAwSzZMgfC9kXM9ogpgmf795KZsAFufjgBAUGEzpRebvnVOwVkaeQ4j6QH2bUuYPwEXXXKrUfXoc9Q0aZmkG+cu90=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aa75b9-b85f-476e-fa6b-08d650397024
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 05:14:54.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octo mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octo transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v4:
- None
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris.

 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04..6f3c280 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -195,7 +195,14 @@ static int m25p_probe(struct spi_mem *spimem)
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

