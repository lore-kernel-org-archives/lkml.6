Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFBAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3662084E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3662084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeH0HUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:20:08 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19627 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725878AbeH0HUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:20:07 -0400
X-IronPort-AV: E=Sophos;i="5.53,293,1531778400"; 
   d="scan'208";a="343751086"
Received: from unknown (HELO hadrien) ([208.181.63.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 05:35:19 +0200
Date:   Sun, 26 Aug 2018 23:35:17 -0400 (EDT)
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
In-Reply-To: <20180827023526.GA6515@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.1808262319000.2295@hadrien>
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk> <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com> <20180826173236.GU6515@ZenIV.linux.org.uk> <d31fe59160e0b7d40e09536a3c74619ebb1f3b13.camel@perches.com>
 <20180826212421.GW6515@ZenIV.linux.org.uk> <eca48539a3dede3bfaed9ab9a6c06794cf8160e0.camel@perches.com> <20180826224322.GX6515@ZenIV.linux.org.uk> <alpine.DEB.2.21.1808262159430.2528@hadrien> <20180827023526.GA6515@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Aug 2018, Al Viro wrote:

> On Sun, Aug 26, 2018 at 10:00:46PM -0400, Julia Lawall wrote:
> >
> >
> > On Sun, 26 Aug 2018, Al Viro wrote:
> >
> > > On Sun, Aug 26, 2018 at 03:26:54PM -0700, Joe Perches wrote:
> > > > On Sun, 2018-08-26 at 22:24 +0100, Al Viro wrote:
> > > > > On Sun, Aug 26, 2018 at 11:57:57AM -0700, Joe Perches wrote:
> > > > >
> > > > > > > That, BTW, is why I hate the use of sizeof(*p) in kmalloc, etc.
> > > > > > > arguments.  typeof is even worse in that respect.
> > > > > >
> > > > > > True.  Semantic searches via tools like coccinelle could help here
> > > > > > but those searches are quite a bit slower than straightforward greps.
> > > > >
> > > > > Those searches are .config-sensitive as well, which can be much more
> > > > > unpleasant than being slow...
> > > >
> > > > Are they?  Julia?
> > >
> > > They work pretty much on preprocessor output level; if something it ifdef'ed
> > > out on given config, it won't be seen...
> >
> > Coccinelle doesn't care what is ifdef'd out.  It only misses the things it
> > can't parse.  Very strange ifdefs could indeed cause that, but it should
> > be a minor problem.
>
> OK, but... what does it do when it sees two definitions of a structure
> in different branches of #if/#else/#endif?  I think I'm confused about
> what it can and cannot do; to restate the original problem:
> 	* we need to find all places where instances of given type
> are created.  Assume it never is a member of struct/union/array and
> no static or auto duration instances exist - everything is dynamically
> allocated somewhere.
>
> Can coccinelle do that and if it can, what are the limitations?

Looking at the thread, it seems that what you are asking for is something
like:

@@
struct tcf_proto *x;
@@

* x = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)

The * at the beginning of the line means to highlight what you are looking
for, which is done by making a diff in which the highlighted line
appears to be removed.

The limitation is the ability to figure out the type of x.  If it is a
local variable, Coccinelle should have no problem.  If it is a structure
field, it may be necessary to provide command line arguments like

--all-includes --include-headers-for-types

--all-includes means to try to find all include files that are mentioned
in the .c file.  The next stronger option is --recursive includes, which
means include what all of the mentioned files include as well,
recursively.  This tends to cause a major performance hit, because a lot
of code is being parsed.  --include-headers-for-types heals a bit with
that, as it only considers the header files when computing type
information, and now when applying the rules.

With respect to ifdefs around variable declarations and structure field
declaration, in these cases Coccinelle considers that it cannot make the
ifdef have an if-like control flow, and so if considers the #ifdef, #else
and #endif to be comments.  Thus it takes into account only the last type
provided for a given variable.  For example, in the following:

int main() {
#ifdef X
  int x;
#else
  char xx;
#endif

  return x;
}

int main2() {
#ifdef X
  char x;
#else
  int x;
#endif

  return x;
}

x is considered to have type int in both returns.  But if xx is replaced
by x in the definition of main, then x at the point of the return will
have type char.

Around a statement, such as x = kmalloc(...), it should be able to
consider that both branches of an ifdef are possible.

But there are no absolute guarantees.  If there is any problem in parsing
a line of some function, the whole function will be ignores.

julia
