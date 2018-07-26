Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84169C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C07D206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C07D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbeGZXXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:23:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:35660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730292AbeGZXXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:23:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C16A2ACE2;
        Thu, 26 Jul 2018 22:04:50 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Fri, 27 Jul 2018 08:04:40 +1000
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] rhashtable: detect when object movement between tables might have invalidated a lookup
In-Reply-To: <20180726.135512.137481791294209800.davem@davemloft.net>
References: <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180719.051440.931407144963903326.davem@davemloft.net> <876016r9z5.fsf@notabene.neil.brown.name> <20180726.135512.137481791294209800.davem@davemloft.net>
Message-ID: <87tvolmz5z.fsf@notabene.neil.brown.name>
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

On Thu, Jul 26 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Mon, 23 Jul 2018 11:56:14 +1000
>
>> Some users of rhashtables might need to move an object from one table
>> to another -  this appears to be the reason for the incomplete usage
>> of NULLS markers.
>>=20
>> To support these, we store a unique NULLS_MARKER at the end of
>> each chain, and when a search fails to find a match, we check
>> if the NULLS marker found was the expected one.  If not,
>> the search is repeated.
>  ...
>> This is a simplified version of a previous patch.
>> It provides NULLS_MARKER support only for the specific use case
>> which is currently thought be valuable to in-tree users
>> of rhashtables.
>
> Neil, this doesn't even compile:
>
> In file included from lib/rhashtable.c:28:
> lib/rhashtable.c: In function =E2=80=98rht_bucket_nested=E2=80=99:
> ./include/linux/rhashtable.h:79:2: error: initializer element is not comp=
utable at load time
>   ((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
>   ^
> lib/rhashtable.c:1178:43: note: in expansion of macro =E2=80=98RHT_NULLS_=
MARKER=E2=80=99
>   static struct rhash_head __rcu *rhnull =3D RHT_NULLS_MARKER(&rhnull);
>                                            ^~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:318: lib/rhashtable.o] Error 1
> make: *** [Makefile:1653: lib/rhashtable.o] Error 2
>
> I imagine you have a mix of other changes or whatever in your tree, so I'=
ll
> give you the benefit of the doubt.
>
> But this is the second time this has happened with your rhashtable change=
s,
> so...
Your displeasure is understandable.

I had fixed this, but hadn't refreshed the patch - though I had updated
the patch description to explain the change I had to make - second
sentence of:

  The unique NULLS_MARKER is derived from the address of the
  head of the chain.  As this cannot be derived at load-time the
  static rhnull in rht_bucket_nexted() need to be initialised
  at run time.

This is what I meant to send - it does compile.

Thanks,
NeilBrown

From: NeilBrown <neilb@suse.com>
Date: Mon, 25 Jun 2018 08:09:16 +1000
Subject: [PATCH] rhashtable: detect when object movement between tables mig=
ht
 have invalidated a lookup

Some users of rhashtables might need to move an object from one table
to another -  this appears to be the reason for the incomplete usage
of NULLS markers.

To support these, we store a unique NULLS_MARKER at the end of
each chain, and when a search fails to find a match, we check
if the NULLS marker found was the expected one.  If not,
the search is repeated.

The unique NULLS_MARKER is derived from the address of the
head of the chain.  As this cannot be derived at load-time the
static rhnull in rht_bucket_nexted() need to be initialised
at run time.

Any caller of a lookup function must be prepared for the possibility
that the object returned is in a different table - it might have been
there for some time.

Note that this does NOT provide support for other uses for
NULLS_MARKERs such as allocating with SLAB_TYPESAFE_BY_RCU or changing
the key of an object and re-inserting it in the table.
These could only be done safely if new objects were inserted
at the *start* of a hash chain, and that is not currently the case.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 include/linux/rhashtable.h | 25 +++++++++++++++++--------
 lib/rhashtable.c           |  8 +++++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index eb7111039247..8cc240f14834 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -75,8 +75,10 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
=20
+#define	RHT_NULLS_MARKER(ptr)	\
+	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
 #define INIT_RHT_NULLS_HEAD(ptr)	\
=2D	((ptr) =3D (typeof(ptr)) NULLS_MARKER(0))
+	((ptr) =3D RHT_NULLS_MARKER(&(ptr)))
=20
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
 {
@@ -471,6 +473,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 		.ht =3D ht,
 		.key =3D key,
 	};
+	struct rhash_head __rcu * const *head;
 	struct bucket_table *tbl;
 	struct rhash_head *he;
 	unsigned int hash;
@@ -478,13 +481,19 @@ static inline struct rhash_head *__rhashtable_lookup(
 	tbl =3D rht_dereference_rcu(ht->tbl, ht);
 restart:
 	hash =3D rht_key_hashfn(ht, tbl, key, params);
=2D	rht_for_each_rcu(he, tbl, hash) {
=2D		if (params.obj_cmpfn ?
=2D		    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
=2D		    rhashtable_compare(&arg, rht_obj(ht, he)))
=2D			continue;
=2D		return he;
=2D	}
+	head =3D rht_bucket(tbl, hash);
+	do {
+		rht_for_each_rcu_continue(he, *head, tbl, hash) {
+			if (params.obj_cmpfn ?
+			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
+			    rhashtable_compare(&arg, rht_obj(ht, he)))
+				continue;
+			return he;
+		}
+		/* An object might have been moved to a different hash chain,
+		 * while we walk along it - better check and retry.
+		 */
+	} while (he !=3D RHT_NULLS_MARKER(head));
=20
 	/* Ensure we see any new tables. */
 	smp_rmb();
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index ae4223e0f5bc..0b1baede369c 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1175,8 +1175,7 @@ struct rhash_head __rcu **rht_bucket_nested(const str=
uct bucket_table *tbl,
 					    unsigned int hash)
 {
 	const unsigned int shift =3D PAGE_SHIFT - ilog2(sizeof(void *));
=2D	static struct rhash_head __rcu *rhnull =3D
=2D		(struct rhash_head __rcu *)NULLS_MARKER(0);
+	static struct rhash_head __rcu *rhnull;
 	unsigned int index =3D hash & ((1 << tbl->nest) - 1);
 	unsigned int size =3D tbl->size >> tbl->nest;
 	unsigned int subhash =3D hash;
@@ -1194,8 +1193,11 @@ struct rhash_head __rcu **rht_bucket_nested(const st=
ruct bucket_table *tbl,
 		subhash >>=3D shift;
 	}
=20
=2D	if (!ntbl)
+	if (!ntbl) {
+		if (!rhnull)
+			INIT_RHT_NULLS_HEAD(rhnull);
 		return &rhnull;
+	}
=20
 	return &ntbl[subhash].bucket;
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltaRXkACgkQOeye3VZi
gbm+/w/8Cqo5KkJL5q6Ndkh3FFeP7kk9aXQtKLLifPJPEwc3Dj5w7sYBS9q8NmSS
KoNYDMFJH5RldE91Tv0pa2C5DEl4DGOE2zI0k6L1bavbd+AScdI/TX5GKE3S6bPV
W6x998LExRM93F7X0FEyPVFyUkYRD2ERfanJDigcLaEafSQr7lH8z19Uwh5fN72u
VbpZiJTJUvH+ssfrAlApmcnyyAqIqSsyi2uSRIuRKX7z7odw2oOMkBJ0YxM/8m8s
t9nDYBMcg4Iqnah/nrZbcnuEIlw7GidT1RpMLa5bZtFCAAzDB8crqOwZOD64L3UR
8P17cdngEfT+OrlmJPcR5szVWihz16n4K+APzxqeZ6BVRAnvknIcI2KtEil2cg2K
35PLRz6CCUDCuR2xIck36OiK72i9C6Ojbr73YZrR3j/3jprUBw/eUCKwKId2lP30
V7cYZojzo/Ix4k6mso1KpD7xJutuCI3AWoEThuYCzN/lYKMCxBtaNqA6My2kwma5
k53x1YvWra55Tw0Aj3/jvqNhpIGjkUojhGN1weAyvLBQHLlvUuBLkNO1YchU+vBO
GZSe5llYLcab8qai/6uXD1kgD0D6LqxKgyZePYtMcfj6eWStDZzi+HumtD6AhbzW
k1+ZybuBoWgue2hUXVOgrcOZeHWoMo3jTPf2y43Gxl5/L7uJZds=
=/Wyx
-----END PGP SIGNATURE-----
--=-=-=--
