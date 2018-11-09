Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA17C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154CE2081D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154CE2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeKIKQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:16:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:52986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbeKIKQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 05:16:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FA87AC15;
        Fri,  9 Nov 2018 00:38:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 09 Nov 2018 11:38:19 +1100
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] fs/locks: create a tree of dependent requests.
In-Reply-To: <20181108213030.GF6090@fieldses.org>
References: <154138128401.31651.1381177427603557514.stgit@noble> <154138144796.31651.14201944346371750178.stgit@noble> <20181108213030.GF6090@fieldses.org>
Message-ID: <87k1lnw0ec.fsf@notabene.neil.brown.name>
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

On Thu, Nov 08 2018, J. Bruce Fields wrote:

> On Mon, Nov 05, 2018 at 12:30:48PM +1100, NeilBrown wrote:
>> When we find an existing lock which conflicts with a request,
>> and the request wants to wait, we currently add the request
>> to a list.  When the lock is removed, the whole list is woken.
>> This can cause the thundering-herd problem.
>> To reduce the problem, we make use of the (new) fact that
>> a pending request can itself have a list of blocked requests.
>> When we find a conflict, we look through the existing blocked requests.
>> If any one of them blocks the new request, the new request is attached
>> below that request, otherwise it is added to the list of blocked
>> requests, which are now known to be mutually non-conflicting.
>>=20
>> This way, when the lock is released, only a set of non-conflicting
>> locks will be woken, the rest can stay asleep.
>> If the lock request cannot be granted and the request needs to be
>> requeued, all the other requests it blocks will then be woken
>
> So, to make sure I understand: the tree of blocking locks only ever has
> three levels (the active lock, the locks blocking on it, and their
> children?)

Not correct.
Blocks is only vertical, never horizontal.  Siblings never block each
other.
So one process hold a lock on a byte, and 27 other process want a lock
on that byte, then there will be 28 levels in a narrow tree - it is
effectively a queue.
Branching (via siblings) only happens when a child conflict with only
part of the lock held by the parent.
So if one process locks 32K, then two other processes request locks on
the 2 16K halves, then 4 processes request locks on the 8K quarters, and
so-on, then you could end up with 32767 processes in a binary tree, with
half of them all waiting on different individual bytes.

NeilBrown

>
> --b.
>
>>=20
>> Reported-and-tested-by: Martin Wilck <mwilck@suse.de>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  fs/locks.c |   29 +++++++++++++++++++++++------
>>  1 file changed, 23 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/locks.c b/fs/locks.c
>> index 802d5853acd5..1b0eac6b2918 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -715,11 +715,25 @@ static void locks_delete_block(struct file_lock *w=
aiter)
>>   * fl_blocked list itself is protected by the blocked_lock_lock, but by=
 ensuring
>>   * that the flc_lock is also held on insertions we can avoid taking the
>>   * blocked_lock_lock in some cases when we see that the fl_blocked list=
 is empty.
>> + *
>> + * Rather than just adding to the list, we check for conflicts with any=
 existing
>> + * waiters, and add beneath any waiter that blocks the new waiter.
>> + * Thus wakeups don't happen until needed.
>>   */
>>  static void __locks_insert_block(struct file_lock *blocker,
>> -					struct file_lock *waiter)
>> +				 struct file_lock *waiter,
>> +				 bool conflict(struct file_lock *,
>> +					       struct file_lock *))
>>  {
>> +	struct file_lock *fl;
>>  	BUG_ON(!list_empty(&waiter->fl_block));
>> +
>> +new_blocker:
>> +	list_for_each_entry(fl, &blocker->fl_blocked, fl_block)
>> +		if (conflict(fl, waiter)) {
>> +			blocker =3D  fl;
>> +			goto new_blocker;
>> +		}
>>  	waiter->fl_blocker =3D blocker;
>>  	list_add_tail(&waiter->fl_block, &blocker->fl_blocked);
>>  	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
>> @@ -734,10 +748,12 @@ static void __locks_insert_block(struct file_lock =
*blocker,
>>=20=20
>>  /* Must be called with flc_lock held. */
>>  static void locks_insert_block(struct file_lock *blocker,
>> -					struct file_lock *waiter)
>> +			       struct file_lock *waiter,
>> +			       bool conflict(struct file_lock *,
>> +					     struct file_lock *))
>>  {
>>  	spin_lock(&blocked_lock_lock);
>> -	__locks_insert_block(blocker, waiter);
>> +	__locks_insert_block(blocker, waiter, conflict);
>>  	spin_unlock(&blocked_lock_lock);
>>  }
>>=20=20
>> @@ -996,7 +1012,7 @@ static int flock_lock_inode(struct inode *inode, st=
ruct file_lock *request)
>>  		if (!(request->fl_flags & FL_SLEEP))
>>  			goto out;
>>  		error =3D FILE_LOCK_DEFERRED;
>> -		locks_insert_block(fl, request);
>> +		locks_insert_block(fl, request, flock_locks_conflict);
>>  		goto out;
>>  	}
>>  	if (request->fl_flags & FL_ACCESS)
>> @@ -1071,7 +1087,8 @@ static int posix_lock_inode(struct inode *inode, s=
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
>> @@ -1542,7 +1559,7 @@ int __break_lease(struct inode *inode, unsigned in=
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvk1vwACgkQOeye3VZi
gbn9gg/+I8gooPeWGWlXRUBkus3I0KbACY5ylbCT112HN+p+fjJGZtk9aoOLoaO0
GdRiDGYl6OXGCy9nIxJJR9XvKj5jLUqRFkBQByDCksvf+jNyZvgNTiQ2MiIMXFRY
nvTWqJzuMasUlE0d8u0LFv7Jn/Vmxcat4jbAZQA1Lf+LrkRjmCp/CAC/RSpQ4Zn3
82nk4yqgRKOrNYoHglAhK6TD9IXXFUbjbTpSzE2d+K0QH+6XCFa0VQaKXQN2/pCT
n/Iwsktc0eHh5jyus0NrKec2kzaJP6W+T/l4FBgWNQ3heF/z/NbIgTtRO9Rup6Yn
9sMVVUIeNFGv1Bz/bNGdeoYjQoH6SHn9HDhF+Ld2S3vfctYFfaPxeRwDNeb7pxG2
S2TsUOjr0QeRTJkG5DZJJKE1/SZyhpabUkvaN2J3feu5+0n5yagrjdlYZIDuOmWK
uC27+eNJiY8USDfPnc1I3IW5zS2KKtqua0ObEzDUDwRWWwl3OkcCnKclqLqluKMG
4MgAqIZQGEPThmv5IBvzH16osoJPZBdvuEAV3O50BdShTGtow5RwJ16FXSMDHz9K
rIMn6WD7MSZ4WbwAqgg2mEfpTkuuwkVnhSm+dfUJ5Yg9xFFE80Nn8VxG8toJU0wO
8mz75dpjZaHnziHAJ2vXc+QuIh/f76bLGFdI6jBaEkCfue8l56g=
=ByDd
-----END PGP SIGNATURE-----
--=-=-=--
