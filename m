Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C2CECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D6F2154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GfThV7r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D6F2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbeIUSB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:01:28 -0400
Received: from mail-ve1eur01on0040.outbound.protection.outlook.com ([104.47.1.40]:64768
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388944AbeIUSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iik5YbiPbRMfj9z+2UxrLganhSIdaFPu1EsjJT4iRic=;
 b=GfThV7r7fRcxU7MqazultDWRe5abHS/2xLHE3/usQNWnfGEgg/j/IEmVqQqGEnaEClkWs6BXsxljlRnr++iS+QGyq6L3+zINtqPf4/0DuGfNC/7sndPDAIpp6hKxBwVUlgJH8hCQ5cp4AB9o8N7coBANv83Z7xnbLQwVs3FCy74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (2a01:111:e400:596b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Fri, 21 Sep
 2018 12:12:11 +0000
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
Subject: [PATCH v8 4/5] clk: imx: add imx composite clock
Date:   Fri, 21 Sep 2018 15:11:33 +0300
Message-Id: <1537531894-18499-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
References: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0602CA0014.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::24) To VI1PR04MB1614.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae9d3516-0187-4e2d-d2b5-08d61fbb7620
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1614;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;3:jVqetHY00dopl1CKVhGKRDpWVjr/h7g1phorVxXL/IEq+l3AxFHFw+N91DQzEBln1KWYLDzVLrgr9+9GAFbXOmxQrLU4MhF+d+4UY2o/8hAPX3Q8Wn5QjB+zDKKkcCThTqgbkxiS9i6K1QzCEbyPMrrBRO2WtOFZ0DK/aziuXXOmJZcZ1dH+U3yheOJ2pETFmyqB+Fk/TLngYgsp8reRNeznBvxMyKvRzkhTYt1HdmjTlYRFw6iJESME0x0MGxzi;25:S3vBQOnAhazBl3mTH5kDTnk41PjRG9Ye3uuqy2oRd5dxSRhSzkvj1RgkZwKOVl2Af6jjqZuu1brEerNQegdKm15cdhUZ4aytcexikGJQ3sCMYligCkH665CtMiH6VtK/jcOngOsSM5dN4/G+h0JCAniqh+UorRnJW292HCEnt1rZguMBDDK+yK5CmkmrtkOvTezi4uEO4KZc7vhF5SD9B1HjC+SyT99fBmkrXpgm6hZbH0uca7xj1nA0mt6CRDWwqssSyr35FaJT2Gspsvz08RMuk44inH+peDCKYhUl9VLlt71NowXGPXrj3AxagIGDkayGeU1Jk0FrMRdawfqDmA==;31:yuMB6oLCtpxH7rP55y7XZluJjOCu1xJE7FHfJ3DtMkvJZPjNy1qg8uyrY1PWRm1Mdq+o5ZO2rfcv7g3yeChdcWrEOizB2L9w2qVgMK+M87/8EbHG/4GAz0r+XjbHbNwCnbxuGPI1QgnvNTYbinbvTbBsZ3jWoSYZeUyrlwGY1feXcNBo8DjCj5ubhVbISpRGmCVZ5X1rSuVrR8WqMQV95yPL0dJI2OfBlsSopcauZl8=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1614:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;20:TyYR5JX3AImkAkqImlhW1zSNt62SJM6ahAlNm9CnmYZKmtHxekcrx5hx5Ko9ZveJKIBOGcVmExriGdMMIGhubzobvf/tE7nhjIpes/J4Ii7pFHCBGc8jAc0l6ctNdTsWMLrqA/gd9hZwbwFticWxGJwFJQcs1OGB1YS8E5USpOMGVtRs/u816btcA+KqBuu2nSLDAvi1DOPQdyXZXPd9dTt+iuNOcbfyCvhnA0bvFgKo4EhkAiCC4wc/YntuM8M22fVnmM4MO3g2/DUh2RGySbGDpd6/XVOZNVpEy62g9F8G81SQb+y+oDzKJpYEkpMfqvWpWgwVENGWFRRbnARffm2KiMEFv8FPXr5lRb4nKkyjtTdfiTKhgtZJuyRMPSLffuiB81DncxykGeE12/JFLUz5ZPZW9GsQaENmmbq8kNJkVmwnB/bx0Kk/YipuwC2z/yWfpAyyA7ugFVapcH+PuFMbHDNCAoIMB3fcjPEN4dRBqUp+I3+gAqAT0MWA3OC8;4:CDQOMk6Fu6MH7oCf50uPBdqC4PgseX8+mblg3e1YBF7mTjpoLY1Cjpl07GE5q4cHOHlGeJHBH5ka14P8gR1RLo/OWyoXe5vHvYOBPFibEJwF81sIOgc3gWQxrfMyGdyDdHglKtC7vVOFEIH4jY8DhgZr7x0o1mVjddw+mjvOlz/5s7NZYhMuLoRCnJMp4Otlo/0zgyvMwUqj6+c3Qx2bVMk6S9ekdfICujdma4j8nknyqWfz53xPPOGbK1bgod24sx7wVfVAdaFNeyVBmCEnxsEqUT43bIMq2G3OMGZaOVNPp8O7anTLDK1KYaXjeKaC
X-Microsoft-Antispam-PRVS: <VI1PR04MB161437C5B5FF08A405F2ABBAF6120@VI1PR04MB1614.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1614;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(97736004)(36756003)(4326008)(6666003)(25786009)(6512007)(186003)(16526019)(2906002)(47776003)(8936002)(81156014)(81166006)(8676002)(16586007)(66066001)(50226002)(6486002)(6116002)(478600001)(54906003)(110136005)(14444005)(68736007)(3846002)(51416003)(486006)(76176011)(26005)(7416002)(106356001)(386003)(6506007)(575784001)(44832011)(52116002)(86362001)(5660300001)(316002)(2616005)(956004)(476003)(105586002)(11346002)(446003)(39060400002)(48376002)(50466002)(53936002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1614;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1614;23:uEMqNhW+t9QhAZhXkKn3uRugLRgUL51NvCEuajJap?=
 =?us-ascii?Q?F+PIT1ckODwrg5TCcG606iELkiSbrg4dWgdhB65dzLKPQIBZqCb9jGig78nw?=
 =?us-ascii?Q?mKS1vJteVvGth42XE/N7277J+AXe4LiUpQKu0rPEmQ3o808L0rkap1K2Gh9s?=
 =?us-ascii?Q?/QmG5OqumyTVjVReX7Zsvz9c0bdruw56KAT0dKqkZ4x6sMxF+7cFu1uiJxYW?=
 =?us-ascii?Q?yZIwv0WQLyxeE5gdztOuMj9638YjzcDk4MvzbD2AbvRzWBWh19gjJAIG33EG?=
 =?us-ascii?Q?mnpG9b5O5wHvIfU1rH7ijbPYioVhQBsTYW5jaedvtIuo/c2xqqUOWKg/ahHd?=
 =?us-ascii?Q?GGBrNq7BXec6GlMic1CAl6lmz4mhLdY5aVqYZlZ6j7zs7wwZqqygNtIH/B8x?=
 =?us-ascii?Q?0gxK/DYfThy7FEKMLCwZJCyZaZc0iTIAUSMHB4SaCS4sI12YPXH38AHBMX1+?=
 =?us-ascii?Q?iv5W+6GyD15aSs+eyJ2nyZBOvgtnZlyGksZ6wp0abs429Dp0TFqCbId9r1IP?=
 =?us-ascii?Q?EUokru/u53Vsr6bUNERSxB53hA1CZDRe7mShDhTdqPENGRgsMjkZP4GNS+Y+?=
 =?us-ascii?Q?qcMzVsCcIpvI/Ib8ILf3n8olbDNbCLTjfH48EEuL8RPACbFVUEN/6piH4kUC?=
 =?us-ascii?Q?WcB0Utj6AmfOQJWVQK2x6UV4/tmD/NmeVpCcf5/kyHezd201Ypzidpm6bpfl?=
 =?us-ascii?Q?k+k/wO7dLW80Sgo8BbIJkRcggSJD4XOcfJUDRRPDL5PbReSPH+VS9d22P4HT?=
 =?us-ascii?Q?SsGydmnjrSk+BZOkQ01FsXt+IDndWYXNE1hUkvgeynq4zrbtiGp8DaXh2ybu?=
 =?us-ascii?Q?0ui64N1CasFpqgTa73ReDxPP7LdJMyJzLBWg/6kz6bjcGHusFESCQwrnPvgQ?=
 =?us-ascii?Q?xz0CuozHoPFn1eAWmPEMMfnnlB84JngVgqTExzFCmWTicEdsve5Po1MjTBmL?=
 =?us-ascii?Q?/eKnea811MtQvM0bSNkaGtqzdky3KeA3pSe1nkVEN52zEhUgZMavo4MrnQMb?=
 =?us-ascii?Q?c8ZvldxXKzUDfjdZW6X8atK6WXbARELFFyiuuRHZzRBgpyFGbnucxkQPMQp+?=
 =?us-ascii?Q?RF23/rnAnKz7Q6sIerMQ5XnwAQuoLsRj0LZ1zS32ksfasYG3+wDghEhBfW2x?=
 =?us-ascii?Q?ukz5UjAtdfpCpYMaS64z7caY4bjEhp5F5DJg44lyB4RmQP/BxG7ewtpROGdy?=
 =?us-ascii?Q?vO0P6A41HuAi968YInHSSQSC7Ch+20q4BPUrHhTFgrmBxKtpgxMhvPe1watP?=
 =?us-ascii?Q?v1dGe/8scEzV7hGZ4dnNQ7PkBDw4ukcEJClsKwOJUOkQa2crlUHmuNb/ECJL?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: Ks7bflWGsgcq9xMyPSrzmTFdOLHcBoJrI1ajwOHJRwWdMd2Y5yFTToKgM+Sa6OhpGebv5YChbLr6BLkpFUKn++GV7SK4ehJGV308s1MtV7aXPWdUmMx5AJattRjkw/H6BGkKEbnxcMdia/9YTOn1IQCXJnrTUFJ3XWJzKhjEXV+AdIum4f5XfBQgKrdd86eeq8PpwtTK7CW7hicPksadlk40Jm+zLr5XfJElKFLSWEOq21CBM89qufAZS9b+8l4lD987TUir4kwWnDsDNp0GSd+VBddb1bMEH/XNYbbdtL1IvKkNQvreILw3Erh6Wy/3QH/mjvxrskua+Vk10DC0sRVk2fkkA71kqzrzv/Kc/d0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;6:BA0B5ao1KrqpH4zThJYMuoeGylrAEakX7VAW9+ecZGe75hrks1xIxNAYk5/Tlx1e4J8bbfIfmGOzBd94lRT3Lw2fxKvYRr6ppKv0drvqiik3eBU3I6MIxE2j6hxT7L19Dd5F31EEemavpXIM2jCG72dGGIDs/3d4BoV+3MfcsXWaewz+C5SEnn2i7VYNi6e01GRtxjOPfZEuq/rRpc6yaAa4FSdGdnoEyu/lh9Exs0jTnv1kGoT04751bQ5YkXLKt8AHMkJtvmxpbvJ2n4LXgDaG/jddQKBJlyODFBzew6+MStgRgYNH7TKxYOZqvyS9p6TQtcmLCa9jf+ZobmdZHGxmXJGk82eU7dTQOVlVMKe03m/ChX93wluECXGwV6RJeSNdTsngcbrRgTdLNngDuqYqwO6kuDYbmpVm6n6M/ubtP5YyWdKA/Yukooyu+79MJIBkwXxrHKglGvAtbOpoQg==;5:A8eraYI4U8AbdDh7aCH/OAN5enhjW7cZc0Ddsp073dl+NvAICn2V8LRWyjjPXa4qYfhWFZITzGUF6gVxusABABOvhcBTL20kQlUMtKzgCVwF0wJ4p/pJZu8zPaHPK1liIvA6s/Cb9uyeSFDX+T3J6Q5wnugj9ZaBNBa1a/B6B00=;7:LFpcl5SAmWi+CsiFsDShQcawXuDmZpKUPDJ6ePDIHvNpV81oRG7DXseeZYcDvCpVW8WFJejxvRPVmWV24CGzjoT6bffGqJ144TCTqAyqSOfkRIYwqbKGzTp2AaOTVmAvv+XGxR2leaet9Wpzxeod9h/n1YsimPWDMAEq5++nwu+JhSKWIRs9wbVaHFwODHJRD9tClFhOindGeNpCJN9Zd1k55uXwnxHCnyhweXQpolhFskNMzZPeJmgSNpeXWoFF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 12:12:11.3836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9d3516-0187-4e2d-d2b5-08d61fbb7620
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx_clk_composite_divider_ops and register the composite
clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-composite.c | 156 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  14 ++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..4fabb0a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y += \
 	clk.o \
 	clk-busy.o \
+	clk-composite.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
new file mode 100644
index 0000000..1f6cd6a
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+
+#include "clk.h"
+
+#define PCG_PREDIV_SHIFT	16
+#define PCG_PREDIV_WIDTH	3
+
+#define PCG_DIV_SHIFT		0
+#define PCG_DIV_WIDTH		6
+
+#define PCG_PCS_SHIFT		24
+#define PCG_PCS_MASK		0x7
+
+#define PCG_CGC_SHIFT		28
+
+static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value = clk_readl(divider->reg) >> divider->shift;
+	prediv_value &= clk_div_mask(divider->width);
+
+	prediv_rate = divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value = clk_readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &= clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
+				   divider->flags, PCG_DIV_WIDTH);
+}
+
+static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+
+	prediv_rate = divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+	return divider_round_rate(hw, rate, &prediv_rate, divider->table,
+				  PCG_DIV_WIDTH, divider->flags);
+}
+
+static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned long flags = 0;
+	int prediv_value;
+	int div_value;
+	u32 val;
+
+	prediv_value = divider_get_val(rate, parent_rate, NULL,
+				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	if (prediv_value < 0)
+		return prediv_value;
+
+	prediv_rate = DIV_ROUND_UP_ULL((u64)parent_rate, prediv_value + 1);
+
+	div_value = divider_get_val(rate, prediv_rate, NULL,
+				PCG_DIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	if (div_value < 0)
+		return div_value;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val = clk_readl(divider->reg);
+	val &= ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |= (u32)prediv_value << divider->shift;
+	val |= (u32)div_value << PCG_DIV_SHIFT;
+	clk_writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops imx_clk_composite_divider_ops = {
+	.recalc_rate = imx_clk_composite_divider_recalc_rate,
+	.round_rate = imx_clk_composite_divider_round_rate,
+	.set_rate = imx_clk_composite_divider_set_rate,
+};
+
+struct clk *imx_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *mux_hw = NULL, *div_hw = NULL, *gate_hw = NULL;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk *clk = ERR_PTR(-ENOMEM);
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = PCG_PCS_SHIFT;
+	mux->mask = PCG_PCS_MASK;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = PCG_PREDIV_SHIFT;
+	div->width = PCG_PREDIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto fail;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+					mux_hw, &clk_mux_ops, div_hw,
+					&imx_clk_composite_divider_ops, gate_hw,
+					&clk_gate_ops, flags);
+	if (IS_ERR(clk))
+		goto fail;
+
+	return clk;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 12b3fd6..9d7c9c8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,18 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+		int num_parents, void __iomem *reg, unsigned long flags);
+
+#define __imx_clk_composite(name, parent_names, reg, flags) \
+	imx_clk_composite_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, \
+		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx_clk_composite(name, parent_names, reg) \
+	__imx_clk_composite(name, parent_names, reg, 0)
+
+#define imx_clk_composite_critical(name, parent_names, reg) \
+	__imx_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4

