Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B646C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3009E20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3009E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeLAHeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:34:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:34085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeLAHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:34:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 12:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,299,1539673200"; 
   d="scan'208";a="100197235"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2018 12:23:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 815F814F; Fri, 30 Nov 2018 22:23:45 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com, bhe@redhat.com,
        hans.van.kranenburg@mendix.com, x86@kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 1/2] x86/mm: Fix guard hole handling
Date:   Fri, 30 Nov 2018 23:23:27 +0300
Message-Id: <20181130202328.65359-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130202328.65359-1-kirill.shutemov@linux.intel.com>
References: <20181130202328.65359-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a guard hole at the beginning of kernel address space, also
used by hypervisors. It occupies 16 PGD entries.

We do not state the reserved range directly, but calculate it relative
to other entities: direct mapping and user space ranges.

The calculation got broken by recent change in kernel memory layout: LDT
remap range is now mapped before direct mapping and makes the calculation
invalid.

The breakage leads to crash on Xen dom0 boot[1].

State the reserved range directly. It's part of kernel ABI (hypervisors
expect it to be stable) and must not depend on changes in the rest of
kernel memory layout.

[1] https://lists.xenproject.org/archives/html/xen-devel/2018-11/msg03313.html

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Tested-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Fixes: d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable_64_types.h |  5 +++++
 arch/x86/mm/dump_pagetables.c           |  8 ++++----
 arch/x86/xen/mmu_pv.c                   | 11 ++++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 84bd9bdc1987..88bca456da99 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -111,6 +111,11 @@ extern unsigned int ptrs_per_p4d;
  */
 #define MAXMEM			(1UL << MAX_PHYSMEM_BITS)
 
+#define GUARD_HOLE_PGD_ENTRY	-256UL
+#define GUARD_HOLE_SIZE		(16UL << PGDIR_SHIFT)
+#define GUARD_HOLE_BASE_ADDR	(GUARD_HOLE_PGD_ENTRY << PGDIR_SHIFT)
+#define GUARD_HOLE_END_ADDR	(GUARD_HOLE_BASE_ADDR + GUARD_HOLE_SIZE)
+
 #define LDT_PGD_ENTRY		-240UL
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 #define LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index fc37bbd23eb8..dad153e5a427 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -512,11 +512,11 @@ static inline bool is_hypervisor_range(int idx)
 {
 #ifdef CONFIG_X86_64
 	/*
-	 * ffff800000000000 - ffff87ffffffffff is reserved for
-	 * the hypervisor.
+	 * A hole in the beginning of kernel address space reserved
+	 * for a hypervisor.
 	 */
-	return	(idx >= pgd_index(__PAGE_OFFSET) - 16) &&
-		(idx <  pgd_index(__PAGE_OFFSET));
+	return	(idx >= pgd_index(GUARD_HOLE_BASE_ADDR)) &&
+		(idx <  pgd_index(GUARD_HOLE_END_ADDR));
 #else
 	return false;
 #endif
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a5d7ed125337..0f4fe206dcc2 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -648,19 +648,20 @@ static int __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
 			  unsigned long limit)
 {
 	int i, nr, flush = 0;
-	unsigned hole_low, hole_high;
+	unsigned hole_low = 0, hole_high = 0;
 
 	/* The limit is the last byte to be touched */
 	limit--;
 	BUG_ON(limit >= FIXADDR_TOP);
 
+#ifdef CONFIG_X86_64
 	/*
 	 * 64-bit has a great big hole in the middle of the address
-	 * space, which contains the Xen mappings.  On 32-bit these
-	 * will end up making a zero-sized hole and so is a no-op.
+	 * space, which contains the Xen mappings.
 	 */
-	hole_low = pgd_index(USER_LIMIT);
-	hole_high = pgd_index(PAGE_OFFSET);
+	hole_low = pgd_index(GUARD_HOLE_BASE_ADDR);
+	hole_high = pgd_index(GUARD_HOLE_END_ADDR);
+#endif
 
 	nr = pgd_index(limit) + 1;
 	for (i = 0; i < nr; i++) {
-- 
2.19.2

