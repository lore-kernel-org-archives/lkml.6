Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeFDCxH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:53:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:54016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeFDCxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:53:05 -0400
From: NeilBrown <neilb@suse.com>
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 04 Jun 2018 12:52:54 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 15a/18] rhashtables: add lockdep tracking to bucket bit-spin-locks.
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824984.30340.1634082820568216846.stgit@noble> <20180602050322.liesw324q5kawcue@gondor.apana.org.au> <9bea77df-e7db-677a-31b2-710dc6d956ee@gmail.com> <871sdnqty4.fsf@notabene.neil.brown.name>
Message-ID: <87po17p8jd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Native bit_spin_locks are not tracked by lockdep.

The bit_spin_locks used for rhashtable buckets are local
to the rhashtable implementation, so there is little opportunity
for the sort of misuse that lockdep might detect.
However locks are held while a hash function or compare
function is called, and if one of these took a lock,
a misbehaviour is possible.

As it is quite easy to add lockdep support this unlikely
possibility see to be enough justification.

So create a lockdep class for bucket bit_spin_lock as attach
through a lockdep_map in each bucket_table.

With the 'nested' annotation in rhashtable_rehash_one(), lockdep
correctly reports a possible problem as this lock it taken
while another bucket lock (in another table) is held.  This
confirms that the added support works.
With the correct nested annotation in place, lockdep reports
no problems.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 include/linux/rhashtable.h | 40 +++++++++++++++++++++++++++-------------
 lib/rhashtable.c           | 17 ++++++++++-------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 42b5d037ad2e..b12c2cd30a56 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -70,6 +70,8 @@ struct bucket_table {
=20
 	struct bucket_table __rcu *future_tbl;
=20
+	struct lockdep_map	dep_map;
+
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
=20
@@ -90,20 +92,32 @@ struct bucket_table {
  * will have provided that.
  */
=20
=2Dstatic inline void rht_lock(struct rhash_head **bucket)
+static inline void rht_lock(struct bucket_table *tbl, struct rhash_head **=
bucket)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_map_acquire(&tbl->dep_map);
+}
+
+static inline void rht_lock_nested(struct bucket_table *tbl,
+				   struct rhash_head **bucket,
+				   unsigned int subclass)
 {
 	local_bh_disable();
 	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
 }
=20
=2Dstatic inline void rht_unlock(struct rhash_head **bucket)
+static inline void rht_unlock(struct bucket_table *tbl, struct rhash_head =
**bucket)
 {
+	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(1, (unsigned long *)bucket);
 	local_bh_enable();
 }
=20
=2Dstatic inline void rht_unlocked(void)
+static inline void rht_unlocked(struct bucket_table *tbl)
 {
+	lock_map_release(&tbl->dep_map);
 	preempt_enable();
 	__release(bitlock);
 	local_bh_enable();
@@ -742,11 +756,11 @@ static inline void *__rhashtable_insert_fast(
 	if (!headp)
 		goto out;
 	lock =3D pprev =3D headp;
=2D	rht_lock(lock);
+	rht_lock(tbl, lock);
=20
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
=2D		rht_unlock(lock);
+		rht_unlock(tbl, lock);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
@@ -825,10 +839,10 @@ static inline void *__rhashtable_insert_fast(
 		/* Assigning to *headp unlocked the chain, so we
 		 * don't need to do it again.
 		 */
=2D		rht_unlocked();
+		rht_unlocked(tbl);
 	} else {
 out:
=2D		rht_unlock(lock);
+		rht_unlock(tbl, lock);
 	}
 	rcu_read_unlock();
=20
@@ -1033,7 +1047,7 @@ static inline int __rhashtable_remove_fast_one(
 	if (!pprev)
 		return -ENOENT;
 	lock =3D pprev;
=2D	rht_lock(lock);
+	rht_lock(tbl, lock);
=20
 	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
@@ -1078,13 +1092,13 @@ static inline int __rhashtable_remove_fast_one(
 		rcu_assign_pointer(*pprev, obj);
 		if (lock =3D=3D pprev) {
 			/* That rcu_assign_pointer() unlocked the chain */
=2D			rht_unlocked();
+			rht_unlocked(tbl);
 			goto unlocked;
 		}
 		break;
 	}
=20
=2D	rht_unlock(lock);
+	rht_unlock(tbl, lock);
 unlocked:
 	if (err > 0) {
 		if (params.percpu_count)
@@ -1195,7 +1209,7 @@ static inline int __rhashtable_replace_fast(
 		return -ENOENT;
=20
 	lock =3D pprev;
=2D	rht_lock(lock);
+	rht_lock(tbl, lock);
=20
 	rht_for_each_from(he, rht_ptr(*pprev), tbl, hash) {
 		if (he !=3D obj_old) {
@@ -1208,13 +1222,13 @@ static inline int __rhashtable_replace_fast(
 		err =3D 0;
 		if (pprev =3D=3D lock) {
 			/* We just unlocked the chain by assigning to *pprev */
=2D			rht_unlocked();
+			rht_unlocked(tbl);
 			goto unlocked;
 		}
 		break;
 	}
=20
=2D	rht_unlock(lock);
+	rht_unlock(tbl, lock);
=20
 unlocked:
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index aa1e7be8fc5b..1fc235f5d04e 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -174,6 +174,7 @@ static struct bucket_table *bucket_table_alloc(struct r=
hashtable *ht,
 	struct bucket_table *tbl =3D NULL;
 	size_t size;
 	int i;
+	static struct lock_class_key __key;
=20
 	size =3D sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
 	if (gfp !=3D GFP_KERNEL)
@@ -190,6 +191,8 @@ static struct bucket_table *bucket_table_alloc(struct r=
hashtable *ht,
 	if (tbl =3D=3D NULL)
 		return NULL;
=20
+	lockdep_init_map(&tbl->dep_map, "rhashtable_bucket", &__key, 0);
+
 	tbl->size =3D size;
=20
 	INIT_LIST_HEAD(&tbl->walkers);
@@ -249,7 +252,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
=20
 	inspos =3D &new_tbl->buckets[new_hash];
 	lock =3D inspos;
=2D	rht_lock(lock);
+	rht_lock_nested(new_tbl, lock, SINGLE_DEPTH_NESTING);
=20
 	head =3D rht_ptr(rht_dereference_bucket(*inspos, new_tbl, new_hash));
 	while (!rht_is_a_nulls(head) && head < entry) {
@@ -260,9 +263,9 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
=20
 	rcu_assign_pointer(*inspos, entry);
 	if (inspos !=3D lock)
=2D		rht_unlock(lock);
+		rht_unlock(new_tbl, lock);
 	else
=2D		rht_unlocked();
+		rht_unlocked(new_tbl);
=20
 	/* Need to preserved the bit lock. */
 	if (rht_is_locked(*pprev))
@@ -283,14 +286,14 @@ static int rhashtable_rehash_chain(struct rhashtable =
*ht,
=20
 	if (!pprev)
 		return 0;
=2D	rht_lock(pprev);
+	rht_lock(old_tbl, pprev);
=20
 	while (!(err =3D rhashtable_rehash_one(ht, pprev, old_hash)))
 		;
=20
 	if (err =3D=3D -ENOENT)
 		err =3D 0;
=2D	rht_unlock(pprev);
+	rht_unlock(old_tbl, pprev);
=20
 	return err;
 }
@@ -658,7 +661,7 @@ static void *rhashtable_try_insert(struct rhashtable *h=
t, const void *key,
 			new_tbl =3D rht_dereference_rcu(tbl->future_tbl, ht);
 			data =3D ERR_PTR(-EAGAIN);
 		} else {
=2D			rht_lock(pprev);
+			rht_lock(tbl, pprev);
 			data =3D rhashtable_lookup_one(ht, pprev, tbl,
 						     hash, key, obj);
 			new_tbl =3D rhashtable_insert_one(ht, pprev, tbl,
@@ -666,7 +669,7 @@ static void *rhashtable_try_insert(struct rhashtable *h=
t, const void *key,
 			if (PTR_ERR(new_tbl) !=3D -EEXIST)
 				data =3D ERR_CAST(new_tbl);
=20
=2D			rht_unlock(pprev);
+			rht_unlock(tbl, pprev);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsUqYcACgkQOeye3VZi
gbkevhAAtKcCMbSrPr1HylAxCL2CVxVmTokP7Dl4DTtaTVE2DYIQtja/EnYiapvz
8GKeOMlEbF6UBY6TqHEs505clRAKV/sMjOUpat0TZs0eQP5fmSINkOP+x7L4bow/
4b5+w8IrhFAcVGkWIJZxaeqVCn15K72U8Q6Wc5QdFaYvzfsda+8udsmlax/DgvKZ
s02FQ+VZyHjjh9gnJ+gNR84Gy2fqk1SJZ0i8cydgWaO0B3YnO5WkpK7n+0M5OEhq
cXGEaK6nryVrmNAH4kkMgC8RVmGBWxlZQ9KxeE/DDcFT8VoIslMQahuH2VOTPhR6
ggx6A5UwtlRt3xb1DQ37ZSNzMP/UVGtBQP7gl4xN0fNWUifdux34fNy5wEzcFOrq
P2xRs0PYvNDZrBCfeeb5TsRXSokaXXfLq9XfaGjzBUivS6veqUqRlN/wd6GTqzT2
43cTbjr77k6+kLZ4VnF+bNiCm8box8sYjea9Zsy0Qpubn3U1oCPCy7CL6xyQIHDx
YPSl45jesX5BvTwj9O429OMgAEpmpKZi493e4lYZoBbMYCykjnKjqYh9VIMdDwUg
mf4TSkl8AFvAe3lXbq8Hn+3bp5RUcl9yazmjKc9SzfrhRGeIxxn3j/sp8ggVzSya
vk5KX7fCSLArF0ZYYgYKHy/c5r+ZyoamztJULAqs4rQalhKObrM=
=w/68
-----END PGP SIGNATURE-----
--=-=-=--
