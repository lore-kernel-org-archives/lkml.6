Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0gbnKGQVGlu5bwAAmS7hNA
	; Fri, 08 Jun 2018 05:46:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 30888607E4; Fri,  8 Jun 2018 05:46:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XPNORWVN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E97E606FA;
	Fri,  8 Jun 2018 05:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E97E606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeFHFqV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 01:46:21 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:27840
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751535AbeFHFqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 01:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc9lataRQxLmccShCC/qu1V5I+nCiQle0lyKF2zSIoA=;
 b=XPNORWVNioThwb0OTSZrH/tC0JuTq082+sEoYcI/C1kJIj8lFmpFysF/zJam0Xg3N7WvPmuEKcqC5pehbeFb7Qa1TrEWIRqoIDYc7CuKAMSsFMcDGKMJL8NYDn+1RA8w8VWYCOaD5V6PkAMIWPS5zmj/U+hJd3Z7PBJNZEqUQFA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:6::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Fri, 8 Jun 2018 05:45:56 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v2 5/5] dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
Date: Fri,  8 Jun 2018 21:44:50 +0800
Message-Id: <1528465490-19684-6-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To VI1PR04MB3232.eurprd04.prod.outlook.com
 (2603:10a6:802:6::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3232;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;3:PUOFj0VeXqnb3dF9YDeZOGZ6XW/msLPREGuY/uEKhEALnt4gQjweUq09UgP0s/0gsBlQ+lDBK7ic8FQc8ltQqiNh6Nkx1kRJ0q5M8y6bUO0LoQORcFlk3LqC3XeFw5qTJu6c50YfpdwFOiVvGahJ5PDOS3o3dC2FCzi4skX2z6R4kmzudZda6X7Cxw/nmQnLkANRNZLTTuKpVJ2ZB0fzZSi+TmfbxKIhVZd5P7u49TCC9CmAlRRg8YHhpNwr4adR;25:vF0xaBKiLJcyDl6Xceux/tdQBjFSRO72bErQZGjFqxy+TJiWvrVsj6UzkjKShOiNoEnP9YUv+hM/zbJG6ZTAUuw2BbkTcXAtt1GLXTeA1siL3zt5keMSEvxfSxmLkdG2VN6z1qIhRw2VxrkYfqJf5Gk61b/e5ppqRKR6HeB8F7fFl7rI2fS+DqF834ZDVZeIaOorVQkA9M4ccPCnIEzCfSZzFuu6rJwE47U9pYTcWUuENDuSpqrKYyjE8fE2sIjS4Jr+jQUwyknGJb83pzVlFAfyR2NK/1bmJZ+wQqourVKBzbpueDJrajnHJR/eNjYiB5YBqDmwNGb4O4GJ8Ca/4Q==;31:kP1abmRAnL6S+hTMq6seBBTXttAf++7n2t4sloqRxgIBSkVKEYmzbfK4ZyLZLqrglr8uGKSzZEE1iouKbHkD9aRut/1jg6RWZY4Ul4Zkxa6Gax2mat2+NBsZTag9UXRFrF2XvXtS6jAomG1VPzeLMbQrt4t0L9gM3R6855GXyaDA2VYkwnwIATLn9mI0e86aMDTZiX+BVGZuRNH9r4IVze6vNQy0bceBjAARUlXRNfY=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;20:qt8ZvYK4mFPE7NKph/o5O3NHH6PjWF/RH3G4UHLpUD2OI2sXeKieEEdc2dWVEq0/SPbPjKCEp2UcTXmoEwf5q8/8JNRs/N5B4HMOmDEd8NKh3vDMnRyv3s2MyNgqb2AY992dGMjxFUfcniYnk/WCF5PK7hCR0vxrHOjBOtm/DQiv+1indfG23du3jeigY6GcMXdDuBrGK/rb+gUAd5eb93eL4uuPREOkrpkd4Tcsx+uW+17YkdLSTOHrVDVdGrq9taw57KPlGCTrXsMl16Oj2eWqIithbEuXSRco0NquzmPWa3X/F/Ruzoz3QwJQyYOQ16SEWOgkcJRTyIUQ02vLg65avxklvvjc+VbFgbQdBrLw5QQ/nkczkvgC2AGazQuuGdeu2zYnzhWt3l7g40cynEUgK14LhzVzlWxtcm1emkq/rcJgN8oqs5rav/wLnigCY3VdC1cdwkVJTGkCkDMOLmSXbuyVC9qqF5Cuv3yCgPdVKzkYv+7TbtQMwnSd2ZqX;4:qFgHvs2XtbEMf3S+FH+5CqXow4kpRTEJHmfylGpCKqTAmutvb6y/dpR4URvAikaHaQU8blIhnQ/nmzrWJT0YzLCLZUuwSAUWsWTpzBYod/gNQw3oH4aVGRmYqojWRkXoIcerNlggdvHr2iR9WyYrIPWMoDKgTWZnLY8rCpxQqNB62OmqBe8cAg34jaSI+p10ZHd6LucTe/ZBzGBSrEJJx7+lj/souX5iS2YLpxpstPtbiRsbRVz47//iiawEz7cDSSH867kZ9O/eSF+5dC0v0thpXspaPvsnEj0mI71uZ6rAS2UMDttL0gRU/lSB0G0m
X-Microsoft-Antispam-PRVS: <VI1PR04MB3232561C2428479127DE6FFF897B0@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3232;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3232;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(199004)(189003)(11346002)(6512007)(386003)(186003)(66066001)(48376002)(2906002)(3846002)(6116002)(68736007)(16586007)(52116002)(36756003)(97736004)(53936002)(76176011)(86362001)(25786009)(51416003)(26005)(316002)(4326008)(81156014)(2616005)(956004)(446003)(476003)(50226002)(486006)(81166006)(6506007)(106356001)(7736002)(8936002)(8676002)(5660300001)(478600001)(16526019)(6486002)(47776003)(105586002)(50466002)(305945005)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3232;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3232;23:WFqwlQ1usg+m9FGvDTwiYxIdJmgonvG+lBjslr/Aw?=
 =?us-ascii?Q?Dzf2J6+KqthsFuN6FmUB4h8dq4/RNfAJXOc28HqaJAbuZYISU98LTDJicnFy?=
 =?us-ascii?Q?zVwHMmbcbCQ7syufg+H5yjQb7/D6P0uJl0Y64UUO/MuZJVaueDHGKmCIr4Z6?=
 =?us-ascii?Q?sGa1lfm8KDtLuHv4WXK2hItUtjt9DKHWOtaU3GQJR9aksBVONJnQzCXKRKj2?=
 =?us-ascii?Q?6kZhJaU8hkKOI3+kLqCArhBYyIkABwQWR3DomS0baJ/Ikixx+hvOB65jCdUw?=
 =?us-ascii?Q?k+r49qJHSIkpujSzIljqBe/2whBH/uUds0H8kFEzjVqj96Tg7qMheBQjup+A?=
 =?us-ascii?Q?byvHAgVwRalWesWprLUDFXI/q7e2HQlB2eSA5LIHIODnoTvYGEKrPN7tNYbb?=
 =?us-ascii?Q?rdggp9vdkWOXh3DVG4CXwBzpm4P+QA9Ml1/JjN8j/IHicFmrAsy8mKtdSby7?=
 =?us-ascii?Q?fTcg6TXCTvI6n2ssvsddWKS95WYnpAE0sJGqTxjWUBu9So2u8dm+kaPAtWH4?=
 =?us-ascii?Q?Y5nqUzUZ5pudgJvcU/98xP+Vm3Ft6+XyXuwKDRt4vJeUK3W9WAuwFm4zjDLy?=
 =?us-ascii?Q?jKlSKwaviujldvfu37gibt/K0pUYwlszuh2L2PFzIRna+RH1ugndCUEliUjJ?=
 =?us-ascii?Q?uoslhDZw8GokjKMSgWmeuZnwe4dtoTk8NBwAugR6jFOStHUfmDTSQbyntV7t?=
 =?us-ascii?Q?9gtYA8bVfw7oW524NHvSmHe41ahc/or2ov+pIokzspJy8svGmKfHxTVII0P1?=
 =?us-ascii?Q?X5MpXl4y68yYKpJ7Kw7zl3ypV4yt/QZHW4Zdf78NKEAbdbONA79Uyj5pZwYR?=
 =?us-ascii?Q?Cxp26KgS1Bw02K1MWGkIc9gPQarcizbhM7iMO3+Nc9SvpA8XI4uYcyR6IA+/?=
 =?us-ascii?Q?rzoTF9sNZDFoOt5L2R0waMURr3LGir0Vb4e8B9xArq8vaKMgA3i1HIyb1bY/?=
 =?us-ascii?Q?IWiUF2Sg+ewW2zybxm0Ys1yNqcBnolP3p23wXI9+6v4wKmYan1cwO8wqiE3C?=
 =?us-ascii?Q?tDwUjHxliNpKwnaJn0KTz8oeK96THpfcwn8ZD6oW6qFhIRvbcjZ6+biY+xfN?=
 =?us-ascii?Q?ODoO1YfUf98P77qPReM2HK+vr5vYuaBtkKJUVbdq0SYkMP6eng7xO0MdIhoA?=
 =?us-ascii?Q?UhoBPUbn9JahUwgWgdqsHjAJ12bqfpzG2CxGqcXCGKAW5gZi65EsA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ucK+fG5RwWVPS9O/CySiK4YSnmlpfyue6NaxSVFYSicETSiQRf+GMlkHXnlmlaUAw/FSB47Qd2EnQhDGxlJx82eFE/cWV/yegUdKeVmUbKcrinRQ3y4FxLehJ5U1Dd0aQedBHzKqspVd4Jj1XIzwY5mTDtToHEw+xW3ioZUVvP2s686fh5QATYynwHl6a26F
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;6:k+Wvdso2GbRrkHPCxR9/k/mNluY4MSJPyDGCsyStgAvfbs78pcl8eZ1VMJBBpI5xRqjkVMbWUkbGC2pTEUjLjekyvR7PM7SCfAAL4ipqCYrCjFpiKXZujKDZ2m6Dd+Ag4VujLfwcCuLXHTWWCx+WKXqWMzZKJywkyPiW65r1u7wIPyo5pSxLUmVnrnRUTwo60N8UYHvmqo3Zy22mYkXwwXA7RW0tbPewu8UqX05bLymdUr/vSCqpb4rnn7XumoP0Rglg6sdzrNyppoxBSFvfbsifxRwZyIPLRrdhdGX/2RPIrmAyHvn/dMxz4MdH29TCSapTYNYZSZSatcz1izdGhYT/ayr2d7aXFRCUX6wjLhZFQpF/gdZHv6LnB9FqQlu0lpgecsYptWoguLk9BBWS2RyMUoVgQF0JZlzWxbw52B2XNiDM/Z9UyoXuxdeCIwiMOTl4hTKMnBGjpAuj5qDrgw==;5:X5tYVCLaakbzAhhXJUuSPkUYZndiMoQyBRMUn2g8BiV+lBHmssso7eyYB7XGuq/grngSs8cufPt18wEA9KGKDmSgS4xHwQ5A/sQroHGoVzl0bIrWZccQwEbjtplEq+ycLD0SecuE8TD22Zca8ms98mwfqPq0RCt50Wce+RGBIYw=;24:XHD0dZVKKPUGmAMDYVDH7TgSQInDEFjKoNfuhi8xYP6TJWr6qsFUWFYwy7DKppFCuQbjDuQfJd5ywRZQ6rSIs8+qnr7FVHH2NxCGNKIb8yU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3232;7:IVTeyUK5SA8UEpYlTws5fHD+rHcsavK1qos15E09J4rUKSTTXTcXRqMXm2Oz+PXFdEwwsbUALnUg0MaDHiWaYZFCafHkFSdnlRD8cFCR99OkUvMFka0aWcgipnO3Vtj9IDaQKylNvvN03ZpNbExRb1Rt1mveFtDQpNCMFElatA5Z+5QnTd1aUrp8uMHnor0XomedgUCpF2ErpJApBtzFZ3r6V2fP4F1qnd3S22CLBbCOEyn04UAPJV1etmnwr2pp
X-MS-Office365-Filtering-Correlation-Id: f2cc1715-63be-4f64-1f12-08d5cd031c72
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 05:45:56.5505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cc1715-63be-4f64-1f12-08d5cd031c72
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are lot of codes overlap between prep_sg and prep_cyclic function.
Add sdma_transfer_init() function to elimated the code overlap.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/imx-sdma.c | 83 ++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index afaee72..25de89e 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1255,6 +1255,40 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	clk_disable(sdma->clk_ahb);
 }
 
