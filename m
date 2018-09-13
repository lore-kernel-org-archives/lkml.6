Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7ECC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DB120869
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DB120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIMTdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeIMTdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C4C3307D85F;
        Thu, 13 Sep 2018 14:23:36 +0000 (UTC)
Received: from redhat.com (ovpn-123-149.rdu2.redhat.com [10.10.123.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 71D122AA9F;
        Thu, 13 Sep 2018 14:23:30 +0000 (UTC)
Date:   Thu, 13 Sep 2018 10:23:29 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Henry Willard <henry.willard@oracle.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: mprotect: check page dirty when change ptes
Message-ID: <20180913142328.GA3576@redhat.com>
References: <20180912064921.31015-1-peterx@redhat.com>
 <20180912130355.GA4009@redhat.com>
 <20180912132438.GB4009@redhat.com>
 <20180913073722.GF10763@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913073722.GF10763@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Sep 2018 14:23:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:37:22PM +0800, Peter Xu wrote:
> On Wed, Sep 12, 2018 at 09:24:39AM -0400, Jerome Glisse wrote:
> > On Wed, Sep 12, 2018 at 09:03:55AM -0400, Jerome Glisse wrote:
> > > On Wed, Sep 12, 2018 at 02:49:21PM +0800, Peter Xu wrote:
> > > > Add an extra check on page dirty bit in change_pte_range() since there
> > > > might be case where PTE dirty bit is unset but it's actually dirtied.
> > > > One example is when a huge PMD is splitted after written: the dirty bit
> > > > will be set on the compound page however we won't have the dirty bit set
> > > > on each of the small page PTEs.
> > > > 
> > > > I noticed this when debugging with a customized kernel that implemented
> > > > userfaultfd write-protect.  In that case, the dirty bit will be critical
> > > > since that's required for userspace to handle the write protect page
> > > > fault (otherwise it'll get a SIGBUS with a loop of page faults).
> > > > However it should still be good even for upstream Linux to cover more
> > > > scenarios where we shouldn't need to do extra page faults on the small
> > > > pages if the previous huge page is already written, so the dirty bit
> > > > optimization path underneath can cover more.
> > > > 
> > > 
> > > So as said by Kirill NAK you are not looking at the right place for
> > > your bug please first apply the below patch and read my analysis in
> > > my last reply.
> > 
> > Just to be clear you are trying to fix a userspace bug that is hidden
> > for non THP pages by a kernel space bug inside userfaultfd by making
> > the kernel space bug of userfaultfd buggy for THP too.
> > 
> > 
> > > 
> > > Below patch fix userfaultfd bug. I am not posting it as it is on a
> > > branch and i am not sure when Andrea plan to post. Andrea feel free
> > > to squash that fix.
> > > 
> > > 
> > > From 35cdb30afa86424c2b9f23c0982afa6731be961c Mon Sep 17 00:00:00 2001
> > > From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
> > > Date: Wed, 12 Sep 2018 08:58:33 -0400
> > > Subject: [PATCH] userfaultfd: do not set dirty accountable when changing
> > >  protection
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> > > 
> > > mwriteprotect_range() has nothing to do with the dirty accountable
> > > optimization so do not set it as it opens a door for userspace to
> > > unwrite protect pages in a range that is write protected ie the vma
> > > !(vm_flags & VM_WRITE).
> > > 
> > > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > > ---
> > >  mm/userfaultfd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index a0379c5ffa7c..59db1ce48fa0 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -632,7 +632,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
> > >  		newprot = vm_get_page_prot(dst_vma->vm_flags);
> > >  
> > >  	change_protection(dst_vma, start, start + len, newprot,
> > > -				!enable_wp, 0);
> > > +				false, 0);
> > >  
> > >  	err = 0;
> > >  out_unlock:
> 
> Hi, Jerome,
> 
> I tried your patch, unluckily it didn't work just like when not
> applied:
> 
> Sep 13 15:16:52 px-ws kernel: FAULT_FLAG_ALLOW_RETRY missing 71
> Sep 13 15:16:52 px-ws kernel: CPU: 5 PID: 1625 Comm: qemu-system-x86 Not tainted 4.19.0-rc2+ #31                                                                            
> Sep 13 15:16:52 px-ws kernel: Hardware name: LENOVO ThinkCentre M8500t-N000/SHARKBAY, BIOS FBKTC6AUS 06/22/2016                                                             
> Sep 13 15:16:52 px-ws kernel: Call Trace:
> Sep 13 15:16:52 px-ws kernel:  dump_stack+0x5c/0x7b
> Sep 13 15:16:52 px-ws kernel:  handle_userfault+0x4b5/0x780
> Sep 13 15:16:52 px-ws kernel:  ? userfaultfd_ctx_put+0xb0/0xb0
> Sep 13 15:16:52 px-ws kernel:  do_wp_page+0x1bd/0x5a0
> Sep 13 15:16:52 px-ws kernel:  __handle_mm_fault+0x7f9/0x1250
> Sep 13 15:16:52 px-ws kernel:  handle_mm_fault+0xfc/0x1f0
> Sep 13 15:16:52 px-ws kernel:  __do_page_fault+0x255/0x520
> Sep 13 15:16:52 px-ws kernel:  do_page_fault+0x32/0x110
> Sep 13 15:16:52 px-ws kernel:  ? page_fault+0x8/0x30
> Sep 13 15:16:52 px-ws kernel:  page_fault+0x1e/0x30
> Sep 13 15:16:52 px-ws kernel: RIP: 0033:0x7f2a9d3254e0
> Sep 13 15:16:52 px-ws kernel: Code: 73 01 c1 ef 07 48 81 e6 00 f0 ff ff 81 e7 e0 1f 00 00 49 8d bc 3e 40 57 00 00 48 3b 37 48 8b f3 0f 85 a4 01 00 00 48 03 77 10 <66> 89 06f
> Sep 13 15:16:52 px-ws kernel: RSP: 002b:00007f2ab1aae390 EFLAGS: 00010202
> Sep 13 15:16:52 px-ws kernel: RAX: 0000000000000246 RBX: 0000000000001ff2 RCX: 0000000000000031                                                                             
> Sep 13 15:16:52 px-ws kernel: RDX: ffffffffffac9604 RSI: 00007f2a53e01ff2 RDI: 000055a98fa049c0                                                                             
> Sep 13 15:16:52 px-ws kernel: RBP: 0000000000001ff4 R08: 0000000000000000 R09: 0000000000000002                                                                             
> Sep 13 15:16:52 px-ws kernel: R10: 0000000000000000 R11: 00007f2a98201030 R12: 0000000000001ff2                                                                             
> Sep 13 15:16:52 px-ws kernel: R13: 0000000000000000 R14: 000055a98f9ff260 R15: 00007f2ab1aaf700                                                                             
> 
> In case you'd like to try, here's the QEMU binary I'm testing:
> 
> https://github.com/xzpeter/qemu/tree/peter-userfault-wp-test
> 
> It write protects the whole system when received HMP command "info
> status" (I hacked that command for simplicity; it's of course not used
> for that...).
> 
> Would you please help me understand how your patch could resolve the
> wp page fault from userspace if not with dirty_accountable set in the
> uffd-wp world (sorry for asking a question that is related to a custom
> tree, but finally it'll be targeted at upstream after all)? I asked
> this question in my previous reply to you in v1 but you didn't
> respond.  I'd be glad to test any of your further patches if you can
> help solve the problem, but I'd also appreciate if you could explain
> it a bit on how it work since again I didn't see why it could work:
> again, if without that dirty_accountable set then IMO we will never
> setup _PAGE_WRITE for page entries and IMHO that's needed for
> resolving the page fault for uffd-wp tree.

I missed that reply and forgot about PAGE_COPY ... So below is
what i believe a proper fix for your issue:


From 4362d8a3bb44b756209a44f1342e1c568ad6c3e6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Date: Thu, 13 Sep 2018 10:16:30 -0400
Subject: [PATCH] mm/mprotect: add a mkwrite paramater to change_protection()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mkwrite parameter allow to change read only pte to write one which
is needed by userfaultfd to un-write-protect after a fault have been
handled.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
---
 include/linux/huge_mm.h |  2 +-
 include/linux/mm.h      |  3 ++-
 mm/huge_memory.c        |  5 ++++-
 mm/mempolicy.c          |  2 +-
 mm/mprotect.c           | 37 +++++++++++++++++++++----------------
 mm/userfaultfd.c        |  2 +-
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a8a126259bc4..b51ff7f8e65c 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -45,7 +45,7 @@ extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 			 pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush);
 extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, pgprot_t newprot,
-			int prot_numa);
+			int prot_numa, bool mkwrite);
 int vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmd, pfn_t pfn, bool write);
 int vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5d5c7fd07dc0..2bbf3e33bf9e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1492,7 +1492,8 @@ extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		bool need_rmap_locks);
 extern unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 			      unsigned long end, pgprot_t newprot,
