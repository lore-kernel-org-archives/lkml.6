Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754810AbeDCFmV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 01:42:21 -0400
Received: from ozlabs.org ([103.22.144.67]:60891 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754331AbeDCFmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 01:42:19 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 15:41:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20180403154122.00d76d61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uJwx2qSW+qXiNaBkLiP/uCo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uJwx2qSW+qXiNaBkLiP/uCo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

net/rxrpc/call_object.c: In function 'rxrpc_rcu_destroy_call':
net/rxrpc/call_object.c:661:3: error: implicit declaration of function 'wak=
e_up_atomic_t'; did you mean 'wake_up_bit'? [-Werror=3Dimplicit-function-de=
claration]
   wake_up_atomic_t(&rxnet->nr_calls);
   ^~~~~~~~~~~~~~~~
   wake_up_bit
net/rxrpc/call_object.c: In function 'rxrpc_destroy_all_calls':
net/rxrpc/call_object.c:728:2: error: implicit declaration of function 'wai=
t_on_atomic_t'; did you mean 'wait_on_bit'? [-Werror=3Dimplicit-function-de=
claration]
  wait_on_atomic_t(&rxnet->nr_calls, atomic_t_wait, TASK_UNINTERRUPTIBLE);
  ^~~~~~~~~~~~~~~~
  wait_on_bit
net/rxrpc/call_object.c:728:37: error: 'atomic_t_wait' undeclared (first us=
e in this function); did you mean 'atomic_long_t'?
  wait_on_atomic_t(&rxnet->nr_calls, atomic_t_wait, TASK_UNINTERRUPTIBLE);
                                     ^~~~~~~~~~~~~
                                     atomic_long_t
net/rxrpc/call_object.c:728:37: note: each undeclared identifier is reporte=
d only once for each function it appears in
net/rxrpc/call_accept.c: In function 'rxrpc_discard_prealloc':
net/rxrpc/call_accept.c:223:4: error: implicit declaration of function 'wak=
e_up_atomic_t'; did you mean 'wake_up_bit'? [-Werror=3Dimplicit-function-de=
claration]
    wake_up_atomic_t(&rxnet->nr_conns);
    ^~~~~~~~~~~~~~~~
    wake_up_bit

Caused by commit

  9b8cce52c4b5 ("sched/wait: Remove the wait_on_atomic_t() API")

interacting with commits

  d3be4d244330 ("xrpc: Fix potential call vs socket/net destruction race")
  31f5f9a1691e ("rxrpc: Fix apparent leak of rxrpc_local objects")

from the net-next tree.

Haven't we figured out how to remove/change APIs yet? :-(

That tip tree commit is now in Linus' tree (merged since I started this
morning) so the net-next tree will need the below patch (or something
similar when it is merged.

I have applied the following merge fix patch (this may need more work):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 3 Apr 2018 15:34:48 +1000
Subject: [PATCH] sched/wait: merge fix up for wait_on_atomic() API removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/rxrpc/call_accept.c | 2 +-
 net/rxrpc/call_object.c | 4 ++--
 net/rxrpc/conn_object.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index f67017dcb25e..a9a9be5519b9 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -220,7 +220,7 @@ void rxrpc_discard_prealloc(struct rxrpc_sock *rx)
 		write_unlock(&rxnet->conn_lock);
 		kfree(conn);
 		if (atomic_dec_and_test(&rxnet->nr_conns))
-			wake_up_atomic_t(&rxnet->nr_conns);
+			wake_up_var(&rxnet->nr_conns);
 		tail =3D (tail + 1) & (size - 1);
 	}
=20
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index f721c2b7e234..f6734d8cb01a 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -658,7 +658,7 @@ static void rxrpc_rcu_destroy_call(struct rcu_head *rcu)
 	kfree(call->rxtx_annotations);
 	kmem_cache_free(rxrpc_call_jar, call);
 	if (atomic_dec_and_test(&rxnet->nr_calls))
-		wake_up_atomic_t(&rxnet->nr_calls);
+		wake_up_var(&rxnet->nr_calls);
 }
=20
 /*
@@ -725,5 +725,5 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 	write_unlock(&rxnet->call_lock);
=20
 	atomic_dec(&rxnet->nr_calls);
-	wait_on_atomic_t(&rxnet->nr_calls, atomic_t_wait, TASK_UNINTERRUPTIBLE);
+	wait_var_event(&rxnet->nr_calls, !atomic_read(&rxnet->nr_calls));
 }
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 0950ee3d26f5..4c77a78a252a 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -367,7 +367,7 @@ static void rxrpc_destroy_connection(struct rcu_head *r=
cu)
 	rxrpc_put_peer(conn->params.peer);
=20
 	if (atomic_dec_and_test(&conn->params.local->rxnet->nr_conns))
-		wake_up_atomic_t(&conn->params.local->rxnet->nr_conns);
+		wake_up_var(&conn->params.local->rxnet->nr_conns);
 	rxrpc_put_local(conn->params.local);
=20
 	kfree(conn);
@@ -482,6 +482,6 @@ void rxrpc_destroy_all_connections(struct rxrpc_net *rx=
net)
 	/* We need to wait for the connections to be destroyed by RCU as they
 	 * pin things that we still need to get rid of.
 	 */
-	wait_on_atomic_t(&rxnet->nr_conns, atomic_t_wait, TASK_UNINTERRUPTIBLE);
+	wait_var_event(&rxnet->nr_conns, !atomic_read(&rxnet->nr_conns));
 	_leave("");
 }
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/uJwx2qSW+qXiNaBkLiP/uCo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrDFAIACgkQAVBC80lX
0Gz+Uwf8CTmNfFYPo5qx5fOTsuQ36JQEVcShdKDG4A9d/znKEBflnYHJUQ89ptqK
EPN2ZpIOXJmTw3lPcfXRRRh+f7pd9TKnXFccPNtbLsTBHRZn9qCmZUMkofNG9AYT
JgJRagSDs6cdKVyk41BLtPSTYHr/6sXWKIux7fMpm7jSE4A8Fn/cRQrus6eDhngU
I2jv/RHMHDJG1K/JoM8i1LlhsDMlrMCduuISgacyCH9ondAEPi/yLNSAXzaZjqWi
IeeFJrm8S7FGAVZFJEFFPsSxevxD6LxdPqviXO4FpC0v9FIzkYyr46lEcTgIE2yj
TfFe2LThAr9xo4m+VJr9TE7S6oIGRQ==
=3w5l
-----END PGP SIGNATURE-----

--Sig_/uJwx2qSW+qXiNaBkLiP/uCo--
