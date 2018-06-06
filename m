Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UCsfYuGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8550E60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeFFHvj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:51:39 -0400
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:60960
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932406AbeFFHvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:51:31 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <wmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <miquel.raynal@bootlin.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v9 2/4] memory: pl353: Add driver for arm pl353 static memory controller
Date: Wed, 6 Jun 2018 13:19:40 +0530
Message-ID: <1528271382-21690-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39840400004)(39380400002)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(7696005)(59450400001)(51416003)(486006)(26005)(316002)(50226002)(106466001)(126002)(47776003)(336012)(478600001)(77096007)(186003)(575784001)(2201001)(5660300001)(76176011)(6666003)(4326008)(9786002)(110136005)(11346002)(446003)(8936002)(36386004)(2616005)(2906002)(39060400002)(7416002)(16586007)(476003)(106002)(36756003)(81166006)(81156014)(107886003)(356003)(8676002)(50466002)(54906003)(305945005)(426003)(63266004)(48376002)(107986001)(921003)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR0201MB1456;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:JQgLlA9CmqH5e6uERObsbdY1ntRnKyRU+JFHe3942U+93fGL1OpblMvkmvIOcA6i198UwLyEEQCTcs4XKimKcEbZ5yfYAR+Kdna5GvNrqtzZKabtiPro2eq9OQwfXXjQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR0201MB1456;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;3:1VvMJopVqhlvyZQ8fXo+D5LPoBbcuV5CUS5XgVMCQRDINuiIUc66+Mx/wZ10RJlfpoUzQclaZENZnSIodzeMYOkPfyOmdCS1uoZFJXOF9mbO+cAoLsStasMjp2bcSbDhZQuLXEoxbOxlUu+XqBY6FVBisDr/+f+b8xpSnJ7pzO9EhAD86HYA6j1t0xXpzerVnyqpJcjrJUI/wGodpkRyqa0vY7MyMribOghCrX03PhfxeccBV9b1T9a8rbKB5DGMNU4GCSJGGuPx1ziB5zYvY7QQSyrbodkb7rnQ2HH2F0LiIXfL7QsvR6Sdx6o6IUf7VGgSI9qnxXI3kaj8zDgvUuTpQtR2q0SmATwhkg7Pmwg=;25:j2Vqtu4C0QKpoTjZPOcq93OZoThtLbrLdCMeLzlGHDk9iDtO7qzfbvPBRMePUegx5LIgpgbCen8Av4AY1E82ufMZ4ow4nZHeexqKQ8sEtR4vnaJx81sopWlb+CFqMeKNTgxBWhndJfFa5aa/iDYQ+BJICLeFfkbis9f6PEpDemhuvcsUG/XugovdUl+dS4zpsxpwodl143rvS/lnBc0jdVsQ0G28T/2/Qgfilc1h9jeABbZwz1olY8Eve9mscTnP16aOS6iarRKkDpBxgRs5699XP4pY7Tpb7HqK5MNBd9OoBauDcrfAQC94L60aakOTCDTfVmdwWx1vGDUtyNPbpA==
X-MS-TrafficTypeDiagnostic: SN1PR0201MB1456:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;31:QS/gyIJ2HgdOzUgI9y+UAxiWxwROw3Rsn97nEK6m4Q7mGQxOYtLbTh5WvktfbN7ioVWeBlShAWPpDrAMUvsjIx6ZtOmywsiNXMddhVqlOf9aGQloyxhMyJOVy/eijNbGTMb9vvtgCPU0aoxM3sTzmY2NLTmHf/R1B8RlGLRiVtnVxigB4pszVYiFFbB9Q0CZlJXm6xyIuy5k9m3rrvMqEqgMiMKMIoIYX6dDHLhfCbg=;20:qbeylAyWbbt1UCpxC3JRFCNhDQNLZE+EMlVV7WYptDbdn+7SFMKYd0tL0vvTdLhT4QyG4+UhZzYHYhdxKD9sYcu9BqOmBhv+ZZX5wX4jzsOIMRkgqIwd/OWO2ig9dAqGiW1GPXI5taeevOgOzXFtumjCZAZnejS0ZxSmH82uI7fnaAVeQ8bVnSiS9vQuinkRsj+5KCQGP67GmNtw6X/rjo/gkttZlX60Ji6c5yvfpsmOldCREhDqUOyQrHvLbepV9szilFGf6Ufz3Z8f/cr/+yTtc2aUdYwvZ2kG6Vv6HkZzzHsRcG8qEeveQEly2Sc+BOO1WqsF+rfn9aEEoRhj3B0HDZN1e49jlue3hnZyfXgZm0++MZZ+yEeFme/F2BVginXWQYqDhy54r7yO3f0T5Brwfs1S/LWPh6YYsYDOeQVLJHJAjh3bkH3XqhY5FEBRKVnaXKNy+8skHLFEXQGdkx9rcxrVIEFTUDj43CjzVY9kVW86bKC7xwmwdvhUtJak
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR0201MB14565F040A5E4546ADD8CC05AF650@SN1PR0201MB1456.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR0201MB1456;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0201MB1456;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;4:JpkM2lJLQUb0W/TNAE4PCoksq7T3cAejVCyFh2R9LDsy1EpOeJNvGC2Wb3RGB9mZNTLq/Ntu+T6hf44bPsZYi+VBOQC5YMpDAzhSRYTUg6OktrFF8oGp+eSpiNuQiowh3w/A67EnJdoO72clAywkAxaSKX8trReIOo8C2LJIT3Wv2/aTnwpCuPs6MF5WM1VYYW3choIBeRVZLX2MDmsHfNFFyUocsJPPHNJGp7DEcamw9+MBXkphoLwt2qL2Axd9yHo/oUwhI1Tt90AN2tlDPoL7ZTNyThOVMReByN/Kpj3DVqLC5al2oEzg9nHcroXw
X-Forefront-PRVS: 06952FC175
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR0201MB1456;23:58MT869Dee7f/zRv8qTmTvhpXCBfIylqY2zpEcJ?=
 =?us-ascii?Q?vFtI7Xwz/Gs8lwZGf69PeVLOYcytpWsvXyqZe9R9tUvIMm9rFGZXrgzLk3Jt?=
 =?us-ascii?Q?Fw1eE8x5aI36mYPBupQ28rGjAMcdgPUFNDX2Gyj979plZlyV/x4/hvjJBSEb?=
 =?us-ascii?Q?bWRKNhEj7oy2rSUC+XY+tMcZEQgF2byo4EsCKRp2OCfPYjRLgU/Z6rAF4Doz?=
 =?us-ascii?Q?POHc3lGdoSE4kt/vQo0qBURA8xQTjqkV0xRRCpe9Vu3ssparAL3cDDWqWRQE?=
 =?us-ascii?Q?63kVfqPFnwTQaXVDyYmhb7O3viI3Kw/VFcihL6qX0oeC6IPSIxdBIMtIMcXT?=
 =?us-ascii?Q?ucePhQ//ExSzn6cy1Ibfj2YaRTXFUMHInNphTpqvzvhOfgHCc8eHyYYoZhnI?=
 =?us-ascii?Q?/eWh2DstbMJxy+GWnTgeQU1W1XkgzJz/IZKnsPX51RVeTNFjoiag1lVi36MP?=
 =?us-ascii?Q?8rvOd+9CLl268RKwzacR04TLId7Bm2H34Wt+PMO8HQosC84B4ao2+KEK37TB?=
 =?us-ascii?Q?tCHyCI9mHwbXVrNdylTjuHp8zgAFTwiCmppa77A0KUm9sWIhhMhOWWseU70W?=
 =?us-ascii?Q?yEGQpeAaZwvNsgdvHb5S33gfzPpFlxAzylEroJ9RzVGLpiOaxd50qoxsPjJu?=
 =?us-ascii?Q?kWoUjkiwACMlnnrlg1x1P4gmPK/8VYsyNO6rfbJ46Q7ygO1L28A/inwJZaN1?=
 =?us-ascii?Q?UITmvkStN32H2WjJMjTPxEfEzfzIPbUL3yyZlBd+Sg1/kcpUuRoHxDUVIP90?=
 =?us-ascii?Q?TRHfpqkiV2TzekWAPVrk+WuoSi0dDMGgnuaNlBln4gVtQVmMFol3bRRDGmcQ?=
 =?us-ascii?Q?U/KSBaOPGa3FXcYzWgZaijulnteKuHmU22YyOJS62okkWnsn8wMsIzSyFlvT?=
 =?us-ascii?Q?nYRjGBwJj1WVpvuZqG34PzlK4y7B9UaEqYBo6JgSTCF0Aj/k+8vL3TJfoggP?=
 =?us-ascii?Q?r/WQtWAKMykMoIvOV8XCqxgBsWv+a9HrfvESpV38xXLJIG394k4WMppvlhtw?=
 =?us-ascii?Q?6D65IfCzqmJMyK1ie0ejKi0X/ZnEmQ87VDFRvUqF4v9FpbqBH6+oO+QIdqxo?=
 =?us-ascii?Q?XGfDSM4SHBHdZgBLaZOm2It04YWb4PlsecjN8VDRUU1nqbCVE8zr+m1ewFqg?=
 =?us-ascii?Q?C1LMBrRxcNZhgE3vafSvhif5VJvJk2wTmglS7wk6CXGhIYRnqGYaSWdqDHNy?=
 =?us-ascii?Q?84tjeTMo1S6W4xqwLcmzHoxebwocaxxWXMrzxHnyxjUU+Bm6aHSdeN/2rINh?=
 =?us-ascii?Q?OdzuRGIXgi3k/B9jOdD0JxiYywevNEngV60byoYyoJdPzIvZr4COA49R4Nip?=
 =?us-ascii?Q?thQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: uGRwHmMcDFjuVLU4N9yMPDRhx6fgvPgSepzNVm83px0tdCtXNscMNxKRhsIug8PZ8jc4kbXnHTJAR5INYdZnNjF4U9VDzyHOFxVfJV8i3Tje6rIxfAwzuVMAd/BTFmay89J9TKHSBhNAGPycoL/7VdlzS0AW+G3r6ll8msngxo8ucsc8JhCGxbFDyU/1QBQU
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;6:FRMIBCYg5pUL2UM+BgqzEqkHCNKWVeFOgjuvrNCCL4113XottrTtJgZdG4CpJWe3xJnY8wX8dv2vhuwOcuNVkuPWneeyOG4BmQF7pnOelFSe2PAzVDSd7giDuemWnNhxKpzvK9WUZTXlHJSCYln5EE8whCgAzfGMvQnQZid7NX97QjYqV+wDuGwqDE1A264Z4Ak7Pm1rMqzr10BVxbJg6trYdXZo+lV1umFR7D3hXOjEXd3ItbUTolbwgajRtC4/ImYNXnoCMEL7NjWpbUxgpksUR2zCD0x10ZUeVr64u868kRiytx6RoK/eyHSUVyQw2J0R1rUE50RRrAYXr02pQite5YFxTS1AazDdR8OBpyWRil9otvuim9licLNVL36EmpW5kk+JSUpFmhszsFQFoyoUQ9lBbKTQkF9/zqjqK8iiUburg3sYDwLwcqTx0aAILLG//xU8His27TY039EeLQ==;5:0w6EHYm1xan3oFXjW5eqDc87KRUMzFkETGHgmu7A5V091rmQGsR9UD2lLRmLzIqE9kq6vhWX2WaTKCrkHBFV3Z0wgPSJwo2RCdDh/e4fQzaAopFAOdvTc24LEOJ+ud2j4qI+KpRgZg+eu+IW4BX3NvMaTgBvMWuBJCpE+vcvu2s=;24:AOjQM8hq035FsbGgnjFXud3v8uHhRf7+lQRNMKViAFTeTYjx9wVe6BrsbZeCXf7SNqUaKzpKb4p9/DliG1YNCHB6t9k7dVG70J33u6EjGR8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR0201MB1456;7:1V5SQjyitqPHx6iOLvnlqasNuubL5xHpAaF0Y5laHFpZRCHW1rp3BPnLg070bFb9g+dVNZIjmvsVlE7YTQISvKGVVwxJgUx0HbmF8y7LL320JrIwON/ewUzc3O0qRtHcmcnVHOq/dJ8zRgVbhzrJZ5C554xgSl81AcOFkCVXq15wcdjZdS8X2vVgCh7hNwzxV6nCgjLsv9dZZr4C+dFXAgJ+dODWguG4eAPXFmFgaGTEXF67Sj39TP2z1dRW6dPJ
X-MS-Office365-Filtering-Correlation-Id: 652bdde4-9abe-4f94-1812-08d5cb824df1
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 07:51:25.2876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652bdde4-9abe-4f94-1812-08d5cb824df1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0201MB1456
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller. This controller is
used in xilinx zynq soc for interfacing the nand and nor/sram memory
devices.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v9:
 - Addressed the comments given by Julia Cartwright to the v8 series.
