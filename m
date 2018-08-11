Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2780C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 12:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B39219C1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 12:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B39219C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHKOzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 10:55:52 -0400
Received: from fieldses.org ([173.255.197.46]:52420 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbeHKOzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 10:55:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 39F0CBD4; Sat, 11 Aug 2018 08:21:50 -0400 (EDT)
Date:   Sat, 11 Aug 2018 08:21:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
Message-ID: <20180811122150.GA15848@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble>
 <20180809173245.GM23873@fieldses.org>
 <87lg9frxyc.fsf@notabene.neil.brown.name>
 <20180810002922.GA3915@fieldses.org>
 <f1b9ca11a26eafbeb348bbfdf12d2ccdd43dc3c9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b9ca11a26eafbeb348bbfdf12d2ccdd43dc3c9.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 07:51:13AM -0400, Jeff Layton wrote:
> On Thu, 2018-08-09 at 20:29 -0400, J. Bruce Fields wrote:
> > On Fri, Aug 10, 2018 at 08:12:43AM +1000, NeilBrown wrote:
> > > On Thu, Aug 09 2018, J. Bruce Fields wrote:
> > > 
> > > > I think there's also a problem with multiple tasks sharing the same
> > > > lock owner.
> > > > 
> > > > So, all locks are exclusive locks for the same range.  We have four
> > > > tasks.  Tasks 1 and 4 share the same owner, the others' owners are
> > > > distinct.
> > > > 
> > > > 	- Task 1 gets a lock.
> > > > 	- Task 2 gets a conflicting lock.
> > > > 	- Task 3 gets another conflicting lock.  So now we the tree is
> > > > 		3->2->1.
> > > > 	- Task 1's lock is released.
> > > > 	- Before task 2 is scheduled, task 4 acquires a new lock.
> > > > 	- Task 2 waits on task 4's lock, we now have
> > > > 		3->2->4.
> > > > 
> > > > Task 3 shouldn't be waiting--the lock it's requesting has the same owner
> > > > as the lock task 4 holds--but we fail to wake up task 3.
> > > 
> > > So task 1 and task 4 are threads in the one process - OK.
> > > Tasks 2 and 3 are threads in two other processes.
> > > 
> > > So 2 and 3 conflict with either 1 or 4 equally - why should task 3 be
> > > woken?
> > > 
> > > I suspect you got the numbers bit mixed up,
> > 
> > Whoops.
> > 
> > > but in any case, the "conflict()" function that is passed around takes
> > > ownership into account when assessing if one lock conflicts with
> > > another.
> > 
> > Right, I know, but, let me try again:
> > 
> > All locks are exclusive locks for the same range.  Only tasks 3 and 4
> > share the the same owner.
> > 
> > 	- Task 1 gets a lock.
> > 	- Task 2 requests a conflicting lock, so we have    2->1.
> > 	- Task 3 requests a conflicting lock, so we have 3->2->1.
> > 	- Task 1 unlocks.  We wake up task 2, but it isn't scheduled yet.
> > 	- Task 4 gets a new lock.
> > 	- Task 2 runs, discovers the conflict, and waits.  Now we have:
> > 		3->2->4.
> > 
> > There is no conflict between the lock 3 requested and the lock 4 holds,
> > but 3 is not woken up.
> > 
> > This is another version of the first problem: there's information we
> > need (the owners of the waiting locks in the tree) that we can't
> > determine just from looking at the root of the tree.
> > 
> > I'm not sure what to do about that.
> > 
> 
> Is this still a problem in the v2 set?
> 
> wake_non_conflicts walks the whole tree of requests that were blocked on
> it,

Not in the FL_TRANSITIVE_CONFLICT case, which is the case here.

--b.

> so a. After task 2 discovers the conflict, it should wake any of its
> children that don't conflict. So in that last step, task 3 would be
> awoken before task 2 goes back to sleep.
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
