Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C77C217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfBRSlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:41:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbfBRSlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:41:50 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IIctQt022215
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:41:49 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qqxqwu4sf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:41:49 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 18 Feb 2019 18:41:46 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 18:41:42 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IIffDH19857480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 18:41:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 960314C04A;
        Mon, 18 Feb 2019 18:41:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5DC54C04E;
        Mon, 18 Feb 2019 18:41:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.207.239])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Feb 2019 18:41:37 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Mon, 18 Feb 2019 20:41:36 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2 1/4] init: provide a generic free_initmem implementation
Date:   Mon, 18 Feb 2019 20:41:22 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
References: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021818-0028-0000-0000-0000034A033B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021818-0029-0000-0000-000024083C64
Message-Id: <1550515285-17446-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=853 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For most architectures free_initmem just a wrapper for the same
free_initmem_default(-1) call.
Provide that as a generic implementation marked __weak.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/mm/init.c      | 6 ------
 arch/arc/mm/init.c        | 8 --------
 arch/c6x/mm/init.c        | 5 -----
 arch/h8300/mm/init.c      | 6 ------
 arch/microblaze/mm/init.c | 5 -----
 arch/nds32/mm/init.c      | 5 -----
 arch/nios2/mm/init.c      | 5 -----
 arch/openrisc/mm/init.c   | 5 -----
 arch/sh/mm/init.c         | 5 -----
 arch/unicore32/mm/init.c  | 5 -----
 arch/xtensa/mm/init.c     | 5 -----
 init/main.c               | 5 +++++
 12 files changed, 5 insertions(+), 60 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 97f4940..e2cbec3 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -285,9 +285,3 @@ mem_init(void)
 	memblock_free_all();
 	mem_init_print_info(NULL);
 }
-
-void
-free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index c357a3b..02b7a3b 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -206,11 +206,3 @@ void __init mem_init(void)
 	memblock_free_all();
 	mem_init_print_info(NULL);
 }
-
-/*
- * free_initmem: Free all the __init memory.
- */
-void __ref free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/c6x/mm/init.c b/arch/c6x/mm/init.c
index 5504b71..3257c53 100644
--- a/arch/c6x/mm/init.c
+++ b/arch/c6x/mm/init.c
@@ -66,8 +66,3 @@ void __init mem_init(void)
 
 	mem_init_print_info(NULL);
 }
-
-void __init free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 2eff00d..73671d0 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -100,9 +100,3 @@ void __init mem_init(void)
 
 	mem_init_print_info(NULL);
 }
-
-void
-free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 3bd32de..cf29692 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -186,11 +186,6 @@ void __init setup_memory(void)
 	paging_init();
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 void __init mem_init(void)
 {
 	high_memory = (void *)__va(memory_start + lowmem_size - 1);
diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index c02e10a..0003187 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -244,11 +244,6 @@ void __init mem_init(void)
 	return;
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 void __set_fixmap(enum fixed_addresses idx,
 			       phys_addr_t phys, pgprot_t flags)
 {
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index 60736a7..2c609c2 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -82,11 +82,6 @@ void __init mmu_init(void)
 	flush_tlb_all();
 }
 
-void __ref free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #define __page_aligned(order) __aligned(PAGE_SIZE << (order))
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d0d94a4..aa83f7d 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -220,8 +220,3 @@ void __init mem_init(void)
 	mem_init_done = 1;
 	return;
 }
-
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 2fa824336..ca9761b 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -405,11 +405,6 @@ void __init mem_init(void)
 	mem_init_done = 1;
 }
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		bool want_memblock)
diff --git a/arch/unicore32/mm/init.c b/arch/unicore32/mm/init.c
index 01271ce..2c52d9b 100644
--- a/arch/unicore32/mm/init.c
+++ b/arch/unicore32/mm/init.c
@@ -311,8 +311,3 @@ void __init mem_init(void)
 		sysctl_overcommit_memory = OVERCOMMIT_ALWAYS;
 	}
 }
-
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index d498610..b51746f 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -216,11 +216,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 }
 #endif
 
-void free_initmem(void)
-{
-	free_initmem_default(-1);
-}
-
 static void __init parse_memmap_one(char *p)
 {
 	char *oldp;
diff --git a/init/main.c b/init/main.c
index c86a1c8..38d69e0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1047,6 +1047,11 @@ static inline void mark_readonly(void)
 }
 #endif
 
+void __weak free_initmem(void)
+{
+	free_initmem_default(-1);
+}
+
 static int __ref kernel_init(void *unused)
 {
 	int ret;
-- 
2.7.4

