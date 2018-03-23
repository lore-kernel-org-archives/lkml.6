Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeCWTx1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:53:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCWTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:53:26 -0400
Date: Fri, 23 Mar 2018 12:52:58 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-e7de6c7cc207be78369d45fb833d7d53aeda47f8@git.kernel.org>
Cc: thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, mulix@mulix.org, konrad.wilk@oracle.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, hch@lst.de, mingo@kernel.org,
        jdmason@kudzu.us, joro@8bytes.org
Reply-To: dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com, mulix@mulix.org,
        thomas.lendacky@amd.com, mingo@kernel.org, hpa@zytor.com, hch@lst.de,
        joro@8bytes.org, jdmason@kudzu.us, tglx@linutronix.de,
        peterz@infradead.org
In-Reply-To: <20180319103826.12853-12-hch@lst.de>
References: <20180319103826.12853-12-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] dma/swiotlb: Remove swiotlb_set_mem_attributes()
Git-Commit-ID: e7de6c7cc207be78369d45fb833d7d53aeda47f8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e7de6c7cc207be78369d45fb833d7d53aeda47f8
Gitweb:     https://git.kernel.org/tip/e7de6c7cc207be78369d45fb833d7d53aeda47f8
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:58 +0100

dma/swiotlb: Remove swiotlb_set_mem_attributes()

Now that set_memory_decrypted() is always available we can just call it
directly.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-12-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/mm/mem_encrypt.c          |  8 --------
 lib/swiotlb.c                      | 12 ++++++------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 8fe61ad21047..c0643831706e 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -49,8 +49,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
-void swiotlb_set_mem_attributes(void *vaddr, unsigned long size);
-
 bool sme_active(void);
 bool sev_active(void);
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1217a4fab915..d243e8d80d89 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -441,11 +441,3 @@ void __init mem_encrypt_init(void)
 			     : "Secure Memory Encryption (SME)");
 }
 
-void swiotlb_set_mem_attributes(void *vaddr, unsigned long size)
-{
-	WARN(PAGE_ALIGN(size) != size,
-	     "size is not page-aligned (%#lx)\n", size);
-
-	/* Make the SWIOTLB buffer area decrypted */
-	set_memory_decrypted((unsigned long)vaddr, size >> PAGE_SHIFT);
-}
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index c43ec2271469..005d1d87bb2e 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
+#include <linux/set_memory.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -156,8 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size) { }
-
 /* For swiotlb, clear memory encryption mask from dma addresses */
 static dma_addr_t swiotlb_phys_to_dma(struct device *hwdev,
 				      phys_addr_t address)
@@ -209,12 +208,12 @@ void __init swiotlb_update_mem_attributes(void)
 
 	vaddr = phys_to_virt(io_tlb_start);
 	bytes = PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT);
-	swiotlb_set_mem_attributes(vaddr, bytes);
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 
 	vaddr = phys_to_virt(io_tlb_overflow_buffer);
 	bytes = PAGE_ALIGN(io_tlb_overflow);
-	swiotlb_set_mem_attributes(vaddr, bytes);
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
 }
 
@@ -355,7 +354,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	io_tlb_start = virt_to_phys(tlb);
 	io_tlb_end = io_tlb_start + bytes;
 
-	swiotlb_set_mem_attributes(tlb, bytes);
+	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	memset(tlb, 0, bytes);
 
 	/*
@@ -366,7 +365,8 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!v_overflow_buffer)
 		goto cleanup2;
 
-	swiotlb_set_mem_attributes(v_overflow_buffer, io_tlb_overflow);
+	set_memory_decrypted((unsigned long)v_overflow_buffer,
+			io_tlb_overflow >> PAGE_SHIFT);
 	memset(v_overflow_buffer, 0, io_tlb_overflow);
 	io_tlb_overflow_buffer = virt_to_phys(v_overflow_buffer);
 
