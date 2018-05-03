Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZpz4C84bgf9DZx9VmmS7BdFlcALfdb4LJEob7wmeW4QuFzC1QUfjq8GPlqzlWKCNVjpw2WX
ARC-Seal: i=1; a=rsa-sha256; t=1525390759; cv=none;
        d=google.com; s=arc-20160816;
        b=niNxZ4qRd/vl2++2ukKf2FMxrIndmFk1C0Fn8OgYPDVF1pPTGE3r2Yg7fkWOLsSJe5
         6Pc/oZbYIJxKzyKjuh3D2ec52aAohQ2T6R3Nr1Moc1B0Y50mfkkJwgUHQwxFypxv1glB
         +jawDoPOb5jREUza1Hd/rnr6FmDhgnFi6tCANgBfGxaTYIGAu1aZTlFGvMP6ORN9klQG
         6YlVRfBp+rC1B8WDmmCPJ7l/+J3ZJBw59Ul3m/S4jnFEK7DUgghYcT25kwiKcTvl/AD4
         RObvzM8Ttu2PRSWd0nRT9/y9QcqfnKugTYrGAaPTvEKLNpVPapNIGBxTsKQT59S5NbOq
         zGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=uu//lakRX6T0NZNEjiO9ZOFX+8EkQ/aYHx/JMzvQNKA=;
        b=x3wRyJ+fc61U4jtct+OVkmrjsfDej57qZmjgBGOcoBrV3RUT3bxixh8fzWrm8+NGVu
         8S5k1smv2oxspZgjwm6vw3uR+q4Mc3WsK5O1rWZmCnzBQ99MQpDG1ShAoh79Z+cCtA5/
         0nfHoichHM46IpBmPbCw25N25YWR9kwS1yoPHtVU+LhYIjsn9eC/umGX6++dH+xOpFDZ
         gF7OCqVunnPbRFyOkOO/SkSKJZMeCq0Hct+askCZ6Zx5xujQwQiOkedpX6euX5dn9JRW
         SxLiqx0x9o2XtJiJSVvjKK9NrnzQm1FkjwqtyFpEXpfw9AR7DHQClsRPH3cXdpeTACI4
         hm4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>
Date: Fri, 04 May 2018 09:39:04 +1000
Cc: Oleg Drokin <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Dilger <andreas.dilger@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 02/10] staging: lustre: make struct lu_site_bkt_data private
In-Reply-To: <alpine.LFD.2.21.1805020400400.2551@casper.infradead.org>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675889.17843.8198702967686860985.stgit@noble> <alpine.LFD.2.21.1805020400400.2551@casper.infradead.org>
Message-ID: <87muxgfgx3.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232325950422032?=
X-GMAIL-MSGID: =?utf-8?q?1599488140457344693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 02 2018, James Simmons wrote:

