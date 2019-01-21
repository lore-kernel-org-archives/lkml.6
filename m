Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC63C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8D22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UEIZcR8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfAUMZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:25:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfAUMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AyS4kcH3KILuE4E2F2as1z3uNLds1VWJsElfbbWdDDc=; b=UEIZcR8IK5lJ4UtIlnq83kCAM
        O9ydTokCT1cl8zwm/WWn6dgwHcjfokPS8thakzzoKnVPiI9Rft09q0IFtB6Jie9fsmg0JuMKypbiM
        QicUMyFfOVIBrpaBmVQHkkJYo5U8oN0u6D8fcYsSNJ8ylVubu3OtNmydOkcJ4zLgFmaqguKvXlWk/
        x1dXyNSNG1CmqkwWobiESrofBYTHGCyY0OERGJ9gpdgefqG/e6MTS9nVz8t28LAcgXzh2op2FZfME
        sERn250nbc/oako9vSHWavr2WLEtFFgpsS/3nxaeTeT5e2uWw0NA1o469oFK2wEsL0Kc28DVm5eqI
        sfA/A3tyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glYdt-0006Zy-FD; Mon, 21 Jan 2019 12:25:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 090C920267E52; Mon, 21 Jan 2019 13:25:27 +0100 (CET)
Date:   Mon, 21 Jan 2019 13:25:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] sched: Use READ_ONCE()/WRITE_ONCE() in
 task_cpu()/__set_task_cpu()
Message-ID: <20190121122526.GA13777@hirez.programming.kicks-ass.net>
References: <20190116184218.13757-1-andrea.parri@amarulasolutions.com>
 <20190121104707.GA5883@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121104707.GA5883@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:51:21AM +0100, Andrea Parri wrote:
> On Wed, Jan 16, 2019 at 07:42:18PM +0100, Andrea Parri wrote:
> > The smp_wmb() in move_queued_task() (c.f., __set_task_cpu()) pairs with
> > the composition of the dependency and the ACQUIRE in task_rq_lock():
> > 
> > 	move_queued_task()		task_rq_lock()
> > 
> > 	[S] ->on_rq = MIGRATING		[L] rq = task_rq()
> > 	WMB (__set_task_cpu())		ACQUIRE (rq->lock);
> > 	[S] ->cpu = new_cpu		[L] ->on_rq
> > 
> > where "[L] rq = task_rq()" is ordered before "ACQUIRE (rq->lock)" by an
> > address dependency and, in turn, "ACQUIRE (rq->lock)" is ordered before
> > "[L] ->on_rq" by the ACQUIRE itself.
> > 
> > Use READ_ONCE() to load ->cpu in task_rq() (c.f., task_cpu()) to honour
> > this address dependency between loads; also, mark the store to ->cpu in
> > __set_task_cpu() by using WRITE_ONCE() in order to tell the compiler to
> > not mess/tear this (synchronizing) memory access.
> 
> In the light of the recent discussion about the integration of plain
> accesses in the LKMM (c.f., e.g., [1] and discussion thereof), I was
> considering even further changes to this in order to "reinforce" the
> above smp_wmb().  Here's two approaches (one of):
> 
>  1) replace this smp_wmb()+WRITE_ONCE() with an smp_store_release();
> 
>  2) or keep this smp_wmb()+WRITE_ONCE(), but use {WRITE,READ}_ONCE()
>     also for the accesses to ->on_rq.

That should be the least painful I think. Note that we never store a
value larger than a single byte in that word, so tearing shouldn't be a
problem, but yes, that makes it all neat and tidy.

> What do you think?  (maybe I'm just being too paranoid?)
> 
> Adding Will to the Cc:  ((1) should be "painless" for x86, not sure
> about arm64...)

ARM64 should be fine, it is 32bit ARM that will suffer, because it uses
smp_mb() to implement acquire/release.
