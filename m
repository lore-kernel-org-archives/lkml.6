Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AB8JxZreryjJYjeFwSSYrzaK2OC+pUjXh0k0JDu+SFSeMh/FXIlpQe3ZMbfN4fFPd+pmS+JkwhGm
ARC-Seal: i=1; a=rsa-sha256; t=1525162972; cv=none;
        d=google.com; s=arc-20160816;
        b=oQdjurD07DQ1n/3JGY8y+I/kr/Cesz0f/Spps8D/IqK8XzGO7JUFPbcp0kGu8oCqEN
         YcBkC+UIWDPK/QxqrwMXNcZ9jpVgLa66nHDy8eyBVUnjazxFJtV9J4yWqe5rxvVujpeG
         2V8GuxFvf3gHJoF31mLpMfTo/UBszUadt+MpUMb+Akuq2UohQ3WVRkZq/TKBJUDikVYI
         4gVVAsAsuo42epcRpsR+Lc47agYQ0ddIC4tN2Jmhsp7XOrj3jIG3fYjiy3N7mtumiMOp
         Z2Y5Om9AHuhEUMCPQ3oUOQRwBNnEjTRJTSSR/AEdI4tSMzZsfJi7vkLGWCEwWod9PSmh
         G0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=ujH0YOk6fxesOtD2/NcFxsyBmL+AY1r0b5Z4Ry1IR3s=;
        b=lwYI3J4OGqj2O+sWrDe4cXuOMBpSOZEwwZD1nJnWQOudbkFeCnEWL55x+cGsXTsnL5
         croTlMkhl8zm1X/HWSyXls3IyzlaESwqxco1GfQ1Lwvzj59FEyFXtPeki1We7hB85VDT
         Iq/OwpAOTf5hG4mzdSiKzFPjNqf7wEgY10mQ8jk8+n68A47nViQOdmYBa9QXi4NS8a8e
         6bt1+jVhEO1yP8DblCQLACD++JJcLSfJvV2kYuQnvPKTS50x+TKn0xmvMOH0xXvdDJ7y
         rB708NB7KOvg+mSO/J0xlRR8cEaGUdMdua+hTIXYj9nvMGVPn/btIJlYCruP2psQyyJH
         ClPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,350,1520924400";
   d="scan'208";a="36533882"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 04/10] staging: lustre: lu_object: move
 retry logic inside htable_lookup
Thread-Topic: [lustre-devel] [PATCH 04/10] staging: lustre: lu_object: move
 retry logic inside htable_lookup
Thread-Index: AQHT4P/85u70Xh3XOk6Z467GqtGvSKQa/oeA
Date: Tue, 1 May 2018 08:22:50 +0000
Message-ID: <EFC6D018-5FB5-4902-AE7A-B91A5E0148FE@intel.com>
References: <152514658325.17843.11455067361317157487.stgit@noble>
 <152514675897.17843.15112214060540196720.stgit@noble>
In-Reply-To: <152514675897.17843.15112214060540196720.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C93B490BA3AF447803E59C5EAC1D61B@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232342096971957?=
X-GMAIL-MSGID: =?utf-8?q?1599249288957743128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>=20
> The current retry logic, to wait when a 'dying' object is found,
> spans multiple functions.  The process is attached to a waitqueue
> and set TASK_UNINTERRUPTIBLE in htable_lookup, and this status
> is passed back through lu_object_find_try() to lu_object_find_at()
> where schedule() is called and the process is removed from the queue.
>=20
> This can be simplified by moving all the logic (including
> hashtable locking) inside htable_lookup(), which now never returns
> EAGAIN.
>=20
> Note that htable_lookup() is called with the hash bucket lock
> held, and will drop and retake it if it needs to schedule.
>=20
> I made this a 'goto' loop rather than a 'while(1)' loop as the
> diff is easier to read.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
> drivers/staging/lustre/lustre/obdclass/lu_object.c |   73 +++++++--------=
-----
> 1 file changed, 27 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index 2bf089817157..93daa52e2535 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -586,16 +586,21 @@ EXPORT_SYMBOL(lu_object_print);
> static struct lu_object *htable_lookup(struct lu_site *s,

It's probably a good idea to add a comment for this function that it may
drop and re-acquire the hash bucket lock internally.

> 				       struct cfs_hash_bd *bd,
> 				       const struct lu_fid *f,
> -				       wait_queue_entry_t *waiter,
> 				       __u64 *version)
> {
> +	struct cfs_hash		*hs =3D s->ls_obj_hash;
> 	struct lu_site_bkt_data *bkt;
> 	struct lu_object_header *h;
> 	struct hlist_node	*hnode;
> -	__u64  ver =3D cfs_hash_bd_version_get(bd);
> +	__u64 ver;
> +	wait_queue_entry_t waiter;
>=20
> -	if (*version =3D=3D ver)
> +retry:
> +	ver =3D cfs_hash_bd_version_get(bd);
> +
> +	if (*version =3D=3D ver) {
> 		return ERR_PTR(-ENOENT);
> +	}

(style) we don't need the {} around a single-line if statement

> 	*version =3D ver;
> 	bkt =3D cfs_hash_bd_extra_get(s->ls_obj_hash, bd);
> @@ -625,11 +630,15 @@ static struct lu_object *htable_lookup(struct lu_si=
te *s,
> 	 * drained), and moreover, lookup has to wait until object is freed.
> 	 */
>=20
> -	init_waitqueue_entry(waiter, current);
> -	add_wait_queue(&bkt->lsb_marche_funebre, waiter);
> +	init_waitqueue_entry(&waiter, current);
> +	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> 	set_current_state(TASK_UNINTERRUPTIBLE);
> 	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
> -	return ERR_PTR(-EAGAIN);
> +	cfs_hash_bd_unlock(hs, bd, 1);

This looks like it isn't unlocking and locking the hash bucket in the same
manner that it was done in the caller.  Here excl =3D 1, but in the caller
you changed it to excl =3D 0?

> +	schedule();
> +	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);

