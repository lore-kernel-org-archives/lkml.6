Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YaBjLhoeHlslOAAAmS7hNA
	; Mon, 11 Jun 2018 07:00:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 05F19608FB; Mon, 11 Jun 2018 07:00:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SUjJPtLp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=2.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C00AD601D2;
	Mon, 11 Jun 2018 07:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C00AD601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932485AbeFKHAh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:00:37 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:55025
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932354AbeFKHAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsKkuDD/7rgxOwckGlMi34DPD1M6SqTb5nvQvLVunj0=;
 b=SUjJPtLpNIqBZHlxvQBd6v/34rJmt2zzssBreXCJAkLjon2hz9ewbdi307Zt9XD4GIogmDSDTTvhimkXK1OOj5Dv9Ghno7d6ZeRTvgkQyi3U8WCRY7S+2cKF6Y4h8um+nPUzRcLbumoIyIqsPaUoIHZqbHb2SnymWTMZxiDsLQk=
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3217.eurprd04.prod.outlook.com (2603:10a6:206:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.18; Mon, 11 Jun 2018 07:00:19 +0000
From: Robin Gong <yibin.gong@nxp.com>
To: vkoul@kernel.org, s.hauer@pengutronix.de, dan.j.williams@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: [PATCH v3 2/6] dmaengine: imx-sdma: add virt-dma support
Date: Mon, 11 Jun 2018 22:59:29 +0800
Message-Id: <1528729173-28684-3-git-send-email-yibin.gong@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;3:dtPHZIaU8Whtm0imtMHDM7CkQKlDfBHs7PWWrTeueB3tOzkJ/qFQt2Tfe2ZuF7r9fUHhxSC3m+pwLCpw9DKVm0ofnTXgbBPc1q3r/gey3yppJx443NzQ/WjY2qTs3rleDsVA/iM8VLmdtBEl7NJ+I2rHRyFCZZx00CR2qUed47HeisN3wUm/ZEhaGiqZgZpYlcMLp+zlFEWgdEi7yIpSgZclSWGgEUXNX2EMGusqfriscyRcQHSHK8Xi0HpUpMRd;25:gNKpBpzB+KpoAPdJ+YP6MPJCA2Mz/YAI8H9GL0NyKD97qE0k7uvKXCirxfR5YLcN+Xd0evqrpmgR2motyhQK+Gnsw7g20gP3pmvn1zhxbOOGNnjYotJbrw4ti67ltYtisilSzgEABPL8wOX1G4se96Wwh4z3Bd0EKh3nzel/RuGyVBvNZXyNcwtNXtzuXI6xPzKjtdhO1Dt83pxiDqPQ8tEyGIhzBr2h0PBfvjSXQmgGjzSzbBj4dvZpWi7n8WyRRbH1C3+EG6/KNFeRclZ7s3GbjWHDqZeOTSwXv4IGgMEbBBqIXcCD2OTYO0EUX/4pSvBfr1EkikUhHITXMDi2YA==;31:zQ4EWXwUhjrZ0YYQDIaPXOKVY595mANxh612yqMTQGflsnrv24GU7XA8j8kWngd7filt9c802wGuRPIA98BtsJ6gEx2z9KXoZ9BiOWqlNYKzFTnCKMyV6f2RE6ktQLKJy2l79HUHkS7vZ7hirrjYjMuRilohGx1zeVSBuNSfqp5zLAWuyc1wU1Qvc9Mlvfmp0tSxzx4joIatFHd1/bL+nziduuRl9mdW7hVxEvJDYPY=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3217:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;20:M/zJpWgVKAhClje38nkmbrFLIASxG2sJUj4iJkZL2OHAPFhddceikezp9LJD9DiQ3DoLB4T4oOnX4rF3lMXsNQvXCOaNqNF4GMENpjD6/xvEoDp6EzTYZMECHCB9QMAJbcx6P0VKIs7JD6ZoA9flHBU05J1X9hFFEImlcxO+Ah63OoSy2wJOOr24Ky7gb4uhBS73ca5tFtG2/ErOW+HWJX8lnHmwzZ8Jh/B4AS9pvvZe2Oi8IwFmlQyTgamCEURmA92D4PV9Pqx+8EtqDIy71cQT+VPXTYmO7l1iFJDy9zsHbTBcbRXtGOGQQ61RiFQ/yUijp+iRQFsbTCSDMSfMR8j0faTQOlYfFod3uGC0RdAkBGxu1iFiYBoyfw1MBQBCrPHbxqfpBxhWgP4lCrN3QHfrclw0Lb9LpuCzkIanJSp77YAMYuMABamgllaxHZ3K/dtcVG8qibn3aHKc0f0DpS+WbzvBzEMN31w6e10nC/QHfB2SmMbVxEWbCx0fhnjP;4:rXFsMYFL+BUGz35+VCW6r+EAcJBq96fXfpHR5N5lqYPbV6/QnG1BIHbigAgCxG3fjQzeswex3D3ih+rXZL+HvXC+uyFfPIjFjbGeFMB3qaKcNtP2S+hIELKbbjkLwIlvgTOmnL3hutEpeqAKRaKn79v7RADJbyhnSWYXQxIl0h64XBKYkZy7b5OdATTMnIaxwBLszYd6nF6N3tDAOSHd9K4jZBUMoTgCdVwhxf/yLFwLjelf2STrTdQpCd26L4C0WO+efBEAM6u8a3moEcsyL3WPKYg0pFeRWVVARVPT+KZ1IwmJMHJEHs+d4YGg22l0
X-Microsoft-Antispam-PRVS: <AM5PR04MB3217B6D5108A8F69CBF1E33789780@AM5PR04MB3217.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3217;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3217;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(5660300001)(7736002)(51416003)(76176011)(52116002)(97736004)(478600001)(16586007)(68736007)(48376002)(59450400001)(36756003)(50466002)(316002)(2906002)(386003)(6506007)(81156014)(4326008)(86362001)(575784001)(476003)(106356001)(66066001)(8676002)(16526019)(6486002)(105586002)(486006)(2616005)(956004)(6666003)(3846002)(47776003)(53936002)(50226002)(186003)(446003)(26005)(6512007)(6116002)(81166006)(25786009)(305945005)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3217;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3217;23:rxPZLtX6ao5DlVDKgltdevtiSeLnQs0MsfHB4rmlz?=
 =?us-ascii?Q?c7KEh1IFskij2oW4oXafoeP0Xjn+4ET1WttWnqPIQxosbwfopIuA6X04mh/u?=
 =?us-ascii?Q?+oBqBXsFF4L1ekoqughDauukFLbd9xzIOVcbPOU9KgYP19v/dwlG0NY6Lfs/?=
 =?us-ascii?Q?EoI0g4biIIh0gvNiH+UYoLGzlGGeW5RIWkPjZ7L8yYOGNB8ro11rj//mPnt5?=
 =?us-ascii?Q?ATwn9TXxIFa4c2n60x8o379JM3lqMRyXV9FDA11eXXr4v9treb56sSpNj5D5?=
 =?us-ascii?Q?U6QNtcNjnGoOgk7Wvylmme55TA3/Svdu/9Mfr8lA9s2qNAfhTqjvCik8rbUx?=
 =?us-ascii?Q?93pcKJn/BKoTDQ4TrcmiX43jsBaYtbiFJ2vDVb/5tR2wGPh7qqkey6Hy2/Pg?=
 =?us-ascii?Q?hD+9BeOyJB6IrI8NEYvvV0kM2U7ODhCe1Z1Y/sDFDw0S9sHxEM0TfFMIwfCV?=
 =?us-ascii?Q?UVNB7mwAGY/v7SOYZ2wJcAzRWghWyr4k3RGoCwU7hHMwiBDmSXIxwHACBvXe?=
 =?us-ascii?Q?aWXDgw25pkKhDgT8Y8ytsC3Xa0ip28Wi1hAs5qTlYbKDnypv5mhP/qgcmrB/?=
 =?us-ascii?Q?EJPeHUWFAtID2jUex9OXyB2y+VfNIuxRh4w159GhMjVZKbXQLPMhapwv3982?=
 =?us-ascii?Q?3vGJ0yYRjLIRxvPlHE9uMAcWnh/E1ajOs0P0ROYZDT8kztwr0OF0OnxmHCn2?=
 =?us-ascii?Q?EMmUWyw66JzFyY2v7qm9ishj2h84mXHPqFfjEUjdXZF9ISQGjtHTNcmvszAL?=
 =?us-ascii?Q?GZ4wLeNum1hogkOfTY3ISdk38X34D3KT5HaXygp5pn5ISfzdtSpwK0yCduYZ?=
 =?us-ascii?Q?zNOnTGkPP/udXq4MHnycRiAHRcVUw69bLZPZZOT0b8CHO/d1IFTZhTbe6Vrf?=
 =?us-ascii?Q?WWKoCuZY6Q3wcjGJ1rU0YRL3DZ+fNJFBu/1Z2CHgMVMeW/jM5+SbG7g1wivm?=
 =?us-ascii?Q?ta4UEM6RyJv3X2bzA7qJsjzqRQ1mf6OI3IZHC4hc6ARjRWbPA5hE0V40ozpx?=
 =?us-ascii?Q?QyDblrkN8Jg+DMyU/1XodV31811W8ObJfj/UOc9gJkpfVbDYMou5ky9iF8Bu?=
 =?us-ascii?Q?8fkvsk9fz8YRZoZXn7gROnZyI8QVApsRX4O4+9gxKjnEFRl/O3iaMqws/9f9?=
 =?us-ascii?Q?u8BQ3dUau6FFojN1WnX0LANy3n7wvcMlGjx1EWtQxaRGPA9EbgCWFo0k+qJs?=
 =?us-ascii?Q?/D+UmC5sza3UcGafXinmzagDecUQIaFOe+n?=
X-Microsoft-Antispam-Message-Info: coyit1JB4MVTOeZl8a9tii1hQwx9/b/5s0ZX61Gsrwq1mOKr1sdbmUMBtWcUb/n2Nh+b7rycDardV77mFq1oyO4Ggk+9FEzV2ypDdrl2zhuWgJyI/EEF9i9h8ym+KdUShSrYKnD2LbvfNntDEVZY6aWCFbxi7WpH637jInXHwErFkyMVdXzxcaWvOHY/aYSy
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;6:XC+sVjQXS2zvdBtQPqgNDRJPkqEkl4dvF/PrT0MW3ljgU+8Q52twFGni0HFvft/8aCyANOnuxbZnsrMWeDN4hdvPD7f/YD9l3QGH4U8KX9OR6DccpVHuAC3AK3sPo2DEkEVRhFvUS9DavL4OUHbOCWH1L6Y4hdejC/AASn7KT5GtP9zGBKYD0S7aqQ9+wijK6RS/YG/lxrET9oK82lYC8DC3JzdLkpiu8EslXdOpw/YcK22RC6ngk9yfRPhE8/fA2TssCG6YSiu8f0ZZWKxk5MzuRm8scOdffXc7FwCzETo36u0EAO1UbTEKwpbrHNjZPYn4vKgXBSkt5a6TovKA1u+gv74oIvofWTRndDWmBG0Nh54JhgPT9jQGsI4IO+xagPFa+UP7bgQ0SUOBAlWp69lDVPl3cxNA+N+vJ33R/o/WH1Tpbvzt9ctvXtAD2LsbTj1iLkRQKZ3scYcy0nlKEg==;5:NdaLoz3tXAYzryPUOraM1VYMN4KKqEmBxNn2pJqpc3mhYIpP0C9kFGqmPmde34pkvI2/WHfFziJ3F+fecbKpw0J9kSz6gzPV4UfEkf0G3uVz2bQNmZsX2v/vnkOzSh57gEzf9DnIDAx3wqkcKaMlt9RIr5s38kS8HvTj78QUq2I=;24:fOBxZK4fFFo6jcGOu/Suw8QrTegFm0u58CGLtf80f4CgRsEQHFTEQFz87/+uoSqrNcRbhuTA0ajaFil0aiAgUzCM/CvOqvCXoiSIa9tHPsk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3217;7:EQaMl1SfO+6OHAKvb/GvsJCgrruP4R+r8AMiBaihAEFoXMZiB1/tTODZBNYYZvjcU4C229fAQWIkCQQ6tgibXeP2taE3UiIy4TEXF7BTCzoINcRE+EjlkcLoldbL80hl4oRz2DmhVKwWNW2svJdhZz9UmazEFUFYcpgikzNh0xzLjbF6MDnhLPUMIp6sUKDJES1OT7OD+OyP9CBcXjJarCGSZujlkzyiI71LCI62qkbrRLqBsRNRoxLZgJm4sh41
X-MS-Office365-Filtering-Correlation-Id: 9392a376-e639-421d-9ebc-08d5cf68ffab
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 07:00:19.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9392a376-e639-421d-9ebc-08d5cf68ffab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/Kconfig    |   1 +
 drivers/dma/imx-sdma.c | 258 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 168 insertions(+), 91 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 6d61cd0..78715a2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -257,6 +257,7 @@ config IMX_SDMA
 	tristate "i.MX SDMA support"
 	depends on ARCH_MXC
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the i.MX SDMA engine. This engine is integrated into
 	  Freescale i.MX25/31/35/51/53/6 chips.
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 556d087..474c105 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -48,6 +48,7 @@
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /* SDMA registers */
 #define SDMA_H_C0PTR		0x000
@@ -308,6 +309,7 @@ struct sdma_engine;
  * @bd			pointer of alloced bd
  */
 struct sdma_desc {
+	struct virt_dma_desc	vd;
 	unsigned int		num_bd;
 	dma_addr_t		bd_phys;
 	unsigned int		buf_tail;
@@ -331,8 +333,8 @@ struct sdma_desc {
  * @word_size		peripheral access size
  */
 struct sdma_channel {
+	struct virt_dma_chan		vc;
 	struct sdma_desc		*desc;
-	struct sdma_desc		_desc;
 	struct sdma_engine		*sdma;
 	unsigned int			channel;
 	enum dma_transfer_direction		direction;
@@ -347,11 +349,8 @@ struct sdma_channel {
 	unsigned long			event_mask[2];
 	unsigned long			watermark_level;
 	u32				shp_addr, per_addr;
-	struct dma_chan			chan;
 	spinlock_t			lock;
-	struct dma_async_tx_descriptor	txdesc;
 	enum dma_status			status;
-	struct tasklet_struct		tasklet;
 	struct imx_dma_data		data;
 	bool				enabled;
 };
@@ -705,6 +704,35 @@ static void sdma_event_disable(struct sdma_channel *sdmac, unsigned int event)
 	writel_relaxed(val, sdma->regs + chnenbl);
 }
 
+static struct sdma_desc *to_sdma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct sdma_desc, vd.tx);
+}
+
+static void sdma_start_desc(struct sdma_channel *sdmac)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&sdmac->vc);
+	struct sdma_desc *desc;
+	struct sdma_engine *sdma = sdmac->sdma;
+	int channel = sdmac->channel;
+
+	if (!vd) {
+		sdmac->desc = NULL;
+		return;
+	}
+	sdmac->desc = desc = to_sdma_desc(&vd->tx);
+	/*
+	 * Do not delete the node in desc_issued list in cyclic mode, otherwise
+	 * the desc alloced will never be freed in vchan_dma_desc_free_list
+	 */
+	if (!(sdmac->flags & IMX_DMA_SG_LOOP))
+		list_del(&vd->node);
+
+	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
+	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma_enable_channel(sdma, sdmac->channel);
+}
+
 static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 {
 	struct sdma_buffer_descriptor *bd;
@@ -723,7 +751,7 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 	 * loop mode. Iterate over descriptors, re-setup them and
 	 * call callback function.
 	 */
-	while (1) {
+	while (sdmac->desc) {
 		struct sdma_desc *desc = sdmac->desc;
 
 		bd = &desc->bd[desc->buf_tail];
@@ -755,14 +783,14 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * executed.
 		 */
 
-		dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
+		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
 
 		if (error)
 			sdmac->status = old_status;
 	}
 }
 
-static void mxc_sdma_handle_channel_normal(unsigned long data)
+static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
 	struct sdma_buffer_descriptor *bd;
@@ -785,10 +813,6 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->txdesc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -804,12 +828,21 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 	while (stat) {
 		int channel = fls(stat) - 1;
 		struct sdma_channel *sdmac = &sdma->channel[channel];
+		struct sdma_desc *desc;
+
+		spin_lock(&sdmac->vc.lock);
+		desc = sdmac->desc;
+		if (desc) {
+			if (sdmac->flags & IMX_DMA_SG_LOOP) {
+				sdma_update_channel_loop(sdmac);
+			} else {
+				mxc_sdma_handle_channel_normal(sdmac);
+				vchan_cookie_complete(&desc->vd);
+				sdma_start_desc(sdmac);
+			}
+		}
 
-		if (sdmac->flags & IMX_DMA_SG_LOOP)
-			sdma_update_channel_loop(sdmac);
-		else
-			tasklet_schedule(&sdmac->tasklet);
-
+		spin_unlock(&sdmac->vc.lock);
 		__clear_bit(channel, &stat);
 	}
 
@@ -965,7 +998,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -987,7 +1020,16 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
 static int sdma_disable_channel_with_delay(struct dma_chan *chan)
 {
+	struct sdma_channel *sdmac = to_sdma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
 	sdma_disable_channel(chan);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vchan_get_all_descriptors(&sdmac->vc, &head);
+	sdmac->desc = NULL;
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
+	vchan_dma_desc_free_list(&sdmac->vc, &head);
 
 	/*
 	 * According to NXP R&D team a delay of one BD SDMA cost time
@@ -1116,46 +1158,56 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
 	return 0;
 }
 
-static int sdma_request_channel(struct sdma_channel *sdmac)
+static int sdma_request_channel0(struct sdma_engine *sdma)
 {
-	struct sdma_engine *sdma = sdmac->sdma;
-	struct sdma_desc *desc;
-	int channel = sdmac->channel;
 	int ret = -EBUSY;
 
-	sdmac->desc = &sdmac->_desc;
-	desc = sdmac->desc;
-
-	desc->bd = dma_zalloc_coherent(NULL, PAGE_SIZE, &desc->bd_phys,
+	sdma->bd0 = dma_zalloc_coherent(NULL, PAGE_SIZE, &sdma->bd0_phys,
 					GFP_KERNEL);
-	if (!desc->bd) {
+	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	sdma->channel_control[channel].base_bd_ptr = desc->bd_phys;
-	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
+	sdma->channel_control[0].base_bd_ptr = sdma->bd0_phys;
+	sdma->channel_control[0].current_bd_ptr = sdma->bd0_phys;
 
-	sdma_set_channel_priority(sdmac, MXC_SDMA_DEFAULT_PRIORITY);
+	sdma_set_channel_priority(&sdma->channel[0], MXC_SDMA_DEFAULT_PRIORITY);
 	return 0;
 out:
 
 	return ret;
 }
 
-static dma_cookie_t sdma_tx_submit(struct dma_async_tx_descriptor *tx)
+
+static int sdma_alloc_bd(struct sdma_desc *desc)
 {
-	unsigned long flags;
-	struct sdma_channel *sdmac = to_sdma_chan(tx->chan);
-	dma_cookie_t cookie;
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
+	int ret = 0;
 
-	spin_lock_irqsave(&sdmac->lock, flags);
+	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
+					GFP_ATOMIC);
+	if (!desc->bd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+out:
+	return ret;
+}
 
-	cookie = dma_cookie_assign(tx);
+static void sdma_free_bd(struct sdma_desc *desc)
+{
+	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
 
-	spin_unlock_irqrestore(&sdmac->lock, flags);
+	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
+}
 
-	return cookie;
+static void sdma_desc_free(struct virt_dma_desc *vd)
+{
+	struct sdma_desc *desc = container_of(vd, struct sdma_desc, vd);
+
+	sdma_free_bd(desc);
+	kfree(desc);
 }
 
 static int sdma_alloc_chan_resources(struct dma_chan *chan)
@@ -1191,19 +1243,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
 	if (ret)
 		goto disable_clk_ipg;
 
-	ret = sdma_request_channel(sdmac);
-	if (ret)
-		goto disable_clk_ahb;
-
 	ret = sdma_set_channel_priority(sdmac, prio);
 	if (ret)
 		goto disable_clk_ahb;
 
-	dma_async_tx_descriptor_init(&sdmac->txdesc, chan);
-	sdmac->txdesc.tx_submit = sdma_tx_submit;
-	/* txd.flags will be overwritten in prep funcs */
-	sdmac->txdesc.flags = DMA_CTRL_ACK;
-
 	return 0;
 
 disable_clk_ahb:
@@ -1217,9 +1260,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
-	struct sdma_desc *desc = sdmac->desc;
 
-	sdma_disable_channel(chan);
+	sdma_disable_channel_with_delay(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1231,8 +1273,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
@@ -1247,7 +1287,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1255,23 +1295,34 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 	sdmac->flags = 0;
 
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
 	desc->buf_tail = 0;
 	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = sg_len;
 	desc->chn_real_count = 0;
 
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_out;
+	}
+
 	dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
 			sg_len, channel);
 
 	sdmac->direction = direction;
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (sg_len > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, sg_len, NUM_BD);
 		ret = -EINVAL;
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	desc->chn_count = 0;
@@ -1287,7 +1338,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
@@ -1295,25 +1346,25 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES) {
 			ret =  -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		switch (sdmac->word_size) {
 		case DMA_SLAVE_BUSWIDTH_4_BYTES:
 			bd->mode.command = 0;
 			if (count & 3 || sg->dma_address & 3)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_2_BYTES:
 			bd->mode.command = 2;
 			if (count & 1 || sg->dma_address & 1)
-				return NULL;
+				goto err_bd_out;
 			break;
 		case DMA_SLAVE_BUSWIDTH_1_BYTE:
 			bd->mode.command = 1;
 			break;
 		default:
-			return NULL;
+			goto err_bd_out;
 		}
 
 		param = BD_DONE | BD_EXTD | BD_CONT;
@@ -1332,10 +1383,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 		bd->mode.status = param;
 	}
 
