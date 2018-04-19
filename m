Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753655AbeDSWNU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:13:20 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36889 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeDSWNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:13:19 -0400
To: rientjes@google.com, mhocko@kernel.org
Cc: akpm@linux-foundation.org, aarcange@redhat.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
        <20180418075051.GO17484@dhcp22.suse.cz>
        <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
        <20180419063556.GK17484@dhcp22.suse.cz>
        <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
Message-Id: <201804200713.IJF15701.SOVFOMHtQJOFFL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 20 Apr 2018 07:13:02 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Thu, 19 Apr 2018, Michal Hocko wrote:
> 
> > > exit_mmap() does not block before set_bit(MMF_OOM_SKIP) once it is 
> > > entered.
> > 
> > Not true. munlock_vma_pages_all might take page_lock which can have
> > unpredictable dependences. This is the reason why we are ruling out
> > mlocked VMAs in the first place when reaping the address space.
> > 
> 
> I don't find any occurrences in millions of oom kills in real-world 
> scenarios where this matters.

Is your OOM events system-wide rather than memcg?
It is trivial to hide bugs in the details if your OOM events is memcg OOM.

>                                The solution is certainly not to hold 
> down_write(&mm->mmap_sem) during munlock_vma_pages_all() instead.  If 
> exit_mmap() is not making forward progress then that's a separate issue; 

Just a simple memory + CPU pressure is sufficient for making exit_mmap()
unable to make forward progress. Try triggering system-wide OOM event by
running below reproducer. We are ever ignoring this issue.

-----
#include <unistd.h>

int main(int argc, char *argv[])
{
        while (1)
                if (fork() == 0)
                        execlp(argv[0], argv[0], NULL);
        return 0;
}
-----

> that would need to be fixed in one of two ways: (1) in oom_reap_task() to 
> try over a longer duration before setting MMF_OOM_SKIP itself, but that 
> would have to be a long duration to allow a large unmap and page table 
> free, or (2) in oom_evaluate_task() so that we defer for MMF_OOM_SKIP but 
> only if MMF_UNSTABLE has been set for a long period of time so we target 
> another process when the oom killer has given up.
> 
> Either of those two fixes are simple to implement, I'd just like to see a 
> bug report with stack traces to indicate that a victim getting stalled in 
> exit_mmap() is a problem to justify the patch.

It is too hard for normal users to report problems under memory pressure
without a mean to help understand what is happening. See a bug report at
https://lists.opensuse.org/opensuse-kernel/2018-04/msg00018.html for example.

> 
> I'm trying to fix the page table corruption that is trivial to trigger on 
> powerpc.  We simply cannot allow the oom reaper's unmap_page_range() to 
> race with munlock_vma_pages_range(), ever.  Holding down_write on 
> mm->mmap_sem otherwise needlessly over a large amount of code is riskier 
> (hasn't been done or tested here), more error prone (any code change over 
> this large area of code or in functions it calls are unnecessarily 
> burdened by unnecessary locking), makes exit_mmap() less extensible for 
> the same reason, and causes the oom reaper to give up and go set 
> MMF_OOM_SKIP itself because it depends on taking down_read while the 
> thread is still exiting.

I suggest reverting 212925802454 ("mm: oom: let oom_reap_task and exit_mmap
run concurrently"). We can check for progress for a while before setting
MMF_OOM_SKIP after the OOM reaper completed or gave up reaping.
