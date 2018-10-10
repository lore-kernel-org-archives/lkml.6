Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C375C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37A62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37A62086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJKDrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:47:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56328
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbeJKDrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:47:08 -0400
X-IronPort-AV: E=Sophos;i="5.54,365,1534802400"; 
   d="scan'208";a="281717963"
Received: from 89-157-201-244.rev.numericable.fr (HELO hadrien) ([89.157.201.244])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 22:23:18 +0200
Date:   Wed, 10 Oct 2018 22:23:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>
Subject: Re: First coccinelle script, need some help.
In-Reply-To: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1810102217260.2479@hadrien>
References: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2018, Joel Fernandes wrote:

>
> Hi!
>
> I am trying to determine if a function argument is used across the whole
> kernel for a certain kernel function.
>
> I mustered up enough courage to write my first coccinelle script after a few
> late nights of reading up about it :)
>
> Here is .cocci script. I am trying to find if address is used at all in any
> possible definitions of pte_alloc():
>
> $ cat ~/pte_alloc.cocci
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
> ...
> (
> ...
>  E2
> ...
> )
> ...
>  }


In report mode, by default, the pattern has to match on all paths.  Also
when you have ... before or after E2, there can be no occurrence of E2 in
the code matched by the ...  So your rule requires that on every possible
execution path through the function, there is exactly one occurrence of
E2.

You can try the following instead:

virtual report

@pte_args depends on report exists@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc@p(T1 E1, T2 E2)
 {
 ... when any
 E2
 ... when any
 }

The exists in the rule header means check one path at a time.  The when
any allows anything, including E2, to occur in the ... part.  You could
also drop the first when any.  The E2 will only match the first one, but
you don't care in this case.

julia

>
> @script:python depends on report@
> p << pte_args.p;
> @@
> coccilib.report.print_report(p[0], "WARNING: found definition of
> apte_alloc_one with address used in the body")
>
> The above warning does fire on the following test.c program:
>
> struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> {
>         address++;
>          if (condition()) {
>                 return NULL;
>         }
> }
>
> But, *not* if I move 'address' into the if block:
>
> struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> {
>          if (condition()) {
>               address++;
>               return NULL;
>         }
> }
>
> I could not understand why, In my view the "address" expression should be
> matched across the function body even within if blocks. But if I move
> "address" into the if block, then the match doesn't occur any longer.
>
> My coccicheck command is as follow:
> make coccicheck COCCI=~/pte_alloc.cocci MODE=report  M=test/test.c
>
> What am I missing? Thanks for any help.
>
> thanks,
>
>  - Joel
>
>
