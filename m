Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A72150F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8A72150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbeHNUf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:35:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbeHNUf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:35:28 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C71A540B;
        Tue, 14 Aug 2018 17:47:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 30/43] mm: Add vm_insert_pfn_prot()
Date:   Tue, 14 Aug 2018 19:18:06 +0200
Message-Id: <20180814171519.080414264@linuxfoundation.org>
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

From: Andy Lutomirski <luto@kernel.org>

commit 1745cbc5d0dee0749a6bc0ea8e872c5db0074061 upstream

The x86 vvar vma contains pages with differing cacheability
flags.  x86 currently implements this by manually inserting all
the ptes using (io_)remap_pfn_range when the vma is set up.

x86 wants to move to using .fault with VM_FAULT_NOPAGE to set up
the mappings as needed.  The correct API to use to insert a pfn
in .fault is vm_insert_pfn(), but vm_insert_pfn() can't override the
vma's cache mode, and the HPET page in particular needs to be
uncached despite the fact that the rest of the VMA is cached.

Add vm_insert_pfn_prot() to support varying cacheability within
the same non-COW VMA in a more sane manner.

x86 could alternatively use multiple VMAs, but that's messy,
would break CRIU, and would create unnecessary VMAs that would
waste memory.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/d2938d1eb37be7a5e4f86182db646551f11e45aa.1451446564.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h |    2 ++
 mm/memory.c        |   25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2083,6 +2083,8 @@ int remap_pfn_range(struct vm_area_struc
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
+int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot);
 int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1605,8 +1605,29 @@ out:
 int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn)
 {
+	return vm_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(vm_insert_pfn);
+
+/**
+ * vm_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @pgprot: pgprot flags for the inserted page
+ *
+ * This is exactly like vm_insert_pfn, except that it allows drivers to
+ * to override pgprot on a per-page basis.
+ *
+ * This only makes sense for IO mappings, and it makes no sense for
+ * cow mappings.  In general, using multiple vmas is preferable;
+ * vm_insert_pfn_prot should only be used if using multiple VMAs is
+ * impractical.
+ */
+int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot)
+{
 	int ret;
-	pgprot_t pgprot = vma->vm_page_prot;
 	/*
 	 * Technically, architectures with pte_special can avoid all these
 	 * restrictions (same for remap_pfn_range).  However we would like
@@ -1628,7 +1649,7 @@ int vm_insert_pfn(struct vm_area_struct
 
 	return ret;
 }
-EXPORT_SYMBOL(vm_insert_pfn);
+EXPORT_SYMBOL(vm_insert_pfn_prot);
 
 int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn)


