Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D85C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB94721728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB94721728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeHNUNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:13:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733240AbeHNUNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:13:38 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8AF74C5C;
        Tue, 14 Aug 2018 17:25:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 4.18 07/79] x86/speculation/l1tf: Protect swap entries against L1TF
Date:   Tue, 14 Aug 2018 19:16:26 +0200
Message-Id: <20180814171337.079739604@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable_64.h |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -273,7 +273,7 @@ static inline int pgd_large(pgd_t pgd) {
  *
  * |     ...            | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
  * |     ...            |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
- * | TYPE (59-63) |  OFFSET (9-58)  |0|0|X|X| X| X|X|SD|0| <- swp entry
+ * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| X|X|SD|0| <- swp entry
  *
  * G (8) is aliased and used as a PROT_NONE indicator for
  * !present ptes.  We need to start storing swap entries above
@@ -286,6 +286,9 @@ static inline int pgd_large(pgd_t pgd) {
  *
  * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
  * but also L and G.
+ *
+ * The offset is inverted by a binary not operation to make the high
+ * physical bits set.
  */
 #define SWP_TYPE_BITS		5
 
@@ -300,13 +303,15 @@ static inline int pgd_large(pgd_t pgd) {
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


