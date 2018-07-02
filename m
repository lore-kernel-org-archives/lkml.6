Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A2259E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A2259E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933925AbeGBKDG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933467AbeGBKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:03:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C58CAEC7;
        Mon,  2 Jul 2018 10:03:02 +0000 (UTC)
Date:   Mon, 2 Jul 2018 12:03:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Thelen <gthelen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg, oom: move out_of_memory back to the charge path
Message-ID: <20180702100301.GC19043@dhcp22.suse.cz>
References: <20180628151101.25307-1-mhocko@kernel.org>
 <xr93in62jy8k.fsf@gthelen.svl.corp.google.com>
 <20180629072132.GA13860@dhcp22.suse.cz>
 <xr93bmbtju6f.fsf@gthelen.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xr93bmbtju6f.fsf@gthelen.svl.corp.google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-06-18 11:59:04, Greg Thelen wrote:
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Thu 28-06-18 16:19:07, Greg Thelen wrote:
> >> Michal Hocko <mhocko@kernel.org> wrote:
> > [...]
> >> > +	if (mem_cgroup_out_of_memory(memcg, mask, order))
> >> > +		return OOM_SUCCESS;
> >> > +
> >> > +	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> >> > +		"This looks like a misconfiguration or a kernel bug.");
> >> 
> >> I'm not sure here if the warning should here or so strongly worded.  It
> >> seems like the current task could be oom reaped with MMF_OOM_SKIP and
> >> thus mem_cgroup_out_of_memory() will return false.  So there's nothing
> >> alarming in that case.
> >
> > If the task is reaped then its charges should be released as well and
> > that means that we should get below the limit. Sure there is some room
> > for races but this should be still unlikely. Maybe I am just
> > underestimating though.
> >
> > What would you suggest instead?
> 
> I suggest checking MMF_OOM_SKIP or deleting the warning.

So what do you do when you have MMF_OOM_SKIP task? Do not warn? Checking
for all the tasks would be quite expensive and remembering that from the
task selection not nice either. Why do you think it would help much?

I feel strongly that we have to warn when bypassing the charge limit
during the corner case because it can lead to unexpected behavior and
users should be aware of this fact. I am open to the wording or some
optimizations. I would prefer the latter on top with a clear description
how it helped in a particular case though. I would rather not over
optimize now without any story to back it.
-- 
Michal Hocko
SUSE Labs
