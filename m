Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2E8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FA920858
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="brEKFMPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FA920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJJTrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:47:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l5HgXudRo/pDiprhmaIgNFDr6UzvKOBYblCMU6cOosY=; b=brEKFMPmZP2NvBIADEaT21Ke/G
        giCaxdL0kwzbU1j1k+Y30CD+s0d7mRIMtaf6oa+swYFVKsOWh8zEwg2nJdgyvFj5XJeupbtZiXWLE
        YoO72vgGg6dBEAbnMBu71vyNpRPRfFxinc9YLY/kTmRu4kWuv3nmVW4KOmunxgvjUJERJ7Pf6PZ3U
        3j4adsj78eUqBN+sHSOjWcQzZ57Qoh11s1H89F+N9kv1zEX55BiBLUGQa1LgDd566H9aw17m+Dt7V
        x8hEIH9fhc08V9qW5P1Li7lo7363/ZSCobxhugf3e0NR6u4IOlD3tVYHPaHzon497i0mP1QA5GpUG
        WbecOJbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gADXs-0000dS-Nn; Wed, 10 Oct 2018 12:24:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C2C22029856A; Wed, 10 Oct 2018 14:24:54 +0200 (CEST)
Date:   Wed, 10 Oct 2018 14:24:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Henrik Austad <henrik@austad.us>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Message-ID: <20181010122454.GR5663@hirez.programming.kicks-ass.net>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
 <20181010115639.GA25534@sisyphus.home.austad.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181010115639.GA25534@sisyphus.home.austad.us>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:56:39PM +0200, Henrik Austad wrote:
> On Tue, Oct 09, 2018 at 11:24:26AM +0200, Juri Lelli wrote:
> > Hi all,
>=20
> Hi, nice series, I have a lot of details to grok, but I like the idea of =
PE
>=20
> > Proxy Execution (also goes under several other names) isn't a new
> > concept, it has been mentioned already in the past to this community
> > (both in email discussions and at conferences [1, 2]), but no actual
> > implementation that applies to a fairly recent kernel exists as of today
> > (of which I'm aware of at least - happy to be proven wrong).
> >=20
> > Very broadly speaking, more info below, proxy execution enables a task
> > to run using the context of some other task that is "willing" to
> > participate in the mechanism, as this helps both tasks to improve
> > performance (w.r.t. the latter task not participating to proxy
> > execution).
>=20
> From what I remember, PEP was originally proposed for a global EDF, and a=
s=20
> far as my head has been able to read this series, this implementation is=
=20
> planned for not only deadline, but eventuall also for sched_(rr|fifo|othe=
r)=20
> - is that correct?

This implementation covers every scheduling class unconditionally. It
directly uses the scheduling function to order things; where PI
re-implements the FIFO scheduling function to order the blocked lists.

> I have a bit of concern when it comes to affinities and and where the=20
> lock owner will actually execute while in the context of the proxy,=20
> especially when you run into the situation where you have disjoint CPU=20
> affinities for _rr tasks to ensure the deadlines.

The affinities of execution contexts are respected.

> I believe there were some papers circulated last year that looked at=20
> something similar to this when you had overlapping or completely disjoint=
=20
> CPUsets I think it would be nice to drag into the discussion. Has this be=
en=20
> considered? (if so, sorry for adding line-noise!)

Hurm, was that one of Bjorn's papers? Didn't that deal with AC of
disjoint/overlapping sets?

> > One can define the scheduling context of a task as all the information
> > in task_struct that the scheduler needs to implement a policy and the
> > execution contex as all the state required to actually "run" the task.
> > An example of scheduling context might be the information contained in
> > task_struct se, rt and dl fields; affinity pertains instead to execution
> > context (and I guess decideing what pertains to what is actually up for
> > discussion as well ;-). Patch 04/08 implements such distinction.
>=20
> I really like the idea of splitting scheduling ctx and execution context!

Right; so this whole thing relies on 'violating' affinities for
scheduling contexts, but respects affinities for execution contexts.

The basic observation is that affinities only matter when you execute
code.

This then also gives a fairly clear definition of what an execution
context is.