-	desc->num_bd = sg_len;
-	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
-
-	return &sdmac->txdesc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1351,7 +1402,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1360,27 +1411,39 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
 	sdmac->status = DMA_IN_PROGRESS;
 
+	desc = kzalloc((sizeof(*desc)), GFP_KERNEL);
+	if (!desc)
+		goto err_out;
+
 	desc->buf_tail = 0;
 	desc->buf_ptail = 0;
+	desc->sdmac = sdmac;
+	desc->num_bd = num_periods;
 	desc->chn_real_count = 0;
 	desc->period_len = period_len;
 
 	sdmac->flags |= IMX_DMA_SG_LOOP;
 	sdmac->direction = direction;
+
+	if (sdma_alloc_bd(desc)) {
+		kfree(desc);
+		goto err_bd_out;
+	}
+
 	ret = sdma_load_context(sdmac);
 	if (ret)
-		goto err_out;
+		goto err_bd_out;
 
 	if (num_periods > NUM_BD) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
 				channel, num_periods, NUM_BD);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	if (period_len > 0xffff) {
 		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
 				channel, period_len, 0xffff);
-		goto err_out;
+		goto err_bd_out;
 	}
 
 	while (buf < buf_len) {
@@ -1392,7 +1455,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1415,10 +1478,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		i++;
 	}
 
