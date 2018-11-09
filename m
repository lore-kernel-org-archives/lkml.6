Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A3C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E672086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 03:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E672086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeKIMru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:47:50 -0500
Received: from fieldses.org ([173.255.197.46]:39454 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeKIMrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:47:49 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id CB2581E29; Thu,  8 Nov 2018 22:09:13 -0500 (EST)
Date:   Thu, 8 Nov 2018 22:09:13 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] fs/locks: create a tree of dependent requests.
Message-ID: <20181109030913.GA8831@fieldses.org>
References: <154138128401.31651.1381177427603557514.stgit@noble>
 <154138144796.31651.14201944346371750178.stgit@noble>
 <20181108213030.GF6090@fieldses.org>
 <87k1lnw0ec.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1lnw0ec.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 11:38:19AM +1100, NeilBrown wrote:
> On Thu, Nov 08 2018, J. Bruce Fields wrote:
> 
> > On Mon, Nov 05, 2018 at 12:30:48PM +1100, NeilBrown wrote:
> >> When we find an existing lock which conflicts with a request,
> >> and the request wants to wait, we currently add the request
> >> to a list.  When the lock is removed, the whole list is woken.
> >> This can cause the thundering-herd problem.
> >> To reduce the problem, we make use of the (new) fact that
> >> a pending request can itself have a list of blocked requests.
> >> When we find a conflict, we look through the existing blocked requests.
> >> If any one of them blocks the new request, the new request is attached
> >> below that request, otherwise it is added to the list of blocked
> >> requests, which are now known to be mutually non-conflicting.
> >> 
> >> This way, when the lock is released, only a set of non-conflicting
> >> locks will be woken, the rest can stay asleep.
> >> If the lock request cannot be granted and the request needs to be
> >> requeued, all the other requests it blocks will then be woken
> >
> > So, to make sure I understand: the tree of blocking locks only ever has
> > three levels (the active lock, the locks blocking on it, and their
> > children?)
> 
> Not correct.
> Blocks is only vertical, never horizontal.  Siblings never block each
> other.
> So one process hold a lock on a byte, and 27 other process want a lock
> on that byte, then there will be 28 levels in a narrow tree - it is
> effectively a queue.
> Branching (via siblings) only happens when a child conflict with only
> part of the lock held by the parent.
> So if one process locks 32K, then two other processes request locks on
> the 2 16K halves, then 4 processes request locks on the 8K quarters, and
> so-on, then you could end up with 32767 processes in a binary tree, with
> half of them all waiting on different individual bytes.

Maybe I should actually read the code carefully instead of just skimming
the changelog and jumping to conclusions.

I think this is correct, but I wish we had an actual written-out
argument that it's correct, because intuition isn't a great guide for
posix file locks.

Maybe:

Waiting and applied locks are all kept in trees whose properties are:

	- the root of a tree may be an applied or unapplied lock.
	- every other node in the tree is an unapplied lock that
	  conflicts with every ancestor of that node.

Every such tree begins life as an unapplied singleton which obviously
satisfies the above properties.

The only ways we modify trees preserve these properties:

	1. We may add a new child, but only after first verifying that it
	   conflicts with all of its ancestors.
	2. We may remove the root of a tree, creating a new singleton
	   tree from the root and N new trees rooted in the immediate
	   children.
	3. If the root of a tree is not currently an applied lock, we may
	   apply it (if possible).
	4. We may upgrade the root of the tree (either extend its range,
	   or upgrade its entire range from read to write).

When an applied lock is modified in a way that reduces or downgrades any
part of its range, we remove all its children (2 above).

For each of those child trees: if the root of the tree applies, we do so
(3).  If it doesn't, it must conflict with some applied lock.  We remove
all of its children (2), and add it is a new leaf to the tree rooted in
the applied lock (1).  We then repeat the process recursively with those
children.

Something like that.

--b.

> 
> NeilBrown
> 
> >
> > --b.
> >
> >> 
> >> Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
> >> Signed-off-by: NeilBrown <neilb@suse.com>
> >> ---
> >>  fs/locks.c |   29 +++++++++++++++++++++++------
> >>  1 file changed, 23 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/fs/locks.c b/fs/locks.c
> >> index 802d5853acd5..1b0eac6b2918 100644
> >> --- a/fs/locks.c
> >> +++ b/fs/locks.c
> >> @@ -715,11 +715,25 @@ static void locks_delete_block(struct file_lock *waiter)
> >>   * fl_blocked list itself is protected by the blocked_lock_lock, but by ensuring
> >>   * that the flc_lock is also held on insertions we can avoid taking the
> >>   * blocked_lock_lock in some cases when we see that the fl_blocked list is empty.
> >> + *
> >> + * Rather than just adding to the list, we check for conflicts with any existing
> >> + * waiters, and add beneath any waiter that blocks the new waiter.
> >> + * Thus wakeups don't happen until needed.
> >>   */
> >>  static void __locks_insert_block(struct file_lock *blocker,
> >> -					struct file_lock *waiter)
> >> +				 struct file_lock *waiter,
> >> +				 bool conflict(struct file_lock *,
> >> +					       struct file_lock *))
> >>  {
> >> +	struct file_lock *fl;
> >>  	BUG_ON(!list_empty(&waiter->fl_block));
> >> +
> >> +new_blocker:
> >> +	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
> >> +		if (conflict(fl, waiter)) {
> >> +			blocker =  fl;
> >> +			goto new_blocker;
> >> +		}
> >>  	waiter->fl_blocker = blocker;
> >>  	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
> >>  	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
> >> @@ -734,10 +748,12 @@ static void __locks_insert_block(struct file_lock *blocker,
> >>  
> >>  /* Must be called with flc_lock held. */
> >>  static void locks_insert_block(struct file_lock *blocker,
> >> -					struct file_lock *waiter)
> >> +			       struct file_lock *waiter,
> >> +			       bool conflict(struct file_lock *,
> >> +					     struct file_lock *))
> >>  {
> >>  	spin_lock(&blocked_lock_lock);
> >> -	__locks_insert_block(blocker, waiter);
> >> +	__locks_insert_block(blocker, waiter, conflict);
> >>  	spin_unlock(&blocked_lock_lock);
> >>  }
> >>  
> >> @@ -996,7 +1012,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
> >>  		if (!(request->fl_flags & FL_SLEEP))
> >>  			goto out;
> >>  		error = FILE_LOCK_DEFERRED;
> >> -		locks_insert_block(fl, request);
> >> +		locks_insert_block(fl, request, flock_locks_conflict);
> >>  		goto out;
> >>  	}
> >>  	if (request->fl_flags & FL_ACCESS)
> >> @@ -1071,7 +1087,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> >>  			spin_lock(&blocked_lock_lock);
> >>  			if (likely(!posix_locks_deadlock(request, fl))) {
> >>  				error = FILE_LOCK_DEFERRED;
> >> -				__locks_insert_block(fl, request);
> >> +				__locks_insert_block(fl, request,
> >> +						     posix_locks_conflict);
> >>  			}
> >>  			spin_unlock(&blocked_lock_lock);
> >>  			goto out;
> >> @@ -1542,7 +1559,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
> >>  		break_time -= jiffies;
> >>  	if (break_time == 0)
> >>  		break_time++;
> >> -	locks_insert_block(fl, new_fl);
> >> +	locks_insert_block(fl, new_fl, leases_conflict);
> >>  	trace_break_lease_block(inode, new_fl);
> >>  	spin_unlock(&ctx->flc_lock);
> >>  	percpu_up_read_preempt_enable(&file_rwsem);
> >> 


