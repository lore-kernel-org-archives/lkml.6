Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E522075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITzQ9ri3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E522075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbeGROSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:09 -0400
Received: from mail-eopbgr10072.outbound.protection.outlook.com ([40.107.1.72]:61114
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbeGROSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hI6TxihQp97FX+aqsVcmCSXkePT3yKbjfq+/4fni3LU=;
 b=ITzQ9ri3XqjQ40s8sP7OdH8tkA4hpXjOgNFE1uplTxEUfGHUHgatoIsOOPrqFy0RHzNzqIk0htMNHdeuV8e/2b1kHdMhVwmaLTICyij8pfLT3TyUvUGQ3zU/QqZszum5zCjA1YoU59fDMmAOnJk5vyA+hZSEtEBLaY/bQtSRz4Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:01 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 3/9] clk: imx: add pllv4 support
Date:   Wed, 18 Jul 2018 21:36:57 +0800
Message-Id: <1531921023-18497-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c44ef3e-cdc5-406f-2c08-08d5ecb3f88c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:QUbB5CFJKy5MGMSS6yfF9OcJv63dseXPjftbTstXQgWtWme14KLmUhyJh7MwYk6ivXwxU53yjHFtCvXv0p0WmYLMY2x/2wm74e+d64uXtr1aNiHZl8kBXx49abOEggD5aH+qzzDpVWVjdNfnK07C8eq5To87DSOZHzfTLT1LJOmon0ms7EHMbcAXRWOCPVEdbZNlaqV5+hi9OHdTSZAMOlFfKKfPM1jK5Bq2WDqB8QLAPa0RSf3jgd8/1p/ifFqF;25:4WtfgoqVj5O0VXsJ/6WdnRbiVRwKnam6oLwW3qcQALkN7k76vu9Tm735f1/KyHxQ7fdPC8pm0Le9s+7paUTvwJGuayr/r9vi+2V2FUCuQyoqIuuXa8tLVoEEZr9c5BzqrIrPTnc/MTw4wa88g7jmbjB2Kx1x7py+eUg/GnduuNPNE2sT4MKmHndMggrx+QxJEnzzIipcL+DJ/ZbEzltwwjPtlxqbNP0m3UhQTwwl9X6vDr22datzIyUrNuRe6N+vMyyMdzCOG0PhD7hKuKH014UuuNuBExD0pn80kYeq2ixLmCKHe8I/thHQVtdd6Vb3sCC1nnKcolGtwSE8ChC5dw==;31:gx3ncM9EaDi6BfIvrg7VgpNhYTKKsyh8EzCs1drwOJ2laRznQqFzG6WUCqVIv7L3UDDmKux6oug96eSkE5AHuvGPtiAqN1zOb2g2yLOdhvM0mD4hn50Ox+F5r39KP6G/q+R2EPNPCeGU6Vr029Ify/bcdsndqIlXertrx7hPUf40nKhEbJk+8Shf0s6nfyQPHKY1LqeKEFXbPayteOqfILAsrd1aViApi4ryK2t+Qlk=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:p/V/IikOEmpyL8ujwn8qfbF80HeO73QMONoIePw1R4VKiUVxgS8SBBVwcpkGdgLm7FzEFGi0wvGazcqfdtKMAiS7nJrpHNvIQp0zzNRTzdZ4uInBFY0dlX/MHhrFHImOFvHHvszwBx7pRKWUMNUZusrnFq3WeHP9slxWMyrv9sDSrQVMzv10kM/cOWVXgXtlQHx/6kyS/ii5u/SyMy2Ccfp+amlDsRzJbPG3GffZnQ+xG9IGQnC8U6skF5RFlrUgk5JxKERU3UtFsDMUjmFnVl4uaU7w+b2EJ81172LWhIoRLavZJv96MfBHd4DHrfFg8cFiM50wqqpEOvVRjjXOJnKSj29lmLqKrgNakuPMeU2XvWs4mdAWiwI1gTxnXcuaBprUlLJa6p7b7g7FfNyHJPx/fE86cNM50QqDwC4D8wpiEq1rrgMnofh8TwGNuvyk/KsEl+L3cVbVP0yyGi4/MJlxlMtf9M+JYZpaKzNsW0Wd/9yXdrZWc2hD3Y5C2zaL;4:pnYs9C4bFj5eWC8SI1uYyVYBpzSXlPtOTL9DEmQsCvp9D+5ROlapvq5gHPXQZrF+1WIm4ZS+wZeKMPxTEto8JKxC4dKtsbZIf3HnjFdoFS+ovrg4pyMyRs4+mZzSGFZ5NuhdlMD1zmwFedmuAvo4BUNYcasjk+0bkw7u4JrqtYo0VcSC8bMgpXdWES+y2EI/hFUsoGvrxlLMQR99YXLnLtgXtQpNXKt9ClfAu4WH1kGwgKfNZCzdmJC5IAc4y62VIvUF8+4DLyAS3J9X0ogbksH38hM/FbVOq7VJ6jrjPtHT9gR0JqBiDZLh9EOkzo6a
X-Microsoft-Antispam-PRVS: <DB7PR04MB4219B9930DF85531F7F2FF5880530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:Y9Y7fp5Bl2O1f77H/efsRBu70u4H5iVfWineJm1ZR?=
 =?us-ascii?Q?19h/nJQ8G7+vFynMtH/FuQhu+JaMYwaTdqOJw7aNBPrwFvkUBHW2sGD5bjcI?=
 =?us-ascii?Q?L8BiGSXat2dHJIfTnN7TnmzFo4K5eYwyo/oZdfLAETNPlf0Afv7wJHAHXsx/?=
 =?us-ascii?Q?aj7MOljOdGlxvSzbWpCqQyjO45EVQmAaDqDM7ylskXiJ1jzPHCL7B6vYH967?=
 =?us-ascii?Q?v8kOg9tl0/hqqPTuRpBfgaDiSpwM3hCu4zwFClbfFWJumhIDsJiiv56JkxIB?=
 =?us-ascii?Q?GcikB/yPjCQj0BhYOOqNLIdsF1ohMX7unKQS5HMmusMqfmgjwFX7fGVCignr?=
 =?us-ascii?Q?PE5PBsX6nRbIicKNTW/3iQdF31hLb7Jh4z5u8dMGLt1KxAsVGsA6RSY+9olM?=
 =?us-ascii?Q?KExo43vSby8vqcccOeAfuxQ/XsRpp0UlMPR3j6BVRmkdzizdwLljCzFhm/au?=
 =?us-ascii?Q?UUYD7JsEmeZtJeYoJZ8JehStTLce5jM5uH1yYhJTZT8CdekF9KMTTu+7fOdA?=
 =?us-ascii?Q?hZieC1+xUoAbyv35QhIFpJQHbvKr1Vc0wGAPu44q9T/15k2l70kWJuSAxaV+?=
 =?us-ascii?Q?1Hh0jQJeMmtFmhF1ll1/OU2NP25YiAWSzL7qMmxAdGJzydvzwcUmcJWJTID3?=
 =?us-ascii?Q?Ua5WyZk/IOO0fK3QRAAlw8V+a4nNB4r7GhSfnNE5JJzxd7ATMneWxZ8fVyDp?=
 =?us-ascii?Q?x/Lrsjn3WDM6Z5mHMSZey9qdAt8U6HYmMcANpLm8J6R8kUicAr/uBxmzlTC7?=
 =?us-ascii?Q?eKqUxYKp0hVF/pY/+ZUwuHWC2KE4OAVbNGtpFqh5oVUfpS+r17k2r1dbwysu?=
 =?us-ascii?Q?c3QzWWT1lgoZH5qLyzGNqthAyNbVSFlYDWNEcPLWDmMgtwNJK+b8sr8XHlj5?=
 =?us-ascii?Q?39W5pOeWd3mNnfhcXgJklVtV9PlUjLth6UdFwRs67LSGm32qdaLtT7kr/npg?=
 =?us-ascii?Q?1qasP4lZSSq37Kip7ik60P4giBbAdohMe+otEbXcsGVtRlp7nI4RIqVkLWTn?=
 =?us-ascii?Q?gjW6RpltZhZ9wAzGTyKfcqwLsXKvaLlRS1jU44+6rIANMCg7i0WeC15BZuiE?=
 =?us-ascii?Q?3HjfTO3uKMuB7iiPA5pbh2+jQS5VKCqeOCL0HAp5iYSnFfegAVuqkVYiqtvx?=
 =?us-ascii?Q?1ntB4qBeZ0LxvcQkgWokx/xbShyti9AdnUM8J6lJ5K4Qbvh2S6ykbKGOSJ2L?=
 =?us-ascii?Q?1gsM8vT7kmMSwB5Ye/SQ+f89J+MuN494a0114GGK8gI1uTxkflwoOkcVNvCa?=
 =?us-ascii?Q?ka0N7I78PSTIlBNa9zeYrKD7JYiOmLr153nQC7M?=
