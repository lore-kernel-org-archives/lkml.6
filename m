Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeC0Vp3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:45:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55831 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbeC0Vp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:45:27 -0400
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "Cc"
        occurs 3 times
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 28 Mar 2018 08:45:18 +1100
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tom Herbert <tom@quantonium.net>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/6 v2] rhashtable: improve documentation for rhashtable_walk_peek()
In-Reply-To: <152210718418.11435.11573013181393548255.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble> <152210718418.11435.11573013181393548255.stgit@noble>
Message-ID: <87vadh42hd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


In this version I:
 - fixed brace-after-else coding style, thanks Sergei Shtylyov,
 - explained where the one user is, thanks David Miller
 - added CC for author of rhashtable_walk_peek (Tom Herbert) and
   of the one usage (Andreas Gruenbacher) - thanks Herbert Xu

NeilBrown

=2D----------------8<-------------------------
Subject: [PATCH] rhashtable: improve documentation for rhashtable_walk_peek=
()

The documentation for rhashtable_walk_peek() wrong.  It claims to
return the *next* entry, whereas it in fact returns the *previous*
entry.
However if no entries have yet been returned - or if the iterator
was reset due to a resize event, then rhashtable_walk_peek()
*does* return the next entry, but also advances the iterator.

I suspect that this interface should be discarded and the one user
should be changed to not require it.  The only current user is
gfs2_glock_iter_next in fs/gfs2/glock.c, which is part of the
implementation of a seq_file which reports all the content of the
hash table.
Possibly this patch should be seen as a first step in that
conversation.

This patch mostly corrects the documentation, but does make a
small code change so that the documentation can be correct without
listing too many special cases.  I don't think gfs2_glock_iter_next
will be affected by the code change.

Cc: Tom Herbert <tom@quantonium.net>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 lib/rhashtable.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 3825c30aaa36..9367816820ea 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -853,13 +853,17 @@ void *rhashtable_walk_next(struct rhashtable_iter *it=
er)
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
=20
 /**
=2D * rhashtable_walk_peek - Return the next object but don't advance the i=
terator
+ * rhashtable_walk_peek - Return the previously returned object without ad=
vancing the iterator
  * @iter:	Hash table iterator
  *
=2D * Returns the next object or NULL when the end of the table is reached.
+ * Returns the last object returned, or NULL if no object has yet been ret=
urned.
+ * If the previously returned object has since been removed, then some oth=
er arbitrary
+ * object maybe returned, or possibly NULL will be returned.  In that case=
, the
+ * iterator might be advanced.
  *
  * Returns -EAGAIN if resize event occurred.  Note that the iterator
=2D * will rewind back to the beginning and you may continue to use it.
+ * will rewind back to the beginning and rhashtable_walk_next() should be
+ * used to get the next object.
  */
 void *rhashtable_walk_peek(struct rhashtable_iter *iter)
 {
@@ -880,6 +884,12 @@ void *rhashtable_walk_peek(struct rhashtable_iter *ite=
r)
 		 * the table hasn't changed.
 		 */
 		iter->skip--;
+	} else {
+		/* ->skip is only zero after rhashtable_walk_start()
+		 * or when the iterator is reset.  In this case there
+		 * is no previous object to return.
+		 */
+		return NULL;
 	}
=20
 	return __rhashtable_walk_find_next(iter);
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlq6u24ACgkQOeye3VZi
gbmL+Q//dO+Fld6gE/k1GL/LV6d+h9iOoJXSEVy1CXt/GQPdM/p5q2PQK8RHXmUn
9Rcudzn8muc71mydai+UTb2jSJtb5Gfhz1LxXKVp1APQxn4q/ggyaK8ENlJgOKuy
k3JhNVS6uGlHs6l2/O8i1TY40Tykvv3F80wCjvI2gND51wEMASGwsMTwh/doF5mo
VuRc5ZCYf+momLFogsyRPBSUBXNCTgr3H2FaxFwIIN6tfMbzur5k2x7c/eCAfgey
jQHVrjjamjV8vzowP+/bJOXudPVzOIckwo+oZSyhvLRj+JWXtR7z3WNg/3h4fa6z
XL6E/eslbbKpQzVJzu8v+tdpnFBq+UX6KnGuL8vHGZmIPZq30zss07h9wTqx85lt
PziOeMLR7h100Rwf5uIV97VMGMFXbSxzWrlp7KTwQXWItBgrCla/xDpJBbcXbBTo
l5ir4orz4PrMQWakSs8qJITKnKMU6QXZlwuTSl4Ny57Xp847lfzbMDP6NhgKQAWH
OWugpew3MHd0JAEhogpjIhN/brL2d0br07y3q6JtDPWE7gbyDL8JD4VQ5gM1fL7+
RXSF0ZuPXKhI5icZz7EHvoQ3BUPIzU2sn7/ZCV8BAOCmaThzNG5zc0Z+eerOoSVC
k5zXgZstImPqeIaBTKqK/SlNeAkqHHPhKsPMSFI/1+OLoycOyGk=
=a0sn
-----END PGP SIGNATURE-----
--=-=-=--
