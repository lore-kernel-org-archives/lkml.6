Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794E6ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F289520880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uSYnv9j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F289520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeITPuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:50:12 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:51783
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731866AbeITPuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKunZGfg6mMYdV+XMBrRxjs5w4PNvBNiaagUaJakTgY=;
 b=uSYnv9j2NIi8pW2aqi+7ivI8/PuiQWVHRuHpP/tXLEnmhBCpmTfnSm3mL7ZYuNB2yM1TKaX9wqDkJzDLePhY64h5quF+iIi4FBrws/gHwzU/BaGfMkrRAJHE2Oo3wwGFxrdjRxOHsGKuzaUwVfV7FISF0QzlcH6BUaojnyJ1S0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Thu, 20 Sep
 2018 10:07:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH v7 3/5] clk: imx: add SCCG PLL type
Date:   Thu, 20 Sep 2018 13:06:38 +0300
Message-Id: <1537438000-20313-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To VI1PR04MB1616.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4587b589-9689-4d8c-6aca-08d61ee0d707
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:mEXJGlle5oBGoiAf6rlvWiK+IEldI840YGmwCTY0nUg9lP80uNYUwFE5nsUvXdk0D+DV+NsI/Le0B8phClUo+Hz9uVS18lngdbs0k/ADEHG3fQzy2+LiUMTvN/N70YUEhyGckPQ4+MBLv8G/rdMkNyXqRvUQP/lzovKnnWoTJ6M5rWXvB+LALPGVemTRXoSqQ2hh+MEo878P6Cp+rLXv7momZDanoMkcpDspHBjNETi5gd8/NWLYFrc8+lEyGlmR;25:f29OVr3Ktl0bdjlKUqojuRVJakuU3dHT8GqTkIG3dsUF1MkXoFevvOjgbqBiFUxRiviTFtf+qBVA+KmdS8gtYg6gEDnhP1QYEHhzn6c8MeDFHag2AoN6er+WW5rfOzN+8lB14So4yD/7GpjU/jXKDoOuYR1M11pyOIy/xW2vUCRmSGtCXkHf4i2ua7XydF0U6QbNnmllVxt5Hlr0TMbZ2B4Djc1ECwCTSVIGzjq4GTric90CN0EMf08flaJvx74ynFX4arOpOA9QkiZEx/Cl79imHGlttZVk1hL3mANZk37FRKAw6waokpkoTaY4uC+8YWttJOIiQ1Gi2xlBNW1obQ==;31:0fC6IWHiXcSRxS+2BgVo8FAvozfcvMnud6UVbcxZ1ySEQH1KMQSa9QT/1clgFj2/zwdVLmUFGCKdGK7bqN3gNiL1hiFmlVRpc3ntK7D+vzjU67jzPiywWP988ooTk6ir8uniiFRNeGpv5OeJgJ1B2bmVw74Hj1bBGxX+75YRGvTkVsJtGNWCziGcAK5ziriZFUoINvvNw8mwVKhYxHeDJgqxUyIChG8p53GQCaR7JtM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:XmTk7p9gMDtQKmpNrsi9pmYQHJRkENqiyjh8qm5YYrPi7em3uSlGVx01S3EhBX9kUcl3iTqEWX1cdrNp7/38+PfNdmY0UE+JedP9Qe3yBeWZPG2PqNFYP4iroE9mATyHf1/f4+3zZeWh7OhF0cDIhcUrOSKQVh34284h9pqzbcXIY5rTFIf3phKMhh8qT1ID2rkaveGQ5PJEIh1aQR1HHZlpj5xl/Y7v2fgcgcARy4othoFVwhIcY/4V41L5AH8aEP1ndcaEy2fKzE3Goj7ClVDBbj7B1Y8vG7OXLWfqdM7YVUihMUCMAE4sHdrsCOzeqEK4Zot8m5OHl3Zszwln4WZ6/CFC0+yj7IGiKIQ6JE+ESuLtx+SqCnBUr9VmZQGCz90gkcpGShf4D6PTeAXuBi/cEvIkQA4jpKiEU6w+klFW7HAB8IRPFntRV9UZQEUNbqno63gHV1+vzG9EqYJ3cglPRFZZE4D8tgMoHBsypVcX44kbo28iXqaYOLzVtPxu;4:C7cqTOsIDBs8XAhDO/1M4aZY4PW2rmmGoaQsdj6QulFcIunSwqaKR26e+r5cMCZidKtK6CVYRuZacqQxbVSYlF9kF4O0HA4po/HpjxXJ8hU3qzeviBjrtutf2zOaTvvH64eyWCOiA5e/f88fAqkMWA5Owo5njHnF22x7g37lbgKlQ2wVli6kopZwuxbKVuG9bgrOPIi7NgyvkRsIGwi/ErVtE4fpxgrfCKZWCflw2isE6ZMiOMcNAOQPa4Vp46Sets/r1XJBpZDkuPA0WwqhT6osvHT3xSpsyZyYNfwLPTBIumRzpR16r4n0PVb3oR7A
X-Microsoft-Antispam-PRVS: <VI1PR04MB16167C3948973C7C08B09366F6130@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(6666003)(8936002)(5660300001)(2906002)(50226002)(3846002)(68736007)(50466002)(53936002)(6116002)(217873002)(66066001)(86362001)(478600001)(97736004)(14444005)(39060400002)(6506007)(6512007)(25786009)(316002)(486006)(51416003)(52116002)(6486002)(386003)(476003)(446003)(7736002)(2616005)(4326008)(16586007)(16526019)(47776003)(81156014)(44832011)(7416002)(186003)(48376002)(110136005)(54906003)(26005)(305945005)(81166006)(105586002)(106356001)(76176011)(956004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:0Vequ5dle+fG+YKSlZcCW2oUT27/EaQmQIA45AVTi?=
 =?us-ascii?Q?R8JEOObZiO2GMrZBKI6uZsNp0FSwgctzhM3K1eP3R3pVFG3OB3BdJIBbaXga?=
 =?us-ascii?Q?p30qNLLEw2a9dScAcMXHLhqHprXBWS5kXei4+26eUC4EppC/AZR70nJmiNYj?=
 =?us-ascii?Q?cv9WclfH6Pr+UTaiL28JBBCefZb8NFj3ds8yqX3zl/oYKA9UQWqN941Apla9?=
 =?us-ascii?Q?ouAWk9cvBj/OWCAtz36QuGrVJTBkJ29uxgyg8XAS4fYuoDOagKn3FG+3CPgQ?=
 =?us-ascii?Q?BRZoqROCvncIjNPflIKPOKyX8sL9lYV8jyxiHEYhOYWzDFeKAGt73E7kJ3cs?=
 =?us-ascii?Q?CvjpNGVhcIA7qOVd0PZ2vM2sLNbLqtpiwfryePZN3yy9ZBjb0HwWAm4hkVAb?=
 =?us-ascii?Q?ho8BUvYeLJouRDBXQp+PLuZcb9AlvsvyaASrbnHnogOsjr1E2Je/koDQxvU3?=
 =?us-ascii?Q?ai50Vm3BaskomxL6tox8hVnp1RP0kKa1/g7+97CLMTkMl4YodqOKQ5NpUPcV?=
 =?us-ascii?Q?Jyf+9HMUQcny3njOkIex7M92Xn7wdVugzRQSPVdBfz7L/Rm7vVBWnQbGm5lT?=
 =?us-ascii?Q?AuiId5arIEcbl/fEBSEvAqv6/9dvUGwu56eHlP6HlqMzELjZ6yFM7myaXEhH?=
 =?us-ascii?Q?AZFcCLw3W1LfsNTVu/3UBTbA5hFcGGjPrmXwbiBgEsGMWUnHL9CPNtkhh3gV?=
 =?us-ascii?Q?RTgGSMQ3EzJAayE55O0cMTk1dNju7aKQhHxv078vQw0ZzlXpYrvqJRZd1/XF?=
 =?us-ascii?Q?sXvTtmkUEf4bEK2rVAs/RKz7Fkie+K0Q8McdavEmvu4SshEgQQwYVIS6Xlv9?=
 =?us-ascii?Q?H3uu2lVVGiSn+M/uIK/A2KQuBsb8bUzD8kHCuJ3aLKtsQSgQ5QL6T9V7R9IB?=
 =?us-ascii?Q?5n9QaCnr3uskkEQjeHY7m9KgKCnvcGcSyR4QP8lay/1H8eFxA4ISxyMPxB0r?=
 =?us-ascii?Q?mpQkpI6Tj15JPx2peh6iqBDRIieWaGDqGQcOhOKEsP0lUg59V3v3qfodGWLr?=
 =?us-ascii?Q?a+oH0OXLOtAgptJXRbCpTO2AerjDninKk4bke7picMipi+8HGZb1aJOFIaM5?=
 =?us-ascii?Q?xyF6+VBtiLcQviQUaggoDgL7Huusq/xFn6/5cLcQkDFsXfLsFRyds0QpeSvy?=
 =?us-ascii?Q?WEpT2FGYetg5lQa5GKqKMf0PNqvzwfaOi7PopNPjujnsdCVL0/vM4Zl+5WkW?=
 =?us-ascii?Q?4Z2luHeu8fvCHKTZcl+2ZMNyPWpHSV0WfuWUffwc9xnG1qlUfRbO/S989q/R?=
 =?us-ascii?Q?Ut+EF3GEZgmZu78t+LOnKbgLGQxAgwxTIy40xjaZlCHam6L+LS/9Z/hRxv2P?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: MHnz7F092JzouV0y67vsY/qSvDYN3rOptWU3smCddcCZzBqQFjQOprJaGVv83cyXvImLaBncSZTH9h57lTMh4RzgpClSnfh7+WacDSSYiLFXzwSZ0SqyFeWedCZW3aThE5q3CPS2+qf60N+nTn9LGuvO3TUlc9bIr7ZrjJ+yH2XenzGUE5IgYWXGb0sokMfytLbXDfOuUnVjy/dVbmAWMVQKQJx2Y+z8rNBy6uAAeKVfT9tBsR7KTiXPO3/U5jBdGtqEkq+sF/VY9iofO7SqTQMmzfk7oBjQzijy6P5EkNeuw9i9yA3nOZVYwGKNUtsywTxIsUR5ModThPm55Mi0V+ca5vSlKpk+BJpaERwG5ss=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:YMeoTdQpNWsL4bX4+0sCCKBEaGmX7Byl9WnpmJIOXSu/wJ/c+bXjS8THMBKUCE5akKtSIeJeQ5AYzfm1Tu1IjXDvIpeSRYRecVm0F1+XCOYXXg1WvC2P/aUFVaKehnEWIGZH1a0/b2IVU2x+76kMuZNOBFd98+vTc30/QUsX6sns3+7y9XB3akERa0R+qtNzxSSZnj25rbiLzhlnlyXYrp2b1CRk4Hcmbbt9lEALc9uCQ1+r2fgxBO5d9lq9SIvmRDQdEonfsoDSh3u/4ZvF5FXZWjBqKvL3X9wc9HeY/GX1HYApOGjuz/PoRoDyLK0W+5USDGaLC3EECnb0ItGPa/lCNIGT57L9/ff5obSLqXf4AZXbJ94XQy18WurbJqFo9oooUQCWnXLcz2oUdxdV64wzPGazqzzQU/hs4aJpuITOhq0c/fQZHGDgGDW9wYyTG7PVWe4bJ0fhKsSQYlhAmg==;5:rHjsQKS/WWxEQYZpNW/0WALD/8DNJqhtgkURv52jwa8Pdz2byP5MeurkSDOD60Xr3bxSqOFyZdqvCju2kq4Sd9SMqDkVCkIn3Av/MVQLA2pKFJMe5a8MI/DNNDeMBbGVcWTRavPLGNn7ATwlcI7142cbxTyZMaMqa8Z1orAEeTU=;7:ZBi3+7dFLFKumSDSShts55Noetnrai9nXAYf6atymUhDjoU9tCl5OsQn1UO9TbfI5CICSF2Vc6yrrdEfmmFMuPVDEjFc/Q3Pcelu8SpdR0TaCkok84Q6MHBohX1xH40jxOn+I0bTC7io25+eygiYBDTzinyb/KaQSnT5so0Y6sPAV/DjPmfSIIdhyOsGsxqDDN4UWFoHWGrU1kgDoWlYYgVuPUfLe6DnRgzyWYP2g7+pQg4Wx5Ysdyw3k4mX5ZZW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 10:07:13.4907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4587b589-9689-4d8c-6aca-08d61ee0d707
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8. Add support for this.
The driver currently misses the PLL lock check, as the preliminary
documentation mentions lock configurations, but is quiet about where
to find the actual lock status signal.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 246 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4893c1f..b87513c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-sccg-pll.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
new file mode 100644
index 0000000..8d87ba5
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0	0x0
+#define PLL_CFG1	0x4
+#define PLL_CFG2	0x8
+
+#define PLL_DIVF1_SHIFT	13
+#define PLL_DIVF2_SHIFT	7
+#define PLL_DIVF_MASK	0x3f
+
+#define PLL_DIVR1_SHIFT	25
+#define PLL_DIVR2_SHIFT	19
+#define PLL_DIVR1_MASK	0x3
+#define PLL_DIVR2_MASK	0x3f
+#define PLL_REF_SHIFT	0
+#define PLL_REF_MASK	0x3
+
+#define PLL_LOCK_MASK	BIT(31)
+#define PLL_PD_MASK	BIT(7)
+
+#define OSC_25M		25000000
+#define OSC_27M		27000000
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
+{
+	/* max lock time is 70us */
+	int retry = 7;
+
+	/* Wait for PLL to lock */
+	do {
+		if (readl_relaxed(pll->base) & PLL_LOCK_MASK)
+			break;
+		udelay(10);
+		retry--;
+	} while (retry);
+
+	return retry ? 0 : -ETIMEDOUT;
+}
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+
+	return parent_rate * 2 * (divf + 1);
+}
+
+static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 div;
+
+	div = rate / (parent_rate * 2);
+
+	return parent_rate * div * 2;
+}
+
+static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+	u32 divf;
+
+	divf = rate / (parent_rate * 2);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
+	val |= (divf - 1) << PLL_DIVF1_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+}
+
+static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, ref, divr1, divf1, divr2, divf2;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	switch ((val >> PLL_REF_SHIFT) & PLL_REF_MASK) {
+	case 0:
+		ref = OSC_25M;
+		break;
+	case 1:
+		ref = OSC_27M;
+		break;
+	default:
+		ref = OSC_25M;
+		break;
+	}
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divr1 = (val >> PLL_DIVR1_SHIFT) & PLL_DIVR1_MASK;
+	divr2 = (val >> PLL_DIVR2_SHIFT) & PLL_DIVR2_MASK;
+	divf1 = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+	divf2 = (val >> PLL_DIVF2_SHIFT) & PLL_DIVF_MASK;
+
+	temp64 = ref * 2;
+	temp64 *= (divf1 + 1) * (divf2 + 1);
+
+	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+
+	return (unsigned long)temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate = *prate;
+
+	div = rate / (parent_rate);
+
+	return parent_rate * div;
+}
+
+static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	u32 val;
+	u32 divf;
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+
+	divf = rate / (parent_rate);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF2_SHIFT);
+	val |= (divf - 1) << PLL_DIVF2_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static const struct clk_ops clk_sccg_pll1_ops = {
+	.is_prepared	= clk_pll1_is_prepared,
+	.recalc_rate	= clk_pll1_recalc_rate,
+	.round_rate	= clk_pll1_round_rate,
+	.set_rate	= clk_pll1_set_rate,
+};
+
+static const struct clk_ops clk_sccg_pll2_ops = {
+	.prepare	= clk_pll1_prepare,
+	.unprepare	= clk_pll1_unprepare,
+	.recalc_rate	= clk_pll2_recalc_rate,
+	.round_rate	= clk_pll2_round_rate,
+	.set_rate	= clk_pll2_set_rate,
+};
+
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char *parent_name,
+				void __iomem *base,
+				enum imx_sccg_pll_type pll_type)
+{
+	struct clk_sccg_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops = &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops = &clk_sccg_pll2_ops;
+		break;
+	default:
+		kfree(pll);
+		return ERR_PTR(-EINVAL);
+	}
+
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 13daf1c..12b3fd6 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -21,6 +21,11 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
 
+enum imx_sccg_pll_type {
+	SCCG_PLL1,
+	SCCG_PLL2,
+};
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
 
@@ -30,6 +35,10 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
+struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
+			     void __iomem *base,
+			     enum imx_sccg_pll_type pll_type);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

