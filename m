Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932787AbeBLXmu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:42:50 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36677 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbeBLXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:42:48 -0500
X-Google-Smtp-Source: AH8x227x9M5kEVfO13czJtnwm7UegEaP8q7maDIw86yU1RluwLVbvapg9chk4IQPebbxjM48rtokaw==
From: Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
Date: Mon, 12 Feb 2018 15:42:44 -0800
In-Reply-To: <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 12 Feb 2018 13:59:27 -0800")
Message-ID: <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And some maintainers end up using multiple repositories as branches
> (the old _original_ git model). Again, you can just use "git fetch +
> git reset", of course, but that's a bit unsafe. In contrast, doing
> "git pull --ff-only" is a safe convenient operation that does both the
> fetch and the update to whatever state.
>
> But you do need that "--ff-only" to avoid the merge.

OK.  I guess it is legit (and semi-sensible) for downstream
contributors to "git pull --ff-only $upstream $release_tag_X" to
bring their long-running topic currently based on release X-1 up to
date with respect to release X.  It probably makes more sense than
rebasing on top of release X, even though it makes a lot less sense
than merging their topics into release X.

As you said, pull of a tag that forbids fast-forward by default is
rather old development (I am kind of surprised that it was so old,
in v1.7.9), so it may be a bit difficult to transition.

There is 

	[pull]
                ff = only

but pull.ff is quite global, and not good for intermediate level
maintainers who pull to integrate work of their downstream (for
which they do want the current "do not ff, record the tag in a merge
commit" behaviour) and also pull to catch up from their upstream
(which they want "ff-when-able").  They need to control between
ff=only and ff=when-able, depending on whom they are pulling from.

We may want per-remote equivalent for it, i.e. e.g.

	[pull]
		ff=false ;# good default for collecting contributions

	[remote "torvalds"] 
		pullFF = only ;# good default for catching up

or something like that, perhaps?
