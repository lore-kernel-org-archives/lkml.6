Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeDXV61 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:58:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62845 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:58:25 -0400
To: rientjes@google.com
Cc: mhocko@kernel.org, akpm@linux-foundation.org, aarcange@redhat.com,
        guro@fb.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaper unmap
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp>
        <alpine.DEB.2.21.1804231706340.18716@chino.kir.corp.google.com>
        <201804240511.w3O5BY4o090598@www262.sakura.ne.jp>
        <alpine.DEB.2.21.1804232231020.82340@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1804232231020.82340@chino.kir.corp.google.com>
Message-Id: <201804250657.GFI21363.StOJHOQFOMFVFL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 25 Apr 2018 06:57:59 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Tue, 24 Apr 2018, Tetsuo Handa wrote:
> 
> > > > We can call __oom_reap_task_mm() from exit_mmap() (or __mmput()) before
> > > > exit_mmap() holds mmap_sem for write. Then, at least memory which could
> > > > have been reclaimed if exit_mmap() did not hold mmap_sem for write will
> > > > be guaranteed to be reclaimed before MMF_OOM_SKIP is set.
> > > > 
> > > 
> > > I think that's an exceptionally good idea and will mitigate the concerns 
> > > of others.
> > > 
> > > It can be done without holding mm->mmap_sem in exit_mmap() and uses the 
> > > same criteria that the oom reaper uses to set MMF_OOM_SKIP itself, so we 
> > > don't get dozens of unnecessary oom kills.
> > > 
> > > What do you think about this?  It passes preliminary testing on powerpc 
> > > and I'm enqueued it for much more intensive testing.  (I'm wishing there 
> > > was a better way to acknowledge your contribution to fixing this issue, 
> > > especially since you brought up the exact problem this is addressing in 
> > > previous emails.)
> > > 
> > 
> > I don't think this patch is safe, for exit_mmap() is calling
> > mmu_notifier_invalidate_range_{start,end}() which might block with oom_lock
> > held when oom_reap_task_mm() is waiting for oom_lock held by exit_mmap().
> 
> One of the reasons that I extracted __oom_reap_task_mm() out of the new 
> oom_reap_task_mm() is to avoid the checks that would be unnecessary when 
> called from exit_mmap().  In this case, we can ignore the 
> mm_has_blockable_invalidate_notifiers() check because exit_mmap() has 
> already done mmu_notifier_release().  So I don't think there's a concern 
> about __oom_reap_task_mm() blocking while holding oom_lock.  Unless you 
> are referring to something else?

Oh, mmu_notifier_release() made mm_has_blockable_invalidate_notifiers() == false. OK.

But I want comments why it is safe; I will probably miss that dependency
when we move that code next time.
