Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76BEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2401C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2401C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeH0I0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 04:26:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:65482
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbeH0I0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 04:26:04 -0400
X-IronPort-AV: E=Sophos;i="5.53,293,1531778400"; 
   d="scan'208";a="276816270"
Received: from unknown (HELO hadrien) ([208.181.63.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 06:41:04 +0200
Date:   Sun, 26 Aug 2018 21:41:02 -0700 (PDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Al Viro <viro@ZenIV.linux.org.uk>
cc:     Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
In-Reply-To: <20180827040423.GB6515@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1808262107340.2295@hadrien>
References: <20180826061534.GT6515@ZenIV.linux.org.uk> <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com> <20180826173236.GU6515@ZenIV.linux.org.uk> <d31fe59160e0b7d40e09536a3c74619ebb1f3b13.camel@perches.com> <20180826212421.GW6515@ZenIV.linux.org.uk>
 <eca48539a3dede3bfaed9ab9a6c06794cf8160e0.camel@perches.com> <20180826224322.GX6515@ZenIV.linux.org.uk> <alpine.DEB.2.21.1808262159430.2528@hadrien> <20180827023526.GA6515@ZenIV.linux.org.uk> <alpine.DEB.2.21.1808262319000.2295@hadrien>
 <20180827040423.GB6515@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Aug 2018, Al Viro wrote:

> On Sun, Aug 26, 2018 at 11:35:17PM -0400, Julia Lawall wrote:
>
> > * x = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)
>
> I can name several you've missed right off the top of my head -
> vmalloc, kvmalloc, kmem_cache_alloc, kmem_cache_zalloc, variants
> with _trace slapped on, and that is not to mention the things like
> get_free_page or

OK, maybe for a given type the set of functions would be smaller.

>
> void *my_k3wl_alloc(u64 n) // 'cause all artificial limits suck, that's why
> {
> 	lots and lots of home-grown stats collection
> 	some tracepoints thrown in just for fun
> 	return kmalloc(n);
> }
>
> (and no, I'm not implying that net/sched folks had done anything of that
> sort; I have seen that and worse in drivers, though)
>
> > The * at the beginning of the line means to highlight what you are looking
> > for, which is done by making a diff in which the highlighted line
> > appears to be removed.
>
> Umm...  Does that cover return, BTW?  Or something like
> 	T *barf;
> 	extern void foo(T *p);
> 	foo(kmalloc(sizeof(*barf)));

It only covers the pattern that is shown, ie an assignment.  For this,
another pattern would be needed.  It would be necessary to match first the
call that one is concerned with and then go find the function definition
or prototype to find the type of the associated parameter.  It is possible
to count the offset of the kmalloc call in the argument list and then get
the type at the corresponding offset in the parameter list of the function
declaration or prototype.

>
>
> > The limitation is the ability to figure out the type of x.  If it is a
> > local variable, Coccinelle should have no problem.  If it is a structure
> > field, it may be necessary to provide command line arguments like
> >
> > --all-includes --include-headers-for-types
> >
> > --all-includes means to try to find all include files that are mentioned
> > in the .c file.  The next stronger option is --recursive includes, which
> > means include what all of the mentioned files include as well,
> > recursively.  This tends to cause a major performance hit, because a lot
> > of code is being parsed.  --include-headers-for-types heals a bit with
> > that, as it only considers the header files when computing type
> > information, and now when applying the rules.
> >
> > With respect to ifdefs around variable declarations and structure field
> > declaration, in these cases Coccinelle considers that it cannot make the
> > ifdef have an if-like control flow, and so if considers the #ifdef, #else
> > and #endif to be comments.  Thus it takes into account only the last type
> > provided for a given variable.
>
> [snip]
>
> What about several variants of structure definition?  Because ifdefs around
> includes do occur in the wild...

Such ifdefs would be ignored completely.  I suspect that only the last
definition of the structure would be taken into account.

julia
