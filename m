Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98FF7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F352208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDLGYMQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F352208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeFNGEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:04:30 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:25664
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754540AbeFNGEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3CFrUpFKIveFYV2slsOsapmG3kZGgKlzElUk+EcHtU=;
 b=LDLGYMQmqldb1YhD5jxv18w3CprlX5Q0Gt8H9ICAZHArxntCPP9kXfgbz3EMLgr2MvqD6I6XJ3zMuHnzvHh0bD9O8S96nrT9BDF7fYeTYRwT/VMoDcQw8OatiLexzwPjK+nipIGSkhbpRo1Bx65wvcslOiTs1jzcHJYTj0BinmA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:17 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 3/7] dmaengine: imx-sdma: add virt-dma support
Date:   Thu, 14 Jun 2018 22:02:58 +0800
Message-Id: <1528984982-5074-4-git-send-email-yibin.gong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b396e98e-1291-465c-cb67-08d5d1bcab7a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:kwjApfMDWVPmV6atwhXovBi4/k5Q9WraMn9/M6e5fimjFnWYcrdG0ACJE93cegryHuBYzi2PXWJCIgPn3cObHFfdOKXoYTlsltgH6ugNHVG75Gi1CkD34YBgytwxS6pRICoR1Pnd/s4Cjqhl3H+s/bUCZR1nCu2OQfaJ4k7bBcG3MtX5QV/tOfKHGbGIOjf1+O1fvcVsV0f7lBd3bWeNMwKDi0lx9WGwWWjcwT3ZO6ODqWgxQbP7er5bCd3clWVD;25:XzVvUSfRxYJrU1mgQ8lTpeEAL4ZsbrbssbJpljYq3kqzJomE5bxW7o8yLpYXvKqrX0WE/gNgtLhO+OELh5JguPISwytOwA4PNv5yOzQmlhrxPKvG+Lro7gfz5SveRbrKciSlbg+xm1eDJr//gSV5+e5p+TFww0/47gsxEWnelvCeQINj46iqnDqK10pY5TPU3WfNSOTPlYBu+Q1F+tZw/O8bRVF1qcK6YS+YZclujHob6J5bDSDDcCMAKvCxv/CMngTTX+W1kxcO/EZQVaijN+8b3snPeSubtaqAgMu1YBBWXI7gqcgmuKUc13kjgmUDq3sQy71yOL4pQLi8v4oFyA==;31:4VctjVJ57t2zdCP30deXVndMbIYxzINOb4Xqsev8Yy1O/WT9m8CckJasNjHdnu9cFQwr66rmDOhkk6RbkaxT4vFeCA/0X7/GN3FQUXbxV92r6HakEduoiV99i/EK9T9Wy6LnFPhxSQZyGBqiegdOz2xZ9FX908xvFnyLOYXr0M+25KkwjWwY9FML/y8r2bZTBR+OC9ssIkk350IxWkMa2j9MabflSoZ/Dc+dHUMaxWY=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:Y2dz4DT0upQ2dPEJ6+Xzw2cD+e+HsLNTO22mJLT3wpqr+MapVLZNxHAsr36acJGhO55MRWxf7cMqGuEuPMKzBGbgB+PrQsSvol5unSXHL80AfBqGDc1wVV0aYVidNZ/Pmx13DdEkAS6NisJDl1aO1DRBCz9RZF/zUTdSNAuRUry76GmzoGGez/AQ8b94CiiTJa8pEBF7RL0IwQ7yfjxKJ2fHK8ERYZGnC+67JyvTjwtPMwnj9IzGef+t/MKUz/lcrC36PqMS/tS8VM4TSEXoFGW5d2/VJ8UspFPf5Nk0kOzqFm5pCMMUt15OUSrZFwmiKLDvo0YsVfaRJDVf31j6RrQM+mYsb5x40TwyL+NOYlejYLnqS6SlBUfKw4N8/fT1Er1HKD0YiaIxhXcprGoHnPFpCkqD6T3B9HpLwKk5WgT/f+rqblDUz7/NUGNna6kJvxi7gqLSiPxypXHsgp2Wnu4KRGD0OkkNmDQN1bfdz8mQ9j+RQQ2BAeV6czDvfKUR;4:Qk6hgWVRqPjkG0CCWlKbg5qaC8DTvbJhsM4c9Xvzm+AkWNtxsotjePD1crfLdlOnOFaGmWI9Ob9Y5dkGJP2gr96k2L/hEJHmipYotNC3M9+SNNlRgq7VrpBWEqGNuNM2il5Y28jJHv5qeqK+P1tfbjuEFWzm2oRtfOYYZxEjuJl4wzGfmMqqmD3dDwAQs6e+cqOdnGy/7qSnZ3IGw6zhyOvbvjK5OZzCtlm0NJF5cekvZ8YvLZmXBZ6YEMxEB5hH2utxvp+9MlQb14wFibzDL2XBIKbsMWVrHYaKmKB8h8Vy6ff1qWMMHYYvQsMu7huy
X-Microsoft-Antispam-PRVS: <AM5PR04MB321932FA7567A0FC69A0E54C897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(59450400001)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(575784001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(76176011)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(446003)(486006)(476003)(53936002)(551934003)(2616005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:gLAMz3nUr8TnK1voN1sP9A7rNpVGZ9CKFn97piEJB?=
 =?us-ascii?Q?TsY3SsLC2l0A4mALbnoCLduTYFD1UiiS7linVa9Yal0AZQ+QONwodYaQxd2m?=
 =?us-ascii?Q?t5kF4yVP496xPepQj2sPqJO658hL26TJb69hcO9Zh50O+WcNFKBhuhscR6O9?=
 =?us-ascii?Q?yL6nJqMu2HlCihH3gS8SXqCIuzPmbda6r4zmnI1VSfKVGLW5qc1oJSco6fd5?=
 =?us-ascii?Q?ht2kApl+lcKZWWulLTzYB/9wLObB7evCHUSzGXDTnvyg8ZXFI+gmWZZgQHUg?=
 =?us-ascii?Q?ZJL5VQHypuq3+h8h2NFv29tLqgQvx1QBt/uScL1+ARJBZSPO7olD1jl7NtzT?=
 =?us-ascii?Q?l8W6YaJgGwn0yzn586J/PZMSSdkNhpvfcelIthHW71T0Pj9F35fnsiPqskee?=
 =?us-ascii?Q?/J2JR9dOLztHONyT697x8oz0onQ5fjmDlbfTHWybpu1nEE4cYHXdKTBs1cyG?=
 =?us-ascii?Q?D45aUkX2kyW032vTD79W4V7Txqu7bUx374JUG2U8v+/1uDH26iqEdTpNCQqb?=
 =?us-ascii?Q?50NJYNkQ3RhEUzIVW/I9mj9Vc1wnQFlMyLa38XCEowWdfgFZ0rpbFoxxqANg?=
 =?us-ascii?Q?CVoq2Cu6TRHDHsBpaUHeZIc/6dhthlDAErgG0h2gEGMcr62PYyEYcCPDdsge?=
 =?us-ascii?Q?36cpFCae9OTME4UQ3xx47XtbFgBy9AU/BUm1+RQbdjUBXmUmg9Qnqp0p5XAu?=
 =?us-ascii?Q?NygzZVIfWn/3h4IToPYB/UdFHkZj8fhHqET2t6P0F26y1EEAzuJeDr0teJnF?=
 =?us-ascii?Q?NE6v7BB3fpCxE9y9KDfQVTcRd+6fPJb7pMGLYW9k8cimycxL7BUrP1ZFv3ep?=
 =?us-ascii?Q?PTvEt62FJIf+qFyD0FIH5947vW5vsNv3iDDVQJ8gGxd6BwoRtdgZRGV6vP/q?=
 =?us-ascii?Q?aXbs34AQBlme1B8Ex5wkjCkl7IW3dhRcFdvBsUWH+dldHkO6usS22y4LRNMi?=
 =?us-ascii?Q?1QwWgFNGnYs++PnoGY/ewmwauAjTH0uLc1Vl66assPOi8Tnk1d0HmzP/e6YE?=
 =?us-ascii?Q?5z++r7bsaK5ZXFECCmO6G1l0c+6jEIpI4xYuLxSsZUXMLBhfa5xjpJPZpZ4A?=
 =?us-ascii?Q?XMuYiJrzBCtnMAcYytILZPROnXWSW15hmajOoxpG5GO/lf/ekida5liSaCup?=
 =?us-ascii?Q?tfyUmjeauGJzJ8G2j8nSK5YLYpqfKYyCCgGuOVJL5ovsKVxier9dnsfYEahL?=
 =?us-ascii?Q?W8k0P6Eu+suh5sRvLTq5bZtLJKYzF0nRoMI15YoZVMuv/PgmTJTbH/uGziiL?=
 =?us-ascii?Q?35CiXtiBHu2dny0TFk=3D?=
X-Microsoft-Antispam-Message-Info: NjJuqhU0bLsOmIkTUsOknt6WK03vjFIS6O7L22XQ7tqwC2gSchyPxzrr3FFAj6cTTI2NGaoB114tXWh6+hg9LoONCd1BF9HyTVj2I1oNPFCIyiC50l4ogYv1G5PfxqiUW9pFjZDXegm2ioc7aCq8nvDi/3w+K1pQ1jPQelwzzx6f2F1XMl1TacKpgpXZr4+L
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:AN6BjUAhlNf1XqXcbRRJFQYHoPcUjBAapIaD5DbcbScGqHrcT1sZl/oiRzYM8cPSsViV0KgHgugkwMmhMBdIdFX66AOwAXg+ORUxlj3KEdIvPVCJmq6lfF6XwW3p4U6//UVUdv0qBu0qKsxKYqqtV2Z6++ZZ7BlittMX6tEU2YVo0K5XChNmXk7aeLdGHoAxu/TN5+fcpo56og+pHVtP703i4sO434BKCZ0Ilf8ukyT8pZfKa20kcooM10fNq/D0MqPLMe1jHilZrNuOZvsQazr+xzX4vhKSCL1z2oD3HWeMPKIjEsf98Vhk5RDwHzLEkDHETTx7gcXn5lmVdgRtHCqBnX/m4KNuVmR8e7nwxLd9xsnBqyuGYcjRQlJtJz/q95qQhk/BQ1uZ9HYlC4JjLbBQvNyzRBXQRJyZoaD2lTA8QJPvpqz3X82MZE2hz7vYUO8RygzeM/X2JEOmdpQepw==;5:ynPhOELBx69ha/KhxkPIT1lNaF0xtcm0mF2e+xUKmclYBQMdX1ko6EYBfDFCFAbV0BW8RSamQpxorhKU9N+UdeogkvoaLU7neIJ150FK5PekIoZGG58faBprrB/RZO473OyDPtFx2/0hm9iocxB+zarp4ve1xLjtSA89ree8dB8=;24:O8byeP0h2kybPIeF2Orpv33R+lWzcqxw+mV7EGCiZcUoL+1hQJ/wH2lhfC0GjCnfPqfiH8Ns/tLm152IqglDblH+LEoVTtOqjdNd9kU4svE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:J4pRT2ok7iGbd/CkF8eG2JvN1gnhY5T8CaP82DnuNjKINf9muuwEAyKLv28LMroANFG+KsMAqUcw8AABUvzGMNonCEq8I/SRh/6ljv6eAdppz9PZDla/Np9dFfPGM+fPZCipxzPjDapUdu1lX+Igjz/01OLnp9bnnpUQp7pEw5vTlulCNwfhaXwHzwSQn8eqOpYXs+WLDxldLTJt86m4lBHgFAkxY1BQdGNPpH7KcZJw/XqT7z+iblTZTVe20Djl
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:17.1011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b396e98e-1291-465c-cb67-08d5d1bcab7a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
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
 drivers/dma/imx-sdma.c | 261 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 170 insertions(+), 92 deletions(-)

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
index 556d087..719bf9f 100644
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
@@ -754,15 +782,16 @@ static void sdma_update_channel_loop(struct sdma_channel *sdmac)
 		 * SDMA transaction status by the time the client tasklet is
 		 * executed.
 		 */
-
-		dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
+		spin_unlock(&sdmac->vc.lock);
+		dmaengine_desc_get_callback_invoke(&desc->vd.tx, NULL);
+		spin_lock(&sdmac->vc.lock);
 
 		if (error)
 			sdmac->status = old_status;
 	}
 }
 
