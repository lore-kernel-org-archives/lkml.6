Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4B521780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4B521780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbeKOVo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:44:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728609AbeKOVo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:44:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54B58AE0E;
        Thu, 15 Nov 2018 11:36:55 +0000 (UTC)
Date:   Thu, 15 Nov 2018 12:36:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 0/3] oom: rework oom_reaper vs. exit_mmap handoff
Message-ID: <20181115113653.GO23831@dhcp22.suse.cz>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181108093224.GS27423@dhcp22.suse.cz>
 <9dfd5c87-ae48-8ffb-fbc6-706d627658ff@i-love.sakura.ne.jp>
 <20181114101604.GM23419@dhcp22.suse.cz>
 <0648083a-3112-97ff-edd7-1444c1be529a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0648083a-3112-97ff-edd7-1444c1be529a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 18:54:15, Tetsuo Handa wrote:
> On 2018/11/14 19:16, Michal Hocko wrote:
> > On Wed 14-11-18 18:46:13, Tetsuo Handa wrote:
> > [...]
> > > There is always an invisible lock called "scheduling priority". You can't
> > > leave the MMF_OOM_SKIP to the exit path. Your approach is not ready for
> > > handling the worst case.
> > 
> > And that problem is all over the memory reclaim. You can get starved
> > to death and block other resources. And the memory reclaim is not the
> > only one.
> 
> I think that it is a manner for kernel developers that no thread keeps
> consuming CPU resources forever. In the kernel world, doing
> 
>   while (1);
> 
> is not permitted. Likewise, doing
> 
>   for (i = 0; i < very_large_value; i++)
>       do_something_which_does_not_yield_CPU_to_others();

There is nothing like that proposed in this series.

> has to be avoided, in order to avoid lockup problems. We are required to
> yield CPU to others when we are waiting for somebody else to make progress.
> It is the page allocator who is refusing to yield CPU to those who need CPU.

And we do that in the reclaim path.

> Since the OOM reaper kernel thread "has normal priority" and "can run on any
> CPU", the possibility of failing to run is lower than an OOM victim thread
> which "has idle priority" and "can run on only limited CPU". You are trying
> to add a dependency on such thread, and I'm saying that adding a dependency
> on such thread increases possibility of lockup.

Sigh. No, this is not the case. All this patch series does is that we
hand over to the exiting task once it doesn't block on any locks
anymore. If the thread is low priority then it is quite likely that the
oom reaper is done by the time the victim even reaches the exit path.

> Yes, even the OOM reaper kernel thread might fail to run if all CPUs were
> busy with realtime threads waiting for the OOM reaper kernel thread to make
> progress. In that case, we had better stop relying on asynchronous memory
> reclaim, and switch to direct OOM reaping by allocating threads.
> 
> But what I demonstrated is that
> 
>         /*
>          * the exit path is guaranteed to finish the memory tear down
>          * without any unbound blocking at this stage so make it clear
>          * to the oom_reaper
>          */
> 
> becomes a lie even when only one CPU was busy with realtime threads waiting
> for an idle thread to make progress. If the page allocator stops telling a
> lie that "an OOM victim is making progress on behalf of me", we can avoid
> the lockup.

OK, I stopped reading right here. This discussion is pointless. Once you
busy loop all CPUs you are screwed. Are you going to blame a filesystem
that no progress can be made if a code path holding an important lock
is preemempted by high priority stuff a no further progress can be
made? This is just ridiculous. What you are arguing here is not fixable
with the current upstream kernel. Even your so beloved timeout based
solution doesn't cope with that because oom reaper can be preempted for
unbound amount of time. Your argument just doens't make much sense in
the context of the current kernel. Full stop.
-- 
Michal Hocko
SUSE Labs
