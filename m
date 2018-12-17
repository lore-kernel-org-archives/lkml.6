Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B91BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F223B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XdMh4unw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeLQJLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:11:52 -0500
Received: from ozlabs.org ([203.11.71.1]:58279 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLQJLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:11:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JFlR6Jk1z9sN1;
        Mon, 17 Dec 2018 20:11:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545037908;
        bh=Xjoc8JKR/wBT/vj+3XoU9gDjk+9UaLNGfNF25lTdsGY=;
        h=Date:From:To:Cc:Subject:From;
        b=XdMh4unw61LtO4ZFuRBHu75i1UV5AJQlFF7/kgIxMmQF15jzJSQcXDn6PQSBdvM5P
         fzIJjVHWTflR5aezjJAB4mqnn1VZY9kQAXiJCay0KJyjelKVcsPGhPKQFDAEf94k3C
         ROCq9uNcKkyWSOyfvvaZgJDglspCTSTh4i5h2RGfwY125cMpvzQr/UHQ12i/S9hlSu
         gYztgQrhGkwgXecz2iXIfEtWq4JKhvMrJeMjBXV3SPeZaDtWvB8lEqD8lTnxCYn0eu
         sSeIPrejXXqRUSQUappj8Z2MDYeTwyMibpkJMC/H8zhWWBfntRGv2rOrlmNRYNs0uh
         CfCiUaL6Ty9MA==
Date:   Mon, 17 Dec 2018 20:11:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>, Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paulo Alcantara <palcantara@suse.de>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: build failure after merge of the y2038 tree
Message-ID: <20181217201146.170ca9b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/b9PV77FI4lBcRm.5LYedj1L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b9PV77FI4lBcRm.5LYedj1L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

After merging the y2038 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/cifs/dfs_cache.c: In function 'cache_entry_expired':
fs/cifs/dfs_cache.c:106:7: error: implicit declaration of function 'current=
_kernel_time64'; did you mean 'core_kernel_text'? [-Werror=3Dimplicit-funct=
ion-declaration]
  ts =3D current_kernel_time64();
       ^~~~~~~~~~~~~~~~~~~~~
       core_kernel_text
fs/cifs/dfs_cache.c:106:5: error: incompatible types when assigning to type=
 'struct timespec64' from type 'int'
  ts =3D current_kernel_time64();
     ^
fs/cifs/dfs_cache.c: In function 'get_expire_time':
fs/cifs/dfs_cache.c:342:24: error: incompatible type for argument 1 of 'tim=
espec64_add'
  return timespec64_add(current_kernel_time64(), ts);
                        ^~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/restart_block.h:10,
                 from include/linux/thread_info.h:13,
                 from arch/x86/include/asm/preempt.h:7,
                 from include/linux/preempt.h:78,
                 from include/linux/rcupdate.h:40,
                 from fs/cifs/dfs_cache.c:8:
include/linux/time64.h:66:66: note: expected 'struct timespec64' but argume=
nt is of type 'int'
 static inline struct timespec64 timespec64_add(struct timespec64 lhs,
                                                ~~~~~~~~~~~~~~~~~~^~~
fs/cifs/dfs_cache.c:343:1: warning: control reaches end of non-void functio=
n [-Wreturn-type]
 }
 ^

Caused by commit

  ccea641b6742 ("timekeeping: remove obsolete time accessors")

interacting with commit

  34a44fb160f9 ("cifs: Add DFS cache routines")

from the cifs tree.

I have applied the following merge fix patch (better versions welcome):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 17 Dec 2018 20:03:28 +1100
Subject: [PATCH] cifs: update for current_kernel_time64() removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/cifs/dfs_cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 70f9c9e2175c..d20cc94d7abd 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -103,7 +103,7 @@ static inline bool cache_entry_expired(const struct dfs=
_cache_entry *ce)
 {
 	struct timespec64 ts;
=20
-	ts =3D current_kernel_time64();
+	ktime_get_coarse_real_ts64(&ts);
 	return timespec64_compare(&ts, &ce->ce_etime) >=3D 0;
 }
=20
@@ -338,8 +338,10 @@ static inline struct timespec64 get_expire_time(int tt=
l)
 		.tv_sec =3D ttl,
 		.tv_nsec =3D 0,
 	};
+	struct timespec64 now;
=20
-	return timespec64_add(current_kernel_time64(), ts);
+	ktime_get_coarse_real_ts64(&now);
+	return timespec64_add(now, ts);
 }
=20
 /* Allocate a new DFS target */
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/b9PV77FI4lBcRm.5LYedj1L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwXaFIACgkQAVBC80lX
0GxqBQgApHUD43yvLCpA7lqOg9JyNZKwi4uYKwFWOolil5QlsEKxxZqyZYYywhQB
dyGJ2mf9wH6Kq+pnPQINEnJAido1APqtC6h+0veYgMoDE7ea/AgbdwIiXkQikapp
UQIpLqUR/6aeqKRaWsHIWBdHqg12blIsrdNczJNhQFvLqCFZ7O/Sm9JR70cHb6KU
xHwRwNPLSG85bM2rN1QGCHPHngomhe6/j8EB5zlBzvoV9JkHHs7MDOvsrIujFksc
0zmZu+XTvsL8j2EXjq5ssspxQr2f4dqLI0zyopQdYDtcMQxCAI4UlHIrxhxBs/Ml
cwOY60WgBWGi79XZ3rD15vxhbnQs7g==
=XT4/
-----END PGP SIGNATURE-----

--Sig_/b9PV77FI4lBcRm.5LYedj1L--
