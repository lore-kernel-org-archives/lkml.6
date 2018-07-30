Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A9C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BE620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 02:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="d3oIT/Zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BE620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeG3EZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 00:25:40 -0400
Received: from mail-eopbgr690065.outbound.protection.outlook.com ([40.107.69.65]:4096
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbeG3EZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 00:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DMtqpOMbuFhQoQgeJJlG3FGQoKSeAMNNyY9oeGv2F8=;
 b=d3oIT/Zib5MHs9s0fjzPOFVJmLGzLzjEcIKsXPWQRF6t6BXa1gu9PlOFS31IoPp0pu70esJ56rmi1SpgATyY80aUwoVK86OSDeq1rFbBtprd7Pc9Rawm+SRRMtXJJ0pFTg9gc5EHRajgGcD6qltbYhZQr45gYGJZQ2HFLRIvXok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Mon, 30 Jul
 2018 02:48:56 +0000
Date:   Mon, 30 Jul 2018 10:46:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v3 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180730104636.1a3e6c81@xhacker.debian>
In-Reply-To: <20180730104228.28b58bd0@xhacker.debian>
References: <20180730104228.28b58bd0@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0027.apcprd06.prod.outlook.com
 (2603:1096:404:2e::15) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc42ea34-c5ef-4b9c-8695-08d5f5c6ff46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:WXBvdwL/s6ZYQSpsN6y7zCfLoEKcB+9jx8MccKvGx/qYoHFhhCm/fQqv0YYUCfWKxKWPnkFtLP4Zywizg3oKD1PqQhsvZd7Biy/HOTOUYG1Hook5CjYIDJYbJs/llmEbVg0IncmuWMZ+9uqgXdH4nur0zNYnuq37bkxHJaQQtJqW9vliTdFdW32KLLsXnx9CGcof9lY/8+6E2ebgMADLxNzCGO7O5uwm4E0a+T4/Pcp71DwBdvxotvSW0qkV33mg;25:7Fk1vARo2e9kZXemo6zdcpnuMuJnXnK3WLJr9+gIryxKfZEeyQ7WV2CKqTZ7s3is0iz5gLZ6o5PRdOgIHdupKXNbOwwRIqqCygAO28Nbf34jzGNdcOC1Ba1vnUl5v4YxpOJTgtxuM6yVs3GeVIwZowpih4ewyKbs6KeABgBctH4mJwEw6BSQ7flRHXwmPQrM3aGANjpQT6Yp79OwDVHBK7WswgGyKDpqpdZFfknzZSbSlNtkpXP20HTqz/of9jDj4kFXhIcRyncBM5i/cup19BLzGbsABDAhNPjuLCNm8FYdzkS6n6WNvfCDem1oP43wE+LTBFJ5blWyH7Ae/lmUhw==;31:fLeS9TSy5GKeSIe9TsIwkF1bO0b0+gTldOWVp3pC2OggNbck+Kjc55+slpppDiYI+d9+hggjibbn10WosiQgMIww4A1c9MJbPslTL7jswfRqIUkCbzdq77KiBOc1GChYmCEi6xxGr8lG6tFXsZPjHQa6u0qTPJBjD2kh+GA3A5Yaevt4V2+T2o6rRo8lgZePqmJT1DMM1w3TPb4/SE9zqqakLCDfj8SbyVakwVVQNHQ=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:BjSAWJUKJFPY5/aoFLi81AOZBZCyTBllN3JectW6nvoSRruxJjj/46K2lYVUZSQcqkjQROYnDkgHYdwASHCtOzfSH90vetzIoE9S8aLPXx7q6EJIEaUT1wpJTJ1oht8HXonbN0OsIFL99uSoStk0z/m6JlK+Nx+mmWw5weTWtgEs1MvegCPTpzNdqhbVWYki747l8ds46TmwybACeS5AB+v3WEQ3Wyq5yR9zhU/tel2emik0vb/4E4Dtzkjk33E2GiqQsJxwpQMxHnIUjeExIJZf+HHo7pu9iTU9RlcEca9LcXIHPnh9VUaQgan6Umme4sjTfLJsIxHZQETMj3svCmgHqX3PNm3dOnnS++ZXfUtoQZGLZNaux57TmY9w4Cz/SU2JUu4RQdV9+QXqpBbYZyBQHZTmm9De4vpC4zz8H8LdFWHUYjHSeOVXudxzFGwThJCg6Kqwv3/gqwIo4yN4xfR1XsdE3j8ke3o30ugjctb2N/gGSklYvA2xaZgPfT/H;4:4NXyEBVxriNe/UdKsdaO2WIqVts3Ym7iunNWvtJp6CtJIUDlX184bDNrmtQOZ0o8jZ9vazhD98RDkU37WKqbLOehhFc/w0MCGI8xKSpH6sv1HCDip0xcqoajOdieNrCpDSO3nlLyP/ClrHpWXBm8YPiOHYrWnlSTyutEfLYei7BaqiCncGg04+u5Tglw6WfUgzZ7cn8EOOC+mVckbDPpYDD/qg9ToZDzCP7g+MmqG4lLMCZenxa/A/6pCdcSJvOIgrYwWGlm/1JsSnkGzAceSg==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1578E6448F2A876080ABC74CED2F0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 0749DC2CE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39850400004)(366004)(346002)(136003)(199004)(189003)(386003)(6506007)(8676002)(50466002)(14444005)(76176011)(81166006)(305945005)(7736002)(81156014)(33896004)(52116002)(7696005)(6116002)(3846002)(97736004)(956004)(476003)(23726003)(11346002)(105586002)(446003)(26005)(106356001)(230700001)(47776003)(1076002)(486006)(6666003)(9686003)(8936002)(53936002)(50226002)(66066001)(68736007)(5660300001)(86362001)(55016002)(4326008)(316002)(186003)(16526019)(110136005)(2906002)(25786009)(72206003)(478600001)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:uPixWRCW1QTZ/X+1Hr6G2Gr9FZ+nvLxdY4HbQa5?=
 =?us-ascii?Q?OurWGjrtO8b5fz9J9KFowhphE5Bfz6m86AB96jq8qLQnyF6mBBn57QLxXLYu?=
 =?us-ascii?Q?mt2FmuQbv2++/ir4IMMipRnBs1SKOrJuKQBXXaDUDi9pa/zK9PEnA+ydur+W?=
 =?us-ascii?Q?HeeR4w9RN3lEgsqT43r3MRaAz8fE6VIZ6Lsn48s9j6AmWxbBHVYvea3+ReO4?=
 =?us-ascii?Q?XOmQJ6sjB5myKkDsPjbLnXk/7421wxaQk9AFxsJLtI2202g/bmiSqKEWuInT?=
 =?us-ascii?Q?6wLrEhguZdfw2nAFji3xeZxIQwrNXxQADnVep2TWAflZgwrmjMmVDf+u4swG?=
 =?us-ascii?Q?RsI2dMp2C2TvZ43Dn81wyrtzRDppo6DUNEvC+n4+qoJsC9VDfkeKeKkIwThm?=
 =?us-ascii?Q?GJwMVzJ4LTx8X335mLe1z+cZa5ch1uWS/bswMSKNbAlSt/3E60vOPYPZad0b?=
 =?us-ascii?Q?4VCtxHebD18iVrG2QN0FZHTp6FaZe+Vm4XhLcRgHti7/j0ybJQtx9moK3nGo?=
 =?us-ascii?Q?DpJca3VTAQw+3N8C3fr7jCj7e146bsbPX44EgQmF3QOfEXQd19rxFG5DP5Tj?=
 =?us-ascii?Q?ioheSUiI/TBXBG7GC/536nR+tiQgYx/1Dp4zV19U+g9s2nQ8B5RUNFgDKmHv?=
 =?us-ascii?Q?CGh9NXxcykP9NQrct5cD+0sj13OCfGeNXu3PNKQ34o2kHCUCCLLEMX7UdeOI?=
 =?us-ascii?Q?0MVrZ6gDNN4sXrDqwoIFVyH0ej8UCnydwyz+TxS4h6yVJmUYntMoqNdJCKuv?=
 =?us-ascii?Q?yj2x4K4mzZyfDG/EM27eIgBL1STkpeJ5e3MuWO3FNTKHosNhz5uAYWDqq4So?=
 =?us-ascii?Q?rRnm1GgG+nzHNVKLZ0MYAsjivEM0dylSkjMRYy6W0QdmbS5qEZd6jfux2ld4?=
 =?us-ascii?Q?lUDN8TVX1l2zzeS/oJXBf35yzlYZJhdvpv4e3ZOLrOlxg5VkaaAv+bhkOZH2?=
 =?us-ascii?Q?S5jTOICl3Kg4df/XzdkrvNTvLugu2Ke2TFHqwf314zOn7z3EerRQOSmyh26l?=
 =?us-ascii?Q?RbH0kp4hC4wBVnAsE4agJrBMTSmsckrrJL64n1ovLKDy2eB6OxLu2mLdIrYv?=
 =?us-ascii?Q?bjxRuR28XsAkf+GNjToNA6UpOAJl+R8nllD/G9g2Suo9pxsIh7sVPKDNlJsx?=
 =?us-ascii?Q?YV419dtES9PEujRI5EspWFpt+oVKKy2gGevLkbM9hlC8sHALNLng9O54b1mc?=
 =?us-ascii?Q?KoLWFnSUjQhKilmfqnYffcY5QbyDM1jV6QmGa0nObR66qWdZWvOEHU0jIPCz?=
 =?us-ascii?Q?WFED5iqzJwuomwb4J20DK0bugev4y2pDcyxoDouYU?=
