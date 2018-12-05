Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DFDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1A42084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1A42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeLEDvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:51:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:55290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726830AbeLEDvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:51:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25401AEF7;
        Wed,  5 Dec 2018 03:51:13 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>
Date:   Wed, 05 Dec 2018 14:51:02 +1100
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <153086109256.2825.15329014177598382684.stgit@noble>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109256.2825.15329014177598382684.stgit@noble>
Message-ID: <87zhtkeimx.fsf@notabene.neil.brown.name>
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


If the sequence:
   obj =3D rhashtable_walk_next(iter);
   rhashtable_walk_stop(iter);
   rhashtable_remove_fast(ht, &obj->head, params);
   rhashtable_walk_start(iter);

 races with another thread inserting or removing
 an object on the same hash chain, a subsequent
 rhashtable_walk_next() is not guaranteed to get the "next"
 object. It is possible that an object could be
 repeated, or missed.

 This can be made more reliable by keeping the objects in a hash chain
 sorted by memory address.  A subsequent rhashtable_walk_next()
 call can reliably find the correct position in the list, and thus
 find the 'next' object.

 It is not possible to take this approach with an rhltable as keeping
 the hash chain in order is not so easy.  When the first object with a
 given key is removed, it is replaced in the chain with the next
 object with the same key, and the address of that object may not be
 correctly ordered.
 I have not yet found any way to achieve the same stability
 with rhltables, that doesn't have a major impact on lookup
 or insert.  No code currently in Linux would benefit from
 such extra stability.

 With this patch:
 - a new object is always inserted after the last object with a
   smaller address, or at the start.
 - when rhashtable_walk_start() is called, it records that 'p' is not
   'safe', meaning that it cannot be dereferenced.  The revalidation
   that was previously done here is moved to rhashtable_walk_next()
 - when rhashtable_walk_next() is called while p is not NULL and not
   safe, it walks the chain looking for the first object with an
   address greater than p and returns that.  If there is none, it moves
   to the next hash chain.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

This is a resend of a patch that I sent back in July.  I couldn't
applied then because it assumed another rhashtable patch which hadn't
landed yet - it now has.

NeilBrown

 include/linux/rhashtable-types.h |  1 +
 include/linux/rhashtable.h       | 10 ++++-
 lib/rhashtable.c                 | 82 ++++++++++++++++++++++++++----------=
----
 3 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-ty=
pes.h
index 763d613ce2c2..bc3e84547ba7 100644
=2D-- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -126,6 +126,7 @@ struct rhashtable_iter {
 	struct rhashtable_walker walker;
 	unsigned int slot;
 	unsigned int skip;
+	bool p_is_unsafe;
 	bool end_of_table;
 };
=20
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 20f9c6af7473..4a8056b66bfb 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -635,7 +635,12 @@ static inline void *__rhashtable_insert_fast(
 		    (params.obj_cmpfn ?
 		     params.obj_cmpfn(&arg, rht_obj(ht, head)) :
 		     rhashtable_compare(&arg, rht_obj(ht, head)))) {
=2D			pprev =3D &head->next;
+			if (rhlist) {
+				pprev =3D &head->next;
+			} else {
+				if (head < obj)
+					pprev =3D &head->next;
+			}
 			continue;
 		}
=20
@@ -1131,7 +1136,8 @@ static inline int rhashtable_walk_init(struct rhashta=
ble *ht,
  * Note that if you restart a walk after rhashtable_walk_stop you
  * may see the same object twice.  Also, you may miss objects if
  * there are removals in between rhashtable_walk_stop and the next
=2D * call to rhashtable_walk_start.
+ * call to rhashtable_walk_start.  Note that this is different to
+ * rhashtable_walk_enter() which never misses objects.
  *
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 852ffa5160f1..d4154b9a29a1 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -225,6 +225,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,=
 unsigned int old_hash)
 	struct bucket_table *old_tbl =3D rht_dereference(ht->tbl, ht);
 	struct bucket_table *new_tbl =3D rhashtable_last_table(ht, old_tbl);
 	struct rhash_head __rcu **pprev =3D rht_bucket_var(old_tbl, old_hash);
+	struct rhash_head __rcu **inspos;
 	int err =3D -EAGAIN;
 	struct rhash_head *head, *next, *entry;
 	spinlock_t *new_bucket_lock;
@@ -253,12 +254,15 @@ static int rhashtable_rehash_one(struct rhashtable *h=
t, unsigned int old_hash)
 	new_bucket_lock =3D rht_bucket_lock(new_tbl, new_hash);
=20
 	spin_lock_nested(new_bucket_lock, SINGLE_DEPTH_NESTING);
=2D	head =3D rht_dereference_bucket(new_tbl->buckets[new_hash],
=2D				      new_tbl, new_hash);
=2D
+	inspos =3D &new_tbl->buckets[new_hash];
+	head =3D rht_dereference_bucket(*inspos, new_tbl, new_hash);
+	while (!rht_is_a_nulls(head) && head < entry) {
+		inspos =3D &head->next;
+		head =3D rht_dereference_bucket(*inspos, new_tbl, new_hash);
+	}
 	RCU_INIT_POINTER(entry->next, head);
=20
=2D	rcu_assign_pointer(new_tbl->buckets[new_hash], entry);
+	rcu_assign_pointer(*inspos, entry);
 	spin_unlock(new_bucket_lock);
=20
 	rcu_assign_pointer(*pprev, next);
