Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB7A2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeGUDQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:16:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbeGUDQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:16:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CFA7ADC5;
        Sat, 21 Jul 2018 02:25:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     paulmck@linux.vnet.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Sat, 21 Jul 2018 12:25:41 +1000
Cc:     Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rhashtable: don't hold lock on first table throughout insertion.
In-Reply-To: <20180720144152.GW12945@linux.vnet.ibm.com>
References: <153086169828.24852.10332573315056854948.stgit@noble> <153086175009.24852.7782466383056542839.stgit@noble> <20180720075409.kfckhodsnvktift7@gondor.apana.org.au> <20180720144152.GW12945@linux.vnet.ibm.com>
Message-ID: <87muulqq8q.fsf@notabene.neil.brown.name>
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

On Fri, Jul 20 2018, Paul E. McKenney wrote:

> On Fri, Jul 20, 2018 at 03:54:09PM +0800, Herbert Xu wrote:
>> On Fri, Jul 06, 2018 at 05:22:30PM +1000, NeilBrown wrote:
>> > rhashtable_try_insert() currently hold a lock on the bucket in
>> > the first table, while also locking buckets in subsequent tables.
>> > This is unnecessary and looks like a hold-over from some earlier
>> > version of the implementation.
>> >=20
>> > As insert and remove always lock a bucket in each table in turn, and
>> > as insert only inserts in the final table, there cannot be any races
>> > that are not covered by simply locking a bucket in each table in turn.
>> >=20
>> > When an insert call reaches that last table it can be sure that there
>> > is no match entry in any other table as it has searched them all, and
>> > insertion never happens anywhere but in the last table.  The fact that
>> > code tests for the existence of future_tbl while holding a lock on
>> > the relevant bucket ensures that two threads inserting the same key
>> > will make compatible decisions about which is the "last" table.
>> >=20
>> > This simplifies the code and allows the ->rehash field to be
>> > discarded.
>> >=20
>> > We still need a way to ensure that a dead bucket_table is never
>> > re-linked by rhashtable_walk_stop().  This can be achieved by
>> > calling call_rcu() inside the locked region, and checking
>> > ->rcu.func in rhashtable_walk_stop().  If it is not NULL, then
>> > the bucket table is empty and dead.
>> >=20
>> > Signed-off-by: NeilBrown <neilb@suse.com>
>>=20
>> ...
>>=20
>> > @@ -339,13 +338,16 @@ static int rhashtable_rehash_table(struct rhasht=
able *ht)
>> >  	spin_lock(&ht->lock);
>> >  	list_for_each_entry(walker, &old_tbl->walkers, list)
>> >  		walker->tbl =3D NULL;
>> > -	spin_unlock(&ht->lock);
>> >=20=20
>> >  	/* Wait for readers. All new readers will see the new
>> >  	 * table, and thus no references to the old table will
>> >  	 * remain.
>> > +	 * We do this inside the locked region so that
>> > +	 * rhashtable_walk_stop() can check ->rcu.func and know
>> > +	 * not to re-link the table.
>> >  	 */
>> >  	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
>> > +	spin_unlock(&ht->lock);
>> >=20=20
>> >  	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
>> >  }
>>=20
>> ...
>>=20
>> > @@ -964,7 +942,7 @@ void rhashtable_walk_stop(struct rhashtable_iter *=
iter)
>> >  	ht =3D iter->ht;
>> >=20=20
>> >  	spin_lock(&ht->lock);
>> > -	if (tbl->rehash < tbl->size)
>> > +	if (tbl->rcu.func =3D=3D NULL)
>> >  		list_add(&iter->walker.list, &tbl->walkers);
>> >  	else
>> >  		iter->walker.tbl =3D NULL;
>>=20
>> This appears to be relying on implementation details within RCU.
>> Paul, are you OK with rhashtable doing this trick?
>
> The notion of accessing objects that are already on RCU's callback lists
> makes me -very- nervous because this sort of thing is not easy to
> get right.  After all, if you are accessing something that is already
> on one of RCU's callback lists, RCU might invoke the callback it at any
> time (thus freeing it in this case), and because it is already on RCU's
> callback lists, rcu_read_lock() is going to be of no help whatsoever.

