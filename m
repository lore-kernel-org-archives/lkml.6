Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB5DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F4D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 03:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=opengear.com header.i=@opengear.com header.b="Ff6MkHU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F4D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opengear.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJKLSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:18:12 -0400
Received: from mail-eopbgr710088.outbound.protection.outlook.com ([40.107.71.88]:12352
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbeJKLSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73rWjMJucnKIylu9X02BC9mMLTi3Ip9ugYCkODTgkM0=;
 b=Ff6MkHU6+W1p/yd/C9TKB6lUUPWvAthn+NVqRt69lqJKEc8pHdxQM39Ckywlh5EKUl1nuTCjX+jQZ7eh5svKfkaBl9tfZyaeDfxsIb/XZMk9U+Aj8bpfcymLTrqE7MjINDKDiNh2ELRwMs7O6FNOjq/Hd7oB0/L1icDuU3m5aNU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brett.grandbois@opengear.com; 
Received: from opengear.com (59.167.150.161) by
 DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a2::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Thu, 11 Oct 2018 03:52:46 +0000
From:   Brett Grandbois <brett.grandbois@opengear.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Add support for SPI boot flash access for AMD Family 16h
Date:   Thu, 11 Oct 2018 13:52:05 +1000
Message-Id: <20181011035220.22343-1-brett.grandbois@opengear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME2PR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:201:2e::24) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a2::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03cfcecc-1e34-4d0c-87c7-08d62f2d032e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR1501MB2055;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB2055;3:0Ht4sO7nzP6FkGQ0+mNlFc9Sd/TTfCYauDrNP1iDlifv+dVq+dmvLydIiYHqhLqbnRuzJi4e0WTOZ3jFfm/W4OSSktV87u7ubrKsEebSNZiFelF2H5IWyUVm5GpXzyhwZYh/HmxBqHs4p+sQULKC8EoIYUpga/8TUQqO+oetltXGX+OhG/8/deM39QD2AR1noXNMtRldqQM1sPQaEDCdwzuQp5dY/zR8TZonz8P8fUsQnIn4EH4Uk69jyyR0W/n4;25:QLD7Dybmo5H96OkeDzL89kpk9qzfQD4RoSK0WpN/FAbZIMS2gOCDdGveGi6UhMjrfbTEK/+RqrFzMzIwTAj94wR1biXyA8ULO10OFIQcl780zt8hjr09T8fJZPcHEpvIapSr7tMmrsUavL1CiSSbZe2ZpasWbq5j1DarjUJmi2dNU1bA7MUqAF33CFVEIi9wvJc85M4QP8eIuPSu1O3qugE3Zbtk70IioHLSJ/7BEPUuIrIrAaUiVEL7NjHuscsSl2PxBn31mgbZ5CmgeOG53/oV+NMEOZI95GpxE+QqdfJxugR6S3RyDg5EzOkYwQpROQy7T9RApzVJfo09pXFA4g==;31:Bs8XPQl+X6c6t4i7kNtmM6q59wGYzNTsS8oIBctCfI52/KyEuD97ExtfYG9ymtwy8KukaXvk985mcVhWZB+1YGClx7W5U+bZnQ7hpHxsH+lIt17RM9DEXIdFKS22OUcHWpp/YkDGcSu6v986XzES16DmK/lOi8JqmzOXFsAEt4I1aCn1fPXCNtJxp4rhhGodrDWQOSeSt/vhttVfJQ+wg8hCp+5VGU3AxDUO5Xu2QYg=
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB2055;20:/D71AOACe+8uBte7gHnptwN5b1jCZ6pEGaCBVKdAFAXykPhMoG23/ZThEVHTlJljVsawdRgp+3w5prvQCLCSeacBw7J+FQZnODMvHGQ2v3p7aP8MfHv9p4rDey2wp6CTkNtfTKmWIdWiyYjMTBzpF2uDQkg6Q1EXc8cMXVpqOv4=;4:NC6X2etZoNlBzWYHx3HxoHUetDMad2sW+cjkA183rRtXPtTXEORF+rN4KlMUlq1fKa9ioYXGrSPWUkyVfqNwODPTd+28gBgJ6mCyVAxOH09MbuuxBK68mUc89vJdINadcxnAIgL/9Fu35SCQvZCoTsTf5IPwmu40TIUPlQtO9BMRO0z51n3snWhkSR5I5ExTrvHD8UYa89f0ozBAgwPXsA6pig8iYCzsGccI0gboe400NfndGFUIYBk59X0Q84h5m9B9ve4VdGKX8rMrb4y/EZPR7LEXBi3GfmxXKuLXmqFof5WtMjNMwec3Yo+Un9Hp9Cn/Toc+RKn1T+LJIHtOngkkn4Co7Qt82gXIiVxoyXA=
X-Microsoft-Antispam-PRVS: <DM5PR1501MB2055E8FF47326B7B1FB5F4F582E10@DM5PR1501MB2055.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658)(60795455431006);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR1501MB2055;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1501MB2055;
X-Forefront-PRVS: 08220FA8D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39840400004)(396003)(376002)(136003)(199004)(57704003)(43544003)(189003)(2616005)(6116002)(51416003)(7736002)(14444005)(33026002)(50466002)(36756003)(44832011)(39060400002)(305945005)(1076002)(3846002)(486006)(476003)(53936002)(478600001)(6666004)(48376002)(68736007)(1857600001)(52116002)(97736004)(55016002)(956004)(25786009)(7696005)(110136005)(8936002)(8676002)(81166006)(47776003)(81156014)(4744004)(66066001)(5660300001)(106356001)(186003)(4326008)(386003)(105586002)(16586007)(86362001)(316002)(50226002)(2906002)(8886007)(575784001)(26005)(21086003)(16526019)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1501MB2055;H:opengear.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: opengear.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR1501MB2055;23:IwVGrOsaz61anAiEmv1S57R1FzE7VJneRR7YV7t?=
 =?us-ascii?Q?5iPSm3L5pEdcQHKT4yGqteD1FlcBuHJWNvvI2seP29LiVjxWpeU+XyW3eboG?=
 =?us-ascii?Q?K/lHMNEwdmnVwBAbDFzWz5PWzBImWlc2iIlTeWpmlcgcb/M93tH8T2+h9iWh?=
 =?us-ascii?Q?W6keI6rWAnTwynHhtT/Pog8Ab3FRjWw98oF/KVdSX3rsEiINpwyHk2mTFld0?=
 =?us-ascii?Q?qLZrX10OO252lNzS/Vch6gyr+RdVF7FFwkcjDhjuAC8rnw95+L8Mw3zJClsA?=
 =?us-ascii?Q?lEWaRTl6KbsF8zj6TzVrtPXDFJXqDcaS8/9DlvxQw5yWiHSJNy2lqKTarubc?=
 =?us-ascii?Q?ldNHGcVB6HMU2/x0hRCHH3kzTA9rFKbILJluRzBvwZTvCmafYTiUdzNROkVs?=
 =?us-ascii?Q?B0x5sszKdSNIoQZF9pBjO4AChl4ecGBSft8Ty5MXPH956j1nnPaJeTuMfTjS?=
 =?us-ascii?Q?m+FT2C+0ZUK/epDhrqhkywyawHS1+DC2IKy3BpbhKjfX2aq2EmFWmm2HfBsL?=
 =?us-ascii?Q?M7j2/npwUfbUbHEHaw56mnWFULCAj/warMefy3lXvQIayXHnL4ZNW3nUkCDJ?=
 =?us-ascii?Q?EXg/svNdNIdZO+CpSQiEiH7vc9NTrG2ml5j6lUCq9Mghs/zsFQs0bDUTSg9B?=
 =?us-ascii?Q?q3gUfcvc7OhrHvUTZdsOFBZFYXvibiLc9egVmQpS1OqGzTElL0e1yN9Yl8vi?=
 =?us-ascii?Q?jmIBGYq1ZsVGR/rOZ8+eHfXpTk8Y7D0nHr21ctQ2o9FQf51rGnOcbN/DTS4e?=
 =?us-ascii?Q?D362W462XrNzWyqJ+aoE/Sfms6/IewZRvBJ0nylfNmKAvrfH3rBUOyh+yNA2?=
 =?us-ascii?Q?eUR0qYsg1pnevkAC8+1vrW4VC1Um8wQmMpLfz4ECVaOcU3uLL8udMDenEkZ2?=
 =?us-ascii?Q?kpi5Bx5uHmdeA7ITGT2cydu9slICrIcb+9c3pjQ8S3zzUQBposD8XBxjpSJP?=
 =?us-ascii?Q?HLb5B+bMzBIsptTT9IO3Xv6Ku5KNtCcKpsw7CEA94fzka4LAsFad3sw8wYEG?=
 =?us-ascii?Q?I6+inE/MOU4ShYV2Y6QHuASOdBzn6BJNnYo8Jkjx8QnRtRQ/D9xqgMpDDpdH?=
 =?us-ascii?Q?OIpReYblTGR95OrWbKVl1Psva3nf5uYa9Y3/WkQB+U9wIm+0qrQQn/DdGoC0?=
 =?us-ascii?Q?WaG6BkhISXz4G19Bqp8wclf8Wunk0UF6ZShsyp6LRvv7RhikmB5j+NYREX1l?=
 =?us-ascii?Q?vRjqX2OYYQg7+PYNvS8MVtKdTHn047tzW/aedrhtkXsopc+2dqPrtDcxfq90?=
 =?us-ascii?Q?hRMlSISA3dJSqXA38gdhka/k7F/BqRTORWX9SbjtmAO3LtJtM2VH3shuQChu?=
 =?us-ascii?Q?6ig57/0zRIkcmlCR2ywtmUbnX21s6k22BcjIJhKFwOsq63os0TZWMHN5tyvp?=
 =?us-ascii?Q?HK2XdAxOjlrg0ElHfeSGYCnJOx+U=3D?=
