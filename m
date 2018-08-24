Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAA32173A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zc5WdXGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAA32173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeHXNfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 09:35:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38602 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbeHXNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 09:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3TnbEPHwO774Tc5/VhRj0iPFtlsqtIQ+PbmWzcc4MSg=; b=zc5WdXGHPeGibgebIQMRipGEf
        S+VCAUfXOHNK85U1Snd0ruc4hjQBJ7s+M5yeKiFkoDvC5P7onVCGLOx44bcBM7+hy23R14Yoki1FJ
        xCJPMJJwlGbvqvGGS4/0DatO1Z6tYcM3ZHkWkN86i1nWRs4vnQfaVm9ZNrlmmtTE1DtX0kX6asank
        aY38lunnu3EUy292/PdqBhU+DXMXXyaVV0v5obySqQdo+RgZChFGlYB29pxABshsV+JR8ACK5pBuN
        tIn3ijceAFklarNC2/BHl1NtEcULiTYBsP7eDjhP/doaGK8Yht1RV6Ktyz+EZ4wu+OqrG0bpaJ65Y
        VlOw0KDJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ft8tt-0008FF-Qx; Fri, 24 Aug 2018 10:01:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 366872024D70A; Fri, 24 Aug 2018 11:47:42 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:47:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miguel de Dios <migueldedios@google.com>
Cc:     Steve Muckle <smuckle@google.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching
 from fair
Message-ID: <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824093227.GN24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On 08/17/2018 11:27 AM, Steve Muckle wrote:

> > > When rt_mutex_setprio changes a task's scheduling class to RT,
> > > we're seeing cases where the task's vruntime is not updated
> > > correctly upon return to the fair class.

> > > Specifically, the following is being observed:
> > > - task is deactivated while still in the fair class
> > > - task is boosted to RT via rt_mutex_setprio, which changes
> > >    the task to RT and calls check_class_changed.
> > > - check_class_changed leads to detach_task_cfs_rq, at which point
> > >    the vruntime_normalized check sees that the task's state is TASK_WAKING,
> > >    which results in skipping the subtraction of the rq's min_vruntime
> > >    from the task's vruntime
> > > - later, when the prio is deboosted and the task is moved back
> > >    to the fair class, the fair rq's min_vruntime is added to
> > >    the task's vruntime, even though it wasn't subtracted earlier.

I'm thinking that is an incomplete scenario; where do we get to
TASK_WAKING.
