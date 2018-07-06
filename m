Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F6C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A966223FF6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A966223FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeGFI3l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:29:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932174AbeGFI33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:29:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w668SvgB119285
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 04:29:28 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k245wa01q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 04:29:28 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 6 Jul 2018 04:29:27 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 04:29:25 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w668TOaD6292158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 08:29:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DFBF112063;
        Fri,  6 Jul 2018 04:29:16 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A227C112061;
        Fri,  6 Jul 2018 04:29:14 -0400 (EDT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.51])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 04:29:14 -0400 (EDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>,
        Oliver <oohall@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 2/2] mm/pmem: Add memblock based e820 platform driver
Date:   Fri,  6 Jul 2018 13:59:11 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
References: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070608-0040-0000-0000-0000044AECCC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009318; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057295; UDB=6.00542444; IPR=6.00835216;
 MB=3.00022021; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-06 08:29:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070608-0041-0000-0000-000008510C4E
Message-Id: <20180706082911.13405-2-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch steal system RAM and use that to emulate pmem device using the
e820 platform driver.

This adds a new kernel command line 'pmemmap' which takes the format <size[KMG]>
to allocate memory early in the boot. This memory is later registered as
persistent memory range.

Based on original patch from Oliver OHalloran <oliveroh@au1.ibm.com>

Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/Kconfig        |  13 ++++
 drivers/nvdimm/Makefile       |   1 +
 drivers/nvdimm/memblockpmem.c | 115 ++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/nvdimm/memblockpmem.c

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 50d2a33de441..cbbbcbd4506b 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -115,4 +115,17 @@ config OF_PMEM
 config PMEM_PLATFORM_DEVICE
        bool
 
+config MEMBLOCK_PMEM
+	bool "pmemmap= parameter support"
+	default y
+	depends on HAVE_MEMBLOCK
+	select PMEM_PLATFORM_DEVICE
+	help
+	  Add support for the pmemmap= kernel command line parameter. This is similar
+	  to the memmap= parameter available on ACPI platforms, but it uses generic
+	  kernel facilities (the memblock allocator) to reserve memory rather than adding
+	  to the e820 table.
+
+	  Select Y if unsure.
+
 endif
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 94f7f29146ce..0215ce0182e9 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ND_BTT) += nd_btt.o
 obj-$(CONFIG_ND_BLK) += nd_blk.o
 obj-$(CONFIG_PMEM_PLATFORM_DEVICE) += nd_e820.o
 obj-$(CONFIG_OF_PMEM) += of_pmem.o
+obj-$(CONFIG_MEMBLOCK_PMEM) += memblockpmem.o
 
 nd_pmem-y := pmem.o
 
diff --git a/drivers/nvdimm/memblockpmem.c b/drivers/nvdimm/memblockpmem.c
new file mode 100644
index 000000000000..d39772b75fcd
--- /dev/null
+++ b/drivers/nvdimm/memblockpmem.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2018 IBM Corporation
+ */
+
+#define pr_fmt(fmt) "memblock pmem: " fmt
+
+#include <linux/libnvdimm.h>
+#include <linux/bootmem.h>
+#include <linux/memblock.h>
+#include <linux/mmzone.h>
+#include <linux/cpu.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+
+/*
+ * Align pmem reservations to the section size so we don't have issues with
+ * memory hotplug
+ */
+#ifdef CONFIG_SPARSEMEM
+#define BOOTPMEM_ALIGN (1UL << SECTION_SIZE_BITS)
+#else
+#define BOOTPMEM_ALIGN PFN_DEFAULT_ALIGNMENT
+#endif
+
+static __initdata u64 pmem_size;
+static __initdata phys_addr_t pmem_stolen_memory;
+
+static void alloc_pmem_from_memblock(void)
+{
+
+	pmem_stolen_memory = memblock_alloc_base(pmem_size,
+						 BOOTPMEM_ALIGN,
+						 MEMBLOCK_ALLOC_ACCESSIBLE);
+	if (!pmem_stolen_memory) {
+		pr_err("Failed to allocate memory for PMEM from memblock\n");
+		return;
+	}
+
+	/*
+	 * Remove from the memblock reserved range
+	 */
+	memblock_free(pmem_stolen_memory, pmem_size);
+
+	/*
+	 * Remove from the memblock memory range.
+	 */
+	memblock_remove(pmem_stolen_memory, pmem_size);
+	pr_info("Allocated %ld memory at 0x%lx\n", (unsigned long)pmem_size,
+		(unsigned long)pmem_stolen_memory);
+	return;
+}
+
+/*
+ * pmemmap=ss[KMG]
+ *
+ * This is similar to the memremap=offset[KMG]!size[KMG] paramater
+ * for adding a legacy pmem range to the e820 map on x86, but it's
+ * platform agnostic.
+ *
+ * e.g. pmemmap=16G allocates 16G pmem region
+ */
+static int __init parse_pmemmap(char *p)
+{
+	char *old_p = p;
+
+	if (!p)
+		return -EINVAL;
+
+	pmem_size = memparse(p, &p);
+	if (p == old_p)
+		return -EINVAL;
+
+	alloc_pmem_from_memblock();
+	return 0;
+}
+early_param("pmemmap", parse_pmemmap);
+
+static __init int register_e820_pmem(void)
+{
+	struct resource *res, *conflict;
+        struct platform_device *pdev;
+
+	if (!pmem_stolen_memory)
+		return 0;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -1;
+
+	memset(res, 0, sizeof(*res));
+	res->start = pmem_stolen_memory;
+	res->end = pmem_stolen_memory + pmem_size - 1;
+	res->name = "Persistent Memory (legacy)";
+	res->desc = IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	res->flags = IORESOURCE_MEM;
+
+	conflict = insert_resource_conflict(&iomem_resource, res);
+	if (conflict) {
+		pr_err("%pR conflicts, try insert below %pR\n", res, conflict);
+		kfree(res);
+		return -1;
+	}
+	/*
+	 * See drivers/nvdimm/e820.c for the implementation, this is
+	 * simply here to trigger the module to load on demand.
+	 */
+	pdev = platform_device_alloc("e820_pmem", -1);
+
+	return platform_device_add(pdev);
+}
+device_initcall(register_e820_pmem);
-- 
2.17.1

