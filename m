Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1AC24DF1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1AC24DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeGCHRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:17:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753770AbeGCHRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:17:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F81DADE3;
        Tue,  3 Jul 2018 07:16:59 +0000 (UTC)
Date:   Tue, 3 Jul 2018 09:16:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: move out_of_memory back to the charge path
Message-ID: <20180703071658.GC16767@dhcp22.suse.cz>
References: <20180628151101.25307-1-mhocko@kernel.org>
 <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
 <20180629072132.GA13860@dhcp22.suse.cz>
 <xr93bmbtju6f.fsf@gthelen.svl.corp.google.com>
 <20180702100301.GC19043@dhcp22.suse.cz>
 <xr938t6skd9m.fsf@gthelen.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xr938t6skd9m.fsf@gthelen.svl.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 00:08:05, Greg Thelen wrote:
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Fri 29-06-18 11:59:04, Greg Thelen wrote:
> >> Michal Hocko <mhocko@kernel.org> wrote:
> >> 
> >> > On Thu 28-06-18 16:19:07, Greg Thelen wrote:
> >> >> Michal Hocko <mhocko@kernel.org> wrote:
> >> > [...]
> >> >> > +	if (mem_cgroup_out_of_memory(memcg, mask, order))
> >> >> > +		return OOM_SUCCESS;
> >> >> > +
> >> >> > +	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> >> >> > +		"This looks like a misconfiguration or a kernel bug.");
> >> >> 
> >> >> I'm not sure here if the warning should here or so strongly worded.  It
> >> >> seems like the current task could be oom reaped with MMF_OOM_SKIP and
> >> >> thus mem_cgroup_out_of_memory() will return false.  So there's nothing
> >> >> alarming in that case.
> >> >
> >> > If the task is reaped then its charges should be released as well and
> >> > that means that we should get below the limit. Sure there is some room
> >> > for races but this should be still unlikely. Maybe I am just
> >> > underestimating though.
> >> >
> >> > What would you suggest instead?
> >> 
> >> I suggest checking MMF_OOM_SKIP or deleting the warning.
> >
> > So what do you do when you have MMF_OOM_SKIP task? Do not warn? Checking
> > for all the tasks would be quite expensive and remembering that from the
> > task selection not nice either. Why do you think it would help much?
> 
> I assume we could just check current's MMF_OOM_SKIP - no need to check
> all tasks.

I still do not follow. If you are after a single task memcg then we
should be ok. try_charge has a runaway for oom victims
	if (unlikely(tsk_is_oom_victim(current) ||
		     fatal_signal_pending(current) ||
		     current->flags & PF_EXITING))
		goto force;

regardless of MMF_OOM_SKIP. So if there is a single process in the
memcg, we kill it and the oom reaper kicks in and sets MMF_OOM_SKIP then
we should bail out there. Or do I miss your intention?

> My only (minor) objection is that the warning text suggests
> misconfiguration or kernel bug, when there may be neither.
> 
> > I feel strongly that we have to warn when bypassing the charge limit
> > during the corner case because it can lead to unexpected behavior and
> > users should be aware of this fact. I am open to the wording or some
> > optimizations. I would prefer the latter on top with a clear description
> > how it helped in a particular case though. I would rather not over
> > optimize now without any story to back it.
> 
> I'm fine with the warning.  I know enough to look at dmesg logs to take
> an educates that the race occurred.  We can refine it later if/when the
> reports start rolling in.  No change needed.

OK. Thanks!

-- 
Michal Hocko
SUSE Labs
