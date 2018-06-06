Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="V6Xj+QsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B95CE60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFFHvs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:51:48 -0400
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:63424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932443AbeFFHvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:51:42 -0400
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
Subject: [LINUX PATCH v9 4/4] mtd: rawnand: pl353: Add basic driver for arm pl353 smc nand interface
Date: Wed, 6 Jun 2018 13:19:42 +0530
Message-ID: <1528271382-21690-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39840400004)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(7416002)(26005)(186003)(81156014)(81166006)(8676002)(5660300001)(486006)(50226002)(53946003)(106002)(36756003)(107886003)(336012)(106466001)(59450400001)(9786002)(426003)(356003)(575784001)(47776003)(48376002)(6666003)(63266004)(50466002)(4326008)(39060400002)(77096007)(2616005)(2201001)(476003)(110136005)(51416003)(76176011)(54906003)(316002)(446003)(36386004)(16586007)(126002)(8936002)(2906002)(305945005)(478600001)(11346002)(7696005)(921003)(107986001)(1121003)(217873001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1495;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:R3uvXBHKWTcxgco2yM0YHwiu8YdwSKjMgP7EoDtr6jNHIKEsf9QO366L2PbDnrwLumQ6j5SYLmOTF425pfJIKyM3xtpIs+vSC6hHaDTthDT6ZF0yqUPlg8aKgk7VcJF6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BY2PR0201MB1495;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;3:Mjc/erDYrjeFVacpny8+c3MN4twkxitXpIZlcNfgUOZlHht6KPZsLHcApBiUQatGYwQ0BrnjQhVk0i+3/uKgAyjDHLGMkxhkoasrTt18HDte48sySkeuh+RVHLNtctXjJ5fT/d3DzN5lrEuGeXZv4aTZ6UKhFFI0SRHdKM5tufZTdiq+Vecu+CtYEGHos6aqbxnHTB2/1Am3KIenwfnN2WO8b8Sqiv1nIJNiARQIzoW5WR7whBzH73vAFKxT/KPCAZl/REpRUES58Rd22kvstz1GXKTUH7ng/517K/FohRueJLCf802Iyl6Cvk45oPHoW90KhmEE2MtrZXAsgQhHJ4ACRMdLpdtXiVhi3d0c0w8=;25:MRXIIP6QwqPhQOlY1zdSIf/hlXLuoSH76dSiQaAW5+5uYQzd3jodTmmi9j5pr6HABkmL1J3ylmOQFWDyungrwDqxaVsXnY2zRackY7I15v7SXVB60JDlvSRJDyq3DecOSmWgAjrAqI5z2fqYJALq/A3wZxt/s6LkGKaau4VRQr8qJs8EWYBBBZEwBzoTo+E4tJCYHqL6pBrENiJYB+yn2En/mAMRTR26j8wjQ1gAfkoAfmynvQ7LWxfgMK1Xl7b7oi8GKf4Z/hCehgB5A+bwd1SS/ZaBFtvBJz4/91tqC/ySySHXs8JHmD+tzdm9B7HDJXKD9PrHtwlwpPSTKKY2dA==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1495:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;31:lUVCu7r/CmhsFoUOjhnMLpfObYOJ1BfBQFGAFO6QFZz1hfXjn0DZ3FOyOootJ3h0LwRLacDtNuOVMZHr4Ncw6U6ht2OOcY31b3PRk5Tb4Ye7jCW5jpsRIV6Dj2H6+NDyUVVFQKTTEaFOAtYk5iVn6MpxgHcOGDUIzebR5iJDFw5NG6RujCFY8rVpQmImzwUf8O2mizAk8HjCODHDwL/dyeHWrUwCo31MGAU/PTdPhNo=;20:nnTxBiv2LK4GvQEz3mkH+P/ofDfHRe/hLpZUTmt2UmhlkIAkFeKaEmhziBXQvDQJ8ML2HvxhN1++nFAu0lWlApRufKdGI/UJBmMHVuTyJoWkHolYqQqLHcJGyCs9hIhIN9i7loS/miwRzAFoCNjhWMEWLgVR5GVVvZe1ceTOX50Z7NiJoDRgGghvu9ytsELpXAdvMFAZJjqjoG1FjgfCsga+KTxtXW80hl4ISY7drOpJI59VGY3qakUgg5v2ItX7b8swG/cIogof1q57voUEbaGyrGtEkuqB6VDK46wf9haJL2Ydc0B+zM1lPnYDmjEF1lFrOpkkh8gpT8WbAr7QyIXKS6BN6GbO6se7A3n+CyFtBsiAtZcQ+hgKG7nwoteXeCbPsuphxThTTBCPxh1QXzgcmfT24vejihbkDWoIB0okYp9RS/8nxVIl4k4Y2M2nV8IXNEZaolw92In7e2dGIzHIMwk2Ti95Ym+PepXYVm7Raz+5yyFkeVk3T9TaNhcn
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB14959F63ACF7ACCD3499C345AF650@BY2PR0201MB1495.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR0201MB1495;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1495;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;4:tje8h1BxpWHIZ6vyJVhP89HREjLuS704/HKxQuVVwdpfK4gRyobZcLCo1It8/Vl++br7cnFDAVRg4tVCHzQ8OU/Fb572je8Xmt8wMv+XMXmJjPxB1lc8rJKfCaj0sfZB1gtQ3EkGJH7dzO6KZFSH4/PW7ooMLz8281GJFIboeFcXfWWkh4Ta3EyChvkinMDTVnzUnWlEHW1+Y4L6Zou5n5l55MCSi8p2gshqO09sF84CdXsnyDrnajT583Wh+reQ+eVDljTziiRzXqVzsRye/t3WXZXnx1JW40UIzUijM7bKLi5UGYR4W6kCFVx+ovMl
X-Forefront-PRVS: 06952FC175
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1495;23:1vvDfEXVfZddwQjGCSwjtcVzMwsSXbpHgVSYfEa?=
 =?us-ascii?Q?/fH3rUnil41z3qpESW+IjPhPQIuyq3DROMsQmfw3+Ile3JrFYy/aRIvI2/IW?=
 =?us-ascii?Q?ACZ7AcKVAG7UNWbntkwXN5fGbR4+/ZMmTHcwesyGk6sIwf3tFSPA4Wo1+j1d?=
 =?us-ascii?Q?lK5lZJVBKFGIJTZ6gUH43jD6qwZTGT2RZvInebdLqsmi9Rdgtgc9u2wTEk+I?=
 =?us-ascii?Q?tFXr8WQf2EtEwTnO7GMvSZCtWHXet6McCeclqVH4Yu4yTExYJRahcl1joqDN?=
 =?us-ascii?Q?HPJrHMc6s5Ob5F1otYvMMv1n9se3sFwwvqlfw6sYLxyjtd3OApnFxSr20C6j?=
 =?us-ascii?Q?p43K7AlEiWX+G2ajlhUKdu1z3sF+ijPk4X1aQZirDj4XrkB/jzCmlEz9RT8w?=
 =?us-ascii?Q?oI+IzFg0XLeAaYDmCIDjOQfc8YTfM6O1hvfyVW2duJRpvfpUEagEmcW5VGSc?=
 =?us-ascii?Q?19xDhiAvNE6CgpPtVFJSDCodr6R2UapOiy1S4Ah9yuvhrpeuq3ZFl4KLSAwq?=
 =?us-ascii?Q?Iq/phTYOsYs11ac4FXFElqFzcb35ylI2CWUTSntxkrJJcX/ouO82y14N0Cwc?=
 =?us-ascii?Q?pjNm8sZr16VIysPooi6AqFBvjxJIr9S7u7y6KX+hrsUVpVFPBLD4K3mAItBe?=
 =?us-ascii?Q?KkI/uIa70ef3HJmdmQfnQ+GmKo00Ud68QbIOMh7HH78IefX3+P+tlcQhsMZR?=
 =?us-ascii?Q?UusMSUNTep3NFV8yrTNKpyCSgobk16zwZ2JxlAZbosBR0pWJ2hjiWkGUQ9fY?=
 =?us-ascii?Q?NeWK2bIjC/4ejWFE1Szhg+cfo9bEolUZ0NTNRnBsgzySjEFwvSZLTZMJClVp?=
 =?us-ascii?Q?bZVYMG5VcqXMqQn6saUD+cuByDUHiPC42d9aXCNdpnCKQqh/8LQJWCipRQcM?=
 =?us-ascii?Q?LV72pWLX8yYcWc42BJEvsh8A1/hAz2ijATmsUoiKrN5vqs8plwrD2Gvm7VJH?=
 =?us-ascii?Q?5lHNyJottnB5pk8ZYa74LCFdJYgzKcihH2U6rlFJSEdA8XUvJetyYcAWI2lg?=
 =?us-ascii?Q?kKsXKIVgN/pBb4aq9adWVyeVXRI9ldEosbWzDA/oH2QXl6HRrTiY+DNI7Amu?=
 =?us-ascii?Q?g0QKwEEpA7rC/fumyzXMLtPYHwxkaohCW6ZyXiXF/3CnfmbGxKAXEJGNgeJK?=
 =?us-ascii?Q?24f1jTyWQbI8mz8wHQSsDT2hR0Bsl6zMv6MicpEnBZ4oHgoy491KCk+Cggm1?=
 =?us-ascii?Q?TX4QD5wO+vex38oNrxOrgV5ovPWCExdVtwAceD/ulncONMBGPM3FKOgsr1e5?=
 =?us-ascii?Q?LBpFr/+2TVD39xOWShrV/Qjk7Tm57m2SPzMJzT9tZjMUJa15lEugjlFt8dgc?=
 =?us-ascii?Q?hq5APJuLmFC6fBdWj3sTiV5iTomZSo6glyT9X9psbQSOp?=
X-Microsoft-Antispam-Message-Info: UL9cfSWndXzNPYM3Y0ihUymD4vWL/dp9I2d2PY+9W2JIrVbXVto+k+XBfuStssmokV6QKGSXCwtHkpD/sigb8xl+zhSYZC+R29NdkT2aHPf8rhnhbusOAo9zNMivL6Ylyl3C2leNY3+W+ZInz29ErTSwsXE1VAep9no8BP/z6ylJVkpwz8vetaYyEyG+4s9M
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;6:WL3U0NenAj3ZEnL9a7wr71o4DouXOs4CZRVqqf2ggWr1WgQozrJV+m8vhGvFG1BgyrA03N3aluAh3KUybhdiP0TtoBvYz6dkq6WS0Rz3+StMoeG0HtD+29v63FVIlQzwnxslV5eFd0VlEC7sF4yFI/H+X2rEhOxdGhU2u+/eLru8U2bC/Yg5KeKZLtSxjCXh3QMZ2mm5sQE8UpK0/W7L4lT9uzBTE9sKlp+KD/fOjeUHFGe3zbS1fdLLQ9aAXYGeuoMGORH+OBKrEgmlzE3vRlheLcwCkVr1Rbz4p50iX2qOIdGNToJzdcwyj7MckqPgZZDC7aGG7vHFw6WLGdHWbFBy4p2CSGXPbsoU6VWx+SpTb+5XMZc5/hzGVGPWvM7QzPtWmuzXYT8wguEw/LssSzkOW0L2azV3craiabB7K3hm2BM7Ef/4i+qW6u46Xs9hYL1vAcCgzm8FlNHGv0o4lw==;5:cuDR1c/e/tr2NZpXPGWHuxetfE5ZCuhMSjXPrhP0FIF4aU6q2EmXh0vdk2CoVPru33vG7jUMxGechVNCmmbf1VQUdGNIqYDM26LtvQWocTDYRH6q2iWt/IYc6040GGBp57JLmeMBjAWhMbe+RK6l2nAsHEs4bo8OFYQhwT/Kn6U=;24:8yzW6pzIrNYMqUPiLfaXimpLVMMsrWDp+rB/5QgKLJAkVAk5yhcYCcZnsqXVRfuZ1zHPsVFTAlLeSvHsvpMWjtRXhVEHgIpgT9lo6ReN540=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1495;7:kHCQdziVKNyFQrqAaV4IOHpRTJ5s3/axhA5L6dPNvWHAhOp3txXykzR9aUmI7f46sJhNpsx7DjM2bvt6FsS9r5Q3fmJX3Zc6EA7gcnxGENMiSUHX42G94wKX26pf6QflALw9GM22FK1ADV8osgg3dAjVRDbvZ22CkfcTiYaQNfViF9r6xb1mIE9VHs4Cf+yUx/TcACRmZ8YpsAv6Ujd2jnnFnr7Tg4ijkFbxvLnpMZR2BUS5wPGsXGPk5fJ7E52V
X-MS-Office365-Filtering-Correlation-Id: 6c920560-bef0-497f-928b-08d5cb82546b
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 07:51:35.4378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c920560-bef0-497f-928b-08d5cb82546b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1495
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for arm pl353 static memory controller nand interface with
HW ECC support. This controller is used in xilinx zynq soc for interfacing
the nand flash memory.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v9:
 - Addressed the below comments given by Miquel
 - instead of using pl353_nand_write32, use directly writel_relaxed
 - Fixed check patch warnings
 - Renamed write_buf/read_buf to write_data_op/read_data_op
 - use BIT macro instead of 1 << nr
 - Use NAND_ROW_ADDR_3 flag
 - Use nand_wait_ready()
 - Removed swecc functions
 - Use address cycles as per size, instead of reading it from Parameter page
 - Instead of writing too many patterns, use optional property
Changes in v8:
 - Added exec_op() implementation
 - Fixed the below v7 review comments
 - removed mtd_info from pl353_nand_info struct
 - Corrected ecc layout offsets
 - Added on-die ecc support
Changes in v7:
 - Currently not implemented the memclk rate adjustments. I will
   look into this later and once the basic driver is accepted.
 - Fixed GPL licence ident
Changes in v6:
 - Fixed the checkpatch.pl reported warnings
 - Using the address cycles information from the onfi param page
   earlier it is hardcoded to 5 in driver
Changes in v5:
 - Configure the nand timing parameters as per the onfi spec
Changes in v4:
 - Updated the driver to sync with pl353_smc driver APIs
Changes in v3:
 - implemented the proper error codes
 - further breakdown this patch to multiple sets
 - added the controller and driver details to Documentation section
 - updated the licenece to GPLv2
 - reorganized the pl353_nand_ecc_init function
Changes in v2:
 - use "depends on" rather than "select" option in kconfig
 - remove unused variable parts
 - remove dummy helper and use writel_relaxed directly
---

 drivers/mtd/nand/raw/Kconfig      |    7 +
 drivers/mtd/nand/raw/Makefile     |    3 +
 drivers/mtd/nand/raw/pl353_nand.c | 1236 +++++++++++++++++++++++++++++++++++++
 3 files changed, 1246 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/pl353_nand.c

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6871ff0..1c5d528 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -530,4 +530,11 @@ config MTD_NAND_MTK
 	  Enables support for NAND controller on MTK SoCs.
 	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
 
+config MTD_NAND_PL353
+	tristate "ARM Pl353 NAND flash driver"
+	depends on MTD_NAND && ARM
+	depends on PL353_SMC
+	help
+	  Enables support for PrimeCell Static Memory Controller PL353.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 165b7ef..6855a0d 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -56,7 +56,9 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
 obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
 obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
 obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
+obj-$(CONFIG_MTD_NAND_PL353)		+= pl353_nand.o
 
+CFLAGS_{nand_base.o} := -DDEBUG
 nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
 nand-objs += nand_amd.o
 nand-objs += nand_hynix.o
@@ -64,3 +66,4 @@ nand-objs += nand_macronix.o
 nand-objs += nand_micron.o
 nand-objs += nand_samsung.o
 nand-objs += nand_toshiba.o
+
diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
new file mode 100644
index 0000000..a880eade
--- /dev/null
+++ b/drivers/mtd/nand/raw/pl353_nand.c
@@ -0,0 +1,1236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM PL353 NAND flash controller driver
+ *
+ * Copyright (C) 2017 Xilinx, Inc
+ * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
+ * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/nand_ecc.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/platform_data/pl353-smc.h>
+
+#define PL353_NAND_DRIVER_NAME "pl353-nand"
+
+/* NAND flash driver defines */
+#define PL353_NAND_CMD_PHASE	1	/* End command valid in command phase */
+#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */
+#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
+
+/* Flash memory controller operating parameters */
+
+#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */ \
+				 (0 << 5))	/* No Jumping */
+
+/* AXI Address definitions */
+#define START_CMD_SHIFT		3
+#define END_CMD_SHIFT		11
+#define END_CMD_VALID_SHIFT	20
+#define ADDR_CYCLES_SHIFT	21
+#define CLEAR_CS_SHIFT		21
+#define ECC_LAST_SHIFT		10
+#define COMMAND_PHASE		(0 << 19)
+#define DATA_PHASE		BIT(19)
+
+#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
+#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
+
+#define ONDIE_ECC_FEATURE_ADDR	0x90
+#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
+#define PL353_NAND_LAST_TRANSFER_LENGTH	4
+
+struct pl353_nfc_op {
+	u32 cmnds[4];
+	u32 thirdrow;
+	u32 type;
+	u32 end_cmd;
+	u32 addrs;
+	bool wait;
+	u32 len;
+	u32 naddrs;
+	unsigned int data_instr_idx;
+	const struct nand_op_instr *data_instr;
+	unsigned int rdy_timeout_ms;
+	unsigned int rdy_delay_ns;
+	unsigned int data_delay_ns;
+	unsigned int cle_ale_delay_ns;
+	u32 addr5;
+	u32 addr6;
+};
+
+/**
+ * struct pl353_nand_info - Defines the NAND flash driver instance
+ * @chip:		NAND chip information structure
+ * @nand_base:		Virtual address of the NAND flash device
+ * @end_cmd_pending:	End command is pending
+ * @end_cmd:		End command
+ * @row_addr_cycles:	Row address cycles
+ * @col_addr_cycles:	Column address cycles
+ * @address:		Page address
+ * @cmd_pending:	More command is needed
+ */
+struct pl353_nand_info {
+	struct nand_chip chip;
+	void __iomem *nand_base;
+	unsigned long end_cmd_pending;
+	unsigned long end_cmd;
+	u8 addr_cycles;
+	u32 address;
+	u32 cmd_pending;
+	struct completion complete;
+};
+
+static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes);
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 8;
+	oobregion->length = 8;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops = {
+	.ecc = pl353_ecc_ooblayout16_ecc,
+	.free = pl353_ecc_ooblayout16_free,
+};
+
+static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 52;
+	oobregion->length = chip->ecc.bytes;
+
+	return 0;
+}
+
+static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section)
+		return -ERANGE;
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobregion->offset = (section * chip->ecc.bytes) + 2;
+	oobregion->length = 50;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
+	.ecc = pl353_ecc_ooblayout64_ecc,
+	.free = pl353_ecc_ooblayout64_free,
+};
+
+/* Generic flash bbt decriptors */
+static u8 bbt_pattern[] = { 'B', 'b', 't', '0' };
+static u8 mirror_pattern[] = { '1', 't', 'b', 'B' };
+
+static struct nand_bbt_descr bbt_main_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = bbt_pattern
+};
+
+static struct nand_bbt_descr bbt_mirror_descr = {
+	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
+		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
+	.offs = 4,
+	.len = 4,
+	.veroffs = 20,
+	.maxblocks = 4,
+	.pattern = mirror_pattern
+};
+
+/**
+ * pl353_nand_read_data_op - read chip data into buffer
+ * @chip:	Pointer to the NAND chip info structure
+ * @in:		Pointer to the buffer to store read data
+ * @len:	Number of bytes to read
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_data_op(struct nand_chip *chip,
+				   u8 *in,
+				   unsigned int len)
+{
+	int i;
+
+	if (IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
+	    IS_ALIGNED(len, sizeof(uint32_t))) {
+		u32 *ptr = (u32 *)in;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			ptr[i] = readl(chip->IO_ADDR_R);
+	} else {
+		for (i = 0; i < len; i++)
+			in[i] = readb(chip->IO_ADDR_R);
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_buf - write buffer to chip
+ * @mtd:	Pointer to the mtd info structure
+ * @buf:	Pointer to the buffer to store write data
+ * @len:	Number of bytes to write
+ */
+static void pl353_nand_write_data_op(struct mtd_info *mtd, const u8 *buf,
+				     int len)
+{
+	int i;
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
+	    IS_ALIGNED(len, sizeof(uint32_t))) {
+		u32 *ptr = (u32 *)buf;
+
+		len /= 4;
+		for (i = 0; i < len; i++)
+			writel(ptr[i], chip->IO_ADDR_W);
+	} else {
+		for (i = 0; i < len; i++)
+			writeb(buf[i], chip->IO_ADDR_W);
+	}
+}
+
+/**
+ * pl353_nand_calculate_hwecc - Calculate Hardware ECC
+ * @mtd:	Pointer to the mtd_info structure
+ * @data:	Pointer to the page data
+ * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
+ *
+ * This function retrieves the Hardware ECC data from the controller and returns
+ * ECC data back to the MTD subsystem.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
+				      const u8 *data, u8 *ecc)
+{
+	u32 ecc_value, ecc_status;
+	u8 ecc_reg, ecc_byte;
+	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
+	/* Wait till the ECC operation is complete or timeout */
+	do {
+		if (pl353_smc_ecc_is_busy())
+			cpu_relax();
+		else
+			break;
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		pr_err("%s timed out\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	for (ecc_reg = 0; ecc_reg < 4; ecc_reg++) {
+		/* Read ECC value for each block */
+		ecc_value = pl353_smc_get_ecc_val(ecc_reg);
+		ecc_status = (ecc_value >> 24) & 0xFF;
+		/* ECC value valid */
+		if (ecc_status & 0x40) {
+			for (ecc_byte = 0; ecc_byte < 3; ecc_byte++) {
+				/* Copy ECC bytes to MTD buffer */
+				*ecc = ~ecc_value & 0xFF;
+				ecc_value = ecc_value >> 8;
+				ecc++;
+			}
+		} else {
+			pr_warn("%s status failed\n", __func__);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * onehot - onehot function
+ * @value:	Value to check for onehot
+ *
+ * This function checks whether a value is onehot or not.
+ * onehot is if and only if onebit is set.
+ *
+ * Return:	1 if it is onehot else 0
+ */
+static int onehot(unsigned short value)
+{
+	return (value & (value - 1)) == 0;
+}
+
+/**
+ * pl353_nand_correct_data - ECC correction function
+ * @mtd:	Pointer to the mtd_info structure
+ * @buf:	Pointer to the page data
+ * @read_ecc:	Pointer to the ECC value read from spare data area
+ * @calc_ecc:	Pointer to the calculated ECC value
+ *
+ * This function corrects the ECC single bit errors & detects 2-bit errors.
+ *
+ * Return:	0 if no ECC errors found
+ *		1 if single bit error found and corrected.
+ *		-1 if multiple ECC errors found.
+ */
+static int pl353_nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
+				   unsigned char *read_ecc,
+				   unsigned char *calc_ecc)
+{
+	unsigned char bit_addr;
+	unsigned int byte_addr;
+	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
+	unsigned short calc_ecc_lower, calc_ecc_upper;
+
+	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) & 0xfff;
+	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) & 0xfff;
+
+	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) & 0xfff;
+	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) & 0xfff;
+
+	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
+	ecc_even = read_ecc_upper ^ calc_ecc_upper;
+
+	/* no error */
+	if (ecc_odd == 0 && ecc_even == 0)
+		return 0;
+
+	if (ecc_odd == (~ecc_even & 0xfff)) {
+		/* bits [11:3] of error code is byte offset */
+		byte_addr = (ecc_odd >> 3) & 0x1ff;
+		/* bits [2:0] of error code is bit offset */
+		bit_addr = ecc_odd & 0x7;
+		/* Toggling error bit */
+		buf[byte_addr] ^= (BIT(bit_addr));
+		return 1;
+	}
+	/* one error in parity */
+	if (onehot(ecc_odd | ecc_even) == 1)
+		return 1;
+
+	/* Uncorrectable error */
+	return -1;
+}
+
+static int pl353_dev_timeout(struct mtd_info *mtd, struct nand_chip *chip)
+{
+	unsigned long timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
+
+	do {
+		if (chip->dev_ready(mtd))
+			break;
+		cpu_relax();
+	} while (!time_after_eq(jiffies, timeout));
+
+	if (time_after_eq(jiffies, timeout)) {
+		pr_err("%s timed out\n", __func__);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void pl353_prepare_cmd(struct mtd_info *mtd, struct nand_chip *chip,
+			      int page, int column, int start_cmd, int end_cmd,
+			      bool read)
+{
+	unsigned long data_phase_addr;
+	u32 end_cmd_valid = 0;
+	void __iomem *cmd_addr;
+	unsigned long cmd_phase_addr = 0, cmd_data = 0;
+
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+
+	end_cmd_valid = read ? 1 : 0;
+
+	cmd_phase_addr = (unsigned long __force)xnand->nand_base +
+			 ((xnand->addr_cycles
+			 << ADDR_CYCLES_SHIFT) |
+			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+			 (COMMAND_PHASE) |
+			 (end_cmd << END_CMD_SHIFT) |
+			 (start_cmd << START_CMD_SHIFT));
+	cmd_addr = (void __iomem * __force)cmd_phase_addr;
+
+	/* Get the data phase address */
+	data_phase_addr = (unsigned long __force)xnand->nand_base +
+			  ((0x0 << CLEAR_CS_SHIFT) |
+			  (0 << END_CMD_VALID_SHIFT) |
+			  (DATA_PHASE) |
+			  (end_cmd << END_CMD_SHIFT) |
+			  (0x0 << ECC_LAST_SHIFT));
+
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	chip->IO_ADDR_W = chip->IO_ADDR_R;
+	if (chip->options & NAND_BUSWIDTH_16)
+		column /= 2;
+	cmd_data = column;
+	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+		cmd_data |= page << 16;
+		/* Another address cycle for devices > 128MiB */
+		if (chip->options & NAND_ROW_ADDR_3) {
+			writel_relaxed(cmd_data, cmd_addr);
+			cmd_data = (page >> 16);
+		}
+	} else {
+		cmd_data |= page << 8;
+	}
+
+	writel_relaxed(cmd_data, cmd_addr);
+}
+
+/**
+ * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
+			       int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnand->nand_base;
+
+	chip->pagebuf = -1;
+	if (mtd->writesize < PL353_NAND_ECC_SIZE)
+		return 0;
+
+	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+
+	ndelay(100);
+	pl353_dev_timeout(mtd, chip);
+
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write function
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ * @page:	Page number to write
+ *
+ * Return:	Zero on success and EIO on failure
+ */
+static int pl353_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
+				int page)
+{
+	const u8 *buf = chip->oob_poi;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnand->nand_base;
+	u32 addrcycles = 0;
+
+	chip->pagebuf = -1;
+	addrcycles = xnand->addr_cycles;
+	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+	ndelay(100);
+	pl353_nand_write_data_op(mtd, buf,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, buf, PL353_NAND_LAST_TRANSFER_LENGTH);
+	nand_wait_ready(mtd);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_read_page_raw(struct mtd_info *mtd,
+				    struct nand_chip *chip,
+				    u8 *buf, int oob_required, int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnand->nand_base;
+
+	pl353_nand_read_data_op(chip, buf, mtd->writesize);
+	p = chip->oob_poi;
+	pl353_nand_read_data_op(chip, p,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_write_page_raw - [Intern] raw page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_raw(struct mtd_info *mtd,
+				     struct nand_chip *chip,
+				     const u8 *buf, int oob_required,
+				     int page)
+{
+	unsigned long data_phase_addr;
+	u8 *p;
+
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnand->nand_base;
+
+	pl353_nand_write_data_op(mtd, buf, mtd->writesize);
+	p = chip->oob_poi;
+	pl353_nand_write_data_op(mtd, p,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+
+	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+	ndelay(100);
+	nand_wait_ready(mtd);
+	return 0;
+}
+
+/**
+ * nand_write_page_hwecc - Hardware ECC based page write function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the data buffer
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to write
+ *
+ * This functions writes data and hardware generated ECC values in to the page.
+ *
+ * Return:	Always return zero
+ */
+static int pl353_nand_write_page_hwecc(struct mtd_info *mtd,
+				       struct nand_chip *chip,
+				       const u8 *buf, int oob_required,
+				       int page)
+{
+	int eccsize = chip->ecc.size;
+	int eccsteps = chip->ecc.steps;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *oob_ptr;
+	const u8 *p = buf;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnand->nand_base;
+
+	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
+			  NAND_CMD_PAGEPROG, 0);
+	ndelay(100);
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_write_data_op(mtd, p, eccsize);
+		p += eccsize;
+	}
+	pl353_nand_write_data_op(mtd, p,
+				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	p = buf;
+	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
+
+	/* Wait for ECC to be calculated and read the error values */
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
+					 0, chip->ecc.total);
+	if (ret)
+		return ret;
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+
+	/* Write the spare area with ECC bytes */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_write_data_op(mtd, oob_ptr,
+				 (mtd->oobsize -
+				 PL353_NAND_LAST_TRANSFER_LENGTH));
+
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_write_data_op(mtd, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/*
+	 * Apply this short delay always to ensure that we do wait tWB in any
+	 * case on any machine.
+	 */
+	ndelay(100);
+	nand_wait_ready(mtd);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_read_page_hwecc - Hardware ECC based page read function
+ * @mtd:		Pointer to the mtd info structure
+ * @chip:		Pointer to the NAND chip info structure
+ * @buf:		Pointer to the buffer to store read data
+ * @oob_required:	Caller requires OOB data read to chip->oob_poi
+ * @page:		Page number to read
+ *
+ * This functions reads data and checks the data integrity by comparing hardware
+ * generated ECC values and read ECC values from spare area.
+ *
+ * Return:	0 always and updates ECC operation status in to MTD structure
+ */
+static int pl353_nand_read_page_hwecc(struct mtd_info *mtd,
+				      struct nand_chip *chip,
+				      u8 *buf, int oob_required, int page)
+{
+	int i, stat, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	u8 *p = buf;
+	u8 *ecc_calc = chip->ecc.calc_buf;
+	u8 *ecc = chip->ecc.code_buf;
+	unsigned int max_bitflips = 0;
+	u8 *oob_ptr;
+	u32 ret;
+	unsigned long data_phase_addr;
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	unsigned long nand_offset = (unsigned long __force)xnand->nand_base;
+
+	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
+			  NAND_CMD_READSTART, 1);
+	ndelay(100);
+	pl353_dev_timeout(mtd, chip);
+
+	for ( ; (eccsteps - 1); eccsteps--) {
+		pl353_nand_read_data_op(chip, p, eccsize);
+		p += eccsize;
+	}
+	pl353_nand_read_data_op(chip, p,
+				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
+	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Set ECC Last bit to 1 */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	/* Read the calculated ECC value */
+	p = buf;
+	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
+
+	/* Clear ECC last bit */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr &= ~PL353_NAND_ECC_LAST;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+
+	/* Read the stored ECC value */
+	oob_ptr = chip->oob_poi;
+	pl353_nand_read_data_op(chip, oob_ptr,
+				(mtd->oobsize -
+				PL353_NAND_LAST_TRANSFER_LENGTH));
+
+	/* de-assert chip select */
+	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
+	data_phase_addr -= nand_offset;
+	data_phase_addr |= PL353_NAND_CLEAR_CS;
+	data_phase_addr += nand_offset;
+	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+
+	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
+	pl353_nand_read_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
+
+	ret = mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
+
+	eccsteps = chip->ecc.steps;
+	p = buf;
+
+	/* Check ECC error for all blocks and correct if it is correctable */
+	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
+		stat = chip->ecc.correct(mtd, p, &ecc[i], &ecc_calc[i]);
+		if (stat < 0) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += stat;
+			max_bitflips = max_t(unsigned int, max_bitflips, stat);
+		}
+	}
+
+	return max_bitflips;
+}
+
+/**
+ * pl353_nand_select_chip - Select the flash device
+ * @mtd:	Pointer to the mtd info structure
+ * @chip:	Pointer to the NAND chip info structure
+ *
+ * This function is empty as the NAND controller handles chip select line
+ * internally based on the chip address passed in command and data phase.
+ */
+static void pl353_nand_select_chip(struct mtd_info *mtd, int chip)
+{
+}
+
+/* NAND framework ->exec_op() hooks and related helpers */
+static void pl353_nfc_parse_instructions(struct nand_chip *chip,
+					 const struct nand_subop *subop,
+					 struct pl353_nfc_op *nfc_op)
+{
+	const struct nand_op_instr *instr = NULL;
+	unsigned int op_id, offset, naddrs;
+	int i, len;
+	const u8 *addrs;
+
+	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
+	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
+		nfc_op->len = nand_subop_get_data_len(subop, op_id);
+		len = nand_subop_get_data_len(subop, op_id);
+		instr = &subop->instrs[op_id];
+		if (subop->ninstrs == 1)
+			nfc_op->cmnds[0] = -1;
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			nfc_op->type = NAND_OP_CMD_INSTR;
+			if (op_id)
+				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
+			else
+				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			offset = nand_subop_get_addr_start_off(subop, op_id);
+			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
+			addrs = &instr->ctx.addr.addrs[offset];
+			nfc_op->addrs = instr->ctx.addr.addrs[offset];
+			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
+				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
+						 (8 * i);
+			}
+
+			if (naddrs >= 5)
+				nfc_op->addr5 = addrs[4];
+			if (naddrs >= 6)
+				nfc_op->addr6 = addrs[5];
+			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
+								     op_id);
+			nfc_op->cle_ale_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			nfc_op->data_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			nfc_op->data_instr = instr;
+			nfc_op->type = NAND_OP_DATA_IN_INSTR;
+			nfc_op->data_instr_idx = op_id;
+			nfc_op->data_delay_ns = instr->delay_ns;
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
+			nfc_op->rdy_delay_ns = instr->delay_ns;
+			nfc_op->wait = true;
+			break;
+		}
+	}
+}
+
+static void cond_delay(unsigned int ns)
+{
+	if (!ns)
+		return;
+
+	if (ns < 10000)
+		ndelay(ns);
+	else
+		udelay(DIV_ROUND_UP(ns, 1000));
+}
+
+/**
+ * pl353_nand_cmd_function - Send command to NAND device
+ * @chip:	Pointer to the NAND chip info structure
+ * @subop:	Pointer to array of instructions
+ * Return:	Always return zero
+ */
+static int pl353_nand_cmd_function(struct nand_chip *chip,
+				   const struct nand_subop *subop)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const struct nand_op_instr *instr;
+	struct pl353_nfc_op nfc_op = {};
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+	void __iomem *cmd_addr;
+	unsigned long cmd_data = 0, end_cmd_valid = 0;
+	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
+	unsigned int op_id, len, offset;
+	bool reading;
+
+	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
+	instr = nfc_op.data_instr;
+	op_id = nfc_op.data_instr_idx;
+	len = nand_subop_get_data_len(subop, op_id);
+	offset = nand_subop_get_data_start_off(subop, op_id);
+
+	if (nfc_op.cmnds[0] != -1) {
+		pl353_smc_clr_nand_int();
+		/* Get the command phase address */
+		if (nfc_op.cmnds[1] != 0) {
+			if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
+				end_cmd_valid = 0;
+			else
+				end_cmd_valid = 1;
+			end_cmd = nfc_op.cmnds[1];
+		}  else {
+			end_cmd = 0x0;
+		}
+		cmd_phase_addr = (unsigned long __force)xnand->nand_base +
+				 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
+				 (end_cmd_valid << END_CMD_VALID_SHIFT) |
+				 (COMMAND_PHASE) |
+				 (end_cmd << END_CMD_SHIFT) |
+				 (nfc_op.cmnds[0] << START_CMD_SHIFT));
+
+		cmd_addr = (void __iomem * __force)cmd_phase_addr;
+		/* Get the data phase address */
+		end_cmd_valid = 0;
+
+		data_phase_addr = (unsigned long __force)xnand->nand_base +
+				  ((0x0 << CLEAR_CS_SHIFT) |
+				  (end_cmd_valid << END_CMD_VALID_SHIFT) |
+				  (DATA_PHASE) |
+				  (end_cmd << END_CMD_SHIFT) |
+				  (0x0 << ECC_LAST_SHIFT));
+		chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
+		chip->IO_ADDR_W = chip->IO_ADDR_R;
+		/* Command phase AXI Read & Write */
+		if (nfc_op.naddrs >= 5) {
+			if (mtd->writesize > PL353_NAND_ECC_SIZE) {
+				cmd_data = nfc_op.addrs;
+				/* Another address cycle for devices > 128MiB */
+				if (chip->options & NAND_ROW_ADDR_3) {
+					writel_relaxed(cmd_data, cmd_addr);
+					cmd_data = nfc_op.addr5;
+					if (nfc_op.naddrs >= 6)
+						cmd_data |= (nfc_op.addr6 << 8);
+				}
+			}
+		}  else {
+			if (nfc_op.addrs != -1) {
+				int column = nfc_op.addrs;
+				/*
+				 * Change read/write column, read id etc
+				 * Adjust columns for 16 bit bus width
+				 */
+				if ((chip->options & NAND_BUSWIDTH_16) &&
+				    (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
+					nfc_op.cmnds[0] == NAND_CMD_SEQIN ||
+					nfc_op.cmnds[0] == NAND_CMD_RNDOUT ||
+					nfc_op.cmnds[0] == NAND_CMD_RNDIN)) {
+					column >>= 1;
+				}
+				cmd_data = column;
+			}
+		}
+		writel_relaxed(cmd_data, cmd_addr);
+	ndelay(100);
+	}
+
+	cond_delay(nfc_op.cle_ale_delay_ns);
+	if (!nfc_op.data_instr)
+		return 0;
+
+	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
+	udelay(1000);
+
+	if (!reading) {
+		cond_delay(nfc_op.rdy_delay_ns);
+
+		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN &&
+		    nfc_op.cmnds[1] == NAND_CMD_PAGEPROG) {
+			pl353_nand_write_page_raw(mtd, chip,
+						  instr->ctx.data.buf.out, 0,
+						  nfc_op.addrs);
+		} else {
+			pl353_nand_write_data_op(mtd, instr->ctx.data.buf.out,
+						 len);
+		}
+	}
+
+	else if (reading) {
+		cond_delay(nfc_op.rdy_delay_ns);
+		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len);
+	}
+	cond_delay(nfc_op.data_delay_ns);
+
+	return 0;
+}
+
+static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER
+	(NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
+		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false),
+		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
+		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
+		NAND_OP_PARSER_PAT_CMD_ELEM(true),
+		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
+	NAND_OP_PARSER_PATTERN
+		(pl353_nand_cmd_function,
+		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
+	);
+
+static int pl353_nfc_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			     bool check_only)
+{
+	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
+					      op, check_only);
+}
+
+/**
+ * pl353_nand_device_ready - Check device ready/busy line
+ * @mtd:	Pointer to the mtd_info structure
+ *
+ * Return:	0 on busy or 1 on ready state
+ */
+static int pl353_nand_device_ready(struct mtd_info *mtd)
+{
+	if (pl353_smc_get_nand_int_status_raw()) {
+		pl353_smc_clr_nand_int();
+		return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * pl353_nand_ecc_init - Initialize the ecc information as per the ecc mode
+ * @mtd:	Pointer to the mtd_info structure
+ * @ecc:	Pointer to ECC control structure
+ * @ecc_mode:	ondie ecc status
+ *
+ * This function initializes the ecc block and functional pointers as per the
+ * ecc mode
+ */
+static void pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
+				int ecc_mode)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pl353_nand_info *xnand =
+		container_of(chip, struct pl353_nand_info, chip);
+
+
+	if (ecc_mode == NAND_ECC_ON_DIE) {
+		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
+		/*
+		 * On-Die ECC spare bytes offset 8 is used for ECC codes
+		 * Use the BBT pattern descriptors
+		 */
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+		bitmap_set(chip->parameters.get_feature_list,
+			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
+		bitmap_set(chip->parameters.set_feature_list,
+			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
+	} else {
+		ecc->read_oob = pl353_nand_read_oob;
+		ecc->write_oob = pl353_nand_write_oob;
+
+		ecc->mode = NAND_ECC_HW;
+		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
+		ecc->bytes = 3;
+		ecc->strength = 1;
+		ecc->calculate = pl353_nand_calculate_hwecc;
+		ecc->correct = pl353_nand_correct_data;
+		ecc->hwctl = NULL;
+		ecc->read_page = pl353_nand_read_page_hwecc;
+		ecc->size = PL353_NAND_ECC_SIZE;
+		ecc->write_page = pl353_nand_write_page_hwecc;
+		pl353_smc_set_ecc_pg_size(mtd->writesize);
+		switch (mtd->writesize) {
+		case SZ_512:
+		case SZ_1K:
+		case SZ_2K:
+			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
+			break;
+		default:
+			/*
+			 * The software ECC routines won't work with the
+			 * SMC controller
+			 */
+			ecc->calculate = nand_calculate_ecc;
+			ecc->correct = nand_correct_data;
+			ecc->size = 256;
+			break;
+		}
+		if (mtd->writesize <= SZ_512)
+			xnand->addr_cycles = 1;
+		else
+			xnand->addr_cycles = 2;
+
+		if (chip->options & NAND_ROW_ADDR_3)
+			xnand->addr_cycles += 3;
+		else
+			xnand->addr_cycles += 2;
+
+		if (mtd->oobsize == 16)
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
+		else if (mtd->oobsize == 64)
+			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
+	}
+}
+
+/**
+ * pl353_nand_probe - Probe method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function initializes the driver data structures and the hardware.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_probe(struct platform_device *pdev)
+{
+	struct pl353_nand_info *xnand;
+	struct mtd_info *mtd;
+	struct nand_chip *nand_chip;
+	struct resource *res;
+
+	xnand = devm_kzalloc(&pdev->dev, sizeof(*xnand), GFP_KERNEL);
+	if (!xnand)
+		return -ENOMEM;
+
+	/* Map physical address of NAND flash */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xnand->nand_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(xnand->nand_base))
+		return PTR_ERR(xnand->nand_base);
+
+	nand_chip = &xnand->chip;
+	mtd = nand_to_mtd(nand_chip);
+	nand_chip->exec_op = pl353_nfc_exec_op;
+	nand_set_controller_data(nand_chip, xnand);
+	mtd->priv = nand_chip;
+	mtd->owner = THIS_MODULE;
+	mtd->name = PL353_NAND_DRIVER_NAME;
+	nand_set_flash_node(nand_chip, pdev->dev.of_node);
+
+	/* Set address of NAND IO lines */
+	nand_chip->IO_ADDR_R = xnand->nand_base;
+	nand_chip->IO_ADDR_W = xnand->nand_base;
+	/* Set the driver entry points for MTD */
+	nand_chip->dev_ready = pl353_nand_device_ready;
+	nand_chip->select_chip = pl353_nand_select_chip;
+	/* If we don't set this delay driver sets 20us by default */
+	nand_chip->chip_delay = 30;
+
+	/* Set the device option and flash width */
+	nand_chip->options = NAND_BUSWIDTH_AUTO;
+	nand_chip->bbt_options = NAND_BBT_USE_FLASH;
+	platform_set_drvdata(pdev, xnand);
+
+	/* first scan to find the device and get the page size */
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		dev_err(&pdev->dev, "nand_scan_ident for NAND failed\n");
+		return -ENXIO;
+	}
+	pl353_nand_ecc_init(mtd, &nand_chip->ecc, nand_chip->ecc.mode);
+	if (nand_chip->options & NAND_BUSWIDTH_16)
+		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
+	/* second phase scan */
+	if (nand_scan_tail(mtd)) {
+		dev_err(&pdev->dev, "nand_scan_tail for NAND failed\n");
+		return -ENXIO;
+	}
+
+	mtd_device_register(mtd, NULL, 0);
+
+	return 0;
+}
+
+/**
+ * pl353_nand_remove - Remove method for the NAND driver
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * This function is called if the driver module is being unloaded. It frees all
+ * resources allocated to the device.
+ *
+ * Return:	0 on success or error value on failure
+ */
+static int pl353_nand_remove(struct platform_device *pdev)
+{
+	struct pl353_nand_info *xnand = platform_get_drvdata(pdev);
+	struct mtd_info *mtd = nand_to_mtd(&xnand->chip);
+
+	/* Release resources, unregister device */
+	nand_release(mtd);
+
+	return 0;
+}
+
+/* Match table for device tree binding */
+static const struct of_device_id pl353_nand_of_match[] = {
+	{ .compatible = "arm,pl353-nand-r2p1" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
+
+/*
+ * pl353_nand_driver - This structure defines the NAND subsystem platform driver
+ */
+static struct platform_driver pl353_nand_driver = {
+	.probe		= pl353_nand_probe,
+	.remove		= pl353_nand_remove,
+	.driver		= {
+		.name	= PL353_NAND_DRIVER_NAME,
+		.of_match_table = pl353_nand_of_match,
+	},
+};
+
+module_platform_driver(pl353_nand_driver);
+
+MODULE_AUTHOR("Xilinx, Inc.");
+MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
+MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
