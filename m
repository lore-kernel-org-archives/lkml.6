Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485EE22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485EE22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeKOJhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:37:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:37400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbeKOJhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:37:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67831B038;
        Wed, 14 Nov 2018 23:32:22 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au,
        tgraf@suug.ch
Date:   Thu, 15 Nov 2018 10:32:13 +1100
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: [PATCH] rhashtable: detect when object movement between tables might
 have invalidated a lookup
Message-ID: <87muqbtev6.fsf@notabene.neil.brown.name>
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


Some users of rhashtables might need to move an object from one table
to another -  this appears to be the reason for the incomplete usage
of NULLS markers.

To support these, we store a unique NULLS_MARKER at the end of
each chain, and when a search fails to find a match, we check
if the NULLS marker found was the expected one.  If not, the search
may not have examined all objects in the target bucket, so it is
repeated.

The unique NULLS_MARKER is derived from the address of the
head of the chain.  As this cannot be derived at load-time the
static rhnull in rht_bucket_nested() needs to be initialised
at run time.

Any caller of a lookup function must still be prepared for the
possibility that the object returned is in a different table - it
might have been there for some time.

Note that this does NOT provide support for other uses of
NULLS_MARKERs such as allocating with SLAB_TYPESAFE_BY_RCU or changing
the key of an object and re-inserting it in the same table.
These could only be done safely if new objects were inserted
at the *start* of a hash chain, and that is not currently the case.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

I sent this patch back in July, but I made a bit of a mess of it.
Here it is again, with a bit more care.

Previously in
   Commit: 9f9a707738aa ("rhashtable: remove nulls_base and related code.")
I removed some 'nulls' related code that wasn't being used and wasn't
usable.
This patch adds code to provide the functionality that the removed
code was intended for.
Specifically, it is now possible to move an object in one rhashtable
into another rhashtable, and still provide correct lookup(etc)
semantics.

If a lookup is performed on a table from which objects can be moved,
then a found object will have been in the table at some point during the
looku, but might not still be there.  If that lookup returns failure,
then you can be sure that there was no matching object in the table for
the entire duration of the lookup.

This patch doesn't provide code to safely move an object.  It just adds
enough code that the already-existing references to NULLS_MARKER()s make
sense.

NeilBrown


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
index 30526afa8343..852ffa5160f1 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1179,8 +1179,7 @@ struct rhash_head __rcu **rht_bucket_nested(const str=
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
@@ -1198,8 +1197,11 @@ struct rhash_head __rcu **rht_bucket_nested(const st=
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvssH0ACgkQOeye3VZi
gblytxAAqGgxAj7OUxk7eth8rAi1+e09bVYsJx6299Gu0z8MUCcqXUGtPLDyjLTd
b7DriROsrCXGhlNXknWiUiCuzV363jUkmHOJojJeTh+qBDp3hQFpewx3vgUukswQ
hV7xPpcplW2OSki8UnKwIeFPFe41g16ZHiR+CLBF03h4WtK88p0H675EkumgI6z1
Mg0LwzXJ2T202XRt7uMTkFVifuW/RhIkGeS4Bx3zZt4M2jPz00tXwNlgQ/97q5+c
A7RKO2xnP8VmX10N4iX2qubwjIG7rhQ3oQ1WEcFKEhP7uTgwLs0ojSbldo3lI8Gc
XGMqR2hDv9xa81UF+g0LxATHRHhr0jE5f369xvN/8YCZxz2S/7iPyrgSpu9i4gtm
6+0YkCrnLfd+14NTg35G0IBl3FLN3LE5YvD0cu3w+b1AZmtRXPN10J1JovmiACKF
Qcko9P45omo9NkxZF5RdWgXWyAJRs9PzRm4CCsor5bDpn23IVn/oYluTvZrjtlJa
wKCYWJ0XnCXjbPMYw3It10BZ6Op4TpJWLohESyGL3xPlcntCSd65GnvPQbTt+exk
OIyhmf65G3iu+eghovu/BR4BWQv2sHGwmrfPX/e5n5FG+7xrdPTwkf8f6dFo0y0m
Oj0X6GPOJoNWfpSNOs+hS2ota/AdC989kuLRrkJK9bApHKKVAtQ=
=IFph
-----END PGP SIGNATURE-----
--=-=-=--
