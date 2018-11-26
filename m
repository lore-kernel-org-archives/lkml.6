Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD23C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952A821104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1TDatplh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952A821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbeKZVy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbeKZVy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9830020817;
        Mon, 26 Nov 2018 11:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230041;
        bh=LaPX98p5/0BH2YUXG3GhbBtnEJxJtz+LXuSWxuS5utA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TDatplh135vEVjeNXDAlWwnvG48TTh7lpafocdWzVdqqBHSpkId2Vfh/8pwf2sbb
         7VzdelQu4ggjUzPF7Ra5wPkLk50CxfnKq1jgDMyVdQzV2uvQA2GqaklXDEQiCxHu1w
         mAAX8j36pP5CzCGcfw2Ok0eX+YUvwqRJ1+h6kyUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        bhe@redhat.com, willy@infradead.org, linux-mm@kvack.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 49/62] x86/ldt: Unmap PTEs for the slot before freeing LDT pages
Date:   Mon, 26 Nov 2018 11:51:30 +0100
Message-Id: <20181126105054.440503950@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit a0e6e0831c516860fc7f9be1db6c081fe902ebcf upstream

modify_ldt(2) leaves the old LDT mapped after switching over to the new
one. The old LDT gets freed and the pages can be re-used.

Leaving the mapping in place can have security implications. The mapping is
present in the userspace page tables and Meltdown-like attacks can read
these freed and possibly reused pages.

It's relatively simple to fix: unmap the old LDT and flush TLB before
freeing the old LDT memory.

This further allows to avoid flushing the TLB in map_ldt_struct() as the
slot is unmapped and flushed by unmap_ldt_struct() or has never been mapped
at all.

[ tglx: Massaged changelog and removed the needless line breaks ]

Fixes: f55f0501cbf6 ("x86/pti: Put the LDT in its own PGD if PTI is on")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: bhe@redhat.com
Cc: willy@infradead.org
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181026122856.66224-3-kirill.shutemov@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/ldt.c | 49 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 26d713ecad34..65df298d4e9e 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -103,14 +103,6 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
- *
- * There is no corresponding unmap function.  Even if the LDT is freed, we
- * leave the PTEs around until the slot is reused or the mm is destroyed.
- * This is harmless: the LDT is always in ordinary memory, and no one will
- * access the freed slot.
- *
- * If we wanted to unmap freed LDTs, we'd also need to do a flush to make
- * it useful, and the flush would slow down modify_ldt().
  */
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
@@ -119,8 +111,8 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	bool is_vmalloc, had_top_level_entry;
 	unsigned long va;
 	spinlock_t *ptl;
+	int i, nr_pages;
 	pgd_t *pgd;
-	int i;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return 0;
@@ -141,7 +133,9 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
-	for (i = 0; i * PAGE_SIZE < ldt->nr_entries * LDT_ENTRY_SIZE; i++) {
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
 		unsigned long offset = i << PAGE_SHIFT;
 		const void *src = (char *)ldt->entries + offset;
 		unsigned long pfn;
@@ -189,14 +183,42 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		}
 	}
 
-	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0);
-
 	ldt->slot = slot;
 #endif
 	return 0;
 }
 
+static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
+{
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	unsigned long va;
+	int i, nr_pages;
+
+	if (!ldt)
+		return;
+
+	/* LDT map/unmap is only required for PTI */
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long offset = i << PAGE_SHIFT;
+		spinlock_t *ptl;
+		pte_t *ptep;
+
+		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
+		ptep = get_locked_pte(mm, va, &ptl);
+		pte_clear(mm, va, ptep);
+		pte_unmap_unlock(ptep, ptl);
+	}
+
+	va = (unsigned long)ldt_slot_va(ldt->slot);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, 0);
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+}
+
 static void free_ldt_pgtables(struct mm_struct *mm)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
@@ -433,6 +455,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 	}
 
 	install_ldt(mm, new_ldt);
+	unmap_ldt_struct(mm, old_ldt);
 	free_ldt_struct(old_ldt);
 	error = 0;
 
-- 
2.17.1



