Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02801C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C541D206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C541D206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeI3E1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:27:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51699 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728337AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000HB-4U; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wU-Hi; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Michal Hocko" <mhocko@suse.com>, "Andi Kleen" <ak@linux.intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.872077619@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/131] x86/speculation/l1tf: Protect swap entries
 against L1TF
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

commit 2f22b4cd45b67b3496f4aa4c7180a1271c6452f6 upstream.

With L1 terminal fault the CPU speculates into unmapped PTEs, and resulting
side effects allow to read the memory the PTE is pointing too, if its
values are still in the L1 cache.

For swapped out pages Linux uses unmapped PTEs and stores a swap entry into
them.

To protect against L1TF it must be ensured that the swap entry is not
pointing to valid memory, which requires setting higher bits (between bit
36 and bit 45) that are inside the CPUs physical address space, but outside
any real memory.

To do this invert the offset to make sure the higher bits are always set,
as long as the swap file is not too big.

Note there is no workaround for 32bit !PAE, or on systems which have more
than MAX_PA/2 worth of memory. The later case is very unlikely to happen on
real systems.

[AK: updated description and minor tweaks by. Split out from the original
     patch ]

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
 arch/x86/include/asm/pgtable_64.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -167,7 +167,7 @@ static inline int pgd_large(pgd_t pgd) {
  *
  * |     ...                | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
  * |     ...                |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
- * | TYPE (59-63) |  OFFSET (10-58) | 0 |0|0|X|X| X| X|X|SD|0| <- swp entry
+ * | TYPE (59-63) | ~OFFSET (10-58) | 0 |0|0|X|X| X| X|X|SD|0| <- swp entry
  *
  * G (8) is aliased and used as a PROT_NONE indicator for
  * !present ptes.  We need to start storing swap entries above
@@ -180,6 +180,9 @@ static inline int pgd_large(pgd_t pgd) {
  *
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
+ *
+ * The offset is inverted by a binary not operation to make the high
+ * physical bits set.
  */
 #define SWP_TYPE_BITS		5
 
@@ -199,13 +202,15 @@ static inline int pgd_large(pgd_t pgd) {
 #define __swp_type(x) ((x).val >> (64 - SWP_TYPE_BITS))
 
 /* Shift up (to get rid of type), then down to get value */
-#define __swp_offset(x) ((x).val << SWP_TYPE_BITS >> SWP_OFFSET_SHIFT)
+#define __swp_offset(x) (~(x).val << SWP_TYPE_BITS >> SWP_OFFSET_SHIFT)
 
 /*
  * Shift the offset up "too far" by TYPE bits, then down again
+ * The offset is inverted by a binary not operation to make the high
+ * physical bits set.
  */
 #define __swp_entry(type, offset) ((swp_entry_t) { \
-	((unsigned long)(offset) << SWP_OFFSET_SHIFT >> SWP_TYPE_BITS) \
+	(~(unsigned long)(offset) << SWP_OFFSET_SHIFT >> SWP_TYPE_BITS) \
 	| ((unsigned long)(type) << (64-SWP_TYPE_BITS)) })
 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })

