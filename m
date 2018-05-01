Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AB8JxZq4ix9CMBb+1+7HNxuiOzNseNFDKrbsFTzgf8+LhAKfd05cl238VeYq1UG5nVmwhQeiaUQg
ARC-Seal: i=1; a=rsa-sha256; t=1525148396; cv=none;
        d=google.com; s=arc-20160816;
        b=FOMElfxt7cw+qgNXkR3kdfwfUAGV5nu7bIW6tzyUeePNIaWMPIALDC+8AdAMcyUpV9
         XKz9vTrfFyy/Km9x3tnaG+etg0J7cWuixTyDGjTgXbRUnVXySAjVxrYv4m2d/IV2v9dR
         eQ7sZVXgCmK51BPlqQ+GXaYKxtkWQtINf+IsLg9Hiyw7c5c88rcpHe07G1P/7oTQNLZu
         7j5go/OvsXyhmg3ikhfcfu/S/QLR4uRc+BqQQ58J/5rY53OtbjBGMk7NhdJRodwEtut6
         HWymLS6qRKx79kBztuzpehYW+PxHEAWfSHck6lGsTPFMtU5wgG/NztwwvOSvh707GbhR
         sZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=q5hSnxNAZELDREAQHHZvEEZ31zoLaQKaHiVQ+Vf36ds=;
        b=lxkHHmy6vRIJU7mHe1B+c5XeMm1BxpA4efw7TCJ/gnbQ6VvWNMbomAa6boPZ4CWMOK
         3Pv8eLahtaI1MbcM1oYztkNXfOcyPaGFBl7vn0f+YM52/8i/sFOn3kzr14lyCrpRSvkb
         anzO4AcfAg407nrbkTPbJF+fEXQ3S4gURb3jw9qdXC0TYQObF7BZGr1SmcwPdAeCxbnJ
         wHS6WVzLBgnYDjzwIoa2Cj4asXIiH3qrqldXo5ezI5OZMqzFCS1cZ10FR3E3QN/Qm44R
         of0MdG8OXogyOL1tnTJN9DDGxZvX1HFz8Ip7GaELtTxLxdZKChlU1XK4Ep9XOWV3WHz6
         9nhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,349,1520924400";
   d="scan'208";a="54962337"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 03/10] staging: lustre: lu_object: discard extra lru
 count.
Thread-Topic: [PATCH 03/10] staging: lustre: lu_object: discard extra lru
 count.
Thread-Index: AQHT4P/2AaK69p/2O0ySpUfCQOIv8KQauqeA
Date: Tue, 1 May 2018 04:19:54 +0000
Message-ID: <A3CD6D51-5ADF-41A0-AED2-B1C06935586C@intel.com>
References: <152514658325.17843.11455067361317157487.stgit@noble>
 <152514675893.17843.8396665070911641266.stgit@noble>
In-Reply-To: <152514675893.17843.8396665070911641266.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8CBB530FEF2EA04D8B612C526B2B58BC@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232334415255756?=
X-GMAIL-MSGID: =?utf-8?q?1599234004557837770?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 30, 2018, at 21:52, NeilBrown <neilb@suse.com> wrote:
>=20
> lu_object maintains 2 lru counts.
> One is a per-bucket lsb_lru_len.
> The other is the per-cpu ls_lru_len_counter.
>=20
> The only times the per-bucket counters are use are:
> - a debug message when an object is added
> - in lu_site_stats_get when all the counters are combined.
>=20
> The debug message is not essential, and the per-cpu counter
> can be used to get the combined total.
>=20
> So discard the per-bucket lsb_lru_len.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Looks reasonable, though it would also be possible to fix the percpu
functions rather than adding a workaround in this code.

Reviewed-by: Andreas Dilger <andreas.dilger@dilger.ca>

> ---
> drivers/staging/lustre/lustre/obdclass/lu_object.c |   24 ++++++++-------=
-----
> 1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index 2a8a25d6edb5..2bf089817157 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -57,10 +57,6 @@
> #include <linux/list.h>
>=20
> struct lu_site_bkt_data {
> -	/**
> -	 * number of object in this bucket on the lsb_lru list.
> -	 */
> -	long			lsb_lru_len;
> 	/**
> 	 * LRU list, updated on each access to object. Protected by
> 	 * bucket lock of lu_site::ls_obj_hash.
> @@ -187,10 +183,9 @@ void lu_object_put(const struct lu_env *env, struct =
lu_object *o)
> 	if (!lu_object_is_dying(top)) {
> 		LASSERT(list_empty(&top->loh_lru));
> 		list_add_tail(&top->loh_lru, &bkt->lsb_lru);
> -		bkt->lsb_lru_len++;
> 		percpu_counter_inc(&site->ls_lru_len_counter);
> -		CDEBUG(D_INODE, "Add %p to site lru. hash: %p, bkt: %p, lru_len: %ld\n=
",
> -		       o, site->ls_obj_hash, bkt, bkt->lsb_lru_len);
> +		CDEBUG(D_INODE, "Add %p to site lru. hash: %p, bkt: %p\n",
> +		       o, site->ls_obj_hash, bkt);
> 		cfs_hash_bd_unlock(site->ls_obj_hash, &bd, 1);
> 		return;
> 	}
> @@ -238,7 +233,6 @@ void lu_object_unhash(const struct lu_env *env, struc=
t lu_object *o)
>=20
> 			list_del_init(&top->loh_lru);
> 			bkt =3D cfs_hash_bd_extra_get(obj_hash, &bd);
> -			bkt->lsb_lru_len--;
> 			percpu_counter_dec(&site->ls_lru_len_counter);
> 		}
> 		cfs_hash_bd_del_locked(obj_hash, &bd, &top->loh_hash);
> @@ -422,7 +416,6 @@ int lu_site_purge_objects(const struct lu_env *env, s=
truct lu_site *s,
> 			cfs_hash_bd_del_locked(s->ls_obj_hash,
> 					       &bd2, &h->loh_hash);
> 			list_move(&h->loh_lru, &dispose);
> -			bkt->lsb_lru_len--;
> 			percpu_counter_dec(&s->ls_lru_len_counter);
> 			if (did_sth =3D=3D 0)
> 				did_sth =3D 1;
> @@ -621,7 +614,6 @@ static struct lu_object *htable_lookup(struct lu_site=
 *s,
> 		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> 		if (!list_empty(&h->loh_lru)) {
> 			list_del_init(&h->loh_lru);
> -			bkt->lsb_lru_len--;
> 			percpu_counter_dec(&s->ls_lru_len_counter);
> 		}
> 		return lu_object_top(h);
> @@ -1834,19 +1826,21 @@ struct lu_site_stats {
> 	unsigned int	lss_busy;
> };
>=20
> -static void lu_site_stats_get(struct cfs_hash *hs,
> +static void lu_site_stats_get(const struct lu_site *s,
> 			      struct lu_site_stats *stats, int populated)
> {
> +	struct cfs_hash *hs =3D s->ls_obj_hash;
> 	struct cfs_hash_bd bd;
> 	unsigned int i;
> +	/* percpu_counter_read_positive() won't accept a const pointer */
> +	struct lu_site *s2 =3D (struct lu_site *)s;

It would seem worthwhile to change the percpu_counter_read_positive() and
percpu_counter_read() arguments to be "const struct percpu_counter *fbc",
rather than doing this cast here.  I can't see any reason that would be bad=
,
since both implementations just access fbc->count, and do not modify anythi=
ng.

> +	stats->lss_busy +=3D cfs_hash_size_get(hs) -
> +		percpu_counter_read_positive(&s2->ls_lru_len_counter);
> 	cfs_hash_for_each_bucket(hs, &bd, i) {
> -		struct lu_site_bkt_data *bkt =3D cfs_hash_bd_extra_get(hs, &bd);
> 		struct hlist_head	*hhead;
>=20
> 		cfs_hash_bd_lock(hs, &bd, 1);
> -		stats->lss_busy  +=3D
> -			cfs_hash_bd_count_get(&bd) - bkt->lsb_lru_len;
> 		stats->lss_total +=3D cfs_hash_bd_count_get(&bd);
> 		stats->lss_max_search =3D max((int)stats->lss_max_search,
> 					    cfs_hash_bd_depmax_get(&bd));
> @@ -2039,7 +2033,7 @@ int lu_site_stats_print(const struct lu_site *s, st=
ruct seq_file *m)
> 	struct lu_site_stats stats;
>=20
> 	memset(&stats, 0, sizeof(stats));
> -	lu_site_stats_get(s->ls_obj_hash, &stats, 1);
> +	lu_site_stats_get(s, &stats, 1);
>=20
> 	seq_printf(m, "%d/%d %d/%ld %d %d %d %d %d %d %d\n",
> 		   stats.lss_busy,
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