+static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
+				enum dma_transfer_direction direction, u32 bds)
+{
+	struct sdma_desc *desc;
+
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
+	sdmac->status = DMA_IN_PROGRESS;
+	sdmac->direction = direction;
+	sdmac->flags = 0;
+
+	desc->chn_count = 0;
+	desc->chn_real_count = 0;
+	desc->buf_tail = 0;
+	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = bds;
+
+	if (sdma_alloc_bd(desc))
+		goto err_desc_out;
+
+	if (sdma_load_context(sdmac))
+		goto err_desc_out;
+
+	return desc;
+
+err_desc_out:
+	kfree(desc);
+err_out:
+	return NULL;
+}
+
 static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
@@ -1267,36 +1301,13 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	struct scatterlist *sg;
 	struct sdma_desc *desc;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-	sdmac->status = DMA_IN_PROGRESS;
-
-	sdmac->flags = 0;
-
-	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	desc = sdma_transfer_init(sdmac, direction, sg_len);
 	if (!desc)
 		goto err_out;
 
-	desc->buf_tail = 0;
-	desc->buf_ptail = 0;
-	desc->sdmac = sdmac;
-	desc->num_bd = sg_len;
-	desc->chn_real_count = 0;
-
-	if (sdma_alloc_bd(desc)) {
-		kfree(desc);
-		goto err_out;
-	}
-
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
 
-	sdmac->direction = direction;
-	ret = sdma_load_context(sdmac);
-	if (ret)
-		goto err_bd_out;
-
-	desc->chn_count = 0;
 	for_each_sg(sgl, sg, sg_len, i) {
 		struct sdma_buffer_descriptor *bd = &desc->bd[i];
 		int param;
@@ -1372,38 +1383,18 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	struct sdma_engine *sdma = sdmac->sdma;
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
-	int ret, i = 0, buf = 0;
+	int i = 0, buf = 0;
 	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
 
-	sdmac->status = DMA_IN_PROGRESS;
-
-	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	desc = sdma_transfer_init(sdmac, direction, num_periods);
 	if (!desc)
 		goto err_out;
-
-	desc->buf_tail = 0;
-	desc->buf_ptail = 0;
-	desc->sdmac = sdmac;
-	desc->num_bd = num_periods;
-	desc->chn_real_count = 0;
 	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
-	sdmac->direction = direction;
-
-	if (sdma_alloc_bd(desc)) {
-		kfree(desc);
-		goto err_out;
-	}
-
-	ret = sdma_load_context(sdmac);
-	if (ret)
-		goto err_bd_out;
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-- 
2.7.4
