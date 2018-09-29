Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674FFC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299C92087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299C92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeI3E0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51725 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000H3-51; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wG-Fg; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, linux-mm@kvack.org,
        mhocko@suse.com, "Brian Gerst" <brgerst@gmail.com>,
        "Toshi Kani" <toshi.kani@hp.com>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        "Ingo Molnar" <mingo@kernel.org>, "Dave Hansen" <dave@sr71.net>,
        dave.hansen@intel.com,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.740574776@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 092/131] x86/mm: Move swap offset/type up in PTE to
 work around erratum
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

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 00839ee3b299303c6a5e26a0a2485427a3afcbbf upstream.

This erratum can result in Accessed/Dirty getting set by the hardware
when we do not expect them to be (on !Present PTEs).

Instead of trying to fix them up after this happens, we just
allow the bits to get set and try to ignore them.  We do this by
shifting the layout of the bits we use for swap offset/type in
our 64-bit PTEs.

It looks like this:

 bitnrs: |     ...            | 11| 10|  9|8|7|6|5| 4| 3|2|1|0|
 names:  |     ...            |SW3|SW2|SW1|G|L|D|A|CD|WT|U|W|P|
 before: |         OFFSET (9-63)          |0|X|X| TYPE(1-5) |0|
  after: | OFFSET (14-63)  |  TYPE (9-13) |0|X|X|X| X| X|X|X|0|

Note that D was already a don't care (X) even before.  We just
move TYPE up and turn its old spot (which could be hit by the
A bit) into all don't cares.

We take 5 bits away from the offset, but that still leaves us
with 50 bits which lets us index into a 62-bit swapfile (4 EiB).
I think that's probably fine for the moment.  We could
theoretically reclaim 5 of the bits (1, 2, 3, 4, 7) but it
doesn't gain us anything.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave@sr71.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hp.com>
Cc: dave.hansen@intel.com
Cc: linux-mm@kvack.org
Cc: mhocko@suse.com
Link: http://lkml.kernel.org/r/20160708001911.9A3FD2B6@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: Bit 9 may be reserved for PAGE_BIT_NUMA, which
 no longer exists upstream.  Adjust the bit numbers accordingly,
 incorporating commit ace7fab7a6cd "x86/mm: Fix swap entry comment and
 macro".]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -162,23 +162,37 @@ static inline int pgd_large(pgd_t pgd) {
 #define pte_offset_map(dir, address) pte_offset_kernel((dir), (address))
 #define pte_unmap(pte) ((void)(pte))/* NOP */
 
-/* Encode and de-code a swap entry */
-#define SWP_TYPE_BITS 5
+/*
+ * Encode and de-code a swap entry
+ *
+ * |     ...                | 11| 10|  9|8|7|6|5| 4| 3|2|1|0| <- bit number
+ * |     ...                |SW3|SW2|SW1|G|L|D|A|CD|WT|U|W|P| <- bit names
+ * | OFFSET (15->63) | TYPE (10-14) | 0 |0|X|X|X| X| X|X|X|0| <- swp entry
+ *
+ * G (8) is aliased and used as a PROT_NONE indicator for
+ * !present ptes.  We need to start storing swap entries above
+ * there.  We also need to avoid using A and D because of an
+ * erratum where they can be incorrectly set by hardware on
+ * non-present PTEs.
+ */
 #ifdef CONFIG_NUMA_BALANCING
 /* Automatic NUMA balancing needs to be distinguishable from swap entries */
-#define SWP_OFFSET_SHIFT (_PAGE_BIT_PROTNONE + 2)
+#define SWP_TYPE_FIRST_SHIFT (_PAGE_BIT_PROTNONE + 2)
 #else
-#define SWP_OFFSET_SHIFT (_PAGE_BIT_PROTNONE + 1)
+#define SWP_TYPE_FIRST_SHIFT (_PAGE_BIT_PROTNONE + 1)
 #endif
+#define SWP_TYPE_BITS 5
+/* Place the offset above the type: */
+#define SWP_OFFSET_FIRST_BIT (SWP_TYPE_FIRST_BIT + SWP_TYPE_BITS)
 
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
 
-#define __swp_type(x)			(((x).val >> (_PAGE_BIT_PRESENT + 1)) \
+#define __swp_type(x)			(((x).val >> (SWP_TYPE_FIRST_BIT)) \
 					 & ((1U << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)			((x).val >> SWP_OFFSET_SHIFT)
+#define __swp_offset(x)			((x).val >> SWP_OFFSET_FIRST_BIT)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
-					 ((type) << (_PAGE_BIT_PRESENT + 1)) \
-					 | ((offset) << SWP_OFFSET_SHIFT) })
+					 ((type) << (SWP_TYPE_FIRST_BIT)) \
+					 | ((offset) << SWP_OFFSET_FIRST_BIT) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
 

