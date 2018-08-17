Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A360C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F20121868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F20121868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeHQQnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:43:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbeHQQnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:43:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7F19ADB5;
        Fri, 17 Aug 2018 13:40:20 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, pasha.tatashin@oracle.com,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] x86/xen: enable early use of set_fixmap in 32-bit Xen PV guest
Date:   Fri, 17 Aug 2018 15:40:16 +0200
Message-Id: <20180817134016.19957-1-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7b25b9cb0dad83 ("x86/xen/time: Initialize pv xen time in
init_hypervisor_platform()") moved the mapping of the shared info area
before pagetable_init(). This breaks booting as 32-bit PV guest as the
use of set_fixmap isn't possible at this time on 32-bit.

This can be worked around by populating the needed PMD on 32-bit
kernel earlier.

In order not to reimplement populate_extra_pte() using extend_brk()
for allocating new page tables extend alloc_low_pages() to do that in
case the early page table pool is not yet available.

Fixes: 7b25b9cb0dad83
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/init.c          | 17 ++++++++++++-----
 arch/x86/xen/enlighten_pv.c |  2 ++
 arch/x86/xen/mmu_pv.c       |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index acfab322fbe0..5c32a7665492 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -99,15 +99,22 @@ __ref void *alloc_low_pages(unsigned int num)
 	}
 
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
-		unsigned long ret;
-		if (min_pfn_mapped >= max_pfn_mapped)
-			panic("alloc_low_pages: ran out of memory");
-		ret = memblock_find_in_range(min_pfn_mapped << PAGE_SHIFT,
+		unsigned long ret = 0;
+
+		if (min_pfn_mapped < max_pfn_mapped) {
+			ret = memblock_find_in_range(
+					min_pfn_mapped << PAGE_SHIFT,
 					max_pfn_mapped << PAGE_SHIFT,
 					PAGE_SIZE * num , PAGE_SIZE);
+		}
+		if (ret)
+			memblock_reserve(ret, PAGE_SIZE * num);
+		else if (can_use_brk_pgt)
+			ret = __pa(extend_brk(PAGE_SIZE * num, PAGE_SIZE));
+
 		if (!ret)
 			panic("alloc_low_pages: can not alloc memory");
-		memblock_reserve(ret, PAGE_SIZE * num);
+
 		pfn = ret >> PAGE_SHIFT;
 	} else {
 		pfn = pgt_buf_end;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index ee3b00c7acda..d7b2022ee301 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -122,6 +122,8 @@ static void __init xen_banner(void)
 
 static void __init xen_pv_init_platform(void)
 {
+	populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));
+
 	set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
 	HYPERVISOR_shared_info = (void *)fix_to_virt(FIX_PARAVIRT_BOOTMAP);
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 52206ad81e4b..9e7012858420 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2171,6 +2171,8 @@ void __init xen_relocate_p2m(void)
 #else	/* !CONFIG_X86_64 */
 static RESERVE_BRK_ARRAY(pmd_t, initial_kernel_pmd, PTRS_PER_PMD);
 static RESERVE_BRK_ARRAY(pmd_t, swapper_kernel_pmd, PTRS_PER_PMD);
+RESERVE_BRK(fixup_kernel_pmd, PAGE_SIZE);
+RESERVE_BRK(fixup_kernel_pte, PAGE_SIZE);
 
 static void __init xen_write_cr3_init(unsigned long cr3)
 {
-- 
2.13.7

