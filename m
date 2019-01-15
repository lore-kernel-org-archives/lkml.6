Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF48C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844E320651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nPQ6AqV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfAOKF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:05:29 -0500
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:21740
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfAOKF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H5vAledmi0esA7RBZS8cP072AFqnf9w5a0YwwQhDEs=;
 b=nPQ6AqV3xVQajzukwEsDcrJtsmi6ZIeOxOZRKZw4MavbMwD6MRQmcUbxkdO1GxgPQHo0zY1uH/btRbFAhHoIs78nE6KD7oNOx5YAz4QMfAV79gMc71jF4vUkNIVqGonQxACMXgiWyUaMseGBzfbmP3rAVex7fJc91Umgo0aU9lg=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5822.eurprd04.prod.outlook.com (20.178.204.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 10:05:23 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%4]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 10:05:23 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 3/5] mtd: m25p80: add support of octal mode I/O transfer
Thread-Topic: [PATCH v7 3/5] mtd: m25p80: add support of octal mode I/O
 transfer
Thread-Index: AQHUrLnUkUf6WbGWr02OhoksrpQ9ag==
Date:   Tue, 15 Jan 2019 10:05:22 +0000
Message-ID: <1547546584-5254-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To VI1PR04MB5726.eurprd04.prod.outlook.com
 (2603:10a6:803:e4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5822;6:Ag9dWE1ag6+JHhM4Bk8YsHF09tVGWVoL7kcRutAHS3MMWJD+2E4DNZXnF46CinZZfVzDayQBf9wvicgE4ZTGxXGR6UIu99Q9oy/vdmI6T1cTx0zyRlDYSC+SVicWAtQK1ejeuDwvIrc2J4KZisfXgrxjoxbEbeTtNWb4Or/FSVRbepRHDTrWRcqBUQsCRMHoV9wn+rQlNIMNM8pWikZRB+GPLV9af1uMIi14kgkCrWHUN/CJOTEOMAZjQEw4RgH+oZamUX7mIG0YLRnNsRPSWctoP9YBGH4TZvnwOA5BFCrHjgVWwThzgPY5YP9tQw4RQaU3nBoV/y1ZulKOH0+hVxJd/4opBOpjENWixpPqEkFkKSILFOADTckkqtTN9HpkL8vJzjSEX4rO1KO9Jxc9jfAogxdQ4ZU+ctLaHQO+YBNIEORI5YdA5Z+CXpt5CROmYpi2Xd+jvx2X1MDXwU4usg==;5:Ul5nd7LIqpTjcHJOIvshhbfcloQCAMVcWjraoMcNTPh2KR7UTLoMd/5Pv97IQTXvPv9s7WE5dYHGNh8P8r+axkHhgVTVlbyK1lKdXLBY339nufjNAy55KP8fL+51SH0hobefSymcObplAzLm9QH/WkMOVZbHuW/J8KbxHKTd/olYpM7CJgy7p+l4ps6nahQEGnaRPM98We1luKSHNpV+WA==;7:gptW05hTBtZ/oxkxgKV7TLjX/MSLz7YwtoxFtmM+akay/JN0oe1r0LoIiQo0r2nS1FkqmKjdDsW2kzRrSs0+YY786WWc1Jkf4DXbyijhDvbT74kL4/kGzZgr9+ho5JoJiT0VJJUD1sFZYVrujGsRLw==
x-ms-office365-filtering-correlation-id: 383a9aaa-f204-4ca4-9ff8-08d67ad0f670
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5822;
x-ms-traffictypediagnostic: VI1PR04MB5822:
x-microsoft-antispam-prvs: <VI1PR04MB58223B1B17D7E316FBBC556A99810@VI1PR04MB5822.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(36756003)(305945005)(14454004)(6512007)(81166006)(486006)(446003)(2201001)(81156014)(2501003)(4326008)(14444005)(105586002)(8936002)(386003)(7736002)(86362001)(102836004)(2616005)(26005)(186003)(6506007)(54906003)(50226002)(97736004)(316002)(5660300001)(110136005)(2906002)(6116002)(8676002)(256004)(71190400001)(6486002)(7416002)(66066001)(3846002)(99286004)(6436002)(106356001)(478600001)(76176011)(55236004)(71200400001)(78486014)(11346002)(39060400002)(53936002)(52116002)(68736007)(476003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5822;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ScdKliUfYOU0y9Cln/XdEcLHwAMbJUMPKkKrFyqYakAuAESCF9s5fcYgNg4JHIm3zOm7HWcFg+1rpVdrX6T2cj2uQmOXgqHOtBKLFXPtRbZIdPtrJLIdyf/F48qvG87bHeAZ4lc/w3770VF86mx6wXiPDXExw4QEW/OslOyiF0Gh3HJ0ilTo4MQjzBboOWK555awo8A28Y9PjIIpAMO+bTiJnpzoFHo0jO3FYRt9zQ3y/Jn71PVyoHw3rufZQwQ+eZVf+KR03bB0nIBGtwLvxYwF9C+FAc18EHvVlL/1+fRRteTtyvmsX48G5kF8FaPt1jTyFm88xmGwF4FFmciBYojf9O4MLELqgxANZbi4qHx6BDDMqBNMTVz5rRodQHEkxFCOS3XzIfm2u5C7RYApoUNeVuv9ZvD74RI8l9FMcAE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383a9aaa-f204-4ca4-9ff8-08d67ad0f670
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 10:05:17.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for octal mode I/O data transfer based on the controller (spi)
mode.
Assign hw-capability mask bits for octal transfer.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c4a1d04b8c80..651bab6d4e31 100644
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
2.17.1

