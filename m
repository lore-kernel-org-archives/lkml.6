Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A634C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078842087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078842087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeI3E0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51729 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728386AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000H9-4u; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wu-Ob; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Quentin Casasnovas" <quentin.casasnovas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.154488040@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 100/131] mm: Add vm_insert_pfn_prot()
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

From: Andy Lutomirski <luto@kernel.org>

commit 1745cbc5d0dee0749a6bc0ea8e872c5db0074061 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 25 +++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1965,6 +1965,8 @@ int remap_pfn_range(struct vm_area_struc
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
@@ -1574,8 +1574,29 @@ out:
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
@@ -1597,7 +1618,7 @@ int vm_insert_pfn(struct vm_area_struct
 
 	return ret;
 }
-EXPORT_SYMBOL(vm_insert_pfn);
+EXPORT_SYMBOL(vm_insert_pfn_prot);
 
 int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn)

