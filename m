Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAB0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA902083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA902083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeIGWgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:36:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726583AbeIGWgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25EF0807A0D0;
        Fri,  7 Sep 2018 17:54:41 +0000 (UTC)
Received: from redhat.com (ovpn-123-145.rdu2.redhat.com [10.10.123.145])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F8472027EA4;
        Fri,  7 Sep 2018 17:54:37 +0000 (UTC)
Date:   Fri, 7 Sep 2018 13:54:35 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugepage: mark splitted page dirty when needed
Message-ID: <20180907175434.GB3519@redhat.com>
References: <20180904075510.22338-1-peterx@redhat.com>
 <20180904080115.o2zj4mlo7yzjdqfl@kshutemo-mobl1>
 <D3B32B41-61D5-47B3-B1FC-77B0F71ADA47@cs.rutgers.edu>
 <20180905073037.GA23021@xz-x1>
 <20180905125522.x2puwfn5sr2zo3go@kshutemo-mobl1>
 <20180906113933.GG16937@xz-x1>
 <20180906140842.jzf7tluzocb5nv3f@kshutemo-mobl1>
 <20180907043524.GM16937@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907043524.GM16937@xz-x1>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 17:54:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 17:54:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:35:24PM +0800, Peter Xu wrote:
> On Thu, Sep 06, 2018 at 05:08:42PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Sep 06, 2018 at 07:39:33PM +0800, Peter Xu wrote:
> > > On Wed, Sep 05, 2018 at 03:55:22PM +0300, Kirill A. Shutemov wrote:
> > > > On Wed, Sep 05, 2018 at 03:30:37PM +0800, Peter Xu wrote:
> > > > > On Tue, Sep 04, 2018 at 10:00:28AM -0400, Zi Yan wrote:
> > > > > > On 4 Sep 2018, at 4:01, Kirill A. Shutemov wrote:
> > > > > > 
> > > > > > > On Tue, Sep 04, 2018 at 03:55:10PM +0800, Peter Xu wrote:
> > > > > > >> When splitting a huge page, we should set all small pages as dirty if
> > > > > > >> the original huge page has the dirty bit set before.  Otherwise we'll
> > > > > > >> lose the original dirty bit.
> > > > > > >
> > > > > > > We don't lose it. It got transfered to struct page flag:
> > > > > > >
> > > > > > > 	if (pmd_dirty(old_pmd))
> > > > > > > 		SetPageDirty(page);
> > > > > > >
> > > > > > 
> > > > > > Plus, when split_huge_page_to_list() splits a THP, its subroutine __split_huge_page()
> > > > > > propagates the dirty bit in the head page flag to all subpages in __split_huge_page_tail().
> > > > > 
> > > > > Hi, Kirill, Zi,
> > > > > 
> > > > > Thanks for your responses!
> > > > > 
> > > > > Though in my test the huge page seems to be splitted not by
> > > > > split_huge_page_to_list() but by explicit calls to
> > > > > change_protection().  The stack looks like this (again, this is a
> > > > > customized kernel, and I added an explicit dump_stack() there):
> > > > > 
> > > > >   kernel:  dump_stack+0x5c/0x7b
> > > > >   kernel:  __split_huge_pmd+0x192/0xdc0
> > > > >   kernel:  ? update_load_avg+0x8b/0x550
> > > > >   kernel:  ? update_load_avg+0x8b/0x550
> > > > >   kernel:  ? account_entity_enqueue+0xc5/0xf0
> > > > >   kernel:  ? enqueue_entity+0x112/0x650
> > > > >   kernel:  change_protection+0x3a2/0xab0
> > > > >   kernel:  mwriteprotect_range+0xdd/0x110
> > > > >   kernel:  userfaultfd_ioctl+0x50b/0x1210
> > > > >   kernel:  ? do_futex+0x2cf/0xb20
> > > > >   kernel:  ? tty_write+0x1d2/0x2f0
> > > > >   kernel:  ? do_vfs_ioctl+0x9f/0x610
> > > > >   kernel:  do_vfs_ioctl+0x9f/0x610
> > > > >   kernel:  ? __x64_sys_futex+0x88/0x180
> > > > >   kernel:  ksys_ioctl+0x70/0x80
> > > > >   kernel:  __x64_sys_ioctl+0x16/0x20
> > > > >   kernel:  do_syscall_64+0x55/0x150
> > > > >   kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > > 
> > > > > At the very time the userspace is sending an UFFDIO_WRITEPROTECT ioctl
> > > > > to kernel space, which is handled by mwriteprotect_range().  In case
> > > > > you'd like to refer to the kernel, it's basically this one from
> > > > > Andrea's (with very trivial changes):
> > > > > 
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git userfault
> > > > > 
> > > > > So... do we have two paths to split the huge pages separately?
> > > > 
> > > > We have two entiries that can be split: page table enties and underlying
> > > > compound page.
> > > > 
> > > > split_huge_pmd() (and variants of it) split the PMD entry into a PTE page
> > > > table. It doens't touch underlying compound page. The page still can be
> > > > mapped in other place as huge.
> > > > 
> > > > split_huge_page() (and ivariants of it) split compound page into a number
> > > > of 4k (or whatever PAGE_SIZE is). The operation requires splitting all
> > > > PMD, but not other way around.
> > > > 
> > > > > 
> > > > > Another (possibly very naive) question is: could any of you hint me
> > > > > how the page dirty bit is finally applied to the PTEs?  These two
> > > > > dirty flags confused me for a few days already (the SetPageDirty() one
> > > > > which sets the page dirty flag, and the pte_mkdirty() which sets that
> > > > > onto the real PTEs).
> > > > 
> > > > Dirty bit from page table entries transferes to sturct page flug and used
> > > > for decision making in reclaim path.
> > > 
> > > Thanks for explaining.  It's much clearer for me.
> > > 
> > > Though for the issue I have encountered, I am still confused on why
> > > that dirty bit can be ignored for the splitted PTEs.  Indeed we have:
> > > 
> > > 	if (pmd_dirty(old_pmd))
> > > 		SetPageDirty(page);
> > > 
> > > However to me this only transfers (as you explained above) the dirty
> > > bit (AFAIU it's possibly set by the hardware when the page is written)
> > > to the page struct of the compound page.  It did not really apply to
> > > every small page of the splitted huge page.  As you also explained,
> > > this __split_huge_pmd() only splits the PMD entry but it keeps the
> > > compound huge page there, then IMHO it should also apply the dirty
> > > bits from the huge page to all the small page entries, no?
> > 
> > The bit on compound page represents all small subpages. PageDirty() on any
> > subpage will return you true if the compound page is dirty.
> 
> Ah I didn't notice this before (since PageDirty is defined with
> PF_HEAD), thanks for pointing out.
> 
> > 
> > > These dirty bits are really important to my scenario since AFAIU the
> > > change_protection() call is using these dirty bits to decide whether
> > > it should append the WRITE bit - it finally corresponds to the lines
> > > in change_pte_range():
> > > 
> > >         /* Avoid taking write faults for known dirty pages */
> > >         if (dirty_accountable && pte_dirty(ptent) &&
> > >                         (pte_soft_dirty(ptent) ||
> > >                                 !(vma->vm_flags & VM_SOFTDIRTY))) {
> > >                 ptent = pte_mkwrite(ptent);
> > >         }
> > > 
> > > So when mprotect() with that range (my case is UFFDIO_WRITEPROTECT,
> > > which is similar) although we pass in the new protocol with VM_WRITE
> > > here it'll still mask it since the dirty bit is not set, then the
> > > userspace program (in my case, the QEMU thread that handles write
> > > protect failures) can never fixup the write-protected page fault.
> > 
> > I don't follow here.
> > 
> > The code you quoting above is an apportunistic optimization and should not
> > be mission-critical. The dirty and writable bits can go away as soon as
> > you drop page table lock for the page.
> 
> Indeed it's an optimization, IIUC it tries to avoid an extra but
> possibly useless write-protect page fault when the dirty bits are
> already set after all.  However that's a bit trickly here - in my use
> case the write-protect page faults will be handled by one of the QEMU
> thread that reads the userfaultfd handle, so the fault must be handled
> there instead of inside kernel otherwise there'll be nested page
> faults forever (and userfaultfd will detect that then send a SIGBUS
> instead).
> 
> I'll try to explain with some more details on how I understand what
> happened.  This should also answer Zi's question so I'll avoid
> replying twice there.  Please feel free to correct me.
> 
> Firstly, below should be the correct steps to handle a userspace write
> protect page fault using Andrea's userfault-wp tree (I only mentioned
> the page fault steps and ignored most of the irrelevant setup
> procedures):
> 
> 1. QEMU write-protects page P using UFFDIO_WRITEPROTECT ioctl, then
>    the write bit removed from PTE, so QEMU can capture any further
>    writes to the page
> 
>    ... (time passes)...

