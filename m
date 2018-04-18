Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeDRNoE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33847 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752714AbeDRNoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:44:03 -0400
Date: Wed, 18 Apr 2018 15:44:01 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rientjes@google.com, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
Message-ID: <20180418134401.GF17484@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1804171928040.100886@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1804171951440.105401@chino.kir.corp.google.com>
 <20180418075051.GO17484@dhcp22.suse.cz>
 <201804182049.EDJ21857.OHJOMOLFQVFFtS@I-love.SAKURA.ne.jp>
 <20180418115830.GA17484@dhcp22.suse.cz>
 <201804182225.EII57887.OLMHOFVtQSFJOF@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804182225.EII57887.OLMHOFVtQSFJOF@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-04-18 22:25:54, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > > > Can we try a simpler way and get back to what I was suggesting before
> > > > [1] and simply not play tricks with
> > > > 		down_write(&mm->mmap_sem);
> > > > 		up_write(&mm->mmap_sem);
> > > > 
> > > > and use the write lock in exit_mmap for oom_victims?
> > > 
> > > You mean something like this?
> > 
> > or simply hold the write lock until we unmap and free page tables.
> 
> That increases possibility of __oom_reap_task_mm() giving up reclaim and
> setting MMF_OOM_SKIP when exit_mmap() is making forward progress, doesn't it?

Yes it does. But it is not that likely and easily noticeable from the
logs so we can make the locking protocol more complex if this really
hits two often.

> I think that it is better that __oom_reap_task_mm() does not give up when
> exit_mmap() can make progress. In that aspect, the section protected by
> mmap_sem held for write should be as short as possible.

Sure, but then weight the complexity on the other side and try to think
whether simpler code which works most of the time is better than a buggy
complex one. The current protocol has 2 followup fixes which speaks for
itself.
 
[...]
> > > Then, I'm tempted to call __oom_reap_task_mm() before holding mmap_sem for write.
> > > It would be OK to call __oom_reap_task_mm() at the beginning of __mmput()...
> > 
> > I am not sure I understand.
> 
> To reduce possibility of __oom_reap_task_mm() giving up reclaim and
> setting MMF_OOM_SKIP.

Still do not understand. Do you want to call __oom_reap_task_mm from
__mmput? If yes why would you do so when exit_mmap does a stronger
version of it?

-- 
Michal Hocko
SUSE Labs
