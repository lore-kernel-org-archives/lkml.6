Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeDVDpP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 23:45:15 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37630 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeDVDpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 23:45:14 -0400
X-Google-Smtp-Source: AIpwx49UPSZ22KQGYbfeqACUOGGQh1GRsY4wtzSEy/hGCu0naD9LKfkz3T19L69VbE1eUdhxAf97XQ==
Date: Sat, 21 Apr 2018 20:45:11 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper
 unmap
In-Reply-To: <20180420082349.GW17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1804212023120.84222@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1804171545460.53786@chino.kir.corp.google.com> <201804180057.w3I0vieV034949@www262.sakura.ne.jp> <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com> <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com> <20180419063556.GK17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com> <20180420082349.GW17484@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018, Michal Hocko wrote:

> > The solution is certainly not to hold 
> > down_write(&mm->mmap_sem) during munlock_vma_pages_all() instead.
> 
> Why not? This is what we do for normal paths. exit path just tries to be
> clever because it knows that it doesn't have to lock because there is no
> concurent user. At least it wasn't until the oom reaper came. So I
> really fail to see why we shouldn't do the most obvious thing and use
> the locking.
> 

Because the oom reaper uses the ability to acquire mm->mmap_sem as a 
heuristic to determine when to give up and allow another process to be 
chosen.

If the heuristics of the oom reaper are to be improved, that's great, but 
this patch fixes the oops on powerpc as 4.17 material and as a stable 
backport.  It's also well tested.

> > If 
> > exit_mmap() is not making forward progress then that's a separate issue; 
> 
> Please read what I wrote. There is a page lock and there is no way to
> guarantee it will make a forward progress. Or do you consider that not
> true?
> 

I don't have any evidence of it, and since this is called before 
exit_mmap() sets MMF_OOM_SKIP then the oom reaper would need to set the 
bit itself and I would be able to find the artifact it leaves behind in 
the kernel log.  I cannot find a single instance of a thread stuck in 
munlock by way of exit_mmap() that causes the oom reaper to have to set 
the bit itself, and I should be able to if this were a problem.

> > Holding down_write on 
> > mm->mmap_sem otherwise needlessly over a large amount of code is riskier 
> > (hasn't been done or tested here), more error prone (any code change over 
> > this large area of code or in functions it calls are unnecessarily 
> > burdened by unnecessary locking), makes exit_mmap() less extensible for 
> > the same reason,
> 
> I do not see any of the calls in that path could suffer from holding
> mmap_sem. Do you?
> 
> > and causes the oom reaper to give up and go set 
> > MMF_OOM_SKIP itself because it depends on taking down_read while the 
> > thread is still exiting.
> 
> Which is the standard backoff mechanism.
> 

The reason today's locking methodology is preferred is because of the 
backoff mechanism.  Your patch kills many processes unnecessarily if the 
oom killer selects a large process to kill, which it specifically tries to 
do, because unmap_vmas() and free_pgtables() takes a very long time, 
sometimes tens of seconds.
