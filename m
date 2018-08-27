Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9435C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C6C208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jf84q63s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C6C208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH0PBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:01:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeH0PBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J4Qmd2lna15d2oscrCMDFsZyNTB9HIqjLoxsx0c2Ays=; b=jf84q63sy7MV44f6gn+ofBtgz
        tgWJ8NYsmILL+zUxojkKfe9PUBYQLopby1yOZK9YRXhd409OTMy4Rn9bzsHAa6flj1qkv/jMjTWRV
        JtxLxQ+3WGkhk+AICi+3L3M/CjFO17u0hBp+FgCC8T58TodaaMHnpRB5b6/vkn/VajABFiaqTKrSZ
        G2yvxFRESQaipz3UJlsYf2ZEBjQYajbB1vXd+ZHZmDcBCCYbIJ6NwBm9mZxw8lrs+VWephL0zU+qj
        BIfjLbbCSenS0Cu7hD2LJlE4ta5PYFNEtw6OrfOMVVbzQjXg9DFDZ7BS6tBJ5OOP1OIZdj9wKRkAQ
        QrTIQKYXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuFU4-0001hH-4I; Mon, 27 Aug 2018 11:15:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B06992024EB1B; Mon, 27 Aug 2018 13:14:58 +0200 (CEST)
Date:   Mon, 27 Aug 2018 13:14:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steve Muckle <smuckle@google.com>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching
 from fair
Message-ID: <20180827111458.GB24124@hirez.programming.kicks-ass.net>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
> > > > On 08/17/2018 11:27 AM, Steve Muckle wrote:
> > 
> > > > > When rt_mutex_setprio changes a task's scheduling class to RT,
> > > > > we're seeing cases where the task's vruntime is not updated
> > > > > correctly upon return to the fair class.
> > 
> > > > > Specifically, the following is being observed:
> > > > > - task is deactivated while still in the fair class
> > > > > - task is boosted to RT via rt_mutex_setprio, which changes
> > > > >     the task to RT and calls check_class_changed.
> > > > > - check_class_changed leads to detach_task_cfs_rq, at which point
> > > > >     the vruntime_normalized check sees that the task's state is TASK_WAKING,
> > > > >     which results in skipping the subtraction of the rq's min_vruntime
> > > > >     from the task's vruntime
> > > > > - later, when the prio is deboosted and the task is moved back
> > > > >     to the fair class, the fair rq's min_vruntime is added to
> > > > >     the task's vruntime, even though it wasn't subtracted earlier.
> > 
> > I'm thinking that is an incomplete scenario; where do we get to
> > TASK_WAKING.
> 
> Yes there's a missing bit of context here at the beginning that the task to
> be boosted had already been put into TASK_WAKING.

See, I'm confused...

The only time TASK_WAKING is visible, is if we've done a remote wakeup
and it's 'stuck' on the remote wake_list. And in that case we've done
migrate_task_rq_fair() on it.

So by the time either rt_mutex_setprio() or __sched_setscheduler() get
to calling check_class_changed(), under both pi_lock and rq->lock, the
vruntime_normalized() thing should be right.

So please detail the exact scenario. Because I'm not seeing it.

