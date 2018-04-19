Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeDSLE2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 07:04:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43993 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751882AbeDSLE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 07:04:27 -0400
Date: Thu, 19 Apr 2018 13:04:19 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rientjes@google.com, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
Message-ID: <20180419110419.GQ17484@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804181159020.227784@chino.kir.corp.google.com>
 <20180419063556.GK17484@dhcp22.suse.cz>
 <201804191945.BBF87517.FVMLOQFOHSFJOt@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804191945.BBF87517.FVMLOQFOHSFJOt@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-04-18 19:45:46, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > > exit_mmap() does not block before set_bit(MMF_OOM_SKIP) once it is 
> > > entered.
> > 
> > Not true. munlock_vma_pages_all might take page_lock which can have
> > unpredictable dependences. This is the reason why we are ruling out
> > mlocked VMAs in the first place when reaping the address space.
> 
> Wow! Then,
> 
> > While you are correct, strictly speaking, because unmap_vmas can race
> > with the oom reaper. With the lock held during the whole operation we
> > can indeed trigger back off in the oom_repaer. It will keep retrying but
> > the tear down can take quite some time. This is a fair argument. On the
> > other hand your lock protocol introduces the MMF_OOM_SKIP problem I've
> > mentioned above and that really worries me. The primary objective of the
> > reaper is to guarantee a forward progress without relying on any
> > externalities. We might kill another OOM victim but that is safer than
> > lock up.
> 
> current code has a possibility that the OOM reaper is disturbed by
> unpredictable dependencies, like I worried that
> 
>   I think that there is a possibility that the OOM reaper tries to reclaim
>   mlocked pages as soon as exit_mmap() cleared VM_LOCKED flag by calling
>   munlock_vma_pages_all().
> 
> when current approach was proposed. We currently have the MMF_OOM_SKIP problem.
> We need to teach the OOM reaper stop reaping as soon as entering exit_mmap().
> Maybe let the OOM reaper poll for progress (e.g. none of get_mm_counter(mm, *)
> decreased for last 1 second) ?

Can we start simple and build a more elaborate heuristics on top _please_?
In other words holding the mmap_sem for write for oom victims in
exit_mmap should handle the problem. We can then enhance this to probe
for progress or any other clever tricks if we find out that the race
happens too often and we kill more than necessary.

Let's not repeat the error of trying to be too clever from the beginning
as we did previously. This are is just too subtle and obviously error
prone.

-- 
Michal Hocko
SUSE Labs
