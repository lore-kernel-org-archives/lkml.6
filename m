Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeDWBjc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:39:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50179 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753830AbeDWBj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 21:39:29 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 23 Apr 2018 11:39:17 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] rhashtable: remove incorrect comment on r{hl, hash}table_walk_enter()
In-Reply-To: <20180419032237.yjvjuh6n7n6tggtr@gondor.apana.org.au>
References: <152403346237.16895.8767189357062722046.stgit2@noble> <152403402192.16895.9740762152906281009.stgit2@noble> <20180418142854.wacgjdycxvfjh77s@gondor.apana.org.au> <87efjcqg2r.fsf@notabene.neil.brown.name> <20180419032237.yjvjuh6n7n6tggtr@gondor.apana.org.au>
Message-ID: <87d0yqog56.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19 2018, Herbert Xu wrote:

> On Thu, Apr 19, 2018 at 08:56:28AM +1000, NeilBrown wrote:
>>
>> I don't want to do that - I just want the documentation to be correct
>> (or at least, not be blatantly incorrect).  The function does not sleep,
>> and is safe to call with spin locks held.
>> Do we need to spell out when it can be called?  If so, maybe:
>>=20
>>    This function may be called from any process context, including
>>    non-preemptable context, but cannot be called from interrupts.
>
> Just to make it perfectly clear, how about "cannot be called from
> softirq or hardirq context"? Previously the not able to sleep part
> completely ruled out any ambiguity but the new wording could confuse
> people into thinking that this can be called from softirq context
> where it would be unsafe if mixed with process context usage.
>

Sound fair.  Could you Ack the following?  Then I'll resend all the
patches that have an ack.
I've realised that the "further improve stability of rhashtable_walk"
patch isn't actually complete, so I'll withdraw that for now.

Thanks,
NeilBrown

From=20e16c037398b6c057787437f3a0aaa7fd44c3bee3 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.com>
Date: Mon, 16 Apr 2018 11:05:39 +1000
Subject: [PATCH] rhashtable: Revise incorrect comment on
 r{hl,hash}table_walk_enter()

Neither rhashtable_walk_enter() or rhltable_walk_enter() sleep, though
they do take a spinlock without irq protection.
So revise the comments to accurately state the contexts in which
these functions can be called.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 include/linux/rhashtable.h | 5 +++--
 lib/rhashtable.c           | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 87d443a5b11d..4e1f535c2034 100644
=2D-- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -1268,8 +1268,9 @@ static inline int rhashtable_walk_init(struct rhashta=
ble *ht,
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
  *
=2D * This function may sleep so you must not call it from interrupt
=2D * context or with spin locks held.
+ * This function may be called from any process context, including
+ * non-preemptable context, but cannot be called from softirq or
+ * hardirq context.
  *
  * You must call rhashtable_walk_exit after this function returns.
  */
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 2b2b79974b61..6d490f51174e 100644
=2D-- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -668,8 +668,9 @@ EXPORT_SYMBOL_GPL(rhashtable_insert_slow);
  * For a completely stable walk you should construct your own data
  * structure outside the hash table.
  *
=2D * This function may sleep so you must not call it from interrupt
=2D * context or with spin locks held.
+ * This function may be called from any process context, including
+ * non-preemptable context, but cannot be called from softirq or
+ * hardirq context.
  *
  * You must call rhashtable_walk_exit after this function returns.
  */
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrdOUYACgkQOeye3VZi
gbnnpA/9HTRgJaKgT4RcH7gyOxd67e6dCqQUsW03265SQxkv8jWLEmteoQZOs3Nl
6UNlI3JUGqQaYtLstZewxkkyjJfbF/jdCBgorR/ICkGg7w5mbVNkameyDK+b+0ND
lUXD9L8s132z4WoybmHgAmJ0kYX2OmQcLSCXhSag2iTiQvdl0dPjgIZXq+iB6q6J
fZ8TdVP/x1OqXjRXhhKTx3VbqhiteUhFr3RLLjsRsowWJ/bRjuF+6K8E7lLq1stb
LYz17eQC18E82fiJWdeiRORtQYC1RmiDe0/68M7zBlAsvmOuQiXlEcGFkPHtUvK4
j5HcFQk6asdL4kpbLM3zachIAcES20oo1t092Kqa2heFFfJnr+ATGeRBAc6KMMHw
Rhfm9dFnm2Fyt7I0xI/1Yujm2V+Vk3OLCfK3RrGKuE7hXMnw/aTD/uEq6hQ4cpxj
pvfyww6OtPA0QGlzmHkkWZC1yxdjKMKI51o233zM5be3OnZrvlVLOi6UQGF3ZqSh
TNmLK8C9dBzi+0KvEkQSvyALj/ZHI+IGzyoIiXhre6NoQuXdlPuE6f5hj4YP7t7P
i/wSGn7NFwhduzRGgPHSFGAll2f+1WxmcktA7I/u+L2rPfJLlEB79yvQ1trx8WtC
igDSl1eD2CZDAQrouOS8NzpPXjc3eGg+WmEKKieZmQlWBJBnF9w=
=0QmK
-----END PGP SIGNATURE-----
--=-=-=--
