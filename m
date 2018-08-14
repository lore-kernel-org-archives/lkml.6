Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B202154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B202154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390498AbeHNUbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:31:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:31:12 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C169B40B;
        Tue, 14 Aug 2018 17:43:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 053/107] x86/speculation/l1tf: Protect PAE swap entries against L1TF
Date:   Tue, 14 Aug 2018 19:17:16 +0200
Message-Id: <20180814171524.390362592@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 0d0f6249058834ffe1ceaad0bb31464af66f6e7a upstream

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable-3level.h |   35 ++++++++++++++++++++++++++++++++--
 arch/x86/mm/init.c                    |    2 -
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
@@ -796,7 +796,7 @@ unsigned long max_swapfile_size(void)
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
 		 */
-#ifdef CONFIG_X86_64
+#if CONFIG_PGTABLE_LEVELS > 2
 		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
 #endif
 		pages = min_t(unsigned long, l1tf_limit, pages);