I don't follow that last line.  If some other thread has already called
rcu_read_lock() when call_rcu() is called, then that other threads
rcu_read_lock() will certainly help to ensure that the object doesn't
get freed.  This code assumes that it also ensures that rcu.func will
not be changed before the other thread calls rcu_read_unlock() and
allows the grace period to end.
(There is nothing explicitly about rcu lists here, just rcu.func).

>
> In addition, RCU does no ordering on its store to ->func, but the ht->lock
> compensates in this case.  But suppose rhashtable_walk_stop() sees the
> pointer as non-NULL.  What prevents RCU from freeing the bucket table out
> from under rhashtable_walk_stop()?  In v4.17, bucket_table_free_rcu()
> just does some calls to various deallocators, which does not provide
> the necessary synchronization.
>
> Does the rhashtable_iter structure use some trick to make this safe?
> Or has synchronization been added to bucket_table_free_rcu()?  Or is
> some other trick in use?
>
> 							Thanx, Paul

When rhashtable_rehash_table() has copied all objects out of a
bucket_table, it must then disconnect any paused walkers and free the
table. (a 'paused' walker has called rhashtable_walk_stop() and dropped
the rcu read lock).
It sets walk->tbl=3DNULL (thus implicitly removing from the list) and
calls call_rcu(...,bucket_table_free_rcu) under a spinlock.

When rhashtable_walk_stop() is called, it needs to know whether it is
safe to attach the walker to the bucket_table().
It takes the same spin lock as above while still holding the
rcu_read_lock that it took some time ago.
If it gets the spinlock before rhashtable_rehash_table() gets it, then
rcu.func will be NULL (tables are allocated with kzalloc) and the walker
is attached to the table.  If it gets the spinlock after
rhashtable_rehash_table() gets it, then rcu.func will not be NULL and
the walker will not be attached to the table.

The only interesting question is whether RCU might ever set rcu.func to
NULL (or change it at all) *after* call_rcu() has been called, and
*before* the current grace period ends.
If you don't want to guarantee that it doesn't, I can add an extra flag
field to the table to say "this table must not be attached walkers", but
I currently think that should be unnecessary.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltSmaYACgkQOeye3VZi
gbmSag/+PIJbVkkCSVOhCxOJoTgo+hcjbDrrnAVWiOPc5hJpLf1i814gazhDd3jX
1DrBl38H9FPoEVyDeqBcHGfPF0UvbFBuzYj0K6yEpgiKHDbhYJeKpFvl7wgmRD/g
x6dcu+Jp4NDa6BBWlNhuZGtNojdi+TpPaQvaD9TC8z9HKUvhnj9JmHggSzkXsvpk
2nyr+qqQ0FHGTuk+ulJhp3lCWtguu64CumGtoR+b8762kqOXy6/lQTnNeJpAiMGa
lmSqzQYqNwHI7qVAPVcxdQDpWU0UVySXjQS7yhaOolTNf8jUxFnJwCYDGoFqU4Xu
rppozGbM3mBSRpmnR1ipRxy+zRaV1Pr0OcG1j4So2SZK269GscGZP6kqe2AhZF8B
hmPbQoiZDiF3h1JMZGTBSEGZ++EK3cKvBJWuPItAvp/RmGXJshLlVZceG1wNYTSi
dmwD4Sy2YO8BPV6ChtFgzPoDWP0ctZYiyTcXw4Z5ATCXvPvfkBZXx7uPk4s4T2NC
qTNZ2pbKjPppz2uLgr+BWu9SU3YGg4j2B+u0VeQNqnMfVCKhd00cmSSJjPFf3Q+8
ZMgXiJabOGWNI+cedZLR3BuMPUnmI9DAgkQIyX8Wa61/It8BEPWavmGGtNdyUNLK
MpRfsP0DIA67lMAdnVUo7lcSU+Z5On5QJZrA6Y4vArZMkt4sxw0=
=vWtD
-----END PGP SIGNATURE-----
--=-=-=--
