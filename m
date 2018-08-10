Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9222BC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F04223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F04223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeHJJcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:32:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeHJJcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:32:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7741AAF74;
        Fri, 10 Aug 2018 07:03:52 +0000 (UTC)
Date:   Fri, 10 Aug 2018 09:03:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180810070351.GB1644@dhcp22.suse.cz>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
 <20180731235135.GA23436@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
 <20180801224706.GA32269@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com>
 <20180807003020.GA21483@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808071519030.237317@chino.kir.corp.google.com>
 <20180808105909.GJ27972@dhcp22.suse.cz>
 <alpine.DEB.2.21.1808091308210.244858@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808091308210.244858@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-08-18 13:10:10, David Rientjes wrote:
> On Wed, 8 Aug 2018, Michal Hocko wrote:
> 
> > > > > In a cgroup-aware oom killer world, yes, we need the ability to specify 
> > > > > that the usage of the entire subtree should be compared as a single 
> > > > > entity with other cgroups.  That is necessary for user subtrees but may 
> > > > > not be necessary for top-level cgroups depending on how you structure your 
> > > > > unified cgroup hierarchy.  So it needs to be configurable, as you suggest, 
> > > > > and you are correct it can be different than oom.group.
> > > > > 
> > > > > That's not the only thing we need though, as I'm sure you were expecting 
> > > > > me to say :)
> > > > > 
> > > > > We need the ability to preserve existing behavior, i.e. process based and 
> > > > > not cgroup aware, for subtrees so that our users who have clear 
> > > > > expectations and tune their oom_score_adj accordingly based on how the oom 
> > > > > killer has always chosen processes for oom kill do not suddenly regress.
> > > > 
> > > > Isn't the combination of oom.group=0 and oom.evaluate_together=1 describing
> > > > this case? This basically means that if memcg is selected as target,
> > > > the process inside will be selected using traditional per-process approach.
> > > > 
> > > 
> > > No, that would overload the policy and mechanism.  We want the ability to 
> > > consider user-controlled subtrees as a single entity for comparison with 
> > > other user subtrees to select which subtree to target.  This does not 
> > > imply that users want their entire subtree oom killed.
> > 
> > Yeah, that's why oom.group == 0, no?
> > 
> > Anyway, can we separate this discussion from the current series please?
> > We are getting more and more tangent.
> > 
> > Or do you still see the current state to be not mergeable?
> 
> I've said three times in this series that I am fine with it.

OK, that wasn't really clear to me because I haven't see any explicit
ack from you (well except for the trivial helper patch). So I was not
sure.

> Roman and I 
> are discussing the API for making forward progress with the cgroup aware 
> oom killer itself.  When he responds, he can change the subject line if 
> that would be helpful to you.

I do not insist of course but it would be easier to follow if that
discussion was separate.

-- 
Michal Hocko
SUSE Labs
