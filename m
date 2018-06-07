Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id p0DrNiebGFtfBQAAmS7hNA
	; Thu, 07 Jun 2018 02:45:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3193E608B8; Thu,  7 Jun 2018 02:45:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9B08A607F7;
	Thu,  7 Jun 2018 02:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B08A607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeFGCpw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:45:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50777 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbeFGCpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:45:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6562AD0B;
        Thu,  7 Jun 2018 02:45:49 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: Tom Herbert <tom@herbertland.com>
Date: Thu, 07 Jun 2018 12:45:40 +1000
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Graf <tgraf@suug.ch>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Herbert <tom@quantonium.net>
Subject: [PATCH - RFC] rhashtable: add rhashtable_walk_last_seen()
In-Reply-To: <87in6wo636.fsf@notabene.neil.brown.name>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824964.30340.6329146982899668633.stgit@noble> <20180602154851.pfy4wryezuhxp76v@gondor.apana.org.au> <87y3fvpf40.fsf@notabene.neil.brown.name> <CALx6S37AYrFoJNrdToRc84J=B4f57jaHS077UsxdEoQ-xwyCeg@mail.gmail.com> <87sh63pakb.fsf@notabene.neil.brown.name> <CALx6S35sf4oj=x73SfhUxi1e9-u4Stxgr9BAj5E7KKmbufntwg@mail.gmail.com> <87r2lmnj2c.fsf@notabene.neil.brown.name> <CALx6S36Ce-rXQMzmFYZVPGD10Bo6udvRAHiZ5gWwnzVwoTVv0w@mail.gmail.com> <87in6wo636.fsf@notabene.neil.brown.name>
Message-ID: <871sdjnwkr.fsf@notabene.neil.brown.name>
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


rhashtable_walk_last_seen() returns the object returned by
the previous rhashtable_walk_next(), providing it is still in the
table (or was during this grace period).
This works even if rhashtable_walk_stop() and rhashtable_talk_start()
have been called since the last rhashtable_walk_next().

If there have been no calls to rhashtable_walk_next(), or if the
object is gone from the table, then NULL is returned.

This can usefully be used in a seq_file ->start() function.
If the pos is the same as was returned by the last ->next() call,
then rhashtable_walk_last_seen() can be used to re-establish the
current location in the table.  If it returns NULL, then
rhashtable_walk_next() should be used.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 include/linux/rhashtable.h |  1 +
 lib/rhashtable.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 657e37ae314c..d63b472e9d50 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -248,6 +248,7 @@ static inline void rhashtable_walk_start(struct rhashta=
ble_iter *iter)
=20
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
+void *rhashtable_walk_last_seen(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
=20
 void rhashtable_free_and_destroy(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index e0060cb264e9..45f2554399a5 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -949,6 +949,36 @@ void *rhashtable_walk_peek(struct rhashtable_iter *ite=
r)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
=20
+/**
+ * rhashtable_walk_last_seen - Return the previously returned object, if a=
vailable
+ * @iter:	Hash table iterator
+ *
+ * If rhashtable_walk_next() has previously been called and the object
+ * it returned is still in the hash table, that object is returned again,
+ * otherwise %NULL is returned.
+ *
+ * If the recent rhashtable_walk_next() call was since the most recent
+ * rhashtable_walk_start() call then the returned object may not, strictly
+ * speaking, still be in the table.  It will be safe to dereference.
+ *
+ * Note that the iterator is not changed.
+ */
+void *rhashtable_walk_last_seen(struct rhashtable_iter *iter)
+{
+	struct rhashtable *ht =3D iter->ht;
+	struct rhash_head *p =3D iter->p;
+
+	if (!p)
+		return NULL;
+	if (!iter->p_is_unsafe || ht->rhlist)
+		return p;
+	rht_for_each_rcu(p, iter->walker.tbl, iter->slot)
+		if (p =3D=3D iter->p)
+			return p;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(rhashtable_walk_last_seen);
+
 /**
  * rhashtable_walk_stop - Finish a hash table walk
  * @iter:	Hash table iterator
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsYnFQACgkQOeye3VZi
gbkf4A/8DMbMh50VCbOuQacFobPCHZ7lyTtxJP4/RwBKGEF+mzeq+KdNT2WaiB/Y
iQ24EUZhMCvpdBPkpLK0t7v10+jOv0/Ki29ceAELd9fQv2n0qJb9ojpBYlB44Sn4
Him86wcn6HqgzM/nDHnlE0aBN5DQ8dOlPjnSvDEiwrOmFTesO15rvSZFZGHbbCEI
+g75QqMrrA1v5V2mCK5wl+HpliZkYjHrtxZjja4hVq/8S2LLnO78YIoSamqr2FK0
xT1HQh7MSEjWenNkNEokNKj53bGfU+8+e9EaMwoEmr3jcv5g+MDjzhWBIGphHMvZ
hDDUwxApm7yxCD7yem1vQfayHXDr/0D5dVD5MUiIzBsNOb9U5+TpRAKTOG9iZBfo
kgy3LnaS6tTMvBnbJ3N8REe1OFSCJNrHjcOSfms0Tkck4IVRvrI47lp4amMDFjxG
2kVmBGQhEw3LO7W9NC/5kAMHOkxMhgJBYMOENb9aO8kfRc1biWouo5+FGkRdDApA
Bf51FysE57DIEf3/RrSAVqFTmeV0iadCgz94VhZdGQAqj8pw10F3NYVnAtEqPRdI
fb7zKGDk7mxOw/8hApDXVg/Q+TRumxc97U1FXqZCYYSncuqCTrBvINPyRuOfA/WO
xCULsjvgORtxnPri3Eos6xijgb1Je1BGa9SZYH/JPHG0/aTjtfA=
=FOW2
-----END PGP SIGNATURE-----
--=-=-=--
