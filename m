Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeDREsj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 00:48:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53379 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDREsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 00:48:38 -0400
Message-Id: <201804180447.w3I4lq60017956@www262.sakura.ne.jp>
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Andrea Arcangeli <aarcange@redhat.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date: Wed, 18 Apr 2018 13:47:52 +0900
References: <201804180355.w3I3tM6T001187@www262.sakura.ne.jp> <alpine.DEB.2.21.1804172103050.113086@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1804172103050.113086@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Wed, 18 Apr 2018, Tetsuo Handa wrote:
> > > Fix this by reusing MMF_UNSTABLE to specify that an mm should not be
> > > reaped.  This prevents the concurrent munlock_vma_pages_range() and
> > > unmap_page_range().  The oom reaper will simply not operate on an mm that
> > > has the bit set and leave the unmapping to exit_mmap().
> > 
> > This change assumes that munlock_vma_pages_all()/unmap_vmas()/free_pgtables()
> > are never blocked for memory allocation. Is that guaranteed? For example,
> > i_mmap_lock_write() from unmap_single_vma() from unmap_vmas() is never blocked
> > for memory allocation? Commit 97b1255cb27c551d ("mm,oom_reaper: check for
> > MMF_OOM_SKIP before complaining") was waiting for i_mmap_lock_write() from
> > unlink_file_vma() from free_pgtables(). Is it really guaranteed that somebody
> > else who is holding that lock is never waiting for memory allocation?
> > 
> 
> Commit 97b1255cb27c is referencing MMF_OOM_SKIP already being set by 
> exit_mmap().  The only thing this patch changes is where that is done: 
> before or after free_pgtables().  We can certainly move it to before 
> free_pgtables() at the risk of subsequent (and eventually unnecessary) oom 
> kills.  It's not exactly the point of this patch.
> 
> I have thousands of real-world examples where additional processes were 
> oom killed while the original victim was in free_pgtables().  That's why 
> we've moved the MMF_OOM_SKIP to after free_pgtables().

"we have moved"? No, not yet. Your patch is about to move it.

My question is: is it guaranteed that munlock_vma_pages_all()/unmap_vmas()/free_pgtables()
by exit_mmap() are never blocked for memory allocation. Note that exit_mmap() tries to unmap
all pages while the OOM reaper tries to unmap only safe pages. If there is possibility that
munlock_vma_pages_all()/unmap_vmas()/free_pgtables() by exit_mmap() are blocked for memory
allocation, your patch will introduce an OOM livelock.

>                                                         I'm not sure how 
> likely your scenario is in the real world, but if it poses a problem then 
> I believe it should be fixed by eventually deferring previous victims as a 
> change to oom_evaluate_task(), not exit_mmap().  If you'd like me to fix 
> that, please send along your test case that triggers it and I will send a 
> patch.
> 