X-Microsoft-Antispam-Message-Info: 7r5wvU9P1wx/lzTW7UnuH+tiC2s6Tauxfe7+lPu0sNL0ud3X35ec5d+uZJtnU8RP9dynhDVqAB32aLFdzszmw4EAcfYulKCXN4fko/lg4DQEgdtpuGrUIaky7ZL6uyfi9+XLIBc3vAhmtHfaKd6fzz8qHj6cWln3wB0KIBmxjGkmrTjymNlAr9+7zVkOfQgLhVMJh3T0rpkemt6YcD4SX0d4pcZPrH7zZ/qrVKK+SmUxSPG+I46hvhpVMoFllahYh9TCV5BSOH4eFqglrdyK/aDIYooA2vOmhGecvxLXVwRrDSGf3SDrYSiM2hUD9DHXfax8ntfJp7Var4XHh6r/yXVFoHyp3Op3mndzBv/o13Q=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:LTLShC5Jyv+bC88TvaAbcSYfM1BBxIKw1oJuWJ7lZ+Kg0amlwa5T9r1vo4+SyOF0sSn3qOiF6jt2++0K3bhhJtJJXI42Vw1nSELk2e9aAKWT0YOXq+DdMBCmAFNLVfqNl7c8NfLa+8uOHFl5zgU7XFCtaNYrNBl7xitjMFsNoHhxv0WpddxHiPuqgoPBG5laV8EcgxrrjMAB3nWhTgFgWu5TtgKChiGACkGO56Ig4fR0LXMMw2nszPQiggEABeGHQv3cAeY30T8d74UvfpgdcRQ/zytVDglwdy3YVQfPu68bT9JgMJpwhI8GGgfIFq4TIWnWhix6W7t/ThamowZGzqVCgOIJFWEPLrshL9v9+4N1xb4cAVqELHfdFZ6d3ALyuxH8Mz5tJRtPsfJeb/gq9/hyZuPYTNoGakdhMPLPQKtwlbT3BCfrqKwkZCIub9YZI5ebPM2ye8QSE+mutfkzVw==;5:CZCZ79YRfZ66IvPiEA02kDLwUkRqHVEriHeOOjh7FDd/824HG7179SydhcaoijeQKASTOWxt26LTcd/7T5+59W4HnB83bw8j3YngJ3Q9fu1/bbDPLy2e7lh/LI+tA6GYSZIv2tgT8M1Gv3+4InHoNBDQ0QFgpbhO9+4SGtNlUTg=;24:G/Ai3RbhtE6thtMG/DeezTxbuGf216grvvzC4kan2/RJCyJXVwY1GCl1/k1Q1WPjW5V6y5xsnYT8avNEcy9cD3t/coSZiaPBDXQUWOmckPc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:eF3rMFXXngC/aYKXJu0AX6imCD6bPMR0gW1AaA5StWyVvpPwcStDMWDcL3T883uP4+4zra+P2ZGwqjgX38LXyyaSfUiwHog1fx7bk6d/IJl4xTKPLbdgFgHehV+vJ6ImhMyKXLQ+ogLxKyuJ56UlVDiIiXo4baD8smwiDJS4x/Viy1kSZbmWkt++F2zUV572rlH9jjLHHS63MUp8JMfhgMoEpdeV1mf8Fd21RCv0kUdVuOX8Xsm0KNEKPWKcexXu
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:01.4622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c44ef3e-cdc5-406f-2c08-08d5ecb3f88c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pllv4 is designed for System Clock Generation (SCG) module observed
in IMX ULP SoC series. e.g. i.MX7ULP.

