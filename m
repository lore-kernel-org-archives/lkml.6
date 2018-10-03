Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF40C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B916B213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="wPbijM0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B916B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeJCWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:22:58 -0400
Received: from imap.thunk.org ([74.207.234.97]:34230 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCWW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IgUH+wccZfyBwYBvcoEsdtmL+lfBX0dNy5P8XKGVI54=; b=wPbijM0QhycH/1j7hMTxDKqMqC
        380DQffsSZyV1/Bq0G7HBB6UAIVLcv5CbiMfNh8wqXcNoL+HZAW2hAO+WAKyjURCCvvEXGDHpquyT
        OokvVnhjFiEW5ogrF2mOaD4O4EX1btXFDJnoZWRu2zCw/WHzVdVcfXdDvYjkFGCYWBc4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7j96-0006iB-6e; Wed, 03 Oct 2018 15:33:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68FDC7A0136; Wed,  3 Oct 2018 11:33:03 -0400 (EDT)
Date:   Wed, 3 Oct 2018 11:33:03 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Message-ID: <20181003153303.GC2835@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
 <20181003071059.02b3fd6f@canb.auug.org.au>
 <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
 <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
 <20181002232454.GB2483@thunk.org>
 <CANiq72=cRpqnB3BxLsmj-rMdUGJK+pac1SRppoRgsON69ErfQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=cRpqnB3BxLsmj-rMdUGJK+pac1SRppoRgsON69ErfQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 01:54:05PM +0200, Miguel Ojeda wrote:
> 
> Exactly. And for this case, I simply assumed Stephen wanted a clean
> series to apply on top of the latest next-* tag (same way we base
> stuff on top of -rc*s). Note that this is *not* really a "tree"
> collecting changes/development, it is a patch series, i.e. what is
> important is only the range-diff.
> 
> What has surprised me is that -next does not allow for range-diffs
> (patches/commits/...) to be inside -next, maybe applied after all the
> normal merges of trees. I simply assumed it did, given what I could
> find about -next (which does not seem to be documented properly, by
> the way).

Part of the reason why I wrote my long message was because the -next
tree usage has been mostly by convention.  Better documentation would
be a good thing; I think the main reason why we don't have it is that
historically, the people who submit direct pull requests to Linus
already know how things work.  Obviously that's not a great
assumption, but in fact there are a large number of things about what
is needed to be a subsystem maintainer which needs to be documented,
and the linux-next tree is just one part of it.  (And perhaps not even
the biggest part.)

Historically there was one source of changes into the linux-next tree
which was done as quilt-style patch series, and that was Andrew
Morton's mmotm tree.  Part of the problem is that it's a lot more work
to consume a patch series, and so these days while Andrew still uses a
patch series, he exports a git tree[1] which is what I believe Stephen
and Linus use.  (For that matter, I use a patch series[2] as well, but
the public interface is the ext4.git tree on git.kernel.org.)

[1] https://www.ozlabs.org/~akpm/mmotm/mmotm-readme.txt
[2] https://ext4.wiki.kernel.org/index.php/Ext4_patchsets

> While this is a simple conflict, I don't really agree with release
> maintainers having to fix conflicts on the fly (even if it is a single
> trivial line), but that is an orthogonal discussion...

Sure; there are some srtong reasons for it, but we can save that for
the Maintainer's Handbook discussion.  I will say that this is
something where attempts to avoid Linus needing to fix conflicts on
the fly, such as a rebase right before a PULL request, violates
Linus's rules which has in the past resulted in him expressing a
"strong" correction e-mail to Maintainers since it was assumed that
they really should have known better.  Linus has said he doesn't want
to yell at Maintainers, so we can support him by getting the
Maintainer's Handbook out there.  :-)

> Alright, I am not sure how to answer this without sounding
> "aggressive" and maybe I misunderstood something you tried to point
> out, so I apologize in advance. There are several points here:
> 
>   * The merge conflict isn't related to this (but let's assume it was,
> since you pointed this out as an example -- I guess; although I am not
> sure why).

I thought I was clear that I used it as an example, but my apologies
if that didn't come across.

>     - Changes should include everything related to them (as far as
> possible, i.e. extreme examples aside). Adding __nonstring and not
> removing the ext4 part would simply be leaving undone work (which has
> to be done sooner or later). To be honest, it could have even been
> done in the same commit and I would say it is logically OK (even if
> not great).
> ...
>
> You seem to argue that it is better to avoid merge conflicts rather
> than doing a proper series. Well, I think we should really try to
> avoid conflicts pushing down the """quality""" of
> patches/commits/series.

And I think this is where the disagreement lies, which is why I
bothered to send my long missive in the first place.  From my point of
view, and I suspect many maintainers share this, avoiding merge
conflicts is way important than making sure everything is "done" in a
single patch series.  There have been plenty of changes where cleanup
is done latter, and/or where preparatory patches are done in one
release, and the big change happens in the next release, 3 months
later.

That's because some of the alternatives, such as basing your git tree
on an unstable head branch, such as linux-next, or a last minute
rebase which means that the actual patches that which gets the pull
rebase hasn't been tested or soaked in linux-next, are far worse
because it can lead to lower quality git trees getting merged during
the merge window.

There is a tension here between maximizing the "quality" of a patch
series, and maximizing the "quality" of the git trees that feed into
the merge window.  Or perhaps the better way of saying this is
minimizing the risk of bad changes getting integreted during the merge
window.  Some technical debt which gets cleaned up in the next release
is in my view a very low price to pay in order to minimize risk.

Part of this is because I've had to waste time debugging changes made
to the ext4 sources which came in via someone else's git tree that
were "obviously correct" or "trivial changes" --- but they weren't.
Most of the time they get caught as part of linux-next testing, but
not always.  So sometimes the interests of one subsystem maintainer
can end up conflicting with the interests of the patch series author,
or the interests of another subsystem maintainer.  And that's why we
have some of these "cultural understandings", many of which we clearly
need to document.

(And yes, in this case I didn't object to the cleanup being in your
patch series; normally I don't care, unless it actually break things.
I was just trying to make the point from my perspective, nothing
*required* that the change be in your git tree, and if it *was*
causing the problem, I had gone out of my way to make sure to make it
easy for you to drop the change; and from my perspective I was doing
you --- and me :-) --- a favor when I added the outer #ifndef, which I
had done with full consideration, specifically for this reason.  Even
if the definition was different, my definition *had* been fully tested
with over a 27+ VM hours of regression testing, and if it turned out
that they were different, cleaning that up three months from now in
the next release is just *fine* as far as I'm concerned.)

Cheers,

						- Ted
