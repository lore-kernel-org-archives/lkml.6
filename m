Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C85AC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488342083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPBvJkd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488342083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJOT72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:59:28 -0400
Received: from mail-db5eur01on0087.outbound.protection.outlook.com ([104.47.2.87]:39136
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726400AbeJOT71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbpsSOKRqk9CcRIeTqfas15AOZ/alGFiAmz2QAL3i3E=;
 b=gPBvJkd3Zt0j+SlWVYhq9/YMBH6wvQKndg2gJAjb1MRKIXx8HR7vVTnScwy4gWB4N0s9qsRpqjOCfQl2YdSylqjk5xtYxFPeSYK4FOGhc9SyibwQQtDccFV7RRcPSvnsxVJhF6ZhSY6oaXcEcUsNEtnANLFKc39uGaId3xg0l+E=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB4240.eurprd04.prod.outlook.com (52.134.31.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Mon, 15 Oct 2018 12:14:22 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 12:14:22 +0000
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
Subject: [PATCH v2 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Topic: [PATCH v2 4/7] mtd: spi-nor: add octal read flag for flash
 mt35xu512aba
Thread-Index: AQHUZICae4AyQTKH0k6RjbskCrBeqg==
Date:   Mon, 15 Oct 2018 12:14:21 +0000
Message-ID: <1539605534-22302-5-git-send-email-yogeshnarayan.gaur@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4240;6:sdRQncZP841xtSYXrG31bZhBX627p0WWQNcLS5t9imOQ1+5mucpjQa6/ZHIhZdCbQEOK25wjsMnZuvgNO232IGJ9gfxIHzK6hUdyGUUBIvJ+hP2IciLACTQwcbmxkBcNrbK2uodrqrpjEFQ5GWtXwtT3mPqlosaodcOm85AxYWTzZbTu/IJSwjF0utY2edEkrdX/CBvu1ERmhFKK+YqKlmr+zrVyI12Xty7SZpc9VfOGG9Rjzu/tnoMuyHlnUJzcIr7WQH77H7CB23Y+1ZvF2lmJoisr5xf35WLeBxNiGJt4twDIxrjaaao5UUnMSSqKmBWLNeX/vOf2vxlubbR3iv3o1Ef+fNk7WnJC895WxfCbcdcvH+n/hakWGCYBD9kWlZep53rZMPYEWP584AEIswbqhlVLa7mIabyM/71Fc3i7EdIFMOrvQvCzm2cBjpDWg+jkrOD8JRNZyG7QmEtKtg==;5:ceWcgZRkf7N3SLO6t2MX1bkIbKl+rEyOjn35njvpoaIlwjx02HbuhlUXNO7VgBeIYIFsaL+nU6g14JlTaDBvZjWEW5FnNPBnmoZW1ti81djhhu/3LyicezDPbVbql9/sag48pmji5TKI69/gkA243LiW1S+jBKjLCwWUYS0azk4=;7:nYkk9I8nlIaW2MAFZ5kA9M+nzFzLOoz2PMQgFCprlTUEs4xyY/u4LRtVGk3l1XpRVax9TDeoebsNBQok5M52MF3FEYlbTvNKxY9f/T5lOyJRM7vWxGT5nPhLnN4pBLWQGaVWQKqHH+NLeUDuSnS9aMwst+hKHjLkAP2Z++gD/Zh/ewbFYLbO38REcvvm5mEgneoSTsIdpVGpnn0PC6sI7ryOhEKVYIG+Z4HgIybSm+aOpEw8xVJhypSJ0NWDw8Lm
x-ms-office365-filtering-correlation-id: d7f7825d-23ff-4ebb-6e6f-08d63297bcde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4240;
x-ms-traffictypediagnostic: VI1PR04MB4240:
x-microsoft-antispam-prvs: <VI1PR04MB4240CAAAB4849641D30D3E2699FD0@VI1PR04MB4240.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(31051911155226)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4240;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4240;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(86362001)(102836004)(106356001)(99286004)(105586002)(6486002)(39060400002)(26005)(6436002)(476003)(446003)(71190400001)(71200400001)(2201001)(186003)(5660300001)(66066001)(486006)(11346002)(2616005)(14454004)(97736004)(305945005)(55236004)(52116002)(76176011)(478600001)(4326008)(5250100002)(36756003)(81156014)(81166006)(54906003)(7736002)(53936002)(6512007)(68736007)(2501003)(8676002)(8936002)(6506007)(386003)(14444005)(256004)(2906002)(110136005)(7416002)(316002)(2900100001)(25786009)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4240;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uoonjKa0qV7PolKFMuSHiITmsHbj1KYqMsMddjVZJRKtl0YLU956cM/kP8QoJW+hOIUorLkHtYAPkL/g/fRK6AgxbdDO/F7NLLqpp7N+qclBCig0bPp4KqmzHi9GYwx5G7uj8t0oTpf/Y4KnngTttLPQA1v5Q+Eyqvwx00h9XbydWFlg89/ovmg1yvI/IvHq6hlxh24oQ3yPkriajWRjupYSKcHFeXJMpN2Kc7GWYrqqcUl2KyZ6lY9oL3++HpI7TX1h6RmkhF0KhjifC3M8VdGwY99266CuUL3yplL4L178LhS//60dWH5QGkpyS5YHO8kJbVI+EFrP8dgRSdmuig4K8C3WAvXvey0gvSJGfEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f7825d-23ff-4ebb-6e6f-08d63297bcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 12:14:21.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add octal read flag for flash mt35xu512aba.
This flash, mt35xu512aba, is only complaint to SFDP JESD216B and does
not seem to support newer JESD216C standard that provides auto
detection of Octal mode capabilities and opcodes. Therefore, this
capability is manually added using new SPI_NOR_OCTAL_READ flag.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
 Incorporated review comments of Boris and Vignesh

 drivers/mtd/spi-nor/spi-nor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7c64ff0..574f3e6 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1413,7 +1413,8 @@ static const struct flash_info spi_nor_ids[] =3D {
 	/* Micron */
 	{
 		"mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
-			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES)
+			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
+			SPI_NOR_4B_OPCODES)
 	},
=20
 	/* PMC */
--=20
2.7.4

