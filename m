Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF84ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670CC2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I2esuaOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670CC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeIQTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:04:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Awci2NloivThIfbI7FN2RhRdTGtjr7Ke5VYdFsXkUuA=; b=I2esuaOB8jYWzAPflSLqQQ2r8Y
        y4lHDLPdNsDHzN3YoJc8iBkCDGnhze+C7Ab7cHA9lToh8orQMnv5ByIq1JeC7gEolEVGrgMVvIEO8
        tQq9ectED1HZQVFEo1rpUkEy+axxgSUDl607QURnSCYVfActB0nw2ZLv7dnS3/sWCu2FwMQOFWUr0
        nq/StrUbEr5XmGX1ryrpIVmm0FFFfL1qaeOKDNK/xn4X774epynfjVpLP3foDkVyRahmIl0MgCVF9
        bnkcrQ4Ks2OPFetoK/zfqBwFljuGDAxIQxSdxOt/ShsNmvKdrv08tcedeHA97II8VMsA3HaruBM1u
        eqyjor2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1ti6-00046y-82; Mon, 17 Sep 2018 13:37:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E56702058AF01; Mon, 17 Sep 2018 15:37:03 +0200 (CEST)
Date:   Mon, 17 Sep 2018 15:37:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180917133703.GU24124@hirez.programming.kicks-ass.net>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
> On 09/14/2018 01:12 PM, Peter Zijlstra wrote:

> >> 1. Execute parallel applications that rely on active waiting or synchronous
> >>    execution concurrently with other applications.
> >>
> >>    The prime example in this class are probably virtual machines. Here,
> >>    coscheduling is an alternative to paravirtualized spinlocks, pause loop
> >>    exiting, and other techniques with its own set of advantages and
> >>    disadvantages over the other approaches.
> > 
> > Note that in order to avoid PLE and paravirt spinlocks and paravirt
> > tlb-invalidate you have to gang-schedule the _entire_ VM, not just SMT
> > siblings.
> > 
> > Now explain to me how you're going to gang-schedule a VM with a good
> > number of vCPU threads (say spanning a number of nodes) and preserving
> > the rest of CFS without it turning into a massive trainwreck?
> 
> You probably don't -- for the same reason, why it is a bad idea to give
> an endless loop realtime priority. It's just a bad idea. As I said in the
> text you quoted: coscheduling comes with its own set of advantages and
> disadvantages. Just because you find one example, where it is a bad idea,
> doesn't make it a bad thing in general.
> 
> 
> > Such things (gang scheduling VMs) _are_ possible, but not within the
> > confines of something like CFS, they are also fairly inefficient
> > because, as you do note, you will have to explicitly schedule idle time
> > for idle vCPUs.
> 
> With gang scheduling as defined by Feitelson and Rudolph [6], you'd have to
> explicitly schedule idle time. With coscheduling as defined by Ousterhout [7],
> you don't. In this patch set, the scheduling of idle time is "merely" a quirk
> of the implementation. And even with this implementation, there's nothing
> stopping you from down-sizing the width of the coscheduled set to take out
> the idle vCPUs dynamically, cutting down on fragmentation.

The thing is, if you drop the full width gang scheduling, you instantly
require the paravirt spinlock / tlb-invalidate stuff again.

Of course, the constraints of L1TF itself requires the explicit
scheduling of idle time under a bunch of conditions.

I did not read your [7] in much detail (also very bad quality scan that
:-/; but I don't get how they leap from 'thrashing' to co-scheduling.
Their initial problem, where A generates data that B needs and the 3
scenarios:

 1) A has to wait for B
 2) B has to wait for A
 3) the data gets buffered

Seems fairly straight forward and is indeed quite common, needing
co-scheduling for that, I'm not convinced.

We have of course added all sorts of adaptive wait loops in the kernel
to deal with just that issue.

With co-scheduling you 'ensure' B is running when A is, but that doesn't
mean you can actually make more progress, you could just be burning a
lot of CPu cycles (which could've been spend doing other work).

I'm also not convinced co-scheduling makes _any_ sense outside SMT --
does one of the many papers you cite make a good case for !SMT
co-scheduling? It just doesn't make sense to co-schedule the LLC domain,
that's 16+ cores on recent chips.
