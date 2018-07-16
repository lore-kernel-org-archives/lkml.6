Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D23DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC22820856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC22820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeGPGjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:39:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbeGPGjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:39:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86CA6AF51;
        Mon, 16 Jul 2018 06:13:19 +0000 (UTC)
Date:   Mon, 16 Jul 2018 08:13:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] mm, oom: remove oom_lock from exit_mmap
Message-ID: <20180716061317.GA17280@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
 <20180713142612.GD19960@dhcp22.suse.cz>
 <44d26c25-6e09-49de-5e90-3c16115eb337@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d26c25-6e09-49de-5e90-3c16115eb337@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-07-18 06:18:58, Tetsuo Handa wrote:
> On 2018/07/13 23:26, Michal Hocko wrote:
> > On Thu 12-07-18 14:34:00, David Rientjes wrote:
> > [...]
> >> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >> index 0fe4087d5151..e6328cef090f 100644
> >> --- a/mm/oom_kill.c
> >> +++ b/mm/oom_kill.c
> >> @@ -488,9 +488,11 @@ void __oom_reap_task_mm(struct mm_struct *mm)
> >>  	 * Tell all users of get_user/copy_from_user etc... that the content
> >>  	 * is no longer stable. No barriers really needed because unmapping
> >>  	 * should imply barriers already and the reader would hit a page fault
> >> -	 * if it stumbled over a reaped memory.
> >> +	 * if it stumbled over a reaped memory. If MMF_UNSTABLE is already set,
> >> +	 * reaping as already occurred so nothing left to do.
> >>  	 */
> >> -	set_bit(MMF_UNSTABLE, &mm->flags);
> >> +	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
> >> +		return;
> > 
> > This could lead to pre mature oom victim selection
> > oom_reaper			exiting victim
> > oom_reap_task			exit_mmap
> >   __oom_reap_task_mm		  __oom_reap_task_mm
> > 				    test_and_set_bit(MMF_UNSTABLE) # wins the race
> >   test_and_set_bit(MMF_UNSTABLE)
> > set_bit(MMF_OOM_SKIP) # new victim can be selected now.
> > 
> > Besides that, why should we back off in the first place. We can
> > race the two without any problems AFAICS. We already do have proper
> > synchronization between the two due to mmap_sem and MMF_OOM_SKIP.
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index fc41c0543d7f..4642964f7741 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3073,9 +3073,7 @@ void exit_mmap(struct mm_struct *mm)
> >  		 * which clears VM_LOCKED, otherwise the oom reaper cannot
> >  		 * reliably test it.
> >  		 */
> > -		mutex_lock(&oom_lock);
> >  		__oom_reap_task_mm(mm);
> > -		mutex_unlock(&oom_lock);
> >  
> >  		set_bit(MMF_OOM_SKIP, &mm->flags);
> 
> David and Michal are using different version as a baseline here.
> David is making changes using timeout based back off (in linux-next.git)
> which is inappropriately trying to use MMF_UNSTABLE for two purposes.
> 
> Michal is making changes using current code (in linux.git) which does not
> address David's concern.

Yes I have based it on top of Linus tree because the point of this patch
is to get rid of the locking which is no longer needed. I do not see
what concern are you talking about.
> 
> My version ( https://marc.info/?l=linux-mm&m=153119509215026 ) is
> making changes using current code which also provides oom-badness
> based back off in order to address David's concern.
> 
> >  		down_write(&mm->mmap_sem);
> 
> Anyway, I suggest doing
> 
>   mutex_lock(&oom_lock);
>   set_bit(MMF_OOM_SKIP, &mm->flags);
>   mutex_unlock(&oom_lock);

Why do we need it?

> like I mentioned at
> http://lkml.kernel.org/r/201807130620.w6D6KiAJ093010@www262.sakura.ne.jp
> even if we make changes on top of linux-next's timeout based back off.

says
: (3) Prevent from selecting new OOM victim when there is an !MMF_OOM_SKIP mm
:     which current thread should wait for.
[...]
: Regarding (A), we can reduce the range oom_lock serializes from
: "__oom_reap_task_mm()" to "setting MMF_OOM_SKIP", for oom_lock is useful for (3).

But why there is a lock needed for this? This doesn't make much sense to
me. If we do not have MMF_OOM_SKIP set we still should have mm_is_oom_victim
so no new task should be selected. If we race with the oom reaper than
ok, we would just not select a new victim and retry later.
-- 
Michal Hocko
SUSE Labs
