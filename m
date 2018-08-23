Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859EF21525
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="mhZXa8EN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859EF21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbeHWNli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:41:38 -0400
Received: from mail-eopbgr680066.outbound.protection.outlook.com ([40.107.68.66]:41369
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeHWNlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mugOSjt0euDPb0idTRjybc3FDW6t0ZBTaqeUhCSK0Ms=;
 b=mhZXa8ENQWP8826/q0KfoND+rhjnYUtEE58zLk+gRpSAVkbE1CkW/eZ3CJSzQX0XGV48+WQnS0z1pq+XsCDRUBu6/iF/98A1jz8R5SkWFQaRbzd44XYzpzY/8YcC/45HXWPpG05YbYuG/REllrWT4ZqQvodyEKn7fL6S+eXlHXw=
Received: from xhacker.debian (124.74.246.114) by
 SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.13; Thu, 23 Aug
 2018 10:12:19 +0000
Date:   Thu, 23 Aug 2018 18:09:26 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Message-ID: <20180823180926.444b34b5@xhacker.debian>
In-Reply-To: <20180823180549.78e508db@xhacker.debian>
References: <20180823180549.78e508db@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To SN1PR0301MB1582.namprd03.prod.outlook.com (2a01:111:e400:5232::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f33881-a792-406d-d868-08d608e0ea0a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0301MB1582;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;3:iO8a+gBzdYCZJcvdWPIz15z/01cPHFwk02BWYqm4ll45FCCi7RT7wSAjc14v+V4eJK01CvwOmRkIxribR3SF4I0IXNkYqSJC0RMx9JDGKOMZ5mxn0FzeK/r9hr8GFlYGSaonWNgHdW3n+HToq/FtWVA7dxIb3h7z2G61+UJypxDqoAHbjKexkWQlsaeihNu2cRfFRYD9S2+gvSRKKyzCjo8wA6iUw/uwCPxelufzrGfrQGCFfnQvcohWWh6YAEiS;25:UDawk77UJCIl5VbCp04sJZkE3KJzIsT4RXLvBUYqguzKMlVQb5P+h3Y//h1A0Ak17ZJfwF4QmkYYqQoK17xuu755Epb04uqCnEE2CcZL/idDAEhACjZP7YuQpG7fC2AAR85un7vPJKlUh+9tyj5RudfHwCmX9aD0sj2mG7eRAPRV9ILkjHMgxqai0fOK2TchGG2bGcpwewSozg7oj3srP7rQXWTjX2RjeUVsU8/LIcAlfQ2C+sYcrdc0KwDdzDFP38cphIO/Y2VGwye3kDo3RO0pKEOdxUM6ji+EEtnkiiFFHV0/Q39Z2L0+SMA6k33dB/28tl8f1MI41XsSrAEYkg==;31:/v87Y6PczlyEmLDBWjDq+1waZzxdmH23x2zpt2fQ2fulfeIhvhEnV58K6EH6j0ldflfFD2M+xx1LnaGpfbofk0R4BEsZbcdz4lU0hlHv8uC3115ahXYDCpRDQ3eJQNPS97hDjD+i3xttaIu+q0bpYUNyrm526GxmGuts8n8fWLDkqCyG6o7i4cEvzrjoRkxb+zkR2wHr0pbDHEyw5XEgGdchJlxKhIARAEvPzGBwgvU=
X-MS-TrafficTypeDiagnostic: SN1PR0301MB1582:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;20:vplPV1squi5HcE+LY9ydZeB0ecMLnfob3uDuc6WJJ+iwpAphGwQlVBAKj7KTTNvewiBdlbVsrKhgCK0uie+TJUShrNz6r68805y+IMlIYL4rXZ68ci/RrH+PNQUPnBWLjImBp0lc8tYTByJkMX75I/er5ygupvPm1lz+1P/j69Fz5n+ViH5Zlf8UcQsCdAiCc1k7bS8E7To1MflSgXv8bJf0iL8q5Rr4Zhi46yx7bdg6vbSgERcX7TqmtNtxB7AECklXdOKpGV/VieljYCFi8U53VysGdz014nO5cX/mKYQLtUOdDRrtgGVKT0I59ZIce1igmTROPBrlTaAydKSSiBTDWNiHpFxNYmsFV7Lk9mJlcde2n6DbG4V1hUKJlEVXUQjl4gmouatrsS8FPio23bvypk2KqVn4uBqkvURjTGtO8pgY1Jsjvj5CulvfG2oHi7Xgqcf1dc6Ad12gi+lTT5WettQj9rqyXyINKughj38iXGpgNjX4429k896Nq/mG;4:2opeqg4aw+aU8hgQatm9OIEswC8IQQK9du8P8CFsWyEXoFenDAcbKIwRn2oY+tbA7T9MNgO/kSzCdzsyur/nzmz0NOzwf/AZ92NETn0n0PUyZfMnsFDArHzh9vZwVb+AUytRDZCUm6dEWKXXHsqTsA5vp57z3LFv9ozp0+JYpW029lgnMo0ZLVkBza+1+mAqKp3btdtqTYa0jTNnGy2WEZTxKDoidPSwpAs42yrkfqaGHpnCqXT20WY0CnQVFq60u81C508VSxsJJ0pKKF5reA==
X-Microsoft-Antispam-PRVS: <SN1PR0301MB1582BB33C9072C184A7595F6ED370@SN1PR0301MB1582.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:SN1PR0301MB1582;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0301MB1582;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(66066001)(25786009)(6116002)(52116002)(3846002)(5660300001)(110136005)(956004)(50466002)(446003)(54906003)(81166006)(81156014)(7696005)(575784001)(86362001)(33896004)(11346002)(76176011)(8936002)(47776003)(478600001)(106356001)(97736004)(186003)(6666003)(4326008)(486006)(16526019)(105586002)(386003)(6506007)(50226002)(26005)(2906002)(1076002)(72206003)(23726003)(53936002)(14444005)(7736002)(476003)(68736007)(305945005)(316002)(9686003)(55016002)(8676002)(230700001)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0301MB1582;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0301MB1582;23:RBnvuvpBn86v1u4PLNn0/gHEI9Zk4xwiq2g2CFX?=
 =?us-ascii?Q?s99a9wx71eyGgcwhmyEgtlCwPILTZiSiIFQ5ZYL//+0MB47TQaK02sJC5t3o?=
 =?us-ascii?Q?reqsXwhCJIFIqZT/QWhEmk44xhr1s+7346O0QuVQJxIQt9cA5e/dVqWKBgnc?=
 =?us-ascii?Q?BNrqeRlgvYv8JGGnS1NAYv+/8JThNyx4MuDVf/ceTUujQbnnVC0aShzKwPgM?=
 =?us-ascii?Q?+KGnkKFRFfumOGWogBB/LM0wTvMydWVDQPulT66l4rW0p/7KS3tNfPBxn44h?=
 =?us-ascii?Q?xacj0Xs+K4oAeGKe2cdTH+0UZLvU9mq4aQTFR6xp/c6hwXIIXFvWV73gdjGw?=
 =?us-ascii?Q?pqEPsCGUM8/jHp0OyC2LYAlyin4YXvMQAj6wHxx9ZYz9JzRQh1VJxe0wHNZN?=
 =?us-ascii?Q?oX78lKJNJKRcLQGzUHifIeqlM7XTqM83w25M8Z6mmXSkUBBFmkP6jRawUDVc?=
 =?us-ascii?Q?WYteY/0GeFjAKU0mOcxpx0cYzEXoE7lhViUyaiPqEuCYlr4YyKSgz+clYoG7?=
 =?us-ascii?Q?p8FmqDMfq/7p4hQ2kLHUMqS6IDQtOJPrTTR/S1+2kFWTad+HFVTQJ29DNR2e?=
 =?us-ascii?Q?6Aq92CGMbvxku58YgONkAlfhxUF6sOd7iKRdR9y5YW8MJz8XeJ6Itz4eGD8n?=
 =?us-ascii?Q?GEWOwpbM/hfd40spPOgbG9NeSp7XBWQUfqFaqJgANHFH7BBiGoblsBogQMTE?=
 =?us-ascii?Q?TSMB9lb8uO39Ua6CR4kZ3pJ+Yn+7pjM2umRLsR7kD+nm0E+lPiU0AWEFITpE?=
 =?us-ascii?Q?SSWshbdDihvP8rgZVgcmV3G6e+6dNJPjpNU0GGcMwNoGx24TxmUm3FYV+0MV?=
 =?us-ascii?Q?VINe4To/2WqTiLL1z9Jt7Od61a4tgK8UEicd+AwlFlk7V3RlfdxaQg5tOkqj?=
 =?us-ascii?Q?45zc0hBB7fez5HCj6ESPzEZQd73/Kr0z0Re+WezogJiq3q7nl8NvSrua0G7s?=
 =?us-ascii?Q?QwJ9eLqtpZaTRDgTscMXVeh3kxeBKc8AkrnD0qXYU7f0bzz2JwjY6zLrkhqH?=
 =?us-ascii?Q?PQ1q3Dl1IQ10q5ErJToV1flxQ1lZGvG2ElWX0Ph3t5BrJYrQi5/CChraM5tG?=
 =?us-ascii?Q?ECQm91BfApY4+pltk4I1iai4jhcI8KSz+9mpNVVs1J3hLxPdoqVQ8hwMEmP8?=
 =?us-ascii?Q?532Y11quhtWdJNIptFq52aIclenng2VNB1qTJxaINzEKNC/WEs6ZHVHkHXTI?=
 =?us-ascii?Q?Wlvcy3wrDmDDll1gMAC3Q647ZHtShsTFAZzhSPitP9qcAV7gxWkARv3pm0IQ?=
 =?us-ascii?Q?tMDibTgX7IppeAZA0IYL0s2RkfyUROCmIwQV1Aq2BtPIUyhObDy/JHWaliTw?=
 =?us-ascii?Q?Ct/uxwb7pKjlXKkiB+uh5OzY=3D?=
X-Microsoft-Antispam-Message-Info: vJcNxcZW8dbn396lCU87R2FkpBT+H82Dk+44fctQMuK9oOnIuIc0yW+AufarnreyMTp7eyJLcknWBTbHGCFc53tRwJCdhS6ti/ZYGZnt+OzESXGFfmIRvi6qDAkmPWSNKaToa9vrmLjB5CefE9aCOl8gqppDKQ6ZVH9DEUoV+ha6ubggd6XKrkzSUtdyXgb7BT41N5qqpt4FJrHxsoPtE45DiENim7ZQNEp/K8/k8H8hAd8LYqx/zDCoW2VApfhe8SsRqun7QaXt/jZMJ5KVQdg1X687vY6GeFkLomIYNjEbcp9prUY2sr9ayOA8Ylo/OujW5KBqwc50wMnc8REJvf26z+n8qkMrM1nkLCUEnxU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0301MB1582;6:DDk9B1QNSQA8XBwU3udZU2XjEQvzzEYpN0cG9Ej51xkkhzi1HixuOyOiMe3JJhe8Tq8ecXq0+MIAL5Trxzm8eIcZ/ktVTTen3rmkpt/H0M5svfJYwA57cVbGIjYNWmw43I4ZL16whD6nQok7wGzLkooaAPBML3v+V1TNUUAohMREJ6SEPGCD9bfyg8C1ZHcuee1kkgzzWhIh5mj66AXn4O2f0mx4O9anK8oAPWihaBIh/tKpyEbcMi1/IH7dQzCCK8MrRZNeGQ3ZELQBk+U1StKu+svNd9dBs/8I8pnLpqUrjohjALtiRp+eCXpZBxSwuBiYgS+TN8FFOl6+TVU6bXgUnSkJHvS+SQy5gD+LsiqnWxsU5yjJoLYVdKWp6P5ARgpj6tQV2i8Eus36UXjhqEPzA6cGGHIoExI4XTpx4dha6XuTwI3oQJ0uiXLqspV404t5lcpTQTmjxcEzjfkiiQ==;5:EtQ79QAMxCM93xiHfa6PpexrXwV7KEq1/a0KBv9CzbDyTMZg9X38toBT21RfYiTvgXPU4D3Owg/FMPwke6CZkE57ANX/h3DK6CRCthLWr3Kl6DCDPgxk0uHJlbT6E5JwZWZyOP42eKNBJgIyRgdwyjAeEPOrA6eruoOQ2W+4AUU=;7:f+5Ekk8ZFL6GrTY/T014aeOyriW38jUDvYZyXzsGs3CW/AONCczH6BSPj+8J016cJv0E3MfluPBOItgzgcpBu7/eXSHmjiS+VIPRzuBAcTfHSjge8TOICxcJ7hCGZFAko/BkkCSJiPxkkqS2Oqu4euCs/aQxzGM6gWL6McXNxtrNv4ecSXzno/yPKVxwleAOZRIC4dnOaiX4kzmG+4wq6NcxpO0ima8e8AlWW00JeFsw8cGTXnejYENrfGLGIlwy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 10:12:19.7560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f33881-a792-406d-d868-08d608e0ea0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0301MB1582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1b7cd144fb01..df0a3aeabe19 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,21 +8,48 @@
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
+ * If DMA addr spans 128MB boundary, we split the DMA transfer into two
+ * so that the DMA transfer doesn't exceed the boundary.
+ */
+static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || BOUNDARY_OK(addr, len)))
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
+
+	offset = addr & (SZ_128M - 1);
+	tmplen = SZ_128M - offset;
+	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
+
+	addr += tmplen;
+	len -= tmplen;
+	sdhci_adma_write_desc(host, desc, addr, len, cmd);
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
@@ -36,12 +63,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
 	int err;
+	u32 extra;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	/*
+	 * The DMA table descriptor count is calculated as the maximum
+	 * number of segments times 2, to allow for an alignment
+	 * descriptor for each segment, plus 1 for a nop end descriptor,
+	 * plus extra number for cross 128M boundary handling.
+	 */
+	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
+	if (extra > SDHCI_MAX_SEGS)
+		extra = SDHCI_MAX_SEGS;
+	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1 + extra;
+
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-- 
2.18.0

