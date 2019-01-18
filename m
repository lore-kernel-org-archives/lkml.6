Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFBC65C14
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC2320883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OzkO8bHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfARULA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:11:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37326 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfARULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U/QJ4CfI81kB0VE0e1usY7t5S5dPhqUGyBh/r+7td44=; b=OzkO8bHgYeoURMmtm+ykXf/ov
        qZJGBvb6xV/ExWUP8Xetm4EwoBbz5GGDPf10/FJqkqadqsC6kd46nmwmK7+M5k/XojrGwsODZojip
        aTmFMZVSU/leOh2NekEFTr90i9yhi2iOim6UHCSWy9mAg9NDIOqUw17K8et/knpftuGutA0bALdu4
        Bi4bzJDRuRcdrhtQdhuCZQEpctubNB/qUdK6GSCvnl1BgzCMlIEFslciCac/x4EmI8+a3CfQybbe1
        qVxpykR9qc4xjY4FGJh3UE30aNdaBmABycDUG4CgOiF6cUzwp3T4Q1VtqwAJsys3jO8N8/btSmtak
        K2ozcxXrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkaTf-0005gu-8P; Fri, 18 Jan 2019 20:10:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DABC320289CC4; Fri, 18 Jan 2019 21:10:51 +0100 (CET)
Date:   Fri, 18 Jan 2019 21:10:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vince Weaver <vincent.weaver@maine.edu>,
        '@hirez.programming.kicks-ass.net
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
Message-ID: <20190118201051.GF27931@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air>
 <alpine.DEB.2.21.1901101246340.3358@macbook-air>
 <alpine.DEB.2.21.1901101500030.3717@macbook-air>
 <alpine.DEB.2.21.1901111649580.6487@macbook-air>
 <20190118120149.GC27931@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901180905090.5762@macbook-air>
 <20190118155814.GC14054@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901181217180.5762@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901181217180.5762@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:24:20PM -0500, Vince Weaver wrote:
> On Fri, 18 Jan 2019, Peter Zijlstra wrote:
> > 
> > You can actually use rdpmc when you attach to a CPU, but you have to
> > ensure that the userspace component is guaranteed to run on that very
> > CPU (sched_setaffinity(2) comes to mind).
> 
> unfortunately the HPC people using PAPI would probably be annoyed if we 
> started binding their threads to cores out from under them.

Quite.. :-)

> > The best we could possibly do is put the (target, not current) cpu
> > number in the mmap page; but userspace should already know this, for it
> > created the event and therefore knows this already.
> 
> one other thing the kernel would do is just disable rdpmc (setting index 
> to 0) in the case where the original perf_event_open() cpu paramater!=0
> 
> though that would stop the case where we were on the same CPU from 
> working.

Indeed.

> The issue is currently if you're not careful the rdpmc() interface will 
> sometimes return plausible (but wrong) results for a cross-CPU rdpmc() 
> call, even if you are properly falling back to read() on ->index being 0.
> It's a bit surprising and it looks like it will take a decent amount of 
> userspace code to work around the issue, which cuts into the low-overhead 
> nature of rdpmc.
> 
> If the answer is simply this is the way the kernel is going to do it, 
> that's fine, I just have to add workarounds to PAPI and then get the 
> perf_even_open() manpage updated to make sure people are aware of the 
> issue.

I'm not sure there really is anything the kernel can do to help here...
One thing you could look at is using rseq together with adding a CPU
number to the userspace descriptor, and if rseq gives you a matching CPU
number use rdpmc, otherwise, or on rseq abort, use read().
