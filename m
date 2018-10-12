Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A59D21473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 07:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A59D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJLPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:00:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbeJLPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:00:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34C35AF84;
        Fri, 12 Oct 2018 07:29:13 +0000 (UTC)
Subject: Re: [PATCH] mm: Speed up mremap on large regions
To:     Jann Horn <jannh@google.com>
Cc:     joel@joelfernandes.org, kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kernel-team@android.com,
        Minchan Kim <minchan@google.com>,
        Hugh Dickins <hughd@google.com>, lokeshgidra@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        pombredanne@nexb.com, Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <CAG48ez3yLkMcyaTXFt_+w8_-HtmrjW=XB51DDQSGdjPj43XWmA@mail.gmail.com>
 <42b81ac4-35de-754e-545b-d57b3bab3b7a@suse.com>
 <CAG48ez1=RAvrTyWyWcxANBM+Sf7qDoScaA_hvebxp1qh0WzcYg@mail.gmail.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2c540b83-9125-8cae-9aab-3c8b37d7e914@suse.com>
Date:   Fri, 12 Oct 2018 09:29:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez1=RAvrTyWyWcxANBM+Sf7qDoScaA_hvebxp1qh0WzcYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 07:34, Jann Horn wrote:
> On Fri, Oct 12, 2018 at 7:29 AM Juergen Gross <jgross@suse.com> wrote:
>> On 12/10/2018 05:21, Jann Horn wrote:
>>> +cc xen maintainers and kvm folks
>>>
>>> On Fri, Oct 12, 2018 at 4:40 AM Joel Fernandes (Google)
>>> <joel@joelfernandes.org> wrote:
>>>> Android needs to mremap large regions of memory during memory management
>>>> related operations. The mremap system call can be really slow if THP is
>>>> not enabled. The bottleneck is move_page_tables, which is copying each
>>>> pte at a time, and can be really slow across a large map. Turning on THP
>>>> may not be a viable option, and is not for us. This patch speeds up the
>>>> performance for non-THP system by copying at the PMD level when possible.
>>> [...]
>>>> +bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>>> +                 unsigned long new_addr, unsigned long old_end,
>>>> +                 pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
>>>> +{
>>> [...]
>>>> +       /*
>>>> +        * We don't have to worry about the ordering of src and dst
>>>> +        * ptlocks because exclusive mmap_sem prevents deadlock.
>>>> +        */
>>>> +       old_ptl = pmd_lock(vma->vm_mm, old_pmd);
>>>> +       if (old_ptl) {
>>>> +               pmd_t pmd;
>>>> +
>>>> +               new_ptl = pmd_lockptr(mm, new_pmd);
>>>> +               if (new_ptl != old_ptl)
>>>> +                       spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>>> +
>>>> +               /* Clear the pmd */
>>>> +               pmd = *old_pmd;
>>>> +               pmd_clear(old_pmd);
>>>> +
>>>> +               VM_BUG_ON(!pmd_none(*new_pmd));
>>>> +
>>>> +               /* Set the new pmd */
>>>> +               set_pmd_at(mm, new_addr, new_pmd, pmd);
>>>> +               if (new_ptl != old_ptl)
>>>> +                       spin_unlock(new_ptl);
>>>> +               spin_unlock(old_ptl);
>>>
>>> How does this interact with Xen PV? From a quick look at the Xen PV
>>> integration code in xen_alloc_ptpage(), it looks to me as if, in a
>>> config that doesn't use split ptlocks, this is going to temporarily
>>> drop Xen's type count for the page to zero, causing Xen to de-validate
>>> and then re-validate the L1 pagetable; if you first set the new pmd
>>> before clearing the old one, that wouldn't happen. I don't know how
>>> this interacts with shadow paging implementations.
>>
>> No, this isn't an issue. As the L1 pagetable isn't being released it
>> will stay pinned, so there will be no need to revalidate it.
> 
> Where exactly is the L1 pagetable pinned? xen_alloc_ptpage() does:
> 
>         if (static_branch_likely(&xen_struct_pages_ready))
>             SetPagePinned(page);

This marking the pagetable as to be pinned, in order to pin it via

xen_activate_mm()
  xen_pgd_pin()
    __xen_pgd_pin()
      __xen_pgd_walk()
        xen_pin_page()
          xen_do_pin()

> 
>         if (!PageHighMem(page)) {
>             xen_mc_batch();
> 
>             __set_pfn_prot(pfn, PAGE_KERNEL_RO);
> 
>             if (level == PT_PTE && USE_SPLIT_PTE_PTLOCKS)
>                 __pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE, pfn);
> 
>             xen_mc_issue(PARAVIRT_LAZY_MMU);
>         } else {
>             /* make sure there are no stray mappings of
>                this page */
>             kmap_flush_unused();
>         }
> 
> which means that if USE_SPLIT_PTE_PTLOCKS is false, the table doesn't
> get pinned and only stays typed as long as it is referenced by an L2
> table, right?

In case the pagetable has been allocated since activation of the
address space it seems indeed not to be pinned yet. IMO this is not
meant to be that way, but probably most kernel configs for 32-bit
PV guests have NR_CPUS > 4, so they do use split ptlocks.

In fact this seems to be a bug as at deactivation of the address
space the kernel will try to unpin the pagetable and the hypervisor
would issue a warning if it has been built with debug messages
enabled. Same applies to suspend()/resume() cycles.


Juergen
