Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF86C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E5020880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E5020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeI3ESa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51779 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728539AbeI3ES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:29 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000H4-Nn; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006vN-1s; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.903877172@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 081/131] s390: drop pte_file()-related helpers
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

commit 6e76d4b20bf6b514408ab5bd07f4a76723259b64 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/include/asm/pgtable.h | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -237,10 +237,10 @@ extern unsigned long MODULES_END;
 				 _PAGE_DIRTY | _PAGE_YOUNG)
 
 /*
- * handle_pte_fault uses pte_present, pte_none and pte_file to find out the
- * pte type WITHOUT holding the page table lock. The _PAGE_PRESENT bit
- * is used to distinguish present from not-present ptes. It is changed only
- * with the page table lock held.
+ * handle_pte_fault uses pte_present and pte_none to find out the pte type
+ * WITHOUT holding the page table lock. The _PAGE_PRESENT bit is used to
+ * distinguish present from not-present ptes. It is changed only with the page
+ * table lock held.
  *
  * The following table gives the different possible bit combinations for
  * the pte hardware and software bits in the last 12 bits of a pte:
@@ -267,7 +267,6 @@ extern unsigned long MODULES_END;
  *
  * pte_present is true for the bit pattern .xx...xxxxx1, (pte & 0x001) == 0x001
  * pte_none    is true for the bit pattern .10...xxxx00, (pte & 0x603) == 0x400
- * pte_file    is true for the bit pattern .11...xxxxx0, (pte & 0x601) == 0x600
  * pte_swap    is true for the bit pattern .10...xxxx10, (pte & 0x603) == 0x402
  */
 
@@ -644,13 +643,6 @@ static inline int pte_swap(pte_t pte)
 		== (_PAGE_INVALID | _PAGE_TYPE);
 }
 
-static inline int pte_file(pte_t pte)
-{
-	/* Bit pattern: (pte & 0x601) == 0x600 */
-	return (pte_val(pte) & (_PAGE_INVALID | _PAGE_PROTECT | _PAGE_PRESENT))
-		== (_PAGE_INVALID | _PAGE_PROTECT);
-}
-
 static inline int pte_special(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_SPECIAL);
@@ -1710,19 +1702,6 @@ static inline pte_t mk_swap_pte(unsigned
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#ifndef CONFIG_64BIT
-# define PTE_FILE_MAX_BITS	26
-#else /* CONFIG_64BIT */
-# define PTE_FILE_MAX_BITS	59
-#endif /* CONFIG_64BIT */
-
-#define pte_to_pgoff(__pte) \
-	((((__pte).pte >> 12) << 7) + (((__pte).pte >> 1) & 0x7f))
-
-#define pgoff_to_pte(__off) \
-	((pte_t) { ((((__off) & 0x7f) << 1) + (((__off) >> 7) << 12)) \
-		   | _PAGE_INVALID | _PAGE_PROTECT })
-
 #endif /* !__ASSEMBLY__ */
 
 #define kern_addr_valid(addr)   (1)

