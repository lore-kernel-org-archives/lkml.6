Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C8BC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 12:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E00321D68
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 12:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E00321D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHKPJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 11:09:30 -0400
Received: from fieldses.org ([173.255.197.46]:52446 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeHKPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 11:09:30 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id AA772BD4; Sat, 11 Aug 2018 08:35:26 -0400 (EDT)
Date:   Sat, 11 Aug 2018 08:35:26 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
Message-ID: <20180811123526.GB15848@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
 <20180809173245.GM23873@fieldses.org>
 <87lg9frxyc.fsf@notabene.neil.brown.name>
 <20180810002922.GA3915@fieldses.org>
 <871sb7rnul.fsf@notabene.neil.brown.name>
 <20180810025251.GO23873@fieldses.org>
 <87y3derjut.fsf@notabene.neil.brown.name>
 <20180810154742.GE7906@fieldses.org>
 <0f198c62b057ab7d796746144d458835a6c7433e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f198c62b057ab7d796746144d458835a6c7433e.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 07:56:25AM -0400, Jeff Layton wrote:
> FWIW, I did a bit of testing with lockperf tests that I had written on
> an earlier rework of this code:
> 
>     https://git.samba.org/jlayton/linux.git/?p=jlayton/lockperf.git;a=summary
> 
> 
> The posix01 and flock01 tests in there show about a 10x speedup with
> this set in place.
> 
> I think something closer to Neil's design will end up being what we want
> here. Consider the relatively common case where you have a whole-file
> POSIX write lock held with a bunch of different waiters blocked on it
> (all whole file write locks with different owners):
> 
> With Neil's patches, you will just wake up a single waiter when the
> blocked lock is released, as they would all be in a long chain of
> waiters.

Right, but you still need to walk the whole tree to make sure that it's
the only one you need to wake.  The tree structure means that you know
all the other locks have non-overlapping ranges, but it doesn't tell you
the lock owners.

Maybe there's some reasonable way to rule out the shared-lockowner case
more quickly too.  I haven't thought about that much.

> If you keep all the locks in a single list, you'll either have to:
> 
> a) wake up all the waiters on the list when the lock comes free: no lock
> is held at that point so none of them will conflict.
> 
> ...or...
> 
> b) keep track of what waiters have already been awoken, and compare any
> further candidate for waking against the current set of held locks and
> any lock requests by waiters that you just woke.

Instead of keeping track of *every* waiter that you've woken, you could
keep track of some subset.  Worst case that just means waking more
processes than you need to, which is wasteful but correct.

In the common case that you give, that subset could just be "the first
waiter you wake".  You'd get the same result.

The every-waiter-a-whole-file-write-lock case is pretty easy.  To
benefit from the tree you need a case where some of the waiters overlap
and some don't.

Might be worth it, sure.

--b.

> b seems more expensive as you have to walk over a larger set of locks
> on every change.
> -- 
> Jeff Layton <jlayton@kernel.org>
