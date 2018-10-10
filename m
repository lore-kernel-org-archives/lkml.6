Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CD5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2502087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2502087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeJKEg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:36:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:41586
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbeJKEgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:36:25 -0400
X-IronPort-AV: E=Sophos;i="5.54,365,1534802400"; 
   d="scan'208";a="281719755"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 23:12:26 +0200
Date:   Wed, 10 Oct 2018 23:12:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>
Subject: Re: First coccinelle script, need some help.
In-Reply-To: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1810102312010.2479@hadrien>
References: <20181010193854.GA93016@joelaf.mtv.corp.google.com> <alpine.DEB.2.21.1810102217260.2479@hadrien> <20181010204517.GA109962@joelaf.mtv.corp.google.com> <alpine.DEB.2.21.1810102249410.2479@hadrien>
 <20181010211125.GA128537@joelaf.mtv.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2018, Joel Fernandes wrote:

> On Wed, Oct 10, 2018 at 10:51:28PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 10 Oct 2018, Joel Fernandes wrote:
> >
> > > On Wed, Oct 10, 2018 at 10:23:18PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Wed, 10 Oct 2018, Joel Fernandes wrote:
> > > >
> > > > >
> > > > > Hi!
> > > > >
> > > > > I am trying to determine if a function argument is used across the whole
> > > > > kernel for a certain kernel function.
> > > > >
> > > > > I mustered up enough courage to write my first coccinelle script after a few
> > > > > late nights of reading up about it :)
> > > > >
> > > > > Here is .cocci script. I am trying to find if address is used at all in any
> > > > > possible definitions of pte_alloc():
> > > > >
> > > > > $ cat ~/pte_alloc.cocci
> > > > > virtual report
> > > > >
> > > > > @pte_args depends on report@
> > > > > identifier E1, E2;
> > > > > type T1, T2;
> > > > > position p;
> > > > > @@
> > > > >
> > > > >  pte_alloc@p(T1 E1, T2 E2)
> > > > >  {
> > > > > ...
> > > > > (
> > > > > ...
> > > > >  E2
> > > > > ...
> > > > > )
> > > > > ...
> > > > >  }
> > > >
> > > >
> > > > In report mode, by default, the pattern has to match on all paths.  Also
> > > > when you have ... before or after E2, there can be no occurrence of E2 in
> > > > the code matched by the ...  So your rule requires that on every possible
> > > > execution path through the function, there is exactly one occurrence of
> > > > E2.
> > > >
> > > > You can try the following instead:
> > > >
> > > > virtual report
> > > >
> > > > @pte_args depends on report exists@
> > > > identifier E1, E2;
> > > > type T1, T2;
> > > > position p;
> > > > @@
> > > >
> > > >  pte_alloc@p(T1 E1, T2 E2)
> > > >  {
> > > >  ... when any
> > > >  E2
> > > >  ... when any
> > > >  }
> > >
> > > Thanks for the quick reply.
> > > If I just add 'depends on report exists' to the rule, then my original
> > > example works fine now. I did not need to add the 'when any'. Do you mind
> > > taking my original simple test.c example and modify it and let me know under
> > > what situation would it not work?
> > >
> > > I even added address = 1 outside of the if block and it works fine, I see the
> > > warning as I expect without 'when any' in pront of the "...".
> > >
> > > struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> > > {
> > > 	 address = 1;
> > >          if (condition()) {
> > > 		 while (1) {
> > > 			address++;
> > > 		 }
> > >                 return NULL;
> > >         }
> > > }
> >
> > This works, because there exists a path through the function that has only
> > one use of address, ie the path where condition() is false.  It should
> > break if you put address = 2; just under address = 1, for example.
> >
> Ok, thanks. This fact really is a bit subtle I'd say but hopefully will not
> be once I get past the learning curve. Interestingly, if I do the following
> then that works too without needing 'exists':
>
> virtual report
>
> @pte_args depends on report@
> identifier E1, E2;
> type T1, T2;
> position p;
> @@
>
>  pte_alloc@p(T1 E1, T2 E2)
>  {
> <+...
>  E2
> ...+>
>  }
>
> @script:python depends on report@
> p << pte_args.p;
> @@
> coccilib.report.print_report(p[0], "WARNING: found definition of pte_alloc with
> address used in the body")

Yes, that is another option.  But it may be more expensive.

julia
