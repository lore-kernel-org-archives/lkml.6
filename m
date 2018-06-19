Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4977C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632192075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ClfWVAn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632192075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965432AbeFSI6a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:58:30 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937517AbeFSI6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksDZpiZAEOS/YsgW4PW7Fl9WfdSCpCSXgoNgJvTr/3c=;
 b=ClfWVAn0CZRN39zoYA8i10vlaVoMWN9Nyx3/sATb/8t4H8HeIPCYR5MVBZD/m2CwCdHrsb/cpZ9Z9ojGv0D3SercpxGXV2i0aAR9CHSLt1F/Xm0xTzowdsHfn33WjTbuVfr3KpDmwpbvCQcBgj7TbQl4iblbIHT6i6BmahfDcqo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:58:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 6/7] dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
Date:   Wed, 20 Jun 2018 00:57:03 +0800
Message-Id: <1529427424-12321-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bb59274-2809-4d7e-377c-08d5d5c2cbc8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:Z5ciAUy0AOdyMsq7Xf0+nXKFgnYKuWzr73p4P08BvUsb5UQcoOqgVlCFM5c7ealn40bzzZ4hNmcmgUnee65MRV99qCi7PAstSJ1BZ8QkTLQsbWidi71XzH21kcZjNhS5JuUYSwaOVJRZkYdRN/1/iel445rDKoDPK8pWKUk8vKbVwbKNHvJ7QLr3/8vvD5EQ94XWfmekTpiw08QFWr/PEikl93lNAoi3W58+/zz1J+ioFfEU88fSaG6t0+TfBm7S;25:DTllh5f2ygHf9W+y6KbS2yqDI+MDpFB0m1eMyqzipZ3cNOKa21dDDZusOIlIV9MHsoA0x41OxvhZi6vBGujUWUsCneZIkotyBYIXPEMa1Ysawp9uvJk2rB2ytaSubp3B2eZ1Pqcu9H/Ht2Klo01jOCVXannU7IHcUIZDPaj/PSAPPTonjljjKijn+tz8o/kM4FzpTDjuvXqv/SkU5z2SPjGWxk+yydsLbgNAJOSUxjg5vZ4z4AdBZUIoTgcHjIS03s5ix3ie7V7aFWCye3/P9tRtHorP46xtkbazE5ZEXPVNGwCQPeVd+rcZyO+zvXkHGPjvTkNslrLRQKQciQGV7g==;31:AHaq8fsi0Ly8A1Vx65iLgXho8iO9lMwzGnqh3tz0DRNlpTG0StbtviD9pgPpxfHbcxxDejUiyaeEjJlgy5U8sTs4CKDOUTDrzPp8wduMKAZ5i+EAoH6eEvAKi6vwRXyr/aDTF3s+QmNahmuJ35km9bfPpcQ6Sm8kNX6nshSpw7uza+DY7jRepSeXUl0THUiT6SrQhB5r3ErplS3lvHvKSzPCBmTZC4/YVFhfWpeCpvg=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:9F5Of+WY/nKyWgCm7JukF9ACWB+P2u62+LFx7scanXzABCk4Z44hL8n+WRfWJzs3R9gv3vRbwZYSVgLqAMWCTAcd/qcdj0tdEODU0KTb75rncWcTSyRNYi/uGrJcbhzafqBwKyPC+hL9/r9SlR3yje8jjZx3+fgl7TeJ+JIe/YLoWjDa0mz1e9tGJNr7cmtVdv0ZLeQBiV9EwrJDTsNVqQlDSykLdbpSV0PEh1QyVt1EhXRm6vLg5IWdjh4an/wvWoOBstMZI5A6N56MH62f0jNbiZPA+ZLMf/l30H2p1GnLcfQinBXXDBXLUhaNWmFfLwGOs4reG7dgK586J+KNhMD4ZLHHfO1H1mc1rO9R65tRI1gC2ITG5XEael8BBgc/hLVboVjTimJ5KMR3B0fZhw20+WoWTk+YcWWnvh+5M6LEVq4B0Rr5Rs2fzdlolZy/tEklH8O+g9Ggp4lokBAOSMwBCWPsXtEbggJ05vuxLAHYFr8x7Iyxh+BlNe4Apb11;4:wOWe7gYhDBoQ4ZjUo9ea4daiUfMpq0mbChDnt+0YtfjEODb1TxI0EeOaYWrDVXTOW/pUPa0awA04/gDepHAQrQzy3t/q/ge5r4mShzTRlOEWWpXUFyafl6VOmeBzkRr2qkkXeFvWONP6EnGSfeyESfEULIQe2N+reCx5kGE1uWA4kGem/JgdZQmAqcHnQxQYCCY2L6sRqORpBeF2nW/rVp53oJyQVWIRVHmW6gtZV3AfFqA8EFj4mrE1YHpl96+lIgbBDnMrleD2wIxd+FM+RlcFjvCLXRmdQhNjtZ/Qql0SAn/mI32+cZkh0SUjqZkQ
X-Microsoft-Antispam-PRVS: <VI1PR04MB3231A776EBD1624D305BF95A89700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(76176011)(68736007)(47776003)(86362001)(66066001)(7416002)(6666003)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(11346002)(446003)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:2w0rJi+jLkAvoRG86REqML8ArV4rxE/xw7Myv67bm?=
 =?us-ascii?Q?vQ5YIDsMtlUs4lFvr/cZOityaRi/d9TJDUx3jgxR8EOFggoXgAxD0/AaHs78?=
 =?us-ascii?Q?e59kxsQjbnSg/xHG6PSvMYrAh5+if9AHUONMLPOD3I9LkeOcFdn/OcMvPkwz?=
 =?us-ascii?Q?Yv2deorCEI+DrSxGzixWhf1OUZ7kI/TfKsuYJCcHTz/uGJO1M5YozaY8wmR6?=
 =?us-ascii?Q?ACF3fxzNrtcZrc5uxNk2JH58GPI1iktfC6qRPJY+VOxPp8/A9zS2wrDDBZQd?=
 =?us-ascii?Q?TP2wg+hpWfb4MWD5q2rXZV1yn1kBEi7F2l8NQ64/CpDgVDDSEGje49AY8IiM?=
 =?us-ascii?Q?6z3fgn6ce3V1kHHykTtE+yEzIPsZ0aYBq6eoM370UIRqaf/TdACjLsvPZdH4?=
 =?us-ascii?Q?Lyt6aedL1iPenkZe+AbFjXGka0f3uAQYnrUD880xlDEKgM28t6F4U15aD/Me?=
 =?us-ascii?Q?ApDZIracZ4uOEtpsimFxkokKfeenMlMIH2G1MnsT1rf0YA66QArh6NUY/4Gf?=
 =?us-ascii?Q?rwJ4V9pQRn83+UD7X6SgYES3qWyJQvb+2/YMLYETXsVFbQOa/zr6liW+wqaP?=
 =?us-ascii?Q?0MnWDynRTD5lNCq3svPvVp8ZQ9al5Rb6jOd+23VVH/Dw88j7pYNSg/vyrhPu?=
 =?us-ascii?Q?fqW8xh5uFtoRdhBZsX/c5CfkALxepEEc3rvKIPTow+X301xj0zKqGglW8t3W?=
 =?us-ascii?Q?qjoZinA1NpAJQgVRbcK34Q+hlEaQqoJL7+6SAaBhtXSqzOc8Yr6BEwmK088B?=
 =?us-ascii?Q?SZR20wh9p52nCMDm4YlW7Iw3ilj8/BN8sl1jDNf0SY3NRfj0cE/CJ3Txwdw3?=
 =?us-ascii?Q?2UCGtU126hWvQRURsfV7EiYCfrHhuq3vFQ9G1jhamf87Ao5dx8PggxiJE/Aj?=
 =?us-ascii?Q?uDJDtYUSUM+Jh19F6t+RlZtHi7aYJz5P8RsnQ8F0JUg0A1kgfsuhfChfUTi2?=
 =?us-ascii?Q?VA+UpcOH8xys7dA7lt5HCzNtPJiuPEyNtiKwIXqcgyswZyPn0+jY0yzHHQab?=
 =?us-ascii?Q?6MZFswNyjL8XEQEe0/AIYG8yx5pWe41GQh0qKjGeq4ciPKiG8xpTO2vZaMTf?=
 =?us-ascii?Q?WrfTnMEreBkbiLI7CpFVDUIpYjIg3vze/lohJ7vX6Q3hiDjJ8kF/n5mDTEof?=
 =?us-ascii?Q?ePzzEJ03OkBfZagAiL5h5wOptSNjc45PLgiGh/QZcEE1kF+BwyUrauYT9VEo?=
 =?us-ascii?Q?+Luz5njbE27KK4=3D?=
