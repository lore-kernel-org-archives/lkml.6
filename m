Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9895C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6960E205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6960E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJ3XR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:17:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727834AbeJ3XR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:17:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21EB9B0E0;
        Tue, 30 Oct 2018 14:23:47 +0000 (UTC)
Date:   Tue, 30 Oct 2018 15:23:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 3/3] mm, oom: hand over MMF_OOM_SKIP to exit path
 if it is guranteed to finish
Message-ID: <20181030142344.GF32673@dhcp22.suse.cz>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181025082403.3806-4-mhocko@kernel.org>
 <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
 <20181030063136.GU32673@dhcp22.suse.cz>
 <95cb93ec-2421-3c5d-fd1e-91d9696b0f5a@I-love.SAKURA.ne.jp>
 <20181030113915.GB32673@dhcp22.suse.cz>
 <ca390ac1-2f10-b734-fff7-56767253e8c5@i-love.sakura.ne.jp>
 <20181030121012.GC32673@dhcp22.suse.cz>
 <0b1a8c3b-8346-ba7d-da7b-3c79354e11d7@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1a8c3b-8346-ba7d-da7b-3c79354e11d7@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-10-18 22:57:37, Tetsuo Handa wrote:
> On 2018/10/30 21:10, Michal Hocko wrote:
> > I misunderstood your concern. oom_reaper would back off without
> > MMF_OOF_SKIP as well. You are right we cannot assume anything about
> > close callbacks so MMF_OOM_SKIP has to come before that. I will move it
> > behind the pagetable freeing.
> > 
> 
> And at that point, your patch can at best wait for only __free_pgtables(),

Yes, mostly on the grounds that oom victims are mostly sitting on mapped
memory and page tables. I can see how last ->close() can release some
memory as well but a) we do not consider that memory when selecting a
victim and b) it shouldn't be a large memory consumer on its own.

> at the cost/risk of complicating exit_mmap() and arch specific code.Also,
> you are asking for comments to wrong audiences. It is arch maintainers who
> need to precisely understand the OOM behavior / possibility of OOM lockup,
> and you must persuade them about restricting/complicating future changes in
> their arch code due to your wish to allow handover. Without "up-to-dated
> big fat comments to all relevant functions affected by your change" and
> "acks from all arch maintainers", I'm sure that people keep making
> errors/mistakes/overlooks.

Are you talking about arch_exit_mmap or which part of the arch code?

> My patch can wait for completion of (not only exit_mmap() but also) __mmput(),
> by using simple polling approach. My patch can allow NOMMU kernels to avoid
> possibility of OOM lockup by setting MMF_OOM_SKIP at __mmput() (and future
> patch will implement timeout based back off for NOMMU kernels), and allows you
> to get rid of TIF_MEMDIE (which you recently added to your TODO list) by getting
> rid of conditional handling of oom_reserves_allowed() and ALLOC_OOM.

OK, let's settle on a simple fact. I would like to discuss _this_
approach here. Bringing up _yours_ all the time is not productive much.
You might have noticed that I have posted this for discussion (hence the
RGC) and as such I would appreciate staying on the topic.

What is the best approach in the end is a matter of discsussion of
course. At thise stage it is quite clear we can only agree to disagree
which approach is better and discussing the same set of points back and
forth is not going to get us anywhere. Therefore we would have to rely on the
maintainer to decide.
-- 
Michal Hocko
SUSE Labs
