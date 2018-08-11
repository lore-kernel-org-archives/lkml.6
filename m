Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73205C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2102422392
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 11:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8vb9esN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2102422392
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbeHKOa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 10:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbeHKOa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 10:30:26 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5053221EB6;
        Sat, 11 Aug 2018 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533988587;
        bh=aVS1gRD3+urPpUIY6bgKnp/wC73c3RhohIWBM5l5g0Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=u8vb9esN3FXCRTzpZwyBuWSgmYpfz1WVUBCiqsMmqAYXyXPFnr3poNj2oQXGCp8K8
         mJrBKINKYNKg0zseQBF/TDrCdY9KikC6P6lC4xqIyAmjz+hCFi+xvNXwUEbGz9fdn9
         Oja9IzWHf2q5Tn8NfXURao3a8JQGPWN2XkN3fqeI=
Message-ID: <0f198c62b057ab7d796746144d458835a6c7433e.camel@kernel.org>
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 11 Aug 2018 07:56:25 -0400
In-Reply-To: <20180810154742.GE7906@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
         <20180809173245.GM23873@fieldses.org>
         <87lg9frxyc.fsf@notabene.neil.brown.name>
         <20180810002922.GA3915@fieldses.org>
         <871sb7rnul.fsf@notabene.neil.brown.name>
         <20180810025251.GO23873@fieldses.org>
         <87y3derjut.fsf@notabene.neil.brown.name>
         <20180810154742.GE7906@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 11:47 -0400, J. Bruce Fields wrote:
> On Fri, Aug 10, 2018 at 01:17:14PM +1000, NeilBrown wrote:
> > On Thu, Aug 09 2018, J. Bruce Fields wrote:
> > 
> > > On Fri, Aug 10, 2018 at 11:50:58AM +1000, NeilBrown wrote:
> > > > You're good at this game!
> > > 
> > > Everybody's got to have a hobby, mine is pathological posix locking
> > > cases....
> > > 
> > > > So, because a locker with the same "owner" gets a free pass, you can
> > > > *never* say that any lock which conflicts with A also conflicts with B,
> > > > as a lock with the same owner as B will never conflict with B, even
> > > > though it conflicts with A.
> > > > 
> > > > I think there is still value in having the tree, but when a waiter is
> > > > attached under a new blocker, we need to walk the whole tree beneath the
> > > > waiter and detach/wake anything that is not blocked by the new blocker.
> > > 
> > > If you're walking the whole tree every time then it might as well be a
> > > flat list, I think?
> > 
> > The advantage of a tree is that it keeps over-lapping locks closer
> > together.
> > For it to make a difference you would need a load where lots of threads
> > were locking several different small ranges, and other threads were
> > locking large ranges that cover all the small ranges.
> 
> OK, I'm not sure I understand, but I'll give another look at the next
> version....
> 
> > I doubt this is common, but it doesn't seem as strange as other things
> > I've seen in the wild.
> > The other advantage, of course, is that I've already written the code,
> > and I like it.
> > 
> > Maybe I'll do a simple-list version, then a patch to convert that to the
> > clever-tree version, and we can then have something concrete to assess.
> 
> That might help, thanks.
> 

FWIW, I did a bit of testing with lockperf tests that I had written on
an earlier rework of this code:

    https://git.samba.org/jlayton/linux.git/?p=jlayton/lockperf.git;a=summary


The posix01 and flock01 tests in there show about a 10x speedup with
this set in place.

I think something closer to Neil's design will end up being what we want
here. Consider the relatively common case where you have a whole-file
POSIX write lock held with a bunch of different waiters blocked on it
(all whole file write locks with different owners):

With Neil's patches, you will just wake up a single waiter when the
blocked lock is released, as they would all be in a long chain of
waiters.

If you keep all the locks in a single list, you'll either have to:

a) wake up all the waiters on the list when the lock comes free: no lock
is held at that point so none of them will conflict.

...or...

b) keep track of what waiters have already been awoken, and compare any
further candidate for waking against the current set of held locks and
any lock requests by waiters that you just woke.

b seems more expensive as you have to walk over a larger set of locks
on every change.
-- 
Jeff Layton <jlayton@kernel.org>