>> This data structure only needs to be public so that
>> various modules can access a wait queue to wait for object
>> destruction.
>> If we provide a function to get the wait queue, rather than the
>> whole bucket, the structure can be made private.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  drivers/staging/lustre/lustre/include/lu_object.h  |   36 +-------------
>>  drivers/staging/lustre/lustre/llite/lcommon_cl.c   |    8 ++-
>>  drivers/staging/lustre/lustre/lov/lov_object.c     |    8 ++-
>>  drivers/staging/lustre/lustre/obdclass/lu_object.c |   50 +++++++++++++=
++++---
>>  4 files changed, 54 insertions(+), 48 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/lustre/include/lu_object.h b/drivers=
/staging/lustre/lustre/include/lu_object.h
>> index c3b0ed518819..f29bbca5af65 100644
>> --- a/drivers/staging/lustre/lustre/include/lu_object.h
>> +++ b/drivers/staging/lustre/lustre/include/lu_object.h
>> @@ -549,31 +549,7 @@ struct lu_object_header {
>>  };
>>=20=20
>>  struct fld;
>> -
>> -struct lu_site_bkt_data {
>> -	/**
>> -	 * number of object in this bucket on the lsb_lru list.
>> -	 */
>> -	long			lsb_lru_len;
>> -	/**
>> -	 * LRU list, updated on each access to object. Protected by
>> -	 * bucket lock of lu_site::ls_obj_hash.
>> -	 *
>> -	 * "Cold" end of LRU is lu_site::ls_lru.next. Accessed object are
>> -	 * moved to the lu_site::ls_lru.prev (this is due to the non-existence
>> -	 * of list_for_each_entry_safe_reverse()).
>> -	 */
>> -	struct list_head		lsb_lru;
>> -	/**
>> -	 * Wait-queue signaled when an object in this site is ultimately
>> -	 * destroyed (lu_object_free()). It is used by lu_object_find() to
>> -	 * wait before re-trying when object in the process of destruction is
>> -	 * found in the hash table.
>> -	 *
>> -	 * \see htable_lookup().
>> -	 */
>> -	wait_queue_head_t	       lsb_marche_funebre;
>> -};
>> +struct lu_site_bkt_data;
>>=20=20
>>  enum {
>>  	LU_SS_CREATED	 =3D 0,
>> @@ -642,14 +618,8 @@ struct lu_site {
>>  	struct percpu_counter	 ls_lru_len_counter;
>>  };
>>=20=20
>> -static inline struct lu_site_bkt_data *
>> -lu_site_bkt_from_fid(struct lu_site *site, struct lu_fid *fid)
>> -{
>> -	struct cfs_hash_bd bd;
>> -
>> -	cfs_hash_bd_get(site->ls_obj_hash, fid, &bd);
>> -	return cfs_hash_bd_extra_get(site->ls_obj_hash, &bd);
>> -}
>> +wait_queue_head_t *
>> +lu_site_wq_from_fid(struct lu_site *site, struct lu_fid *fid);
>>=20=20
>>  static inline struct seq_server_site *lu_site2seq(const struct lu_site =
*s)
>>  {
>> diff --git a/drivers/staging/lustre/lustre/llite/lcommon_cl.c b/drivers/=
staging/lustre/lustre/llite/lcommon_cl.c
>> index df5c0c0ae703..d5b42fb1d601 100644
>> --- a/drivers/staging/lustre/lustre/llite/lcommon_cl.c
>> +++ b/drivers/staging/lustre/lustre/llite/lcommon_cl.c
>> @@ -211,12 +211,12 @@ static void cl_object_put_last(struct lu_env *env,=
 struct cl_object *obj)
>>=20=20
>>  	if (unlikely(atomic_read(&header->loh_ref) !=3D 1)) {
>>  		struct lu_site *site =3D obj->co_lu.lo_dev->ld_site;
>> -		struct lu_site_bkt_data *bkt;
>> +		wait_queue_head_t *wq;
>>=20=20
>> -		bkt =3D lu_site_bkt_from_fid(site, &header->loh_fid);
>> +		wq =3D lu_site_wq_from_fid(site, &header->loh_fid);
>>=20=20
>>  		init_waitqueue_entry(&waiter, current);
>> -		add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
>> +		add_wait_queue(wq, &waiter);
>>=20=20
>>  		while (1) {
>>  			set_current_state(TASK_UNINTERRUPTIBLE);
>> @@ -226,7 +226,7 @@ static void cl_object_put_last(struct lu_env *env, s=
truct cl_object *obj)
>>  		}
>>=20=20
>>  		set_current_state(TASK_RUNNING);
>> -		remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
>> +		remove_wait_queue(wq, &waiter);
>>  	}
>>=20=20
>>  	cl_object_put(env, obj);
>> diff --git a/drivers/staging/lustre/lustre/lov/lov_object.c b/drivers/st=
aging/lustre/lustre/lov/lov_object.c
>> index f7c69680cb7d..adc90f310fd7 100644
>> --- a/drivers/staging/lustre/lustre/lov/lov_object.c
>> +++ b/drivers/staging/lustre/lustre/lov/lov_object.c
>> @@ -370,7 +370,7 @@ static void lov_subobject_kill(const struct lu_env *=
env, struct lov_object *lov,
>>  	struct cl_object	*sub;
>>  	struct lov_layout_raid0 *r0;
>>  	struct lu_site	  *site;
>> -	struct lu_site_bkt_data *bkt;
>> +	wait_queue_head_t *wq;
>>  	wait_queue_entry_t	  *waiter;
>>=20=20
>>  	r0  =3D &lov->u.raid0;
>> @@ -378,7 +378,7 @@ static void lov_subobject_kill(const struct lu_env *=
env, struct lov_object *lov,
>>=20=20
>>  	sub  =3D lovsub2cl(los);
>>  	site =3D sub->co_lu.lo_dev->ld_site;
>> -	bkt  =3D lu_site_bkt_from_fid(site, &sub->co_lu.lo_header->loh_fid);
>> +	wq   =3D lu_site_wq_from_fid(site, &sub->co_lu.lo_header->loh_fid);
>>=20=20
>>  	cl_object_kill(env, sub);
>>  	/* release a reference to the sub-object and ... */
>> @@ -391,7 +391,7 @@ static void lov_subobject_kill(const struct lu_env *=
env, struct lov_object *lov,
>>  	if (r0->lo_sub[idx] =3D=3D los) {
>>  		waiter =3D &lov_env_info(env)->lti_waiter;
>>  		init_waitqueue_entry(waiter, current);
>> -		add_wait_queue(&bkt->lsb_marche_funebre, waiter);
>> +		add_wait_queue(wq, waiter);
>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>>  		while (1) {
>>  			/* this wait-queue is signaled at the end of
>> @@ -408,7 +408,7 @@ static void lov_subobject_kill(const struct lu_env *=
env, struct lov_object *lov,
>>  				break;
>>  			}
>>  		}
>> -		remove_wait_queue(&bkt->lsb_marche_funebre, waiter);
>> +		remove_wait_queue(wq, waiter);
>>  	}
>>  	LASSERT(!r0->lo_sub[idx]);
>>  }
>> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/driver=
s/staging/lustre/lustre/obdclass/lu_object.c
>> index 3de7dc0497c4..2a8a25d6edb5 100644
>> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> @@ -56,6 +56,31 @@
>>  #include <lu_ref.h>
>>  #include <linux/list.h>
>>=20=20
>> +struct lu_site_bkt_data {
>> +	/**
>> +	 * number of object in this bucket on the lsb_lru list.
>> +	 */
>> +	long			lsb_lru_len;
>> +	/**
>> +	 * LRU list, updated on each access to object. Protected by
>> +	 * bucket lock of lu_site::ls_obj_hash.
>> +	 *
>> +	 * "Cold" end of LRU is lu_site::ls_lru.next. Accessed object are
>> +	 * moved to the lu_site::ls_lru.prev (this is due to the non-existence
>> +	 * of list_for_each_entry_safe_reverse()).
>> +	 */
>> +	struct list_head		lsb_lru;
>> +	/**
>> +	 * Wait-queue signaled when an object in this site is ultimately
>> +	 * destroyed (lu_object_free()). It is used by lu_object_find() to
>> +	 * wait before re-trying when object in the process of destruction is
>> +	 * found in the hash table.
>> +	 *
>> +	 * \see htable_lookup().
>> +	 */
>> +	wait_queue_head_t	       lsb_marche_funebre;
>> +};
>> +
>>  enum {
>>  	LU_CACHE_PERCENT_MAX	 =3D 50,
>>  	LU_CACHE_PERCENT_DEFAULT =3D 20
>> @@ -88,6 +113,17 @@ MODULE_PARM_DESC(lu_cache_nr, "Maximum number of obj=
ects in lu_object cache");
>>  static void lu_object_free(const struct lu_env *env, struct lu_object *=
o);
>>  static __u32 ls_stats_read(struct lprocfs_stats *stats, int idx);
>>=20=20
>> +wait_queue_head_t *
>> +lu_site_wq_from_fid(struct lu_site *site, struct lu_fid *fid)
>> +{
>> +	struct cfs_hash_bd bd;
>> +	struct lu_site_bkt_data *bkt;
>> +
>> +	cfs_hash_bd_get(site->ls_obj_hash, fid, &bd);
>> +	bkt =3D cfs_hash_bd_extra_get(site->ls_obj_hash, &bd);
>> +	return &bkt->lsb_marche_funebre;
>> +}
>> +
>
> Nak. You forgot the EXPORT_SYMBOL for this. Once I added the export symbol
> it seems to work so far in my testing.

Thanks!  I'll try to remember the occasional build-test with modules.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrnZkACgkQOeye3VZi
gbmYBQ//bhrP/u5tMlVEQ7IeqJwAED4DidT2UFCIjZLJ2v2frMma6+b0I+TlRRTs
52mofWvC9ouOC85yBkcNiam8w52EjcEkfiNXPSyCXTQ6+ZA4ooHxtd2t/Ji6LgJq
nS8QEgMQDWPTEIQIHTewK7ytxkinc1r8d699QMXbBUED7B+IknaLAk8SMI77Ovhg
jj9wKHq3stvksu1xJ7PJibCWZ9yYlxj49v6IVfM6qukcpvwEWRcO4wvBrOJQBske
SJOtn6whTyNMLD46xIi3YV+YkyJk43jq16bZnfVQ4M4gDKPxAe+LZHJ+N37fvlY3
q2i+6bfa4GC7bVsJCsyzqSIdSt1hQ9/pPntrgXzDphjt3UTmj8hhz1iv3tPTmM35
S1t0r5rgwLrvdJJII9Ej6gZNQC4N9I9ev9eqTHyliCllTNaDbp1cFcFj05hZYAdX
3Gc7KT4OSf6qk20hffRTtgbuPMPvYJz3mmDoxjhDNWytAhprqziPVq/bf7blGuHn
zBzFYFf7UZn6Mxwj8ZJN7iS6wSj4M5S0bAg1hcCKxKn2gPUzt25LBTd66BSoGUSk
5kf4ivCDOcJhG4E2gE6GmN/yQZRvBQv7fXBthHZDb8WtZL1uMQN7FnOqQKbUuaXo
O4GNgRU6yL4pFuJQXYgeNqWKpvzOXDgkZuh6dNH3i2rxD19QayI=
=Hu4F
-----END PGP SIGNATURE-----
--=-=-=--
