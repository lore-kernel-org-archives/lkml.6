Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8BD5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A801208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FSCTioLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A801208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeFNGFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:05:10 -0400
Received: from mail-ve1eur01on0084.outbound.protection.outlook.com ([104.47.1.84]:51328
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754629AbeFNGEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGaw3XOBxk5cW2PAnV2R51VUhiuMBXL3OI+oxBseZ2k=;
 b=FSCTioLPBDbvW57KO8zf/bKO0qne8CHVdA5Id+GFv0qAa4sA38hwNhZ2SP15Uy/o0cVoze9UE9UjokigPK2ITqlBHxHmmB5ps21UuZTkrZ/35yOU8GesfwovpH3L/C8EjJ1WYe6yr7sQ8k1hdVkjTmmhbcjZopWAc1YWf98oe3E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:28 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 6/7] dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
Date:   Thu, 14 Jun 2018 22:03:01 +0800
Message-Id: <1528984982-5074-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
References: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61f26088-02df-4743-b3bb-08d5d1bcb23a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:k8nm1ZPAGWox8+VUIjU1XuNM4/pQUIUqxQMzDwjN/p7vyNACoHcpYujrBHSsmyqDvJ45NrMU+Pwe9VeOGLavIzr+N3OroduH1i1fwU8db1+uLdVATyX0Un4IxqxwBS7jQaTs58vKsXsDJ5bA2lyMHK/ZH70VT0Sybf77XL0Be4Y/gjkEpO7Q03apu22lV0pnYuTTDwtdBSCUh2vb5V6IrOuFqxRhB8wkg1YlS2aJvrsnglI4vqyrap1XDx0Pzioo;25:fmWPmm5ObtvSd+ZQ/6oLSeADW6aBNcd0fbRkOCPCEdEla1t6KDAG3T0NmIq1b89Xemtr468RZyGFY5Yw8f0F6n2rx5StIkNA5sGMUurU/eK2cOc9NPCKNuU8C5HA9S85M4K9f9RPSwPYqGvy49Hz267/DciyAEgM0JDgho30LuhTB46taZhFlv62Lkbv2B5ZiQQPdz4JKHCnvnfdUobFkS1tzB8FTpJTJ8tWxssTEcNaeem6eSFQDovWAqTGmuzHWQt4Sfh90NDUD5XVyXCgAWeCHKevmnqSyCKMqU38lG8KxINOtXMztrFkbE8+uFXK2vvloR6c07Sm+dYxG1wveQ==;31:I+qBLQeoFjpHtoryc8Urc/AECNBIHBdLmNtwS4xcxqwQSn0bps/pnxAcD0Z1l7WAFVKc2FeHYHpqzUHI6q+UicbleGk6Bn/pz1h0vy4yixn8a9AcAg2/B3pT7Dq5JttK+CMjeGYWrI5z2omcoDqiMcu3DXtq4PsrsGcPjszYfzPPEfc/o15XO4v3csUQYw2RNyvoQPm64Su5botdvYcfvzNYtWJY4XZ9l+JYBmhc3jM=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:/4mmO6e5InVVTnTJOUPqS/DxfXSxl/ISK31Y4/E1j4jpnfIkS/hnE0S+yGBA3JKPuS5qUGvKlHdJ8DDGrh5ufsWkZ1viWmcnYfeNjnVTTtbeAJeduGZp216vrjEK+3zxMuy7kfWsc6QsxSXLeTGpY5W2aZ2FgT5z9Js7avCD1HO0a9nxuE7XAxWPQGngmZ9s9Ob8y8jA+7LFFpzPa1Ef/8kUUAnenwk9xhpaWDI260wKPQYaK/FPK1/znZj/iz5t9rmR9FRDA7qRu70ZrQtRVN8Tvj+VHNIDbaW8HKFaAKto9fNGn8K4JvQR3TUNv5ywtxpHhfDE6cHB9rZBql/MQ+ndZ5rKCFykr6Ba+ZEnqTZ4hjA31+Kh3TjD0uWYy5HOF6wzN5FeJ1aITmbShl2Tp7wdwsjOv0Pi6jdBYDxNoUGLZlrIJDnpgWWyI++De3V165Meg+HoKa5ywfKbQzPsA5mntMjvZ9qjzcAE/EyrmvZfdDADAg3OJVBh5eaIefk1;4:VtgZzmPveIlsHBy2memwsOtde1Wew9yZsh8lV3bovV6/GEUVRLAHzn3CTN1t5q7Ksf5l+ahJdbZWCDJjkAjsxryRHek4n7bcmsfwwGA3dwu4mi3hKpvim3slFSS/WwxEPcIOXlPads8XBa37EkCYywtdqUtvnuOin1QdsFGjiHzaTy14MF2bm5G2mTnK1GsUw4T1E2IYlO5usqwwL7ZI8JEsczXxDtGiKRruY2U3GDzQKb2OSdamghEYOR22e9qzsW0nmS0NhcCN970sT0TcfDB4MA9P89PiTn2XH5cZ04P07TXSKJPiMp9X5ynaL6sf
X-Microsoft-Antispam-PRVS: <AM5PR04MB3219D85F713305F440362813897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(2616005)(11346002)(956004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:K+TdftZOKh4EO6ON7cmjxWjLcnp9Gvsk2NDnFuw43?=
 =?us-ascii?Q?yUhmnokJogfPNIy09Up30vC29vf1m4Lq2xwh+50xzCI6MYGNtx/VokhVHDXy?=
 =?us-ascii?Q?voALYn3mxKs7XOlL4CjHuk7KiKUClxyj+4GycMmNOGqzim7b6QE/BgzL7gxA?=
 =?us-ascii?Q?sf8Td5SznttEQiOOwTMudfr7eyqPgTfVL+sEmiXJxO6yclTp+gTECm4ACa5R?=
 =?us-ascii?Q?OK8AhL2+dhmre2srEAxfaeSgrg5uKCF3hqvH4qY/d0zAboDVwMW2KEQWRYO+?=
 =?us-ascii?Q?fecsJky10BsakJrXeCAjveRIXZjLbx4tN8VIyiMqMDXBIG9W38hJxC6ybmtp?=
 =?us-ascii?Q?0gfh43Hp2mdjg7NjIrggAtlRL3QluGXs0VwDkC5SoiM3al/8lRgVIOdZeXP2?=
 =?us-ascii?Q?Ro9BY1Bl9eCtJqIiyFPE/zDX7YIJS5ppnKqLSITm6RoZy7QqFj2vCXXTIbTu?=
 =?us-ascii?Q?ju7EgkDEhCULKXbqdsNODUV7I+Wjl3UuaJ3FLcte9OtjLOK7rHIzXPYv+blS?=
 =?us-ascii?Q?OfzwyB5dqeWPqT3Zb20oteAEKkyTMyKF69sIA6ZV/SqHGy2ROuEz3lpSbQoE?=
 =?us-ascii?Q?nSemUNwN/PZzuNPioRH4MEbVNEUfEF1kf0vZ2eytd6tYy0uI15yxEiKl6yZu?=
 =?us-ascii?Q?ixfZHGaUXLX2w/sHy6nDxUuFNVKKMgOgXexDhjpjw9aw/kp6VvWgbLWokatc?=
 =?us-ascii?Q?aebK6BjSyslt13Rj7O5XaAa2Naw5Iczb8TUho329JZaQ2b1URq/fjacc6DRq?=
 =?us-ascii?Q?APzMDcCS9UPR/nBE47L6vk57GLQQHufHgsRewENkxyGuI5eApudS4vCt3VYU?=
 =?us-ascii?Q?jXs3yca6fvhd7S7Y7GQrVxx9uI+PJv5xYM2blvN5Q7LmQBxChgFdL8sEf5AE?=
 =?us-ascii?Q?8ngrAgb+MptxaB2EKkaOBx05+r2APKUbJrAnQROVVQ/Xqwp7hYJvHiBJP6lr?=
 =?us-ascii?Q?EIDd94NtTv9+vWe8KtYAn3hCnBqvGRQzuqrX3CTgPqmCgtx6BHnwka0mXDYB?=
 =?us-ascii?Q?fMsn1BIIncnnqz+TVba/IGp05blF32F+W6bHkTu/JmE5+TSgNSPM0Z54NRxs?=
 =?us-ascii?Q?QYTce0jCspn7+EKhngE3UlmIgCJSI3/leLleNUVB2JnaM2RBGQmN8QB9Ve46?=
 =?us-ascii?Q?8/QM0ygq8ps3UIUw/myaRiRGJZ9Jwahxo1JlQCBvqNirQxDMUN2eqYhcerFA?=
 =?us-ascii?Q?q8BNjQDMAIhDAVwoor2Sz629SZvyjYuKqhWON/0W8GiLRP1phiIlSWftrLOA?=
 =?us-ascii?Q?wWoOusRB7pDmMeATYZxAbTGPXms0z0m1ArLy5+C?=
X-Microsoft-Antispam-Message-Info: XOXO4ItzYcKX90zNGen1kpkm7if2ItZgQqRC055sxjnASM4CONXTNWogBIZKHCU0lXegk9qtrg0cVw4fEdfggai2C4Iy8ik9EOKVOuhWiMwxnAXlILPGGz+kynmwkvITIDfgD9/U2J4qPLC2m8y5NzEg97tFXBtZSTzPCpN+AOJv124hLik4dNLZK7QLGvrH
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:3n9NkLLrjgtPrBYSUOip/roRuPQSp5nIxPOmRUSpc7sRzjDppBXp6aCnrjpNA4xAYJYI9sFrbtXhAUPQ0PD2CIWF5dun3fykT16U0c/+NzmhcLe1CwE3UE0MgCbTaMvX5eLju/pl8l+6jRSCxUOfQGvFhKPtWz0pw/bXyRGKcJB5EFwjtTSfnxNRHaYxhJwjPD8K4DXdoVwhuLYq8uo+QqP06adt438K1jO1hkJE4ht8I/5c1whhV485AE+FgPwVNJUYWYJOzphIYAmgzBFiB6JPxxowPvF7Bp6KT96CuuNIBGp+/xEVXuPk10JTbnxS/4js0uj1sq6uapGC9E5sbY9xFr6bQPK9EATSOVXYPM2FZGmXPwmP47IMPLk0M4CDQrC5q2Gf9muAa/nU5BqFf3scimYy0LuZxOX8QmdCYpI//OroYnoqT7kV1U3JoUkinpUjGDX/GKxkn6mR4+vPlg==;5:hV+gUbq4FAUqSnbCRBKtJOf0WRI0B3cj3yDRl/ResBafDin093M1X1eB3poU9sSTc3lrSianO+i8qt6BEhZ8tNZiMCE63tUxpTMeMsorHoQlEu8dSJK7649wmJZPDzuO0ZjOpAyDmIwbKxOisoTrCT52Dd0ZJoBeQt2BH6pfWA0=;24:kTXRmW8vinsYn0EMEs0ndlRh1gp6l57J/QMlQmFH9nFEEy9kBzZKMcIJrmOqKKpjCBcGePfMk17Sgw/dTLoiOZmKstHFHGQ/FaqN8qKtg+U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:C66ZSUDe/lxGnUc3HV1VQNIRr+j0DGrKhmeDwBU+L3Ls3QDatP3P+n+DPu7QLD1lKn3gfzdxxX7HKMKqW9zL+iPxGHvdgN/v8vfEqlHNGB3fnx+I0R2vhvUWyOWJuTcRAMH9ev++8ffDFFctN/ccI8MaXwEWaAStqIQc49TvK9ZNK74xVU6WuyNqAP/4ZLP78ndmOv/NwfLD4QT9ZhYAci0RZdyWrtDBHgMBoB6jNt3/jl/RHYhI5HP8pcim2rWX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:28.4348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f26088-02df-4743-b3bb-08d5d1bcb23a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
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
index f56226f..e0783a2 100644
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

