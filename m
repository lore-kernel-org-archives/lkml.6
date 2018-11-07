Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE147C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB122081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaTjr2cS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB122081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeKHGAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeKHGAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:00:18 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB4242081D;
        Wed,  7 Nov 2018 20:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541622497;
        bh=Xb+w8Ru1VzlB3mAQJxTy32XpmY/XzYTzj/W/SowOUbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaTjr2cSV7NzJvohZqaM71mtvtUHTeUXrckgti19hdl9umM5aA7AiddH6k95wZyYK
         QaVojF0LMpXtVZ54ZhqdMtezhpBRE2mc/j/B4vdCEcL0oxmFQQesjSXUkvVRG+/APM
         FvukyEYYgCqdEGKGT4yAPzVchyRRN/qIwJLvgkPg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 269B7142D3F; Wed,  7 Nov 2018 17:28:15 -0300 (-03)
Date:   Wed, 7 Nov 2018 17:28:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181107202815.GH18346@kernel.org>
References: <20181106.221349.1296959035550004994.davem@davemloft.net>
 <20181107083217.GA12870@krava>
 <20181107194344.GA29732@krava>
 <20181107.120154.1747291861102322855.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107.120154.1747291861102322855.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 07, 2018 at 12:01:54PM -0800, David Miller escreveu:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Wed, 7 Nov 2018 20:43:44 +0100
> 
> > I pushed new version in my perf/fixes branch
> 
> Thanks, I'll check it out later today for sure!  This is pretty exciting
> work.
> 
> Just some random thoughts as I've been thinking about this whole
> situation a lot lately:
> 
> Something to consider might be consolidating all of the event rings
> into one.  This would force perf to process all events in "system
> order", ie. what order they actually occurred in the machine.

Processing in "system order" is what we want, yeah.
 
> Yes, this means more contention for the entities inside the kernel
> queueing up the events, however the benefits are enormous.
> 
> Right now we go forwards and backwards in time as we move from one
> event ring to another, as you know.
> 
> However, we have to reconcile with the need we have to separate "high
> priority" (ie. cannot really lose) events like fork, mmap2, etc.  with
> "low priority" ones such as IP samples.

So perhaps we should tell the kernel that is ok to lose SAMPLEs but not
the other events, and make userspace ask for PERF_RECORD_!SAMPLE in all
ring buffers? Duplication wouldn't be that much of a problem?
 
> Perhaps another way to think about this is to go to the one huge mmap
> ring model, and do the prioritization internally in perf.
> 
> Actually, this opens up tons of possibilities in my mind.
> 
> Perf can queue to an internal high priority queue for fork and mmap2
> events, and never drop them.  Whilst at the same time queueing low

Right, or put that in all queues? Would that be too costly?

> priority events like IP samples into a low priority queue and dropping
> with whatever policy it wants when overloaded (f.e. drop older events
> before newer ones).
> 
> I do not like the overwrite ring buffer mode that was implemented
> because it enforeces an entire set of policy decisions upon the user.
> Either the model works for you (which it currently does not for perf)
> or you can't use it at all.
> 
> If the issue is that newer events are more interesting than old ones,
> that is entirely perf's businness.  And it can implement this policy
> %100 internally to itself.  No kernel changes were ever needed to do
> this, as explained above.
> 
> Please, let's abandon this whole overwrite mode of the ring buffer.
> The old one works perfectly fine, we just have to use it properly.
> We should never have to shut off kernel side event queueing just
> because we are processing the event ring on the user side.
> 
> Thanks.
