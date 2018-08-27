Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F84B208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="p7+2+IIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F84B208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeH0MNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:13:02 -0400
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:26496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbeH0MNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9RRjbOvBHjb8Mm5unulNA3GXdei0drLuVJUXzZw4R4=;
 b=p7+2+IIjN/xaJIbEyB7/s5fEDFCBQMPY9DfDobiODs1bEcXwfGaOAAuMHW/pIzh+xP6Kpv5x4MQWxcqMCd+yTkdp2qXHnsqj02kqVoTTV0JpAX4I+qw7dpdy80Sw1phjw67/qsHR4eLOsciH45Y9rmY+0WledEPRAuML/V5AcWE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1580.namprd03.prod.outlook.com (2a01:111:e400:529c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Mon, 27 Aug
 2018 08:27:18 +0000
Date:   Mon, 27 Aug 2018 16:24:19 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Message-ID: <20180827162419.61afe238@xhacker.debian>
In-Reply-To: <20180827162026.3901de27@xhacker.debian>
References: <20180827162026.3901de27@xhacker.debian>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0185.jpnprd01.prod.outlook.com (2603:1096:403::15)
 To CY1PR0301MB1580.namprd03.prod.outlook.com (2a01:111:e400:529c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da08f8f-342c-4e77-ac78-08d60bf6e7c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1580;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;3:OQLlM4zE4bsPMkNCHJSlksYe0nPAl2tm4O0N3nAluJeRqkHTTD984FGYLQR5Xpht3cSa0+yy8YVw+PjPQnGV8Zzww4Iz5jMs15QLuRXAVGdKQMl5vBo3Wcbn0O5EdrUMGH6dTS8tT3/uLg9o5FKzG4a8G025l5QJIowh8rVXFAUMHnaemsLHXqT57s8vLJ5V7HFPOUhwG4973cEHaM2miJQS6YlaTRunkQWtPb3xA40gTTiwFi0iw402gOQ/FmmT;25:oGXd4NEqEaFMo3dplCPTDplmHLcYYW+Ne7YF94rf8IwP/Amw4zKDtL7IbRKMXG5NErkvHJtmoro3axEP0SVa+pkUdZ4KMdSFo9WAJFjiTWaQIWdKE7FhUThhAx8jAElYRc7CzLRb9Qm3i/9o3viua1XUaRuJtiQauyjcN+d/mMas6RxBFeQQppAAijw4O/+5HCVNpLY/vlfFEa9c6PppRj5DYlvSI1bjDB3yP303NV2hdF4XiA07ZcZjZSZn9KvK7c6ARSIl9LdcZBshHDDJSye2Qdf3cRvBSwNSckgnwAMpONqqbeaZNttfHuIiO0BO3kof1nfoADdWPnZ07Dsa6Q==;31:S0Ms9aNFbHterslk+6K+M40FRTWBddwErJnAyEeYh4059ivJO2MQ1BIIueh+KFAy1OD/ZR6I+tXYiyehF7AONbc+M5YT9x8CBE2TYP/H0givvi6gqRph4bVO5YiqcO2pSC2sUgwy5EGXSuhN5GNA7fXCkGQcqW3l7WTh33/Bw32XtoUt1N1yjb4lk8l4iayU+slCqT2U1cJ6ghKgGlrL9bHenrzs+oBUV3sD/qMwtuI=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1580:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;20:yqGof6uqJZcK4t65TwBYcOcumHPqx8bsJRExsZy8rwOpDdK5vFDXQIaEzXYCslomc9VzIpPS4Q8UPbGNTu8usFBZicimdEOtxlnYMWXFOe81/cMW8sryJOUxpGjI9N0SXvg2X21st46GTEpe9ktcpoPzRsmfPA1KM4cAS/dZR3QQ6qKYtPHRNbPxRcfRAawAwnHqfC0OdZkHjko9fsdC7DacZ1zjrdzZREGU42g+YW353SuVjeYZ5ZQheqku2Q0bKK9hQ2aNxTcwyMnu1kx5jLDud1X8QdhUiHhvhpXVTj1vaBA9Cabea/cJ2tWxZAMMLmN5iYH6JfgdINf3qEryyfcQ5TBQ4Rb1eaHn2y2mRO8qR1hJGwT/m2j4yhbVroOxCs5xG2nlGfVFzDWpAO4ycffnQ16pyD0F1+p/oAkvPkx1WyKN404n0kPrZOFKxLFKN+ojDsVTsYq/A+VVl/WIWXIp9fx72o2bGgLDSXWP9+8NqdSwXjBwuf0IH/QXBxEb;4:2YfO3l9s6U/gql6+rNcdoEHo1SOjt0luz8NSL75psTMKmHDpGyuKDZm23qT2IMvUOiaObNNaFsgI3YRfF9v9HgUtLn/MtYUYJFVbOAs53LNEuI5OHwlquEAmwppwS7E6Ji4Z6Y6tCc7Rni0yW88m34uPgFhgqNwkGBRYn5UdiXC5ECTMkz7C/VUuU5Afgn/HwkrTQhZz4oWXPgbqhFPE8+mwjj4MSFTCEr7jIRhfptPUzTqalcTtbk9iGK5JdEVlTFAPlg3ev+ccWjqvh75/qg==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB1580968713A5065C2562EFF4ED0B0@CY1PR0301MB1580.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY1PR0301MB1580;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1580;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(39850400004)(396003)(199004)(189003)(2906002)(6506007)(446003)(14444005)(66066001)(50226002)(8676002)(8936002)(86362001)(11346002)(72206003)(478600001)(68736007)(386003)(47776003)(26005)(476003)(316002)(54906003)(110136005)(53936002)(186003)(76176011)(1076002)(81166006)(81156014)(55016002)(9686003)(486006)(16526019)(97736004)(106356001)(5660300001)(230700001)(105586002)(3846002)(7736002)(33896004)(6116002)(25786009)(50466002)(4326008)(305945005)(23726003)(7696005)(956004)(52116002)(133343001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1580;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1580;23:cKU/3ACjFHLdOqzFLY1c0xXQK9STfYvt5gk1VKt?=
 =?us-ascii?Q?uzXJUfZxVqIaXR0q03GDo3b/vWY5XAytHFZkRMN3H2s9Jx3Cu8I5auWhvXi2?=
 =?us-ascii?Q?tS2p1fyu9I0HKT3VglK7UcNou+/baSY778xkIyP9fLT40lcga8WaJK0OSgW5?=
 =?us-ascii?Q?Ln1abIgaoGXUZ3CNMW+Om3UtDLwmvU31cr+er2vgHJwkPBh9g4m62+c1q01W?=
 =?us-ascii?Q?HgtsWNSAmXvpFWmuBj0RWC+UGyKC3S/iM1iKO8jMMg5lRI9t+Vme+L7m4IMh?=
 =?us-ascii?Q?uMj4qIdCNpSjzZilaqvqkhYBkC3vhFHZCJejw0wB3VnClppli86HNfqQEZFp?=
 =?us-ascii?Q?XXo+ZewHr37IVYA3TXVSUT6cHwO7uglpF+ic7Vwx6+/3FcJWOFNM4yNgaoVp?=
 =?us-ascii?Q?JAMYqOgfxO2hbhugs3Yxo6uolTnJrMV3l5ZmAZ4O4QfhSUjynnh+I3VHOdzS?=
 =?us-ascii?Q?ghbtXUMHZ1p1fPqoAURWIU+Vi+SXf1PZ/NJiHoE5FdJGg+deGl9EW5stX8UM?=
 =?us-ascii?Q?E2+C2L/lPmybGMkCQ+wX6mLhcIaJEu8QvB91ElaNa5vhzX+O4g+If1Pn7ol9?=
 =?us-ascii?Q?XG7D+OiVcvtqgmy9dUZ+dct9jwnYcCmdTAN54WEt4ApEdTXlQDY7+ZZA851o?=
 =?us-ascii?Q?gOWvjdX00tAohF8DSxNIooWJNqo+LAekTaB0nqSuj30ndY1z+a0+RO1AzjF3?=
 =?us-ascii?Q?DaS/1TY+uGxWN+WYN3gzwJHXKH2midz28ePP+WQzx+3gRlzKMdMGhpCzW2Mp?=
 =?us-ascii?Q?GYfTZizpm6+4ijHs+vh/UTqZxJN43OWyZVFWKmqvsYqf+Q0Y2PNkA/Ip24jx?=
 =?us-ascii?Q?c/7wyUzm5F9xZxHxC10jP7YdHsVX3ydY+2kVjhGkQakWAlpfXCGoTEPAPaK2?=
 =?us-ascii?Q?u3pyPPPNA5n4XLqk2IN36KpkeFg5hQox2sYC8p4XUEqKJazS/kZbRllHPFRZ?=
 =?us-ascii?Q?QSymYjpM2VIdboWRJ5VkvxgjhEN951g4SKV3ZWbS9vrt5vR7zUeP2mYquht4?=
 =?us-ascii?Q?YUN7sPiRa78nsGY+OENUT2X0OjXYx+/OWMbZvump7CD4Emjlg91c/upbrY7M?=
 =?us-ascii?Q?IPmqKLeiwKlG5YDrEyoT/htwAMPuk5V2Ai3H9Zf4LUxjxIi+4wo63/L5BZ5e?=
 =?us-ascii?Q?SPQ/QjOp0HXfQU3IYzTpMMezVF9CSIVCLhREWENeTd00+oehq87UgzPHBvSc?=
 =?us-ascii?Q?15Aq7aTZcXniEkSQYBbNWCxNy7g2x2Mp3hUdzk5CYvYrHpaW1PijfV6ZtHEI?=
 =?us-ascii?Q?+Am5Z+KmhtiS8CUdjJujiLRM2vs14RM2EsuQPPFLo?=
X-Microsoft-Antispam-Message-Info: WAsi4u/tMiOvhqL2idAkuUkcOtLAweLNrZJHcbzCc1YKxfcUyNxEN2LIazeyvPg5xkAKr+IFpPRia6ILPWXWtlWgAdHLzZRIpAL2lD0Sezu4j78/Pynj/o1sqgNIcga/82x/YsFm0OCrCbERT5/ecKNqw1oSTJGsUykaUTvunjZAzjaQjmOeadsiMYXYk59DqqoGFVMs+4Lo4LxQe6BxvKZ5dTi+ttdxra3BpyWT32yRJk43XMWvQpr8uMi5gxx0Ed8zVl9PkNd3iGRzZBESzw46wOl1e1iKW1dX7gRgBErr+l0yWHtky+sRvhb3S30QuxXQr2OFMPDFwqbrnd8tjIh+BZ9J1BoCHCz0AfQp6+k=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;6:Tj/Tz7GBZYHsxDPr57meWiU3HC7IkJb+aNx11JbiU1Byirkhvnp7hBv/ii7j+31+XsGH0b/WjlQw0xdf9TOrW+I+dyQK0kbJ1JBewLjETKsmN7HKWbyHiIn7BYG4MPZ/AD7DViS8q0JZIfobo2d+aJz9kNC1pIcqjyHijc9KvzV3rYkAzmIpmyhpBjOTyRK4+Oml6/nCJwkejJa/ESyN+vWnFdYNHRqUR0BoutPYRm0e3DdCNT/87HwS4DuGTOMtVpZJd/RppfVIxcXwlOlMKiTn/xcCUE8jVaUDUlEtgaauAf8CpP4tQR7MB+nqk2zqrN5a/myuuVDpBS+N4GB7wvC8E98UOM53Z1FQqIDwB0SvKrsx+rcJbVuDG7EMbWZJHZ34wzJXJzAmCVC3uWJvOm9214fGwGEha2jCH5sTH9n+jbraMwrQ2Yp2RHoGGlKDoDp+JxxccBiwzqE4TW30YA==;5:Ew8p1sRQa+ak9mJAo3Lz3vuA2sd5xKZvbxbQrJMetsf8VRzWkCZUx7lxrXgHF5DpxrkedUlNrq4bjg8uQKrGoQvxjq18MOHlrB4dG3JskUae8DpaA9vSOy3Ihnar4bCFMWC2zu+orMRh0H5e+liFJ/lWq1mvLcywXWpwvOZJd/Q=;7:ISH74r7aQBqIgmdjxydA00BP0GWXRM+yIODyqIBpQlsUNGI5twdq9mzd+UVr+escejvg/jvsjacEo97eQlWBw51sxBOyQAOqcqUgIOXRjMI/aq/4XYiAjdNbkO6MSdaBSUCg8yQQH5tKurKNxhM8spyYrrzuPd70sY6NEL/3odQDgs76OoahWpNQptoTYaIkEvkp6VSEfGGrgr0L8NxvcznSWebE6EBUPKF/nGU5JO7wXpjmBucd4SpbIOQ5rprA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 08:27:18.3242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da08f8f-342c-4e77-ac78-08d60bf6e7c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1b7cd144fb01..cfbdae8703a1 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -8,21 +8,50 @@
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
@@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
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
+	host->adma_table_cnt += extra;
+
 	pltfm_host = sdhci_priv(host);
 	priv = sdhci_pltfm_priv(pltfm_host);
 
-- 
2.18.0

