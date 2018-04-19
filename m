Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbeDSTe5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:34:57 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33343 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeDSTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:34:55 -0400
X-Google-Smtp-Source: AIpwx4/0y+qmJkShSdnOCTF66V6ENEOe04/+UzIL1Bss/7nCci93IWV3rlYkiTT6ehYPGhRfzoRH0w==
Date: Thu, 19 Apr 2018 12:34:53 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper
 unmap
In-Reply-To: <20180419063556.GK17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1804171545460.53786@chino.kir.corp.google.com> <201804180057.w3I0vieV034949@www262.sakura.ne.jp> <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com> <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com> <20180419063556.GK17484@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018, Michal Hocko wrote:

> > exit_mmap() does not block before set_bit(MMF_OOM_SKIP) once it is 
> > entered.
> 
> Not true. munlock_vma_pages_all might take page_lock which can have
> unpredictable dependences. This is the reason why we are ruling out
> mlocked VMAs in the first place when reaping the address space.
> 

I don't find any occurrences in millions of oom kills in real-world 
scenarios where this matters.  The solution is certainly not to hold 
down_write(&mm->mmap_sem) during munlock_vma_pages_all() instead.  If 
exit_mmap() is not making forward progress then that's a separate issue; 
that would need to be fixed in one of two ways: (1) in oom_reap_task() to 
try over a longer duration before setting MMF_OOM_SKIP itself, but that 
would have to be a long duration to allow a large unmap and page table 
free, or (2) in oom_evaluate_task() so that we defer for MMF_OOM_SKIP but 
only if MMF_UNSTABLE has been set for a long period of time so we target 
another process when the oom killer has given up.

Either of those two fixes are simple to implement, I'd just like to see a 
bug report with stack traces to indicate that a victim getting stalled in 
exit_mmap() is a problem to justify the patch.

I'm trying to fix the page table corruption that is trivial to trigger on 
powerpc.  We simply cannot allow the oom reaper's unmap_page_range() to 
race with munlock_vma_pages_range(), ever.  Holding down_write on 
mm->mmap_sem otherwise needlessly over a large amount of code is riskier 
(hasn't been done or tested here), more error prone (any code change over 
this large area of code or in functions it calls are unnecessarily 
burdened by unnecessary locking), makes exit_mmap() less extensible for 
the same reason, and causes the oom reaper to give up and go set 
MMF_OOM_SKIP itself because it depends on taking down_read while the 
thread is still exiting.

> On the
> other hand your lock protocol introduces the MMF_OOM_SKIP problem I've
> mentioned above and that really worries me. The primary objective of the
> reaper is to guarantee a forward progress without relying on any
> externalities. We might kill another OOM victim but that is safer than
> lock up.
> 

I understand the concern, but it's the difference between the victim 
getting stuck in exit_mmap() and actually taking a long time to free its 
memory in exit_mmap().  I don't have evidence of the former.  If there are 
bug reports for occurrences of the oom reaper being unable to reap, it 
would be helpful to see.  The only reports about the "unable to reap" 
message was that the message itself was racy, not that a thread got stuck.  
This is more reason to not take down_write unnecessarily in the 
exit_mmap() path, because it influences an oom reaper heurstic.

> The current protocol has proven to be error prone so I really believe we
> should back off and turn it into something much simpler and build on top
> of that if needed.
> 
> So do you see any _technical_ reasons why not do [1] and have a simpler
> protocol easily backportable to stable trees?

It's not simpler per the above, and I agree with Andrea's assessment when 
this was originally implemented.  The current method is not error prone, 
it works, it just wasn't protecting enough of exit_mmap().  That's not a 
critcism of the method itself, it's a bugfix that expands its critical 
section.  
