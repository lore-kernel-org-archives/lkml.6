Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2C5C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29FD20663
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VbTndJNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfBEPnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:51 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:65268 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBEPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:48 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="23460621"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:47 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3DbP0akwgA1ib2ETINmbcm+K+erVixwuSYsl6qmapA=;
 b=VbTndJNzFu3btmUQlLfPnTUsJXvDpcSlyb1lu90fEon39vywFo53AcXHdz7TtyIUzbgYOK5u6u1KInnu/e/Uo2rAMSIM5j3TEM31XNw5x3scXUTHfUsY4+8nzPt/9HIgpFlgvZoD2sTDpn+6N1Lg7cIuQMTLKsI29VOWq7m7LPU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1764.namprd11.prod.outlook.com (10.175.98.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Tue, 5 Feb 2019 15:43:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 08/13] spi: atmel-quadspi: rework transfer macros
Thread-Topic: [PATCH v5 08/13] spi: atmel-quadspi: rework transfer macros
Thread-Index: AQHUvWmTFUGhomzabkCYHRAIfK6I4A==
Date:   Tue, 5 Feb 2019 15:43:44 +0000
Message-ID: <20190205154257.29529-9-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1764;6:/kUcAaQW5IAL7X3XYYQ+JGB7mNQlJ52Ja0CvoTbcvd7cnzn5lLPivz7eDJ0hu9HC/xQj4YHEd5c3217IOmHVusJwFdnowzQQdvQtYhpWe676TiRDug9mYS68pwfWN94K7XTMb/2TLs8h+nBeFa+vyGqFUGGFHEIXkeiov7HOmOFUZRX7MhlmCTxqKjOs/pQMYSvajYtPujiAq52oEKCbkwuZYh1E5MAGIGkpWAowBeQJSubUBGQ1N3D6exOxOC+/r8ysHNCeQokFST75wTQ4fePiJkFgb5Y3VYXlzBZyZakBYgLAsWAFBAMloCgayzH7GFnOWih1MokPXF2zZuh5pQji1Sp7cyKdIOty6JSfOoxNl/u7VIpKk34krH2RG5tNE+6D9pVPUzgazkoFN/zcPu1tOpuyrLv6BFgwULsWT4yT8GO8y6nYkxwntjlVF58kLPFNkbk6gc8StXrUHMv3iA==;5:YAs74gLgXiIAW09DfwvIzLTVBhsu8/VGwXn/TLT/1WGOZwMeSYo/3cGM1GscIP+f7HguWSRIjvR3ltOr1Ci/toUW/JdFEjanstQAOKR118RpcQsBrSvGgJ2bA7dRIVkEHpHRoORMS+zQxyWfQf6ZGKAS2cDs/MYrrkL4CDL1w251FJ/GxNEndb4ICYAOKgzFBZ+qEnkBUnZDFIF8JdeD9A==;7:yJ0F5rs2sv63cqwIIMPRV0//dIBvlo/gvWNfYipl4KUcCbAnz2IKRtNlytx+e3sFQwCZYFfqshyVWOwPd91bX2+GZQF9GYgpKQ3QFjSU3s24NFp5J0bhRwSnCLvKy59cXrxHbCHfXnN65t0tgu/tPw==
x-ms-office365-filtering-correlation-id: 7b95c937-d88b-4b67-ef51-08d68b80b5fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1764;
x-ms-traffictypediagnostic: BN6PR11MB1764:
x-microsoft-antispam-prvs: <BN6PR11MB1764B1F2367B946F4C62E038F06E0@BN6PR11MB1764.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(366004)(396003)(136003)(199004)(189003)(25786009)(2906002)(4326008)(2501003)(50226002)(8936002)(52116002)(53936002)(36756003)(76176011)(107886003)(7416002)(186003)(26005)(68736007)(97736004)(386003)(6506007)(316002)(54906003)(71200400001)(6116002)(2616005)(105586002)(66066001)(476003)(110136005)(6486002)(486006)(86362001)(11346002)(446003)(3846002)(6512007)(71190400001)(72206003)(478600001)(305945005)(14444005)(1076003)(14454004)(256004)(6436002)(102836004)(99286004)(8676002)(81166006)(81156014)(106356001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1764;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UmZa9UO+yLBFzNcNXvkisxqVL/o8vCWXHE8aLr6VjJC9XTROmqhtKns79hhNu8f3XR/wv5Jxf+IobKe0779cR0IRJKN/l6EMNeOxhKTp6GiSWD85PqGHvs6z1vWcUJh68mJDKkYgxh4vBCFogmLdPtDN3j+N3wuZvxtMa9RuERQtMXUyLYy6t5lqqFdF0tqsIMH3QW4euXvqi2x5IxeUERaYqa0eL5hc7pV5jnnA0MEovcvqVF/sXWcd1dj/tNGCo/VqHod9/NbkFSHqJl4ck171a/mzrnV8eM/agBhZFDaygzsRFWz1kNIDuWpt8T85IEMlmJhFFiLvdZEChu1YuPqYcVCymSAUoCAUSKGcyYKONR4xZR75lppkdtM4P8uhJryuZZs0uENCXHDsO+gehCPtQyfX8pfnRqt3VPgtkpc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b95c937-d88b-4b67-ef51-08d68b80b5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:41.9649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1764
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Split the TFRTYP_TRSFR_ bitfields in 2: one bit encoding the
mem/reg transfer type and one bit encoding the direction of
the transfer (read/write).

Remove NOP when setting read transfer type. Remove useless
setting of write transfer type when
op->data.dir =3D=3D SPI_MEM_DATA_IN && !op->data.nbytes.

QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: collect R-b
v4: introduce QSPI_IFR_TFRTYP_MEM, reword commit
v3: new patch

 drivers/spi/atmel-quadspi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ce4f8a648f45..19a3980775ad 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -113,11 +113,8 @@
 #define QSPI_IFR_OPTL_4BIT              (2 << 8)
 #define QSPI_IFR_OPTL_8BIT              (3 << 8)
 #define QSPI_IFR_ADDRL                  BIT(10)
-#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
-#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
-#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
+#define QSPI_IFR_TFRTYP_MEM		BIT(12)
+#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
 #define QSPI_IFR_CRM                    BIT(14)
 #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
 #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK=
)
@@ -275,10 +272,8 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, con=
st struct spi_mem_op *op)
 	if (op->data.nbytes)
 		ifr |=3D QSPI_IFR_DATAEN;
=20
-	if (op->data.dir =3D=3D SPI_MEM_DATA_IN && op->data.nbytes)
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_READ;
-	else
-		ifr |=3D QSPI_IFR_TFRTYP_TRSFR_WRITE;
+	if (op->data.dir =3D=3D SPI_MEM_DATA_OUT)
+		ifr |=3D QSPI_IFR_SAMA5D2_WRITE_TRSFR;
=20
 	/* Clear pending interrupts */
 	(void)readl_relaxed(aq->regs + QSPI_SR);
--=20
2.9.5

