Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2395AC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35912087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35912087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeI3EXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51962 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728715AbeI3ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:33 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000Gw-N1; Sat, 29 Sep 2018 22:48:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006tv-C5; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Vineet Gupta" <vgupta@synopsys.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.549536831@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 063/131] arc: drop _PAGE_FILE and pte_file()-related
 helpers
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

commit 18747151308f9e0fb63766057957617ec4afa190 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/include/asm/pgtable.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -61,7 +61,6 @@
 #define _PAGE_WRITE         (1<<4)	/* Page has user write perm (H) */
 #define _PAGE_READ          (1<<5)	/* Page has user read perm (H) */
 #define _PAGE_MODIFIED      (1<<6)	/* Page modified (dirty) (S) */
-#define _PAGE_FILE          (1<<7)	/* page cache/ swap (S) */
 #define _PAGE_GLOBAL        (1<<8)	/* Page is global (H) */
 #define _PAGE_PRESENT       (1<<10)	/* TLB entry is valid (H) */
 
@@ -73,7 +72,6 @@
 #define _PAGE_READ          (1<<3)	/* Page has user read perm (H) */
 #define _PAGE_ACCESSED      (1<<4)	/* Page is accessed (S) */
 #define _PAGE_MODIFIED      (1<<5)	/* Page modified (dirty) (S) */
-#define _PAGE_FILE          (1<<6)	/* page cache/ swap (S) */
 #define _PAGE_GLOBAL        (1<<8)	/* Page is global (H) */
 #define _PAGE_PRESENT       (1<<9)	/* TLB entry is valid (H) */
 #define _PAGE_SHARED_CODE   (1<<11)	/* Shared Code page with cmn vaddr
@@ -269,15 +267,6 @@ static inline void pmd_set(pmd_t *pmdp,
 	pte;								\
 })
 
-/* TBD: Non linear mapping stuff */
-static inline int pte_file(pte_t pte)
-{
-	return pte_val(pte) & _PAGE_FILE;
-}
-
-#define PTE_FILE_MAX_BITS	30
-#define pgoff_to_pte(x)         __pte(x)
-#define pte_to_pgoff(x)		(pte_val(x) >> 2)
 #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)	(__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 #define __pte_index(addr)	(((addr) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
@@ -365,7 +354,7 @@ void update_mmu_cache(struct vm_area_str
 
 /* Encode swap {type,off} tuple into PTE
  * We reserve 13 bits for 5-bit @type, keeping bits 12-5 zero, ensuring that
- * both PAGE_FILE and PAGE_PRESENT are zero in a PTE holding swap "identifier"
+ * PAGE_PRESENT is zero in a PTE holding swap "identifier"
  */
 #define __swp_entry(type, off)	((swp_entry_t) { \
 					((type) & 0x1f) | ((off) << 13) })

