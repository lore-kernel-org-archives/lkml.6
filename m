Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16FF2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16FF2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbeGJE0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:26:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750913AbeGJE0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70C4640AC6DF;
        Tue, 10 Jul 2018 04:26:11 +0000 (UTC)
Received: from treble (ovpn-120-114.rdu2.redhat.com [10.10.120.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F14276E9;
        Tue, 10 Jul 2018 04:26:10 +0000 (UTC)
Date:   Mon, 9 Jul 2018 23:26:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH v2] objtool: move libelf detection to Kconfig from
 Makefile
Message-ID: <20180710042609.zie5fgrvoyusmeod@treble>
References: <1531186516-15764-1-git-send-email-yamada.masahiro@socionext.com>
 <20180710022904.e3oql2ts4qz43bzo@treble>
 <CAK7LNASM+81JkGu5-z8GRZ9+sRyd55gO0G0M5c54zRhE5JhE3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNASM+81JkGu5-z8GRZ9+sRyd55gO0G0M5c54zRhE5JhE3g@mail.gmail.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 10 Jul 2018 04:26:11 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 10 Jul 2018 04:26:11 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:47:49PM +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> 2018-07-10 11:29 GMT+09:00 Josh Poimboeuf <jpoimboe@redhat.com>:
> > On Tue, Jul 10, 2018 at 10:35:16AM +0900, Masahiro Yamada wrote:
> >> Currently, users are allowed to enable STACK_VALIDATION regardless
> >> of the compiler capability.  The top-level Makefile warns or breaks
> >> the build if it turns out that the host compiler cannot link libelf.
> >>
> >> Move the libelf test to Kconfig so that users can enable the feature
> >> only when the host compiler can build the objtool.  The ugly check
> >> in the Makefile will go away.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> >
> > Actually, looking at this again, I want to rescind my ack.
> >
> > This patches changes the behavior in a subtle (but important) way.
> >
> > Before, if I did "make defconfig", it would *always* choose the ORC
> > unwinder.  Then, if I didn't have libelf-devel, the build would fail and
> > it would tell me what I need to install.
> >
> > But now with this patch, if I do "make defconfig", the generated config
> > actually changes based on what I happen to have installed on my build
> > system.  If I don't have libelf-devel, then it silently chooses the
> > non-default unwinder (frame pointer).
> >
> > This is a subtle difference, but IMO it's dangerous, because it will
> > silently enable the frame pointer unwinder for the majority of new
> > systems, even though it's not the default.
> >
> > I strongly prefer the original behavior, because we really want to
> > encourage people to use the ORC unwinder, even if that means they have
> > to install a package to build it.
> >
> > Also -- in general -- I suspect that silently changing the defaults like
> > this will create a lot of bad surprises.  The output of "make defconfig"
> > should be predictable and not dependent on what RPMs I happen to have
> > installed.
> 
> 
> 
> Actually, we had similar discussion for stack protector.
> 
> 
> First, Kees liked to let the build fail
> instead of disabling the stack protector silently:
> 
> https://lkml.org/lkml/2018/2/9/697
> 
> 
> 
> Linus said:
> But yes, I also reacted to your earlier " It can't silently rewrite it
> to _REGULAR because the compiler support for _STRONG regressed."
> Because it damn well can. If the compiler doesn't support
> -fstack-protector-strong, we can just fall back on -fstack-protector.
> Silently. No extra crazy complex logic for that either.
> 
> (https://lkml.org/lkml/2018/2/10/281)
> 
> 
> 
> I hope this is the same pattern.

I wasn't a part of the -fstack-protector conversation, but I doubt it's
the same pattern.  We're trying to phase out frame pointers, for several
reasons.  One big reason is that they cause a general slowdown across
the entire kernel.

Since we switched the x86_64 default to the ORC unwinder, a lot of
people have switched over.  But this patch will reverse (or at least
slow down) that trend, because almost nobody has the libelf devel
packaged installed by default.  So over time, it will effectively make
frame pointers the default again in many cases.  That's exactly what we
*don't* want to do.  It will also cause people to accidentally re-enable
frame pointers when they thought they had ORC.

-- 
Josh
