Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BCEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2EC22395
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2EC22395
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHJAqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:46:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeHJAqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:46:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6861AFFE;
        Thu,  9 Aug 2018 22:19:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 10 Aug 2018 08:19:26 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/locks: create a tree of dependent requests.
In-Reply-To: <20180809141341.GI23873@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble> <153378028121.1220.4418653283078446336.stgit@noble> <20180809141341.GI23873@fieldses.org>
Message-ID: <87in4jrxn5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09 2018, J. Bruce Fields wrote:

> On Thu, Aug 09, 2018 at 12:04:41PM +1000, NeilBrown wrote:
>> When we find an existing lock which conflicts with a request,
>> and the request wants to wait, we currently add the request
>> to a list.  When the lock is removed, the whole list is woken.
>> This can cause the thundering-herd problem.
>> To reduce the problem, we make use of the (new) fact that
>> a pending request can itself have a list of blocked requests.
>> When we find a conflict, we look through the existing blocked requests.
>> If any one of them blocks the new request, the new request is attached
>> below that request.
>> This way, when the lock is released, only a set of non-conflicting
>> locks will be woken.  The rest of the herd can stay asleep.
>
> That that's not true any more--some of the locks you wake may conflict
> with each other.  Is that right?  Which is fine (the possibility of
> thundering herds in weird overlapping-range cases probably isn't a big
> deal).  I just want to make sure I understand....

Yes, you are correct.
Lock waiters will be woken if they were directly blocked by a lock that
has been released, if they were blocked (directly or indirectly) by a
lock which is now blocked by a lock that they don't conflict with.
The first set will be mutually non-conflicting.

>
> I think you could simplify the code a lot by maintaining the tree so
> that it always satisfies the condition that waiters are always strictly
> "weaker" than their descendents, so that finding a conflict with a
> waiter is always enough to know that the descendents also conflict.

Can you define "weaker" please.
I suspect it is a partial ordering, in which case a tree would normally
be more appropriate than trying to find a total ordering.

Thanks,
NeilBrown

