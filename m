Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZr7fwwWAUltPTWKdKWXA0U4oMaqLRYzf6Cutwx4Tys1ifw3c+eiaLQkBj35Bm9jCnXtzkAw
ARC-Seal: i=1; a=rsa-sha256; t=1525397436; cv=none;
        d=google.com; s=arc-20160816;
        b=r72ggUinOOX1jiU1pcINCOceyLohOxrTbo2r3TLvWv7ZAjiypXDWS0fYRH1/aR2Dtr
         91i51FBAmFd1U+GMpBF1pY0CGz4TUt5lF6iEYUureYt4ymD2pmcBByRMQAzcGxe62cwA
         dflo0kAF+iJ+8RQOPzE4GD8OW/fPwmNlILMwp3g2e6L+odxeZ+iQ6l2Sk33B14LaImpm
         GZlwiZoJIVtWwryJyujvXEI1VhCAt/nta4cVKsldej84pMM7jewZfGCXLvNVplDmhn/A
         DcAd1c1plwZw144tWrh3i8GKemYMftJl04oGZV4L/OsCOm06FQD9kKpQhE7C2G8u172G
         uQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=6f3fU5K81CkvIZicX7qIkdvglPL6I1FsqS6KZnqWWt8=;
        b=Qlr5P1CCeDDK46n9TZpfqAir8RXqz+rxNFuZ/GrCcuYFQuVd5AuYXsMi/FCMlpevM+
         T6f2bWOp9Tqt5Ydy5S3vTeVFTUrfmjIQdjgH41U2qnPL7Rfo3StYTW+ZovYhVhUxP6nH
         HJeIUB/31UxdGeqk8SKyNHppCOY22sH0UtIORF3T/lYy9OM7HQkrtYbU8dVdk+pUG2Ys
         WjQ0gTVUBCJVb0hMTmtNTT9UGsYDBEX7XMIZ3R7Uv/d7IGqz60SX6yltBKG+ajsH6//V
         7nXvdKoo36BTthmf0JOa5gkibnrVw/A5f3qGzS8Sk5CIpnigVvwAIWYHS4Zwz6g1t61G
         r3Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>
Date: Fri, 04 May 2018 11:30:25 +1000
Cc: "Drokin\, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 04/10] staging: lustre: lu_object: move retry logic inside htable_lookup
In-Reply-To: <EFC6D018-5FB5-4902-AE7A-B91A5E0148FE@intel.com>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675897.17843.15112214060540196720.stgit@noble> <EFC6D018-5FB5-4902-AE7A-B91A5E0148FE@intel.com>
Message-ID: <874ljofbri.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232342096971957?=
X-GMAIL-MSGID: =?utf-8?q?1599495142522627022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 01 2018, Dilger, Andreas wrote:

