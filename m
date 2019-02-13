Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D3C4151A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461FA222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550058459;
	bh=3AAiA4tNwn19yywJuyiFajqd/KZliB5LZawOr87FRaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A/KLxydvrCx6H9BtcIrSVVRzgbw3UIj8ZoTCqgpcfnYs9dkB8R5fjQe87K+GIUw//
	 CQw2Miiw7WT/OJMjtQXkXW4KXzL0DCNBa6ffSWLiZARnrOqujpZf8AXZHVyL+uY1L1
	 NaOTHRDScMFcN115RIULWwuoIupLxfOGBVkvSAe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbfBMLrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:47:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:49028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfBMLrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:47:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2384AADAA;
        Wed, 13 Feb 2019 11:47:35 +0000 (UTC)
Date:   Wed, 13 Feb 2019 12:47:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yong-Taek Lee <ytk.lee@samsung.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc, oom: do not report alien mms when setting
 oom_score_adj
Message-ID: <20190213114733.GB4525@dhcp22.suse.cz>
References: <20190212102129.26288-1-mhocko@kernel.org>
 <20190212125635.27742b5741e92a0d47690c53@linux-foundation.org>
 <201902130124.x1D1OGg3070046@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201902130124.x1D1OGg3070046@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 10:24:16, Tetsuo Handa wrote:
> Andrew Morton wrote:
> > On Tue, 12 Feb 2019 11:21:29 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > Tetsuo has reported that creating a thousands of processes sharing MM
> > > without SIGHAND (aka alien threads) and setting
> > > /proc/<pid>/oom_score_adj will swamp the kernel log and takes ages [1]
> > > to finish. This is especially worrisome that all that printing is done
> > > under RCU lock and this can potentially trigger RCU stall or softlockup
> > > detector.
> > > 
> > > The primary reason for the printk was to catch potential users who might
> > > depend on the behavior prior to 44a70adec910 ("mm, oom_adj: make sure
> > > processes sharing mm have same view of oom_score_adj") but after more
> > > than 2 years without a single report I guess it is safe to simply remove
> > > the printk altogether.
> > > 
> > > The next step should be moving oom_score_adj over to the mm struct and
> > > remove all the tasks crawling as suggested by [2]
> > > 
> > > [1] http://lkml.kernel.org/r/97fce864-6f75-bca5-14bc-12c9f890e740@i-love.sakura.ne.jp
> > > [2] http://lkml.kernel.org/r/20190117155159.GA4087@dhcp22.suse.cz
> > 
> > I think I'll put a cc:stable on this.  Deleting a might-trigger debug
> > printk is safe and welcome.
> > 
> 
> I don't like this patch, for I can confirm that removing only printk() is not
> sufficient for avoiding hungtask warning. If the reason of removing printk() is
> that we have never heard that someone hit this printk() for more than 2 years,
> the whole iteration is nothing but a garbage. I insist that this iteration
> should be removed.

As the changelog states explicitly, removing the loop should be the next
step and the implementation is outlined in [2]. It is not as simple
as to do the revert as you have proposed. We simply cannot allow to have
different processes disagree on oom_score_adj. This could easily lead
to breaking the OOM_SCORE_ADJ_MIN protection. And that is a correctness
issue.

As a side note.
I am pretty sure I would have more time to do that if only I didn't
really have to spend it on pointless and repeated discussions. You
are clearly not interested on spending _your_ time to address this
issue properly yourself. This is fair but nacking a low hanging
fruit patch that doesn't make situation any worse while it removes a
potential expensive operation from withing RCU context is nothing but
an obstruction.  It is even more sad that this is not the first example
of this attitude which makes it pretty hard, if not impossible, to work
with you.

And another side note. I have already pointed out that this is by far
not the only problem with CLONE_VM without CLONE_SIGHAND threading
model. Try to put your "only the oom paths matter" glasses down
for a moment and try to look what are the actual and much more
serious consequences of this threading model. Hint have a look at
mm_update_next_owner and how we have to for_each_process from under
tasklist_lock or zap_threads with RCU as well.
-- 
Michal Hocko
SUSE Labs
