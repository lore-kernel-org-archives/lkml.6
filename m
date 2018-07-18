Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78700ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A602075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRrYc5/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A602075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbeGROSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:22 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:46816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbeGROSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRmoxj8s/rkF0u5QZEW18bzYyMu7I6QKAx0nCCgN7KI=;
 b=GRrYc5/FEkDM6aRj0ckpDIHozNNkEULqyRS2lVpRfRvjn5I26e/g301zki+4YsCEhwahQAgfyzlfq9G/UzkSChqNmbNfrlOkLulKjstnJ52cPk+3UlkTNo7z8nWyeooeToe6BEp4HwK8BkMbt+EBzwaWU3ppcDmlaQ2mNNRuSSA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:11 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 5/9] clk: imx: add composite clk support
Date:   Wed, 18 Jul 2018 21:36:59 +0800
Message-Id: <1531921023-18497-6-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: af844a8c-ce30-4e5d-2d62-08d5ecb3fe76
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:RMAcuO/AmHHnEr56l+QujF/2lH2BGLX6PJoPKrFYuTr1r0Ad0LXmNPTk304spLwR11pYElc/MNLO09M2i3dOE2zthbVJwkN0byUdZNDT2u1TvYG/lshe6c2z9WUivi1mKP3hk3dikNj7zAQFfMHWwEKStJJF3eFzRP/Qs/1skEJ+bPyEI631u+Es6rXqVh76jvwqcdPAPXjYK8Lsk2hJcM1BPDGlypWt4bnzjXlLJPgEZ9dKjik/lDD8diM9ARIi;25:anXJZdV0YXTslF0LFxreKtdRlpgWDxWskmVVcqtwUghJb/JF2w+Hpm4JMsIIIRVANDyXCqVrDRiSSl92+uE0j8E9W10VayRaVxV9+uOjP14r1D/Aexaida3ge+ZGe3rvqnx4k9LUAi+e6EqmwuBParxxFl8wI5vVaYjcRNARs0z4BTsZbQb8WBZQyV13lm/kWJl9xaG5L24FN8unouEOp5P8ZSiZWRE1M9LDQxhwYxeb3JEL96mq/ib/GHP2JQMxqTVx8r/Od8WRBactAazKZXqiQ2E1+J4c5plFyyH3Pbpek1F1YGPVtUBsYyPMRh1qK2kd87BQFXW4ipdyAUK85w==;31:giWVPGtNAVvbEZTsjkV1a3grmxGIQDkgcdHzIdgrxV9g16rC9pZoMiRcgHHI8PXV7FvH1YgNVWwhCiKO8jP2idW4wVRXetEIdWWkLJhVE24AkQyi3a5ZKDfe7b07m8hPLhzRFa8JI+VfpkFYEI0eoFsp4+i5D7/fPRqGjsBIIl+5C6QsjtsNrB1ajFBSWR+FM2QFsMaLC0l3ldLvOx+Xm2rWhbTo7gfoEumYkoUXDTg=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:FoxOzUzOCQ5JATGaAb9aZEoHy5hHC9y4O/9dg6ouYDLMALF7kKmbRl/GFfczdSlS57pu3cVrPmNtXviFIg7KD0UeA4g9tw+qJAuUvog3cOQ2XVssKGsB0nBR7MJWe2lRbPQGnxNFpqCTZ+bKu3Qxf88j7f5XghEzQJGw8pTNiL5jIwWgzUsZucgH0WqRFBSozmd+X5OIJqUiJozeYh7u2Y9rdijBLYru5XOhwXQl3XpgMvyjp5u4gZbDtZKS1uKjn5mucHU/QsXtkikUYwUzcVOlZrR4B4GCssnYA39PLTpB5Ew8Ikpdwc56xOzhR+6rd+vl9HMEX3M2mkb+le7Uc7EEt11IHhSTE47Y3WwQM/kmmwi6bqV3Chc+p7axAhbFIkZP77zWzhD3OTdAuub5nRihM3UIH4xK7yR5ToTSoCw4ZyT+e2lbeDmnMHvDRRzk+vmjAnjWVt+13K1P+Qerd+ttUPPoYsGi2f36htfd3IlB63463id4t0qNZOwaB6CX;4:j0wg1ebseK4AM3ZWeYbSPnnwXVQZ6963+fVkwdh9jh8fDjnDj4v6T5sqnqm18M6PXx7bs7x4QSTPOAuhmzslIPkIv0p2BVDgWAoZ42+0GZJaDx0lyTKN0AcNldFURbhKF2fEZGsu79Uou0SN5SzCfV2Q1UgmJubOiG1hmd4kFuE32b7Mv2Fm25EfHwTcO1sXpPNCDawnNMyEremIB/OU5UUtXVqS9AUgip0H9A7pOxDCIQ/ILfC2sHcIWUXA6hjywvdlA/8cUDBk0DPuXGKLMYEtkmPujUYTJJ5wXNehlRKoNIjXR6qvF4OD/tToZmm8
X-Microsoft-Antispam-PRVS: <DB7PR04MB421950EA623EEC7F8163340780530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(575784001)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:XsFwQWIqBf8kXff+UZBcBBgFDc8MSp6rzwMtXgeDh?=
 =?us-ascii?Q?CPVOyCUe4q/pYv8cFvdHvk5posfQmabd7QYNUjeRB68rqg1tFYi6N8DIyhSn?=
 =?us-ascii?Q?LclW1CeDw7uF11Fz3Wcv73ZjW7LTK+mLii0Vok0s6+a2+eBP8u5onrxPnWbu?=
 =?us-ascii?Q?kkG+f+9cuzasD/inCzvu0umKTtfIWccssG1P1UcTNw8OfR23sQz/TvkoAjo4?=
 =?us-ascii?Q?s78c9uRlgzHa9pP5M9rE4ZbGeIyYq68DkFdYf+ZxiG5Aj/3u0TNrM/6Tpy13?=
 =?us-ascii?Q?3k4a8L98H9tWx0+GGd6OhX4n24jkui4aoE5TxUGHAMC/Dxxfy5aqZnW8gTPz?=
 =?us-ascii?Q?+/EH5XZRjaQb93AvypW99qCKUYJ0/dCTmskFZ4naCk+m8T7wm8dmpCS+mv1T?=
 =?us-ascii?Q?Dr/T2+qBjNbpSehCf1Cj7c0c97gNjdztU81p40fV1OABhgIZlTzKmIB3rliM?=
 =?us-ascii?Q?xO0K7NLeB5vm0KNUz6nWyJHcK0AEX5xu+3nVQy8AtFyAU9JDDswnwDYYWkRC?=
 =?us-ascii?Q?HzhA8rnW/mhSPV49810QEmyw5UslIRk9JEiWdaKlDEQjpqDIrgzaZbJ6CHmx?=
 =?us-ascii?Q?N+FaNUz2fmfCVIoQy7BCxQUJmydLe20bDGBlVK4LQtJQJO3imLD++odVmXEW?=
 =?us-ascii?Q?+Ovnm0uAyvAWUvTiZusDqhEfmGhuapAPs8SmrtepUz9tKEhEeVpe5dBoAGmP?=
 =?us-ascii?Q?ziIrd5htSLwfKyCdjT7KC1Eb76CE2qGSv+Vp97MjSUje655sGvsupiKJFWtl?=
 =?us-ascii?Q?TwscfAkDKdTQQQ6vfIvg+YYgSNiCQiOl0BiJGzYKXNMrKZyr9tsgATqfu6Zd?=
 =?us-ascii?Q?DCOXAYUjPzAoXr03a6gWz1hjVKWVd8LVkqXsZ3HPe8je5PIYwiq4AyRml+sK?=
 =?us-ascii?Q?3JcDeE7ae510meR+fh46qdAnlwSfJOPS4ii8KgApLPoQszGWCLkgWZXaKT1t?=
 =?us-ascii?Q?75Fz5x29SvYFJ+V/5RqD4GEh8LD/l+EjVZ9s/dEG9Syq5S4t2CFgTTmRNUpq?=
 =?us-ascii?Q?gxOInXzhWsaAyULyp9Q/4ggfK5/WyJmwxa1qqegAFHVa5mGeReYi9lIgOHGm?=
 =?us-ascii?Q?s5Y6SO+TbIn65nhqcLrQKj7U10SVApoKpkO6262QHr/GBRUcR0WSSUZLXt5Z?=
 =?us-ascii?Q?2MFLm6mLDiqVhQ+7mvFzcmYywkPvNX1Kjm0xE41bACAxnvMPvAbuuv1QMiqx?=
 =?us-ascii?Q?jwE8s3tLyPpN+GL8YElMoBG+6aDdmIr4xzKC2/DiggfhWXYutAFSgIVd6+FY?=
 =?us-ascii?Q?uc4oPoWEo7/yC4sgQbSTzmLqWSabT3t5YNqaXMr?=