-	desc->num_bd = num_periods;
-	sdma->channel_control[channel].current_bd_ptr = desc->bd_phys;
-
-	return &sdmac->txdesc;
+	return vchan_tx_prep(&sdmac->vc, &desc->vd, flags);
+err_bd_out:
+	sdma_free_bd(desc);
+	kfree(desc);
 err_out:
 	sdmac->status = DMA_ERROR;
 	return NULL;
@@ -1457,14 +1520,31 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 				      struct dma_tx_state *txstate)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 	u32 residue;
+	struct virt_dma_desc *vd;
+	enum dma_status ret;
+	unsigned long flags;
 
-	if (sdmac->flags & IMX_DMA_SG_LOOP)
-		residue = (desc->num_bd - desc->buf_ptail) *
-			   desc->period_len - desc->chn_real_count;
-	else
-		residue = desc->chn_count - desc->chn_real_count;
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	vd = vchan_find_desc(&sdmac->vc, cookie);
+	if (vd) {
+		desc = to_sdma_desc(&vd->tx);
+		if (sdmac->flags & IMX_DMA_SG_LOOP)
+			residue = (desc->num_bd - desc->buf_ptail) *
+				desc->period_len - desc->chn_real_count;
+		else
+			residue = desc->chn_count - desc->chn_real_count;
+	} else if (sdmac->desc && sdmac->desc->vd.tx.cookie == cookie) {
+		residue = sdmac->desc->chn_count - sdmac->desc->chn_real_count;
+	} else {
+		residue = 0;
+	}
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
 	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
 			 residue);