-			      int dirty_accountable, int prot_numa);
+			      int dirty_accountable, int prot_numa,
+			      bool mkwrite);
 extern int mprotect_fixup(struct vm_area_struct *vma,
 			  struct vm_area_struct **pprev, unsigned long start,
 			  unsigned long end, unsigned long newflags);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abf621aba672..49853f0b1570 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1842,7 +1842,8 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
  *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
  */
 int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, pgprot_t newprot, int prot_numa)
+		unsigned long addr, pgprot_t newprot, int prot_numa,
+		bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	spinlock_t *ptl;
@@ -1925,6 +1926,8 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	entry = pmd_modify(entry, newprot);
 	if (preserve_write)
 		entry = pmd_mk_savedwrite(entry);
+	if (mkwrite)
+		entry = pmd_mkwrite(entry);
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 	BUG_ON(vma_is_anonymous(vma) && !preserve_write && pmd_write(entry));
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ce44d3ff03d..2d0ee09e6b26 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -579,7 +579,7 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 {
 	int nr_updated;
 
-	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1);
+	nr_updated = change_protection(vma, addr, end, PAGE_NONE, 0, 1, false);
 	if (nr_updated)
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 58b629bb70de..792669cfb7e1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -36,7 +36,7 @@
 
 static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		int dirty_accountable, int prot_numa, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, oldpte;
