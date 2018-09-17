Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9153EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5B1214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u1yyOBdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5B1214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIQRw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:52:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeIQRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1jNEWI/9YA3I1o68vOITxMUbkb4Jd883mgsbBf36sUU=; b=u1yyOBdXnls2RnNTWvt+7F5Oes
        01K3qeER++WIkEg6xm+o0wVPweYV8EWsn2GyuhPqtaygYQD7iTN283M/9aNP7H1qekaCra0nYyqG9
        WrL95aMLFmqdLIl350RP4s4dYkKvlHlKpamCrHRLzygI/hdAQaSkbrKoc30d2JMrOOFmGAOUhOEMN
        XHcK780Yuu/8GlPNDWNM3VBTkEdC+ZyJ1p7zskNrXsCLzzby3Nr5XfdgNOo+XoD0V4jEm/qi0k6qG
        uaJWlmrxnLRsQrV9LFnk21XAetgaYYn8AH/frQKWE7VBcL/arLef6m/QcXrLZUvGZwWkC/gFGtkG0
        2NQevgwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1sax-0003eE-LJ; Mon, 17 Sep 2018 12:25:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F64A2058A23E; Mon, 17 Sep 2018 14:25:38 +0200 (CEST)
Date:   Mon, 17 Sep 2018 14:25:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20180917122538.GT24124@hirez.programming.kicks-ass.net>
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

> Assuming, there is a cgroup-less solution that can prevent simultaneous
> execution of tasks on a core, when they're not supposed to. How would you
> tell the scheduler, which tasks these are?

Specifically for L1TF I hooked into/extended KVM's preempt_notifier
registration interface, which tells us which tasks are VCPUs and to
which VM they belong.

But if we want to actually expose this to userspace, we can either do a
prctl() or extend struct sched_attr.

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

Well, you mentioned it as an alternative to paravirt spinlocks -- I'm
saying that co-scheduling cannot do that, you need full featured
gang-scheduling for that.