X-Microsoft-Antispam-Message-Info: L00GVuOifn/ObIlYjlI4OIXR+G17rIXRDY7vpRf5liAoqdBps1t772m2ADc+ly3n53b3+Ws2LZA2gkFg6cFJovdMYmS9RDBBQNF2ojKvs68BHqLI+qrMMKndJlbzON+amxgYrc2w6CD3sB2znyGQaL7mQXj/zApq9oXNkh8HOsZa4BdmrcfsQIqkkPmt84Recl/gz/7pLcws/GlhAf+y5XfPqGYVOLzChPTdzo7sVt+gyqMBcDaTWRvUPaMBl8flKNqGP9Co+HmFrJad7oCV7GCmvV8SATBdzulL/APtdeLPgw9kAShQyHVg2HcSJ1pvzhjk5E5Av2WLx1PtARPHiuQLGaqVapwVad+HZ2lMAuI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:KG+/5sWD3ZmvR2g5ENFTMvBXpoqkaBUWUCP83Jj19YDb6ZnUylZq29CuCBFDYXFdOXaTNpGXkszjJOoPiW4Xw3wqx+nx91ByopxgvefY02OmSbPXpjMaOGh2M3zgFN05tNe6wHfsp3Hil4sEfpgbXfdno5VCPVOwUjyrxVX2DovlQWjJpKYKY0dIp8Xo3ZQ9gCWDPJsEvHdltNGNmesosFJt0rSFj5Z5MgRpv9JaIyCtjDb9KBJc+dciXx3rzZptHuhZQ+zU7/wDijUD/77Lgiud8BoLLF6FZZv11SYpDsyF/XslZIrXzL3gB45pQ/ozXX661Sz9UUMzXDF3ZM0kqBqhxQQnuvBBLSc4u/JZTyXGB29rvVF7ePQhODNHoCeAKg9Tdbl3G31wWyw2vyVu5l5faVYVygxdq0/sUlNhFxAcTMMs9Cgq+0eVCXoNsXUvDukEGRqHk+E5oi3uXqoT4Q==;5:z47wHojkmdB7oIXad8B0empoHqtbLk/kRTuuQpM8bQQBWyfze3haN240xI0EgBWfaNy8xPpA7BWyY9SHFci7CqAECo9b1ob6xq9Y6/B7qWR6MdDTe0QQBoP/xwxsO3eNDoZweCREdJBRuVKDNQCAxnx0vaWCBjhTBchR3tziBps=;24:84Epa1wSXjMPOJAlSebqB+kUd5RrYyx/V+hhAgkNIC5XZrTVvcDSmS3SK35Wllo4fpTUMJsY+R84HBmSkUfTTljtFJAK8MJwFE/OD/wuTJs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:HbcUtnRTqQqfOIRJGATy3mWTapCoLI1PVhHeRMz88SA1Ufb7kr+yC1+r1/D+rz6lume5mWwWgQnkphwiuDuFfa4H3dliUOk1WA7JVdaVewPnSxIDYsdbgBmAQFWqO7sBGpogioQKrf49xGFZfsluexZmh1wNJAWIbBSRc1vln/IMlfJmQff8UX6jKXvK5JMvIlh8G4umq2vkPL3QCA05GQuZKI2NqerzxGTGkUJ117x1KW0WQC5bC8Pi0SgyAfTC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:11.3844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af844a8c-ce30-4e5d-2d62-08d5ecb3fe76
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx composite clk is designed for Peripheral Clock Control (PCC)
module observed in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pcc can only be operated when clk is gated.

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
 * remove an unneeded blank line change
 * use clk_hw_register
