Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZq0m/Tndx3sBk3ZMIqJ1i4Q7hPLVAuOd4E4asF/RqQ4mJLJXLAwtz8Ce+eH1ewClvw4HUq8
ARC-Seal: i=1; a=rsa-sha256; t=1525392524; cv=none;
        d=google.com; s=arc-20160816;
        b=fCoigCSxdOOJQAJBKl0KU5g39Lvp7jG6RUMgM7KYz+P6O2z7Fg6xfMmA9TNpUcgvEg
         o2MqsJHJ2SVKgQi4nGt0izsUhf+n2ffbvP6qmNHEdYo7UFkp77ojgUHe9iAiK0EZgt/O
         bd/naPtqhDLZoUPEc8q6U6MrA+t87yRyUKhS+DaMsumOEehVxBLjB4rbzbvhVxBUM5yO
         FTypWWWWfb+8cXTmFjGuH3mOrzx3y+s7cwAtLNUN1NlH/Da9puqVKnRXSkOfRoZ//Zke
         VwzenxlcOcQ2jAEZoFZAfXgeLEtGwg7fMkYJdUItwFh0LoatPG8SqYcW9TPRhS19tjle
         7sQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:references:in-reply-to:subject:cc:date:to
         :from:arc-authentication-results;
        bh=BZweXGY/nQWibSnT80PqVDW538mHG1KN4xEUR29FtL8=;
        b=knlOgbY5LF+RESCl44oX+7a7NLVbSFTjuU1Ll1HRdOs9hF4PuvNvOnNnqG69xbyghe
         zcdxicI5Tg4+7jH2sxxVXOihB35xYX1indcavyKo6wBAak3b+UdotD9aGAU0F5EJ9x0/
         z5FvMx6ED78MTY00Rg/igHDoMdbisxvoB+3ElkMlJqjVz25eEkAoBTbMcrxGQX/QZiNw
         dvE8e7Zk2Jt79UJRKVxUp2qdh7grY4u6uMLFEXSfwopaeDBfgTDo2IO9gXZ/1lbjacrY
         3lDUyWuWNFZHF5EyAZ5NfK5NmBUVKpAAis9VaQVlGvOdgVwB0MLmkdDvcM4Jsdc5iLw6
         epkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: "Dilger\, Andreas" <andreas.dilger@intel.com>
Date: Fri, 04 May 2018 10:08:35 +1000
Cc: "Drokin\, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 03/10] staging: lustre: lu_object: discard extra lru count.
In-Reply-To: <A3CD6D51-5ADF-41A0-AED2-B1C06935586C@intel.com>
References: <152514658325.17843.11455067361317157487.stgit@noble> <152514675893.17843.8396665070911641266.stgit@noble> <A3CD6D51-5ADF-41A0-AED2-B1C06935586C@intel.com>
Message-ID: <87k1skffjw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232334415255756?=
X-GMAIL-MSGID: =?utf-8?q?1599489991692535119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, May 01 2018, Dilger, Andreas wrote:

> On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>>=20
>> lu_object maintains 2 lru counts.
>> One is a per-bucket lsb_lru_len.
>> The other is the per-cpu ls_lru_len_counter.
>>=20
>> The only times the per-bucket counters are use are:
>> - a debug message when an object is added
>> - in lu_site_stats_get when all the counters are combined.
>>=20
>> The debug message is not essential, and the per-cpu counter
>> can be used to get the combined total.
>>=20
>> So discard the per-bucket lsb_lru_len.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Looks reasonable, though it would also be possible to fix the percpu
> functions rather than adding a workaround in this code.

It would be possibly to change percpu_counter_read_positive() to
take a const (and we should), but thanks to you highlighting this
I realized that I should be using percpu_counter_sum_positive(),
to read across all per-cpu counters.  That takes a spinlock
so it would be a much harder sell to get it to accept a
const pointer.

Thanks,
NeilBrown


