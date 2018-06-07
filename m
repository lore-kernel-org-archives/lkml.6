Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J1v+JjObGFtOBQAAmS7hNA
	; Thu, 07 Jun 2018 02:49:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 87EA86089E; Thu,  7 Jun 2018 02:49:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9D03B60452;
	Thu,  7 Jun 2018 02:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D03B60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbeFGCtS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:49:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:50936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753093AbeFGCtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F8A6AD0B;
        Thu,  7 Jun 2018 02:49:15 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 07 Jun 2018 12:49:07 +1000
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/18] rhashtable: remove nulls_base and related code.
In-Reply-To: <152782824939.30340.13120991612931450792.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824939.30340.13120991612931450792.stgit@noble>
Message-ID: <87vaavmhuk.fsf@notabene.neil.brown.name>
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

On Fri, Jun 01 2018, NeilBrown wrote:

> This "feature" is unused, undocumented, and untested and so
> doesn't really belong.  Next patch will introduce support
> to detect when a search gets diverted down a different chain,
> which the common purpose of nulls markers.
>
> This patch actually fixes a bug too.  The table resizing allows a
> table to grow to 2^31 buckets, but the hash is truncated to 27 bits -
> any growth beyond 2^27 is wasteful an ineffective.
>
> This patch results in NULLS_MARKER(0) being used for all chains,
> and leaves the use of rht_is_a_null() to test for it.
>
> Signed-off-by: NeilBrown <neilb@suse.com>

Hi Herbert,
 You've acked a few patches that depends on this one, but not this
 patch itself.  If you could ack this one, I could submit a collection
 of patches for inclusion (after the merge window closes I guess)
 and then have fewer outstanding.
 This assumes you are in-principle happy with the alternative approach I
 took to handling list-nulls.  I got the impression that it was only
 some small details holding that back.

Thanks,
NeilBrown

