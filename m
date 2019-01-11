Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A381C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C72084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219229;
	bh=huWv7mwP1nwMEk39wMT4w2wv7GbOWMmy82glyP14pqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aFPTAVEF4sV/2nRefLHFLAPBM9AUtJ2nsR/DcD55ol9I8o7v/ViHtEViiecPd352H
	 3xvbEkIGFxw6oBzGMpJQvf+Ctbe9kWV2z4WFLhyFXYOGqvwgHK5Ls9eBQB2QFcvX68
	 NVfbdQR5xz1wD5bGDD8b+HFPRofVPcspa1EMIOME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391921AbfAKPHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:07:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:56288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbfAKPHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:07:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EE71AD14;
        Fri, 11 Jan 2019 15:07:04 +0000 (UTC)
Date:   Fri, 11 Jan 2019 16:07:03 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Message-ID: <20190111150703.GI14956@dhcp22.suse.cz>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
 <20190111113354.GD14956@dhcp22.suse.cz>
 <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
 <20190111133401.GA6997@dhcp22.suse.cz>
 <d9f7b139-d51b-93ae-b5ad-856fd9f2c168@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f7b139-d51b-93ae-b5ad-856fd9f2c168@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-01-19 23:31:18, Tetsuo Handa wrote:
> On 2019/01/11 22:34, Michal Hocko wrote:
> > On Fri 11-01-19 21:40:52, Tetsuo Handa wrote:
> > [...]
> >> Did you notice that there is no
> >>
> >>   "Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n"
> >>
> >> line between
> >>
> >>   [   71.304703][ T9694] Memory cgroup out of memory: Kill process 9692 (a.out) score 904 or sacrifice child
> >>
> >> and
> >>
> >>   [   71.309149][   T54] oom_reaper: reaped process 9750 (a.out), now anon-rss:0kB, file-rss:0kB, shmem-rss:185532kB
> >>
> >> ? Then, you will find that [ T9694] failed to reach for_each_process(p) loop inside
> >> __oom_kill_process() in the first round of out_of_memory() call because
> >> find_lock_task_mm() == NULL at __oom_kill_process() because Ctrl-C made that victim
> >> complete exit_mm() before find_lock_task_mm() is called.
> > 
> > OK, so we haven't killed anything because the victim has exited by the
> > time we wanted to do so. We still have other tasks sharing that mm
> > pending and not killed because nothing has killed them yet, right?
> 
> The OOM killer invoked by [ T9694] called printk() but didn't kill anything.
> Instead, SIGINT from Ctrl-C killed all thread groups sharing current->mm.

I still do not get it. Those other processes are not sharing signals.
Or is it due to injecting the signal too all of them with the proper
timing?
 
> > How come the oom reaper could act on this oom event at all then?
> > 
> > What am I missing?
> > 
> 
> The OOM killer invoked by [ T9750] did not call printk() but hit
> task_will_free_mem(current) in out_of_memory() and invoked the OOM reaper,
> without calling mark_oom_victim() on all thread groups sharing current->mm.
> Did you notice that I wrote that

OK, now it starts making sense to me finally. I got hooked up in
find_lock_task_mm failing in __oom_kill_process because we do see 
"Memory cgroup out of memory" and that happens _after_
task_will_free_mem. So the whole oom_reaper scenario didn't make much
sense to me.

>   Since mm-oom-marks-all-killed-tasks-as-oom-victims.patch does not call mark_oom_victim()
>   when task_will_free_mem() == true,
> 
> ? :-(

No, I got lost in your writeup.

While the task_will_free_mem is fixable but this would get us to even
uglier code so I agree that the approach by my two patches is not
feasible.

I really wanted to have this heuristic based on the oom victim rather
than signal pending because one lesson I've learned over time was that
checks for fatal signals can lead to odd corner cases. Memcg is less
prone to those issues because we can bypass the charge but still.

Anyway, could you update your patch and abstract 
	if (unlikely(tsk_is_oom_victim(current) ||
		     fatal_signal_pending(current) ||
		     current->flags & PF_EXITING))

in try_charge and reuse it in mem_cgroup_out_of_memory under the
oom_lock with an explanation please?

Andrew, please drop my 2 patches please.
                           
-- 
Michal Hocko
SUSE Labs
