Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932895AbeBMAWN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:22:13 -0500
Received: from osg.samsung.com ([64.30.133.232]:54089 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932743AbeBMAWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:22:11 -0500
Date: Mon, 12 Feb 2018 22:21:57 -0200
From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: linux-next: unnecessary merge in the v4l-dvb tree
Message-ID: <20180212222157.0a3bd472@vento.lan>
In-Reply-To: <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
References: <20180213080036.3bf3a908@canb.auug.org.au>
        <CA+55aFwM0vy+pw-Xv=gA19ULMwAXNPhdO3qR5A3hkMrZKJFNSQ@mail.gmail.com>
        <CA+55aFzxsNxgKD1uGZQCiib+=+wCMSa0=B+Ye3Zi-u6kpz8Vrg@mail.gmail.com>
        <xmqqfu65sx20.fsf@gitster-ct.c.googlers.com>
        <CA+55aFwTp8gg70sHXqOgR01Liv5c8nnfUP0yTdwpkh-rg+2EMA@mail.gmail.com>
        <xmqqzi4drczv.fsf@gitster-ct.c.googlers.com>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 12 Feb 2018 15:42:44 -0800
Junio C Hamano <gitster@pobox.com> escreveu:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > And some maintainers end up using multiple repositories as branches
> > (the old _original_ git model). Again, you can just use "git fetch +
> > git reset", of course, but that's a bit unsafe. In contrast, doing
> > "git pull --ff-only" is a safe convenient operation that does both the
> > fetch and the update to whatever state.
> >
> > But you do need that "--ff-only" to avoid the merge.  
> 
> OK.  I guess it is legit (and semi-sensible) for downstream
> contributors to "git pull --ff-only $upstream $release_tag_X" to
> bring their long-running topic currently based on release X-1 up to
> date with respect to release X.  It probably makes more sense than
> rebasing on top of release X, even though it makes a lot less sense
> than merging their topics into release X.
> 
> As you said, pull of a tag that forbids fast-forward by default is
> rather old development (I am kind of surprised that it was so old,
> in v1.7.9), so it may be a bit difficult to transition.
> 
> There is 
> 
> 	[pull]
>                 ff = only
> 
> but pull.ff is quite global, and not good for intermediate level
> maintainers who pull to integrate work of their downstream (for
> which they do want the current "do not ff, record the tag in a merge
> commit" behaviour) and also pull to catch up from their upstream
> (which they want "ff-when-able").  They need to control between
> ff=only and ff=when-able, depending on whom they are pulling from.

Yes, that's my pain. I don't want ff only when pulling from others,
only when pulling from upstream tree.

> 
> We may want per-remote equivalent for it, i.e. e.g.
> 
> 	[pull]
> 		ff=false ;# good default for collecting contributions
> 
> 	[remote "torvalds"] 
> 		pullFF = only ;# good default for catching up
> 
> or something like that, perhaps?


Yeah, something like that works. Please notice, however, that what I
usually do is:

	$ git remote update torvalds
	$ git merge <tag>
	  (or git pull . <tag>)

So, for the above to work, it should store somehow the remote from
where a tag came from.




The reason is that I keep locally a cache with several tree clones
(in bare mode) s that I bother enough to cache (linus, -stable, -next),
as pulling from BR is time consuming, and I want to do it only once
and use the same "cache" for all my git clones.

I have a few git workdirs for my upstream work, but, as a patch
developer, I also have "independent"[1] git repositories.

[1] Due to disk constraints, the clones actually use --shared. So,
the common objects are actually stored inside a single tree.

Thanks,
Mauro
