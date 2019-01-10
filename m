Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D27F208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LnA16k8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfAJUSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:18:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51358 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfAJUSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=34YxzfRCXCPtdMwxkCh+gXntgRrS8+hBKkRFHh9Txvk=; b=LnA16k8VvU9IcMavRR62EatuB
        bDyxbIEgCTeQ2IIU0Lz1bVCi4z0AZNygaBQY/tO7UECZwIPbaJkHoxo7gW9A8czxC4gBl/EvjYTQS
        hLCnbWZYQcS5vpvHXVwA+mPAa/butOiTb05+CWfx2K2Lb7BBTmQw/EliokFwPLUBmAgYLagOGqI0s
        rSeVpz1iayfcGgUOuWdVjeKnbFJGrSM7ktpz3WNiySoJTwg8VaZsl5Z8BZCs7loouxwEbCuCMqAuU
        DaogQ1inoJHR5QAo+mr0fePyVVyKsTkG+hJXcXFpaOI+DAnMi/f/6eJsQaU0ePjlOkaKWeSgxrbJf
        HAqTmR2ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghgmf-0006zn-6V; Thu, 10 Jan 2019 20:18:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BB519844AF; Thu, 10 Jan 2019 21:18:30 +0100 (CET)
Date:   Thu, 10 Jan 2019 21:18:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190110201829.GI2861@worktop.programming.kicks-ass.net>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190108223746.shuwx3ro7cgwz7hh@breakpoint.cc>
 <20190110124123.GA21224@hirez.programming.kicks-ass.net>
 <CACT4Y+YZ-bOFM_vHN5GiE5Yh=qqGjO_cgsJD4cnNyupOd6-A-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YZ-bOFM_vHN5GiE5Yh=qqGjO_cgsJD4cnNyupOd6-A-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:53:28PM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 10, 2019 at 1:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jan 08, 2019 at 11:37:46PM +0100, Florian Westphal wrote:
> > > Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> > > > Or maybe xt_replace_table() can be enhanced? When I hear that
> > > > something waits until an event happens on all CPUs I think about
> > > > wait_event() function. Would it be better for xt_replace_table() to
> > > > introduce an atomic counter that is decremented by CPUs, and the main
> > > > CPU waits until the counter gets zero?
> > >
> > > That would mean placing an additional atomic op into the
> > > iptables evaluation path (ipt_do_table and friends).
> > >
> >
> > For:
> >
> >         /*
> >          * Ensure contents of newinfo are visible before assigning to
> >          * private.
> >          */
> >         smp_wmb();
> >         table->private = newinfo;
> >
> > we have:
> >
> >         smp_store_release(&table->private, newinfo);
> >
> > But what store does that second smp_wmb() order against? The comment:
> >
> >         /* make sure all cpus see new ->private value */
> >         smp_wmb();
> >
> > makes no sense what so ever, no smp_*() barrier can provide such
> > guarantees.
> 
> Do we want WRITE_ONCE here then?

The smp_store_release() already implies WRITE_ONCE().
