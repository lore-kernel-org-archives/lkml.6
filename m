Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDRTOc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 15:14:32 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:33871 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeDRTOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 15:14:31 -0400
X-Google-Smtp-Source: AIpwx497Kxk8sl/8SE5xM+V7hPkufMBs14d3tEoH8MEIQw/rLrs9Kx3N8J7VS4YqG/OhI6LY36dYqw==
Date: Wed, 18 Apr 2018 12:14:29 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper
 unmap
In-Reply-To: <20180418075051.GO17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1804171545460.53786@chino.kir.corp.google.com> <201804180057.w3I0vieV034949@www262.sakura.ne.jp> <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com> <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2018, Michal Hocko wrote:

> > Since exit_mmap() is done without the protection of mm->mmap_sem, it is
> > possible for the oom reaper to concurrently operate on an mm until
> > MMF_OOM_SKIP is set.
> > 
> > This allows munlock_vma_pages_all() to concurrently run while the oom
> > reaper is operating on a vma.  Since munlock_vma_pages_range() depends on
> > clearing VM_LOCKED from vm_flags before actually doing the munlock to
> > determine if any other vmas are locking the same memory, the check for
> > VM_LOCKED in the oom reaper is racy.
> > 
> > This is especially noticeable on architectures such as powerpc where
> > clearing a huge pmd requires serialize_against_pte_lookup().  If the pmd
> > is zapped by the oom reaper during follow_page_mask() after the check for
> > pmd_none() is bypassed, this ends up deferencing a NULL ptl.
> > 
> > Fix this by reusing MMF_UNSTABLE to specify that an mm should not be
> > reaped.  This prevents the concurrent munlock_vma_pages_range() and
> > unmap_page_range().  The oom reaper will simply not operate on an mm that
> > has the bit set and leave the unmapping to exit_mmap().
> 
> This will further complicate the protocol and actually theoretically
> restores the oom lockup issues because the oom reaper doesn't set
> MMF_OOM_SKIP when racing with exit_mmap so we fully rely that nothing
> blocks there... So the resulting code is more fragile and tricky.
> 

exit_mmap() does not block before set_bit(MMF_OOM_SKIP) once it is 
entered.

> Can we try a simpler way and get back to what I was suggesting before
> [1] and simply not play tricks with
> 		down_write(&mm->mmap_sem);
> 		up_write(&mm->mmap_sem);
> 
> and use the write lock in exit_mmap for oom_victims?
> 
> Andrea wanted to make this more clever but this is the second fallout
> which could have been prevented. The patch would be smaller and the
> locking protocol easier
> 
> [1] http://lkml.kernel.org/r/20170727065023.GB20970@dhcp22.suse.cz
> 

exit_mmap() doesn't need to protect munlock, unmap, or freeing pgtables 
with mm->mmap_sem; the issue is that you need to start holding it in this 
case before munlock and then until at least the end of free_pgtables().  
Anything in between also needlessly holds it so could introduce weird 
lockdep issues that only trigger for oom victims, i.e. they could be very 
rare on some configs.  I don't necessarily like holding a mutex over 
functions where it's actually not needed, not only as a general principle 
but also because the oom reaper can now infer that reaping isn't possible 
just because it can't do down_read() and isn't aware the thread is 
actually in exit_mmap() needlessly holding it.

I like how the oom reaper currently retries on failing to grab 
mm->mmap_sem and then backs out because it's assumed it can't make forward 
progress.  Adding additional complication for situations where 
mm->mmap_sem is contended (and munlock to free_pgtables() can take a long 
time for certain processes) to check if it's actually already in 
exit_mmap() would seem more complicated than this.

The patch is simply using MMF_UNSTABLE rather than MMF_OOM_SKIP to 
serialize exit_mmap() with the oom reaper and doing it before anything 
interesting in exit_mmap() because without it the munlock can trivially 
race with unmap_page_range() and cause a NULL pointer or #GP on a pmd or 
pte.  The way Andrea implemented it is fine, we simply have revealed a 
race between munlock_vma_pages_all() and unmap_page_range() that needs it 
to do set_bit(); down_write(); up_write(); earlier.
