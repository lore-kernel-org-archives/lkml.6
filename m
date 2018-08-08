Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FB4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC9521737
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 10:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC9521737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeHHNSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 09:18:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHNSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 09:18:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 617D5AF74;
        Wed,  8 Aug 2018 10:59:10 +0000 (UTC)
Date:   Wed, 8 Aug 2018 12:59:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] introduce memory.oom.group
Message-ID: <20180808105909.GJ27972@dhcp22.suse.cz>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
 <20180731235135.GA23436@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
 <20180801224706.GA32269@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com>
 <20180807003020.GA21483@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808071519030.237317@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808071519030.237317@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-08-18 15:34:58, David Rientjes wrote:
> On Mon, 6 Aug 2018, Roman Gushchin wrote:
> 
> > > In a cgroup-aware oom killer world, yes, we need the ability to specify 
> > > that the usage of the entire subtree should be compared as a single 
> > > entity with other cgroups.  That is necessary for user subtrees but may 
> > > not be necessary for top-level cgroups depending on how you structure your 
> > > unified cgroup hierarchy.  So it needs to be configurable, as you suggest, 
> > > and you are correct it can be different than oom.group.
> > > 
> > > That's not the only thing we need though, as I'm sure you were expecting 
> > > me to say :)
> > > 
> > > We need the ability to preserve existing behavior, i.e. process based and 
> > > not cgroup aware, for subtrees so that our users who have clear 
> > > expectations and tune their oom_score_adj accordingly based on how the oom 
> > > killer has always chosen processes for oom kill do not suddenly regress.
> > 
> > Isn't the combination of oom.group=0 and oom.evaluate_together=1 describing
> > this case? This basically means that if memcg is selected as target,
> > the process inside will be selected using traditional per-process approach.
> > 
> 
> No, that would overload the policy and mechanism.  We want the ability to 
> consider user-controlled subtrees as a single entity for comparison with 
> other user subtrees to select which subtree to target.  This does not 
> imply that users want their entire subtree oom killed.

Yeah, that's why oom.group == 0, no?

Anyway, can we separate this discussion from the current series please?
We are getting more and more tangent.

Or do you still see the current state to be not mergeable?
-- 
Michal Hocko
SUSE Labs
