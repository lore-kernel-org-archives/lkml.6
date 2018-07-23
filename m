Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5E8C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9957420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9957420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbeGWCzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:55:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731254AbeGWCzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:55:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0797ACB0;
        Mon, 23 Jul 2018 01:56:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Mon, 23 Jul 2018 11:56:14 +1000
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: [PATCH net-next] rhashtable: detect when object movement between tables might have invalidated a lookup
In-Reply-To: <20180719.051440.931407144963903326.davem@davemloft.net>
References: <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net> <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180719.051440.931407144963903326.davem@davemloft.net>
Message-ID: <876016r9z5.fsf@notabene.neil.brown.name>
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

This is a simplified version of a previous patch.
It provides NULLS_MARKER support only for the specific use case
which is currently thought be valuable to in-tree users
of rhashtables.
Thanks,
NeilBrown



 include/linux/rhashtable.h | 25 +++++++++++++++++--------
 lib/rhashtable.c           |  3 +--
 2 files changed, 18 insertions(+), 10 deletions(-)

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
index ae4223e0f5bc..ac48f026a8c3 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1175,8 +1175,7 @@ struct rhash_head __rcu **rht_bucket_nested(const str=
uct bucket_table *tbl,
 					    unsigned int hash)
 {
 	const unsigned int shift =3D PAGE_SHIFT - ilog2(sizeof(void *));
=2D	static struct rhash_head __rcu *rhnull =3D
=2D		(struct rhash_head __rcu *)NULLS_MARKER(0);
+	static struct rhash_head __rcu *rhnull =3D RHT_NULLS_MARKER(&rhnull);
 	unsigned int index =3D hash & ((1 << tbl->nest) - 1);
 	unsigned int size =3D tbl->size >> tbl->nest;
 	unsigned int subhash =3D hash;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltVNb8ACgkQOeye3VZi
gbktahAAkdWXsRD9hjW+oMu9FwRVDDfb5nsHdHhT2BG8w7fKXHyKmW727Fb+K/o0
W6WQcZmBSxa44F/cMW8Wl0hqix7zviRzTjMlMpufQ0RfaHJldPoHm9uEqhaAcqst
Rnfpve+3t1clooG+IKuBHpB+qaytLuSJzpyxxoxBwPySu1YcehAd8qfAcEKu4Fua
JjvnOz8+b6URfr/11sdoYANLbjhxbkFtg8TtCOK4KQWOrkdw0TdX7TILiXV3TKo4
MPl7v91aYm/W4CLyoz+oEs/0H0ZGPGeiicKieVPnLJ8vGLgr+FloAFxSbMYdGFBa
CyuMdPVdyuMecbT+VOZFQZGai66SfkUbWSu/m9nO/Isqyju7ElndphEoww8R8Azn
FP9/ObWb+oGu1jIj/+M4DipcKMZf9D5yCO6eEmtLv9P6dCPazsmnwT4mABcA7D9l
yzuTflGsU5P5263WXtxk16Xnco2qAfZdsRim263p+0FllfS0Ui/LdDqqCItfyY0Q
6bQ5au2CKkMWpjXjQSUaYIgB03VSW/WMnUwh6L4019AxgSQRyg528OIdYF7lm3s6
suYEzyOKEwvbUmp/5n2kfUQ9zv5xHCVM6X6XAg7L0qoV9TGLJtP6yGTH6GLsQXod
yft7O7RV/6UuuG90zRN094YFWapInCwVmWrzybdZqvHQXkYTX/c=
=Y/oD
-----END PGP SIGNATURE-----
--=-=-=--
