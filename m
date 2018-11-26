Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36197C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFAE21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrmoTuWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFAE21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeKZV6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC44E2089F;
        Mon, 26 Nov 2018 11:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230284;
        bh=nDWsQK38MjPwn5v29HCwsoPb4koAcJiV97GXH+ZcMZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HrmoTuWNtLR8QrN1dl50KeGoFmiPUq+XucQFqzfLkbTCqIJjTmamJYTXQpYAel/fX
         wnZe3lq1JbfQS/AsyH79V2E0xVGqUmjZUKok9h5CtZV8e1hakCSgRN19VdM0VO+mLA
         PSY6oqzwp+LAjwMTVEJ+PpjxCI1/52QP9Crj6fCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li Wang <liwang@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/118] s390/mm: fix mis-accounting of pgtable_bytes
Date:   Mon, 26 Nov 2018 11:50:38 +0100
Message-Id: <20181126105102.565639804@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e12e4044aede97974f2222eb7f0ed726a5179a32 ]

In case a fork or a clone system fails in copy_process and the error
handling does the mmput() at the bad_fork_cleanup_mm label, the
following warning messages will appear on the console:

  BUG: non-zero pgtables_bytes on freeing mm: 16384

The reason for that is the tricks we play with mm_inc_nr_puds() and
mm_inc_nr_pmds() in init_new_context().

A normal 64-bit process has 3 levels of page table, the p4d level and
the pud level are folded. On process termination the free_pud_range()
function in mm/memory.c will subtract 16KB from pgtable_bytes with a
mm_dec_nr_puds() call, but there actually is not really a pud table.

One issue with this is the fact that pgtable_bytes is usually off
by a few kilobytes, but the more severe problem is that for a failed
fork or clone the free_pgtables() function is not called. In this case
there is no mm_dec_nr_puds() or mm_dec_nr_pmds() that go together with
the mm_inc_nr_puds() and mm_inc_nr_pmds in init_new_context().
The pgtable_bytes will be off by 16384 or 32768 bytes and we get the
BUG message. The message itself is purely cosmetic, but annoying.

To fix this override the mm_pmd_folded, mm_pud_folded and mm_p4d_folded
function to check for the true size of the address space.

Reported-by: Li Wang <liwang@redhat.com>
Tested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/mmu_context.h |  5 -----
 arch/s390/include/asm/pgalloc.h     |  6 +++---
 arch/s390/include/asm/pgtable.h     | 18 ++++++++++++++++++
 arch/s390/include/asm/tlb.h         |  6 +++---
 arch/s390/mm/pgalloc.c              |  1 +
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 0717ee76885d..f1ab9420ccfb 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -45,8 +45,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.asce_limit = STACK_TOP_MAX;
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
-		/* pgd_alloc() did not account this pud */
-		mm_inc_nr_puds(mm);
 		break;
 	case -PAGE_SIZE:
 		/* forked 5-level task, set new asce with new_mm->pgd */
@@ -62,9 +60,6 @@ static inline int init_new_context(struct task_struct *tsk,
 		/* forked 2-level compat task, set new asce with new mm->pgd */
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
-		/* pgd_alloc() did not account this pmd */
-		mm_inc_nr_pmds(mm);
-		mm_inc_nr_puds(mm);
 	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index f0f9bcf94c03..5ee733720a57 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -36,11 +36,11 @@ static inline void crst_table_init(unsigned long *crst, unsigned long entry)
 
 static inline unsigned long pgd_entry_type(struct mm_struct *mm)
 {
-	if (mm->context.asce_limit <= _REGION3_SIZE)
+	if (mm_pmd_folded(mm))
 		return _SEGMENT_ENTRY_EMPTY;
-	if (mm->context.asce_limit <= _REGION2_SIZE)
+	if (mm_pud_folded(mm))
 		return _REGION3_ENTRY_EMPTY;
-	if (mm->context.asce_limit <= _REGION1_SIZE)
+	if (mm_p4d_folded(mm))
 		return _REGION2_ENTRY_EMPTY;
 	return _REGION1_ENTRY_EMPTY;
 }
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 0e7cb0dc9c33..de05466ce50c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -485,6 +485,24 @@ static inline int is_module_addr(void *addr)
 				   _REGION_ENTRY_PROTECT | \
 				   _REGION_ENTRY_NOEXEC)
 
+static inline bool mm_p4d_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION1_SIZE;
+}
+#define mm_p4d_folded(mm) mm_p4d_folded(mm)
+
+static inline bool mm_pud_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION2_SIZE;
+}
+#define mm_pud_folded(mm) mm_pud_folded(mm)
+
+static inline bool mm_pmd_folded(struct mm_struct *mm)
+{
+	return mm->context.asce_limit <= _REGION3_SIZE;
+}
+#define mm_pmd_folded(mm) mm_pmd_folded(mm)
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index 457b7ba0fbb6..b31c779cf581 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -136,7 +136,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
+	if (mm_pmd_folded(tlb->mm))
 		return;
 	pgtable_pmd_page_dtor(virt_to_page(pmd));
 	tlb_remove_table(tlb, pmd);
@@ -152,7 +152,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
+	if (mm_p4d_folded(tlb->mm))
 		return;
 	tlb_remove_table(tlb, p4d);
 }
@@ -167,7 +167,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long address)
 {
-	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
+	if (mm_pud_folded(tlb->mm))
 		return;
 	tlb_remove_table(tlb, pud);
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 76d89ee8b428..814f26520aa2 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -101,6 +101,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 			mm->context.asce_limit = _REGION1_SIZE;
 			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+			mm_inc_nr_puds(mm);
 		} else {
 			crst_table_init(table, _REGION1_ENTRY_EMPTY);
 			pgd_populate(mm, (pgd_t *) table, (p4d_t *) pgd);
-- 
2.17.1



