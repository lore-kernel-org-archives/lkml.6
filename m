Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bGf2DBoeHlvANwAAmS7hNA
	; Mon, 11 Jun 2018 07:00:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 81111608B8; Mon, 11 Jun 2018 07:00:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tyVzfNFh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D9F1360792;
	Mon, 11 Jun 2018 07:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9F1360792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeFKHAv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:00:51 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:55025
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932092AbeFKHAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrWoTnZdIZwVOpWY84aMVebeS8lyXNGJGQsgJuzOsiA=;
 b=tyVzfNFhNCh3jbIM7UoSCKiI01enBhsIWDMC9/AmZBheJpZ2tdHU8sBkgLvsf/Ka29nl0sMMWJIJi1II5eNx+BMHkkIA+EpGdZhsd/smSJbtgxdZOkbbFLfbd/yy5w4reWidjOUfcCtAemmISPpfm2qTqPxbUqnWll/gyMi8fDE=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:31 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 6/6] dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
Date: Mon, 11 Jun 2018 22:59:33 +0800
Message-Id: <1528729173-28684-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To AM5PR04MB3217.eurprd04.prod.outlook.com
 (2603:10a6:206:7::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3217;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:R6VSVqxNq0H4Y3ZNdtEZhrdabPI7rNq4GQBkgdVTx/HX4ZtL3gng6jdGrH1QxfVYmTKqg4ZeEGh3tK5xy8VUx6A5WKT8V3QQMSh7Fo2XBmGtQ6ZuJBdHWGtiOKTq+5wQwzoZDLGotVQqJiBaTuvTL+AnNEBvFpwIl6FNKqVx7v/BHD7H7V6Tizu+oMAO/3kFvwmCDGlp9v7W6u6R3GM5PUqQHTD+WJTMSreDOdyF2hOyzICoFEoJzlKVOFWwvkmJ;25:FaUAgDJD+L7zrAWFvR8aS8vQaJORNdwcU2phTBBr+gA1zyQStSSJPT/W7ZCgn+1nEg1uhtlZ2C9dOqJXB4yHQ4T9frvy6xu4+71SjNes6jbDX8ASDGSGofcKWe++Nl3Xoo+Z//MeJosexiOAAL1kxQD+tYMzdH9ToFmWFPkeylxXindJPyfZ0pp5JRcdH39Vnj0wrcqGB8RwqCCaG8t9AjxBLDKZZTCUJ5jVyWLDDp7RFfCy8NDLZuPmq7g3jcUmT4saoRV4hSVeT71qimmNr75890LwtzRGvfZeDQB2Jz9ckC4BXTjW9Ktx1EdY1QoYoTVfIvwjhCLHuVv2n9pCeQ==;31:7zD77cU+UH6SvH3+7eW9FV4k3FhJ6Ne62TH+ZPhkyxdmyybJbpKNuxh8/HNUVJL4MyJymuPdcdftlqj5Li3f+3fOnHyFBZaSMKqVy69h97urW9irhjqTJwMvghOPWnswXy0vvhlTl/svtlvl1eflxfkk8M7/su7I/47knTpsKdVNnbG9R5NBuX2dO6kblwAxI3xQi4dmWXy06ZjN0y+6LMzFh+ZNJ5awOqP23uTJCAk=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:II7XUR1lZ0ehdT5HvSx+RlfbgbE4IlORyVLuHbVV11fteSFbu6fiGyx1fVNpUn7tL71CSTZhd5rBDpC/KhdxCTFKDuadNyy708cw1i7rSKkQy97MSU3Lthk27DWxrR0DLh0EvkGizwJarMOhhiju6aMRWxArBv00Ua8M1Xcw6xam8QMOt1VyM1y5twgAExxgk1OdlNOasUtW4yTiRu+KE6VqlhCxo8z7eId0MNFhQFTsrr/P/CfX9MRSyVxCFVDlMrjHkEryjA7SWU790/5JvdZwn+u+/9AWRUzXxazHFVxexRQECG6sINJkGwSLunzra0lWTrZjqXmhlsnJEq5O8yfwcZAvXtyJmPSihhf+4PHOrDyHU8pNTOLNFA2zCdtdeH10KILYQidiCMEMgJGWZvYBG2GBeHoK7Q3/dbnuDVdJsvU1LDMFbwZaRlSuzBDqiQXyYnG0aDkX+V3wYoPNGffh7DLO9YNQjRLjVpeQboUq7NPkNkQlclcU6FM+tvR5;4:u3hW9mSauAPRwlgsuNlcwgyN8gKvtkthXPJDu8edvIF5Wr87f063rvblHA+k7b6dSQhwSXXBRlCms5swhJ6r9+4j762sBtC77QsdFXDpLRpluTATKqqf0cAi9t2GLOs0sN4u12Yp2Osi+mTG1uyEQv7p4GKEnjwkGUA15vD9NpLOtlQZCNC9ncEPWohYAD2Fsiy7DztoXCskELLVF/aA/8+vmDBKwY2BXVQsBuxxiZGc3z/lzBc3HntXJXgsvWgcsfyJhbAMWmEYQPVCI9vWmPc5+wfPI+YRPeQG+D0Te35P58Zr7xCquAZt/GYC8CWD
X-Microsoft-Antispam-PRVS: <AM5PR04MB32170850B53C540366E40A6E89780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(76176011)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(3846002)(47776003)(53936002)(50226002)(186003)(446003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:R4aoMDK1E9ZIrVzM07VW/O2H2zkJVA5h4NYrqwlUs?=
 =?us-ascii?Q?9HpDZyinrx1KUcGtuGWzRGMohIBBmbyafVceLMCjfTu/aeoADCeyXn++OE4N?=
 =?us-ascii?Q?4By+za2EvXNflFfLLw4NDsazTFT4bUltcEX/SseL3rl64eZF4TKMM04fdZTg?=
 =?us-ascii?Q?7rmbR+hX9Gcg4sGlZfhNZjFLfF9sQNwfydZVbm+20lkBL0YhLitGEGe0P4Uv?=
 =?us-ascii?Q?ghfT8X1fSSrmXJGtu652vQCA3MFjX2jxfojeYGI/Hkwz2pTfKSuxKKOKhHCE?=
 =?us-ascii?Q?/KbtpmTZl785b7Ojj5/L0CKojZgTQxjFDx5Id6topl4pDZWJ6QrmvJ1sJSE+?=
 =?us-ascii?Q?cIgZWTLaviZ8wCpCJeFiMrR2VwIZrVuHdBBYIqriIlQomspD3/c/wvmolTWn?=
 =?us-ascii?Q?3xr9g+6OjtpFXnsOAxBcbN1PqAgvYuPdKUNCCGfME42uhXwdTj63wlgGDxC6?=
 =?us-ascii?Q?Yin6nU7DnwgpSJkjJmwQX/jTF19KHBcgofU8aUfTbs9o3wo6AQHaEmvuv4cV?=
 =?us-ascii?Q?iD/wH2gYOSOjuOBdm8wwg3is/tOzD05/1A6h71aY3X9ezOwEPaUMFdZxrfjZ?=
 =?us-ascii?Q?Oqli2WyEies7nge9jmWCuMssCTiG144wvZxdGNcyZM7PomNyQ4+Zk1kBk3jF?=
 =?us-ascii?Q?FMJDfEaZoQ3Zicea8cFz5jbX9SgWIy8PEALtU8YlRlDZcJDAAqHaBeHgfDHv?=
 =?us-ascii?Q?Gh1rfiRsnOa39o6dpkYdbT0xtiG85s/dIZhbQ4TQq2SbNng/u7wQyqiJxI74?=
 =?us-ascii?Q?9l76XhkcYa3K3HzhabWeI2pOyb+OhsH69blLpjzGaz/vQNftD6ODx08seBmy?=
 =?us-ascii?Q?hrChXgV2UKPmftgCiDWRdsUsNOnZGh7VFo0yljWVZYKJJpHS0f4f+5ZVvgcW?=
 =?us-ascii?Q?bgSAQLwGpMHNI4Fm5AM+KCBaja7KHvaheyR9fDeRVOnG7m0qAEAupIJRfkp4?=
 =?us-ascii?Q?kFJ+nDTFuek/0tlW0nqmVFhV7SyWQ00F61293mawnt85Q2DL4kS39vGHokCT?=
 =?us-ascii?Q?NgWBMNVZOUuBHd7lxKPY+aKBoyQyLsk1cB/a0gS9dGcZrs7hO0NdtxGNDDFg?=
 =?us-ascii?Q?udtVF+36d3p4ODL3UbT3h1NNv+A358sY3+oG0Hb905BFkg5heIQ4olYo0Zl9?=
 =?us-ascii?Q?9aVnxp4Ejur/GTY7UX4l0ohcAJhQuDl?=
X-Microsoft-Antispam-Message-Info: ojk+QG5z6ZdbUtK2lHk2W2hG1KKX1Dg8lpPOdVMBO0rTY0naNEFpSmjfB+gl+Ch1b0f79H3ZWC1yvIsd5RcbaJ8P9PjqeP7edjut7iFobenllcuDu1HtiXbChn6MC9pgdo+KUXPmgMuR8Apa+kG6TWjb8bVePAbOMrF5VaPd7N9zVbjhgN8yClGco85GFyMM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:FXMyQJoETVrDfFBJ8e2nlFsxmiFE7uX8J3AyzO03rkdufC6nTKL2aRTTqKue0KZqtmhxTAx7FC962mybfE7k1E6gMv4rZOymc8vSqf4NzxizgKIeQZ/ANICIuLc7NriwLTjxa8LuyVkCZyPNRGAu4ng1y2d5k2W/6kNtikFCaOda2uX1WqToHe8ykkZ5IbUZ5jpegtN0N3WPv9l1G7Ot3KJ10mRdIjmbrQ7opFWJLpnkuJsQMJPJSXXI2PDtTS05kjIKKO7QDFP+QxOmqlMFnysJvO2kxIX1uIFkZ/ufHu8iJchCzKBLVxXl4EWdykgvCbvMmcn3KGParX5TCcrXyj2aHPKpp1hMD9vjcYWmWZ3hmdZ2t4kKP6hnVDS/XmpBaOuEaL+3o0AfhcniWk/mfPIc+wg1/nNJm/JbOYSyz1Yh3YSjSdLxxi0V0raP5vcCyQg3wsxvy8yI9Adhgy+3yg==;5:fBl3Zw51s0l+m4zQQ4SSX8cHyucgW+3GktRZlBXdN0wRcUoh7JKqFztLvGOc9Q8tfxQhFMxV6rrFyZhG5sc+LThrLGE0V8eaTTqYFq/8A031SnaJAlrqVwHiwyxtGfJ8Nw0iZllzK+fj6I0ouWT+Z5lWHLicW9uD4KCmf5eoVs4=;24:i0i2kQWqGRcQHmzEO+28Z9a/g2oyJ5FGuoALo5y0Fn+BIpJD4Bq1r5Hshd0qagY+1+yYyN2gD+v7K18g1oMdl62QrX0A7FZniDT5uJZS2nE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:3SoR5EbN7i1+DskNEGcxtQq94fPQjaULD1i1c7c84BzY548Iqi7irZcpIMQEMA168CPr54ugycI02wTuCWdUVt85wBW/CPkvDmy0wo0jKLzX/0mVpGdujNZ2TBW+i9H4D8UBTLl/uUGY0VkCP0E7HYL37UnAZESzkrI2/LVkl1H4jHIfiE2aT06uFW48bjrGfe1KeUDyNHajMcHTV8nFNRmsEWY3EZX1GTtngdKbko62PPJ63+L9BF3GNdvUIbOn
X-MS-Office365-Filtering-Correlation-Id: 9f2f6b98-aa46-4db5-fe18-08d5cf6906c1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:31.0779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2f6b98-aa46-4db5-fe18-08d5cf6906c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
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
index 0b0588d2..486ebfe 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1254,6 +1254,40 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
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
@@ -1266,36 +1300,13 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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
@@ -1371,38 +1382,18 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
-	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
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