-static void mxc_sdma_handle_channel_normal(unsigned long data)
+static void mxc_sdma_handle_channel_normal(struct sdma_channel *data)
 {
 	struct sdma_channel *sdmac = (struct sdma_channel *) data;
 	struct sdma_buffer_descriptor *bd;
@@ -785,10 +814,6 @@ static void mxc_sdma_handle_channel_normal(unsigned long data)
 		sdmac->status = DMA_ERROR;
 	else
 		sdmac->status = DMA_COMPLETE;
-
-	dma_cookie_complete(&sdmac->txdesc);
-
-	dmaengine_desc_get_callback_invoke(&sdmac->txdesc, NULL);
 }
 
 static irqreturn_t sdma_int_handler(int irq, void *dev_id)
@@ -804,12 +829,21 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
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
 
@@ -965,7 +999,7 @@ static int sdma_load_context(struct sdma_channel *sdmac)
 
 static struct sdma_channel *to_sdma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sdma_channel, chan);
+	return container_of(chan, struct sdma_channel, vc.chan);
 }
 
 static int sdma_disable_channel(struct dma_chan *chan)
@@ -987,7 +1021,16 @@ static int sdma_disable_channel(struct dma_chan *chan)
 
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
@@ -1116,46 +1159,56 @@ static int sdma_set_channel_priority(struct sdma_channel *sdmac,
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
@@ -1191,19 +1244,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
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
@@ -1217,9 +1261,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
-	struct sdma_desc *desc = sdmac->desc;
 
-	sdma_disable_channel(chan);
+	sdma_disable_channel_with_delay(chan);
 
 	if (sdmac->event_id0)
 		sdma_event_disable(sdmac, sdmac->event_id0);
@@ -1231,8 +1274,6 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_set_channel_priority(sdmac, 0);
 
-	dma_free_coherent(NULL, PAGE_SIZE, desc->bd, desc->bd_phys);
-
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 }
@@ -1247,7 +1288,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 	int ret, i, count;
 	int channel = sdmac->channel;
 	struct scatterlist *sg;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	if (sdmac->status == DMA_IN_PROGRESS)
 		return NULL;
