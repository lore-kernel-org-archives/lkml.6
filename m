Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753672AbeDRL6f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:58:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:55245 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752116AbeDRL6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:58:33 -0400
Date: Wed, 18 Apr 2018 13:58:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rientjes@google.com, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
Message-ID: <20180418115830.GA17484@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1804171545460.53786@chino.kir.corp.google.com>
 <201804180057.w3I0vieV034949@www262.sakura.ne.jp>
 <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz>
 <201804182049.EDJ21857.OHJOMOLFQVFFtS@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804182049.EDJ21857.OHJOMOLFQVFFtS@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 20:49:11, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > On Tue 17-04-18 19:52:41, David Rientjes wrote:
> > > Since exit_mmap() is done without the protection of mm->mmap_sem, it is
> > > possible for the oom reaper to concurrently operate on an mm until
> > > MMF_OOM_SKIP is set.
> > > 
> > > This allows munlock_vma_pages_all() to concurrently run while the oom
> > > reaper is operating on a vma.  Since munlock_vma_pages_range() depends on
> > > clearing VM_LOCKED from vm_flags before actually doing the munlock to
> > > determine if any other vmas are locking the same memory, the check for
> > > VM_LOCKED in the oom reaper is racy.
> > > 
> > > This is especially noticeable on architectures such as powerpc where
> > > clearing a huge pmd requires serialize_against_pte_lookup().  If the pmd
> > > is zapped by the oom reaper during follow_page_mask() after the check for
> > > pmd_none() is bypassed, this ends up deferencing a NULL ptl.
> > > 
> > > Fix this by reusing MMF_UNSTABLE to specify that an mm should not be
> > > reaped.  This prevents the concurrent munlock_vma_pages_range() and
> > > unmap_page_range().  The oom reaper will simply not operate on an mm that
> > > has the bit set and leave the unmapping to exit_mmap().
> > 
> > This will further complicate the protocol and actually theoretically
> > restores the oom lockup issues because the oom reaper doesn't set
> > MMF_OOM_SKIP when racing with exit_mmap so we fully rely that nothing
> > blocks there... So the resulting code is more fragile and tricky.
> > 
> > Can we try a simpler way and get back to what I was suggesting before
> > [1] and simply not play tricks with
> > 		down_write(&mm->mmap_sem);
> > 		up_write(&mm->mmap_sem);
> > 
> > and use the write lock in exit_mmap for oom_victims?
> 
> You mean something like this?

or simply hold the write lock until we unmap and free page tables.
It would make the locking rules much more straightforward.
What you are proposing is more focused on this particular fix and it
would work as well but the subtle locking would still stay in place.
I am not sure we want the trickiness.

> Then, I'm tempted to call __oom_reap_task_mm() before holding mmap_sem for write.
> It would be OK to call __oom_reap_task_mm() at the beginning of __mmput()...

I am not sure I understand.

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 188f195..ba7083b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3011,17 +3011,22 @@ void exit_mmap(struct mm_struct *mm)
>  	struct mmu_gather tlb;
>  	struct vm_area_struct *vma;
>  	unsigned long nr_accounted = 0;
> +	const bool is_oom_mm = mm_is_oom_victim(mm);
>  
>  	/* mm's last user has gone, and its about to be pulled down */
>  	mmu_notifier_release(mm);
>  
>  	if (mm->locked_vm) {
> +		if (is_oom_mm)
> +			down_write(&mm->mmap_sem);
>  		vma = mm->mmap;
>  		while (vma) {
>  			if (vma->vm_flags & VM_LOCKED)
>  				munlock_vma_pages_all(vma);
>  			vma = vma->vm_next;
>  		}
> +		if (is_oom_mm)
> +			up_write(&mm->mmap_sem);
>  	}
>  
>  	arch_exit_mmap(mm);
> @@ -3037,7 +3042,7 @@ void exit_mmap(struct mm_struct *mm)
>  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
>  	unmap_vmas(&tlb, vma, 0, -1);
>  
> -	if (unlikely(mm_is_oom_victim(mm))) {
> +	if (unlikely(is_oom_mm)) {
>  		/*
>  		 * Wait for oom_reap_task() to stop working on this
>  		 * mm. Because MMF_OOM_SKIP is already set before

-- 
Michal Hocko
SUSE Labs
