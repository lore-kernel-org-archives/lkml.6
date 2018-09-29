Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3AEC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E17F20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E17F20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeI3EXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:23:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51984 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728722AbeI3ESd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:33 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000Gz-OW; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uP-JN; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mikael Starvik" <starvik@axis.com>,
        "Jesper Nilsson" <jesper.nilsson@axis.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.385975558@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 069/131] cris: drop _PAGE_FILE and pte_file()-related
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

commit 103f3d9a26df944f4c29de190d72dfbf913c71af upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/cris/include/arch-v10/arch/mmu.h | 3 ---
 arch/cris/include/arch-v32/arch/mmu.h | 3 ---
 arch/cris/include/asm/pgtable.h       | 4 ----
 3 files changed, 10 deletions(-)

--- a/arch/cris/include/arch-v10/arch/mmu.h
+++ b/arch/cris/include/arch-v10/arch/mmu.h
@@ -58,7 +58,6 @@ typedef struct
 /* Bits the HW doesn't care about but the kernel uses them in SW */
 
 #define _PAGE_PRESENT   (1<<4)  /* page present in memory */
-#define _PAGE_FILE      (1<<5)  /* set: pagecache, unset: swap (when !PRESENT) */
 #define _PAGE_ACCESSED	(1<<5)  /* simulated in software using valid bit */
 #define _PAGE_MODIFIED	(1<<6)  /* simulated in software using we bit */
 #define _PAGE_READ      (1<<7)  /* read-enabled */
@@ -105,6 +104,4 @@ typedef struct
 #define __S110	PAGE_SHARED
 #define __S111	PAGE_SHARED
 
-#define PTE_FILE_MAX_BITS	26
-
 #endif
--- a/arch/cris/include/arch-v32/arch/mmu.h
+++ b/arch/cris/include/arch-v32/arch/mmu.h
@@ -53,7 +53,6 @@ typedef struct
  * software.
  */
 #define _PAGE_PRESENT   (1 << 5)   /* Page is present in memory. */
-#define _PAGE_FILE      (1 << 6)   /* 1=pagecache, 0=swap (when !present) */
 #define _PAGE_ACCESSED  (1 << 6)   /* Simulated in software using valid bit. */
 #define _PAGE_MODIFIED  (1 << 7)   /* Simulated in software using we bit. */
 #define _PAGE_READ      (1 << 8)   /* Read enabled. */
@@ -108,6 +107,4 @@ typedef struct
 #define __S110  PAGE_SHARED_EXEC
 #define __S111  PAGE_SHARED_EXEC
 
-#define PTE_FILE_MAX_BITS	25
-
 #endif /* _ASM_CRIS_ARCH_MMU_H */
--- a/arch/cris/include/asm/pgtable.h
+++ b/arch/cris/include/asm/pgtable.h
@@ -114,7 +114,6 @@ extern unsigned long empty_zero_page;
 static inline int pte_write(pte_t pte)          { return pte_val(pte) & _PAGE_WRITE; }
 static inline int pte_dirty(pte_t pte)          { return pte_val(pte) & _PAGE_MODIFIED; }
 static inline int pte_young(pte_t pte)          { return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_file(pte_t pte)           { return pte_val(pte) & _PAGE_FILE; }
 static inline int pte_special(pte_t pte)	{ return 0; }
 
 static inline pte_t pte_wrprotect(pte_t pte)
@@ -290,9 +289,6 @@ static inline void update_mmu_cache(stru
  */
 #define pgtable_cache_init()   do { } while (0)
 
-#define pte_to_pgoff(x)	(pte_val(x) >> 6)
-#define pgoff_to_pte(x)	__pte(((x) << 6) | _PAGE_FILE)
-
 typedef pte_t *pte_addr_t;
 
 #endif /* __ASSEMBLY__ */

