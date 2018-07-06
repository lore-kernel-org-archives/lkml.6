Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F723223DD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="SglTMl0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F723223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeGFHZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:25:54 -0400
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:64464
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753310AbeGFHZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LixZ4RCINWnhx2+OHcSYA3h/T+RK/u7OyPqaQ+9EbU=;
 b=SglTMl0j+nXDPNYZpIS5nTBtuUhi3e+vSOrpcqq7tH/6p+azy6C54UiA+dfd5dMjw2/j0h36IrRggQ1meDifeXe2Ufiol0xku6LM7DAngVZuUiLliPJ9boU6eQ9xcxr++lS0Df9dgqiHi2vdIX2bfvh9H/Y8NwPfpfgXJ3lOHEo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Fri, 6 Jul 2018 07:25:45 +0000
Date:   Fri, 6 Jul 2018 15:23:55 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Manjunath M B <Manjunath.MB@synopsys.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC
 MSHC driver
Message-ID: <20180706152355.442433b1@xhacker.debian>
In-Reply-To: <20180706151930.78b3024b@xhacker.debian>
References: <20180706151930.78b3024b@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0163.jpnprd01.prod.outlook.com (2603:1096:402::15)
 To CY4PR03MB2632.namprd03.prod.outlook.com (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a800113-7b59-44c5-5a1a-08d5e311b1ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:nbqHC1Mlfqcu8OLzQdpinpwbH7CUh/6CaR+9vPUm6vT4AzgafqgCGQD9jkyOW1+m5wZJfJrj99MXSZaLYlmllTBa8nq/niweEdvBYpzsuHdQIDjr6yrbKAFxVtr2aDCSCx91hlHcmKUnX/b05A2XuU6VY6JzORcBIlMEnr2rX2fpi/wWp6Bavj3zhCjZWppZ9Na/gCLYJvOKwRWwIyjWaKtACHdShOVS8lEkigghJV6UOUw2gMDzgLHJ+xjGf57k;25:0loWQ7/tpjvPlKy18SrR58R/91oAR+69AR6wjtAaoca6XnX35iEaYRijZhcYcQxuk0sQSOpsiJLgPL7AlXRMV/9NM1n9edNPhc4RC3FuWI6280FKSDMPucPllNj2dJ6+sIrcd8mIFXeSSsTMmvMGeSN/7SR41PYMyhlAonJvknp8NMIAYww27dBT8dcGDqEG47ukQROAZKGbCxk2T3pGs4JD8mjhK4hZ2n4ybka7poJyo1oenZ7X3K/VnnzJvrV3owCU4pE6jm2mGx3wnAk+GzZYoZ4aXB28Z4HHfFNZ41nmdSnnlbeYU7//WZBV8AHU1EVUBw2Q+v2q6YPXKLgDWw==;31:ZO8l8lM9JR1Tn7BSteiGiMwFy3eVJWSIeDZ3mfNAV37ffj54PK2H862yopR8Xu2AClls7DVWnYmVJ/2kXlmGCPr6OFR27BBuXUilnUaTbSkJkhbrv7u05XGqY+tqcKM3eoXGqZ4o8SXeVnAx7zZ7xl32JUsQURu48ddpXwUYFRJqoqWzxAUzEsELGS7iudI+ipORTLB9Rw1TSAEr/dAQE9/L0bhyz0zoyiaMrzHhsq8=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:SnSrJVz3BPm/VajYr9HT491yXh0psDI93MvnoIvVGGJ0XohNQgc5m+wDmG63aDL5zG2U4NYAh5N6RnWTO5AY/dAzYPINGZlCzMuxykzQAk76iZaLEEhlTbd4eit6oGza6gvdVs+pPPTQmhHmxDnYzZssnUIdO1PGjAG+7ApFUdL3qXrJFQqc+HHGXtuMbYcvaJqjDWrxuHKDixo1plVC7RpQbuhvApSeb4yniKe6W57A8o5EXAS2v6x4KznjaUEMDyaHb9FWhn1eGvpGxDccxHzBwPMy7qO0iBMr5ckDS2ktuhdOdL/lNQ54srD2BmwdwchNv3IP76OOas8lwWriMZd+C785ylgDxmetvjxOVVf/ckbquBWMVXsp5UlDeyd93McOyj/v3ib2FZXsGvfDvGXnIAsGDDMrdG224JmfdjxkAjqPjce/wBqwILGeiIT6A5L6U8tPnPWfBrI+Tc8o20CNv1S3rSyYJe9Ewbd1k4c7nVfXg8xkMm/+f+OzGmSX;4:h9DHF/OhHw0OFvjSu+IncmF4pFrBrqJGIbbrY+tt0GIl1Rd16FLm7qSQcwC6kQOUxg/rNsh5dtEySmcGEcGhqrv2jZidfCZUoOAX0+S83bjX7VqZFnVkQDNvsAo2JeuKh6lhJ3Ro2f6NcQAEfMNvWO6tMrE+RlShWf9vr0skKkY2hkRLDZshOqkiWPExCHK8xRC8FFFU7ha+HCTBmNdFYE6xWnei3U8Qsd7raUpqzMU5vvsNXOgBaOzt7o0hbhfnXAj9tEMiI2JljYjnBCyJ3w==
X-Microsoft-Antispam-PRVS: <CY4PR03MB2632F785ADB37E634729D73FED470@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(446003)(50226002)(68736007)(86362001)(81166006)(11346002)(81156014)(8676002)(5660300001)(47776003)(8936002)(72206003)(7736002)(7416002)(305945005)(478600001)(6666003)(14444005)(486006)(476003)(956004)(55016002)(66066001)(9686003)(4326008)(25786009)(106356001)(1076002)(230700001)(2906002)(53936002)(16526019)(23726003)(3846002)(50466002)(186003)(6116002)(97736004)(6506007)(386003)(316002)(26005)(110136005)(54906003)(52116002)(7696005)(76176011)(33896004)(105586002)(133343001)(217873001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:8QSCYBYm85D++iCAIyz90pZsnerJ/gbZNN8UCsSgQ?=
 =?us-ascii?Q?t4zoFANtpF+02cizpP5GBj05fkG2jQcz5WZM9Cn1JhKRsZtD0luXBe61Qwxr?=
 =?us-ascii?Q?Dbj5c7ddt41qm9pUrEbOt4WBPVFu8KU+XXY+SUVtPxk/qFR+wtpGkJnukP1Y?=
 =?us-ascii?Q?93kgB7q+up1h4mcU2yCBqnhai6AMY+t4cYxhxwNwQYtfrMfQp5U/Q9cb6bfM?=
 =?us-ascii?Q?TaM9PSfHY3TH00MnX0OzmFoFx3XecG+DGyX73N/j4MaZG7wuYPUbw/SkImXE?=
 =?us-ascii?Q?VcTIG7Ogs+MLG0KIIRBkOfDX9AHLZ/fGFT7+MlVoUzPlqHx80e5+VJCJSxqf?=
 =?us-ascii?Q?WhCjJkF7Jfn0pw8F4E50GoqCiqd33LwNRhIJHe0E5z1+8+hy78FTbTr6jAAt?=
 =?us-ascii?Q?/4FDK0Flj6Pr6cSohVl/BCwBefAqGnwvtwuSXOWgz64dUElIBABKWZuGAvy5?=
 =?us-ascii?Q?IgeILdaCfYS7v//cIDyi3kE8RKDgIIwx+EUoXZu4D+l27Biy5onN7l0t6B91?=
 =?us-ascii?Q?XFkxGub+Oi5nMGj1prkJSkpsQD9B0oEotSrkWwrhPRXIDRJLO532wukmcGt7?=
 =?us-ascii?Q?nHZHXkoRhW79t4AluIs1VQ00klnXjZnKYuNGoeuONfeW8CZVSu4r41fbyxof?=
 =?us-ascii?Q?IvjUXsOECIo5dFqF2WYt/vLc+aK+4HGB+kiZsr1g036liFZsbb1W2OYVzaUo?=
 =?us-ascii?Q?zssUdWtupZNO6ndo259159lG599wK2eCPo1f86x9PFIuOET/mi+9SQSduJHy?=
 =?us-ascii?Q?3yNKdQASOvXjF8ChrJvhErmdZ5WpODwCjo8+Qnl5MIF2DDkIddLf36w61r9b?=
 =?us-ascii?Q?grHOHIdDk4n3rkVbhtSVKap3V3Qvd5is5BbRwLVs8uBEA9q0bOQGLHrW5/pE?=
 =?us-ascii?Q?IDDSa/JshzPJlOQQqR9NJ+UA++LwhYvnXsIJXcpOhsrqSLXLqLUv6l6KoxKY?=
 =?us-ascii?Q?nMBkbOKkSXw7Cruw790uozLkZcw/G/wVr5diU685Ri9UV5Xm4ZgyA3/WdBlB?=
 =?us-ascii?Q?mi6UWlo1P5DCEfxfLJ2yIo0LebG1v0Fu2SAd154isIQOxVNKliMWD0qQWzWK?=
 =?us-ascii?Q?OhMMkEdx7+e5Z0rQDhJn1a/eL5ZJWDXCtmM6s29wqdDRHsPG9wCNSKy+Q0UU?=
 =?us-ascii?Q?Xcm9bTYMJ2Ma6oLOlwK7HXIPp426TynF68CwKrxCRozAfZNqre8iHZvCeZM9?=
 =?us-ascii?Q?7oHIcKMamwm4Uio3/7bBECQ71E6FJj38V6Hh+dR6C61Ob0dW5U9A+OZJ3Ggp?=
 =?us-ascii?Q?3CM9OBpDbloZQVhQEj5mvSGaXe1h6H8ewrgpEWQ+uNaSOOFfJvbYchNHwmqx?=
 =?us-ascii?Q?iVPpAK0q9vlAJFVtemMq9o=3D?=
X-Microsoft-Antispam-Message-Info: FtLPjybBSGEQK77qph25U9JJOL3oDg9x7GdOyoBzCSX9o2oO2apxee0BVaZ8yQvBexqFjMan/O3g4CXUHvQJTpSBzvNLSpz8dClVhMIcdaipi9wRmTRyICcB+DCF8cQ7ZYl4xx8/V7rXvMZRl389qTiPnZVr7dZXxWkBy7Lk2C6ZWLaeh6i+xeHeMEj6gX/JS/rM2qulrgVWjY+xhldoWo4lHTY9XWJQ74AG3jsb/Kn87eJ+qWwkv3BaDgc5V/koUJ+nl0r0eI9s9Uyy/SkbZkqUNqIUxkuy3Rdm7mPUgL1mFWkWs8/FYSXdYdOU4zJ6+rZRUL4fxt3QYh5Mc5PNhg40tsB9NPQjeoq52jDQDrw=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:VDqK3MjKrBwBLiXVbtMXTH+I+HjF+SGuPwT2sck51tpn6pbZi2EeOoRBG+1G4Z/XTK+/Pf8f+iJKej5FL1KfXj209UOGAN86dimoVltUWEwe6YMj618ysCocmYzAxDPrehRKzhPOhhgSXw5hUryEZ4SEwk30CWgiJkOsiS9uIGzouepDNu7svYI5OSTwOIVHe8Q2IvwdHa65h7CuGIaeRoFqa/xZfWxDnJbKqQewQ67PMzEq8XVvFx1jewjbsAs22zYfI8ikRUV+gDH1hoj3vNN4InAsjqJtZc2o3dXlUDdrn9MjHg3SV359qO7ND4zwskc2q1bLFDUJgSjl3PwNoAY9fjKS/v8mPDuMKGLvACKBhiEmwttWLtmxz42l0bM1If+dBmKV1JQACxyNDZrXompi/fCpybz1NSB7x6WWbrUdy1LrH6Jvtg5UUuSug1sqZq0M0cQcnocwzUIYIwakZw==;5:/egf8jNmtTnjJYgIDg44T8YTYg5kysJYDxxnz2Pi1WfSa2codF0tOJGcKDWOOYEUPLGsvtYj3u4pgdvbmpFj3KjhGFBIPum6bSgVFHm2saqgRf5s+HSh8PQjgwfUB6u3BckZEV2GMNynbHJ1XO/3Wcj4q1NvRgoe5lEtz1VBOGc=;24:VPJ8TJ5ZpaIlxEIxzU+fIKVL9zu1x1TifhgW4qWy2FcJDL0rEN4+LqZG+bNooq008Lr0S2coVS9L53eBGcKxwyJIccNqNtu74QrSWg1sG2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;7:NhJwePwNhieaHaAxKzM3e6WXju5iulkkhSQdtoIBKiSXVO9RezE+5s07nEnL4y8P/Q7AouKdBfcVvwqU2p/BBxbxJALBjPyupQ/u+Kvq9ID3QfJ+cTVL76CkpZm24Ve6Hxnh8n9A6OCk22vtGI10HkYP3JWbQ7WJZA3kc+MybW5lZi3HEc9LsmoJwLTXttQI4b+llBsqRr7Q6JMTtuQPVmiaS9VuN2nE4TUJP/AbdT/xEdMjwybRpTXZHFynExoB
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 07:25:45.5222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a800113-7b59-44c5-5a1a-08d5e311b1ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for SDHCI OF Synopsys DesignWare Cores Mobile Storage

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/Kconfig            |  11 +++
 drivers/mmc/host/Makefile           |   1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 116 ++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-dwcmshc.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c199c996..694d0828215d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -176,6 +176,17 @@ config MMC_SDHCI_OF_HLWD
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_DWCMSHC
+	tristate "SDHCI OF support for the Synopsys DWC MSHC"
+	depends on MMC_SDHCI_PLTFM
+	depends on OF
+	depends on COMMON_CLK
+	help
+	  This selects Synopsys DesignWare Cores Mobile Storage Controller
+	  support.
+	  If you have a controller with this interface, say Y or M here.
+	  If unsure, say N.
+
 config MMC_SDHCI_CADENCE
 	tristate "SDHCI support for the Cadence SD/SDIO/eMMC controller"
 	depends on MMC_SDHCI_PLTFM
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 85dc1322c3de..a18fbba1b97e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
 obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
+obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)	+= sdhci-of-dwcmshc.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_IPROC)		+= sdhci-iproc.o
 obj-$(CONFIG_MMC_SDHCI_MSM)		+= sdhci-msm.o
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
new file mode 100644
index 000000000000..1b7cd144fb01
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Synopsys DesignWare Cores Mobile Storage Host Controller
+ *
+ * Copyright (C) 2018 Synaptics Incorporated
+ *
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include "sdhci-pltfm.h"
+
+struct dwcmshc_priv {
+	struct clk	*bus_clk;
+};
+
+static const struct sdhci_ops sdhci_dwcmshc_ops = {
+	.set_clock		= sdhci_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
+	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
+	.reset			= sdhci_reset,
+};
+
+static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
+	.ops = &sdhci_dwcmshc_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+};
+
+static int dwcmshc_probe(struct platform_device *pdev)
+{
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_host *host;
+	struct dwcmshc_priv *priv;
+	int err;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
+				sizeof(struct dwcmshc_priv));
+	if (IS_ERR(host))
+		return PTR_ERR(host);
+
+	pltfm_host = sdhci_priv(host);
+	priv = sdhci_pltfm_priv(pltfm_host);
+
+	pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(pltfm_host->clk)) {
+		err = PTR_ERR(pltfm_host->clk);
+		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
+		goto free_pltfm;
+	}
+	err = clk_prepare_enable(pltfm_host->clk);
+	if (err)
+		goto free_pltfm;
+
+	priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
+	if (!IS_ERR(priv->bus_clk))
+		clk_prepare_enable(priv->bus_clk);
+
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		goto err_clk;
+
+	sdhci_get_of_property(pdev);
+
+	err = sdhci_add_host(host);
+	if (err)
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->bus_clk);
+free_pltfm:
+	sdhci_pltfm_free(pdev);
+	return err;
+}
+
+static int dwcmshc_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_remove_host(host, 0);
+
+	clk_disable_unprepare(pltfm_host->clk);
+	clk_disable_unprepare(priv->bus_clk);
+
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
+	{ .compatible = "snps,dwcmshc-sdhci" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
+
+static struct platform_driver sdhci_dwcmshc_driver = {
+	.driver	= {
+		.name	= "sdhci-dwcmshc",
+		.of_match_table = sdhci_dwcmshc_dt_ids,
+	},
+	.probe	= dwcmshc_probe,
+	.remove	= dwcmshc_remove,
+};
+module_platform_driver(sdhci_dwcmshc_driver);
+
+MODULE_DESCRIPTION("SDHCI platform driver for Synopsys DWC MSHC");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

