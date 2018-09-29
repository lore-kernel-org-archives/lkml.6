Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE0C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3400A2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3400A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeI3ESf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51939 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728705AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000Gs-Mz; Sat, 29 Sep 2018 22:48:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006uZ-Ln; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Richard Kuo" <rkuo@codeaurora.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.945367476@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 071/131] hexagon: drop _PAGE_FILE and pte_file()-related
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

commit d99f95e6522db22192c331c75de182023a49fbcc upstream.

We've replaced remap_file_pages(2) implementation with emulation.  Nobody
creates non-linear mapping anymore.

This patch also increase number of bits availble for swap offset.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Richard Kuo <rkuo@codeaurora.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/hexagon/include/asm/pgtable.h | 60 ++++++++----------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -62,13 +62,6 @@ extern unsigned long zero_page_mask;
 #define _PAGE_ACCESSED	(1<<2)
 
 /*
- * _PAGE_FILE is only meaningful if _PAGE_PRESENT is false, while
- * _PAGE_DIRTY is only meaningful if _PAGE_PRESENT is true.
- * So we can overload the bit...
- */
-#define _PAGE_FILE	_PAGE_DIRTY /* set:  pagecache, unset = swap */
-
-/*
  * For now, let's say that Valid and Present are the same thing.
  * Alternatively, we could say that it's the "or" of R, W, and X
  * permissions.
@@ -456,57 +449,36 @@ static inline int pte_exec(pte_t pte)
 #define pgtable_cache_init()    do { } while (0)
 
 /*
- * Swap/file PTE definitions.  If _PAGE_PRESENT is zero, the rest of the
- * PTE is interpreted as swap information.  Depending on the _PAGE_FILE
- * bit, the remaining free bits are eitehr interpreted as a file offset
- * or a swap type/offset tuple.  Rather than have the TLB fill handler
- * test _PAGE_PRESENT, we're going to reserve the permissions bits
- * and set them to all zeros for swap entries, which speeds up the
- * miss handler at the cost of 3 bits of offset.  That trade-off can
- * be revisited if necessary, but Hexagon processor architecture and
- * target applications suggest a lot of TLB misses and not much swap space.
+ * Swap/file PTE definitions.  If _PAGE_PRESENT is zero, the rest of the PTE is
+ * interpreted as swap information.  The remaining free bits are interpreted as
+ * swap type/offset tuple.  Rather than have the TLB fill handler test
+ * _PAGE_PRESENT, we're going to reserve the permissions bits and set them to
+ * all zeros for swap entries, which speeds up the miss handler at the cost of
+ * 3 bits of offset.  That trade-off can be revisited if necessary, but Hexagon
+ * processor architecture and target applications suggest a lot of TLB misses
+ * and not much swap space.
  *
  * Format of swap PTE:
  *	bit	0:	Present (zero)
- *	bit	1:	_PAGE_FILE (zero)
- *	bits	2-6:	swap type (arch independent layer uses 5 bits max)
- *	bits	7-9:	bits 2:0 of offset
- *	bits 10-12:	effectively _PAGE_PROTNONE (all zero)
- *	bits 13-31:  bits 21:3 of swap offset
- *
- * Format of file PTE:
- *	bit	0:	Present (zero)
- *	bit	1:	_PAGE_FILE (zero)
- *	bits	2-9:	bits 7:0 of offset
- *	bits 10-12:	effectively _PAGE_PROTNONE (all zero)
- *	bits 13-31:  bits 26:8 of swap offset
+ *	bits	1-5:	swap type (arch independent layer uses 5 bits max)
+ *	bits	6-9:	bits 3:0 of offset
+ *	bits	10-12:	effectively _PAGE_PROTNONE (all zero)
+ *	bits	13-31:  bits 22:4 of swap offset
  *
  * The split offset makes some of the following macros a little gnarly,
  * but there's plenty of precedent for this sort of thing.
  */
-#define PTE_FILE_MAX_BITS     27
 
 /* Used for swap PTEs */
-#define __swp_type(swp_pte)		(((swp_pte).val >> 2) & 0x1f)
+#define __swp_type(swp_pte)		(((swp_pte).val >> 1) & 0x1f)
 
 #define __swp_offset(swp_pte) \
-	((((swp_pte).val >> 7) & 0x7) | (((swp_pte).val >> 10) & 0x003ffff8))
+	((((swp_pte).val >> 6) & 0xf) | (((swp_pte).val >> 9) & 0x7ffff0))
 
 #define __swp_entry(type, offset) \
 	((swp_entry_t)	{ \
-		((type << 2) | \
-		 ((offset & 0x3ffff8) << 10) | ((offset & 0x7) << 7)) })
-
-/* Used for file PTEs */
-#define pte_file(pte) \
-	((pte_val(pte) & (_PAGE_FILE | _PAGE_PRESENT)) == _PAGE_FILE)
-
-#define pte_to_pgoff(pte) \
-	(((pte_val(pte) >> 2) & 0xff) | ((pte_val(pte) >> 5) & 0x07ffff00))
-
-#define pgoff_to_pte(off) \
-	((pte_t) { ((((off) & 0x7ffff00) << 5) | (((off) & 0xff) << 2)\
-	| _PAGE_FILE) })
+		((type << 1) | \
+		 ((offset & 0x7ffff0) << 9) | ((offset & 0xf) << 6)) })
 
 /*  Oh boy.  There are a lot of possible arch overrides found in this file.  */
 #include <asm-generic/pgtable.h>

