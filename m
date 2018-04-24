Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeDXXPD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 19:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750791AbeDXXO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 19:14:59 -0400
Date: Tue, 24 Apr 2018 17:14:55 -0600
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaperunmap
Message-ID: <20180424231455.GZ17484@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1804212019400.84222@chino.kir.corp.google.com>
 <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1804231706340.18716@chino.kir.corp.google.com>
 <20180424130432.GB17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804241256000.231037@chino.kir.corp.google.com>
 <20180424201352.GV17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804241317200.231037@chino.kir.corp.google.com>
 <20180424203148.GW17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804241359280.186801@chino.kir.corp.google.com>
 <20180424230815.GX17484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424230815.GX17484@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-04-18 17:08:15, Michal Hocko wrote:
> On Tue 24-04-18 14:07:52, David Rientjes wrote:
> > On Tue, 24 Apr 2018, Michal Hocko wrote:
> > 
> > > > > > My patch has passed intensive testing on both x86 and powerpc, so I'll ask 
> > > > > > that it's pushed for 4.17-rc3.  Many thanks to Tetsuo for the suggestion 
> > > > > > on calling __oom_reap_task_mm() from exit_mmap().
> > > > > 
> > > > > Yeah, but your patch does have a problem with blockable mmu notifiers
> > > > > IIUC.
> > > > 
> > > > What on earth are you talking about?  exit_mmap() does 
> > > > mmu_notifier_release().  There are no blockable mmu notifiers.
> > > 
> > > MMF_OOM_SKIP - remember? The thing that guarantees a forward progress.
> > > So we cannot really depend on setting MMF_OOM_SKIP if a
> > > mmu_notifier_release blocks for an excessive/unbounded amount of time.
> > > 
> > 
> > If the thread is blocked in exit_mmap() because of mmu_notifier_release() 
> > then the oom reaper will eventually grab mm->mmap_sem (nothing holding it 
> > in exit_mmap()), return true, and oom_reap_task() will set MMF_OOM_SKIP.  
> > This is unchanged with the patch and is a completely separate issue.
> 
> I must be missing something or we are talking past each other.

Ohh. Ok, so _I_ was missing that mm_has_notifiers is false after
mmu_notifier_release. So we cannot block at that time. Then we are good.
Sorry about the confusion!
-- 
Michal Hocko
SUSE Labs
