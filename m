Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCCECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121E420880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFQunbaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121E420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbeITPuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:50:08 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:51783
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728444AbeITPuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoHKzRUM4Rc1K65M2cWPvUaeNiIh/eVzAHvLglLFMc=;
 b=IFQunbaNAJzKvdHeAmC166M5dxElW83QVQ1LtOyIcIyYRfs9SYqauXnEjcvwql7traQuWTBTP+aT8TxgKzFUv7DkW6+er0bq0AfmaKly5jnGLX1emtzUZxdFqpzbzDc+u808JmSM+QBbYYajX1AdgDHt8e00nZMc+LWljDF9+4U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Thu, 20 Sep
 2018 10:07:10 +0000
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
Subject: [PATCH v7 2/5] clk: imx: add fractional PLL output clock
Date:   Thu, 20 Sep 2018 13:06:37 +0300
Message-Id: <1537438000-20313-3-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 576b1c26-00fd-4ccc-d87e-08d61ee0d4ef
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:e+0UFPI0T8iDXPHEgn/juAH7jH0k507EDSs9k/8zG9NTDYIsF18JCMQ0C66W7XxaTSBcWlJzJ6rdtgxpu+g+GabMlEhdtg/Rpn+zG1H8+lOiaasLm1k5ADBoI7EQVFtIWnER5q7XIvzDAPA7UFBsNg7qZRlOeGlpHg7277c+ksH22Xw3ou1+uPI7dtRTuTPnkNQWSAh9WQHrlLeuI0G5/BBhrf9gRUC/nlq8rlpQo6apDQB22eNMxR8CfPEXBr7J;25:0vXbDH6Td+p7dC+I+JPJgl2TlT4GBc4BIWNX0v6jn8pRgPC1AdX8/XTYxIYl8D8C6SU5yXGZaES86I8JpVtuusp3ocZ5cq1Rn7FuOGwbqBsWkKwCMn/udyt4FqmJOlwk7M9xzsGrle+GwhmfAbm9d3I1OatslAZhZTH9fK6TQUa6jsX/m35OoevihAdn6uQn2EuNd9gA/UOS4LS5gVvF160q9/eXnQqtuCE9TEtyyDwWAoSDTS0qFjyts1FAX4hlZEhSgFeL/Vi2X2F77OFhWTBdKS02u2lIuFosiS2KjcpIazAGuJAhT8+pdpIdLiTVHu8g7MDgIU7rdX3GZEh+MixweaVHgiPKu6gX+1txNrw=;31:EEpmsyadpXCJ1RFtXwYumf5bkjQ+etQ1Jk2mWyz2KNmmcxxBojXKAvZm0JzYdf1fEcHZ/FeNWIq/pNFfPnCgV3hPhq31YYpVHdld0BdHM4TmAjIJxnkFBYHN+VtfgOBcqaDiI1fHWv/YMVovSqht7sfgAWMnsWZVWu0qdp+7/CPykKcRvNYa2A1kRMfm7tPzeNHkDlG2RlYFth29igCExiBwiAJ81Cf0KAUUBY8gXsk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:xw5NH5upBxQE3NTS25ZaSh8w/q/4LanG8UqhQz2GwNWSbTpT0NwvjBT9uEyiSaMVwo275YyHZe0E08Bim5mGuXN4tUKaL3jJqfl71tHq5CcR8z3YbqxfIqqzXGmfpJhTfU+iPyj3bEZ4X9I1ZT3fLBJ0lgAtmT/D4zgq2iWF2lbWZYBqloJ6lSbdqcwkN31T3QFcq/iCgoaZd1PTzObkCqHjLwgPz1EvM7Q+7UXLhRKk29owhA86QFXHJjxuwCK0+Gf/ACczxLAAQbpoe0dB7HvgYAuMQCEPxhd9ICCtzOMDoDUIUQacdKNr4fDOE8zAcNtACizqXhG319JB9sCshbH2+CWHb0is3VhT8ws0XKqWhokMFTbUFj0ygR+VRf1BjsrxQM1cO3YgM/ljnEpNlamwJswVxxRrd+dCtMXjhvloIo4363hcaKKlol41VCHGEJWSTiEYpxqBlKKz2mc/DGKX92aHUHzVNnOTompAEAlzY8t2rD+q8SDdwgfUTHtU;4:82cUSNyEcKcvyqUUmt5BErCNbFiJtjCnDXGyVvPHzrayTP3FIxat/18evxV+dsvt5ietL4s4enyrHHJlCQVi3Ns35yDVYiKvrV0OwwK53z8kPuxbpr7eoZN+wMX2/XTp9cZvl+1JxYopcDr5oSVo9Qdjal70PMUWpj+PimsPkVX7N35vAG0B0Vfqjkb6QKHWjP+geiCKeViQcu1z75dsJoJBnJ8WcVN8SWd1wvwZbMcA+DAAsVisTwQusPLPo1xYwckA8cy5p1D/KXMBaZVs6ntyKJw2r94bnkVYOeDNhIKDom1TMSYBj27cynU1Zjgd
X-Microsoft-Antispam-PRVS: <VI1PR04MB161611FD45502198A173C401F6130@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(6666003)(8936002)(5660300001)(2906002)(50226002)(3846002)(68736007)(50466002)(53936002)(6116002)(66066001)(86362001)(478600001)(97736004)(14444005)(39060400002)(6506007)(6512007)(25786009)(316002)(486006)(51416003)(52116002)(6486002)(386003)(476003)(446003)(7736002)(2616005)(4326008)(16586007)(16526019)(47776003)(81156014)(44832011)(7416002)(186003)(48376002)(110136005)(54906003)(26005)(305945005)(81166006)(105586002)(106356001)(76176011)(956004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:5hFMcz7BhvgIhN9j+P3HwGdFoSy+UozFwAxStmDGb?=
 =?us-ascii?Q?BXLU7Gz7cbRVVGdiIxBe2H654iJ5sHek8k8tUFQuLxGFcIzSLjATDlMO8L8w?=
 =?us-ascii?Q?u/JrKW6ZfolqwiT1RyP3od+iRTeZqI7kv8Xd4sGXjh4V+EtQzwyLJH5t8Y/Y?=
 =?us-ascii?Q?h5Phq4Pn+lS/aEV/xtvHREvOFp573ovz2FrFqHl61J1h7I6ESWvoFoiFtVVa?=
 =?us-ascii?Q?O0YnjDlBdvMe/VqadbqfnGVsP8bHkiLhDua0qkMIrqwgCE57ZhZKr2sKrlcX?=
 =?us-ascii?Q?PNF1X5I4gP9yWEmsBXQmEME9rMdfvXLIH+TBaPOT4BNLvStx8CHqsRafszUH?=
 =?us-ascii?Q?IlrnjMmJ66Lj+VsjnNUH5o/4HKDC14W2rsqEGWD7fTy50vRUxMzGGN5UXFbC?=
 =?us-ascii?Q?RF+Fi7hlVd+ACRwBDmRG9fbuvsMGXOh3WEiV9dSIRHsLBcXhKZZXu3hxIcLL?=
 =?us-ascii?Q?5mJFuTF0uu9wnQeOabSs7oyXIUbZQqFZwHwunLagfiyzIVBKMVtOyT3HbzbC?=
 =?us-ascii?Q?b86CLWqUskmq9UfcE48M+aXTWUVt+1NeD/ovXDmaAUhjB372k6YEKJqf1MMt?=
 =?us-ascii?Q?PWySfrsXOZcpygHE5kAm+nEBdXW7pe56/Jq25R1EvwYFORgFLUBdBdD+WMzm?=
 =?us-ascii?Q?Faldc3vNu+0vJR9nnFZhcnnJ1BZpr8gwFRXJKfwe16495vLhmFVUzzkXqEA8?=
 =?us-ascii?Q?klXdt2IJyVQhnUfFj2Ajf8pU4/ZZ88PGu4IZKcSUZjdF5E9rzjg6wG2+pJU/?=
 =?us-ascii?Q?AR+VTTWV1jh2HJW5cp7F7+xo1pnOJs3MnmPCzokwXJ+rCZ6GFOJMp5p7fb32?=
 =?us-ascii?Q?zCLJ7K8TCLHM4h7h7YwGsbfIoNTGldfXykc+rbylvq9oeOqX8rxR9nVxrC/F?=
 =?us-ascii?Q?Dd3dBDa1tU5FuSFipVugDaJ1u7Qi2hZVbfZpNAUBBSCrpUs2WDjh23veI0zI?=
 =?us-ascii?Q?4nWknMJpz7x0ZmZSB1DRZS4I/ASX+fn1/1Er3aCoPfNUFSba/ZXSytQvRGHg?=
 =?us-ascii?Q?nirDrqZunymNiurQG25ZAoLhh3IAFAGFoULxsbKETlpNMwZ6+uMmR0r13PyH?=
 =?us-ascii?Q?2apJK4HWxjjttX3TIOfhujPNC/r/yyVau1fzmUnARYwl4khr8VqFkoiiIgXW?=
 =?us-ascii?Q?yMKkXs3jlBlj7bWBwX0DA58Qi9F6IRixmrgh3QVNIc/mcZU0Q7q5tfZGqHhs?=
 =?us-ascii?Q?kcSdyvx9r6vBNI0QDng+HEXMzpQAgtRVTgmtJWcf+3rSu29z4f4piyMbKPv8?=
 =?us-ascii?Q?aOExnnfMLD1jfdlYiSrYMKPUuU1KQw89pnvhwCu?=
X-Microsoft-Antispam-Message-Info: c3XVPajemmHjVm5rHnpr3CGE5vxT685l+9TOPBfzkSr2GIGPHsL92CsOvrbLZ/r4wDkbKOZCDOibkAI/wuFNschbj/kedOmNE2FSzp9A4dZZsHG+ZNEO4Gg8uDmtF89jgrLvmu3I3CE3BGim1GrJssH8qXsuQcUs+5ik1OhGcjhYYbpjuXa9Wc5y03nzKnPwnor4r7j8HPrmft1qY+JzEnHYH2Zc0tXvYTgIGCd46tjDPHyo2ygk5r7VQ0xpkJ8YBw78ucAHE4O6g47DPPjFYskSBmIP47rxYHv0N1BT8Lfc88o4NUgGosfjob1VtUfJNLWBWY5Xy9XhG7kP1rai7sTsO/qv4JjCo6tZCd1k7Rk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:p+cr9d1Di87aOTayeUIzOye/9wORSJqq3FJzuCXYTaQJFP0ERS5i2CEO9DCW5n0pjkJ0kwpqDtNRvGJoJDrc7Tn99rBzpg3z046vQ16jedoFwQwi2Q4yzQDrV4w6f7qilhk8FswlFAq4L1HRrxYXymsy5CoU5F1WOEW12iaFr5lcmLuWEy+hspztBwzoJVyB7ViaOeNaLD+09ZRkjdoXWIejQm3M9usdP4sX7lU1iNaVK+QrX+BSNyXn4gvo3Sloh+Hmo742InTVrFXnkgbmSVMMj7/VAisULtQwPiORHx0wtk84ZEEjhY5h33jXBN8G5h3rZahqFKkaDNyHKXO8RFhkDYMTxDFpDIFCLCSruRn5z2eoT9BYYbsnPyyHHZKXc6qbXcHeZgtvsyNcZi/SVdN4/+z3LrSCi97j+y0SPyf+cJ3KMiPs9gl5HZSWZLyLNw0tsH0M08P4EfAiERvkeg==;5:fAPu6n7VPSBDzd/YDwJqjuR/JfpNDJGr1b0tt7ihTupM2UfaM3R1njZpmf8BNWkTNW2siVrjOGj6lytD/CQplhpfimxZZECqUrLtRuLeHoxWhsqXEG7IZid3T865NPJizUvSGs/u6inNkPQhWCaUEMTVH3iv6MjtYIuie2yKk50=;7:z1EWUabo/m4HMYplpz+I8Mqk0Z8qHfTsK8vS7UkT7OfptYLxNDMLF52L5m7dNHGBg28/5hUxNGV1Ev0HXnJ7238QJZ/+PkJnTWUTGvBs374oXI13MAhHwy977IlgQPcM2fBW4Nt1vDI3OkgM8f1x6nHyfrGFv9S528aBko7htdY5YknPIh4KGsJ+ggICZ4n/ZppFHuW4MZmW9QsDcL5J3CIB8sIBYz65m2D9WBnvPAu0Kci4jzlONKtTfst2nu7x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 10:07:10.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576b1c26-00fd-4ccc-d87e-08d61ee0d4ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new clock type introduced on i.MX8.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 230 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..4893c1f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -6,6 +6,7 @@ obj-y += \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
+	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
 	clk-pllv1.o \
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
new file mode 100644
index 0000000..c80c6ed
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD			19
+#define PLL_PD_MASK		BIT(PLL_PD)
+#define PLL_BYPASS		14
+#define PLL_BYPASS_MASK		BIT(PLL_BYPASS)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	0xffffff
+#define PLL_INT_DIV_MASK	0x7f
+#define PLL_OUTPUT_DIV_MASK	0x1f
+#define PLL_FRAC_DENOM		0x1000000
+
+struct clk_frac_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_frac_pll(_hw) container_of(_hw, struct clk_frac_pll, hw)
+
+static int clk_wait_lock(struct clk_frac_pll *pll)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	u32 val;
+
+	/* Wait for PLL to lock */
+	do {
+		if (readl_relaxed(pll->base) & PLL_LOCK_STATUS)
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	} while (1);
+
+	return readl_poll_timeout(pll->base, val,
+					val & PLL_LOCK_STATUS, 0, 1000);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	do {
+		if (readl_relaxed(pll->base) & PLL_NEWDIV_ACK)
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	} while (1);
+
+	return readl_poll_timeout(pll->base, val,
+					val & PLL_NEWDIV_ACK, 0, 1000);
+}
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_wait_lock(pll);
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+}
+
+static int clk_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divff, divfi, divq;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	divff = (val >> 7) & PLL_FRAC_DIV_MASK;
+	divfi = (val & PLL_INT_DIV_MASK);
+
+	temp64 = (u64)parent_rate * 8;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	temp64 /= divq;
+
+	return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
+}
+
+static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 divff, divfi;
+	u64 temp64;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64)(rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	temp64 = (u64)parent_rate;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	return (parent_rate * divfi + (unsigned long)temp64) / 2;
+}
+
+/*
+ * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' at zero
+ * (means the PLL output will be divided by 2). So the PLL output can use
+ * the below formula:
+ * pllout = parent_rate * 8 / 2 * DIVF_VAL;
+ * where DIVF_VAL = 1 + DIVFI + DIVFF / 2^24.
+ */
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divfi, divff;
+	u64 temp64;
+	int ret;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64) (rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	val &= ~((PLL_FRAC_DIV_MASK << 7) | (PLL_INT_DIV_MASK));
+	val |= ((divff << 7) | (divfi - 1));
+	writel_relaxed(val, pll->base + PLL_CFG1);
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~0x1f;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	/* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	ret = clk_wait_ack(pll);
+
+	/* clear the NEV_DIV_VAL */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return ret;
+}
+
+static const struct clk_ops clk_frac_pll_ops = {
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.is_prepared	= clk_pll_is_prepared,
+	.recalc_rate	= clk_pll_recalc_rate,
+	.round_rate	= clk_pll_round_rate,
+	.set_rate	= clk_pll_set_rate,
+};
+
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base)
+{
+	struct clk_init_data init;
+	struct clk_frac_pll *pll;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	init.ops = &clk_frac_pll_ops;
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
index 8076ec0..13daf1c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -27,6 +27,9 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

