Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8E8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4E02084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eA4BBthv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4E02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbeKFNES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:04:18 -0500
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:37270
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387450AbeKFNES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9rTtDYbiL7B8vl8dIg1hMsywgfV6CT5SUFuHUvESOc=;
 b=eA4BBthvT+UBsx/SDKUo0eAnH5YMTwpuQKysR/NanuBlrpNpaYM6fyRl67BSd1OhAcGW7X2hw4L2Fsw9IMFcOAkB+JkM533JM2qsjsf8JEjKz2cScbg09TaLJEtXQSRvWPBjnzm7yhMdvUUpieRTN737jwh2Dswqpj5HdoiJHSs=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5226.eurprd04.prod.outlook.com (20.176.236.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 03:40:37 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267%3]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 03:40:37 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 4/4] dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor
 allocations
Thread-Topic: [PATCH v3 4/4] dmaengine: imx-sdma: use GFP_NOWAIT for dma
 descriptor allocations
Thread-Index: AQHUdYJ7NPRe1R2FAUCQpmyE6px9sw==
Date:   Tue, 6 Nov 2018 03:40:37 +0000
Message-ID: <1541504525-25720-5-git-send-email-yibin.gong@nxp.com>
References: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:36::16) To DB7PR04MB4538.eurprd04.prod.outlook.com
 (2603:10a6:5:35::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5226;6:/5YnU1lUWk1P85ykz/nviQ04XfhwFbBEra8DPRRjAZHE8FqFjJA3TwsNHomeMQi2RzrIg0YkqKXfQNCZurYZtkGMT5aUN+zA2HuhDTCBo2npC4WINkVRuCJwDBMjzFBR9QWaKtG5jX+JX62jwzpln1TOCrNcNe8prRMyf5zPHPIQSSeyYhpgxMqp2BHi3/bbV7ZME9rBRcUXEvHp6ZcutYiJwUMXLZBC8RUVsXRTQW94ueYPE2ox1XtB/VoOVgaJp8zAPIVGTBCEpEPbEVd2bHUUw9u66h2poPJd5n5LbZf6oJjI9wdAqWrfuyoIQxkQSnrDr/Lpcsy1qAdyIA/vwBH6QTfMtIOFrpn1Eaq/zyPPZn5ESxRODQsIaC1r7kIIopw6HO/n4upHtAj0q14sm+N9QD3FKGqE94ntRj4tay0Boyw+PT4W341FrURfC/Rf4bCEEHD9CGaX/Iy/MaWQ5Q==;5:wLDq9E9YvFfK/mPj/qy72q/w0I2R20+iMRtsKc1EdWNrYWo5NHI64SQowBKfSMeM3o5bJKdyLstLquaPaxusDEE3acPN0w1SOCCeJK3dLce2/t0R1ys12MRngcZj6S5S0emH0G9XE11oTWRzEeI1TcEMn1xot8RoaYy7uC8ahpw=;7:oshJKcqhsX7tjSvzodD4W551D7EPzziIdiotHl2XGD6/zFfanYVCnDFv2IJHAm1EO97a1xvQFn1inqFUp5Zl04t9euw0brDPgcFzpMO6w0CAg5W2xKtCi8CM0W2MBXUOOyU0IA60weRsbjc8VC5TyA==
x-ms-office365-filtering-correlation-id: a025e653-68c8-4bec-f4fe-08d643999d92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5226;
x-ms-traffictypediagnostic: DB7PR04MB5226:
x-microsoft-antispam-prvs: <DB7PR04MB52262E82D95A7F50704073AD89CB0@DB7PR04MB5226.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5226;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5226;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(81166006)(54906003)(316002)(186003)(446003)(25786009)(478600001)(2501003)(71200400001)(6116002)(3846002)(2906002)(71190400001)(110136005)(99286004)(7736002)(11346002)(305945005)(6486002)(4326008)(476003)(86362001)(50226002)(6506007)(14444005)(486006)(6512007)(106356001)(36756003)(386003)(5660300001)(26005)(105586002)(256004)(2616005)(66066001)(102836004)(8936002)(68736007)(76176011)(53936002)(52116002)(6436002)(14454004)(8676002)(97736004)(81156014)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5226;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jlUL/6X95PDp8fzB35DF/KAZchkMa7JLkeqgSDCSRc0dLuTasjL5WQwE+GXWGIAcMGjBMV8+7pP51cRuTA2rGkcn5of7lzm/S+HzK2TaLnI8R+Np9awnbWmpDRt4fK8pTXNkHxazOqKD7xcCBYllf0cq8F4IJgFAFF5n4nB0570lussEPWm3m4N0OOCXb4Zbma+E2aBfWe2p1j8jG0n6AsIEcU8lb+Ab/mUQ/+jv7kfjsvSIKyG1MbTPI7/D5woOwwz2EuUylYzq75Ak/QZvqf8fv/dQY+bAj1Xjq4ZtwRbM1Iri6fhyIVbLIEnA9oTRwppF3lpFvZdXtgOh1nQz2E6jHMpL6hzuVzTD4yQwsso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a025e653-68c8-4bec-f4fe-08d643999d92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 03:40:37.6698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

DMA buffer descriptors aren't allocated from atomic context, so they
can use the less heavyweigth GFP_NOWAIT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 03d46f1..cb1b44d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1214,7 +1214,7 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 	int ret =3D 0;
=20
 	desc->bd =3D dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
-					GFP_ATOMIC);
+					GFP_NOWAIT);
 	if (!desc->bd) {
 		ret =3D -ENOMEM;
 		goto out;
--=20
2.7.4

