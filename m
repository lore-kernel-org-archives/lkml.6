Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27723C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBFF207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xpl2soHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBFF207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeJWSAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:00:24 -0400
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:47104
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbeJWSAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmdXWgEHp8XRel1doDtaRcO+0D2v6jISOd2eKhNZHpg=;
 b=Xpl2soHITEW9kwLbbG4XyDbpVHXBtH9LyrTRNaFvKASMS+2xHrXAUss7fjhFh1eu9Ai0QFLg6FmaNWsEuJP92gjKQwc7xUr0FGCvc+vPsW69IVAKgi4hJQhEaPVi4xwxG4monENWLpL1XUGTCTEtGPMZdBFPJ30UsanV9Ax+ric=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:37:26 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:37:26 +0000
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
Subject: [PATCH v3 4/7] mtd: spi-nor: add octo read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v3 4/7] mtd: spi-nor: add octo read flag for flash
 mt35xu512aba
Thread-Index: AQHUarQBzGIT8YtCf0iM54fpMwIFSA==
Date:   Tue, 23 Oct 2018 09:37:26 +0000
Message-ID: <1540287311-1572-5-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5022;6:lwb5Xh99wFymjC89VNThRa0HNih9hc1XU4t8N+alFxT41WlRlVo4Jt2jZkzIGPPX/p2/TDe669qe5YeBwvf8KR7mAYx5ujZqM+a93jAwYAqwOauJXyxah5rum696OV1JgSzcgw04oBSoGiVGFLcUq1itdGDFNSVEg2OXcbfCPoPmrkOD4eBEV1i/STrSW6aTLRsgrCYXNrpykwq1b95op4e7/HlNbKX997NWxc/pCdgWDPIAAKAtFfJ+/Y1VqJBgsDcG5ItmBC1Ev0dPbl8bRWEek4vL7ibr5A/rYjzpUkIuL9M2p7+lQq0HXOC/4wYr1b5OMrJNe0Y6amB03uQGUJ1wHLVHNX1V0YeBW4SKOigtYKZw85UfuNk+1y5R1Ps6lnWs2AxgdIFa/PUIUt08SkJ+f1g8tfZHQO5wXGWIjG2EfADHUI3I/MWx6S6CKo5eyB1871QxCDC/aTNBugr8JQ==;5:oLBj/K/YflCgO8QVsG+nRCdlTxJ0dXPFNsuhudZqFGy0llJPEcUGx9rAAQH+031m9K1WNJqN6W5C4VEA+qFKG/tOScHHERQX8vjosUsMPzi90nwb/G49nB8QI2z3MVYKIo10sS83GN2srRqGmK8lXWeTQDNH4DOfl0zmWi25xUU=;7:cQnlgysAfrlpipy60mm+1c9bP2ZYkeo7B9nq5EN3dn1LegkjwUNlMbynS10KgswT8qp0Mul2oWQ/DdteA7tjlbe+SLW4Mn5hsUZA8SCHx7Dkwg9nLXE+RbeGNVpBzUdtzEtA5cSAQafRwv6KEXKFFPXQWQdpKQ1Bb3P16gzWdM1N14iapNCLHJiZLu2RgLvSmL5hcurbtCTA63PFqjHN/8ZAtSnYY/H3bz2s8LAwSevFQoH+pyrwPcJ8Yxau5P8m
x-ms-office365-filtering-correlation-id: 98b57d7a-4a20-4506-d3b5-08d638cb23e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5022;
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB50228A7AA06CF2F035048EB999F50@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5022;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(256004)(6512007)(106356001)(102836004)(446003)(53936002)(71190400001)(4326008)(71200400001)(2616005)(54906003)(2906002)(26005)(55236004)(110136005)(476003)(105586002)(99286004)(3846002)(81156014)(7736002)(6436002)(305945005)(81166006)(7416002)(6486002)(2201001)(86362001)(186003)(6506007)(386003)(2900100001)(52116002)(11346002)(478600001)(14454004)(6116002)(8676002)(66066001)(486006)(36756003)(97736004)(5660300001)(39060400002)(316002)(76176011)(2501003)(5250100002)(14444005)(68736007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5022;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iISKfIXVfDt9CI6oYOsEf57Bn+a7P+oCzlVbQkmmVYVR7K+rV9X7kkBuK/PX4UiW/Pkz7b3Vg/AoMi5NhHeHMhyHvTv05EFB2mrcfHVj3nJjugPul5CoQLg9O3bsz0m48Iab9UDaETDCdOn/HiEt3RrMVbkTH9kGuiV83yQOXftsBEhIQyMYbtHzf2xng5GjRlr8DBlIWJv3CFqOlLpwq6ZPyIEZvifm5PGODcCoZarPjfFitITDckmuHix1A1Wyy9htdevoTV2HmUwtvvIOk8x5oEqZohS9eP1e2m0L4whQIDRQyN/mtGX2AxfphI6gL9be1e5me48pPPrI9OUtp22VxYAdTorQXoRRhPDaUXk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b57d7a-4a20-4506-d3b5-08d638cb23e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:37:26.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octo read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTO_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 120c3bc..a04f579 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1413,7 +1413,8 @@ static const struct flash_info spi_nor_ids[] =3D {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTO_READ |
+			SPI_NOR_4B_OPCODES)
 	},
=20
 	/* PMC */
--=20
2.7.4

