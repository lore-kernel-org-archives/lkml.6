Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20568C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B7521EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B7521EFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeHJBwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:52:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHJBwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:52:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62FB8AEE2;
        Thu,  9 Aug 2018 23:25:15 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 10 Aug 2018 09:25:04 +1000
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] fs/locks: create a tree of dependent requests.
In-Reply-To: <20411e8edbc29aa45599b408075548faa9a5b904.camel@kernel.org>
References: <153378012255.1220.6754153662007899557.stgit@noble> <153378028121.1220.4418653283078446336.stgit@noble> <20411e8edbc29aa45599b408075548faa9a5b904.camel@kernel.org>
Message-ID: <87ftznrulr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09 2018, Jeff Layton wrote:

> On Thu, 2018-08-09 at 12:04 +1000, NeilBrown wrote:
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
>
> BUG or WARN here too please.

Maybe .... I'd rather not have the default case at all.
I can remove this one, but if I remove the next one, gcc complains
../fs/locks.c: In function =E2=80=98posix_locks_conflict=E2=80=99:
../fs/locks.c:912:1: warning: control reaches end of non-void function [-Wr=
eturn-type]

event though control cannot reach the end of the function.
Maybe:
	switch (locks_conflict(caller_fl, sys_fl)) {
	default:
		WARN(1, "locks_conflict returned impossible value");
		/* fallthrough */
	case FL_NO_CONFLICT:


>
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
>
> "known"
>
>> +	 * waiter, but it might not conflict with blocker.
>> +	 * If it doesn't, it needs to be woken now so it can find
>> +	 * somewhere else to wait, or possible it can get granted.
>
> "possibly it can be"

Both fixed, thanks.

>
>> +	 */
>> +	if (conflict(waiter, blocker) !=3D FL_TRANSITIVE_CONFLICT)
>> +		wake_non_conflicts(waiter, blocker, conflict);
>> +new_blocker:
>> +	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
>> +		if (conflict(fl, waiter)) {
>> +			blocker =3D  fl;
>> +			goto new_blocker;
>> +		}
>>=20=20
>> > 	waiter->fl_blocker =3D blocker;
>>  	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
>>  	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
>
> I wonder if it might be better to insert the blocker first before waking
> up other waiters? Consider that anything awoken will end up contending
> for the flc_lock that is held by "current" at this point. Doing most of
> what you need to get done before waking them might mean less spinning in
> other tasks.
>

Maybe.
I think you are suggesting we move the call to wake_non_conflicts() to
the end of the function.
The main reason I put it at the top is to use the original value of
"blocker" before it gets changed.
Even if we move it to the end, there is still quite a few other little
tasks to be performed before the lock is dropped.

Will all this get done before some other processor has a chance to wake
up a process, and for that process to get a to spinlock ???

Maybe - though the first spinlock would be blocked_lock_lock in
locks_delete_block(), and that is dropped almost immediately.

I don't know ... it seems much of a muchness.
If the process will be woken that quickly, then some other processor
must be idle, and does it matter much if it spends a microsecond
spinning on a lock rather than being idle a bit longer?

Thanks.
I won't to do a least a little testing before I repost with any of these
changes.

NeilBrown


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
>>=20
>
> --=20
> Jeff Layton <jlayton@kernel.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltszVEACgkQOeye3VZi
gbnq1hAAvffJDaRdkkPTBNUzQrBJA51Di24m40TEKvR7hJOqgjifG3POiLhBTKxO
PIL5xmaWz9lenAeSvfsOyxRQJM9W7YBuliE05H4H6tIrz3nUG+XEWH/JIxmSVk0b
0JsE38lvCJddkAnuNDANA+qff/4wHygCf97a7mxnyexacuH9ZP+hHDwUej6YYaG4
HrV5p/J9P8jPK2ismgbun8agViJNuw29CMx/MEgTc72bCykQG4Hjtfp0F+hKKk7b
IxMmK7jhJHMooE1QEo7y4tOgvljJPzhY9OdDFTZ9yhunKJYeVi2lFxRFkZy8scM3
DXK1TYRKS13JXV+Qhc9ORdzw0/ZsG63naYM3J1vCnm9ePtQ4KMu58lpa83T+R2Tf
kLFoSjAyCQSxt2LNnNYVv3DhrvP8unRJvUuaAbohsdOGbg7y17o1Pb6JfpOvpwWP
LyXB82fuyMM9Xtpnxu39oOcb4UmtkfxcP3iEW9Ar8vWMED8Y5BWZutFLfD33eh3I
GmZRMsvnBE61A2p73ZbgRQhzVzOPSu+yBpzGtkqAhbjpFVVh6oxPEDFEcSObNGlD
gewKLlcdKMU/9e1yvjCatN8JyYRhwoFgaZ1l6Wy6tTn0MvgLnE1qYWMiA+8RfAmm
bo4in5tJYuhQX+hE82Ckd97wdOyflQo4/ZfFZF5JYm37l4rOm3w=
=lxmD
-----END PGP SIGNATURE-----
--=-=-=--