>
> So, when you put a waiter to sleep, you don't add it below a child
> unless it's "stronger" than the child.
>
> You give up the property that siblings don't conflict, but again that
> just means thundering herds in weird cases, which is OK.
>
> --b.
>
>>=20
>> Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  fs/locks.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-----
>>  1 file changed, 63 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index fc64016d01ee..17843feb6f5b 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -738,6 +738,39 @@ static void locks_delete_block(struct file_lock *wa=
iter)
>>  	spin_unlock(&blocked_lock_lock);
>>  }
>>=20=20
>> +static void wake_non_conflicts(struct file_lock *waiter, struct file_lo=
ck *blocker,
>> +			       enum conflict conflict(struct file_lock *,
>> +						      struct file_lock *))
>> +{
>> +	struct file_lock *parent =3D waiter;
>> +	struct file_lock *fl;
>> +	struct file_lock  *t;
>> +
>> +	fl =3D list_entry(&parent->fl_blocked, struct file_lock, fl_block);
>> +restart:
>> +	list_for_each_entry_safe_continue(fl, t, &parent->fl_blocked, fl_block=
) {
>> +		switch (conflict(fl, blocker)) {
>> +		default:
>> +		case FL_NO_CONFLICT:
>> +			__locks_wake_one(fl);
>> +			break;
>> +		case FL_CONFLICT:
>> +			/* Need to check children */
>> +			parent =3D fl;
>> +			fl =3D list_entry(&parent->fl_blocked, struct file_lock, fl_block);
>> +			goto restart;
>> +		case FL_TRANSITIVE_CONFLICT:
>> +			/* all children must also conflict, no need to check */
>> +			continue;
>> +		}
>> +	}
>> +	if (parent !=3D waiter) {
>> +		parent =3D parent->fl_blocker;
>> +		fl =3D parent;
>> +		goto restart;
>> +	}
>> +}
>> +
>>  /* Insert waiter into blocker's block list.
>>   * We use a circular list so that processes can be easily woken up in
>>   * the order they blocked. The documentation doesn't require this but
>> @@ -747,11 +780,32 @@ static void locks_delete_block(struct file_lock *w=
aiter)
>>   * fl_blocked list itself is protected by the blocked_lock_lock, but by=
 ensuring
>>   * that the flc_lock is also held on insertions we can avoid taking the
>>   * blocked_lock_lock in some cases when we see that the fl_blocked list=
 is empty.
>> + *
>> + * Rather than just adding to the list, we check for conflicts with any=
 existing
>> + * waiter, and add to that waiter instead.
>> + * Thus wakeups don't happen until needed.
>>   */
>>  static void __locks_insert_block(struct file_lock *blocker,
>> -					struct file_lock *waiter)
>> +				 struct file_lock *waiter,
>> +				 enum conflict conflict(struct file_lock *,
>> +							struct file_lock *))
>>  {
>> +	struct file_lock *fl;
>>  	BUG_ON(!list_empty(&waiter->fl_block));
>> +
>> +	/* Any request in waiter->fl_blocked is know to conflict with
>> +	 * waiter, but it might not conflict with blocker.
>> +	 * If it doesn't, it needs to be woken now so it can find
>> +	 * somewhere else to wait, or possible it can get granted.
>> +	 */
>> +	if (conflict(waiter, blocker) !=3D FL_TRANSITIVE_CONFLICT)
>> +		wake_non_conflicts(waiter, blocker, conflict);
>> +new_blocker:
>> +	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
>> +		if (conflict(fl, waiter)) {
>> +			blocker =3D  fl;
>> +			goto new_blocker;
>> +		}
>>  	waiter->fl_blocker =3D blocker;
>>  	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
>>  	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
>> @@ -760,10 +814,12 @@ static void __locks_insert_block(struct file_lock =
*blocker,
>>=20=20
>>  /* Must be called with flc_lock held. */
>>  static void locks_insert_block(struct file_lock *blocker,
>> -					struct file_lock *waiter)
>> +			       struct file_lock *waiter,
>> +			       enum conflict conflict(struct file_lock *,
>> +						      struct file_lock *))
>>  {
>>  	spin_lock(&blocked_lock_lock);
>> -	__locks_insert_block(blocker, waiter);
>> +	__locks_insert_block(blocker, waiter, conflict);
>>  	spin_unlock(&blocked_lock_lock);
>>  }
>>=20=20
>> @@ -1033,7 +1089,7 @@ static int flock_lock_inode(struct inode *inode, s=
truct file_lock *request)
>>  		if (!(request->fl_flags & FL_SLEEP))
>>  			goto out;
>>  		error =3D FILE_LOCK_DEFERRED;
>> -		locks_insert_block(fl, request);
>> +		locks_insert_block(fl, request, flock_locks_conflict);
>>  		goto out;
>>  	}
>>  	if (request->fl_flags & FL_ACCESS)
>> @@ -1107,7 +1163,8 @@ static int posix_lock_inode(struct inode *inode, s=
truct file_lock *request,
>>  			spin_lock(&blocked_lock_lock);
>>  			if (likely(!posix_locks_deadlock(request, fl))) {
>>  				error =3D FILE_LOCK_DEFERRED;
>> -				__locks_insert_block(fl, request);
>> +				__locks_insert_block(fl, request,
>> +						     posix_locks_conflict);
>>  			}
>>  			spin_unlock(&blocked_lock_lock);
>>  			goto out;
>> @@ -1581,7 +1638,7 @@ int __break_lease(struct inode *inode, unsigned in=
t mode, unsigned int type)
>>  		break_time -=3D jiffies;
>>  	if (break_time =3D=3D 0)
>>  		break_time++;
>> -	locks_insert_block(fl, new_fl);
>> +	locks_insert_block(fl, new_fl, leases_conflict);
>>  	trace_break_lease_block(inode, new_fl);
>>  	spin_unlock(&ctx->flc_lock);
>>  	percpu_up_read_preempt_enable(&file_rwsem);
>>=20

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltsve4ACgkQOeye3VZi
gbmHaRAAgSYqe2wcJMzrbnTFKrL7QWN/LSe8cMM/5QbCWhJU1HmoIxujWMQuIIb5
53idIbv6EkPvC73BukXIF/oWTFm99t7YmvS7gZte3Y/BIirQ4edTNDU+G66AEqcP
k+mqEDG1ir/C9FNU2gabUcqCq3SiMN2hj6h0Vvx15OC7Okhdom+b1NmADTt8Iryy
RvFKjGIw9BL8L+F5O4iv/sYNEiofQnjbDBoEnZQ9VPQ4pdOd4osfGO1DoBTwESM5
o9KuRod/5Km7Q/FdBoQQ6e7Xo1/Yt5xayXUDkJtsDRTWOXeHGdv8r/dKQkEGwwEu
DDGWU1hfxUt7CsjdBIWUYz0h0DLZi+6Ul80Qdoa4fLgeZeiE/IzwUe2DIKscdHH4
PE3a2OT3WqjCbR1nu7klSveM9rrvREQCZWxyNbrEd49MojPdIohfIhZYQeMR3PS7
3Y1g2LiA6Lovq6652UQt0Zgb8L0f4jHCvnh8iD4XsAirMe4J/ICXW0L3iXNAqen2
8HzhpwAF8jjYAj5d5d8JFSGV1hlKa7dGLikDBltVRT6qT4uIZygGwGbt/mUPgI+W
Fs7mml2YJtinpgNo21ZX0YMEKKNNghUW9la0o22H+mef3NtJstYeDO5ydz6qCWRl
fpwwGr8kRUjz7MNgMfn0HpfwbOKSd4d/aIKmEpkI58UqnbBMjXI=
=8rFu
-----END PGP SIGNATURE-----
--=-=-=--
