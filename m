Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F01C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EA72087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EA72087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeI3E2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:28:34 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51679 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728279AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N65-0000Gu-MT; Sat, 29 Sep 2018 22:48:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006xn-6C; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Vlastimil Babka" <vbabka@suse.cz>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Michal Hocko" <mhocko@suse.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.348117527@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 111/131] x86/speculation/l1tf: Protect PAE swap
 entries against L1TF
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

From: Vlastimil Babka <vbabka@suse.cz>

commit 0d0f6249058834ffe1ceaad0bb31464af66f6e7a upstream.

The PAE 3-level paging code currently doesn't mitigate L1TF by flipping the
offset bits, and uses the high PTE word, thus bits 32-36 for type, 37-63 for
offset. The lower word is zeroed, thus systems with less than 4GB memory are
safe. With 4GB to 128GB the swap type selects the memory locations vulnerable
to L1TF; with even more memory, also the swap offfset influences the address.
This might be a problem with 32bit PAE guests running on large 64bit hosts.

By continuing to keep the whole swap entry in either high or low 32bit word of
PTE we would limit the swap size too much. Thus this patch uses the whole PAE
PTE with the same layout as the 64bit version does. The macros just become a
bit tricky since they assume the arch-dependent swp_entry_t to be 32bit.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Michal Hocko <mhocko@suse.com>
[bwh: Backported to 3.16: CONFIG_PGTABLE_LEVELS is not defined; use other
 config symbols in the condition.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/pgtable-3level.h | 35 +++++++++++++++++++++++++--
 arch/x86/mm/init.c                    |  2 +-
 2 files changed, 34 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -177,12 +177,43 @@ static inline pmd_t native_pmdp_get_and_
 #endif
 
 /* Encode and de-code a swap entry */
+#define SWP_TYPE_BITS		5
+
+#define SWP_OFFSET_FIRST_BIT	(_PAGE_BIT_PROTNONE + 1)
+
+/* We always extract/encode the offset by shifting it all the way up, and then down again */
+#define SWP_OFFSET_SHIFT	(SWP_OFFSET_FIRST_BIT + SWP_TYPE_BITS)
+
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > 5)
 #define __swp_type(x)			(((x).val) & 0x1f)
 #define __swp_offset(x)			((x).val >> 5)
 #define __swp_entry(type, offset)	((swp_entry_t){(type) | (offset) << 5})
-#define __pte_to_swp_entry(pte)		((swp_entry_t){ (pte).pte_high })
-#define __swp_entry_to_pte(x)		((pte_t){ { .pte_high = (x).val } })
+
+/*
+ * Normally, __swp_entry() converts from arch-independent swp_entry_t to
+ * arch-dependent swp_entry_t, and __swp_entry_to_pte() just stores the result
+ * to pte. But here we have 32bit swp_entry_t and 64bit pte, and need to use the
+ * whole 64 bits. Thus, we shift the "real" arch-dependent conversion to
+ * __swp_entry_to_pte() through the following helper macro based on 64bit
+ * __swp_entry().
+ */
+#define __swp_pteval_entry(type, offset) ((pteval_t) { \
+	(~(pteval_t)(offset) << SWP_OFFSET_SHIFT >> SWP_TYPE_BITS) \
+	| ((pteval_t)(type) << (64 - SWP_TYPE_BITS)) })
+
+#define __swp_entry_to_pte(x)	((pte_t){ .pte = \
+		__swp_pteval_entry(__swp_type(x), __swp_offset(x)) })
+/*
+ * Analogically, __pte_to_swp_entry() doesn't just extract the arch-dependent
+ * swp_entry_t, but also has to convert it from 64bit to the 32bit
+ * intermediate representation, using the following macros based on 64bit
+ * __swp_type() and __swp_offset().
+ */
+#define __pteval_swp_type(x) ((unsigned long)((x).pte >> (64 - SWP_TYPE_BITS)))
+#define __pteval_swp_offset(x) ((unsigned long)(~((x).pte) << SWP_TYPE_BITS >> SWP_OFFSET_SHIFT))
+
+#define __pte_to_swp_entry(pte)	(__swp_entry(__pteval_swp_type(pte), \
+					     __pteval_swp_offset(pte)))
 
 #include <asm/pgtable-invert.h>
 
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -715,7 +715,7 @@ unsigned long max_swapfile_size(void)
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
 		 */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
 #endif
 		pages = min_t(unsigned long, l1tf_limit, pages);

