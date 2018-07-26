Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35F32083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XVnEikei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35F32083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeGZIcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:32:13 -0400
Received: from mail-eopbgr680047.outbound.protection.outlook.com ([40.107.68.47]:2560
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeGZIcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlRP5G2TG801QspAVoCKXLH6MnxPvuZHUwgGBnLxYX4=;
 b=XVnEikeiFVfziyuCWPtXtwESNiTYjGexCI56KxZPT/zXp9e+cBPe2Up1eHuBM2Bnb8Hci9ZPvCGRh9dzVCfjS6mqL6knQw1asDSOMxtI217XSX+q2NqkTHTTg7yFOr7jKv0a95IfaI8ZA2EYEoI/smeQfHZb+CEI5WMV/wB/RlI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1574.namprd03.prod.outlook.com (2a01:111:e400:526e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 26 Jul
 2018 07:16:39 +0000
Date:   Thu, 26 Jul 2018 15:14:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Message-ID: <20180726151424.4bcecf41@xhacker.debian>
In-Reply-To: <20180726151017.4da1e336@xhacker.debian>
References: <20180726151017.4da1e336@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To BY2PR0301MB1574.namprd03.prod.outlook.com
 (2a01:111:e400:526e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c619941a-95fb-4468-01f4-08d5f2c7bbf0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1574;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;3:uR8qndBRM+bi+i2EJyzGifOhGY6koOzxZ/tHarlaJ1LPtj/2JShl2S451c1O3OdkzYymO4YQPK6btNZwr5UxxWOAqF2IiFmjUJ07DJ4HGCFIkstK43WsZx6YIrCSjRuQB1IdNRG2TQa8t/+C2+a249HoqO5PQGLnPyFXMG2A/HCdx4xAQEyALKCbJ4JmOF43etEq7fP9YtyIZH9gZRKXB52TA/LRNkgOvHpceTlAyKf4Mx9bYpEl9VCAucxwam97;25:2nvV1opx0VXHihR5Arl+3ZvJi69TJkuryw17CNY1ltU/7YDjHwGtCU18HKvd0yHzwhWmHq2B70J8VB5hyAOhRB5w8qCOIGAzTwVfweUMzi52NrGf+7pI2FY8Sak3fgeCv9/yqySr03NNlkwR70e3m7sAJYyVQbwropDHkTYUPPoe8m2h9OzpfrwspGOfy1z9fIRUDCD0XhxKx29wlH0PgbWE8zIP0gGFhQza8zDjmpsWfenO0KTx74rbqLnDRCYXlJxduXhdnxZpFuS/KYCzt6RZnksi5RDT8v+SZKTBF/i/1JvVjfED5JxNFg0gGGW85o3ivHyOTOuPZONEn3E1Bg==;31:+rdDvWb+TF/3l0YXzBDjFXSSC+0hIEe1Kv1O7sLUjuH4pXUCPo3toSxAK4/QkSWIH6esWWoVhita1A5nXOBWirxjAX1fg8IX2UFXs5/huVmt0bjHg76LKyz+6kM3GNf7RGan+KGQjL9ofo9zYKmoI3db/aJsS4izf6XZGeg2fJaZYHNyF1XKby7P8S7vwvO9+5IlGMKkw5gJwRZsrcY6cgMgCvTm5+4o17hphGgDB/c=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1574:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;20:+tpipn4HMKBTnRfqV0W+sO95QSH4CPTwaBmR9beC9NW715VNkcVaCzRacCkfZnhtu0C0eu2gec0aqK+q33f7Rg0qOOZEvDUdcHAtwauEedXprmlfjueA+FGxxWOzLAs5/1L7VTM51HwVGZkQMU0LbVTkxz7r5ijMWFzIwCzAC/tjoN1tMyHu8vlGX4Jt7cOXJYPZi7GFb8W4ZHcmA3RxhEBwnP/ShwrHH4r9SCqlxpVd2sJ+aWoKcUc/FZl+m1DT3u2kQCVfQyRqFT151DhWAvsv8aDPI8LtKv9Pv9lj5MPngjOK/raS/aPH2pgftPN2qDCdfYTVrw5aHNqX4tIhQaE7TqaMNoX1lVLt3mntH65bdPj8NNJOa0zmMrpgdm6yDtTsMtVAPevZ1THU7wZUAD0wlZC/Zmr2GNNcyulTZBOLgTuP7J36iHtNLw0qxjCZ+KccRjQK38sCQzEkSPxNC1UsHE9ocdrVdXY9X/UOUhP324/QKOPIh1WHpDfRY+iE;4:ALrTVKjXITrc57BDaS+x/zb4gOzNEjFjmYjIC4IWo18wCDoriTQXROrV73ggM5R8ZKuwhtKwjFdWZGdnNY4InedZfdYHXu8NsUsZ4O5S2/N0VPW/wa9fuStKr1p4+Jbcvf2+q8+OJXlaQ9iDMBhwPDeGs0/gqC1YkIbkT6uFk9r5psLCsKWz7UuCJsWOjuWUhVxlvM3RMVHHIM1sUvwBQEGyVKRnZ9FL43DZVM3FiaaJMa6euSfmwy89UBGZ3J5aacgQi62l3JI5U4jWeDae+w==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157461DC72EB15E189C07D4CED2B0@BY2PR0301MB1574.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR0301MB1574;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1574;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(25786009)(52116002)(6116002)(66066001)(72206003)(230700001)(106356001)(5660300001)(68736007)(4326008)(305945005)(53936002)(478600001)(105586002)(6666003)(7736002)(7696005)(76176011)(6506007)(47776003)(55016002)(33896004)(8676002)(2906002)(16526019)(26005)(81166006)(8936002)(14444005)(81156014)(186003)(86362001)(97736004)(3846002)(446003)(486006)(50226002)(11346002)(9686003)(1076002)(50466002)(956004)(23726003)(476003)(316002)(110136005)(386003)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1574;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1574;23:3J4QlBVxEyq5I9GzVUDZOUZv4R3ly4dgeSooYOV?=
 =?us-ascii?Q?wH2gxeqUeLQUeWnA32k+XxmNtZPm4lvo9F3+gqLatvYyUmMr/asa7UCZ4iO7?=
 =?us-ascii?Q?JxyrnziDN5qAvL8437cKfByDznCooDJaboRi5IMdRpqoI9nYi79Yjx2rD7eX?=
 =?us-ascii?Q?xZPvSXh5C5qrj0jvBE8UTwRCD9455Z/rnj7IyrE4OPOjFLcGDcfOLaZrxjQQ?=
 =?us-ascii?Q?IpLOQNrNEk4RpEbnN7ayH73jGhAgI4/PIKNpDo0ud3scPt/sBC2lIDtt/Ibb?=
 =?us-ascii?Q?5HNDW2aDx2NTeVQCXpYbVlWW+BC8R21vZVJ8YpfyatOT4RE5BqWnWGFpOike?=
 =?us-ascii?Q?ZbhQ3o/XjPJtdt/cWrEXX4ygOAXqZOi2eeuqFDPqwRoX4SzXOtYdkIlAOQS0?=
 =?us-ascii?Q?XzCkKc6BHCODspS9BgYBYZNZC3WEhA7kV/O4zIQzg3ORid4N5e0uEAr2GuGO?=
 =?us-ascii?Q?dLoJ6Iks3cOlcQYnGi/mCKeRjNMXY6cvUruVeJukDsDvqT7WhkkSO0DTQ78P?=
 =?us-ascii?Q?BtdOqL0pn3Q/dw+y8Zbk9WAjOgRV5jxQGVmNHcaHNlBSGgEpf8Nh/pxFCYiw?=
 =?us-ascii?Q?msU1Dbp6hOKIoE2S5+qgJIceCv2jHEDnViZBi1dVgPQl41s7tqs13BOgHRgS?=
 =?us-ascii?Q?xAt6WXA46mW1yxyT7htoJ3vGKDuLbw8AWN+g4CZrqqhrULqnhGZ+f01Pk3Ep?=
 =?us-ascii?Q?5wXe5nG0f8KxACM3753lz1v5Ger77h/+/7GlVGAgaDUjons14muUSIlP8Gzc?=
 =?us-ascii?Q?t/TFjwShdE6GIxbCjAwYgaA1OtYI8BTCd35tvFmk8Snny+Hm3O2eVzpR7iri?=
 =?us-ascii?Q?jSmfVPi06FgA1INL/E6TQBfYY/L1V95Ux5un6lINkeXPPvDUts9Ti7OUXV80?=
 =?us-ascii?Q?6P/ERZtK3knV/Y/qiRHS8x1S+BUDg3IgKSEUxUcPrUXadi+gMFZWfB8+1CRv?=
 =?us-ascii?Q?HyIstz+rrP2tYzFmJPBP0wPvXCF1hL0u2G6j9fkR8mZWnGQQSF4v/stRMjvQ?=
 =?us-ascii?Q?tUOwLeIwZPRN7J9izQFFC+wKyTRDgpzcFnvlfT8T9mZIqc5BJJ3/r/HTAb6V?=
 =?us-ascii?Q?8KPfLm2vIxWsKjf64k3LG0i4WiRf3ptID/URsLdo0W3H4BSSxygqHHpoGS3K?=
 =?us-ascii?Q?qoS6Es9qpzIdgqEzoeS+3DV7IA13ao7q9baeZ/GgIwCyMMAuHHhtneto5Iav?=
 =?us-ascii?Q?y5uFHlAXJ5RdAsfv3eN9HRJniUG/oeM0uzMwouxl7dyCZ+cnnfKsu8BCYcp7?=
 =?us-ascii?Q?cZ+8+z/rIrwDItuMmIKvqyhxKrt5kb0bSOk7EapyX?=
X-Microsoft-Antispam-Message-Info: PAwakeKCcrxWwe2hW2fXqVo9GDZi5xxaTx0iouS+LWIMfcqgrCeYHzX1xri6MbCVYPiU9UBvOgr9g3RFoIKFflb7rHVMAEVo7YnMtzM2mBTGrrkfSBLMVwDrFrBNmW6rgXPQM8OuC5AZrpvKf6T80cOm8H+SVFDnmntdFP/RLOGlXeXcf0ahl4BK+6Jl3APFv0ic6BFq6Wc8t+rQo2PMpPVuLPXzud7yAZ0URNoKHT/peYaBuvm6N/kfLjgblJ1sb43KmiH72X+wHq4VRLhaRqLXajP9uTqJo90TsWTq6gbUsFEJgLhniziBNq/kaKvrq4qDj3tnUWsd9X3V6oXJ6gWBQVRxws+TO2ymPQqD/o4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1574;6:jYmcM5nd1otPGAHY16in0qb3rBPDcllb5U2HXy9j73HeG19mn9WGNochBNDs0rdesg/ueRi7MlAovzoYv9+dCNHsrZErCJxfYr2FRRzzz4GVN7o2E9H06zpWLQqvzSMm/g29ZOJeYzdJKmz800QZknwCKqs3StSDZMwnjYyx/Ar1CQO/Zx7l/XiNWqrj93o1af1OmSR9BVSV8FDQMnySjykPxXBK1soX/+5FItN2Ykf8VTTbAML0m8tkyzQdNY8CnwS20o699SUUuPJv9BrgDtvvv7Qkf2NXccBy9qc8SZttQyUWz0kR6diG1MTvO96OjpPAU22GRrBiJVBptaUj2e1jhPik4E/LrHfUpCZx2mDV4peG4pceY2JrBZ82ocKwbvvsJeROy3H1N+2uT9kETxnUo4/rtAnIMiTsvljubM0JYbVCdlXbFDohj4B0d6heczip2y7YWM8Pme/fRmbtXQ==;5:fpoeHsfOv2rk26h4mdzFtHQJRBfnZQ6wRySlMnWzTpKMdYvlo4OKH4/5LqRh/iAQ8QDSl2kFbmDfn+PqwtOT2fPAOEGR8QwoZ6eBanK9R2XEyq7kWRELmgbWpIcsaeFK3zRpNPRnpCd7oH8zW/WC4Q3FSC6Qo87bZJ6zfRDG56c=;7:MYnh/ASPRsEmkNY4KRl+sHPF3opbknqOB6MVqRNOn3IvSMOBHfXsgYOjg69dQw2L17x0n7gcdaQ+RZdbmzKBApChKhneL55H43CTJ4Kgh37UwLa5wxJmfw9Fm5tV/z0cd53gI/af0/ZN8HbT+z1kdNl2lkX07kr9+mt2sONlwtxCc5eFHgPxSmUknjzf2HB3hyTSOQJ7yIidb9qg0vX95NYqFaCwLTbsqahY3in4/xvaG7icFcK2grco8QtsvpLo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 07:16:39.4814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c619941a-95fb-4468-01f4-08d5f2c7bbf0
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1b7cd144fb01..7e189514bc83 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,21 +8,51 @@
  */
 
 #include <linux/clk.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
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
+	if (BOUNDARY_OK(addr, len) || !len)
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
@@ -36,12 +66,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
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

