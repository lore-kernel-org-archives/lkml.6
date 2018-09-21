Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A40ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E839221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LB3BxQOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E839221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389586AbeIUSBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:01:20 -0400
Received: from mail-ve1eur01on0040.outbound.protection.outlook.com ([104.47.1.40]:64768
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388944AbeIUSBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtHEEvRM2DMReWf5kbqx6ieAhRxAOteOVt4WK4r9rOY=;
 b=LB3BxQOzZCnwZtI85XQ/wZbGp9MC2FkQLoT8B/+GGr3ozhUituIWy1bH047b0+v0ChhNBkXMNdzsUgbc34X4Hn26WLrDRPk/VWNVMBjh9d9UNXC9a/5KxT7dg5mAW0mIlb+2SYL4ys5wMW6dp8NtypNJskdEEJJOt2YfsBKZSJg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (2a01:111:e400:596b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Fri, 21 Sep
 2018 12:12:06 +0000
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
Subject: [PATCH v8 2/5] clk: imx: add fractional PLL output clock
Date:   Fri, 21 Sep 2018 15:11:31 +0300
Message-Id: <1537531894-18499-3-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9437a4c-2d06-4c02-748e-08d61fbb7304
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1614;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;3:lw+JR1h/FDZ2GJK8V36ASGYiKZdOcqVZLjALXfFQ10HM8qZ3bUDnYQ+C9h//2/0Zx78fSLgR7l1QIApMrBClLLDPGW4tUeKFs8dpwQFrw+ZSVvMfiaCmgKMkCAKZJKf7+k592bVmjd8aYobP4fDhABzytUzMSSrlr9uXMn3gBxrGjOQoyI5s/3ooaqKk6ufI4d8Mxb76CMk3HOdBObSQ+gPWGp6u/mJHCcFVKyCajX3bCrA1YHyGsuWRC9m6p1v+;25:QDazFBJFI4mHCJrj6vM16vh8151w+21+zO5u9dvCoPC5Ic4n71Deyt9Hgom2JYaS7rg0HzYCKVonbPxl4P6rJMYmrw/Jd6S/ILzR7pm8AaSxh4gEozAjplIj5Cx8NO74BZL0a2XpLpKUE4xOROqnUVSt85a+kzQtDlvSUDhYx6cpEhLPVCXNfrMWXgBix1+YuydaCDsC/ZdYyc7aBUyKmXIAohiGP5rP++uYHZVRZR/nu7n6CKDBr/OOhwc0JFt0XaOn9Rzc1bti6PGxuauFTwAVDlnzNbhBgVjIYAfkUkxLqOqrJvhLEdXwgDetI4jsUX3qoWHE2u2QcKx0DMP+WQ==;31:p0zPe0DqXy3cRYNUeZQoe9WD9vjwTI0L3b6r9i98AYg5WcJ29ZkGSbCR0bTA4YAKxqXiEiT2Rt8vKEn92JYYiOPsrwNiJ+gnhhtFsVZ8NCkeAfLIe7K8/W4EJWmKCYI6bLms8LLzgE+ZxHmjcUtsS8VJdcy+EOBrfcvQKO83kBZ0/A5jppZu3oh4DLJVsk3lDoGxq9RcAjeyWj4nKIrGl0ZzGY+cQNCmXidY6y4UCm8=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1614:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;20:nhmRWqthY5oPvdqwtMJwxHF/DvijdXcoAkgk/gBExFH3r8C8iELODC7u4Cal7ZORLKcKp/pOdRygxrCJdf76XAQT0DwQmdurj3JY7nvBX2+Sseu1jcpFb2PGmtn9iX714sWqwcCr+yuMHLHSgS/EmOw4c3UiU9W8aoH9j84f9Ho1RUfmsDOD7WTj2qNT10EQ84s2VhSSh/L8/Vf3lu8wDlYAVTk0X4brMtZwp/C0JoEY6uymrKJF8Sa8aFZJ3JaLDQaRUL17OgjH6W+/boJELir/zep6DWknI5QP1UHz+nwvScxaN9ZIz4WclVspOs5EThIjl5GvUSlv/1WjtRDqu0Ex+WJMN4sTZFhVZIoaCTJfPn2Z/BdHafN9rq2W++KytjGa6pxgfkBdha9e1ZtVdVeIqwEhJij9YPg7E+bDGDq8hlaCHXfF2Joj9SO5td0PdbI1wHU1rJGsjaLX8ouQcPMZKlU1ta3y7AP8oDPTaBJcg1efVGN8UFepTfU3Q/SQ;4:/fCzSAIsxBAXuaq/rJvotNWWSnW1he0EPKprMvgNSEnoc0WsI8H+qdWdIfdDyaboVj0zJxS/a71sS7eHY+MEUg3CVfAopX3eZC6PDjDXxT7fHX60zZXhnaGuGx2BbNLUR9XT+nzqDSLQHYwXRhAu8Ml3sTKyAZgW1T9/k4wEvX5m6QdjS7/6WvmmKb2D2ZHiHJI9OYvJlj16JLhXgJ9HkYDh15fHdGcnXupCYLL69r8WfqpAmPlS1tXJsa87BYtS3xquGyARJx3WB79LBpm+d7e+ARbouwkbo/PexhQX6YMhNbBBYLYylNhd5sjqcw5i
X-Microsoft-Antispam-PRVS: <VI1PR04MB16143EE96BDEBD26E108C9E0F6120@VI1PR04MB1614.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1614;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(97736004)(36756003)(4326008)(6666003)(25786009)(6512007)(186003)(16526019)(2906002)(47776003)(8936002)(81156014)(81166006)(8676002)(16586007)(66066001)(50226002)(6486002)(6116002)(478600001)(54906003)(110136005)(14444005)(68736007)(3846002)(51416003)(486006)(76176011)(26005)(7416002)(106356001)(386003)(6506007)(44832011)(52116002)(86362001)(5660300001)(316002)(2616005)(956004)(476003)(105586002)(11346002)(446003)(39060400002)(48376002)(50466002)(53936002)(305945005)(7736002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1614;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1614;23:xUB1iiKtwQVYRRTjU0JnCAJaCAMVYEmbKeJ65gWtA?=
 =?us-ascii?Q?pj8h3OLWS6rD773Pnyz0w34ynvTJZTIu+3IKW4/mrJjJdERA2tAvjtWHAnRp?=
 =?us-ascii?Q?1nINhFOdrarYkxA6RJU+OBzpfLqdh65rbF4cvl2aEZ+TMb696VN1nBolyHkj?=
 =?us-ascii?Q?lMya9qcQpphJHjDeT/0bFfjTzTButN5Ctom6fmwwQDSlJ7RoMvJGfsC/xB2c?=
 =?us-ascii?Q?P2a2Y/N4pUI5dVvpffqes4XNm1DISG+iHzgQcia3fNuoL6cWJo3vekuSIUMl?=
 =?us-ascii?Q?2069tY/IdxZ9MM7LuDZHjeOh+Sdnoj5KzQaK9a5/UxXIgwUHE/A52iAIhGJ3?=
 =?us-ascii?Q?gIoviYbXUhQqh5T8f/99lOnFtWYjCV8mGy2hLJvAhhdKTwOeYTblBqLaYJw/?=
 =?us-ascii?Q?a4Wq3HzC50a86/UItTw1HjEcunpTQI1tusW54e0fHdGUM11cUdLpCs3R8AbP?=
 =?us-ascii?Q?QTxJwpcKC2QXtu7hfQXIOBBXELHWdDgnQhy8SmoCGi8q2Y6kRIGUaoq/OQuM?=
 =?us-ascii?Q?V0tN159dHADPAzetCkNAZUxXM9UT/r5+AlG2c4u4A3apSHEEimkxNPQy47Xv?=
 =?us-ascii?Q?55J2C4Z74IBHaccGAwqfGKP5MBSmjXO5qHDJHGZvaMtOMtcEQG2As9uPK6xG?=
 =?us-ascii?Q?7NReWuE1yUWPExyciaqVdTTL6/xZIenhJxNO52oOILIuFdk1rt6bP7SFj7Hr?=
 =?us-ascii?Q?Q0C4thCFWOgyczInB/LMyld5tKX/qIIQn5zFZxccg71LASfya2fSje0Uyw1Z?=
 =?us-ascii?Q?n+YTB3LJsMl+8nbn3UuKZRQd6Tbgrnb6C6263+fJSSGdKQp0sT99ycsPBEJ+?=
 =?us-ascii?Q?AxpJyoeY5mpJens8kKLSPz9l7wUJ8GefLwfcFKhX9AJgRshLRSSAGyKhEnqX?=
 =?us-ascii?Q?0GQwPCD4PCJG29Bz5gOBM8bEqLiaG3qCzkMo5djq428hJL7g47z6ehSqJT8r?=
 =?us-ascii?Q?kKqN/t/3jxEvXPpH1D4sgxfqezKWjuANNfJtuvUIcBWiRk09v9HloCE9+1EX?=
 =?us-ascii?Q?J2ffYmxyRAeft3W2SYlLrAxHGkOoAx6s1xqMj2jKJHpB7ads8sVGdxxZn0gB?=
 =?us-ascii?Q?C7NqNrEnOy91g6sbChukShnVLRtSAmMA58JzK49yt22DmqeUUOdFWPy48ome?=
 =?us-ascii?Q?9biLyuwpfeHYOhG6fFxCN6Qyos1m+mgK4sCRIW/kc4qMPvnPZ7hffhZZwTbR?=
 =?us-ascii?Q?2kzISD13mXhNJpGdXRuq4/hsWzzpzifEqek3et7cBCZMrrIE/oIlLPgZF0zO?=
 =?us-ascii?Q?DAUOmxcMYmmni3imMBtM0/aSxQitJ+7vTIFdwdatMhWCa04Avils1YnEOqHa?=
 =?us-ascii?Q?UYsWTzq8Zs5FUFvLqfDrwsvwxHbYHgVyAStXD62870kdcjBKBCwCopJRq6FT?=
 =?us-ascii?Q?RZv0kUE3dGT6KOzKQrf9PT/ngo=3D?=
X-Microsoft-Antispam-Message-Info: ZZawDZwoa7Wcf1amElo5s6o390toDK8qJ/L2hQbhURkWBuWpnvs68I9QGcYkj5F2wxDQOPS+a3LejBjG7ei0O9V0WWELh9LKBY4P5vN8CCJpkeydtFYIj/zcujtD7LSZ3bzIP8vLNEHATNcyrJoWcQM5RAb/eQsSzSftocPfeRFAugr1RLa1wXqrfzPMLxxVmUDs/ulpNnlKzSoSFe37MVx9QAKMe3oTDdqsC27cKf8fl5zWFNgrTRmQmA9vHDNqwQTu12w3j5Kjxs5V/cg762zgEGMzEEA84zc8r9nStRtlhVZdgn0+e+pj/eMhtGizd+cHFmySmqsZxoAVb2jgvbStwej/pvHMcWZ/fJlW7Qs=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;6:7RIKU2k95ELkazMG7ig7+nPN9/rD8cAekZJG/TpeQMVag4mYLV0tgc8Ahvh+CGr0vjzaCpOTYxzy/W/PIfRDRvurwslfHdj5uKXBcbBHFpdcaN9hL9gTsb+QyDw0tBmIqzlAK8OIGQRv/CIyOonEpsrqULtFOmV592fEVYXFVCPhlRLwFZUD9yfqrik61Vxu9MJAwuEE0uiuoqMze7RTVjTKIenzhIoZcs65D86bqK5iyb1RY0VTc1gu7HaURzazNuGmQRfQQargf3FWIm39biYHimHGX4OADd8MQgsAOXhcaVPZn1aPLtoxpdxNwVbHxNc28I+F1N0avJThwt9XnQ8fThG4hqBhp+K4gHMkTxQi3oYlMRdCi1NNq1mvjaAWuOiaq1U/aQbSP2fjJzB4f/migUZ886+2ErAHoNYezKehV8zrWOzEXBMh1nI4Y2JBhoNY8WfEsaX/cvJw3T2+bg==;5:+ZIa/bWxuGZjybVr6xpseFAx3LotlYJknhStIujsLu2pK2ieCEScb35XyQGVqjF8IE+o8Mg8L9qTGX8MnqosVr1fHENvgbUzL33oNwnabuyNk4B8vg7HULf6QEcSd2oe8QocwGFOZaJaSFSvJvgUZCiqXixmiRlSdHjH79SEr1I=;7:0weXicdIc3rNQjY+kbg+V69AG7EDjBh7LS49IRMXnHUDHW1xd3fV86cs7GMvFMO1GroIHACe0qcSVfYz18BJfGoz7sle9LhiOGHES/Ir9G3D6ztHdHFyYNJLH/5cIxLTxFm0OB60zOmC5DAX4IIYhSclIGi0IpiHjsKikBGzZkPNDK1z4z+mHllxMoFdEqbkH/YYpz1izJlvMKOtC0NX+TrZrxULF/8csg503y56K6pTR2/tmnKobeXinfiBDQVe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 12:12:06.1489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9437a4c-2d06-4c02-748e-08d61fbb7304
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
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
 drivers/clk/imx/clk-frac-pll.c | 215 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 219 insertions(+)
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
index 0000000..030df76
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,215 @@
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
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD_MASK		BIT(19)
+#define PLL_BYPASS_MASK		BIT(14)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	GENMASK(30, 7)
+#define PLL_INT_DIV_MASK	GENMASK(6, 0)
+#define PLL_OUTPUT_DIV_MASK	GENMASK(4, 0)
+#define PLL_FRAC_DENOM		0x1000000
+
+#define PLL_FRAC_LOCK_TIMEOUT	10000
+#define PLL_FRAC_ACK_TIMEOUT	500000
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
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_STATUS, 0,
+					PLL_FRAC_LOCK_TIMEOUT);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	return readl_poll_timeout(pll->base, val, val & PLL_NEWDIV_ACK, 0,
+					PLL_FRAC_ACK_TIMEOUT);
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
+	divff = FIELD_GET(PLL_FRAC_DIV_MASK, val);
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
+	val &= ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
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