X-Microsoft-Antispam-Message-Info: s5IERk2O9ZkakMPLroIyUmH+e3YmHP5JGiXWjG9X9LFsjo8AH43XCWfF8uZBDdtnVH/NrnciWecxwtd0lD0n6uzel6U7i9n4vGEU8OCqMhfyhSn191iCecRVPHlYcr8DCa7oNFvFMqDWpmNGrzG6IEwI9utqo6NSzrCdYLiy3SJCYAkXVz878IKtvVf0FVJ0E8GvxR4b5xCJjgTYgZUxVOUGjMXHM2lUKUdxo9jRjxMIJSllgzKvvrifAEfE0gSHbZLuq3lVhY0hv0WvOhU3ME/+Tg1nhEqNdL6Hy9i2EFTt2JnIeY7TgX/988YgFj8XbHrobvyNQ3E26fHm1pHn1mavkFF9DwSukLdVOZyZHAo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB2055;6:z9qgq9e/VvYE3/bNZpaxL2uptBanqPp2w8j9ZHdmaf0NMYqq2mOa8RDaNYu8drv5eDQKzSbmfkdYBhCFrbWTWNBqXcMlg7D8WiT8pWLS4ul2GeWnw1r7xEgoAREfBpOT7MEAdrN68jyj3Pt/xm4gbU3CvASgompXzwMpLDcmuKFmXuDBUsMK/6vkc1qr+9/0SHJKBHXqna/AMs9cONL0xktI9oikjJaDEsTtzXT7GCNUnT54n4TCPj74YhMt8+6hoDZ6mNEgxVeHuhWnKHF0pv99f/93i1SUAAJOTysDpv2Azd2+WM5Dz2xuN9HSkjW2/pjUUn9DP19IWdnRacGgTq7cHlI//I+A2EYm0xTvsKFjIOF7D5XuccBsNWMqXBHjEd8eAwzyDe5I35RjQUIaRjoa0Eup0QOUOmn+6+TW5xuXRqWTShV1LhEAxjKtiVsduvoQkYEbB7Pv7Qhj9+7GMQ==;5:gJmKSkt5FkEFQ5UyqTr/LhfD2kaoKQ0y/a/qw2q3H95fH8sfUNWDIti/P4I78S4K3EL6xbcqM1/KjKw+MOzPkoYzPUxqOAEEkiq5SB1OdHt/4jLORnXOX+RaC2eMvQ5nHiM26bB4XcyGJExa0oP2KqgnJnOJRU3wvO2Yq/hKFdA=;7:j0mtkVCeaElxgHLgY+P11VjEg2Hh/nS8+1ZaZODYqhq66wU8gTvy0Que2q0e1B0FO4yRklq3tv+qt0FBuKM/svu1zocnd2Q/xvR3I+v3lIZWYok1yUq3wukUwcDJOUxl72hKOv7ww+L8Z9mjKU7VcTS9BSlrI30c606xwBvo+oeL9kTzc5Viv++r71yiqEp0bGkHV47FRYyHr7GVx2CIaxj6JkjCl7ILDpFZ1/13lKIrQudN8uWlX+YMasMDiE9E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 03:52:46.7110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cfcecc-1e34-4d0c-87c7-08d62f2d032e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to expose the SPI boot flash on AMD Family 16h CPUs as a
standard mtd device to give userspace BIOS updaters greater feature
support.  The BIOS and Kernel Developer's Guide refers to this as the
'SPI ROM' controller and so the driver follows that naming convention
for consistency.