Changes in v8:
- None
Changes in v7:
- Corrected the kconfig to use tristate selection
- Corrected the GPL licence ident 
- Added boundary checks for nand timing parameters 
Changes in v6:
- Fixed checkpatch.pl reported warnings
Changes in v5:
- Added pl353_smc_get_clkrate function, made pl353_smc_set_cycles as public
  API
- Removed nand timing parameter initialization and moved it to nand driver  
Changes in v4:
- Modified driver to support multiple instances
- Used sleep instaed of busywait for delay
Changes in v3:
- None
Changes in v2:
- Since now the timing parameters are in nano seconds, added logic to convert
  them to the cycles
---
 drivers/memory/Kconfig                  |   8 +
 drivers/memory/Makefile                 |   1 +
 drivers/memory/pl353-smc.c              | 523 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/pl353-smc.h |  29 ++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/memory/pl353-smc.c
 create mode 100644 include/linux/platform_data/pl353-smc.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 19a0e83..9517da7 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -153,6 +153,14 @@ config DA8XX_DDRCTL
 	  Texas Instruments da8xx SoCs. It's used to tweak various memory
 	  controller configuration options.
 
+config PL353_SMC
+	tristate "ARM PL35X Static Memory Controller(SMC) driver"
+	default y
+	depends on ARM
+	help
+	  This driver is for the ARM PL351/PL353 Static Memory
+	  Controller(SMC) module.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 66f5524..58e794d 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
 obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
+obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
new file mode 100644
index 0000000..8758930
--- /dev/null
+++ b/drivers/memory/pl353-smc.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 SMC driver
+ *
+ * Copyright (C) 2012 Xilinx, Inc
+ * Author: Punnaiah Choudary Kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/platform_data/pl353-smc.h>
+
+/* Register definitions */
+#define PL353_SMC_MEMC_STATUS_OFFS	0	/* Controller status reg, RO */
+#define PL353_SMC_CFG_CLR_OFFS		0xC	/* Clear config reg, WO */
+#define PL353_SMC_DIRECT_CMD_OFFS	0x10	/* Direct command reg, WO */
+#define PL353_SMC_SET_CYCLES_OFFS	0x14	/* Set cycles register, WO */
+#define PL353_SMC_SET_OPMODE_OFFS	0x18	/* Set opmode register, WO */
+#define PL353_SMC_ECC_STATUS_OFFS	0x400	/* ECC status register */
+#define PL353_SMC_ECC_MEMCFG_OFFS	0x404	/* ECC mem config reg */
+#define PL353_SMC_ECC_MEMCMD1_OFFS	0x408	/* ECC mem cmd1 reg */
+#define PL353_SMC_ECC_MEMCMD2_OFFS	0x40C	/* ECC mem cmd2 reg */
+#define PL353_SMC_ECC_VALUE0_OFFS	0x418	/* ECC value 0 reg */
+
+/* Controller status register specific constants */
+#define PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT	6
+
+/* Clear configuration register specific constants */
+#define PL353_SMC_CFG_CLR_INT_CLR_1	0x10
+#define PL353_SMC_CFG_CLR_ECC_INT_DIS_1	0x40
+#define PL353_SMC_CFG_CLR_INT_DIS_1	0x2
+#define PL353_SMC_CFG_CLR_DEFAULT_MASK	(PL353_SMC_CFG_CLR_INT_CLR_1 | \
+					 PL353_SMC_CFG_CLR_ECC_INT_DIS_1 | \
+					 PL353_SMC_CFG_CLR_INT_DIS_1)
+
+/* Set cycles register specific constants */
+#define PL353_SMC_SET_CYCLES_T0_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T0_SHIFT	0
+#define PL353_SMC_SET_CYCLES_T1_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T1_SHIFT	4
+#define PL353_SMC_SET_CYCLES_T2_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T2_SHIFT	8
+#define PL353_SMC_SET_CYCLES_T3_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T3_SHIFT	11
+#define PL353_SMC_SET_CYCLES_T4_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T4_SHIFT	14
+#define PL353_SMC_SET_CYCLES_T5_MASK	0x7
+#define PL353_SMC_SET_CYCLES_T5_SHIFT	17
+#define PL353_SMC_SET_CYCLES_T6_MASK	0xF
+#define PL353_SMC_SET_CYCLES_T6_SHIFT	20
+
+/* ECC status register specific constants */
+#define PL353_SMC_ECC_STATUS_BUSY	BIT(6)
+
+/* ECC memory config register specific constants */
+#define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
+#define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
+#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0xC
+
+#define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
+				 (2 << 21))	/* UpdateRegs operation */
+
+#define PL353_NAND_ECC_CMD1	((0x80)       |	/* Write command */ \
+				 (0 << 8)     |	/* Read command */ \
+				 (0x30 << 16) |	/* Read End command */ \
+				 (1 << 24))	/* Read End command calid */
+
+#define PL353_NAND_ECC_CMD2	((0x85)	      |	/* Write col change cmd */ \
+				 (5 << 8)     |	/* Read col change cmd */ \
+				 (0xE0 << 16) |	/* Read col change end cmd */ \
+				 (1 << 24)) /* Read col change end cmd valid */
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+/**
+ * struct pl353_smc_data - Private smc driver structure
+ * @devclk:		Pointer to the peripheral clock
+ * @aperclk:		Pointer to the APER clock
+ */
+struct pl353_smc_data {
+	struct clk		*memclk;
+	struct clk		*aclk;
+};
+
+/* SMC virtual register base */
+static void __iomem *pl353_smc_base;
+
+/**
+ * pl353_smc_set_buswidth - Set memory buswidth
+ * @bw:	Memory buswidth (8 | 16)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_buswidth(unsigned int bw)
+{
+	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
+		return -EINVAL;
+
+	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
+
+/**
+ * pl353_smc_set_cycles - Set memory timing parameters
+ * @t0:	t_rc		read cycle time
+ * @t1:	t_wc		write cycle time
+ * @t2:	t_rea/t_ceoe	output enable assertion delay
+ * @t3:	t_wp		write enable deassertion delay
+ * @t4:	t_clr/t_pc	page cycle time
+ * @t5:	t_ar/t_ta	ID read time/turnaround time
+ * @t6:	t_rr		busy to RE timing
+ *
+ * Sets NAND chip specific timing parameters.
+ */
+static void pl353_smc_set_cycles(u32 t0, u32 t1, u32 t2, u32 t3, u32
+			      t4, u32 t5, u32 t6)
+{
+	t0 &= PL353_SMC_SET_CYCLES_T0_MASK;
+	t1 = (t1 & PL353_SMC_SET_CYCLES_T1_MASK) <<
+			PL353_SMC_SET_CYCLES_T1_SHIFT;
+	t2 = (t2 & PL353_SMC_SET_CYCLES_T2_MASK) <<
+			PL353_SMC_SET_CYCLES_T2_SHIFT;
+	t3 = (t3 & PL353_SMC_SET_CYCLES_T3_MASK) <<
+			PL353_SMC_SET_CYCLES_T3_SHIFT;
+	t4 = (t4 & PL353_SMC_SET_CYCLES_T4_MASK) <<
+			PL353_SMC_SET_CYCLES_T4_SHIFT;
+	t5 = (t5 & PL353_SMC_SET_CYCLES_T5_MASK) <<
+			PL353_SMC_SET_CYCLES_T5_SHIFT;
+	t6 = (t6 & PL353_SMC_SET_CYCLES_T6_MASK) <<
+			PL353_SMC_SET_CYCLES_T6_SHIFT;
+
+	t0 |= t1 | t2 | t3 | t4 | t5 | t6;
+
+	writel(t0, pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+}
+
+/**
+ * pl353_smc_ecc_is_busy - Read ecc busy flag
+ * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
+ */
+int pl353_smc_ecc_is_busy(void)
+{
+	return !!(readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
+		  PL353_SMC_ECC_STATUS_BUSY);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
+
+/**
+ * pl353_smc_get_ecc_val - Read ecc_valueN registers
+ * @ecc_reg:	Index of the ecc_value reg (0..3)
+ * Return: the content of the requested ecc_value register.
+ *
+ * There are four valid ecc_value registers. The argument is truncated to stay
+ * within this valid boundary.
+ */
+u32 pl353_smc_get_ecc_val(int ecc_reg)
+{
+	u32 addr, reg;
+
+	ecc_reg &= 3;
+	addr = PL353_SMC_ECC_VALUE0_OFFS + (ecc_reg << 2);
+	reg = readl(pl353_smc_base + addr);
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_ecc_val);
+
+/**
+ * pl353_smc_get_nand_int_status_raw - Get NAND interrupt status bit
+ * Return: the raw_int_status1 bit from the memc_status register
+ */
+int pl353_smc_get_nand_int_status_raw(void)
+{
+	u32 reg;
+
+	reg = readl(pl353_smc_base + PL353_SMC_MEMC_STATUS_OFFS);
+	reg >>= PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT;
+	reg &= 1;
+
+	return reg;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_get_nand_int_status_raw);
+
+/**
+ * pl353_smc_clr_nand_int - Clear NAND interrupt
+ */
+void pl353_smc_clr_nand_int(void)
+{
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+}
+EXPORT_SYMBOL_GPL(pl353_smc_clr_nand_int);
+
+/**
+ * pl353_smc_set_ecc_mode - Set SMC ECC mode
+ * @mode:	ECC mode (BYPASS, APB, MEM)
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode)
+{
+	u32 reg;
+	int ret = 0;
+
+	switch (mode) {
+	case PL353_SMC_ECCMODE_BYPASS:
+	case PL353_SMC_ECCMODE_APB:
+	case PL353_SMC_ECCMODE_MEM:
+
+		reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+		reg &= ~PL353_SMC_ECC_MEMCFG_MODE_MASK;
+		reg |= mode << PL353_SMC_ECC_MEMCFG_MODE_SHIFT;
+		writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_mode);
+
+/**
+ * pl353_smc_set_ecc_pg_size - Set SMC ECC page size
+ * @pg_sz:	ECC page size
+ * Return: 0 on success or negative errno.
+ */
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz)
+{
+	u32 reg, sz;
+
+	switch (pg_sz) {
+	case 0:
+		sz = 0;
+		break;
+	case SZ_512:
+		sz = 1;
+		break;
+	case SZ_1K:
+		sz = 2;
+		break;
+	case SZ_2K:
+		sz = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+	reg &= ~PL353_SMC_ECC_MEMCFG_PGSIZE_MASK;
+	reg |= sz;
+	writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_pg_size);
+
+static int __maybe_unused pl353_smc_suspend(struct device *dev)
+{
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	clk_disable(pl353_smc->memclk);
+	clk_disable(pl353_smc->aclk);
+
+	return 0;
+}
+
+static int __maybe_unused pl353_smc_resume(struct device *dev)
+{
+	int ret;
+	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
+
+	ret = clk_enable(pl353_smc->aclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable axi domain clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(pl353_smc->memclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable memory clock.\n");
+		clk_disable(pl353_smc->aclk);
+		return ret;
+	}
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(pl353_smc_dev_pm_ops, pl353_smc_suspend,
+			 pl353_smc_resume);
+
+/**
+ * pl353_smc_init_nand_interface - Initialize the NAND interface
+ * @pdev:	Pointer to the platform_device struct
+ * @nand_node:	Pointer to the pl353_nand device_node struct
+ */
+static void pl353_smc_init_nand_interface(struct platform_device *pdev,
+					  struct device_node *nand_node)
+{
+	u32 t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr;
+	int err;
+	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+	/* nand-cycle-<X> property is refer to the NAND flash timing
+	 * mapping between dts and the NAND flash AC timing
+	 *  X  : AC timing name
+	 *  t0 : t_rc
+	 *  t1 : t_wc
+	 *  t2 : t_rea
+	 *  t3 : t_wp
+	 *  t4 : t_clr
+	 *  t5 : t_ar
+	 *  t6 : t_rr
+	 */
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t0", &t_rc);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t0 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t1", &t_wc);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t1 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t2", &t_rea);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t2 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t3", &t_wp);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t3 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t4", &t_clr);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t4 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t5", &t_ar);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t5 not in device tree");
+		goto default_nand_timing;
+	}
+	err = of_property_read_u32(nand_node, "arm,nand-cycle-t6", &t_rr);
+	if (err) {
+		dev_warn(&pdev->dev, "arm,nand-cycle-t6 not in device tree");
+		goto default_nand_timing;
+	}
+
+default_nand_timing:
+	/*
+	 * Default assume 50MHz clock (20ns cycle time) and 3V operation
+	 * The SET_CYCLES_REG register value depends on the flash device.
+	 * Look in to the device datasheet and change its value, This value
+	 * is for 2Gb Numonyx flash.
+	 */
+	if (err) {
+		/* set default NAND flash timing property */
+		dev_warn(&pdev->dev, "Using default timing for");
+		dev_warn(&pdev->dev, "2Gb Numonyx MT29F2G08ABAEAWP NAND flash");
+		dev_warn(&pdev->dev, "t_wp, t_clr, t_ar are set to 2");
+		dev_warn(&pdev->dev, "t_rc, t_wc, t_rr are set to 4");
+		dev_warn(&pdev->dev, "t_rea is set to 1");
+		t_rc = 4;
+		t_wc = 4;
+		t_rr = 4;
+		t_rea = 1;
+		t_wp = 2;
+		t_clr = 2;
+		t_ar = 2;
+	}
+
+	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
+	pl353_smc_set_cycles(t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr);
+	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
+	       PL353_SMC_DIRECT_CMD_OFFS);
+	/* Wait till the ECC operation is complete */
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout))
+		dev_err(&pdev->dev, "nand ecc busy status timed out");
+
+	writel(PL353_NAND_ECC_CMD1,
+	       pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
+	writel(PL353_NAND_ECC_CMD2,
+	       pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
+}
+
+static const struct of_device_id pl353_smc_supported_children[] = {
+	{ .compatible = "cfi-flash" },
+	{ .compatible = "arm,pl353-nand-r2p1",
+	.data = pl353_smc_init_nand_interface },
+	{}
+};
+
+static int pl353_smc_probe(struct platform_device *pdev)
+{
+	struct pl353_smc_data *pl353_smc;
+	struct device_node *child;
+	struct resource *res;
+	int err;
+	struct device_node *of_node = pdev->dev.of_node;
+	void (*init)(struct platform_device *pdev,
+		     struct device_node *nand_node);
+	const struct of_device_id *match = NULL;
+
+	pl353_smc = devm_kzalloc(&pdev->dev, sizeof(*pl353_smc), GFP_KERNEL);
+	if (!pl353_smc)
+		return -ENOMEM;
+
+	/* Get the NAND controller virtual address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pl353_smc_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pl353_smc_base))
+		return PTR_ERR(pl353_smc_base);
+
+	pl353_smc->aclk = devm_clk_get(&pdev->dev, "aclk");
+	if (IS_ERR(pl353_smc->aclk)) {
+		dev_err(&pdev->dev, "aclk clock not found.\n");
+		return PTR_ERR(pl353_smc->aclk);
+	}
+
+	pl353_smc->memclk = devm_clk_get(&pdev->dev, "memclk");
+	if (IS_ERR(pl353_smc->memclk)) {
+		dev_err(&pdev->dev, "memclk clock not found.\n");
+		return PTR_ERR(pl353_smc->memclk);
+	}
+
+	err = clk_prepare_enable(pl353_smc->aclk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable AXI clock.\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(pl353_smc->memclk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable memory clock.\n");
+		goto out_clk_dis_aper;
+	}
+
+	platform_set_drvdata(pdev, pl353_smc);
+
+	/* clear interrupts */
+	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
+	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
+
+	/* Find compatible children. Only a single child is supported */
+	for_each_available_child_of_node(of_node, child) {
+		match = of_match_node(pl353_smc_supported_children, child);
+		if (!match) {
+			dev_warn(&pdev->dev, "unsupported child node\n");
+			continue;
+		}
+		break;
+	}
+	if (!match) {
+		dev_err(&pdev->dev, "no matching children\n");
+		goto out_clk_disable;
+	}
+
+	init = match->data;
+	if (init)
+		init(pdev, child);
+	of_platform_device_create(child, NULL, &pdev->dev);
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(pl353_smc->memclk);
+out_clk_dis_aper:
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return err;
+}
+
+static int pl353_smc_remove(struct platform_device *pdev)
+{
+	struct pl353_smc_data *pl353_smc = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(pl353_smc->memclk);
+	clk_disable_unprepare(pl353_smc->aclk);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_smc_of_match[] = {
+	{ .compatible = "arm,pl353-smc-r2p1" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pl353_smc_of_match);
+
+static struct platform_driver pl353_smc_driver = {
+	.probe		= pl353_smc_probe,
+	.remove		= pl353_smc_remove,
+	.driver		= {
+		.name	= "pl353-smc",
+		.pm	= &pl353_smc_dev_pm_ops,
+		.of_match_table = pl353_smc_of_match,
+	},
+};
+
+module_platform_driver(pl353_smc_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_DESCRIPTION("ARM PL353 SMC Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/platform_data/pl353-smc.h b/include/linux/platform_data/pl353-smc.h
new file mode 100644
index 0000000..fc4129e
--- /dev/null
+++ b/include/linux/platform_data/pl353-smc.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 SMC Driver Header
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ */
+
+#ifndef __LINUX_MEMORY_PL353_SMC_H
+#define __LINUX_MEMORY_PL353_SMC_H
+
+enum pl353_smc_ecc_mode {
+	PL353_SMC_ECCMODE_BYPASS = 0,
+	PL353_SMC_ECCMODE_APB = 1,
+	PL353_SMC_ECCMODE_MEM = 2
+};
+
+enum pl353_smc_mem_width {
+	PL353_SMC_MEM_WIDTH_8 = 0,
+	PL353_SMC_MEM_WIDTH_16 = 1
+};
+
+u32 pl353_smc_get_ecc_val(int ecc_reg);
+int pl353_smc_ecc_is_busy(void);
+int pl353_smc_get_nand_int_status_raw(void);
+void pl353_smc_clr_nand_int(void);
+int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode);
+int pl353_smc_set_ecc_pg_size(unsigned int pg_sz);
+int pl353_smc_set_buswidth(unsigned int bw);
+#endif
-- 
2.7.4
