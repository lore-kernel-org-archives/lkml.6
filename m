Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69039C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B0F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547225140;
	bh=1zuk0lRJhxt1KtIcuSnHD65qwzMIWTZpvezv6qtKS9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1rwsVtSvepf+YcHUZI3hviai5QXk888kVuDTel7j1a6S4K25SMjfk+52mlS/I04cl
	 GlnBZqG8mDUXqiN7eAWFzkRz7qu/HrqU37r99B7lNBCOjTfIc7sNw1HTaxnmSUPilc
	 nu5yG32tWa2BgHBqG91pkQl7PyvU3AupAOI/KTh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfAKQpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:45:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:44262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728266AbfAKQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:45:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4B4FAE26;
        Fri, 11 Jan 2019 16:45:37 +0000 (UTC)
Date:   Fri, 11 Jan 2019 17:45:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
Message-ID: <20190111164536.GJ14956@dhcp22.suse.cz>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
 <20190111113354.GD14956@dhcp22.suse.cz>
 <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
 <20190111133401.GA6997@dhcp22.suse.cz>
 <d9f7b139-d51b-93ae-b5ad-856fd9f2c168@i-love.sakura.ne.jp>
 <20190111150703.GI14956@dhcp22.suse.cz>
 <baa43a5a-6cae-bc4e-5911-13d4bfcd32f2@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa43a5a-6cae-bc4e-5911-13d4bfcd32f2@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12-01-19 00:37:05, Tetsuo Handa wrote:
> On 2019/01/12 0:07, Michal Hocko wrote:
> > On Fri 11-01-19 23:31:18, Tetsuo Handa wrote:
> >> The OOM killer invoked by [ T9694] called printk() but didn't kill anything.
> >> Instead, SIGINT from Ctrl-C killed all thread groups sharing current->mm.
> > 
> > I still do not get it. Those other processes are not sharing signals.
> > Or is it due to injecting the signal too all of them with the proper
> > timing?
> 
> Pressing Ctrl-C between after task_will_free_mem(p) in oom_kill_process() and
> before __oom_kill_process() (e.g. dump_header()) made fatal_signal_pending() = T
> for all of them.
> 
> > Anyway, could you update your patch and abstract 
> > 	if (unlikely(tsk_is_oom_victim(current) ||
> > 		     fatal_signal_pending(current) ||
> > 		     current->flags & PF_EXITING))
> > 
> > in try_charge and reuse it in mem_cgroup_out_of_memory under the
> > oom_lock with an explanation please?
> 
> I don't think doing so makes sense, for
> 
>   tsk_is_oom_victim(current) = T && fatal_signal_pending(current) == F
> 
> can't happen for mem_cgroup_out_of_memory() under the oom_lock, and
> current->flags cannot get PF_EXITING when current is inside
> mem_cgroup_out_of_memory(). fatal_signal_pending(current) alone is
> appropriate for mem_cgroup_out_of_memory() under the oom_lock because
> 
>   tsk_is_oom_victim(current) = F && fatal_signal_pending(current) == T
> 
> can happen there.

I meant to use the same check consistently. If we can bypass the charge
under a list of conditions in the charge path we should be surely be
able to the the same for the oom path. I will not insist but unless
there is a strong reason I would prefer that.

> Also, doing so might become wrong in future, for mem_cgroup_out_of_memory()
> is also called from memory_max_write() which does not bail out upon
> PF_EXITING. I don't think we can call memory_max_write() after current
> thread got PF_EXITING, but nobody knows what change will happen in future.

No, this makes no sense what so ever.
-- 
Michal Hocko
SUSE Labs
