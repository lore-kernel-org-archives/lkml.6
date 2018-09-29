Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E00AC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1152087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1152087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeI3ESf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51932 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728709AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000Gu-Ni; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uU-KW; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "David Howells" <dhowells@redhat.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.782147215@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 070/131] frv: drop _PAGE_FILE and pte_file()-related
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

commit ca5bfa7b390017f053d7581bc701518b87bc3d43 upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

This patch also increase number of bits availble for swap offset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/frv/include/asm/pgtable.h | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

--- a/arch/frv/include/asm/pgtable.h
+++ b/arch/frv/include/asm/pgtable.h
@@ -62,10 +62,6 @@ typedef pte_t *pte_addr_t;
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#ifndef __ASSEMBLY__
-static inline int pte_file(pte_t pte) { return 0; }
-#endif
-
 #define ZERO_PAGE(vaddr)	({ BUG(); NULL; })
 
 #define swapper_pg_dir		((pgd_t *) NULL)
@@ -298,7 +294,6 @@ static inline pmd_t *pmd_offset(pud_t *d
 
 #define _PAGE_RESERVED_MASK	(xAMPRx_RESERVED8 | xAMPRx_RESERVED13)
 
-#define _PAGE_FILE		0x002	/* set:pagecache unset:swap */
 #define _PAGE_PROTNONE		0x000	/* If not present */
 
 #define _PAGE_CHG_MASK		(PTE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -463,27 +458,15 @@ static inline pte_t pte_modify(pte_t pte
  * Handle swap and file entries
  * - the PTE is encoded in the following format:
  *	bit 0:		Must be 0 (!_PAGE_PRESENT)
- *	bit 1:		Type: 0 for swap, 1 for file (_PAGE_FILE)
- *	bits 2-7:	Swap type
- *	bits 8-31:	Swap offset
- *	bits 2-31:	File pgoff
- */
-#define __swp_type(x)			(((x).val >> 2) & 0x1f)
-#define __swp_offset(x)			((x).val >> 8)
-#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 2) | ((offset) << 8) })
+ *	bits 1-6:	Swap type
+ *	bits 7-31:	Swap offset
+ */
+#define __swp_type(x)			(((x).val >> 1) & 0x1f)
+#define __swp_offset(x)			((x).val >> 7)
+#define __swp_entry(type, offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 7) })
 #define __pte_to_swp_entry(_pte)	((swp_entry_t) { (_pte).pte })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-static inline int pte_file(pte_t pte)
-{
-	return pte.pte & _PAGE_FILE;
-}
-
-#define PTE_FILE_MAX_BITS	29
-
-#define pte_to_pgoff(PTE)	((PTE).pte >> 2)
-#define pgoff_to_pte(off)	__pte((off) << 2 | _PAGE_FILE)
-
 /* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)