The SCG modules generates clock used to derive processor, system,
peripheral bus and external memory interface clocks while this patch
intends to support the PLL part.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * remove clk_pllv4_is_enabled() check in set_rate, instead it will
   be handled by core later.
 * use readl_poll_timeout
 * use clk_hw_register instead of clk_register
 * other minor changes
---
 drivers/clk/imx/Makefile    |   1 +
 drivers/clk/imx/clk-pllv4.c | 182 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/clk/imx/clk-pllv4.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..bfe31bf 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -11,6 +11,7 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
+	clk-pllv4.o \
 	clk-pfd.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
new file mode 100644
index 0000000..67c64c7
--- /dev/null
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+
+/* PLL Control Status Register (xPLLCSR) */
+#define PLL_CSR_OFFSET		0x0
+#define PLL_VLD			BIT(24)
+#define PLL_EN			BIT(0)
+
+/* PLL Configuration Register (xPLLCFG) */
+#define PLL_CFG_OFFSET		0x08
+#define BP_PLL_MULT		16
+#define BM_PLL_MULT		(0x7f << 16)
+
+/* PLL Numerator Register (xPLLNUM) */
+#define PLL_NUM_OFFSET		0x10
+
+/* PLL Denominator Register (xPLLDENOM) */
+#define PLL_DENOM_OFFSET	0x14
+
+struct clk_pllv4 {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+/* Valid PLL MULT Table */
+static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
+
+#define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
+
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static inline int clk_pllv4_wait_lock(struct clk_pllv4 *pll)
+{
+	u32 csr;
+
+	return readl_poll_timeout(pll->base  + PLL_CSR_OFFSET,
+				  csr, csr & PLL_VLD, 0, LOCK_TIMEOUT_US);
+}
+
+static int clk_pllv4_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+
+	if (readl_relaxed(pll->base) & PLL_EN)
+		return 1;
+
+	return 0;
+}
+
+static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+	u32 div;
+
+	div = readl_relaxed(pll->base + PLL_CFG_OFFSET);
+	div &= BM_PLL_MULT;
+	div >>= BP_PLL_MULT;
+
+	return parent_rate * div;
+}
+
+static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	unsigned long round_rate, i;
+
+	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+		round_rate = parent_rate * pllv4_mult_table[i];
+		if (rate >= round_rate)
+			return round_rate;
+	}
+
+	return round_rate;
+}
+
+static bool clk_pllv4_is_valid_mult(unsigned int mult)
+{
+	int i;
+
+	/* check if mult is in valid MULT table */
+	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+		if (pllv4_mult_table[i] == mult)
+			return true;
+	}
+
+	return false;
+}
+
+static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+	u32 val, mult;
+
+	mult = rate / parent_rate;
+
+	if (!clk_pllv4_is_valid_mult(mult))
+		return -EINVAL;
+
+	val = readl_relaxed(pll->base + PLL_CFG_OFFSET);
+	val &= ~BM_PLL_MULT;
+	val |= mult << BP_PLL_MULT;
+	writel_relaxed(val, pll->base + PLL_CFG_OFFSET);
+
+	return 0;
+}
+
+static int clk_pllv4_enable(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+
+	val = readl_relaxed(pll->base);
+	val |= PLL_EN;
+	writel_relaxed(val, pll->base);
+
+	return clk_pllv4_wait_lock(pll);
+}
+
+static void clk_pllv4_disable(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
+
+	val = readl_relaxed(pll->base);
+	val &= ~PLL_EN;
+	writel_relaxed(val, pll->base);
+}
+
+static const struct clk_ops clk_pllv4_ops = {
+	.recalc_rate	= clk_pllv4_recalc_rate,
+	.round_rate	= clk_pllv4_round_rate,
+	.set_rate	= clk_pllv4_set_rate,
+	.enable		= clk_pllv4_enable,
+	.disable	= clk_pllv4_disable,
+	.is_enabled	= clk_pllv4_is_enabled,
+};
+
+struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+			  void __iomem *base)
+{
+	struct clk_pllv4 *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+
+	init.name = name;
+	init.ops = &clk_pllv4_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	pll->hw.init = &init;
+
+	hw = &pll->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec0..2fb4f1d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -42,6 +42,9 @@ enum imx_pllv3_type {
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		const char *parent_name, void __iomem *base, u32 div_mask);
 
+struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 struct clk *clk_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
-- 
2.7.4

