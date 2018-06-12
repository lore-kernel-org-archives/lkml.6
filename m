Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F58EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7201208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7201208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935186AbeFLCsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 22:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58047 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934958AbeFLCsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 22:48:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D4A44AD49;
        Tue, 12 Jun 2018 02:48:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Tom Herbert <tom@herbertland.com>
Date:   Tue, 12 Jun 2018 12:48:31 +1000
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Herbert <tom@quantonium.net>
Subject: [PATCH RFC v2] rhashtable: implement rhashtable_walk_peek() using rhashtable_walk_last_seen()
In-Reply-To: <CALx6S35GgUOd0dPgv7P96wNNTv5pN7fij0pcAoccqcSWZhvY7Q@mail.gmail.com>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au> <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com> <87sh63pakb.fsf@notabene.neil.brown.name> <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com> <87r2lmnj2c.fsf@notabene.neil.brown.name> <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com> <87in6wo636.fsf@notabene.neil.brown.name> <871sdjnwkr.fsf@notabene.neil.brown.name> <87y3frmhyx.fsf@notabene.neil.brown.name> <CALx6S35GgUOd0dPgv7P96wNNTv5pN7fij0pcAoccqcSWZhvY7Q@mail.gmail.com>
Message-ID: <871sdck9ds.fsf@notabene.neil.brown.name>
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


rhashtable_walk_last_seen() does most of the work that
rhashtable_walk_peek() needs done, so use it and put
it in a "static inline".
Also update the documentation for rhashtable_walk_peek() to clarify
the expected use case.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

v2 as static-inline - suggested by Tom.

Thanks,
NeilBrown

 include/linux/rhashtable.h | 29 ++++++++++++++++++++++++++++-
 lib/rhashtable.c           | 34 ----------------------------------
 2 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index d63b472e9d50..96ebc2690027 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -247,10 +247,37 @@ static inline void rhashtable_walk_start(struct rhash=
table_iter *iter)
 }
=20
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
=2Dvoid *rhashtable_walk_peek(struct rhashtable_iter *iter);
 void *rhashtable_walk_last_seen(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
=20
+/**
+ * rhashtable_walk_peek - Return the next object to use in an interrupted =
walk
+ * @iter:	Hash table iterator
+ *
+ * Returns the "current" object or NULL when the end of the table is reach=
ed.
+ * When an rhashtable_walk is interrupted with rhashtable_walk_stop(),
+ * it is often because an object was found that could not be processed
+ * immediately, possible because there is no more space to encode details
+ * of the object (e.g. when producing a seq_file from the table).
+ * When the walk is restarted, the same object needs to be processed again,
+ * if possible.  The object might have been removed from the table while
+ * the walk was paused, so it might not be available.  In that case, the
+ * normal "next" object should be treated as "current".
+ *
+ * To support this common case, rhashtable_walk_peek() returns the
+ * appropriate object to process after an interrupted walk, either the
+ * one that was most recently returned, or if that doesn't exist - the
+ * next one.
+ *
+ * Returns -EAGAIN if resize event occurred.  In that case the iterator
+ * will rewind back to the beginning and you may continue to use it.
+ */
+static inline void *rhashtable_walk_peek(struct rhashtable_iter *iter)
+{
+	return rhashtable_walk_last_seen(iter) ?:
+		rhashtable_walk_next(iter);
+}
+
 void rhashtable_free_and_destroy(struct rhashtable *ht,
 				 void (*free_fn)(void *ptr, void *arg),
 				 void *arg);
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 45f2554399a5..354275037df3 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -915,40 +915,6 @@ void *rhashtable_walk_next(struct rhashtable_iter *ite=
r)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
=20
=2D/**
=2D * rhashtable_walk_peek - Return the next object but don't advance the i=
terator
=2D * @iter:	Hash table iterator
=2D *
=2D * Returns the next object or NULL when the end of the table is reached.
=2D *
=2D * Returns -EAGAIN if resize event occurred.  Note that the iterator
=2D * will rewind back to the beginning and you may continue to use it.
=2D */
=2Dvoid *rhashtable_walk_peek(struct rhashtable_iter *iter)
=2D{
=2D	struct rhlist_head *list =3D iter->list;
=2D	struct rhashtable *ht =3D iter->ht;
=2D	struct rhash_head *p =3D iter->p;
=2D
=2D	if (p)
=2D		return rht_obj(ht, ht->rhlist ? &list->rhead : p);
=2D
=2D	/* No object found in current iter, find next one in the table. */
=2D
=2D	if (iter->skip) {
=2D		/* A nonzero skip value points to the next entry in the table
=2D		 * beyond that last one that was found. Decrement skip so
=2D		 * we find the current value. __rhashtable_walk_find_next
=2D		 * will restore the original value of skip assuming that
=2D		 * the table hasn't changed.
=2D		 */
=2D		iter->skip--;
=2D	}
=2D
=2D	return __rhashtable_walk_find_next(iter);
=2D}
=2DEXPORT_SYMBOL_GPL(rhashtable_walk_peek);
=2D
 /**
  * rhashtable_walk_last_seen - Return the previously returned object, if a=
vailable
  * @iter:	Hash table iterator
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsfNH8ACgkQOeye3VZi
gbn/tw//bpW3Eo57rREpk/xPbYL9FUKWTf4s2UzbtWQefBNxSjzdfSPaz+YfSJ67
/EniHZjo7OxSz2yIOCTcqx59ePqG3nr6NjNPBoYDzNi14M7qnXyHiCh1eHO16JX6
rTK5iRKooFjWZTAVc1V2HdKi1NKTd6Yy7CYcqvhtvmfhEMB9rDmsgvwtsQmukxwI
mhkpUeP2pir5QlcBhVjjvA6kDrNgJ6MRjh+k8AoO19vmJ3yUt4aLXkASEO0r7NvR
hEc/lpfkxsf51gzH7wUcJ4Ywc0YEPq7GKl8nwZ1G2mLtzcnuKvcfGWFAZh9ck4en
2/d47gEggmUL2NX2TGBPri2orliqtiadjxV96V+6grtS2RvlYPSi4jKxeHYsweyO
UJNdBMqGASQsk+KXs9FCf+hDj5jcZFp799FX1hWcgwLdARQrlNJqi6Thg8Qdvaer
FaM/f61ugeRw4n+QVA5kO3i7kWcf1jv/rbsK2+7Hg1+O0LA5uTQLzJ2z1G+qpa2E
DnLDRG1u9o4nhLasYFDW5oXQFVPL7gHQdvCGGRf+ixzg1MDrqYaIsPFCSaMNVVIa
kdpVwD6/swyZy8QUUh7/nHD78vQzrHrdnLf4ufPKdyfYT3OrmuwRcklfs4WBHFmi
PmhLdlsuT4cPU1Q2T261HMobfc854zo25bx8vjVOZO+/BbFXJOQ=
=qldV
-----END PGP SIGNATURE-----
--=-=-=--
