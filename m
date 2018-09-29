Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE331C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A525206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A525206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeI3E1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:27:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51686 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728318AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N65-0000Gx-QJ; Sat, 29 Sep 2018 22:48:21 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006xT-1J; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andi Kleen" <ak@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.940336773@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 107/131] x86/speculation/l1tf: Limit swap file size
 to MAX_PA/2
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

From: Andi Kleen <ak@linux.intel.com>

commit 377eeaa8e11fe815b1d07c81c4a0e2843a8c15eb upstream.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
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
@@ -699,3 +701,15 @@ void __init zone_sizes_init(void)
 	free_area_init_nodes(max_zone_pfns);
 }
 
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
@@ -2166,6 +2166,35 @@ static int claim_swapfile(struct swap_in
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
@@ -2201,22 +2230,7 @@ static unsigned long read_swap_header(st
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
 	if (last_page > maxpages) {
 		pr_warn("Truncating oversized swap area, only using %luk out of %luk\n",