@@ -102,9 +102,9 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				ptent = pte_mk_savedwrite(ptent);
 
 			/* Avoid taking write faults for known dirty pages */
-			if (dirty_accountable && pte_dirty(ptent) &&
-					(pte_soft_dirty(ptent) ||
-					 !(vma->vm_flags & VM_SOFTDIRTY))) {
+			if (enable_write || (dirty_accountable &&
+			    pte_dirty(ptent) && (pte_soft_dirty(ptent) ||
+			    !(vma->vm_flags & VM_SOFTDIRTY)))) {
 				ptent = pte_mkwrite(ptent);
 			}
 			ptep_modify_prot_commit(mm, addr, pte, ptent);
@@ -150,7 +150,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		pud_t *pud, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, int dirty_accountable, int prot_numa,
+		bool mkwrite)
 {
 	pmd_t *pmd;
 	struct mm_struct *mm = vma->vm_mm;
@@ -179,7 +180,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
-						newprot, prot_numa);
+						newprot, prot_numa, mkwrite);
 
 				if (nr_ptes) {
 					if (nr_ptes == HPAGE_PMD_NR) {
@@ -194,7 +195,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			/* fall through, the trans huge pmd just split */
 		}
 		this_pages = change_pte_range(vma, pmd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+				 dirty_accountable, prot_numa, mkwrite);
 		pages += this_pages;
 next:
 		cond_resched();
@@ -210,7 +211,8 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		p4d_t *p4d, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, int dirty_accountable, int prot_numa,
+		bool mkwrite)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -222,7 +224,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+				 dirty_accountable, prot_numa, mkwrite);
 	} while (pud++, addr = next, addr != end);
 
 	return pages;
@@ -230,7 +232,8 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 
 static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		pgd_t *pgd, unsigned long addr, unsigned long end,
-		pgprot_t newprot, int dirty_accountable, int prot_numa)
+		pgprot_t newprot, int dirty_accountable, int prot_numa,
+		bool mkwrite)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -242,7 +245,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+				 dirty_accountable, prot_numa, mkwrite);
 	} while (p4d++, addr = next, addr != end);
 
 	return pages;
@@ -250,7 +253,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 
 static unsigned long change_protection_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
-		int dirty_accountable, int prot_numa)
+		int dirty_accountable, int prot_numa, mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
@@ -267,7 +270,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
-				 dirty_accountable, prot_numa);
+				 dirty_accountable, prot_numa, mkwrite);
 	} while (pgd++, addr = next, addr != end);
 
 	/* Only flush the TLB if we actually modified any entries: */
@@ -280,14 +283,16 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 
 unsigned long change_protection(struct vm_area_struct *vma, unsigned long start,
 		       unsigned long end, pgprot_t newprot,
-		       int dirty_accountable, int prot_numa)
+		       int dirty_accountable, int prot_numa, bool mkwrite)
 {
 	unsigned long pages;
 
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot);
 	else
-		pages = change_protection_range(vma, start, end, newprot, dirty_accountable, prot_numa);
+		pages = change_protection_range(vma, start, end, newprot,
+						dirty_accountable,
+						prot_numa, mkwrite);
 
 	return pages;
 }
@@ -366,7 +371,7 @@ mprotect_fixup(struct vm_area_struct *vma, struct vm_area_struct **pprev,
 	vma_set_page_prot(vma);
 
 	change_protection(vma, start, end, vma->vm_page_prot,
-			  dirty_accountable, 0);
+			  dirty_accountable, 0, false);
 
 	/*
 	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index a0379c5ffa7c..c745c5d87523 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -632,7 +632,7 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 		newprot = vm_get_page_prot(dst_vma->vm_flags);
 
 	change_protection(dst_vma, start, start + len, newprot,
-				!enable_wp, 0);
+			  0, 0, !enable_wp);
 
 	err = 0;
 out_unlock:
-- 
2.17.1

