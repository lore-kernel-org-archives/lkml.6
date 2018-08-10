Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A397C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F234022408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F234022408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeHJSSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:18:06 -0400
Received: from fieldses.org ([173.255.197.46]:50756 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbeHJSSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:18:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id DC5CFBD4; Fri, 10 Aug 2018 11:47:42 -0400 (EDT)
Date:   Fri, 10 Aug 2018 11:47:42 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
Message-ID: <20180810154742.GE7906@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
 <20180809173245.GM23873@fieldses.org>
 <87lg9frxyc.fsf@notabene.neil.brown.name>
 <20180810002922.GA3915@fieldses.org>
 <871sb7rnul.fsf@notabene.neil.brown.name>
 <20180810025251.GO23873@fieldses.org>
 <87y3derjut.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3derjut.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 01:17:14PM +1000, NeilBrown wrote:
> On Thu, Aug 09 2018, J. Bruce Fields wrote:
> 
> > On Fri, Aug 10, 2018 at 11:50:58AM +1000, NeilBrown wrote:
> >> You're good at this game!
> >
> > Everybody's got to have a hobby, mine is pathological posix locking
> > cases....
> >
> >> So, because a locker with the same "owner" gets a free pass, you can
> >> *never* say that any lock which conflicts with A also conflicts with B,
> >> as a lock with the same owner as B will never conflict with B, even
> >> though it conflicts with A.
> >> 
> >> I think there is still value in having the tree, but when a waiter is
> >> attached under a new blocker, we need to walk the whole tree beneath the
> >> waiter and detach/wake anything that is not blocked by the new blocker.
> >
> > If you're walking the whole tree every time then it might as well be a
> > flat list, I think?
> 
> The advantage of a tree is that it keeps over-lapping locks closer
> together.
> For it to make a difference you would need a load where lots of threads
> were locking several different small ranges, and other threads were
> locking large ranges that cover all the small ranges.

OK, I'm not sure I understand, but I'll give another look at the next
version....

> I doubt this is common, but it doesn't seem as strange as other things
> I've seen in the wild.
> The other advantage, of course, is that I've already written the code,
> and I like it.
> 
> Maybe I'll do a simple-list version, then a patch to convert that to the
> clever-tree version, and we can then have something concrete to assess.

That might help, thanks.

--b.