X-Microsoft-Antispam-Message-Info: uBOgpEfyXhokp6hpycK90ndeNtPAvPv0Hh2y3fRsiP0zi79CzpQapwy9mCOXUN5cwLdEM+i9TabZ+oiVhz72nzMS6ssY5Q23d1V3/Z77oQRECSqAeC/nEpWCE0T+389EldRn+gRKfnOIoYsQ+EEAxwlZf/8hEGtmJ1mprKoEp8AyUDM8Afdm8bkNiTbAUPnrcWZXVDshR0JCFiGsKgeDw01w8prGKC7aqMu0jBdb1fg3YTfYqlkbpxD1rP+xGobVSAbMu+zZ2Aehgy+IlIYcEPBRv2qAgsDTUqj0Lxn3mmbXVfYR9gLledvsX1G8SFhNoYE4E6tFZXozCr2V6q2eCOoGDhZunAIbQUThM8+0nsk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:0yIQHG8vPqqwmb8ElTnNHjCBpbyyL6rhFaxbM1u5/Qxupef1bZFvK9FsH7fjKANCd/qoIJvjaPQZfGWNscoUe3EWdC/UFkFRjJVT1QJcr8uKlyQxIB2yMaPmOu8NQEY6tyn3FdeskvEFh/rpHgiAt91Rxtg7+NCHP3JezE3SKxU6jEjp67AXjupoi30bjhH5PALg+AwSXWGXnemFz4jV8qRcxqtESOF0pn+GorqjQ5wmIOiLbzsmWTeNPcOfCN6TWz+oBhDo7LlvcrVS/94mUXB3xl+V4iQbjlh9qszjgu6lK2bH9q7XWC2OBfn+Vxbi2c4cHpUG1MGgOIY+MS60pFC0SObG3AheC0Yu1KEY9uNDUYXYgSSS9BdE6aEwQlmVmjH5r2wpNWLl/QKG+Iuaa1App2ke8yONk41k8sHRmy7tamVL8xtFQ3zGN9M3YUcW5f6AviWNlmdMxkEaDED/1A==;5:9Z/Dgd+YmXHIfoHSzbOcmmEh/aUr0lmzfs6D/6oPknxpVccxr7YYKlzZZn4SRs05PVCJ+IvTl1Y1ZWXp0qjLGc2K52kBo+M07E8qfvb2NSq65XJ1X93gNPdgmErhBR80MA/zx1UbBLL14dLBO6E9Pza2XmQMLiW0TQItMoyFWO8=;7:tyvTEVTpoX7KuwqKfq64XoliSa5wcrrF/Y9U3AUsm7/1fdI6joWJJQtXLrOjBuc8XZREWUdP2sVyZPUuwFdAm2yGfB6JlG/RtY+a3pOmpGUY4RVS7B9waOpcqubEordmNCZf6sIs4+4EatjzsK7anQVW1VVkf81//iLo7ffRna3OPsnWCYVBfT/ZJ8k086pS+ykCysPqYynvP2sDMRa3FNYqPQGG+TU7rgQVMbC80yCAzSSJQNf7M2qxAh5ob//9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2018 02:48:56.3403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc42ea34-c5ef-4b9c-8695-08d5f5c6ff46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1b7cd144fb01..e890fc8f5284 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,21 +8,52 @@
  */
 
 #include <linux/clk.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/sizes.h>
 
 #include "sdhci-pltfm.h"
 
+#define BOUNDARY_OK(addr, len) \
+	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
+
 struct dwcmshc_priv {
 	struct clk	*bus_clk;
 };
 
+/*
+ * if DMA addr spans 128MB boundary, we split the DMA transfer into two
+ * so that the DMA transfer doesn't exceed the boundary.
+ */
+static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
+					    void *desc, dma_addr_t addr,
+					    int len, unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || BOUNDARY_OK(addr, len)))
+		return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
+
+	addr += tmplen;
+	len -= tmplen;
+	desc += host->desc_sz;
+	_sdhci_adma_write_desc(host, desc, addr, len, cmd);
+
+	return host->desc_sz * 2;
+}
+
 static const struct sdhci_ops sdhci_dwcmshc_ops = {
 	.set_clock		= sdhci_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
 	.reset			= sdhci_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
 };
 
 static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
@@ -36,12 +67,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
 	int err;
+	u32 extra;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	/*
+	 * The DMA descriptor table number is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor,
+	 * plus extra number for cross 128M boundary handling.
+	 */
+	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
+	if (extra > SDHCI_MAX_SEGS)
+		extra = SDHCI_MAX_SEGS;
+	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
+
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-- 
2.18.0