>
> Reviewed-by: Andreas Dilger <andreas.dilger@dilger.ca>
>
>> ---
>> drivers/staging/lustre/lustre/obdclass/lu_object.c |   24 ++++++++------=
------
>> 1 file changed, 9 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/driver=
s/staging/lustre/lustre/obdclass/lu_object.c
>> index 2a8a25d6edb5..2bf089817157 100644
>> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
>> @@ -57,10 +57,6 @@
>> #include <linux/list.h>
>>=20
>> struct lu_site_bkt_data {
>> -	/**
>> -	 * number of object in this bucket on the lsb_lru list.
>> -	 */
>> -	long			lsb_lru_len;
>> 	/**
>> 	 * LRU list, updated on each access to object. Protected by
>> 	 * bucket lock of lu_site::ls_obj_hash.
>> @@ -187,10 +183,9 @@ void lu_object_put(const struct lu_env *env, struct=
 lu_object *o)
>> 	if (!lu_object_is_dying(top)) {
>> 		LASSERT(list_empty(&top->loh_lru));
>> 		list_add_tail(&top->loh_lru, &bkt->lsb_lru);
>> -		bkt->lsb_lru_len++;
>> 		percpu_counter_inc(&site->ls_lru_len_counter);
>> -		CDEBUG(D_INODE, "Add %p to site lru. hash: %p, bkt: %p, lru_len: %ld\=
n",
>> -		       o, site->ls_obj_hash, bkt, bkt->lsb_lru_len);
>> +		CDEBUG(D_INODE, "Add %p to site lru. hash: %p, bkt: %p\n",
>> +		       o, site->ls_obj_hash, bkt);
>> 		cfs_hash_bd_unlock(site->ls_obj_hash, &bd, 1);
>> 		return;
>> 	}
>> @@ -238,7 +233,6 @@ void lu_object_unhash(const struct lu_env *env, stru=
ct lu_object *o)
>>=20
>> 			list_del_init(&top->loh_lru);
>> 			bkt =3D cfs_hash_bd_extra_get(obj_hash, &bd);
>> -			bkt->lsb_lru_len--;
>> 			percpu_counter_dec(&site->ls_lru_len_counter);
>> 		}
>> 		cfs_hash_bd_del_locked(obj_hash, &bd, &top->loh_hash);
>> @@ -422,7 +416,6 @@ int lu_site_purge_objects(const struct lu_env *env, =
struct lu_site *s,
>> 			cfs_hash_bd_del_locked(s->ls_obj_hash,
>> 					       &bd2, &h->loh_hash);
>> 			list_move(&h->loh_lru, &dispose);
>> -			bkt->lsb_lru_len--;
>> 			percpu_counter_dec(&s->ls_lru_len_counter);
>> 			if (did_sth =3D=3D 0)
>> 				did_sth =3D 1;
>> @@ -621,7 +614,6 @@ static struct lu_object *htable_lookup(struct lu_sit=
e *s,
>> 		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
>> 		if (!list_empty(&h->loh_lru)) {
>> 			list_del_init(&h->loh_lru);
>> -			bkt->lsb_lru_len--;
>> 			percpu_counter_dec(&s->ls_lru_len_counter);
>> 		}
>> 		return lu_object_top(h);
>> @@ -1834,19 +1826,21 @@ struct lu_site_stats {
>> 	unsigned int	lss_busy;
>> };
>>=20
>> -static void lu_site_stats_get(struct cfs_hash *hs,
>> +static void lu_site_stats_get(const struct lu_site *s,
>> 			      struct lu_site_stats *stats, int populated)
>> {
>> +	struct cfs_hash *hs =3D s->ls_obj_hash;
>> 	struct cfs_hash_bd bd;
>> 	unsigned int i;
>> +	/* percpu_counter_read_positive() won't accept a const pointer */
>> +	struct lu_site *s2 =3D (struct lu_site *)s;
>
> It would seem worthwhile to change the percpu_counter_read_positive() and
> percpu_counter_read() arguments to be "const struct percpu_counter *fbc",
> rather than doing this cast here.  I can't see any reason that would be b=
ad,
> since both implementations just access fbc->count, and do not modify anyt=
hing.
>
>> +	stats->lss_busy +=3D cfs_hash_size_get(hs) -
>> +		percpu_counter_read_positive(&s2->ls_lru_len_counter);
>> 	cfs_hash_for_each_bucket(hs, &bd, i) {
>> -		struct lu_site_bkt_data *bkt =3D cfs_hash_bd_extra_get(hs, &bd);
>> 		struct hlist_head	*hhead;
>>=20
>> 		cfs_hash_bd_lock(hs, &bd, 1);
>> -		stats->lss_busy  +=3D
>> -			cfs_hash_bd_count_get(&bd) - bkt->lsb_lru_len;
>> 		stats->lss_total +=3D cfs_hash_bd_count_get(&bd);
>> 		stats->lss_max_search =3D max((int)stats->lss_max_search,
>> 					    cfs_hash_bd_depmax_get(&bd));
>> @@ -2039,7 +2033,7 @@ int lu_site_stats_print(const struct lu_site *s, s=
truct seq_file *m)
>> 	struct lu_site_stats stats;
>>=20
>> 	memset(&stats, 0, sizeof(stats));
>> -	lu_site_stats_get(s->ls_obj_hash, &stats, 1);
>> +	lu_site_stats_get(s, &stats, 1);
>>=20
>> 	seq_printf(m, "%d/%d %d/%ld %d %d %d %d %d %d %d\n",
>> 		   stats.lss_busy,
>>=20
>>=20
>
> Cheers, Andreas
> --
> Andreas Dilger
> Lustre Principal Architect
> Intel Corporation

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrrpIQACgkQOeye3VZi
gbkCeRAAxIt9W56dEceDCtTHA4FpcsAytHCbbwT3JbRZDqYqOpzXXJw0N8iJTgz5
RQSafAMTSq6Ht5PuT1NRJQlr5FFYaDHZoSwUXpMhrcKiYnjEoL5vLNXDFSGMqAAT
sSRlF/bDBIVPZ0aqCV1kRo8MQhCodl8Gwx6X5AHqhGLkIZrIQqSyV7NhX4hk+PKJ
OGV3Db4pQOu5SpwIhO8zHP7GkWkuIeKf+MoSL72k1KHs026cXeM/wVTuHC4XjQ2b
TXQwg5CwChAXpOyjkvQEke8KCiMhrfuBLpreiMJCzuTcki3oEvhnEpTxHCgXKMOO
DzdP+Pg/edfQQeFDDf0H61TEcr08+7+D42K+abZ8V7AE+CeN04VVtmXNdYa2VWGr
QfEEP7jNwkBfjhGUXPcKePpJvwzduKRQ8dY6ZXw2oerf0kVyTpGPF7G3wSWZ8mVN
TnN5c3U8Ozt1yVBBeQlxQFzNRjiRbAC4pFXGMSvzB/zvte4inZfyz5ypvKhy6U0w
ub1thbiqTa0/G0TBLPencLepUWH1EmbfYWa8j7ZGR9IqGQQKHo+JkIZfzwaBSJvH
bULC6waZUFHwCmpCKlxNZC6DvqPo/oDcPd+XKHXXZ1y5F28OFTrtGNECDeGJO4Od
nKaD7ON60yW2rdNeakbVczxerkiwnDjvTRzzTfVEQzBsNmsc9qw=
=p/N0
-----END PGP SIGNATURE-----
--=-=-=--