@@ -1255,23 +1296,34 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
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
@@ -1287,7 +1339,7 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 			dev_err(sdma->dev, "SDMA channel %d: maximum bytes for sg entry exceeded: %d > %d\n",
 					channel, count, 0xffff);
 			ret = -EINVAL;
-			goto err_out;
+			goto err_bd_out;
 		}
 
 		bd->mode.count = count;
@@ -1295,25 +1347,25 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
 
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
@@ -1332,10 +1384,10 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
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
@@ -1351,7 +1403,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 	int num_periods = buf_len / period_len;
 	int channel = sdmac->channel;
 	int ret, i = 0, buf = 0;
-	struct sdma_desc *desc = sdmac->desc;
+	struct sdma_desc *desc;
 
 	dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);
 
@@ -1360,27 +1412,39 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 
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
@@ -1392,7 +1456,7 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		bd->mode.count = period_len;
 
 		if (sdmac->word_size > DMA_SLAVE_BUSWIDTH_4_BYTES)
-			goto err_out;
+			goto err_bd_out;
 		if (sdmac->word_size == DMA_SLAVE_BUSWIDTH_4_BYTES)
 			bd->mode.command = 0;
 		else
@@ -1415,10 +1479,10 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
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
@@ -1457,14 +1521,31 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
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
@@ -1475,10 +1556,12 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
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
@@ -1684,12 +1767,10 @@ static int sdma_init(struct sdma_engine *sdma)
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
@@ -1850,20 +1931,15 @@ static int sdma_probe(struct platform_device *pdev)
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
@@ -1968,7 +2044,8 @@ static int sdma_remove(struct platform_device *pdev)
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
 		struct sdma_channel *sdmac = &sdma->channel[i];
 
-		tasklet_kill(&sdmac->tasklet);
+		tasklet_kill(&sdmac->vc.task);
+		sdma_free_chan_resources(&sdmac->vc.chan);
 	}
 
 	platform_set_drvdata(pdev, NULL);
-- 
2.7.4