> ---
>  include/linux/rhashtable-types.h |    2 --
>  include/linux/rhashtable.h       |   33 +++------------------------------
>  lib/rhashtable.c                 |    8 --------
>  lib/test_rhashtable.c            |    5 +----
>  4 files changed, 4 insertions(+), 44 deletions(-)
>
> diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-=
types.h
> index 9740063ff13b..763d613ce2c2 100644
> --- a/include/linux/rhashtable-types.h
> +++ b/include/linux/rhashtable-types.h
> @@ -50,7 +50,6 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compar=
e_arg *arg,
>   * @min_size: Minimum size while shrinking
>   * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
>   * @automatic_shrinking: Enable automatic shrinking of tables
> - * @nulls_base: Base value to generate nulls marker
>   * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
>   * @obj_hashfn: Function to hash object
>   * @obj_cmpfn: Function to compare key with object
> @@ -64,7 +63,6 @@ struct rhashtable_params {
>  	u16			min_size;
>  	bool			automatic_shrinking;
>  	u8			locks_mul;
> -	u32			nulls_base;
>  	rht_hashfn_t		hashfn;
>  	rht_obj_hashfn_t	obj_hashfn;
>  	rht_obj_cmpfn_t		obj_cmpfn;
> diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
> index 48754ab07cdf..d9f719af7936 100644
> --- a/include/linux/rhashtable.h
> +++ b/include/linux/rhashtable.h
> @@ -28,25 +28,8 @@
>  #include <linux/rhashtable-types.h>
>  /*
>   * The end of the chain is marked with a special nulls marks which has
> - * the following format:
> - *
> - * +-------+-----------------------------------------------------+-+
> - * | Base  |                      Hash                           |1|
> - * +-------+-----------------------------------------------------+-+
> - *
> - * Base (4 bits) : Reserved to distinguish between multiple tables.
> - *                 Specified via &struct rhashtable_params.nulls_base.
> - * Hash (27 bits): Full hash (unmasked) of first element added to bucket
> - * 1 (1 bit)     : Nulls marker (always set)
> - *
> - * The remaining bits of the next pointer remain unused for now.
> + * the least significant bit set.
>   */
> -#define RHT_BASE_BITS		4
> -#define RHT_HASH_BITS		27
> -#define RHT_BASE_SHIFT		RHT_HASH_BITS
> -
> -/* Base bits plus 1 bit for nulls marker */
> -#define RHT_HASH_RESERVED_SPACE	(RHT_BASE_BITS + 1)
>=20=20
>  /* Maximum chain length before rehash
>   *
> @@ -92,24 +75,14 @@ struct bucket_table {
>  	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
>  };
>=20=20
> -static inline unsigned long rht_marker(const struct rhashtable *ht, u32 =
hash)
> -{
> -	return NULLS_MARKER(ht->p.nulls_base + hash);
> -}
> -
>  #define INIT_RHT_NULLS_HEAD(ptr, ht, hash) \
> -	((ptr) =3D (typeof(ptr)) rht_marker(ht, hash))
> +	((ptr) =3D (typeof(ptr)) NULLS_MARKER(0))
>=20=20
>  static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
>  {
>  	return ((unsigned long) ptr & 1);
>  }
>=20=20
> -static inline unsigned long rht_get_nulls_value(const struct rhash_head =
*ptr)
> -{
> -	return ((unsigned long) ptr) >> 1;
> -}
> -
>  static inline void *rht_obj(const struct rhashtable *ht,
>  			    const struct rhash_head *he)
>  {
> @@ -119,7 +92,7 @@ static inline void *rht_obj(const struct rhashtable *h=
t,
>  static inline unsigned int rht_bucket_index(const struct bucket_table *t=
bl,
>  					    unsigned int hash)
>  {
> -	return (hash >> RHT_HASH_RESERVED_SPACE) & (tbl->size - 1);
> +	return hash & (tbl->size - 1);
>  }
>=20=20
>  static inline unsigned int rht_key_get_hash(struct rhashtable *ht,
> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index c9fafea7dc6e..688693c919be 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -995,7 +995,6 @@ static u32 rhashtable_jhash2(const void *key, u32 len=
gth, u32 seed)
>   *	.key_offset =3D offsetof(struct test_obj, key),
>   *	.key_len =3D sizeof(int),
>   *	.hashfn =3D jhash,
> - *	.nulls_base =3D (1U << RHT_BASE_SHIFT),
>   * };
>   *
>   * Configuration Example 2: Variable length keys
> @@ -1029,9 +1028,6 @@ int rhashtable_init(struct rhashtable *ht,
>  	    (params->obj_hashfn && !params->obj_cmpfn))
>  		return -EINVAL;
>=20=20
> -	if (params->nulls_base && params->nulls_base < (1U << RHT_BASE_SHIFT))
> -		return -EINVAL;
> -
>  	memset(ht, 0, sizeof(*ht));
>  	mutex_init(&ht->mutex);
>  	spin_lock_init(&ht->lock);
> @@ -1096,10 +1092,6 @@ int rhltable_init(struct rhltable *hlt, const stru=
ct rhashtable_params *params)
>  {
>  	int err;
>=20=20
> -	/* No rhlist NULLs marking for now. */
> -	if (params->nulls_base)
> -		return -EINVAL;
> -
>  	err =3D rhashtable_init(&hlt->ht, params);
>  	hlt->ht.rhlist =3D true;
>  	return err;
> diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
> index bf92b7aa2a49..b428a9c7522a 100644
> --- a/lib/test_rhashtable.c
> +++ b/lib/test_rhashtable.c
> @@ -83,7 +83,7 @@ static u32 my_hashfn(const void *data, u32 len, u32 see=
d)
>  {
>  	const struct test_obj_rhl *obj =3D data;
>=20=20
> -	return (obj->value.id % 10) << RHT_HASH_RESERVED_SPACE;
> +	return (obj->value.id % 10);
>  }
>=20=20
>  static int my_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
> @@ -99,7 +99,6 @@ static struct rhashtable_params test_rht_params =3D {
>  	.key_offset =3D offsetof(struct test_obj, value),
>  	.key_len =3D sizeof(struct test_obj_val),
>  	.hashfn =3D jhash,
> -	.nulls_base =3D (3U << RHT_BASE_SHIFT),
>  };
>=20=20
>  static struct rhashtable_params test_rht_params_dup =3D {
> @@ -294,8 +293,6 @@ static int __init test_rhltable(unsigned int entries)
>  	if (!obj_in_table)
>  		goto out_free;
>=20=20
> -	/* nulls_base not supported in rhlist interface */
> -	test_rht_params.nulls_base =3D 0;
>  	err =3D rhltable_init(&rhlt, &test_rht_params);
>  	if (WARN_ON(err))
>  		goto out_free;

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsYnSQACgkQOeye3VZi
gbnaUw/9EDoeqn3FNgpF4uZ0Zikb21BMP10L8vHyI/7atDKFb0VxJk/MtSV3icDf
/X+VYGM/Oaf/Bk3ds0CMZGt8kjbZiteih7x+Oc1yIVecMvhX6Id/A39T1oREhD+w
LEwPHzojyMXuKVy0TURIbXZusmXL1hsa0eMdvRsowkbtW2dvYIDLHgj1rqGEJi51
DLxdOtAGuOuoJhut1mbxXrN4R/Y1waIPTMrLcw7ARLXfc3fJMYJYwFvIZvfhuyQ6
iQC3pxGFnZ96Iu07lXg822Paw4e9qf3GdqXto7pZo4ODmqtVgJ/mbAyUhlf2gKMY
7Ql/ON4mfTw/cFSk3UL9Hd0mfLnqt8gEzJ+rWhl4MHD179IeGPoEblpy+aO0vEKD
o+lGCbmqnR7MD/gaNZd957Lsz/0C9cFmgBkQkAUDcPufx9Qtatpa9pwIfxeF6gvZ
ni2FCTrFh1Be0ejladgz69tp6qoJ0zrFnkPEdqKQerPObPe3fYz2PsfnsUWMpKnr
Ds2AdaVY+xEN1spxvAcCp8+1GY6IxYHRKvHRcMz5eC6rr/bbyexSWdUQXmFkMrmu
NDzI0CpsdUybnbMhsCDFiqjUEB582VIlWMxT2RwdflEk72vrH1Arfh2C+2+bXDly
nhE2H5Bbg8t7JwmdBhQlgzy3DMp5rlhu8g+QQlm9xEpA11cDCgI=
=iWjz
-----END PGP SIGNATURE-----
--=-=-=--
