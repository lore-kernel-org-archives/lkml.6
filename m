Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D708C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB262087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jPtJ5os3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAHMAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:00:20 -0500
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:15520
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727932AbfAHMAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZVN/awjcaKE/2ulu4KEfbfi91zYmAAt2NxEcD8oH7I=;
 b=jPtJ5os3hk8o2K1cnGzFSDATQlOTUdn7gtSZfaXVkrzB+gWYUa8/0OQVF9RrGdsNE8653PhDaFLMyC8mxOG0pY/esn+x3JJiEzS1BsTbQWH7ap4w3p3JFtQg0GA4ppPmMieMw1M0yRadMqDLvmzPCx/W/Usyl00qh9dMgu+Ijw0=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6125.eurprd04.prod.outlook.com (20.179.26.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 12:00:16 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::6d0a:7236:6fac:6fd6]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::6d0a:7236:6fac:6fd6%3]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 12:00:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v2] dmaengine: imx-sdma: refine to load context only once
Thread-Topic: [PATCH v2] dmaengine: imx-sdma: refine to load context only once
Thread-Index: AQHUp0m46lBvnAQrVES/5clQPkHmbg==
Date:   Tue, 8 Jan 2019 12:00:16 +0000
Message-ID: <1546977740-10846-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0038.apcprd03.prod.outlook.com
 (2603:1096:203:2f::26) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6125;6:HLSnuQffUvB1Lr0EY+iab1RrOo6sN6Cn5JWIAYb/hDP0Q1uvbiQg1qTDT0iCNSS8eTsKiRtG+zGu5AtSFiuECBdtkVCsWTIaPiQtwQSM9BFAJaJoirMHnkvTskXYVtxLAt9xslVNO+sYn4G8n0qEBQFfFLGG9w08BI0crC32w9pF5rSBM1SrMUDMd29L7z+jz5RvJYm3nR5+1Ux7ol07im85hcAAZNW3IgHoG1jj/qjy+lBfNfT5DxGLWCb0I39m9wL6o/NJrnWCHgWNMHm1kEjcZpFYhBDP9zsyR/K7lDrxptXkrANlUdWdZXrWRt/hxIQdnpLAy+Y8ynr+worQ+b0gskeWR6y6Jm6LbtQho0Y1X9SIM7pSsa1S4ibz4qoqde2Dn5dotOAfLE+nvUcFlptvdw8Efhu+LEUq+QZjoJ9SzwLi6hx1aXotbb/S6PgGZygLBLmQidk+STcr81aPbw==;5:IKZpQqOjx8bpv0xS96JQkdBpjThTbIVNpBjLw7y1sENith1GDt/cQDK2rAetSBaSsyThTSPNcc8zQBkqU2Ss3zWbYxiCHrjtR0PzijYooM/5THmNLJJUzEvMRPj3W0W6Ep7fCyeVAqIOPHj8uuqjsDRSG+N1TFG1uIuowTebv7OMPCXhQ2UtCFP1x7E4oL+G6rerZ/Pe0Rv7vvRf1PxEng==;7:yPpSVVV2QQ2VrLucyJTbBe/Ib7rHESsrQ+sfocUaWx661BOA9AbHwAaBgVpL+RRQ0JMgsTpfHObyiDbA5OgJ0t8s+5/WAnPDNk4rL0l+GBCpbGELlal+qBv5RyIsx1WBfElV1F8WWgF4SLGYNTvGZg==
x-ms-office365-filtering-correlation-id: 37d3ec58-6ac2-4362-5c98-08d67560da85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6125;
x-ms-traffictypediagnostic: VI1PR04MB6125:
x-microsoft-antispam-prvs: <VI1PR04MB6125DE8AE082E15AB5BCA888898A0@VI1PR04MB6125.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB6125;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB6125;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(2906002)(53936002)(7736002)(6916009)(6512007)(86362001)(256004)(54906003)(5660300001)(81156014)(14444005)(6486002)(25786009)(4326008)(486006)(3846002)(6116002)(97736004)(71190400001)(71200400001)(575784001)(2616005)(476003)(8676002)(2351001)(36756003)(186003)(26005)(1730700003)(305945005)(50226002)(106356001)(102836004)(105586002)(68736007)(478600001)(14454004)(99286004)(5640700003)(8936002)(316002)(6436002)(2501003)(81166006)(6506007)(66066001)(386003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6125;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YgZM7uLy2VMedKcr3UZVMEi/rx7Yq9AJx6QKIBmu+RjKzaLiW0Na5qM92BfllMYEx3S56ugvEO9JqvKwlc2lVpgKp4VO+A8QEyxAWz/2gJfsuStsRNTb/VYrURHq734wkMeqp5tMzWJG9hL1HxxOrIRr17D6/Ua32R32gkpjRZ/615ZEorCt8Lx5OdyHNpxog5BZ2U6zMA+ZpUeN9NWhHe5b7tvRSHolYs/NO+c7sxIp6L9/wuAx2+8M9QV8BQAcThMo+m89oX0QTH4vILzl8oJWfwT/zCOTEJdiG7iheFBYcfXtQsnPJGvyb7tUw91L
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3ec58-6ac2-4362-5c98-08d67560da85
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 12:00:14.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context loaded only one time before channel running,but
currently sdma_config_channel() and dma_prep_* duplicated with
sdma_load_context(), so refine it to load context only one time
before channel running and reload after the channel terminated.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a2b0a0e..015c17a 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -377,6 +377,7 @@ struct sdma_channel {
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
 	enum dma_status			status;
+	bool				context_loaded;
 	struct imx_dma_data		data;
 	struct work_struct		terminate_worker;
 };
@@ -970,6 +971,9 @@ static int sdma_load_context(struct sdma_channel *sdmac=
)
 	int ret;
 	unsigned long flags;
=20
+	if (sdmac->context_loaded)
+		return 0;
+
 	if (sdmac->direction =3D=3D DMA_DEV_TO_MEM)
 		load_address =3D sdmac->pc_from_device;
 	else if (sdmac->direction =3D=3D DMA_DEV_TO_DEV)
@@ -1012,6 +1016,8 @@ static int sdma_load_context(struct sdma_channel *sdm=
ac)
=20
 	spin_unlock_irqrestore(&sdma->channel_0_lock, flags);
=20
+	sdmac->context_loaded =3D true;
+
 	return ret;
 }
=20
@@ -1051,6 +1057,7 @@ static void sdma_channel_terminate_work(struct work_s=
truct *work)
 	sdmac->desc =3D NULL;
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 	vchan_dma_desc_free_list(&sdmac->vc, &head);
+	sdmac->context_loaded =3D false;
 }
=20
 static int sdma_disable_channel_async(struct dma_chan *chan)
--=20
2.7.4