Is it worthwhile to use your new helper function here to get the wq from "s=
"?

> +	cfs_hash_bd_lock(hs, bd, 1);
> +	goto retry;
> }
>=20
> /**
> @@ -693,13 +702,14 @@ static struct lu_object *lu_object_new(const struct=
 lu_env *env,
> }
>=20
> /**
> - * Core logic of lu_object_find*() functions.
> + * Much like lu_object_find(), but top level device of object is specifi=
cally
> + * \a dev rather than top level device of the site. This interface allow=
s
> + * objects of different "stacking" to be created within the same site.
>  */
> -static struct lu_object *lu_object_find_try(const struct lu_env *env,
> -					    struct lu_device *dev,
> -					    const struct lu_fid *f,
> -					    const struct lu_object_conf *conf,
> -					    wait_queue_entry_t *waiter)
> +struct lu_object *lu_object_find_at(const struct lu_env *env,
> +				    struct lu_device *dev,
> +				    const struct lu_fid *f,
> +				    const struct lu_object_conf *conf)
> {
> 	struct lu_object      *o;
> 	struct lu_object      *shadow;
> @@ -725,17 +735,16 @@ static struct lu_object *lu_object_find_try(const s=
truct lu_env *env,
> 	 * It is unnecessary to perform lookup-alloc-lookup-insert, instead,
> 	 * just alloc and insert directly.
> 	 *
> -	 * If dying object is found during index search, add @waiter to the
> -	 * site wait-queue and return ERR_PTR(-EAGAIN).
> 	 */
> 	if (conf && conf->loc_flags & LOC_F_NEW)
> 		return lu_object_new(env, dev, f, conf);
>=20
> 	s  =3D dev->ld_site;
> 	hs =3D s->ls_obj_hash;
> -	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 1);
> -	o =3D htable_lookup(s, &bd, f, waiter, &version);
> -	cfs_hash_bd_unlock(hs, &bd, 1);
> +	cfs_hash_bd_get_and_lock(hs, (void *)f, &bd, 0);
> +	o =3D htable_lookup(s, &bd, f, &version);
> +	cfs_hash_bd_unlock(hs, &bd, 0);

Here you changed the locking to a non-exclusive (read) lock instead of an
exclusive (write) lock?  Why.

> +
> 	if (!IS_ERR(o) || PTR_ERR(o) !=3D -ENOENT)
> 		return o;
>=20
> @@ -751,7 +760,7 @@ static struct lu_object *lu_object_find_try(const str=
uct lu_env *env,
>=20
> 	cfs_hash_bd_lock(hs, &bd, 1);
>=20
> -	shadow =3D htable_lookup(s, &bd, f, waiter, &version);
> +	shadow =3D htable_lookup(s, &bd, f, &version);
> 	if (likely(PTR_ERR(shadow) =3D=3D -ENOENT)) {
> 		cfs_hash_bd_add_locked(hs, &bd, &o->lo_header->loh_hash);
> 		cfs_hash_bd_unlock(hs, &bd, 1);
> @@ -766,34 +775,6 @@ static struct lu_object *lu_object_find_try(const st=
ruct lu_env *env,
> 	lu_object_free(env, o);
> 	return shadow;
> }
> -
> -/**
> - * Much like lu_object_find(), but top level device of object is specifi=
cally
> - * \a dev rather than top level device of the site. This interface allow=
s
> - * objects of different "stacking" to be created within the same site.
> - */
> -struct lu_object *lu_object_find_at(const struct lu_env *env,
> -				    struct lu_device *dev,
> -				    const struct lu_fid *f,
> -				    const struct lu_object_conf *conf)
> -{
> -	wait_queue_head_t	*wq;
> -	struct lu_object	*obj;
> -	wait_queue_entry_t	   wait;
> -
> -	while (1) {
> -		obj =3D lu_object_find_try(env, dev, f, conf, &wait);
> -		if (obj !=3D ERR_PTR(-EAGAIN))
> -			return obj;
> -		/*
> -		 * lu_object_find_try() already added waiter into the
> -		 * wait queue.
> -		 */
> -		schedule();
> -		wq =3D lu_site_wq_from_fid(dev->ld_site, (void *)f);
> -		remove_wait_queue(wq, &wait);
> -	}
> -}
> EXPORT_SYMBOL(lu_object_find_at);
>=20
> /**
>=20
>=20
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
