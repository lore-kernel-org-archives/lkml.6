Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D275EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F101208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rw6++cuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F101208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404050AbeHPS1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:27:09 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:13040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeHPS1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNGjed42+5VuyXroFYkjuHtppZNOzFxaP9xq0CaAALs=;
 b=rw6++cuGnC1TgL0daY2KI2kIpju6D2RH9aZulQUcUqNMs5nJ7zKacpSwL/1A6lGJ7VFMUHKyO80XKx2/RboKlQxovx5671phHzeD2T1mrhWefwcC1geyF7fRSPWvBwv4I/RWCQ48gGOH0womQcg/B8BsxZfC11ADiNI1TPGbZyM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 16 Aug
 2018 15:27:42 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 4/5] clk: imx: add imx composite clock
Date:   Thu, 16 Aug 2018 18:27:15 +0300
Message-Id: <1534433236-8925-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
References: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0020.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::30) To DB5PR04MB1608.eurprd04.prod.outlook.com
 (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf44611-b6cb-47fb-f719-08d6038ccf8d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:ueoygUkzZ+Vj7b+OV8Ykzup4Wb/ePX9ZCU2VLKDFhg279pYcr9n7eJ/xGuO1Y68zG0zmpLUP2Ol2Z9ZLpcO+nMBKjDRZSs4iTbhUTC/elKbV4kUK5NfU6IUxcPkmfnH2lWBze5+vZJfpj6Ku14K2C9IWy5yGr0uCJKoB3ZRB2hhahaMkINulstGFSavgAnTxvFZH9nYm1dbBQicEA52Fo3FwDGsJ9uqtGmEcz69yNjApn7xOSN5irpOzl7vBTIrl;25:DpX4aR7MGzLVDsZtluh9oxdRpy8sYXmp7mgdp8UELiQvvj8ScO7NbH72tK50cUIimosZIq5+PYDkbcdctvnqb2QOeKpBIe2XD4OITfjMzvY8t1TpuNHH7iViFDrcCSduAwaYvzhnT9QBBHmNQetMtcoCxs62CQjHeOTR3HGV48Q25a0VlfxCMk8xVN/5UGaAD6jIMcMnvqZK4laRdReH2qTRUX861Hc83W/MMCEG5zcu7Q9B+SrXzWPQtA4E0aPJ10ovwFhyzMWBhp+SGaBK9rZ1ZDpePiGEggyadFyWyU1NrDJSDEtYSNzpnHU8obdqnlP+fKm92iidOcm0HAsOTg==;31:GQ9B0KBSz2L6M4p/yvHgUGTr4bq8Q32WS2ftqmHpjS8CuZeRwv6b+ceFtiqbtJbKXTkX8lZVVEb+rvIBZTbaNzHCoumLtlCyMk+B5o8sd7I9ssWxQue+RmcwqifBaGyRblzoMJz+NijrPc27BaDCAE0IBt4SL8baOSPDGZYawFbepIiCIRCucwwpDpk9BOdMHJis1AP6oxyxEyTGPlZXC5/zRBFanaANJ6HV/U+lfV8=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:1I9n8CBm9uR9lRhBxAvFAD2HYBDgPQTcrLTPIZkmbzDRJMVdsLecZTGevVWmeCWristt84JQpS/y7pIX2lLZgyPqVeqNUSlkDUwNVbRU47T8fdhCiNe/vKx556JpusmAn6WE8Ds2LR6QzVmrhy6eMN1xXXpEioZplqmMndiQqfGntMqZWMobNNL+xllAvCW7XVgkrV2ILW+lObu8tKyDNlaaeUKA2FIs101k4A7w2OkUCAREKpDenDYBAtu2xVnjp1q4rtM8JruOPsWPtjJ6cb6Uy/mw7CQ9uE0IENThLRPDFNkIzwO6zg/nMLN/Oeg4O+Z6d4C13X72G5chpFU17Y8hdmiugSOnZOo8t+/gMhEZFd2aBuIm/LrZ+VTQTz89WgrfavTUelEcC5mXBpZeQA5utBtffGrAFJ99kDmnwFnMKwQZUJxlHNKtQYqRU17X+YPHjvsT4bIcvitscMvDZyqbZT/aHDrdxCxbD73gpke05qar8BvP1a9z/ceE8A1P;4:4i2gpSjU1j1yMOcneyg1+DWTmOBZDmeZ4EkyHzgfuVElXUD3kJN4OwQ/IxlHZyhX1KSTusn6T+Gl0vKVQeGa4lS4nc7+/9cWvlKmQoWs+2gm9NpyWpONAVO5VIb6Hs7bo3cg3ugSpHKYKtE+n0XUC3Y/hdbCfgAhhKwIzLiS12QVRRvvo8MfNhjxSGGjqF0KAmUQjWxKXEj3it74DdrSDqs++vt/0lFT6d5gnGP5+0FB3RmccctZ9KrbI3ACwW1IYArGpakR3WiRSMUhPEwv00qonzxDmNt76JoCBZcd1WxCxakXuFURfSisuGcXwXKg8H+vydsBj5aaHHuqws85gEAcKjH5a7NYPsZgkyx17IU=
X-Microsoft-Antispam-PRVS: <DB5PR04MB1608310C01B406143332E93DF63E0@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(11346002)(36756003)(446003)(14444005)(476003)(47776003)(53936002)(956004)(386003)(6506007)(6512007)(6116002)(105586002)(106356001)(486006)(2616005)(2906002)(3846002)(305945005)(5660300001)(7416002)(6666003)(6636002)(48376002)(50466002)(7736002)(16526019)(76176011)(6486002)(44832011)(26005)(81156014)(81166006)(316002)(8936002)(8676002)(575784001)(66066001)(51416003)(25786009)(16586007)(86362001)(68736007)(110136005)(54906003)(4326008)(52116002)(50226002)(186003)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:2HxuEGOgoh3iRUqsqLTf8G9QOUqvqB8AvW73swKsG?=
 =?us-ascii?Q?cYsUv3ZZ4QiRjdKPZo7ZhB+AxQ4n9t3/aSvkDccEMqA1FWoDyIuhvlmFxFnu?=
 =?us-ascii?Q?3oG149mMaNSM0c8E+Lay8CCR2AcQgfM6STLR3UYTATVYxZIJ3QYdRq0WGN0m?=
 =?us-ascii?Q?S3TUWThS3v98rptqTglIBMPAeTPqRjdqXDsV5gkwkrp6e9rZHiTLQfkhMFLr?=
 =?us-ascii?Q?QtTDvTcS4ClzxesJH+K+4T7mm2LmlWTOrVhl273VSZgzSj5+mczn0oQWLyxu?=
 =?us-ascii?Q?S7gAGdt6eL884HuyekpzjwU5WskhkiNVL3AU9M6TUcTZdXzOLNOFb/9WOWCq?=
 =?us-ascii?Q?n8ylhlkUiOESwyyl7B5CdKSlARmZu5Etqxkqru7uXj1rlYNze+hxMQSsscXQ?=
 =?us-ascii?Q?SHs/OqEZA6fpYwur+wIvXDgL8a0LdFk3bv1npng8ao7OCrJ/6v65gSXe0J4W?=
 =?us-ascii?Q?o4gBMiJWCBzqUdrTXfaZH9uftxtiZ/ZuqsJXQT1tkYCMZ21/zzHtrJNya+Xp?=
 =?us-ascii?Q?nU5UssHbAPZb+eA+4wB9VRaMspTOUJ305uHVY9fazLwINLmHX3S/HH++tmkb?=
 =?us-ascii?Q?VXZLdPJFbCTMdy0Fw+LTr3i4AhDULpSgHKE0jy/KkSbTASiPW8aFayVyI+ka?=
 =?us-ascii?Q?atAREbb8HpwHdMpFFsulyug7xOzDXBI+gLLzPSOWeaF+byR1jhdMe+39/8tp?=
 =?us-ascii?Q?FgLcf8VPeFjc3Jm27m5VyUpZ977iauHpa1yVOqABpRVYA+u6khvK34XyfICj?=
 =?us-ascii?Q?afxBnOhaRLVXpy1b1w59to0cpXXYTnNSpvpRVB8yZN8IcTrWSvgqWGYvvTg7?=
 =?us-ascii?Q?7l0Bb413f/wZn7D9vFAwQ/Dwi0xGW90bgALEenaJ57RIgA+4oPfbmkMow1+0?=
 =?us-ascii?Q?MBbHceC1wRA4f/EUD1S+nMwU/dBH3kKAC7ehv8L94u2WJiPEUFZsARXAwjAh?=
 =?us-ascii?Q?Ry/AyDVUhJDlUdFnvBbMqwnqCx4vSMCNQHXcB7k8MIp3+ztTCIqoawA4NDfp?=
 =?us-ascii?Q?xAZ3ORb97lmhJ+QBeBiEM1m64+2bk57E+w58B4oyfIvPi7auTByh8VD3J5AR?=
 =?us-ascii?Q?mUKbvQ24/G4a8GbDlhcD50ivOwUnNxgqHWVu05BkLRFHsyTt073nsmldgLzT?=
 =?us-ascii?Q?p3OCwuq6UMxzW966ZRxsSVICYg6gao3qC1+YdtWYmMMs8o0Nw7oq8D4AHDl7?=
 =?us-ascii?Q?lrBithw0g38RUPKiosJaenG5a0A16YsRPTvji9ge3gNdpDACUBMIt1Od8wlV?=
 =?us-ascii?Q?olT4+e4x2KISHEZJCAqD8wjv5TNuZF/Ul3kNPvtO5ip1xbYl8NXWw1H913Ev?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: ARkK5sfyUZ1LKMSgFMN4Siytkxy8Ow8PX5g4hn/0gFnlQ1qsRWDexsaA7Wffk1zJqSsImN3nCAhyPiyicUeZmaZStgPBsmW8sKAYSZc9WO5Umvva7lAbi1CbxQxo6K1JbraQBz7+GYBEnVpZYNYTU5ccY2yKw5dGq13+wnMaXbFQFt0oiJA9YvCsfY3fhvYL3+m0BT560H2lCgSUCHORNwPgLA6vMBwL+ZWGXoyRepYgRtf+lDOHk8Ml3n4terqsBdPFWEUYKVTc8wUruH8tofOZqAysC/ceo7/RUIVtO6NhALIqXnYLmvGczOCYHkbDcNwoIZWZP6ptoKAoLfILXI6dM50itav9fqpWOy85v64=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:vjNM9gjWhpL0wSZNTK3YU1oYVJjIpeooWy1QFZ4h2c8/KmsFW89McpogrSzgfSZNwKkM8EzdwgywrNxGQSQk4gzQQBVxQbXHZE/QU1630l+63wTJL4VIiaEjLR8wULks1/i/wUks31ppKk43ybpBUxGBz5xjuo0oQZNr0qKzwy02MIRK3XtFOvuQAUy1TzcFtKPnbcyLv/wikwwHmyrcBloqJOKwLBZiIx8uGzzBxDB9hwEgcjtr81e7/7jpw9qREhxQRmF4l9BH+0Kie3mvqUJy4uR3hPOZSvVsVGCrvjAf7bovUq1l6yLn8/hUanPdxozXREFg6mZ+UpQWRqahtnrllKPfTmnSqJqYWvIbArDdlU4nCj2Er+Hdx9rhnePvaT0v+kHnfUxUzcfdBdKeoXlUR7Nn6AAwBIk+SzsjYP5FTbH/BLmLZEWqhspHr7WeLWcOl5GffjBQTmxu5O6wVA==;5:4LtBa7qhXL9k9AU0I94c989jer3XQfXYseHed9Okfwkmu9xWzWNit6Bosfsi/kIvP828nvsytqoc4r+SCYqMouApBVoLIJiqMGy1yf+Hrh1e8BYwy5AeC0YATma3Fmm8Eop+7t3Jy3E8y4i+lUUwTnIwY4jnrUprTVrn7Upn840=;7:PonKIN6Q5DedqVkn4dXLVxWdgVyuu7MCdFWWtjIrB19FKNLUaCva1xzSepbzaqC6R7jVISYXVHwmXH8RjXdL8huth46eegxdv7C89nYJnIN4Acge8REhafYc7V0xLf9HJg5hABHRg2Vr2K2CilaIVGTmx7ri3BQ6lPJchHdKMw23txphzuW7/wnN5tPLcnloNM6sjjL1XZseya4Inqkm1voJPlmzOPxmmA2+nWQM0DHuMQsWIslxt1vRVUJZPO/l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 15:27:42.0433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf44611-b6cb-47fb-f719-08d6038ccf8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one more complex
clock type, therefore moving the complexity inside the composite clock and
outside of the SoC specific clock driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-composite.c | 471 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |   9 +
 3 files changed, 481 insertions(+)
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
index 0000000..751dabf
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,471 @@
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
+#define to_clk_imx_composite(_hw) \
+		container_of(_hw, struct imx_clk_composite, hw)
+
+struct imx_clk_composite {
+	struct clk_hw	hw;
+	struct clk_ops	ops;
+
+	struct clk_hw	*mux_hw;
+	struct clk_hw	*prediv_hw;
+	struct clk_hw	*div_hw;
+	struct clk_hw	*gate_hw;
+
+	const struct clk_ops	*mux_ops;
+	const struct clk_ops	*prediv_ops;
+	const struct clk_ops	*div_ops;
+	const struct clk_ops	*gate_ops;
+};
+
+static u8 clk_imx_composite_get_parent(struct clk_hw *hw)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *mux_ops = clk->mux_ops;
+	struct clk_hw *mux_hw = clk->mux_hw;
+
+	__clk_hw_set_clk(mux_hw, hw);
+
+	return mux_ops->get_parent(mux_hw);
+}
+
+static int clk_imx_composite_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *mux_ops = clk->mux_ops;
+	struct clk_hw *mux_hw = clk->mux_hw;
+
+	__clk_hw_set_clk(mux_hw, hw);
+
+	return mux_ops->set_parent(mux_hw, index);
+}
+
+static unsigned long clk_imx_composite_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *div_ops = clk->div_ops;
+	struct clk_hw *div_hw = clk->div_hw;
+
+	__clk_hw_set_clk(div_hw, hw);
+
+	return div_ops->recalc_rate(div_hw, parent_rate);
+}
+
+static int clk_imx_composite_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *div_ops = clk->div_ops;
+	const struct clk_ops *mux_ops = clk->mux_ops;
+	struct clk_hw *div_hw = clk->div_hw;
+	struct clk_hw *mux_hw = clk->mux_hw;
+	struct clk_hw *parent;
+	unsigned long parent_rate;
+	long tmp_rate, best_rate = 0;
+	unsigned long rate_diff;
+	unsigned long best_rate_diff = ULONG_MAX;
+	long rate;
+	int i;
+
+	if (div_hw && div_ops && div_ops->determine_rate) {
+		__clk_hw_set_clk(div_hw, hw);
+		return div_ops->determine_rate(div_hw, req);
+	} else if (div_hw && div_ops && div_ops->round_rate &&
+		   mux_hw && mux_ops && mux_ops->set_parent) {
+		req->best_parent_hw = NULL;
+
+		if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
+			parent = clk_hw_get_parent(mux_hw);
+			req->best_parent_hw = parent;
+			req->best_parent_rate = clk_hw_get_rate(parent);
+
+			rate = div_ops->round_rate(div_hw, req->rate,
+						    &req->best_parent_rate);
+			if (rate < 0)
+				return rate;
+
+			req->rate = rate;
+			return 0;
+		}
+
+		for (i = 0; i < clk_hw_get_num_parents(mux_hw); i++) {
+			parent = clk_hw_get_parent_by_index(mux_hw, i);
+			if (!parent)
+				continue;
+
+			parent_rate = clk_hw_get_rate(parent);
+
+			tmp_rate = div_ops->round_rate(div_hw, req->rate,
+							&parent_rate);
+			if (tmp_rate < 0)
+				continue;
+
+			rate_diff = abs(req->rate - tmp_rate);
+
+			if (!rate_diff || !req->best_parent_hw
+				       || best_rate_diff > rate_diff) {
+				req->best_parent_hw = parent;
+				req->best_parent_rate = parent_rate;
+				best_rate_diff = rate_diff;
+				best_rate = tmp_rate;
+			}
+
+			if (!rate_diff)
+				return 0;
+		}
+
+		req->rate = best_rate;
+		return 0;
+	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
+		__clk_hw_set_clk(mux_hw, hw);
+		return mux_ops->determine_rate(mux_hw, req);
+	} else {
+		pr_err("clk: %s function called, but no mux or rate callback set!\n", __func__);
+		return -EINVAL;
+	}
+}
+
+static long clk_imx_composite_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *div_ops = clk->div_ops;
+	struct clk_hw *div_hw = clk->div_hw;
+
+	__clk_hw_set_clk(div_hw, hw);
+
+	return div_ops->round_rate(div_hw, rate, prate);
+}
+
+static int clk_imx_composite_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *div_ops = clk->div_ops;
+	struct clk_hw *div_hw = clk->div_hw;
+
+	__clk_hw_set_clk(div_hw, hw);
+
+	return div_ops->set_rate(div_hw, rate, parent_rate);
+}
+
+static int clk_imx_composite_set_rate_and_parent(struct clk_hw *hw,
+					     unsigned long rate,
+					     unsigned long parent_rate,
+					     u8 index)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *prediv_ops = clk->prediv_ops;
+	const struct clk_ops *div_ops = clk->div_ops;
+	const struct clk_ops *mux_ops = clk->mux_ops;
+	struct clk_hw *prediv_hw = clk->prediv_hw;
+	struct clk_hw *div_hw = clk->div_hw;
+	struct clk_hw *mux_hw = clk->mux_hw;
+	unsigned long temp_rate;
+
+	__clk_hw_set_clk(prediv_hw, hw);
+	__clk_hw_set_clk(mux_hw, hw);
+
+
+	temp_rate = prediv_ops->recalc_rate(div_hw, parent_rate);
+	if (temp_rate > rate) {
+		prediv_ops->set_rate(div_hw, rate, parent_rate);
+	} else {
+		mux_ops->set_parent(mux_hw, index);
+		prediv_ops->set_rate(div_hw, rate, parent_rate);
+	}
+
+	temp_rate = div_ops->recalc_rate(div_hw, parent_rate);
+	if (temp_rate > rate) {
+		div_ops->set_rate(div_hw, rate, parent_rate);
+		mux_ops->set_parent(mux_hw, index);
+	} else {
+		div_ops->set_rate(div_hw, rate, parent_rate);
+	}
+
+	return 0;
+}
+
+static int clk_imx_composite_is_enabled(struct clk_hw *hw)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *gate_ops = clk->gate_ops;
+	struct clk_hw *gate_hw = clk->gate_hw;
+
+	__clk_hw_set_clk(gate_hw, hw);
+
+	return gate_ops->is_enabled(gate_hw);
+}
+
+static int clk_imx_composite_enable(struct clk_hw *hw)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *gate_ops = clk->gate_ops;
+	struct clk_hw *gate_hw = clk->gate_hw;
+
+	__clk_hw_set_clk(gate_hw, hw);
+
+	return gate_ops->enable(gate_hw);
+}
+
+static void clk_imx_composite_disable(struct clk_hw *hw)
+{
+	struct imx_clk_composite *clk = to_clk_imx_composite(hw);
+	const struct clk_ops *gate_ops = clk->gate_ops;
+	struct clk_hw *gate_hw = clk->gate_hw;
+
+	__clk_hw_set_clk(gate_hw, hw);
+
+	gate_ops->disable(gate_hw);
+}
+
+struct clk_hw *clk_hw_register_imx_composite(struct device *dev, const char *name,
+			const char * const *parent_names, int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *prediv_hw, const struct clk_ops *prediv_ops,
+			struct clk_hw *div_hw, const struct clk_ops *div_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	struct imx_clk_composite *clk_imx8;
+	struct clk_ops *composite_ops;
+	int ret;
+
+	clk_imx8 = kzalloc(sizeof(*clk_imx8), GFP_KERNEL);
+	if (!clk_imx8)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	hw = &clk_imx8->hw;
+
+	composite_ops = &clk_imx8->ops;
+
+	if (mux_hw && mux_ops) {
+		if (!mux_ops->get_parent) {
+			hw = ERR_PTR(-EINVAL);
+			goto err;
+		}
+
+		clk_imx8->mux_hw = mux_hw;
+		clk_imx8->mux_ops = mux_ops;
+		composite_ops->get_parent = clk_imx_composite_get_parent;
+		if (mux_ops->set_parent)
+			composite_ops->set_parent =
+					clk_imx_composite_set_parent;
+		if (mux_ops->determine_rate)
+			composite_ops->determine_rate =
+					clk_imx_composite_determine_rate;
+	}
+
+	if (prediv_hw && prediv_ops && div_hw && div_ops) {
+		if (!div_ops->recalc_rate) {
+			hw = ERR_PTR(-EINVAL);
+			goto err;
+		}
+		composite_ops->recalc_rate = clk_imx_composite_recalc_rate;
+
+		if (prediv_ops->determine_rate)
+			composite_ops->determine_rate =
+				clk_imx_composite_determine_rate;
+		else if (prediv_ops->round_rate)
+			composite_ops->round_rate =
+				clk_imx_composite_round_rate;
+
+		/* .set_rate requires either .round_rate or .determine_rate */
+		if (prediv_ops->set_rate) {
+			if (prediv_ops->determine_rate || prediv_ops->round_rate)
+				composite_ops->set_rate =
+						clk_imx_composite_set_rate;
+			else
+				WARN(1, "%s: missing round_rate op is required\n",
+						__func__);
+		}
+
+		clk_imx8->prediv_hw = prediv_hw;
+		clk_imx8->prediv_ops = prediv_ops;
+		clk_imx8->div_hw = div_hw;
+		clk_imx8->div_ops = div_ops;
+	}
+
+	if (mux_hw && mux_ops) {
+		if ((prediv_hw && prediv_ops) || (div_hw && div_ops)) {
+			if (mux_ops->set_parent &&
+				(prediv_ops->set_rate && div_ops->set_rate))
+				composite_ops->set_rate_and_parent =
+				clk_imx_composite_set_rate_and_parent;
+		}
+	}
+
+	if (gate_hw && gate_ops) {
+		if (!gate_ops->is_enabled || !gate_ops->enable ||
+		    !gate_ops->disable) {
+			hw = ERR_PTR(-EINVAL);
+			goto err;
+		}
+
+		clk_imx8->gate_hw = gate_hw;
+		clk_imx8->gate_ops = gate_ops;
+		composite_ops->is_enabled = clk_imx_composite_is_enabled;
+		composite_ops->enable = clk_imx_composite_enable;
+		composite_ops->disable = clk_imx_composite_disable;
+	}
+
+	init.ops = composite_ops;
+	clk_imx8->hw.init = &init;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		hw = ERR_PTR(ret);
+		goto err;
+	}
+
+	if (clk_imx8->mux_hw)
+		clk_imx8->mux_hw->clk = hw->clk;
+
+	if (clk_imx8->prediv_hw)
+		clk_imx8->prediv_hw->clk = hw->clk;
+
+	if (clk_imx8->div_hw)
+		clk_imx8->div_hw->clk = hw->clk;
+
+	if (clk_imx8->gate_hw)
+		clk_imx8->gate_hw->clk = hw->clk;
+
+	return hw;
+
+err:
+	kfree(clk_imx8);
+	return hw;
+}
+
+struct clk *clk_register_imx_composite(struct device *dev, const char *name,
+			const char * const *parent_names, int num_parents,
+			struct clk_hw *mux_hw, const struct clk_ops *mux_ops,
+			struct clk_hw *prediv_hw, const struct clk_ops *prediv_ops,
+			struct clk_hw *div_hw, const struct clk_ops *div_ops,
+			struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
+			unsigned long flags)
+{
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_imx_composite(dev, name, parent_names, num_parents,
+			mux_hw, mux_ops, prediv_hw, prediv_ops,
+			div_hw, div_ops, gate_hw, gate_ops,
+			flags);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
+}
+
+void clk_unregister_imx_composite(struct clk *clk)
+{
+	struct imx_clk_composite *clk_imx8;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	clk_imx8 = to_clk_imx_composite(hw);
+
+	clk_unregister(clk);
+	kfree(clk_imx8);
+}
+
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+			int num_parents, void __iomem *reg, unsigned long flags)
+{
+	struct clk_hw *mux_hw = NULL, *prediv_hw = NULL;
+	struct clk_hw *div_hw = NULL, *gate_hw = NULL;
+	struct clk_divider *prediv = NULL;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk *clk;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = PCG_PCS_SHIFT;
+	mux->mask = PCG_PCS_MASK;
+
+	prediv = kzalloc(sizeof(*prediv), GFP_KERNEL);
+	if (!prediv) {
+		kfree(mux);
+		return ERR_PTR(-ENOMEM);
+	}
+	prediv_hw = &prediv->hw;
+	prediv->reg = reg;
+	prediv->shift = PCG_PREDIV_SHIFT;
+	prediv->width = PCG_PREDIV_WIDTH;
+	prediv->lock = &imx_ccm_lock;
+	prediv->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	div = kzalloc(sizeof(*prediv), GFP_KERNEL);
+	if (!div) {
+		kfree(mux);
+		return ERR_PTR(-ENOMEM);
+	}
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = PCG_DIV_SHIFT;
+	div->width = PCG_DIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate) {
+		kfree(mux);
+		kfree(prediv);
+		kfree(div);
+		return ERR_PTR(-ENOMEM);
+	}
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+
+	flags |= CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE;
+
+	clk = clk_register_imx_composite(NULL, name, parent_names, num_parents,
+					mux_hw, &clk_mux_ops, prediv_hw,
+					&clk_divider_ops, div_hw,
+					&clk_divider_ops, gate_hw,
+					&clk_gate_ops, flags);
+	if (IS_ERR(clk)) {
+		kfree(mux);
+		kfree(prediv);
+		kfree(div);
+		kfree(gate);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 12b3fd6..9dbb680 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,13 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+		int num_parents, void __iomem *reg, unsigned long flags);
+
+#define imx_clk_composite(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, 0)
+
+#define imx_clk_composite_critical(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4