X-Microsoft-Antispam-Message-Info: 8Bbhh2ResxjwIFfF21sToari/VwJLncHKAuHviQYf90igSzJR4mW21GBuuREXQXkNy+oxWDIIlSbWDrBvcIGCrGaEXxFqh6uygipagM3cCZj85yFI5w6WmJy2721EZc2SdVM4+1CxrxJ7BAwSeI26aT4E0UzO5Mlj7G+w4wpAwUxEwJiVDj6kZ1H5yYdUkXo2+hwyMMVAXBKVOnZoUq7qx+b0RwFbz/sT3Gsw984sxWZzfLB61bT5tum7KQcOMCXWjsxais3YS780reoK4nIqWsqmoK+Ha8Q93hSZtx1XlQwBdZebzG7kvIhfOZzfq2IVvgx+HR/X7ZgFA6yR6DQig==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:g7tcCAYbuGmYcWADV6E5f9WrSFemqpWpOE1vHlK+5yloNbayGGTFtUjznjZTa/BKloYM1ahqTV/w7wFCZfHFZ1H3721Z+AArJO5NjAK84KecSBe+vpFZnS9gUy+UACcJqDQITWVhCV3VBc/pNGfUngI0izNUoPDycdCSzGB5lfSZUPthP1HDisQ3y6tfM3NN0ZGF9B2u80Vdaf7tQDIGL3vLW/mB24qlyvhYSZfMS9qRkibwwWS1YUW/RLBeR+SEWcmjPK6zB+YAboXtY2C41N25DTSoh3jmmnlKXjuL+sKlVsmSB1nO8nB0OVLH69ThJlArMRVFb2pCj/ySIMTbO6l3yY5exl3kpZ0Dwv5fQnzFiRcyYVtL78ptHxjafhocaFM4m9xw3we/6QiB6PwJyFTDPitYO20XDmrRIpkXysQx6LDExk4oP9sRmy6i6s029490bzFhL2KnPgpEWz4FHw==;5:LXu6Itx61vMIh6smiaqk8BL7J5vyl9IxYecujEcu1TAxjm2bdXLeCeHfVD8uUZxQ1L98DEsMRmIsHEGYAUlIlRHPzb0bEJ2ga6BnPRCSq6LuBVP38y3LrfwZ31fIjQSDPUZZYhF/UPymAIsDjiyMbA+JxUR9UCamchNcwN7dVgw=;24:4FzPsMxvvoQgJzMSXKwZojte4scGJBswP4w23wam7OvDpinU6aP+RGBL63kzCgqv8og3JoEldIXrp9Kort9uciVOoCChgS/FYHFHsMIP0TU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:BWxukvT8pD5VekISPZR6anxRQbgo0HYnmGBNxRiwTbZ3VY2Ot0sHJOD4kOg1jUzVnQcwev5g7inCsGZfHEQt4U9n/W7WqFhPtss8fwmvu8zU/oPIpZ/FeQVou93P90y2/mJp54XMI5WDrnHqTee1Mhll3L2JAki5I27Fab58MkI0HM0hEg8OYgBhV2m77J2Gc+TJMbS75oopzx0bG2sr1XZeGo9B/sbWeUVCs0qDpVsbx+6Egt4EdQZk+3Ik7VcR
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:58:12.8477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb59274-2809-4d7e-377c-08d5d5c2cbc8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
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
index 9f1a462..f8becaf 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1248,6 +1248,40 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 	clk_disable(sdma->clk_ahb);
 }
 
+static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
+				enum dma_transfer_direction direction, u32 bds)
+{
+	struct sdma_desc *desc;
+
+	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
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
@@ -1260,36 +1294,13 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	struct scatterlist *sg;
 	struct sdma_desc *desc;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-	sdmac->status = DMA_IN_PROGRESS;
-
-	sdmac->flags = 0;
-
-	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
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
@@ -1365,38 +1376,18 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	struct sdma_engine *sdma = sdmac->sdma;
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
-	int ret, i = 0, buf = 0;
+	int i = 0, buf = 0;
 	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		return NULL;
-
-	sdmac->status = DMA_IN_PROGRESS;
-
-	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
+	desc = sdma_transfer_init(sdmac, direction, num_periods);
 	if (!desc)
 		goto err_out;
 
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
-		goto err_bd_out;
-	}
-
-	ret = sdma_load_context(sdmac);
-	if (ret)
-		goto err_bd_out;
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
-- 
2.7.4

