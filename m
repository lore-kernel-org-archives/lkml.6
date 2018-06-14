Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BF969C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAD7208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FSZmZufa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAD7208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeFNFha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:37:30 -0400
Received: from mail-he1eur01on0043.outbound.protection.outlook.com ([104.47.0.43]:27360
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752876AbeFNFg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGaw3XOBxk5cW2PAnV2R51VUhiuMBXL3OI+oxBseZ2k=;
 b=FSZmZufagyvvI/PaTGu+0j2HkG/peDKqcO8Jcpy0WnuMAilRk5sOokMrG/WBg7G+qQULkLOKz9+g/rXyRfFj7Mj3EkpwY9WKyhyfR/5aNBxG1C1LNGQwB1CUmyehr5ATfF2lL9knHY5ppsy98f3a54zDDHOPO78cqAD2z94e4/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3222.eurprd04.prod.outlook.com (2603:10a6:6:6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Thu, 14 Jun 2018 05:36:51 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v4 6/7] dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
Date:   Thu, 14 Jun 2018 21:35:36 +0800
Message-Id: <1528983337-2726-7-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
References: <1528983337-2726-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To DB6PR04MB3222.eurprd04.prod.outlook.com
 (2603:10a6:6:6::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab74a214-4ea7-4c84-6505-08d5d1b8d67a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3222;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;3:RQRhceg7quhb9DwmsyfF7s92ammRkKFREqKv5g+enXSX3PKXmtT77hbkoKjYjICTtXnOCL0kx75r9fwKLv7vJKKywkkBgezj/ZMSTxUDKy3C1BjTmg1LhliJxCnohFxDrawX6VBakJ3CAzLxvwwkeslxk2d/tP3kTvw7lvC9nyV7nhL330C7wS3HevIziOMl2LPxyUkVso2tzL27TYbq07c9V/8og0igSLDdMMPV5iJwIjw+ajc1QvDU1FV4V64E;25:Ul7FLaR8fSDSMVKAsAUoAUsyv5iKY1pDj07rMt9FIRh2N4sFj7MqWBWWLDXq0LDjb9CZVZaX65dlzb+bs0s+w9L/8VLVZ25bil7IYshXCP3oeDQPQtBylSgbNpAp16tWzmwS6IBT3rVOwKDetmryDUSpXLxY6vl4Rl4D/cFe6F4x5Q8z9sI3j9088XG9KkOr6dZwn3vEn3+pzIaF46kpOqsrMd7MhJ0NsGfotAoyOyFzOG50Dg+mhnuc5TBHP4vMEDYeuCTG62VqU877NmcybK3NRZ6R3ifGSI420CZ7/ldOyvuOWKdNe6/anGycIW+yJFAnpqiunDZx36FoCMWk8Q==;31:7bwREqCnUSORRyKknzhUwp3d4rf6jIj7OML9tLbUuZz8lD+Dy/2GUpajZW1Zn5ULOhUCo7IIaMMvzHF/rHMQK/US6Mg9YjZ7+ZM/CK89qwVrrTgOF/4jZ/ezKx0nDjKHXgvw2PpXR54yJ5/cdTqF+qkYkdjiRQHNFG8pSzOmuZzplXykT/5lTqDTsB2yk2JCRqxrbvUmkidA1WjSaqhunLnZICw1OKgNy5gtDfj8l+w=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3222:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;20:pFJmWsyeuYQYYh4KWvIaIzLtrTX7zwIf/bUa0SHblEGDlZadgvdGq55tpCtpCmBL0McuGocIQh0Ioka/lyeNCV1MDo6TBEQDsVDt48mtXcR2+aQ+FfMDlx0vycPbJGkW2rF105Y0Dj1PY/NVjphuRUyZjNhgQ5NvsCPCXH/52aoaIbE+JqnoBPdGn5DJnr4Cau7jXUubpehwTTgui27HmWGFfkq1TkU3r+6s1DpqN4n5Yu2g9TC6EV3hC6AVmpwWLxKoOkzUJDZfDXEwKN/ZnsDrU5/a6nzlOql31Zzt+fnYiYBNt28ywxE2hzQfn1L920IhtUXs8zhE9RSUM3hWTYoLgc0/b6xiUcXdAwmphQ+RqvfTDFOrroU8doKkWWNk8SnjYzqn6/RECdmE6I8YNb3aQf/xOVRw7Voyyp0pGZRPA+rlshe6lWhsnqIxAwJXF9wGgrhDa3tdiaY5X+/3pP/I/kEhM+ay3HjNw8p543TNkJ+qy/Z6OT4O7jQyWn/J;4:2UkCmrPwsJuk8Pq/zmwg4FJHY4MJk1kcIlv31nkDd9TkDREvhGoMrcgSm1eIWA+4JY5hKUCGQvPNOkLah66a3mDY+K6od6b2K7PAwyPaKZf/0PT3TpATV8pvcJlUGYIO+zxUPGK8F2ngFb1/hZxtB5Bs67YwureM7ZL6K51MQmkY6oDmRYPI1HC1fTzx/11XD0lZiAWDdh+h3ub9KfMIaGVmn75OuLfGPZH+jzZ4VqpCdL4MDa+w+T4cG/wJqAUJKMVEcDyVHqqpebMgWpKVydmOYo1QrbRXBeRPCpp0ccyqoTzQT0Bh3JOf76gObExd
X-Microsoft-Antispam-PRVS: <DB6PR04MB3222C925854EF90D64950D57897D0@DB6PR04MB3222.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3222;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3222;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(376002)(366004)(346002)(199004)(189003)(476003)(6486002)(11346002)(86362001)(16586007)(6666003)(50466002)(48376002)(446003)(25786009)(66066001)(305945005)(956004)(47776003)(97736004)(2616005)(52116002)(51416003)(76176011)(6506007)(386003)(16526019)(486006)(186003)(105586002)(106356001)(36756003)(81156014)(68736007)(3846002)(6116002)(478600001)(53936002)(26005)(6512007)(81166006)(8936002)(2906002)(316002)(8676002)(5660300001)(4326008)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3222;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3222;23:QwaCmSz4xTJwaRSgW4//yB4Gs2j/43W4wt72fs4Hn?=
 =?us-ascii?Q?9JoovTdC2chLQ79wlqR4zDaN0qcuuHT5FvVuGz0N0NQczJrvhqFYdl/MziZb?=
 =?us-ascii?Q?JKG/hJlfw18UM41bvr9rJmiWKyNvI0Wq1AWzfHbnhXfXDHM/chRhnHrBIssQ?=
 =?us-ascii?Q?XwIhSAnvOl6QQmMyA0vv9rhMn42wbk5EEM3IfTAb4/fkJKLe4O2O1GukeKTh?=
 =?us-ascii?Q?MTtQvz4Mg2WURIJh+rQG3+UPxAh0T/hYsRmN+mZ+wHpumK1deH795jtFYPHK?=
 =?us-ascii?Q?g5ZRYnYLewg2F4Ujg16B3XFFIw4wjKifigGTpdp8qZLFK2h/ZjB25IXpClY4?=
 =?us-ascii?Q?cSBe8gGfyCPbEjKBO91sscb5LmqSpnyuSjGp27WwGocyTSu8e+S6xMhF6mTb?=
 =?us-ascii?Q?M/Yxujv3uXeYgSZ8UlZeqQSQSLAl2J7dfkildefTTRu6jQzuXiEOPLJIusBC?=
 =?us-ascii?Q?ZmUhEydrMn9Zs+hqITPlTRmis0/5uNhtgCeL8bD3hJe9f4SUQvOi2V1bowLo?=
 =?us-ascii?Q?paXhQ4O83B+OgJh5wrUO/MavjNQlzuErxHlpNkLwUYs8ywIzsueIhPDmXxC9?=
 =?us-ascii?Q?sFbe9rDF3DQJVYFZYxFV6n43u6Pi8lhkBsR+40emgErQTQjBka1EKhKoQ789?=
 =?us-ascii?Q?NExZQgoLIuhwAW7+2HRF6ZzgCMVsQUyBRpOtblgl7yK4mbugYC2Tl2jf8WXU?=
 =?us-ascii?Q?kEbLlcPR+8bZngAaInpZ5Esm2iYb8zgp/gbNF9AcpiqkHy0Bf/YMI9r+31rr?=
 =?us-ascii?Q?fkxSR5LlwTFk8EDK0TjEgDW31BOIis3QsCALivei3xZXVtttGQLkw/jOR+oY?=
 =?us-ascii?Q?wj27FEVh2/F374j1Bj3aIMXLCsZgYRJ38WLx1mZTXO0UXw2p8m+BoVQKV/Tf?=
 =?us-ascii?Q?CsYNF1w45644r65NgGjZ0b8WoehJxU7n/cSdr9xNbgMJkOygbbnFfXMxUAGi?=
 =?us-ascii?Q?+J0fk9EFw8ZbA1LmBE35FCJHnE3Y3OveXqAYg4YFY7jHHAiwUls7p4D1aNgH?=
 =?us-ascii?Q?dquB/LiGcFDPmgy4jbJup9nxbAeD27qvoHUwIZjL6myCr8plLJG6+Cf2gY/0?=
 =?us-ascii?Q?CtK86HwS9l3xFa6ERqkK8gnZ3BoUbFPbYbzBbX4jrZBedRSPSXhNJga9nAua?=
 =?us-ascii?Q?usg579VqJwWkhTRybgfKf7EyG3p8D0AQVTi+j/16yXXuWLARPp2gA=3D=3D?=
X-Microsoft-Antispam-Message-Info: KqstIPSJqyW5Ojm0afyOEoeDX5eElt2Q6qKYY+WIVCeJauCdLppMvW1nYHpdgLFvAQzkNCz+K5K0JphoXDYT5HHlXJ9ASeMbbv4YOmtVshyAsEq0VSLdBUfnBanXkn8q2P3LmZ6yyGP+JD3vzQoBpsD+2SqZsKaRklOHZWGwFtVA4DcnaAC1/wi1CMeQLPuY
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;6:AxaiYxpZPs/wHl0APQKHWMIooRXsCvnOSLpWJmrT33xyz94ocSFTMyAHVxZQG5YjI/VI97jqSmFmlMMfKCWk7fD8fxhXzsVxinJ67wNxgNrgLSNPy9bSzb698t152T9UDTz14zi/7K8V+BZ7JAnGLwlzYvsZwV3USNekbmH9ckppkNwr/9UnkkGjTs6JAr8xyZLNQNmO3Z4qaxOIf+SZ0dx3Sp2pWuXPxOpxJAVNjz9NYXY6wZX+zPSOXczHtdYeyaZWg0042DtuF6fpe5sQPyGMmaS2whp2Bhzq8GqLcS3l0MzKX8LI6jMaJWDwPeOfG+MC/EyNgXfzFun7LGSO+3Npy4pDylAFlHSOVh6mngVMw6EA5nNjx7NuIADA0IdbSttWXTjf+LBs6kdTX0jHZfMCcv11sK3jDASGJscI944Pc1lsgXzi4qXVfNVSttRby54GzChvtfBSnnJIdi0VLw==;5:3+r3X08EwT4XbwsIscpHj1kohUFMKiLBXw5dxLWysnQiGaPLFm3iceeNYevzqynAirrVyHDnGa+T1dgtlxuOH9R4/jwrn5wTQQzBCiT8hqDNi9j7DoHsr6LdVnY9Q+8rB0gey0FTJNsYWZMUbH2oGzNHMI6ApmqS0fG2brNaBdU=;24:wFVdHhLr4Mxiq/DfGYZA2PbQXQ9ZvrbBuigVfmnYMd1ivhD6MAWBskjkdybOzgfciXaLPZl0KwDxbWBub3gFw0vwtgi6JKuwszRZXk1AApw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3222;7:11SoZb5M6E3Zy2qPegSmZcTyATjaTBN3ZdjyS9YewPD2tZNo1Xl5cf6mQgZ5QFHJi8NKaR6y4gqGN1PzAqPuzZgwACCapArbzp8bVvY64samH7UfRtwny77F9Wf0Wu1NXexE/u3o/IpfofHKKELrxGSRULYiHmzeRmI2UWl5gAhF2wQLtXT3rgAZt4fnDr9MNmypC+vSRkBqZN7HCDMHUcduY2mbNCl7lAbwbSpYzqh4WtWyg4lIDrL4/OvAchbC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 05:36:51.4544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab74a214-4ea7-4c84-6505-08d5d1b8d67a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3222
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