@@ -1475,10 +1555,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 static void sdma_issue_pending(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	struct sdma_engine *sdma = sdmac->sdma;
+	unsigned long flags;
 
-	if (sdmac->status == DMA_IN_PROGRESS)
-		sdma_enable_channel(sdma, sdmac->channel);
+	spin_lock_irqsave(&sdmac->vc.lock, flags);
+	if (vchan_issue_pending(&sdmac->vc) && !sdmac->desc)
+		sdma_start_desc(sdmac);
+	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 }
 
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
@@ -1684,12 +1766,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++)
 		writel_relaxed(0, sdma->regs + SDMA_CHNPRI_0 + i * 4);
 
-	ret = sdma_request_channel(&sdma->channel[0]);
+	ret = sdma_request_channel0(sdma);
 	if (ret)
 		goto err_dma_alloc;
 
-	sdma->bd0 = sdma->channel[0].desc->bd;
-
 	sdma_config_ownership(&sdma->channel[0], false, true, false);
 
 	/* Set Command Channel (Channel Zero) */
@@ -1850,20 +1930,15 @@ static int sdma_probe(struct platform_device *pdev)
 		sdmac->sdma = sdma;
 		spin_lock_init(&sdmac->lock);
 
-		sdmac->chan.device = &sdma->dma_device;
-		dma_cookie_init(&sdmac->chan);
 		sdmac->channel = i;
-
-		tasklet_init(&sdmac->tasklet, mxc_sdma_handle_channel_normal,
-			     (unsigned long) sdmac);
+		sdmac->vc.desc_free = sdma_desc_free;
 		/*
 		 * Add the channel to the DMAC list. Do not add channel 0 though
 		 * because we need it internally in the SDMA driver. This also means
 		 * that channel 0 in dmaengine counting matches sdma channel 1.
 		 */
 		if (i)
-			list_add_tail(&sdmac->chan.device_node,
-					&sdma->dma_device.channels);
+			vchan_init(&sdmac->vc, &sdma->dma_device);
 	}
 
 	ret = sdma_init(sdma);
@@ -1968,7 +2043,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4
