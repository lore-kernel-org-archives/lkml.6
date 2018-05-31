Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeEaVQj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:16:39 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40358 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEaVQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:16:36 -0400
X-Google-Smtp-Source: ADUXVKKnQ5PPE7lGR2BYHTycxht+qW8Da8XGQbmNnIbVIWIgoKMn1XZFZRlbzacgIm7m3+D/bKUlcQ==
Date: Thu, 31 May 2018 14:16:34 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc patch] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <20180531063212.GF15278@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1805311400260.74563@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805241422070.182300@chino.kir.corp.google.com> <20180525072636.GE11881@dhcp22.suse.cz> <alpine.DEB.2.21.1805251227380.158701@chino.kir.corp.google.com> <20180528081345.GD1517@dhcp22.suse.cz> <alpine.DEB.2.21.1805301357100.150424@chino.kir.corp.google.com>
 <20180531063212.GF15278@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Michal Hocko wrote:

> > It's not a random timeout, it's sufficiently long such that we don't oom 
> > kill several processes needlessly in the very rare case where oom livelock 
> > would actually prevent the original victim from exiting.  The oom reaper 
> > processing an mm, finding everything to be mlocked, and immediately 
> > MMF_OOM_SKIP is inappropriate.  This is rather trivial to reproduce for a 
> > large memory hogging process that mlocks all of its memory; we 
> > consistently see spurious and unnecessary oom kills simply because the oom 
> > reaper has set MMF_OOM_SKIP very early.
> 
> It takes quite some additional steps for admin to allow a large amount
> of mlocked memory and such an application should be really careful to
> not consume too much memory. So how come this is something you see that
> consistently? Is this some sort of bug or an unfortunate workload side
> effect? I am asking this because I really want to see how relevant this
> really is.
> 

The bug is that the oom reaper sets MMF_OOM_SKIP almost immediately after 
the victim has been chosen for oom kill and we get follow-up oom kills, 
not that the process is able to mlock a large amount of memory.  Mlock 
here is only being discussed as a single example.  Tetsuo has brought up 
the example of all shared file-backed memory.  We've discussed the mm 
having a single blockable mmu notifier.  Regardless of how we arrive at 
the point where the oom reaper can't free memory, which could be any of 
those three cases, if (1) the original victim is sufficiently large that 
follow-up oom kills would become unnecessary and (2) other threads 
allocate/charge before the oom victim reaches exit_mmap(), this occurs.

We have examples of cases where oom reaping was successful, but the rss 
numbers in the kernel log are very similar to when it was oom killed and 
the process is known not to mlock, the reason is because the oom reaper 
could free very little memory due to blockable mmu notifiers.

> But the waiting periods just turn out to be a really poor design. There
> will be no good timeout to fit for everybody. We can do better and as
> long as this is the case the timeout based solution should be really
> rejected. It is a shortcut that doesn't really solve the underlying
> problem.
> 

The current implementation is a timeout based solution for mmap_sem, it 
just has the oom reaper spinning trying to grab the sem and eventually 
gives up.  This patch allows it to currently work on other mm's and 
detects the timeout in a different way, with jiffies instead of an 
iterator.

I'd love a solution where we can reliably detect an oom livelock and oom 
kill additional processes but only after the original victim has had a 
chance to do exit_mmap() without a timeout, but I don't see one being 
offered.  Given Tetsuo has seen issues with this in the past and suggested 
a similar proposal means we are not the only ones feeling pain from this.

> > I'm open to hearing any other suggestions that you have other than waiting 
> > some time period before MMF_OOM_SKIP gets set to solve this problem.
> 
> I've already offered one. Make mlocked pages reapable.

Making mlocked pages reapable would only solve the most trivial reproducer 
of this.  Unless the oom reaper can guarantee that it will never block and 
can free all memory that exit_mmap() can free, we need to ensure that a 
victim has a chance to reach the exit path on its own before killing every 
other process on the system.

I'll fix the issue I identified with doing list_add_tail() rather than 
list_add(), fix up the commit message per Tetsuo to identify the other 
possible ways this can occur other than mlock, remove the rfc tag, and 
repost.