> On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>>=20
>> The current retry logic, to wait when a 'dying' object is found,
>> spans multiple functions.  The process is attached to a waitqueue
>> and set TASK_UNINTERRUPTIBLE in htable_lookup, and this status
>> is passed back through lu_object_find_try() to lu_object_find_at()
>> where schedule() is called and the process is removed from the queue.
>>=20
>> This can be simplified by moving all the logic (including
>> hashtable locking) inside htable_lookup(), which now never returns
>> EAGAIN.
>>=20
>> Note that htable_lookup() is called with the hash bucket lock
>> held, and will drop and retake it if it needs to schedule.
>>=20
>> I made this a 'goto' loop rather than a 'while(1)' loop as the
>> diff is easier to read.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>> drivers/staging/lustre/lustre/obdclass/lu_object.c |   73 +++++++-------=
------
>> 1 file changed, 27 insertions(+), 46 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/driver=
s/staging/lustre/lustre/obdclass/lu_object.c
>> index 2bf089817157..93daa52e2535 100644
>> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> @@ -586,16 +586,21 @@ EXPORT_SYMBOL(lu_object_print);
>> static struct lu_object *htable_lookup(struct lu_site *s,
>
> It's probably a good idea to add a comment for this function that it may
> drop and re-acquire the hash bucket lock internally.

Added - thanks.

>
>> 				       struct cfs_hash_bd *bd,
>> 				       const struct lu_fid *f,
>> -				       wait_queue_entry_t *waiter,
>> 				       __u64 *version)
>> {
>> +	struct cfs_hash		*hs =3D s->ls_obj_hash;
>> 	struct lu_site_bkt_data *bkt;
>> 	struct lu_object_header *h;
>> 	struct hlist_node	*hnode;
>> -	__u64  ver =3D cfs_hash_bd_version_get(bd);
>> +	__u64 ver;
>> +	wait_queue_entry_t waiter;
>>=20
>> -	if (*version =3D=3D ver)
>> +retry:
>> +	ver =3D cfs_hash_bd_version_get(bd);
>> +
>> +	if (*version =3D=3D ver) {
>> 		return ERR_PTR(-ENOENT);
>> +	}
>
> (style) we don't need the {} around a single-line if statement

Fixed.

>
>> 	*version =3D ver;
>> 	bkt =3D cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
>> @@ -625,11 +630,15 @@ static struct lu_object *htable_lookup(struct lu_s=
ite *s,
>> 	 * drained), and moreover, lookup has to wait until object is freed.
>> 	 */
>>=20
>> -	init_waitqueue_entry(waiter, current);
>> -	add_wait_queue(&bkt->lsb_marche_funebre, waiter);
>> +	init_waitqueue_entry(&waiter, current);
>> +	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
>> 	set_current_state(TASK_UNINTERRUPTIBLE);
>> 	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
>> -	return ERR_PTR(-EAGAIN);
>> +	cfs_hash_bd_unlock(hs, bd, 1);
>
> This looks like it isn't unlocking and locking the hash bucket in the same
> manner that it was done in the caller.  Here excl =3D 1, but in the caller
> you changed it to excl =3D 0?

Don't know what happened there... though as the tables is created with
CFS_HASH_SPIN_BLKLOCK it doesn't make any behavioral difference.
I've put it back to use '1' uniformly.

>
>> +	schedule();
>> +	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
>
> Is it worthwhile to use your new helper function here to get the wq from =
"s"?

I don't think so.  We already have the 'bkt' and it seems pointless to
compute the hash a second time and use it to find the bucket and then
the queue, just to use a nice wrapper function.


>
>> +	cfs_hash_bd_lock(hs, bd, 1);
>> +	goto retry;
>> }
>>=20
>> /**
>> @@ -693,13 +702,14 @@ static struct lu_object *lu_object_new(const struc=
t lu_env *env,
>> }
>>=20
>> /**
>> - * Core logic of lu_object_find*() functions.
>> + * Much like lu_object_find(), but top level device of object is specif=
ically
>> + * \a dev rather than top level device of the site. This interface allo=
ws
>> + * objects of different "stacking" to be created within the same site.
>>  */
>> -static struct lu_object *lu_object_find_try(const struct lu_env *env,
>> -					    struct lu_device *dev,
>> -					    const struct lu_fid *f,
>> -					    const struct lu_object_conf *conf,
>> -					    wait_queue_entry_t *waiter)
>> +struct lu_object *lu_object_find_at(const struct lu_env *env,
>> +				    struct lu_device *dev,
>> +				    const struct lu_fid *f,
>> +				    const struct lu_object_conf *conf)
>> {
>> 	struct lu_object      *o;
>> 	struct lu_object      *shadow;
>> @@ -725,17 +735,16 @@ static struct lu_object *lu_object_find_try(const =
struct lu_env *env,
>> 	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
>> 	 * just alloc and insert directly.
>> 	 *
>> -	 * If dying object is found during index search, add @waiter to the
>> -	 * site wait-queue and return ERR_PTR(-EAGAIN).
>> 	 */
>> 	if (conf && conf->loc_flags & LOC_F_NEW)
>> 		return lu_object_new(env, dev, f, conf);
>>=20
>> 	s  =3D dev->ld_site;
>> 	hs =3D s->ls_obj_hash;
>> -	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
>> -	o =3D htable_lookup(s, &bd, f, waiter, &version);
>> -	cfs_hash_bd_unlock(hs, &bd, 1);
>> +	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 0);
>> +	o =3D htable_lookup(s, &bd, f, &version);
>> +	cfs_hash_bd_unlock(hs, &bd, 0);
>
> Here you changed the locking to a non-exclusive (read) lock instead of an
> exclusive (write) lock?  Why.

Carelessness is all.  And the fact that my thinking was focused on
rhashtable which doesn't make that distinction. Fixed.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrt7IACgkQOeye3VZi
gbkL8A//Ya3S/RrfiF55FlkafVHhlW9Qv3rNRMQ0N7IKhLMImnybNi3V+X29bjVq
/z6OQ9BnBzxZ7OutM/0tgyepJPzJuRC6wRi06F5e3TnnAaMgD68aUSPz0r6+yGLz
x82uEG8CovNN6v0Aq0G3ECcWcWF9t8A7gqyy12oF/upK1Eu64Ro17VbHTyax6syO
iv1iI9unwPTtUwsK+icVzLpbITrewnzPsf6TElJMKsVvpv+ZqrkAcoCPprp+s2rR
ytYvxAMFOipuEd69GkvlZa9sUIOikR2arQ78LyMsI6UiN7iEKfTyQUUB8d3MhNZI
4Jn+03YETwGOmrmg3CUrt34DfS7iWhi7ypyWukLSyvrhlkvM3utYFpDshutBSnZF
BTRYM3HdEHufIZaa1yeI3y3vzrXJac4zKGz/+0Vr0YbjH3qaJT3JGy4Rh1KrNAMY
k5/41/GVs52zx1vx9ElkkEmOIui3sP8V/zvPMeNlE2f/qo0LbSCqndDVvs1T+ehk
0R3RUyOrMC1PsRDHU15m5SizmBOyfHTxgJ2+YRqxDMFIxuMbnCQgmE/+sEtyuHkr
ZHqfR8hXOMF27AO+QpqnVnGynWpb9BKna3q3B84FDlYDa89610+X17OZ0+Y1SDI4
VJN9Po3TQodaY4YY9uQcZgQFwj9ULPFetNgxUwrY4gZJlIN9S8Y=
=ZdaX
-----END PGP SIGNATURE-----
--=-=-=--
