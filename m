Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CE1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6844420989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aqjxlNam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6844420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeLFGgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:36:04 -0500
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:46592
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728294AbeLFGgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZVN/awjcaKE/2ulu4KEfbfi91zYmAAt2NxEcD8oH7I=;
 b=aqjxlNamRPfG6EmpwGfTeoDDkpQC2B0zvkdXodkkMJga9n9XOAv4MAfzhjzR2zbDFCONxNZ6VMwHDWCTX7++htJ77H4+Ws/XjI7lSwoddSkFgvuGhHPntQDPV75ax2FZTrIlo53Uwoj6ZMKVqf2yUS6VzApyDSxUtpN6GPDsCXs=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4910.eurprd04.prod.outlook.com (20.177.49.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 06:36:00 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::4800:ebc9:8bc5:f314]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::4800:ebc9:8bc5:f314%5]) with mapi id 15.20.1382.023; Thu, 6 Dec 2018
 06:36:00 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v1] dmaengine: imx-sdma: refine to load context only once
Thread-Topic: [PATCH v1] dmaengine: imx-sdma: refine to load context only once
Thread-Index: AQHUjS3z65ezEyQA4USXiDHUeJ9i7g==
Date:   Thu, 6 Dec 2018 06:36:00 +0000
Message-ID: <1544107081-7440-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4910;6:oaWcD4jR5EYnhlyqYI1J/sHueCIhLCBEZEE37VaI6zEZ/GjILZrRMaq7EhfTXx8V5TN65SPAiZccOsjLGR/xYrwddwOot8PnZvKRi127Ym1Gnro9t4eC4iwHj622WKaFt8Jv1xpnklTjbtZhWzt/xS4AT3v3r4lqhd/hxGYq7/p35jyvl39AZUXgrQaWDGL6gAaCGfCLm/2czt9VrifF1vBcoTUc2uOrcAHdLIHtla+fTk7ucmJpwyZO2yXTn3QH7k9iyUch9Xn8b5MxVKFPRXQV1SreWy5Yt7D2ByVdGENvEcbGLDHN8BShFTc7UQZ5HhFHxtagx8pEsP/riBFwkTr8klGLOGeQ/jkd1Uff4bGajHibxBLb6c51nn8S+NDIbRG4W1f7VKmYJpAagkY8JQbhxlT95bM6ObW1e4Xextz6auXrf9t2H9+Lpa3DMdARX0whCu7VsB6L3ow2L5ti8g==;5:b79lMa8VDWAnyorTA7OksBGGINKtHEWGZGc4cgvBmVk6fTNwrL/E5YPxsHIkak52S3KWWQ5KnRuHsWhdhWMTLnZVuIADbx13G9iPb+2v9IJlX5+79xj+79+QhjNnQ2e+YDD1dOC7DOwDbIoCuk87nipmXjVP3c79FV9EJyccAk8=;7:SzBSiIgnpikIyk5ZI5Sb4hv0dF4Kgy+HprgbRYMl916Mibk4Ct4QquXOA9S13mv9OJI3LuiN526br6UxOwdfqK6sGjRVBBs4V3j9C4gkPRWg2utcWTgFJFzE8ebglVPtpsfg3IzTfR+bgRQtmPDKDg==
x-ms-office365-filtering-correlation-id: 5b719ae5-ba98-4077-95fc-08d65b4515b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4910;
x-ms-traffictypediagnostic: VI1PR04MB4910:
x-microsoft-antispam-prvs: <VI1PR04MB49104647481CD6EF952C0AA289A90@VI1PR04MB4910.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4910;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4910;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(4326008)(110136005)(71190400001)(68736007)(71200400001)(97736004)(6486002)(316002)(476003)(2616005)(6436002)(486006)(54906003)(66066001)(6116002)(36756003)(50226002)(3846002)(2501003)(52116002)(478600001)(25786009)(99286004)(102836004)(26005)(14454004)(386003)(6506007)(53936002)(305945005)(106356001)(105586002)(7736002)(186003)(2906002)(256004)(14444005)(2201001)(81166006)(5660300001)(86362001)(8936002)(8676002)(6512007)(81156014)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4910;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4BiPUZ06ESAr5hand75FI2PY9D9MpksSAfL6Ve5PkY5jIPds8OJiSO//gTRBnkGoK4Xbj7BP+Ned409vbIWNzEnejN3f6qk4+UfCJzSK5dWR9iyyWZ+gMXjSSaENmJ3ANdDjj8T2S0aPZQaEzChFOzhyFlW4oKTYOLCl+CHa1lzK4dqjPqw++Ik/Qf2ZyEPC/zaEawDUO0a7bRjnTI1KnWRl0ogVfeFtkNuTAuNUR9ys46IatxZ7sS/MTiC5Yb0TLMYks5nwrkNYDSj7pWWJyJsuo7CEIo24LHmN5cq6WDTYvgxaix0RNvwkkll8ZRQyxRHP10T0htqXtAymUrIMCDSehToqCoNbgljgkm1tz9U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b719ae5-ba98-4077-95fc-08d65b4515b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 06:36:00.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4910
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

