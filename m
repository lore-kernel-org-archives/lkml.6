Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4291C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F189224F0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F189224F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeGDNSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:18:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753488AbeGDNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:18:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64D98gt121425
        for <linux-kernel@vger.kernel.org>; Wed, 4 Jul 2018 09:18:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k0xkvs757-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 09:18:32 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 4 Jul 2018 14:18:29 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Jul 2018 14:18:26 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w64DIPgD42401936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jul 2018 13:18:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3EBA4051;
        Wed,  4 Jul 2018 16:18:50 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE12EA404D;
        Wed,  4 Jul 2018 16:18:48 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.160])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Jul 2018 16:18:48 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Wed, 04 Jul 2018 16:18:23 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        nios2-dev@lists.rocketboards.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 3/3] nios2: switch to NO_BOOTMEM
Date:   Wed,  4 Jul 2018 16:18:15 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530710295-10774-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1530710295-10774-1-git-send-email-rppt@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070413-0012-0000-0000-00000286B2CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070413-0013-0000-0000-000020B83605
Message-Id: <1530710295-10774-4-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807040152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bootmem bitmap initialization and replace reserve_bootmem() with
memblock_reserve().

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/nios2/Kconfig        |  2 ++
 arch/nios2/kernel/prom.c  |  7 -------
 arch/nios2/kernel/setup.c | 37 +++++--------------------------------
 3 files changed, 7 insertions(+), 39 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 5db8fa1..661f7f9 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -20,6 +20,8 @@ config NIOS2
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
 	select HAVE_MEMBLOCK
+	select ARCH_DISCARD_MEMBLOCK
+	select NO_BOOTMEM
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index ba96a49..a6d4f75 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -32,13 +32,6 @@
 
 #include <asm/sections.h>
 
-int __init early_init_dt_reserve_memory_arch(phys_addr_t base, phys_addr_t size,
-					     bool nomap)
-{
-	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
-	return 0;
-}
-
 void __init early_init_devtree(void *params)
 {
 	__be32 *dtb = (u32 *)__dtb_start;
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 0946840..2d0011d 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -144,10 +144,11 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 
 void __init setup_arch(char **cmdline_p)
 {
-	int bootmap_size;
+	int dram_start;
 
 	console_verbose();
 
+	dram_start = memblock_start_of_DRAM();
 	memory_size = memblock_phys_mem_size();
 	memory_start = PAGE_ALIGN((unsigned long)__pa(_end));
 	memory_end = (unsigned long) CONFIG_NIOS2_MEM_BASE + memory_size;
@@ -165,39 +166,11 @@ void __init setup_arch(char **cmdline_p)
 	max_low_pfn = PFN_DOWN(memory_end);
 	max_mapnr = max_low_pfn;
 
-	/*
-	 * give all the memory to the bootmap allocator,  tell it to put the
-	 * boot mem_map at the start of memory
-	 */
-	pr_debug("init_bootmem_node(?,%#lx, %#x, %#lx)\n",
-		min_low_pfn, PFN_DOWN(PHYS_OFFSET), max_low_pfn);
-	bootmap_size = init_bootmem_node(NODE_DATA(0),
-					min_low_pfn, PFN_DOWN(PHYS_OFFSET),
-					max_low_pfn);
-
-	/*
-	 * free the usable memory,  we have to make sure we do not free
-	 * the bootmem bitmap so we then reserve it after freeing it :-)
-	 */
-	pr_debug("free_bootmem(%#lx, %#lx)\n",
-		memory_start, memory_end - memory_start);
-	free_bootmem(memory_start, memory_end - memory_start);
-
-	/*
-	 * Reserve the bootmem bitmap itself as well. We do this in two
-	 * steps (first step was init_bootmem()) because this catches
-	 * the (very unlikely) case of us accidentally initializing the
-	 * bootmem allocator with an invalid RAM area.
-	 *
-	 * Arguments are start, size
-	 */
-	pr_debug("reserve_bootmem(%#lx, %#x)\n", memory_start, bootmap_size);
-	reserve_bootmem(memory_start, bootmap_size, BOOTMEM_DEFAULT);
-
+	memblock_reserve(dram_start, memory_start - dram_start);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
-		reserve_bootmem(virt_to_phys((void *)initrd_start),
-				initrd_end - initrd_start, BOOTMEM_DEFAULT);
+		memblock_reserve(virt_to_phys((void *)initrd_start),
+				initrd_end - initrd_start);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-- 
2.7.4

