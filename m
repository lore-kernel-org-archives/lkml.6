Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF3AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8374B21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8374B21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403828AbeHNUfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:35:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbeHNUfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:35:38 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA5B1D08;
        Tue, 14 Aug 2018 17:47:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 33/43] x86/speculation/l1tf: Limit swap file size to MAX_PA/2
Date:   Tue, 14 Aug 2018 19:18:09 +0200
Message-Id: <20180814171519.273142378@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 377eeaa8e11fe815b1d07c81c4a0e2843a8c15eb upstream

For the L1TF workaround its necessary to limit the swap file size to below
MAX_PA/2, so that the higher bits of the swap offset inverted never point
to valid memory.

Add a mechanism for the architecture to override the swap file size check
in swapfile.c and add a x86 specific max swapfile check function that
enforces that limit.

The check is only enabled if the CPU is vulnerable to L1TF.

In VMs with 42bit MAX_PA the typical limit is 2TB now, on a native system
with 46bit PA it is 32TB. The limit is only per individual swap file, so
it's always possible to exceed these limits with multiple swap files or
partitions.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/init.c       |   15 +++++++++++++++
 include/linux/swapfile.h |    2 ++
 mm/swapfile.c            |   46 ++++++++++++++++++++++++++++++----------------
 3 files changed, 47 insertions(+), 16 deletions(-)

--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -4,6 +4,8 @@
 #include <linux/swap.h>
 #include <linux/memblock.h>
 #include <linux/bootmem.h>	/* for max_low_pfn */
+#include <linux/swapfile.h>
+#include <linux/swapops.h>
 
 #include <asm/cacheflush.h>
 #include <asm/e820.h>
@@ -767,3 +769,16 @@ void update_cache_mode_entry(unsigned en
 	__cachemode2pte_tbl[cache] = __cm_idx2pte(entry);
 	__pte2cachemode_tbl[entry] = cache;
 }
+
+unsigned long max_swapfile_size(void)
+{
+	unsigned long pages;
+
+	pages = generic_max_swapfile_size();
+
+	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
+		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
+		pages = min_t(unsigned long, l1tf_pfn_limit() + 1, pages);
+	}
+	return pages;
+}
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,5 +9,7 @@ extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
 extern int try_to_unuse(unsigned int, bool, unsigned long);
+extern unsigned long generic_max_swapfile_size(void);
+extern unsigned long max_swapfile_size(void);
 
 #endif /* _LINUX_SWAPFILE_H */
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2206,6 +2206,35 @@ static int claim_swapfile(struct swap_in
 	return 0;
 }
 
+
+/*
+ * Find out how many pages are allowed for a single swap device. There
+ * are two limiting factors:
+ * 1) the number of bits for the swap offset in the swp_entry_t type, and
+ * 2) the number of bits in the swap pte, as defined by the different
+ * architectures.
+ *
+ * In order to find the largest possible bit mask, a swap entry with
+ * swap type 0 and swap offset ~0UL is created, encoded to a swap pte,
+ * decoded to a swp_entry_t again, and finally the swap offset is
+ * extracted.
+ *
+ * This will mask all the bits from the initial ~0UL mask that can't
+ * be encoded in either the swp_entry_t or the architecture definition
+ * of a swap pte.
+ */
+unsigned long generic_max_swapfile_size(void)
+{
+	return swp_offset(pte_to_swp_entry(
+			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
+}
+
+/* Can be overridden by an architecture for additional checks. */
+__weak unsigned long max_swapfile_size(void)
+{
+	return generic_max_swapfile_size();
+}
+
 static unsigned long read_swap_header(struct swap_info_struct *p,
 					union swap_header *swap_header,
 					struct inode *inode)
@@ -2241,22 +2270,7 @@ static unsigned long read_swap_header(st
 	p->cluster_next = 1;
 	p->cluster_nr = 0;
 
-	/*
-	 * Find out how many pages are allowed for a single swap
-	 * device. There are two limiting factors: 1) the number
-	 * of bits for the swap offset in the swp_entry_t type, and
-	 * 2) the number of bits in the swap pte as defined by the
-	 * different architectures. In order to find the
-	 * largest possible bit mask, a swap entry with swap type 0
-	 * and swap offset ~0UL is created, encoded to a swap pte,
-	 * decoded to a swp_entry_t again, and finally the swap
-	 * offset is extracted. This will mask all the bits from
-	 * the initial ~0UL mask that can't be encoded in either
-	 * the swp_entry_t or the architecture definition of a
-	 * swap pte.
-	 */
-	maxpages = swp_offset(pte_to_swp_entry(
-			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
+	maxpages = max_swapfile_size();
 	last_page = swap_header->info.last_page;
 	if (!last_page) {
 		pr_warn("Empty swap-file\n");