---
 drivers/clk/imx/Makefile        |  1 +
 drivers/clk/imx/clk-composite.c | 85 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  6 +++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index e5b0d42..f4da12c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ obj-y += \
 	clk.o \
 	clk-busy.o \
 	clk-cpu.o \
+	clk-composite.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
 	clk-gate-exclusive.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
new file mode 100644
index 0000000..297974b
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#define PCG_PCS_SHIFT	24
+#define PCG_PCS_MASK	0x7
+#define PCG_CGC_SHIFT	30
+#define PCG_FRAC_SHIFT	3
+#define PCG_FRAC_WIDTH	1
+#define PCG_FRAC_MASK	BIT(3)
+#define PCG_PCD_SHIFT	0
+#define PCG_PCD_WIDTH	3
+#define PCG_PCD_MASK	0x7
+
+struct clk_hw *imx_clk_composite(const char *name,
+			      const char * const *parent_names,
+			      int num_parents, bool mux_present,
+			      bool rate_present, bool gate_present,
+			      void __iomem *reg)
+{
+	struct clk_hw *mux_hw = NULL, *fd_hw = NULL, *gate_hw = NULL;
+	struct clk_fractional_divider *fd = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk_hw *hw;
+
+	if (mux_present) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+		mux_hw = &mux->hw;
+		mux->reg = reg;
+		mux->shift = PCG_PCS_SHIFT;
+		mux->mask = PCG_PCS_MASK;
+	}
+
+	if (rate_present) {
+		fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+		if (!fd) {
+			kfree(mux);
+			return ERR_PTR(-ENOMEM);
+		}
+		fd_hw = &fd->hw;
+		fd->reg = reg;
+		fd->mshift = PCG_FRAC_SHIFT;
+		fd->mwidth = PCG_FRAC_WIDTH;
+		fd->mmask  = PCG_FRAC_MASK;
+		fd->nshift = PCG_PCD_SHIFT;
+		fd->nwidth = PCG_PCD_WIDTH;
+		fd->nmask = PCG_PCD_MASK;
+		fd->flags = CLK_FRAC_DIVIDER_ZERO_BASED;
+	}
+
+	if (gate_present) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(mux);
+			kfree(fd);
+			return ERR_PTR(-ENOMEM);
+		}
+		gate_hw = &gate->hw;
+		gate->reg = reg;
+		gate->bit_idx = PCG_CGC_SHIFT;
+	}
+
+	hw = clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux_hw, &clk_mux_ops, fd_hw,
+				       &clk_fractional_divider_ops, gate_hw,
+				       &clk_gate_ops, CLK_SET_RATE_GATE |
+				       CLK_SET_PARENT_GATE);
+	if (IS_ERR(hw)) {
+		kfree(mux);
+		kfree(fd);
+		kfree(gate);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a5a9374..bc43f68 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -71,6 +71,12 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents);
 
+struct clk_hw *imx_clk_composite(const char *name,
+				 const char * const *parent_names,
+				 int num_parents, bool mux_present,
+				 bool rate_present, bool gate_present,
+				 void __iomem *reg);
+
 struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
-- 
2.7.4