@@ -554,6 +558,10 @@ static struct bucket_table *rhashtable_insert_one(stru=
ct rhashtable *ht,
 		return ERR_PTR(-ENOMEM);
=20
 	head =3D rht_dereference_bucket(*pprev, tbl, hash);
+	while (!ht->rhlist && !rht_is_a_nulls(head) && head < obj) {
+		pprev =3D &head->next;
+		head =3D rht_dereference_bucket(*pprev, tbl, hash);
+	}
=20
 	RCU_INIT_POINTER(obj->next, head);
 	if (ht->rhlist) {
@@ -648,10 +656,10 @@ EXPORT_SYMBOL_GPL(rhashtable_insert_slow);
  *
  * This function prepares a hash table walk.
  *
=2D * Note that if you restart a walk after rhashtable_walk_stop you
=2D * may see the same object twice.  Also, you may miss objects if
=2D * there are removals in between rhashtable_walk_stop and the next
=2D * call to rhashtable_walk_start.
+ * A walk is guaranteed to return every object that was in
+ * the table before this call, and is still in the table when
+ * rhashtable_walk_next() returns NULL.  Duplicates can be
+ * seen, but only if there is a rehash event during the walk.
  *
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
@@ -735,19 +743,10 @@ int rhashtable_walk_start_check(struct rhashtable_ite=
r *iter)
=20
 	if (iter->p && !rhlist) {
 		/*
=2D		 * We need to validate that 'p' is still in the table, and
=2D		 * if so, update 'skip'
+		 * 'p' will be revalidated when rhashtable_walk_next()
+		 * is called.
 		 */
=2D		struct rhash_head *p;
=2D		int skip =3D 0;
=2D		rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
=2D			skip++;
=2D			if (p =3D=3D iter->p) {
=2D				iter->skip =3D skip;
=2D				goto found;
=2D			}
=2D		}
=2D		iter->p =3D NULL;
+		iter->p_is_unsafe =3D true;
 	} else if (iter->p && rhlist) {
 		/* Need to validate that 'list' is still in the table, and
 		 * if so, update 'skip' and 'p'.
@@ -864,15 +863,39 @@ void *rhashtable_walk_next(struct rhashtable_iter *it=
er)
 	bool rhlist =3D ht->rhlist;
=20
 	if (p) {
=2D		if (!rhlist || !(list =3D rcu_dereference(list->next))) {
=2D			p =3D rcu_dereference(p->next);
=2D			list =3D container_of(p, struct rhlist_head, rhead);
=2D		}
=2D		if (!rht_is_a_nulls(p)) {
=2D			iter->skip++;
=2D			iter->p =3D p;
=2D			iter->list =3D list;
=2D			return rht_obj(ht, rhlist ? &list->rhead : p);
+		if (!rhlist && iter->p_is_unsafe) {
+			/*
+			 * First time next() was called after start().
+			 * Need to find location of 'p' in the list.
+			 */
+			struct rhash_head *p;
+
+			iter->skip =3D 0;
+			rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
+				iter->skip++;
+				if (p <=3D iter->p)
+					continue;
+
+				/* p is the next object after iter->p */
+				iter->p =3D p;
+				iter->p_is_unsafe =3D false;
+				return rht_obj(ht, p);
+			}
+			/* There is no "next" object in the list, move
+			 * to next hash chain.
+			 */
+		} else {
+			if (!rhlist || !(list =3D rcu_dereference(list->next))) {
+				p =3D rcu_dereference(p->next);
+				list =3D container_of(p, struct rhlist_head,
+						    rhead);
+			}
+			if (!rht_is_a_nulls(p)) {
+				iter->skip++;
+				iter->p =3D p;
+				iter->list =3D list;
+				return rht_obj(ht, rhlist ? &list->rhead : p);
+			}
 		}
=20
 		/* At the end of this slot, switch to next one and then find
@@ -882,6 +905,7 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
 		iter->slot++;
 	}
=20
+	iter->p_is_unsafe =3D false;
 	return __rhashtable_walk_find_next(iter);
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwHSygACgkQOeye3VZi
gbnDWw/+K+GVxehFAtWhyiuK+gI9g1uV5ThFp5yV70S9BuTXUQiKAZMH9h7pe11k
NLgtq0iOl442UvsRNb0GxlDtevJYdMcPnaW1jt3oE9fnoYm1Etr/dLDUwmJGNeUs
0vYZwcy0uEZ7Y++pHlLZ38NGsLD806egNfduUzzvfE+UDT7S8mD/wUrPsFZGOMo0
uGyVgxTimx0g62V/wx4bq8OlotUGb78OWDlnVMjGMElj6DQC5X5qIotwzaTw8cD7
90jrDjJ/9RKdzA8rSfXpzMZEAWZWg6w17j2ifMNSBpLMFLN68yKLJPlgJGLCpNau
AfU3omBAWYGLMnOyqcPsLAq7J9ZqCZDR3kz12pgXjWIMDouzn/yPMVal71s5hGC6
Ee238xygU/QTw2p5FNHUTL5fQXA9yFzHIqpr/CpUTfhn9HdFZ4GwWlEfUC9xk4Q3
CvYTKI04o/Cec5WZHExGGuVcX2BIBYZ9CB+KrJmm6SNggmITnCE4H4+kIhfOzz5j
/Pwrpk7zKPx1wQXLY72HwndlHnVi+ftWp/l1W4VZEDpeLrJlTKLB70bEK0ZnecHD
KL8M/+XXoG6pOJR4PMsF2smE76tqb2jFw7RddFbrMnykoq+fHGlH49S6StFBIXLw
xfVR1E7PVrLR7C2jCngYcTa7NG5rfaMHJvacOvr3ERATnk6Wqeo=
=CQV/
-----END PGP SIGNATURE-----
--=-=-=--
