Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736DEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E5B20882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E5B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeI3EYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:24:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728568AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000Gz-JE; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vc-5X; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.162889318@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 084/131] sparc: drop pte_file()-related helpers
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit 6a8c4820895cf1dd2a128aef67ce079ba6eded80 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

This patch also increase number of bits availble for swap offset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sparc/include/asm/pgtable_32.h | 24 -----------------
 arch/sparc/include/asm/pgtable_64.h | 40 -----------------------------
 arch/sparc/include/asm/pgtsrmmu.h   | 14 ++++------
 3 files changed, 5 insertions(+), 73 deletions(-)

--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -221,14 +221,6 @@ static inline int pte_young(pte_t pte)
 	return pte_val(pte) & SRMMU_REF;
 }
 
-/*
- * The following only work if pte_present() is not true.
- */
-static inline int pte_file(pte_t pte)
-{
-	return pte_val(pte) & SRMMU_FILE;
-}
-
 static inline int pte_special(pte_t pte)
 {
 	return 0;
@@ -375,22 +367,6 @@ static inline swp_entry_t __swp_entry(un
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-/* file-offset-in-pte helpers */
-static inline unsigned long pte_to_pgoff(pte_t pte)
-{
-	return pte_val(pte) >> SRMMU_PTE_FILE_SHIFT;
-}
-
-static inline pte_t pgoff_to_pte(unsigned long pgoff)
-{
-	return __pte((pgoff << SRMMU_PTE_FILE_SHIFT) | SRMMU_FILE);
-}
-
-/*
- * This is made a constant because mm/fremap.c required a constant.
- */
-#define PTE_FILE_MAX_BITS 24
-
 static inline unsigned long
 __get_phys (unsigned long addr)
 {
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -137,7 +137,6 @@ bool kern_addr_valid(unsigned long addr)
 #define _PAGE_SOFT_4U	  _AC(0x0000000000001F80,UL) /* Software bits:       */
 #define _PAGE_EXEC_4U	  _AC(0x0000000000001000,UL) /* Executable SW bit    */
 #define _PAGE_MODIFIED_4U _AC(0x0000000000000800,UL) /* Modified (dirty)     */
-#define _PAGE_FILE_4U	  _AC(0x0000000000000800,UL) /* Pagecache page       */
 #define _PAGE_ACCESSED_4U _AC(0x0000000000000400,UL) /* Accessed (ref'd)     */
 #define _PAGE_READ_4U	  _AC(0x0000000000000200,UL) /* Readable SW Bit      */
 #define _PAGE_WRITE_4U	  _AC(0x0000000000000100,UL) /* Writable SW Bit      */
@@ -167,7 +166,6 @@ bool kern_addr_valid(unsigned long addr)
 #define _PAGE_EXEC_4V	  _AC(0x0000000000000080,UL) /* Executable Page      */
 #define _PAGE_W_4V	  _AC(0x0000000000000040,UL) /* Writable             */
 #define _PAGE_SOFT_4V	  _AC(0x0000000000000030,UL) /* Software bits        */
-#define _PAGE_FILE_4V	  _AC(0x0000000000000020,UL) /* Pagecache page       */
 #define _PAGE_PRESENT_4V  _AC(0x0000000000000010,UL) /* Present              */
 #define _PAGE_RESV_4V	  _AC(0x0000000000000008,UL) /* Reserved             */
 #define _PAGE_SZ16GB_4V	  _AC(0x0000000000000007,UL) /* 16GB Page            */
@@ -332,22 +330,6 @@ static inline pmd_t pmd_modify(pmd_t pmd
 }
 #endif
 
-static inline pte_t pgoff_to_pte(unsigned long off)
-{
-	off <<= PAGE_SHIFT;
-
-	__asm__ __volatile__(
-	"\n661:	or		%0, %2, %0\n"
-	"	.section	.sun4v_1insn_patch, \"ax\"\n"
-	"	.word		661b\n"
-	"	or		%0, %3, %0\n"
-	"	.previous\n"
-	: "=r" (off)
-	: "0" (off), "i" (_PAGE_FILE_4U), "i" (_PAGE_FILE_4V));
-
-	return __pte(off);
-}
-
 static inline pgprot_t pgprot_noncached(pgprot_t prot)
 {
 	unsigned long val = pgprot_val(prot);
@@ -609,22 +591,6 @@ static inline unsigned long pte_exec(pte
 	return (pte_val(pte) & mask);
 }
 
-static inline unsigned long pte_file(pte_t pte)
-{
-	unsigned long val = pte_val(pte);
-
-	__asm__ __volatile__(
-	"\n661:	and		%0, %2, %0\n"
-	"	.section	.sun4v_1insn_patch, \"ax\"\n"
-	"	.word		661b\n"
-	"	and		%0, %3, %0\n"
-	"	.previous\n"
-	: "=r" (val)
-	: "0" (val), "i" (_PAGE_FILE_4U), "i" (_PAGE_FILE_4V));
-
-	return val;
-}
-
 static inline unsigned long pte_present(pte_t pte)
 {
 	unsigned long val = pte_val(pte);
@@ -964,12 +930,6 @@ pgtable_t pgtable_trans_huge_withdraw(st
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-/* File offset in PTE support. */
-unsigned long pte_file(pte_t);
-#define pte_to_pgoff(pte)	(pte_val(pte) >> PAGE_SHIFT)
-pte_t pgoff_to_pte(unsigned long);
-#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 1UL)
-
 int page_in_phys_avail(unsigned long paddr);
 
 /*
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -80,10 +80,6 @@
 #define SRMMU_PRIV         0x1c
 #define SRMMU_PRIV_RDONLY  0x18
 
-#define SRMMU_FILE         0x40	/* Implemented in software */
-
-#define SRMMU_PTE_FILE_SHIFT     8	/* == 32-PTE_FILE_MAX_BITS */
-
 #define SRMMU_CHG_MASK    (0xffffff00 | SRMMU_REF | SRMMU_DIRTY)
 
 /* SRMMU swap entry encoding
@@ -94,13 +90,13 @@
  * oooooooooooooooooootttttRRRRRRRR
  * fedcba9876543210fedcba9876543210
  *
- * The bottom 8 bits are reserved for protection and status bits, especially
- * FILE and PRESENT.
+ * The bottom 7 bits are reserved for protection and status bits, especially
+ * PRESENT.
  */
 #define SRMMU_SWP_TYPE_MASK	0x1f
-#define SRMMU_SWP_TYPE_SHIFT	SRMMU_PTE_FILE_SHIFT
-#define SRMMU_SWP_OFF_MASK	0x7ffff
-#define SRMMU_SWP_OFF_SHIFT	(SRMMU_PTE_FILE_SHIFT + 5)
+#define SRMMU_SWP_TYPE_SHIFT	7
+#define SRMMU_SWP_OFF_MASK	0xfffff
+#define SRMMU_SWP_OFF_SHIFT	(SRMMU_SWP_TYPE_SHIFT + 5)
 
 /* Some day I will implement true fine grained access bits for
  * user pages because the SRMMU gives us the capabilities to

