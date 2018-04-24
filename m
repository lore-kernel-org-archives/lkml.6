Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeDXVIB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:08:01 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35002 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeDXVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:07:54 -0400
X-Google-Smtp-Source: AIpwx4+MlHRKHpc0BMRufZLglBsqrXG+ferlInuO8n3X7Yc3800UT4vK5FEun3WM9a28n9+etVHYKg==
Date: Tue, 24 Apr 2018 14:07:52 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrea Arcangeli <aarcange@redhat.com>, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: fix concurrent munlock and oom reaperunmap
In-Reply-To: <20180424203148.GW17484@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1804241359280.186801@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1804191214130.157851@chino.kir.corp.google.com> <20180420082349.GW17484@dhcp22.suse.cz> <20180420124044.GA17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804212019400.84222@chino.kir.corp.google.com> <201804221248.CHE35432.FtOMOLSHOFJFVQ@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1804231706340.18716@chino.kir.corp.google.com> <20180424130432.GB17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804241256000.231037@chino.kir.corp.google.com> <20180424201352.GV17484@dhcp22.suse.cz> <alpine.DEB.2.21.1804241317200.231037@chino.kir.corp.google.com>
 <20180424203148.GW17484@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018, Michal Hocko wrote:

> > > > My patch has passed intensive testing on both x86 and powerpc, so I'll ask 
> > > > that it's pushed for 4.17-rc3.  Many thanks to Tetsuo for the suggestion 
> > > > on calling __oom_reap_task_mm() from exit_mmap().
> > > 
> > > Yeah, but your patch does have a problem with blockable mmu notifiers
> > > IIUC.
> > 
> > What on earth are you talking about?  exit_mmap() does 
> > mmu_notifier_release().  There are no blockable mmu notifiers.
> 
> MMF_OOM_SKIP - remember? The thing that guarantees a forward progress.
> So we cannot really depend on setting MMF_OOM_SKIP if a
> mmu_notifier_release blocks for an excessive/unbounded amount of time.
> 

If the thread is blocked in exit_mmap() because of mmu_notifier_release() 
then the oom reaper will eventually grab mm->mmap_sem (nothing holding it 
in exit_mmap()), return true, and oom_reap_task() will set MMF_OOM_SKIP.  
This is unchanged with the patch and is a completely separate issue.

> Look I am not really interested in disussing this to death but it would
> be really _nice_ if you could calm down a bit, stop fighting for the solution
> you have proposed and ignore the feedback you are getting.
> 

I assume we should spend more time considering the two untested patches 
you have sent, one of which killed 17 processes while a 8GB memory hog was 
exiting because the oom reaper couldn't grab mm->mmap_sem and set 
MMF_OOM_SKIP.

> There are two things to care about here. Stop the race that can blow up
> and do not regress MMF_OOM_SKIP guarantee. Can we please do that.

My patch does both.

Thanks.
