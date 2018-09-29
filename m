Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59720C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF372087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF372087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeI3E0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51696 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000H8-4s; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wP-H6; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Hansen" <dave.hansen@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Andi Kleen" <ak@linux.intel.com>, "Michal Hocko" <mhocko@suse.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.461032515@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 094/131] x86/speculation/l1tf: Change order of
 offset/type in swap entry
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit bcd11afa7adad8d720e7ba5ef58bdcd9775cf45f upstream.

If pages are swapped out, the swap entry is stored in the corresponding
PTE, which has the Present bit cleared. CPUs vulnerable to L1TF speculate
on PTE entries which have the present bit set and would treat the swap
entry as phsyical address (PFN). To mitigate that the upper bits of the PTE
must be set so the PTE points to non existent memory.

The swap entry stores the type and the offset of a swapped out page in the
PTE. type is stored in bit 9-13 and offset in bit 14-63. The hardware
ignores the bits beyond the phsyical address space limit, so to make the
mitigation effective its required to start 'offset' at the lowest possible
bit so that even large swap offsets do not reach into the physical address
space limit bits.

Move offset to bit 9-58 and type to bit 59-63 which are the bits that
hardware generally doesn't care about.

That, in turn, means that if you on desktop chip with only 40 bits of
physical addressing, now that the offset starts at bit 9, there needs to be
30 bits of offset actually *in use* until bit 39 ends up being set, which
means when inverted it will again point into existing memory.

So that's 4 terabyte of swap space (because the offset is counted in pages,
so 30 bits of offset is 42 bits of actual coverage). With bigger physical
addressing, that obviously grows further, until the limit of the offset is
hit (at 50 bits of offset - 62 bits of actual swap file coverage).

This is a preparatory change for the actual swap entry inversion to protect
against L1TF.

[ AK: Updated description and minor tweaks. Split into two parts ]
[ tglx: Massaged changelog ]

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Dave Hansen <dave.hansen@intel.com>
[bwh: Backported to 3.16: Bit 9 may be reserved for PAGE_BIT_NUMA here]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable_64.h | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -167,7 +167,7 @@ static inline int pgd_large(pgd_t pgd) {
  *
  * |     ...                | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
  * |     ...                |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
- * | OFFSET (15->63) | TYPE (10-14) | 0 |0|0|X|X| X| X|X|SD|0| <- swp entry
+ * | TYPE (59-63) |  OFFSET (10-58) | 0 |0|0|X|X| X| X|X|SD|0| <- swp entry
  *
  * G (8) is aliased and used as a PROT_NONE indicator for
  * !present ptes.  We need to start storing swap entries above
@@ -181,24 +181,33 @@ static inline int pgd_large(pgd_t pgd) {
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
  */
+#define SWP_TYPE_BITS		5
+
 #ifdef CONFIG_NUMA_BALANCING
 /* Automatic NUMA balancing needs to be distinguishable from swap entries */
-#define SWP_TYPE_FIRST_SHIFT (_PAGE_BIT_PROTNONE + 2)
+#define SWP_OFFSET_FIRST_BIT	(_PAGE_BIT_PROTNONE + 2)
 #else
-#define SWP_TYPE_FIRST_SHIFT (_PAGE_BIT_PROTNONE + 1)
+#define SWP_OFFSET_FIRST_BIT	(_PAGE_BIT_PROTNONE + 1)
 #endif
-#define SWP_TYPE_BITS 5
-/* Place the offset above the type: */
-#define SWP_OFFSET_FIRST_BIT (SWP_TYPE_FIRST_BIT + SWP_TYPE_BITS)
+
+/* We always extract/encode the offset by shifting it all the way up, and then down again */
+#define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT+SWP_TYPE_BITS)
 
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS)
 
-#define __swp_type(x)			(((x).val >> (SWP_TYPE_FIRST_BIT)) \
-					 & ((1U << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)			((x).val >> SWP_OFFSET_FIRST_BIT)
-#define __swp_entry(type, offset)	((swp_entry_t) { \
-					 ((type) << (SWP_TYPE_FIRST_BIT)) \
-					 | ((offset) << SWP_OFFSET_FIRST_BIT) })
+/* Extract the high bits for type */
+#define __swp_type(x) ((x).val >> (64 - SWP_TYPE_BITS))
+
+/* Shift up (to get rid of type), then down to get value */
+#define __swp_offset(x) ((x).val << SWP_TYPE_BITS >> SWP_OFFSET_SHIFT)
+
+/*
+ * Shift the offset up "too far" by TYPE bits, then down again
+ */
+#define __swp_entry(type, offset) ((swp_entry_t) { \
+	((unsigned long)(offset) << SWP_OFFSET_SHIFT >> SWP_TYPE_BITS) \
+	| ((unsigned long)(type) << (64-SWP_TYPE_BITS)) })
+
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
 #define __swp_entry_to_pte(x)		((pte_t) { .pte = (x).val })
 