UFFDIO_WRITEPROTECT with UFFDIO_WRITEPROTECT_MODE_WP

> 
> 2. [vCPU thread] Guest writes to the page P, trigger wp page fault
> 
> 3. [vCPU thread] Since the page (and the whole vma) is tracked by
>    userfault-wp, it goes into handle_userfault() to notify userspace
>    about the page fault and waits...
> 
> 4. [userfault thread] Gets the message about the page fault, do
>    anything it like with the page P (mostly copy it somewhere), and
>    fixup the page fault by another UFFDIO_WRITEPROTECT ioctl, this
>    time to reset the write bit.  After that, it'll wake up the vCPU
>    thread

UFFDIO_WRITEPROTECT with !UFFDIO_WRITEPROTECT_MODE_WP

It confused me when looking at code:
https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=aa97daa6e54f2cfed1a6f1f38f9629608b8aadcc

> 
> 5. [vCPU thread] Got waked up, retry the page fault by returning a
>    VM_FAULT_RETRY in handle_userfault().  Then this time we'll see the
>    PTE with write bit set correctly.  vCPU continues execution.
> 
> Then let's consider THP here, where we might miss the dirty page for
> the PTE of the small page P.  In that case at step (4) when we want to
> recover the write bit we'll fail since the dirty bit is missing in the
> small PTE, so the write bit will still be cleared (expecting that the
> next page fault will fill it up).  However in step (5) we can't really
> fill in the write bit since we'll fault again into the
> handle_userfault() before that happens and then it goes back to step
> (3) then it can actualy loop forever if without the loop detection
> code in handle_userfault().
> 
> So I think now I understand that setting up the dirty bit in the
> compound page should be enough, then would below change acceptable
> instead?
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6d331620b9e5..0d4a8129a5e7 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -73,6 +73,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,                                                                             
>                 if (pte_present(oldpte)) {
>                         pte_t ptent;
>                         bool preserve_write = prot_numa && pte_write(oldpte);
> +                       bool dirty;
> 
>                         /*
>                          * Avoid trapping faults against the zero or KSM
> @@ -115,8 +116,18 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,                                                                          
>                         if (preserve_write)
>                                 ptent = pte_mk_savedwrite(ptent);
> 
> +                       /*
> +                        * The extra PageDirty() check will make sure
> +                        * we'll capture the dirty page even if the
> +                        * PTE dirty bit unset.  One case is when the
> +                        * PTE is splitted from a huge PMD, in that
> +                        * case the dirty flag might only be set on
> +                        * the compound page instead of this PTE.
> +                        */
> +                       dirty = pte_dirty(ptent) || PageDirty(pte_page(ptent));
> +
>                         /* Avoid taking write faults for known dirty pages */
> -                       if (dirty_accountable && pte_dirty(ptent) &&
> +                       if (dirty_accountable && dirty &&
>                                         (pte_soft_dirty(ptent) ||
>                                          !(vma->vm_flags & VM_SOFTDIRTY))) {
>                                 ptent = pte_mkwrite(ptent);
> 
> I tested that this change can also fix my problem (QEMU will not get
> SIGBUS after write protection starts).

This is wrong mwriteprotect_range() should already properly set pte
entry to non write protect:

https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=b16cb9fcb76bec59cbe1427e73246dc81a4942e2

	if (enable_wp)
		newprot = vm_get_page_prot(dst_vma->vm_flags & ~(VM_WRITE));
	else
		newprot = vm_get_page_prot(dst_vma->vm_flags);

So it seems that the vm_flags do not have VM_WRITE set.

To me this all points out so a bug somewhere in userspace or a miss use
of userfaultfd. Here is what i believe to be the chain of event:

  1 QEMU or vCPU write to the affected ufaultfd range and this set the pte
    dirty bit on all the entry in the affected range

  ...

  2 QEMU write protect the affected range with UFFDIO_WRITEPROTECT and
    UFFDIO_WRITEPROTECT_MODE_WP flag set. This clear the pte write bit
    and thus write protect the range. Because it is anonymous memory and
    soft dirty is likely disabled, the dirty bit set in 1 is still there
    and is preserved.

  3 vCPU tries to write to the affected range. This trigger a userfaultfd
    and QEMU handle it and call UFFDIO_WRITEPROTECT but this time without
    UFFDIO_WRITEPROTECT_MODE_WP flag (ie to unprotect).

    For some reasons the affected vma do not have the VM_WRITE flags set
    anymore probably through mprotect() syscall by QEMU. So that the new
    prot for the pte do not have the write bit set.

    But because of the change_pte_range() optimization and because the
    pte dirty bit is set from 1 then the pte write bit set which is wrong
    as the VM_WRITE have been clear.


So hence there is a bug in QEMU somewhere is my best guess.

Note that this means that the:
  https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=b16cb9fcb76bec59cbe1427e73246dc81a4942e2

Needs to be updated with:
-change_protection(dst_vma, start, start + len, newprot, !enable_wp, 0);
+change_protection(dst_vma, start, start + len, newprot, 0, 0);

To avoid such bug to creep in and have bad side effect like allowing
someone to unwrite protect a range of memory.

Cheers,
Jérôme
