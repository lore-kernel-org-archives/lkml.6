Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30456208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LO9wVkc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30456208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeGPFRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 01:17:01 -0400
Received: from mail-he1eur01on0044.outbound.protection.outlook.com ([104.47.0.44]:42797
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727199AbeGPFRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 01:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/Z6ksc0KEVf09XQ1mgawvW4Wjc9321iA78p/B9CUl0=;
 b=LO9wVkc5jUyHMOXJvcZXu2sYhKvfSiWKdoU3X5xqHi28DzOfaYyHZ2nXs/abcqsImGulWl9NnTfOh0LHhQwbA4IOA9PMqYfm/5U8RrpAyzXXGZ9U1taLk2TY4G+BaDi705LzGC88IevyEGiYm/2ETXe/vACN9b8tZmQiX7ZP2jM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1316.eurprd04.prod.outlook.com (2a01:111:e400:586f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Mon, 16 Jul
 2018 04:51:21 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx: gpc: restrict register range for regmap access
Date:   Mon, 16 Jul 2018 12:46:35 +0800
Message-Id: <1531716395-21549-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:203:52::26) To AM3PR04MB1316.eurprd04.prod.outlook.com
 (2a01:111:e400:586f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2d617a-9d10-43e3-de28-08d5ead7c824
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;3:CE3d5Jg2vGpYEzvx9opwqXjxCytFpv6EjY1VnnQaBBLMTXU6eiTAn2GAT0PxPX0so0z19eebIwmZVzTjmei4IrKRKxnoDhD1hV1oSl32f7xgIm6WwalKbJF04tF2jnJHa9kofNp61g9/GKW3aRCpM6k0RoqoyaqC21DUzI6g9g13E2ezJqMY8jut2ikqplLbN3ZnXg3TTc9L5Kxbc7SRrsUDkzXP8dP1uEpAhThnKyhS9KgWFXWxVr+d3eTfoz46;25:WhZV75U5C3QSbXVG2L4SGFypa4SM9GH3T53d1Z3ooyQ2JLUfjXILfrVwWJo2wGPEUkaQ6SjTiAh6S30LwbH9CHO47qULLP6EmlR2cbZbFL7CYR+TNGZz+NOBPyL61BjFW0Eeu+/dOrjFVqGcZWObbGxEVgijisclSHEptih+T0H40LnqoRT2gnK1cltGU6QHR0uPUG5mvjyNiPAkiEORLta5IfaHZS0+thVhJnR4k0iuwRPKfpgDvZPNkn9IydaOaZ9H6h5mYu3l2OcUJqKZ26vAISpcNY+EGqMr6uurxPr78cJFYbbefhlY2s72GdA7hjdnOrnMpW7iVV2JR0OANw==;31:mnIlOfgn6xp/14ma69Q7eohke3ftwFAIQ4D5/K9yyFOWHMCoeuDBpZu03VzL81azcnIhr3P5tiPSkbmmlWkvJSvtXdUzV4j0Gerb33pXQYknJOiZ55NrJCm192dN+opeKK/qB3VsG7ELNnllSTLPk+yNqGMvssHn4kdjsXk1afnS3ELcSuBOXEhHj2teb67Dx5gjc1zLBiNad3m604WPvnvNV7PM/HNwnApPUfsJcsA=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;20:OaSfEAkk4BsUlOB1R0e8BdyxUPkoCUVTyfLkTXjTttPZIgEzIqK4XtR6xFG/iux5gKw3M7z4lnmVpeWtK35hT/Uew6+/kBc6gpFz0qYaVw4qttbIAKfVB+Y8FTI48GtKun5ZluRi7ngiPUNxb+DuikmaW9zPvI5r/L9IYXg8MDVNxZ03EfayGwAy/AwxSEwe25zkUowqqYqUBGHOFYJmc+t0Oz4HN5QGE2UKfkumMCuRzFzwmGKZQgLbqQgXw/eIt0u0MQnPRiuAJ8MdvVuqvrKy3pPQPxGKWw1bp+WRpOSFDycKimRRarpNt2jZ5CW0o9/NNJzWft74lj+78gG/Xdt9zd9HNR73gnPPDnkEeOHrAVaYHKi5KhIIf/RbhkHmDou2R6RMabSNyUh0xlfkRNqMcd8LSjWltEPFe8ElFBquuE3InzdCa9DXEExTyw3BLQjKg+NUE07SRGalRt36hTjTZZvOgyN5NgWkOfAgLmzcWsbyVs5ZLHfeUHs217fO;4:ZVvyJeYDMSnR3hx+PUzez89Sxke9ww3FSmnl1ZD8W/cXlHPgnEs1W9PJLA1kLzxogMKNA8wj2n5/KUDvbnQIycaOuTDxEG2+c2luS+hMwe2Oli28k4MKgndDHqYT2j6A7TIvNwL8ay5+cAa1jahCmZ8j5BtBhsFxTQSWw/scbg7ZREN5NBWVgTcgGh9DhcTolE0fIMyAZHZPaMFO1c68u/80PusKoouf3JxJZrSbgH6u/kVSA1n/cDF8Tl7AjC7OIwMZ84RWIVb5lrpg+yejPvVoDlrDGuad4KiEWsDZ5TXTVDRHRrEhHrhTzvvZkr4t
X-Microsoft-Antispam-PRVS: <AM3PR04MB1316590C920004858E9DCA5EF55D0@AM3PR04MB1316.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1316;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(199004)(189003)(4326008)(25786009)(2906002)(51416003)(52116002)(97736004)(53936002)(106356001)(5660300001)(105586002)(14444005)(50226002)(486006)(36756003)(68736007)(305945005)(6116002)(3846002)(2616005)(956004)(6486002)(50466002)(81166006)(26005)(48376002)(6512007)(8936002)(81156014)(8676002)(45080400002)(1857600001)(386003)(6506007)(47776003)(86362001)(186003)(6666003)(316002)(66066001)(16526019)(476003)(478600001)(7736002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1316;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1316;23:t4PIf8EW3UkNLoJ2i6lVnB1b6i7syL8bEw62IUTho?=
 =?us-ascii?Q?YaWurRP1N45RyyAfchNWSs+ZwEhL8qN4NhBFAjC3DgoNA1d8BOkqKcrLHldK?=
 =?us-ascii?Q?lmju+SLcbwt/OzhFGfo5zUh/Y2x7wvP+CmELWWGRxXHzTqV5ukOwwzmz3fny?=
 =?us-ascii?Q?jSFwg+P7r/+Qcb/V86bXyG16ksc41bD++tXpBjEps5KcwVmsAnkJuRz8fo3m?=
 =?us-ascii?Q?giISJvavxO2//OPdIzzRXyZnR06JoVAHrOs6jwmtQ6JMC/+qYN9DCDe3biLq?=
 =?us-ascii?Q?c40R1vJU9LkMOrUx6QVuCUDpTjaPcOQ1ynFs0PcUXWl0FWQRD2rC2AXo/EfV?=
 =?us-ascii?Q?F9fmDRcz/JkT7TguufbHfjurOyhMB5Y3twIlalWZCSQ01K/4spU5LeH+XQdo?=
 =?us-ascii?Q?P++BlfhpWQU7Cn8Tcbj3RiedMLA9WL9tomv47zCps8scPrlzVio4yAnDsWEx?=
 =?us-ascii?Q?cr+v9rtEGcNEOY6DSIzEki+FTDrsYmYcrDVqk845IJIk7e6oTC/p2zrCxyW3?=
 =?us-ascii?Q?ESHn5IG7Nst37ZtsVsoIjI7h5nfU7ksgN36EVpR70S8d9cC67bQW7fufzQcf?=
 =?us-ascii?Q?t79vPBGse3jX+LIQpLaPQeUu4feQFeN2l4h+JtY2HsWHaKPKeqzfviX/SbV2?=
 =?us-ascii?Q?5dQMAtkxiEb+33gbg+QdSieQfdwvvDmLj7K+y+0i9F4kDWeAJHTBDFq6ddFD?=
 =?us-ascii?Q?6RMWda5XWSqzY62hZTD9Z2Ve33MegQQwQSKXvNBgy2z+BesiiXqt7ZYJGKsK?=
 =?us-ascii?Q?qCdQjGGNU7ThB9t8g6eO10ESrkj3s6U/Ow1Ip9+PWnF/s0XourVHC4x5bY6b?=
 =?us-ascii?Q?RzApsq/e7GtWm+Eh5l33y58fB+MrIn8+UhEN4OVmF/e6umDkepjmQPfSIHgg?=
 =?us-ascii?Q?+iZn1EkPtEqwQV6NMpxiJgVV7wT6lORbsA0T8DFES5dQVz/E4TFVluErFB4Z?=
 =?us-ascii?Q?8mafRX9V8Vylv4n+0bK0FW8ueAkRmrn4DggS+0tnZbyNZ+Y6qe0aGcGhZgGJ?=
 =?us-ascii?Q?Sx9DPorhaHlVe4dFCu2DXr91ta/kzvFrzAUzqQg41F7DQ0gqQgt20vt1ag3Q?=
 =?us-ascii?Q?fjbGhB2BFoC40m1LQ3K7gOtpAMt+XFuMeJGfQU1EBKYTwG+GdjGbqy1/LPRS?=
 =?us-ascii?Q?23opZ/zNhbr2aiFw+WP/xtZZIUPK9EOv8SWhEqh8gGa23YM8SSA+w=3D=3D?=
X-Microsoft-Antispam-Message-Info: uRFbMYu1qSttjy9XSPUPpsmBi/JgeWxGfdBll76ZoF8Z//5FshIdvtTQXC//qLkNJjiAL/4j1kHZ3ocoQGUupjBdYoZRJDi/c1bnI6aGUdbLatvkMqYT+eMonFjrJpw3ODuX65ef/lNX7D1CRCFzf5HLCoJYPs+jMPmLM2K86qBbJ3FLD+Dg2xSEGJUPx1R8T3nTe5Yx7eOl/33EdkdKiVcCHtxfhpy6gG8CqMopZqohNsTqHVqcp+4qN7hzogrUpjoLri33mEHDcPL7uVwxwIGerMKXR1SpPp3VuDXhxxXSLMJX2+YC7xlaTiE5rojipZSg/yKCIPRKhyVE0zn1DLues+1d5gfktMB/wCoc6M8=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;6:ehnKmE6c1DL9MDgUBk9+lsYpf14V4SsPRdaemvsL/w9PwYCcG/IQ0FPS2R9HnHpM+mTXVfzETfxr6tu5Y4EzaixRh6RiPrheCe3JwUqEfNxoydKwvaHKXjgnbrphpSeqJrIUkMkTyN5xjb7W5jBpy++3uOemn9pOsUDTp62+UASHEMhxf0LeTMlZnt+3JXwy2gijekvYD6dGEhzBjqFg1V3lo1anpElNI+RjHap/L/lgJndaCzU0yHBKiydOjoUGVu6kJuMDhfUr2t3tw7CdIPdUIOAgNaZoTJOYSGuUgG9QYUNh2tWsDnKzI5CbYeMLdYjH5mXnUYTMaWxkguioboHEEfUQqduJ9cwqCELL/aLMIAq5AlM2gn2pU9Tf+fnF/jjEIz6c7soIDUWPvACKaecqYTs9kkHViTlNaDk4F0X7a3sjga4k0+J2PzcFaWmI9a6XrDjt97r7szMbv4Cx0A==;5:lxVoFy9xIbyiR8q3c65g9jLQUX3eRqtNvcEhIwW7cbMhz3MCrpWzeUNidWLUwzcCE8j4CJzNy1lSAvgatlkcjIr/Zqg8VQHBQN4X1MWO4iahUFTmc1u6vS33mZZmXPmFLB10sUhZ7jPNjatgWHLTxlLx6bKbrn8vKBbuk3lcV7Y=;24:uZJzBt1VuUTqEpilYL8MRDOiYb9QWvEcnvipEZ4XM53OAbAgKU3APsJs3o4OQWkmAA9TXmNYLlDbhpfn85IX2BJf+PBOWZDs/PLhJp6Z/BM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;7:oFsyHzCafoqeqrCN4cscAmK5xCU7b9jrQ1RsPOyoGqilRAjspTIf81XvFYGF/MBB8u/IXoerwGPnOZ0v3nuw3RS1tNAoBbdYvVOsBhMgjrWnaQkXBo4/55ozi+2oDQIh3qjny3EsUiEjEmh2f2xlP6n5rGoggGJxcqYN8czscQTRhMVER6aZ56uYuLlgXob3UnUS/g3QeYDIGhsBwALozG9AUvsRu5tABJIxd//Hi1OQvLF+qlT0hMzaLDFd4kU1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 04:51:21.6081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2d617a-9d10-43e3-de28-08d5ead7c824
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1316
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPC registers are NOT continuous, some registers are
reserved and accessing them from userspace will trigger
external abort, add regmap register access table to
avoid below abort:

root@imx6slevk:~# cat /sys/kernel/debug/regmap/20dc000.gpc/registers
[  108.480477] Unhandled fault: imprecise external abort (0x1406) at 0xb6db5004
[  108.487985] pgd = 42b54bfd
[  108.490741] [b6db5004] *pgd=ba1b7831
[  108.494386] Internal error: : 1406 [#1] SMP ARM
[  108.498943] Modules linked in:
[  108.502043] CPU: 0 PID: 389 Comm: cat Not tainted 4.18.0-rc1-00074-gc9f1f60-dirty #482
[  108.509982] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
[  108.516123] PC is at regmap_mmio_read32le+0x20/0x24
[  108.521031] LR is at regmap_mmio_read+0x40/0x60
[  108.525586] pc : [<c059cf74>]    lr : [<c059d1ac>]    psr: 20060093
[  108.531875] sp : eccf1d98  ip : eccf1da8  fp : eccf1da4
[  108.537122] r10: ec2d3800  r9 : eccf1f60  r8 : ecfc0000
[  108.542370] r7 : eccf1e2c  r6 : eccf1e2c  r5 : 00000028  r4 : ec338e00
[  108.548920] r3 : 00000000  r2 : eccf1e2c  r1 : f0980028  r0 : 00000000
[  108.555474] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  108.562720] Control: 10c5387d  Table: acf4004a  DAC: 00000051
[  108.568491] Process cat (pid: 389, stack limit = 0xd4318a65)
[  108.574174] Stack: (0xeccf1d98 to 0xeccf2000)

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/gpc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748..0097a93 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -27,9 +27,16 @@
 #define GPC_PGC_SW2ISO_SHIFT	0x8
 #define GPC_PGC_SW_SHIFT	0x0
 
+#define GPC_PGC_PCI_PDN		0x200
+#define GPC_PGC_PCI_SR		0x20c
+
 #define GPC_PGC_GPU_PDN		0x260
 #define GPC_PGC_GPU_PUPSCR	0x264
 #define GPC_PGC_GPU_PDNSCR	0x268
+#define GPC_PGC_GPU_SR		0x26c
+
+#define GPC_PGC_DISP_PDN	0x240
+#define GPC_PGC_DISP_SR		0x24c
 
 #define GPU_VPU_PUP_REQ		BIT(1)
 #define GPU_VPU_PDN_REQ		BIT(0)
@@ -318,10 +325,24 @@ static const struct of_device_id imx_gpc_dt_ids[] = {
 	{ }
 };
 
+static const struct regmap_range yes_ranges[] = {
+	regmap_reg_range(GPC_CNTR, GPC_CNTR),
+	regmap_reg_range(GPC_PGC_PCI_PDN, GPC_PGC_PCI_SR),
+	regmap_reg_range(GPC_PGC_GPU_PDN, GPC_PGC_GPU_SR),
+	regmap_reg_range(GPC_PGC_DISP_PDN, GPC_PGC_DISP_SR),
+};
+
+static const struct regmap_access_table access_table = {
+	.yes_ranges	= yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(yes_ranges),
+};
+
 static const struct regmap_config imx_gpc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
+	.rd_table = &access_table,
+	.wr_table = &access_table,
 	.max_register = 0x2ac,
 };
 
-- 
2.7.4

