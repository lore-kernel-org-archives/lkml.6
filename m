Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC22C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AF32148E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AF32148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeK3KeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:34:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:40576 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3KeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:34:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2DA2AE20;
        Thu, 29 Nov 2018 23:26:57 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Fri, 30 Nov 2018 10:26:50 +1100
Cc:     tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: [PATCH v3] rhashtable: detect when object movement between tables might have invalidated a lookup
In-Reply-To: <878t1tece0.fsf@notabene.neil.brown.name>
References: <87muqbtev6.fsf@notabene.neil.brown.name> <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au> <878t1tece0.fsf@notabene.neil.brown.name>
Message-ID: <87pnuno479.fsf@notabene.neil.brown.name>
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

This version has an added comment to explain the ">>1" in
RHT_NULLS_MARKER().

Thanks,
NeilBrown

 include/linux/rhashtable.h | 34 ++++++++++++++++++++++++++--------
 lib/rhashtable.c           |  8 +++++---
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index eb7111039247..ae507af54800 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -75,8 +75,19 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
=20
+/*
+ * NULLS_MARKER() expects a hash value with the low
+ * bits mostly likely to be significant, and it discards
+ * the msb.
+ * We git it an address, in which the bottom 2 bits are
+ * always 0, and the msb might be significant.
+ * So we shift the address down one bit to align with
+ * expectations and avoid losing a significant bit.
+ */
+#define	RHT_NULLS_MARKER(ptr)	\
+	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
 #define INIT_RHT_NULLS_HEAD(ptr)	\
=2D	((ptr) =3D (typeof(ptr)) NULLS_MARKER(0))
+	((ptr) =3D RHT_NULLS_MARKER(&(ptr)))
=20
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
 {
@@ -471,6 +482,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 		.ht =3D ht,
 		.key =3D key,
 	};
+	struct rhash_head __rcu * const *head;
 	struct bucket_table *tbl;
 	struct rhash_head *he;
 	unsigned int hash;
@@ -478,13 +490,19 @@ static inline struct rhash_head *__rhashtable_lookup(
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwAdboACgkQOeye3VZi
gbn96A/+OHwojhtpC3hdcI9CiYvjGide9ehwVLtgaF95+B+wV1ALPGoJ7Z+Mr9E1
NCXZEs8vmL2FXsQwArY6gCneoLXTAixLcOEPX7vMdZC/RbRZND+uNsJDn3Z96ncZ
2ma7oLgjzVSu+KrFIqn7PW6z4ppM9QR3egLCuRCVwCyTGtzQ4hDDmZUTD7qeHaV/
GK0PCkKoIJ5HB3SjXuT0st243cLtNnIBjGMyXNRVMcGH9Vgf3DejFMnnBcUqj8rh
Cd7hZ9gsrccKug5tKL9kEfFfh0pZH0rh7nQBSGKsPGxxP6iE7A7248AwKD2WRT59
/3GQkXIxM2Jrk3SqtBIpox3MqCqwJ2zVPO9MKhYjfW+nevofNAA7j8R+iqbSmUk1
S2J7jZYnjOI4k7hB6gVH8TgM7H8jDcr96eU18b67sybfzCR57H8l9PO6MeW0FW6D
oDuopi2TP0xyU+PFyhWqGgk4EmuYcqSPopcTlWUBzdhuTsHSjA7RF2gw88rfbTnC
EWv7GwNK9NosF8ANZzerb5Uhq9+Angz7apOd1LSwQ4TN4M4nKXc53zOV876f3bR5
DzZwxeDMcBSiE5UT9YMxOeRhjWcl5h0GRUmtnOuRi5X7b2D2lteGD0sK+vrBl5Xr
uEPLHpxAp6E2tnOxuZrhSc1Wi3LMgIkvANS158Ct2q8dGbhaCPA=
=DgXW
-----END PGP SIGNATURE-----
--=-=-=--