Signed-off-by: Brett Grandbois <brett.grandbois@opengear.com>
---
 drivers/mtd/spi-nor/Kconfig      |  15 +
 drivers/mtd/spi-nor/Makefile     |   1 +
 drivers/mtd/spi-nor/amd-spirom.c | 805 +++++++++++++++++++++++++++++++
 3 files changed, 821 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/amd-spirom.c

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c929ff57..f99b40ec0fef 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -129,4 +129,19 @@ config SPI_STM32_QUADSPI
 	  This enables support for the STM32 Quad SPI controller.
 	  We only connect the NOR to this controller.
 
+config SPI_AMD_SPIROM
+	tristate "AMD Hudson FCH SPI flash drvier (DANGEROUS)"
+	depends on X86 && PCI
+	help
+	  This enables support for the AMD Family 16h SPI flash controller to
+	  access the boot flash from Linux as an mtd device.
+
+	  Using this driver it is possible to upgrade BIOS directly from Linux.
+
+	  Say N here unless you know what you are doing. Overwriting the
+	  SPI flash may render the system unbootable.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called amd-spirom.
+
 endif # MTD_SPI_NOR
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index f4c61d282abd..e49ea4e619c1 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
 obj-$(CONFIG_SPI_INTEL_SPI_PCI)	+= intel-spi-pci.o
 obj-$(CONFIG_SPI_INTEL_SPI_PLATFORM)	+= intel-spi-platform.o
 obj-$(CONFIG_SPI_STM32_QUADSPI)	+= stm32-quadspi.o
