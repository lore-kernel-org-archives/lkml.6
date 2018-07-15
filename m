Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF4AECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265AE2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265AE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeGPAWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:22:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:56720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbeGPAWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:22:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1832ACF1;
        Sun, 15 Jul 2018 23:57:17 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Mon, 16 Jul 2018 09:57:11 +1000
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: [PATCH - revised] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180711.224801.1129067473269289703.davem@davemloft.net>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au> <87k1q8yh70.fsf@notabene.neil.brown.name> <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net>
Message-ID: <87fu0kt5m0.fsf@notabene.neil.brown.name>
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


Some users of rhashtable might need to change the key
of an object and move it to a different location in the table.
Other users might want to allocate objects using
SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
being used for a different (type-compatible) purpose and similarly
end up in a different hash-chain.

To support these, we store a unique NULLS_MARKER at the end of
each chain, and when a search fails to find a match, we check
if the NULLS marker found was the expected one.  If not,
the search is repeated.

The unique NULLS_MARKER is derived from the address of the
head of the chain.

If an object is removed and re-added to the same hash chain, we won't
notice by looking that the NULLS marker.  In this case we must be sure
that it was not re-added *after* its original location, or a lookup may
incorrectly fail.  The easiest solution is to ensure it is inserted at
the start of the chain.  insert_slow() already does that,
insert_fast() does not.  So this patch changes insert_fast to always
insert at the head of the chain.

Note that such a user must do their own double-checking of
the object found by rhashtable_lookup_fast() after ensuring
mutual exclusion which anything that might change the key, such as
successfully taking a new reference.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 include/linux/rhashtable.h | 35 +++++++++++++++++++++++------------
 lib/rhashtable.c           |  8 +++++---
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index eb7111039247..10435a77b156 100644
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
@@ -580,6 +589,7 @@ static inline void *__rhashtable_insert_fast(
 		.ht =3D ht,
 		.key =3D key,
 	};
+	struct rhash_head __rcu **headp;
 	struct rhash_head __rcu **pprev;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
@@ -603,12 +613,13 @@ static inline void *__rhashtable_insert_fast(
 	}
=20
 	elasticity =3D RHT_ELASTICITY;
=2D	pprev =3D rht_bucket_insert(ht, tbl, hash);
+	headp =3D rht_bucket_insert(ht, tbl, hash);
+	pprev =3D headp;
 	data =3D ERR_PTR(-ENOMEM);
 	if (!pprev)
 		goto out;
=20
=2D	rht_for_each_continue(head, *pprev, tbl, hash) {
+	rht_for_each_continue(head, *headp, tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
=20
@@ -648,7 +659,7 @@ static inline void *__rhashtable_insert_fast(
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		goto slow_path;
=20
=2D	head =3D rht_dereference_bucket(*pprev, tbl, hash);
+	head =3D rht_dereference_bucket(*headp, tbl, hash);
=20
 	RCU_INIT_POINTER(obj->next, head);
 	if (rhlist) {
@@ -658,7 +669,7 @@ static inline void *__rhashtable_insert_fast(
 		RCU_INIT_POINTER(list->next, NULL);
 	}
=20
=2D	rcu_assign_pointer(*pprev, obj);
+	rcu_assign_pointer(*headp, obj);
=20
 	atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 0e04947b7e0c..1737fbd049da 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1164,8 +1164,7 @@ struct rhash_head __rcu **rht_bucket_nested(const str=
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
@@ -1183,8 +1182,11 @@ struct rhash_head __rcu **rht_bucket_nested(const st=
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltL31cACgkQOeye3VZi
gbksmhAAmZVoELhBVt321K49kegx4XccqSmLcsiOspMisRgmt2O53lxMppQVUHXZ
KvAQEsSfCPIXTmhk024xb76dtqHDwnpjk+U3h7St8sRu2cw8YxVp6B0aS35X+y6F
wSxrUf1nGldp37jgFd+HLAu99LNsayJ0eqMqlQuh/7xU3s7lGlu0CN/XTmVSmJGU
fpu9uoTJWrboHku03GGX+3dktJKa4en4OKDdN4HinuU6htB9zLvFLoXjJtrQDNlV
RXFPuizFGfp3YOmJOraM9aBmrGCxYjHb9pP4bL+x2d07MtstcrBDW34w55iQ2v5V
fOCSCYP07hixf7+uD7wzMcRVWDTJLlNXiXAgNeKPqE3P8juQEFZe7ykBXCdqOi/S
KqdSKkuoc2pnfs7PW26EV1NIqWlno8PXQfGMKj6NOx0pO7Xp+PkuvJaYUQQqdjM6
qeEfSE2zBrRqpr0MvyPwGHItkSWYjHNQBOrtF/AFO42CkUl4E5Q/EUab1yyF7hcd
dS1rN2sMDqp4QAP5ASZ8T5Vi3DyHcgx2IrRjmn1PCm5RpMz42HDuw5ic4+678IRd
zBnY8ZVzgOD+f6dHEMCZvy7JLjUmPlUpwvi5Aw4ORCsFj1tkpxywuZshKlRvpMpg
Ewe2JQT7ApyrWmS7a+bJSLzAQ0E6Teq3apWWggGHNS30jOIvGvY=
=fjy7
-----END PGP SIGNATURE-----
--=-=-=--
