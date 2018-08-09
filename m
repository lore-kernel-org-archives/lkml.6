Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4354121E17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPpQnQ44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4354121E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeHINmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730532AbeHINmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:42:19 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23169215E5;
        Thu,  9 Aug 2018 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533813475;
        bh=FG8rl2ZKU9tt8CaUHDFQCqtCbAjfoTTJGY3td899RkU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VPpQnQ44A8zuwQBcM0PKwAdRyaNFriYRIG+7HKAXDd5WGVozu9k4dGhiXzAC+DpGI
         ewpKHCVqUJ5C3BGQGsOlGoimYJNdaNRaAisQolVJHXtqyDu2X16mbpmIRrJdTJaMj8
         SMBymLC7hS7SRnQiET3VxwrA4HAb16CU6DQTW6tE=
Message-ID: <20411e8edbc29aa45599b408075548faa9a5b904.camel@kernel.org>
Subject: Re: [PATCH 5/5] fs/locks: create a tree of dependent requests.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Aug 2018 07:17:52 -0400
In-Reply-To: <153378028121.1220.4418653283078446336.stgit@noble>
References: <153378012255.1220.6754153662007899557.stgit@noble>
         <153378028121.1220.4418653283078446336.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 12:04 +1000, NeilBrown wrote:
> When we find an existing lock which conflicts with a request,
> and the request wants to wait, we currently add the request
> to a list.  When the lock is removed, the whole list is woken.
> This can cause the thundering-herd problem.
> To reduce the problem, we make use of the (new) fact that
> a pending request can itself have a list of blocked requests.
> When we find a conflict, we look through the existing blocked requests.
> If any one of them blocks the new request, the new request is attached
> below that request.
> This way, when the lock is released, only a set of non-conflicting
> locks will be woken.  The rest of the herd can stay asleep.
> 
> Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/locks.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index fc64016d01ee..17843feb6f5b 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -738,6 +738,39 @@ static void locks_delete_block(struct file_lock *waiter)
>  	spin_unlock(&blocked_lock_lock);
>  }
>  
> +static void wake_non_conflicts(struct file_lock *waiter, struct file_lock *blocker,
> +			       enum conflict conflict(struct file_lock *,
> +						      struct file_lock *))
> +{
> +	struct file_lock *parent = waiter;
> +	struct file_lock *fl;
> +	struct file_lock  *t;
> +
> +	fl = list_entry(&parent->fl_blocked, struct file_lock, fl_block);
> +restart:
> +	list_for_each_entry_safe_continue(fl, t, &parent->fl_blocked, fl_block) {
> +		switch (conflict(fl, blocker)) {
> +		default:

BUG or WARN here too please.

> +		case FL_NO_CONFLICT:
> +			__locks_wake_one(fl);
> +			break;
> +		case FL_CONFLICT:
> +			/* Need to check children */
> +			parent = fl;
> +			fl = list_entry(&parent->fl_blocked, struct file_lock, fl_block);
> +			goto restart;
> +		case FL_TRANSITIVE_CONFLICT:
> +			/* all children must also conflict, no need to check */
> +			continue;
> +		}
> +	}
> +	if (parent != waiter) {
> +		parent = parent->fl_blocker;
> +		fl = parent;
> +		goto restart;
> +	}
> +}
> +
>  /* Insert waiter into blocker's block list.
>   * We use a circular list so that processes can be easily woken up in
>   * the order they blocked. The documentation doesn't require this but
> @@ -747,11 +780,32 @@ static void locks_delete_block(struct file_lock *waiter)
>   * fl_blocked list itself is protected by the blocked_lock_lock, but by ensuring
>   * that the flc_lock is also held on insertions we can avoid taking the
>   * blocked_lock_lock in some cases when we see that the fl_blocked list is empty.
> + *
> + * Rather than just adding to the list, we check for conflicts with any existing
> + * waiter, and add to that waiter instead.
> + * Thus wakeups don't happen until needed.
>   */
>  static void __locks_insert_block(struct file_lock *blocker,
> -					struct file_lock *waiter)
> +				 struct file_lock *waiter,
> +				 enum conflict conflict(struct file_lock *,
> +							struct file_lock *))
>  {
> +	struct file_lock *fl;
>  	BUG_ON(!list_empty(&waiter->fl_block));
> +
> +	/* Any request in waiter->fl_blocked is know to conflict with

"known"

> +	 * waiter, but it might not conflict with blocker.
> +	 * If it doesn't, it needs to be woken now so it can find
> +	 * somewhere else to wait, or possible it can get granted.

"possibly it can be"

> +	 */
> +	if (conflict(waiter, blocker) != FL_TRANSITIVE_CONFLICT)
> +		wake_non_conflicts(waiter, blocker, conflict);
> +new_blocker:
> +	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
> +		if (conflict(fl, waiter)) {
> +			blocker =  fl;
> +			goto new_blocker;
> +		}
>  
> > 	waiter->fl_blocker = blocker;
>  	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
>  	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))

I wonder if it might be better to insert the blocker first before waking
up other waiters? Consider that anything awoken will end up contending
for the flc_lock that is held by "current" at this point. Doing most of
what you need to get done before waking them might mean less spinning in
other tasks.

> @@ -760,10 +814,12 @@ static void __locks_insert_block(struct file_lock *blocker,
>  
>  /* Must be called with flc_lock held. */
>  static void locks_insert_block(struct file_lock *blocker,
> -					struct file_lock *waiter)
> +			       struct file_lock *waiter,
> +			       enum conflict conflict(struct file_lock *,
> +						      struct file_lock *))
>  {
>  	spin_lock(&blocked_lock_lock);
> -	__locks_insert_block(blocker, waiter);
> +	__locks_insert_block(blocker, waiter, conflict);
>  	spin_unlock(&blocked_lock_lock);
>  }
>  
> @@ -1033,7 +1089,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
>  		if (!(request->fl_flags & FL_SLEEP))
>  			goto out;
>  		error = FILE_LOCK_DEFERRED;
> -		locks_insert_block(fl, request);
> +		locks_insert_block(fl, request, flock_locks_conflict);
>  		goto out;
>  	}
>  	if (request->fl_flags & FL_ACCESS)
> @@ -1107,7 +1163,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  			spin_lock(&blocked_lock_lock);
>  			if (likely(!posix_locks_deadlock(request, fl))) {
>  				error = FILE_LOCK_DEFERRED;
> -				__locks_insert_block(fl, request);
> +				__locks_insert_block(fl, request,
> +						     posix_locks_conflict);
>  			}
>  			spin_unlock(&blocked_lock_lock);
>  			goto out;
> @@ -1581,7 +1638,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  		break_time -= jiffies;
>  	if (break_time == 0)
>  		break_time++;
> -	locks_insert_block(fl, new_fl);
> +	locks_insert_block(fl, new_fl, leases_conflict);
>  	trace_break_lease_block(inode, new_fl);
>  	spin_unlock(&ctx->flc_lock);
>  	percpu_up_read_preempt_enable(&file_rwsem);
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

