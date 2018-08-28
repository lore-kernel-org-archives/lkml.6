Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB560C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C45208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="uJA+TuLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C45208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeH1NmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:42:12 -0400
Received: from mail-eopbgr680044.outbound.protection.outlook.com ([40.107.68.44]:26720
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727101AbeH1NmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vaoEQz1IWgRSirqSCG2jo2WQ2A8ou5Ebi6qEcnTlmU=;
 b=uJA+TuLi/7PRsa/t6vjEpXQL/LaIUI0LnoYSVXUA7L9ACVyKJuMKDS/C7Qq7avcAKshsOsgip1Dnw7fGYGMAquotSPamH5DqVq6F5O8AxTVEUNkgTj5774RuJSOU+QTdlTpUhowdTgZ68KOCGs2v68qH8fZXDEiFOdVvX/HaLMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1574.namprd03.prod.outlook.com (2a01:111:e400:526e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:51:14 +0000
Date:   Tue, 28 Aug 2018 17:48:14 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Message-ID: <20180828174814.40dfa48f@xhacker.debian>
In-Reply-To: <20180828174534.00fb5e24@xhacker.debian>
References: <20180828174534.00fb5e24@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0018.jpnprd01.prod.outlook.com (2603:1096:404::30)
 To BY2PR0301MB1574.namprd03.prod.outlook.com (2a01:111:e400:526e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d283c4ca-d006-48d4-f874-08d60ccbcbf6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1574;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;3:Dt3GKAF0Vm19dsz+NkFK3JWNCCaUQEpMUdCZwA0eKmzmAO/88Kaesdi+pnt4lFpD1GjU3kDt+ejoIlPgH3BBq6SeU5DaR3xJ/AaM81UmkE9//PTpKFn9tfgrAFOdEAr2cbJOhcM9s+5e5V/cbVmyK07rW2NPpDmUEXU30uTbeGRFSLleOD0/QhkoeipnVkJI+2XvdDzOr2M725KMsNy0RpjDDQKxlo10l9Qf2LsFhApRHAhmmepz+9rGw6/tS2K9;25:9lxI9ehjlBmSVPoffC0+eLDkRrufB1pPshl6jec+64cKkFuUnGttOUVLfWU3KzArPyU0HC4jSx+QoZhoLidlBfFI1IIBikVyHd3rZhY3TO/cX2qzf5ksIIH510sGCYE7QTB0Iqb3Cw/C9+OJEh3/tBYiaRSFjp7+3YKm0hEBnOTV+WdAigFR9q6uB00sPE/NFjGwZAWmwxdXgr8F61qpgAnYQhugHmV9J+5dYiua6sdmokNuo4WjZIMSBhgt6hpZf8J/5ahzgy7wWYLQd1hJHsGEdzuMoiHJ2mEoulh2pi9/bstg2/Kwe9J6xFpyUfgE+HEu6DCFf8utOXYpUXW5zA==;31:hqnVoWqR0FkxMXH+lwP6SsthWnm2UL41XjxpZr5oeETmYXc9BdhBUJb4gMD5lOO3rY5ExGZAM3zgWQvsgrucFYQWDaX2kZ/TS66LDWbSzyxmakU0ev1EkTs2qOi/Fx7TDkgoerXdzwrcG3O0otm649zf/N+l7sZ6JgiMJmOq5We6dVBCX1YSJusdYMqbMOupR8KDKuBRsOP7hkEbtxp3kukyGUBLMM18cYGdkQUpCcQ=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1574:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;20:mBuK4NMoWmgLwK1T5QYNQwcBcEu6GoMQ8pJPwKnqZvng5uw9KVGXWW6bhz+OvKeHeP1RdU6EytSOOLeAXJ1jm0nG5/bblD0tUnsUTECFqdgPc3kFhWgTVaKbeG8RrZS/ARlFSu7ODy7aEN3nAjrNFbNGCWNp5xYVzR+dD4acvRYREN+Oo5DesAON+yxXVuNcCJa6AHXc8woCm+3zB4LqcuhI3tiF8fVG3HxRvkwJFuiPW/rRuw3v76rYMW5mTNgeL8OlrJUgLsPMPsIxUawYtcwAcNMarVnTavIKIC0lBwGaKKWh4MQ5Rw4y6d4SBQg869QgbWNEVXTgMJ9rVc1kfjatSroRPrZZd4PATs9DhIkvybwxEG/szW1t5A3tLGzRLlJS4BWMJ/Y/h1SdjeJtAIgy1OwgtW1sgGoCRrC1GtXz8VjmREd0HbsIks5gDh90MfF+sfrpb4JTJYc7aiV4vJRSyDaVvAq/4I92uUcj3kGgnlHNsHy8QGcIwKIHCumu;4:r3d7kzKRoJb4Z85Qd+sg0Rfg8npHm2xQt/mYB6jFGQU6KSJWmheFmLhIhcTyxecTXvh8Eck1q9d6fbAoohLDwQpjjeEl4SUdFwEJwudB9PArFqxR2X3GQD08Wt6C/s2STUkQgDSAGcYitOtmSUKL78B09sF4zlcNTzbYuaJIYRF7ewxTNC1idTH4RNhDus883hsgTP8wzY7UksH8ydOvBS/i6ZJHBh677D61I2bSm32V8C4nDksI67jI24lPtiyl63apIJxqtbs00sI5NojFpg==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB1574DA931CEA70B38CA19F07ED0A0@BY2PR0301MB1574.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BY2PR0301MB1574;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1574;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(54906003)(25786009)(4326008)(16526019)(186003)(66066001)(72206003)(476003)(14444005)(86362001)(26005)(11346002)(6506007)(446003)(386003)(478600001)(956004)(5660300001)(81166006)(8676002)(97736004)(50226002)(8936002)(81156014)(486006)(47776003)(316002)(230700001)(1076002)(3846002)(105586002)(23726003)(7736002)(50466002)(68736007)(52116002)(106356001)(53936002)(33896004)(2906002)(76176011)(305945005)(7696005)(9686003)(110136005)(55016002)(6116002)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1574;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1574;23:7y0KM2oALmFHHJhfBFHd2Mb7zskJDZy+wFwb5HK?=
 =?us-ascii?Q?BZ/55anAaGpP/Ciu3tr7FYUwRlOdjO0eqXU5waP4F7h5B4taYtDjIi9/lJB8?=
 =?us-ascii?Q?E/LTzpaEfPCkBfpK8xgH64EN9pG8MKkppEAuVXVVDrNeOS0islDK0ErVFgDr?=
 =?us-ascii?Q?pgUNa8dtnhp5KZxEDU27WJd5TT0o0p0ckrukrvemRWzELGrPDv2NydxBMLyB?=
 =?us-ascii?Q?VTcRUCDrHb8QdVeiRl5oLyx88EtBgl0QFWT2VRuU+8cDMzMBR2UGsETTO5lq?=
 =?us-ascii?Q?ecKacJijKAFixlIgeqC1JH5la7EmQ12+1tit1taeKpYGsHggCeJQ8wUQ0fy9?=
 =?us-ascii?Q?d6tjB+5sfZYwXQFDWvs5ZxOs01sCgmmP3Dp0TrxiRzap2KCiq5IFdUXRwrcU?=
 =?us-ascii?Q?Rc/59xHIdNrGHgQGtb+gICPxmB0/bIH2bZWgziVCfOLan2q6iDH8s/JVzgwy?=
 =?us-ascii?Q?i6KsH9+et+JWJxaxSR9crkn923r70xephr4XXaEMib2aM4zxJFyc9+pe0Pe6?=
 =?us-ascii?Q?gzCXgub+HWV0RxgQSQmAzfP+DxZjN6yRgGMpSkZWGXpfztbsYXlsexwOlO++?=
 =?us-ascii?Q?tiuO3bX2j6V7cxm0gUetVOQqBX6a6SKmBfvyHe+aF5P3W6V/tzraTEMoY+7c?=
 =?us-ascii?Q?OIDYwHQd/ZaDLWiQYaieId0PdjzbDimoZ7rLnB7rQ/ovTVTi5fdYmooekNWh?=
 =?us-ascii?Q?5q469EbVq1BEF4AP7kMWWAB9nARvsijR6vaGv2Ko7F2QoxtqfXzb3N+HXESD?=
 =?us-ascii?Q?Lh30YOt/huWkwU07lnxtyjfwrjFqcT9qyAC5cSg5CMezE/LtjzmF+UAurq0K?=
 =?us-ascii?Q?W5uYVCY8881IL9v0I/LakxtZYnlRy3Re1PDb1AmP5l0+he51Ru0gJCqMG2UP?=
 =?us-ascii?Q?u5uZc5HA1xPrnoUC0ZTX6Z6xQg6GXKkGR+bhoBy7FeAeZGJg5jkQfkO7uldu?=
 =?us-ascii?Q?rvi2iRreK6xlNeA3c6BSDG2uPwToWFWxOXC3aVrJNm/tjhJTh2OeIb9BOc9y?=
 =?us-ascii?Q?So71puVPook+cnf/SS6XjeTZO8sCvMdiBhD3jKtjPq4J08L0Nk4J7lvJ2SMx?=
 =?us-ascii?Q?cIz50EzDJwQrAvyqCrRCbFkswq6Wp+IWtMX+ZS4S0jPl+92Wxp6S97h4EQxv?=
 =?us-ascii?Q?JOAyOoBwuq6gwtIM08lfjL553UmPAjyO13Nb3Q1AEecyxWA6GF9B0AjEOEQ/?=
 =?us-ascii?Q?+wiBVO8YzZGCFhNCTLYNBIrFd0oTf64Bl1BoW87Nk5cBTGXQvNs2fc8YueuW?=
 =?us-ascii?Q?11am6hUgqcmVEEm2xmTkzjVH9F3mUoXOWOmavBweu?=
X-Microsoft-Antispam-Message-Info: maEKreeX3ReNoIGTo4Dk0Hwfpwyx6wsd3WgofZQ/XW3QwwWyi5zMWBeHpWCGxxbIrpaAyPtXUD33rIFym4f1HU4JiGhF4prw1IPw114zIpuEDq3tY2UTITf+Dga2fhANGGYI7Xpj+asSEfSWeSfeWvb9txUEjxQ4PbHGYJ7v0rsfT5sXs4DYf9RRWurpxmTPdSOkFn+xCHfOopVwS7HvSVBNw5/tJB+5sLSDJm4RVH8qlWqYc9XuqKu7zjQ7PNRwWUtRXn6ly32gvLiJ7kNFyomnoi2kLl5HwCVdW9SLLlcKXr8Qe0wmBzfGUxe1W6MrVO8vKXHIjKyoBi1OTIaRGHWxVlzp6254///njI7C1FM=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;6:uDnoKG/BUmx7zdvy8tzNsKO8H4q6NkDtjs+nshagrVqoe5We2SP+5+s6j/vXqtMGUJCufZdbcU0DcD5oOnewZUPb+5epuytHgw7vV+FEAD3jiNo/2KAl3y8OBjAtzUKIVgyal5tdUkX7oS+BAXa8fZ6FfrCkvMLkh6Jwe3fNzw+Tb2aVwjHMh6JCrCBirC+WMwZ9uuWcD/rgrTNRa1JgFa5nvnloaH2JRiODqzbg1iSS1MnCMKzY42ES78XY6z6hkBnqpQr7S9C632nDLcJTghCJ9jdF3f3EacZNMBeOJbHPYG9TI+wrDbrs8yssObg9BJquMaunoWrJfsej8rADKl+7ft2JYbdCLCr5us9Beyi5oIgZWVsuQAu1D8aKGQy5/6to31VoqQYtuMeZrGkMtQ+0pnjo8y7C5iN/nL/89Pthx4HZeCdDgL+LiUKZ0H/AgvSv0qL3Tl/cr28agt60Sw==;5:o2kUE8YeCPv15/L8srQWMkV7DkVVu6X26E4tEU/fgn66u1fi8t7SXr6wgDCFXPbdeM6S9KHGf5wNvjjE62Iu8PzG60+xp+hEwYgZpkgPa8GiMiQVtgsjZPUfMVL4ve7uq6c1Yo/SBVIY8uK1LRtzPhhhm58jzkn4gbIiUteW/uo=;7:PG7uOMx4BPcBK7yNL1a3vMIQZNarf3ekfdUzkeeGxpSlmz40R1yPkRO66OQB3305pP1t+LCSJc0aWS5uoyOLhFTAkKKyNKBRepdJ2SzkQs6+5+XzQagnEj8P1ZX7kuHqDEdaRGMwosoAEdUkWuuLi6JBXIxiGOThQOIp4nm+V4HLr5mN0UHYSx0Vkd23cRDQRz3y1eekz+7EQ9g+XYvu7sza9uqcVz+vKnn9JEGj4pWjdy7OuwR3u2ZTZbMB7LRo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:51:14.5947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d283c4ca-d006-48d4-f874-08d60ccbcbf6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1574
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
index 1b7cd144fb01..a5137845a1c7 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,21 +8,51 @@
  */
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
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
+ * so that each DMA transfer doesn't exceed the boundary.
+ */
+static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
+				    dma_addr_t addr, int len, unsigned int cmd)
+{
+	int tmplen, offset;
+
+	if (likely(!len || BOUNDARY_OK(addr, len))) {
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
+		return;
+	}
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
@@ -36,12 +66,21 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	struct sdhci_host *host;
 	struct dwcmshc_priv *priv;
 	int err;
+	u32 extra;
 
 	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
 				sizeof(struct dwcmshc_priv));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	/*
+	 * extra adma table cnt for cross 128M boundary handling.
+	 */
+	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
+	if (extra > SDHCI_MAX_SEGS)
+		extra = SDHCI_MAX_SEGS;
+	host->adma_table_cnt += extra;
+
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-- 
2.18.0

