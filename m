Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD64C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F9221848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219061;
	bh=sL27qDBXpdMClx4vlWMvVCPWP+xP0FVw1IYbAL6O5Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ygZnrjtFA11FAE0mH8696OyypkfiL6fyiWgqA9cWAjWXHU9bCFJXNR2JEDbg7tKq
	 nkpYepjkYPeLvaLDzE/TfRwmfZIJVtS70LofSbEMv3rjeA44yCgfauJrJg7WRDaZ8n
	 GGL1OQX5n8y1k9XZ39zOPhnQbU8syYWAE/IfBfDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391866AbfAKPET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:04:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388975AbfAKOae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568CF2063F;
        Fri, 11 Jan 2019 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217034;
        bh=sL27qDBXpdMClx4vlWMvVCPWP+xP0FVw1IYbAL6O5Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v+LPO2IW7D1o1PnBkiJ/KWA6zcLnpSovgHfmV6QJtsEVCWzafvvoygdYvzivOhZTF
         XCKu7kqUSe5QsL8MUKAf0bRhdnGiTihauphYFRPGYGdgV3oO7k3rLlG4duuw8109P4
         3ZoetcOKIA3li/TAbVxGRbshWwxw2hH/qvD7Tf+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, bhe@redhat.com, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 018/105] x86/mm: Fix guard hole handling
Date:   Fri, 11 Jan 2019 15:13:49 +0100
Message-Id: <20190111131104.761109114@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 16877a5570e0c5f4270d5b17f9bab427bcae9514 ]

There is a guard hole at the beginning of the kernel address space, also
used by hypervisors. It occupies 16 PGD entries.

This reserved range is not defined explicitely, it is calculated relative
to other entities: direct mapping and user space ranges.

The calculation got broken by recent changes of the kernel memory layout:
LDT remap range is now mapped before direct mapping and makes the
calculation invalid.

The breakage leads to crash on Xen dom0 boot[1].

Define the reserved range explicitely. It's part of kernel ABI (hypervisors
expect it to be stable) and must not depend on changes in the rest of
kernel memory layout.

[1] https://lists.xenproject.org/archives/html/xen-devel/2018-11/msg03313.html

Fixes: d52888aa2753 ("x86/mm: Move LDT remap out of KASLR region on 5-level paging")
Reported-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: bhe@redhat.com
Cc: linux-mm@kvack.org
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20181130202328.65359-2-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h |  5 +++++
 arch/x86/mm/dump_pagetables.c           |  8 ++++----
 arch/x86/xen/mmu_pv.c                   | 11 ++++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 7764617b8f9c..bf6d2692fc60 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -94,6 +94,11 @@ typedef struct { pteval_t pte; } pte_t;
 # define __VMEMMAP_BASE		_AC(0xffffea0000000000, UL)
 #endif
 
+#define GUARD_HOLE_PGD_ENTRY	-256UL
+#define GUARD_HOLE_SIZE		(16UL << PGDIR_SHIFT)
+#define GUARD_HOLE_BASE_ADDR	(GUARD_HOLE_PGD_ENTRY << PGDIR_SHIFT)
+#define GUARD_HOLE_END_ADDR	(GUARD_HOLE_BASE_ADDR + GUARD_HOLE_SIZE)
+
 #define LDT_PGD_ENTRY		-240UL
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2a4849e92831..cf403e057f3f 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -465,11 +465,11 @@ static inline bool is_hypervisor_range(int idx)
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
index b33fa127a613..7631e6130d44 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -614,19 +614,20 @@ static int __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
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
2.19.1