+obj-$(CONFIG_SPI_AMD_SPIROM)	+= amd-spirom.o
diff --git a/drivers/mtd/spi-nor/amd-spirom.c b/drivers/mtd/spi-nor/amd-spirom.c
new file mode 100644
index 000000000000..514e67edc9cd
--- /dev/null
+++ b/drivers/mtd/spi-nor/amd-spirom.c
@@ -0,0 +1,805 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018, Opengear
+ *
+ * AMD Family 16h Hudson FCH SPI flash driver.
+ *
+ * When the FCH is strapped to SPI boot ROM mode 'SPIROM'
+ * the FCH will do a flash auto-probe and self-configure
+ * for read operations to the ROM address range(s).
+ * For any command outside of read/write (chip erase, etc)
+ * you need to go through the alternate program method.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/iopoll.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/spi-nor.h>
+
+/* FCH Device LPC Bridge Configuration Registers */
+#define PCI_DEVICE_ID_AMD_FCH_LPC_BRIDGE	0x780E
+
+#define FCH_PCI_CONTROL				0x40
+#define FCH_INTEGRATED_EC_PRESENT		0x80
+#define FCH_EC_SEM				0x40
+#define FCH_BIOS_SEM				0x20
+#define FCH_LEGACY_DMA				0x04
+
+#define FCH_ROM_ADDR_RANGE_2			0x6C
+
+#define FCH_SPI_BASE_ADDR			0xA0
+#define FCH_SPI_BASE_ADDR_MASK			0xFFFFFFC0
+#define FCH_SPI_ROUTE_TPM_SPI			0x08
+#define FCH_SPI_ROM_ENABLE			0x02
+
+/* up through FIFO [C6:80] */
+#define SPI_IO_REGION_LEN			256
+
+/* SPI Registers, the labels come from the BKDG */
+#define SPI_CNTRL0				0x00
+#define SPI_CNTRL0_FIFO_PTR_CLEAR		0x00100000
+#define SPI_CNTRL0_FIFO_PTR_CLEAR_MASK		0xFFEFFFFF
+#define SPI_CNTRL0_SPI_ARB_ENABLE		0x00080000
+#define SPI_CNTRL0_SPI_ARB_ENABLE_MASK		0xFFF7FFFF
+
+#define ALT_SPI_CS				0x1D
+#define ALT_SPI_CS_MASK				0xFC
+#define ALT_SPI_CS_WR_BUF_EN			0x04
+
+#define SPI100_ENABLE				0x20
+#define SPI100_SPEED_CONFIG			0x22
+
+
+/* SPI control shadow registers */
+#define CMD_CODE				0x45
+
+#define CMD_TRIGGER				0x47
+#define CMD_TRIGGER_EXECUTE			0x80
+
+#define TX_BYTE_COUNT				0x48
+
+#define RX_BYTE_COUNT				0x4B
+
+#define SPI_STATUS				0x4C
+#define SPI_STATUS_BUSY_MASK			0x80000000
+
+#define SPI_FIFO				0x80
+
+static const struct pci_device_id amd_fch_lpc_pci_device_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FCH_LPC_BRIDGE) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, amd_fch_lpc_pci_device_ids);
+
+static short norm_speed = -1;
+module_param(norm_speed, short, 0444);
+MODULE_PARM_DESC(norm_speed, "Specify SPI speed for normal read.  This sets NormSpeedNew[3:0] from BKDG. -1 means use existing (defaut).");
+
+static short fast_speed = -1;
+module_param(fast_speed, short, 0444);
+MODULE_PARM_DESC(fast_speed, "Specify SPI speed for fast/dual/quad read.  This sets FastSpeedNew[3:0] from BKDG. -1 means use existing (defaut).");
+
+static short alt_speed = -1;
+module_param(alt_speed, short, 0444);
+MODULE_PARM_DESC(alt_speed, "Specify alternate command SPI speed.  This sets AltSpeedNew[3:0] from BKDG. -1 means use existing (defaut).");
+
+static int read_mode = -1;
+module_param(read_mode, int, 0444);
+MODULE_PARM_DESC(read_mode, "Specify SPI read settings.  This sets SpiReadMode[2:0] from BKDG. -1 means use existing (defaut).");
+
+static char *flash_name;
+module_param(flash_name, charp, 0444);
+MODULE_PARM_DESC(flash_name, "Specify flash type name to spi_nor_scan(). Default (null) is auto-probe from JEDEC ID.");
+
+static short chip_select = -1;
+module_param(chip_select, short, 0444);
+MODULE_PARM_DESC(chip_select, "Specify the alternate SPI CS# [0-3]. -1 means use existing (defaut).");
+
+static char *part_name = "BIOS";
+module_param(part_name, charp, 0444);
+MODULE_PARM_DESC(part_name, "MTD partition label for SPIROM region.");
+
+static short write_buffer_enable = -1;
+module_param(write_buffer_enable, short, 0444);
+MODULE_PARM_DESC(write_buffer_enable, "Enable write buffer.  This sets WriteBufferEn from BKDG.  0 means disable, >0 means enable, <0 means use existing (default)");
+
+static short mac_arb_enable = -1;
+module_param(mac_arb_enable, short, 0444);
+MODULE_PARM_DESC(write_buffer_enable, "Enable MAC arbitration.  This sets SpiArbEnable from BKDG.  0 means disable, >0 means enable, <0 means use existing (default)");
+
+
+static bool accelerated_rd = true;
+module_param(accelerated_rd, bool, 0444);
+MODULE_PARM_DESC(hw_write, "Have read requests go via flash MMIO address space. This is a performance enhancement.");
+
+/*
+ * The SPIROM interface only supports 1 flash chip so that's all the driver
+ * supports.  Theoretically you could access up to 3 others via alt command
+ * and SPI_ALT_CS but that's a future expansion and likely not ever to be
+ * actually needed.
+ */
+struct amd_spirom {
+	void __iomem *spi;
+	void __iomem *rom;
+	struct spi_nor nor;
+	/*
+	 * pre-calculated delays for reg_xfer (up to 8 bytes data + opcode)
+	 * note that the delay includes the opcode byte and the value is double
+	 * because reg_xfer is using poll_timeout which actually quarters the
+	 * value for usleep_range.
+	 */
+	u32 reg_delay_us[9];
+	u16 spi_alt_speed;
+	bool mtd_registered;
+};
+
+/* note we're assuming no dual/quad here */
+static u32 amd_spirom_get_usecs_per_bytes(u16 speed_config, u32 bytes)
+{
+	static const u32 hz[6] = {	(u32)(6666 * 1000),
+					(u32)(3333 * 1000),
+					(u32)(2222 * 1000),
+					(u32)(1666 * 1000),
+					(u32)(100000 * 1000),
+					(u32)(800 * 1000) };
+
+	return mult_frac(bytes * 8, USEC_PER_SEC, hz[speed_config]);
+}
+
+static int amd_spirom_reg_xfer(struct amd_spirom *spirom, u8 opcode,
+				u8 rx_len, u8 tx_len, u8 *rx_buf, u8 *tx_buf)
+{
+	u32 delay_us;
+	u32 total_len;
+	u32 cntrl0;
+	u8 sts;
+	int rc;
+	uint i;
+
+	total_len = tx_len + rx_len + 1;
+
+	/* transfer FIFO is actually 70 bytes long so that's the hard limit */
+
+	/*
+	 * no irq here so just need to wait
+	 *
+	 * poll_timeout will actually quarter the delay so we'll double the
+	 * expected range and should then hit on the second or third iteration
+	 *
+	 * for reg_read/write transactions we can use the pre-calculated value
+	 *
+	 * Note we need to +1 for the opcode.
+	 */
+
+
+	if (total_len <= 9)
+		delay_us = spirom->reg_delay_us[total_len - 1];
+	else if (total_len <= 71)
+		delay_us = amd_spirom_get_usecs_per_bytes(spirom->spi_alt_speed,
+							  total_len << 1);
+	else
+		return -EINVAL;
+
+
+	iowrite8(opcode, spirom->spi + CMD_CODE);
+
+	iowrite8(tx_len, spirom->spi + TX_BYTE_COUNT);
+	iowrite8(rx_len, spirom->spi + RX_BYTE_COUNT);
+
+	/* reset the transfer fifo */
+	cntrl0 = ioread32(spirom->spi + SPI_CNTRL0);
+	cntrl0 &= SPI_CNTRL0_FIFO_PTR_CLEAR_MASK;
+	cntrl0 |= SPI_CNTRL0_FIFO_PTR_CLEAR;
+	iowrite32(cntrl0, spirom->spi + SPI_CNTRL0);
+
+	/* fill the FIFO */
+	for (i = 0; i < (uint)tx_len; i++)
+		iowrite8(tx_buf[i], spirom->spi + SPI_FIFO + i);
+
+	/* release the hounds... */
+	iowrite8(CMD_TRIGGER_EXECUTE, spirom->spi + CMD_TRIGGER);
+
+	rc = readb_poll_timeout(spirom->spi + SPI_STATUS, sts,
+				!(sts & SPI_STATUS_BUSY_MASK),
+				delay_us, 4 * delay_us);
+
+	if (!rc) {
+		/* drain the FIFO */
+		for (i = 0; i < (uint)rx_len; i++)
+			rx_buf[i] = ioread8(spirom->spi + SPI_FIFO + tx_len + i);
+	}
+
+	return rc;
+}
+
+static int amd_spirom_prepare(struct spi_nor *nor, enum spi_nor_ops ops)
+{
+	/* get the semaphore */
+	struct pci_dev *pcidev = to_pci_dev(nor->dev);
+	u32 pci_control;
+	int rc = -ETIMEDOUT;
+	int count;
+
+	/*
+	 * procedure from BKDG is to wait for EC_SEM to be 0, then write 1 to
+	 * BIOS_SEM, then read back to verify the 1 has been set by HW to grant
+	 * ownership
+	 *
+	 * this is only necessary when the IMC is active
+	 */
+	for (count = 0; count < 100 && rc; count++) {
+		pci_read_config_dword(pcidev, FCH_PCI_CONTROL, &pci_control);
+		if (pci_control & FCH_EC_SEM)
+			msleep(50);
+		else {
+			if (pci_control & FCH_BIOS_SEM)
+				rc = 0;
+			else
+				pci_write_config_dword(pcidev, FCH_PCI_CONTROL,
+						       pci_control | FCH_BIOS_SEM);
+		}
+	}
+
+	return rc;
+}
+
+static void amd_spirom_unprepare(struct spi_nor *nor, enum spi_nor_ops ops)
+{
+	/* we assume we own the semaphore at this point */
+	struct pci_dev *pcidev = to_pci_dev(nor->dev);
+	u32 pci_control;
+
+	pci_read_config_dword(pcidev, FCH_PCI_CONTROL, &pci_control);
+
+	pci_control &= FCH_LEGACY_DMA;
+
+	pci_write_config_dword(pcidev, FCH_PCI_CONTROL, pci_control);
+}
+
+static int amd_spirom_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
+{
+	struct amd_spirom *spirom = nor->priv;
+	int rc;
+
+	dev_dbg(nor->dev, "read_reg: op: 0x%02x  len: %d\n", opcode, len);
+
+	rc = amd_spirom_reg_xfer(spirom, opcode, len, 0, buf, NULL);
+	if (!rc)
+		dev_dbg(nor->dev, "read_reg: %*ph\n", len, buf);
+	else
+		dev_dbg(nor->dev, "read_reg: failed: %d\n", rc);
+
+	return rc;
+}
+
+static int amd_spirom_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
+{
+	struct amd_spirom *spirom = nor->priv;
+	int rc;
+
+	dev_dbg(nor->dev, "write_reg: op: 0x%02x  len: %d  data: %*ph\n",
+		opcode, len, len, buf);
+
+	rc = amd_spirom_reg_xfer(spirom, opcode, 0, len, NULL, buf);
+
+	if (rc)
+		dev_dbg(nor->dev, "write_reg: failed: %d\n", rc);
+
+	return rc;
+}
+
+/*
+ * fallback read op based on explicit read command
+ * ideally the HW io will be used but this needs to be available if it's not
+ * strapped, can't get the resources, etc.
+ * spi_nor_read() will loop on the actual bytes read so we can just limit
+ * ourselves to the 64-byte FIFO size.
+ */
+static ssize_t amd_spirom_read(struct spi_nor *nor, loff_t from,
+			       size_t len, u_char *read_buf)
+{
+	struct amd_spirom *spirom = nor->priv;
+	u32 *pbuf32;
+	size_t head;
+	size_t tail;
+	size_t left;
+	ssize_t rc;
+	size_t cur;
+	u8 *p_addr;
+	u8 rd_len;
+	size_t i;
+	u32 addr;
+
+	dev_dbg(nor->dev, "read: from: %lld  len: %zu\n", from, len);
+
+	/*
+	 * We only allow READ in the HWCAPS so most read operations should come
+	 * with that opcode.  However, the SPI-NOR layer can swap out the read
+	 * opcode with something else (i.e. Read SFDP) which must be handled via
+	 * alt command and not the ROM IO
+	 */
+	if (spirom->rom && (nor->read_opcode == SPINOR_OP_READ)) {
+		/*
+		 * no need for status/busy as the HW controller will deal with
+		 * that, but memcpy_fromio can make out-of-order fetches so need
+		 * to do this explicitly
+		 */
+		left = len;
+		head = from & 3;
+		left -= head;
+		tail = left & 3;
+		left -= tail;
+		cur = 0;
+
+		for (i = 0; i < head; i++, cur++)
+			read_buf[cur] = ioread8(spirom->rom + from + cur);
+
+		pbuf32 = (u32 *)(read_buf + cur);
+		left /= 4;
+
+		for (i = 0; i < left; i++, cur += 4, pbuf32++)
+			*pbuf32 = ioread32(spirom->rom + from + cur);
+
+		for (i = 0; i < tail; i++, cur++)
+			read_buf[cur] = ioread8(spirom->rom + from + cur);
+
+		rc = (ssize_t)len;
+	} else {
+
+		addr = cpu_to_be32((u32)(from));
+		p_addr = (u8 *)(&addr);
+
+		rd_len = len > 64 ? 64 : (u8)len;
+
+		if (nor->addr_width == 3)
+			p_addr++;
+
+		rc = amd_spirom_reg_xfer(spirom, nor->read_opcode, rd_len,
+					 nor->addr_width, read_buf, p_addr);
+
+		if (!rc)
+			rc = (ssize_t)rd_len;
+	}
+
+	return rc;
+}
+
+static ssize_t amd_spirom_write(struct spi_nor *nor, loff_t to,
+				size_t len, const u_char *write_buf)
+{
+	/*
+	 * spi_nor_write() will have already segmented this into pages
+	 * and we will have overridden the flash page size to 64 (or less)
+	 * for the FIFO size so just need to serialize into one byte stream
+	 * for the addr + data.
+	 * Note Page Program takes a BE address.
+	 * Supposedly the ROM IO space should be able to deal with writes but
+	 * cant get it to work in practice.
+	 */
+	struct amd_spirom *spirom = nor->priv;
+	u8 buf[4 + 64];
+	u8 *p_buf = buf;
+	u32 addr;
+	int rc;
+
+	dev_dbg(nor->dev, "write: to: %lld  len: %zu\n", to, len);
+
+	if (len > 64)
+		return -EINVAL;
+
+	addr = cpu_to_be32((u32)(to));
+
+	memcpy(buf, &addr, 4);
+
+	memcpy(&buf[4], write_buf, len);
+
+	if (nor->addr_width == 3)
+		p_buf++;
+
+	rc = amd_spirom_reg_xfer(spirom, nor->program_opcode, 0,
+				 len + nor->addr_width, NULL, p_buf);
+
+	return !rc ? (ssize_t)len : rc;
+}
+
+static int amd_spirom_spi_init(struct device *dev, struct amd_spirom *spirom,
+			       bool imc_active)
+{
+	struct spi_nor_hwcaps hwcaps;
+	bool update_speed_config = false;
+	u32 spi_read_mode;
+	u32 spi_cntrl0;
+	u16 speed_config;
+	u8 cs_val;
+	int i;
+
+	/*
+	 * Speed and Mode and CS settings should be configured by BIOS
+	 * but can be overridden by module param.
+	 */
+
+	cs_val = ioread8(spirom->spi + ALT_SPI_CS);
+	if (chip_select >= 0) {
+		if (chip_select < 4) {
+			iowrite8((cs_val & ALT_SPI_CS_MASK) | (u8)(chip_select),
+				 spirom->spi + ALT_SPI_CS);
+
+			dev_info(dev, "updated CS from: %d to: %d\n",
+				cs_val & 0xF, chip_select);
+
+		} else
+			dev_err(dev, "invalid chip_select value: %d\n",
+				chip_select);
+	} else
+		chip_select = (short)(cs_val & 0x3);
+
+	if (write_buffer_enable >= 0) {
+		cs_val = ioread8(spirom->spi + ALT_SPI_CS);
+		if (write_buffer_enable) {
+			iowrite8(cs_val | ALT_SPI_CS_WR_BUF_EN,
+				 spirom->spi + ALT_SPI_CS);
+			dev_info(dev, "enabled write buffer\n");
+		} else {
+			iowrite8(cs_val & ~ALT_SPI_CS_WR_BUF_EN,
+				 spirom->spi + ALT_SPI_CS);
+			dev_info(dev, "disabled write buffer\n");
+		}
+	} else
+		write_buffer_enable = (cs_val & ALT_SPI_CS_WR_BUF_EN) >> 2;
+
+	speed_config = ioread16(spirom->spi + SPI100_SPEED_CONFIG);
+	dev_info(dev, "SPI100 speed config: 0x%04x\n", speed_config);
+
+	if (alt_speed >= 0) {
+		if (alt_speed < 6) {
+			speed_config &= 0xFF0F;
+			speed_config |= alt_speed << 4;
+			update_speed_config = true;
+		} else
+			dev_err(dev, "invalid alt_speed value: %d\n",
+				alt_speed);
+	}
+
+	if (norm_speed >= 0) {
+		if (norm_speed < 6) {
+			speed_config &= 0x0FFF;
+			speed_config |= norm_speed << 12;
+			update_speed_config = true;
+		} else
+			dev_err(dev, "invalid norm_speed value: %d\n",
+				norm_speed);
+	}
+
+	if (fast_speed >= 0) {
+		if (fast_speed < 6) {
+			speed_config &= 0xF0FF;
+			speed_config |= fast_speed << 8;
+			update_speed_config = true;
+		} else
+			dev_err(dev, "invalid fast_speed value: %d\n",
+				fast_speed);
+	}
+
+	if (update_speed_config) {
+		dev_info(dev, "updated SPI100 speed config: 0x%04x\n",
+			 speed_config);
+		/* do we need to enable 100 mode? */
+		for (i = 0; i < 4; i++) {
+			if (((speed_config >> i) & 0xF) == 4) {
+				iowrite8(1, spirom->spi + SPI100_ENABLE);
+				dev_info(dev, "SPI100 enabled\n");
+				break;
+			}
+		}
+		iowrite16(speed_config, spirom->spi + SPI100_SPEED_CONFIG);
+	}
+
+	/* AltSpeed is [7:4] */
+	spirom->spi_alt_speed = (speed_config >> 4) & 0xF;
+
+	/* which mode are we in, and therefore which reg to read? */
+	spi_cntrl0 = ioread32(spirom->spi + SPI_CNTRL0);
+	dev_info(dev, "SPI CNTRL0: 0x%08x\n", spi_cntrl0);
+
+	if (mac_arb_enable >= 0) {
+		if (mac_arb_enable) {
+			spi_cntrl0 |= SPI_CNTRL0_SPI_ARB_ENABLE;
+			dev_info(dev, "enabled MAC arbritration\n");
+		} else {
+			spi_cntrl0 &= SPI_CNTRL0_SPI_ARB_ENABLE;
+			dev_info(dev, "disabled MAC arbitration\n");
+		}
+	} else
+		mac_arb_enable = (spi_cntrl0 & SPI_CNTRL0_SPI_ARB_ENABLE) >> 19;
+	/*
+	 * this is a 3 bit mashup with bits [2:1] being [30:29]
+	 * and bit [0] being [18] in the register
+	 */
+	spi_read_mode  = (spi_cntrl0 >> 28) & 0x6;
+	spi_read_mode |= (spi_cntrl0 & BIT(18)) ? 1 : 0;
+	if (read_mode >= 0) {
+		if (read_mode < 8) {
+			spi_read_mode = read_mode;
+			spi_cntrl0 &= 0x17F80000;
+			spi_cntrl0 |= (read_mode & 0x6) << 29;
+			spi_cntrl0 |= (read_mode & 0x1) << 18;
+			iowrite32(spi_cntrl0, spirom->spi + SPI_CNTRL0);
+			dev_info(dev, "updated SPI_CNTRL0: 0x%08x\n",
+				 spi_cntrl0);
+		} else
+			dev_err(dev, "invalid read_mode value %d\n", read_mode);
+	}
+
+	/* update the params */
+	read_mode = spi_read_mode;
+	alt_speed = spirom->spi_alt_speed;
+	norm_speed = (speed_config >> 12) & 0xF;
+	fast_speed = (speed_config >> 8) & 0xF;
+
+	for (i = 0; i < 10; i++)
+		spirom->reg_delay_us[i - 1] = amd_spirom_get_usecs_per_bytes(alt_speed,
+									     i << 1);
+
+	/* as far as the spi-nor layer is concerned we can only do READ */
+	hwcaps.mask = SNOR_HWCAPS_READ | SNOR_HWCAPS_PP;
+
+	spirom->nor.dev = dev;
+	spirom->nor.priv = spirom;
+
+	spirom->nor.read_reg = amd_spirom_read_reg;
+	spirom->nor.write_reg = amd_spirom_write_reg;
+	spirom->nor.read = amd_spirom_read;
+	spirom->nor.write = amd_spirom_write;
+
+	/*
+	 * for now the un/prepare functions only deal with IMC so can global
+	 * enable/disable here.  if it turns out later we need other
+	 * functionality we'll have to filter IMC presence in the actual
+	 * routines.
+	 */
+	if (imc_active) {
+		spirom->nor.prepare = amd_spirom_prepare;
+		spirom->nor.unprepare = amd_spirom_unprepare;
+	}
+
+	return spi_nor_scan(&spirom->nor, flash_name, &hwcaps);
+}
+
+static int amd_spirom_mtd_init(struct device *dev, struct amd_spirom *spirom)
+{
+	struct mtd_partition part;
+	int rc;
+
+	/* need to define a basic partition for the region */
+
+	memset(&part, 0, sizeof(part));
+
+	/* Eventually add a CBFS region parser? */
+
+	part.name = part_name;
+	part.size = MTDPART_SIZ_FULL;
+
+	/*
+	 * need to override the flash page size to our 64-byte FIFO
+	 * limit so we can let the spi-nor layer take care of the
+	 * segmentation for us
+	 */
+	if (spirom->nor.page_size > 64) {
+		spirom->nor.page_size = 64;
+		spirom->nor.mtd.writebufsize = 64;
+	}
+
+	rc = mtd_device_parse_register(&spirom->nor.mtd, NULL, NULL, &part, 1);
+
+	if (rc)
+		dev_err(dev, "failed MTD device register: %d\n", rc);
+
+	spirom->mtd_registered = !rc;
+
+	return rc;
+}
+
+static bool amd_spirom_imc_enabled(struct pci_dev *pcidev)
+{
+	bool imc_enabled = false;
+	void __iomem *acpi_misc;
+	u32 imc_present;
+	u8 imc_active;
+
+	pci_read_config_dword(pcidev, FCH_PCI_CONTROL, &imc_present);
+	if (imc_present & FCH_INTEGRATED_EC_PRESENT) {
+		/* this is the hard-coded AcpiMmio Misc region address */
+		acpi_misc = ioremap_nocache(0xFED80E00, 256);
+		if (acpi_misc) {
+			imc_active = ioread8(acpi_misc + 0x80);
+			imc_enabled = imc_active & 0x04;
+			iounmap(acpi_misc);
+			if (imc_enabled)
+				dev_info(&pcidev->dev, "IMC is enabled\n");
+		} else {
+			dev_warn(&pcidev->dev, "failed to map AcpiMmio Misc region, assuming IMC is enabled\n");
+			imc_enabled = true;
+		}
+	}
+
+	return imc_enabled;
+}
+
+static int amd_spirom_pci_probe(struct pci_dev *pcidev,
+				const struct pci_device_id *id)
+{
+	struct cpuinfo_x86 *cpu = &boot_cpu_data;
+	struct device *dev = &pcidev->dev;
+	struct amd_spirom *spirom;
+	struct resource *res;
+	u32 spi_base_addr;
+	u32 rom_addr_range;
+	u32 rom_addr_start;
+	u32 rom_addr_end;
+	u32 rom_len;
+	bool imc_active;
+	int rc;
+
+	/*
+	 * Shouldn't get here without an AMD vendor code so ignore that,
+	 * but there are slight variations in the family/model implementations
+	 * that we need to be aware of.
+	 * Right now we only support Family 16h, all models seem to work the
+	 * same.
+	 * Is there a device/function version number somewhere?  That would be
+	 * better to switch off of but can't seem to find anything suitable in
+	 * the BKDG.
+	 */
+	if (cpu->x86 != 0x16) {
+		dev_err(dev,
+			"unsupported CPU family: 0x%02x, only support 16h\n",
+			cpu->x86);
+		return -ENODEV;
+	}
+
+	rc = pcim_enable_device(pcidev);
+	if (rc) {
+		dev_err(dev, "failed pci enable: %d\n", rc);
+		return rc;
+	}
+
+	pci_set_master(pcidev);
+
+	spirom = devm_kzalloc(dev, sizeof(*spirom), GFP_KERNEL);
+	if (!spirom) {
+		rc = -ENOMEM;
+		dev_err(dev, "failed spirom alloc\n");
+		goto err_disable;
+	}
+
+	pci_set_drvdata(pcidev, spirom);
+
+	pci_read_config_dword(pcidev, FCH_SPI_BASE_ADDR, &spi_base_addr);
+
+	dev_info(dev, "SPI base addr: 0x%08x\n", spi_base_addr);
+
+	/*
+	 * set up the SPI region
+	 * the coreboot Hudson ACPI configuration sets this as a PNP0C02 BAR0
+	 * resource, which then gets claimed by the system driver. Problem is
+	 * that there's a bug there where they use the SPI_Base_Addr field
+	 * without masking the RouteTpm2Spi and SpiRomEnable bits so the whole
+	 * region can be incorrectly offset, which can then fail the resource
+	 * requests because of the bad overlap.  There doesn't seem to be any
+	 * ideal way to fix it in an external module so if detected just warn.
+	 */
+
+	res = devm_request_mem_region(dev,
+				      spi_base_addr & FCH_SPI_BASE_ADDR_MASK,
+				      SPI_IO_REGION_LEN, "amd-spirom-spi");
+	if (!res)
+		dev_warn(dev, "cannot claim SPI region, this is likely a harmless bug in BIOS and can usually be ignored\n");
+
+	spirom->spi = devm_ioremap_nocache(dev,
+					   spi_base_addr & FCH_SPI_BASE_ADDR_MASK,
+					   SPI_IO_REGION_LEN);
+	if (!spirom->spi) {
+		rc = -ENOMEM;
+		dev_err(dev, "failed to remap SPI region\n");
+		goto err_disable;
+	}
+
+	imc_active = amd_spirom_imc_enabled(pcidev);
+
+	rc = amd_spirom_spi_init(dev, spirom, imc_active);
+	if (rc)
+		goto err_disable;
+
+	/*
+	 * look to see if we can use the HW IO support
+	 * if the SPIROM interface is strapped then HW has mapped the SPI flash
+	 * to the ROM regsions 1 and 2, which are the BIOS regions
+	 * we want to use ROM ADDR 2 as that's the 4GB - size range
+	 * but the controller assumes a 24-bit flash so only enable in that case
+	 */
+
+	if (accelerated_rd && (spirom->nor.addr_width == 3) &&
+	    (spi_base_addr & FCH_SPI_ROM_ENABLE)) {
+
+		pci_read_config_dword(pcidev, FCH_ROM_ADDR_RANGE_2,
+				      &rom_addr_range);
+
+		dev_info(dev, "ROM address range 2: 0x%08x\n", rom_addr_range);
+
+		rom_addr_start = (rom_addr_range & 0xFFFF) << 16;
+		rom_addr_end = ((rom_addr_range & 0xFFFF0000) | 0xFFFF);
+		rom_len = rom_addr_end - rom_addr_start + 1;
+
+		dev_info(dev, "ROM base: 0x%08x  ROM len: %d\n", rom_addr_start,
+			 rom_len);
+
+		/*
+		 * ok now try to request the ROM regions.
+		 * maybe do a pci_quirk with this at some point to reserve
+		 * early?
+		 */
+
+		res = devm_request_mem_region(dev, rom_addr_start, rom_len,
+						"amd-spirom-rom");
+		if (res) {
+			spirom->rom = devm_ioremap_nocache(dev, res->start,
+							   rom_len);
+			if (!spirom->rom)
+				dev_warn(dev, "failed to map ROM region, cannot accelerate read\n");
+		} else
+			dev_warn(dev, "failed to request ROM region, cannot accelerate read\n");
+	}
+
+
+	rc = amd_spirom_mtd_init(dev, spirom);
+	if (rc)
+		goto err_disable;
+
+	dev_info(dev, "enabled\n");
+
+	return 0;
+
+err_disable:
+	pci_disable_device(pcidev);
+	return rc;
+}
+
+static void amd_spirom_pci_remove(struct pci_dev *pcidev)
+{
+	struct amd_spirom *spirom = pci_get_drvdata(pcidev);
+
+	if (spirom && spirom->mtd_registered) {
+		dev_dbg(&pcidev->dev, "mtd unregister\n");
+		mtd_device_unregister(&spirom->nor.mtd);
+	}
+
+	dev_info(&pcidev->dev, "exit\n");
+
+	/* devres should clean up everything else */
+
+	pci_disable_device(pcidev);
+}
+
+static struct pci_driver amd_spirom_pci_driver = {
+	.name =	"amd-spirom",
+	.id_table = amd_fch_lpc_pci_device_ids,
+	.probe =	amd_spirom_pci_probe,
+	.remove =	amd_spirom_pci_remove,
+
+	/*
+	 * no need to worry about power ops here,
+	 * this whole interface is idle until explicit request
+	 */
+};
+
+module_pci_driver(amd_spirom_pci_driver);
+
+MODULE_DESCRIPTION("MTD SPI-NOR driver for AMD Hudson FCH SPIROM");
+MODULE_AUTHOR("Brett Grandbois <brett.grandbois@opengear.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

