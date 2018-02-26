Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBZD6G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:58:06 -0500
Received: from ozlabs.org ([103.22.144.67]:55967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751959AbeBZD6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:58:03 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Feb 2018 14:57:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@elte.hu>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Subject: linux-next: build failure after merge of the percpu tree
Message-ID: <20180226145756.228d1e23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mtTtVY7XKF=aWFkX/2MNmCb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mtTtVY7XKF=aWFkX/2MNmCb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the percpu tree, today's linux-next build (sparc defconfig)
failed like this:

mm/percpu.c: In function 'pcpu_balance_workfn':
mm/percpu.c:1613:3: error: implicit declaration of function 'cond_resched';=
 did you mean 'should_resched'? [-Werror=3Dimplicit-function-declaration]
   cond_resched();
   ^~~~~~~~~~~~
   should_resched

Caused by commit

  accd4f36a7d1 ("percpu: add a schedule point in pcpu_balance_workfn()")

I have added this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 26 Feb 2018 14:47:39 +1100
Subject: [PATCH] percpu: include sched.h for cond_resched()

Fixes: accd4f36a7d1 ("percpu: add a schedule point in pcpu_balance_workfn()=
")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/percpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 36e7b65ba6cf..15a398c00791 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -80,6 +80,7 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 #include <linux/kmemleak.h>
+#include <linux/sched.h>
=20
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/mtTtVY7XKF=aWFkX/2MNmCb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqThcQACgkQAVBC80lX
0Gxp2Af/R0uJKlQL9fAltStm4xJtBSVe+P4tdTRCn2t0A3x6hWn6w/N/AX3a4e8O
Fgb0ycThY19E5oWmLq/6nzRrDoVW72VaVqbGNrQ6LncXsjBSX+3prK9tQM7NN6un
gNKuVmS+Zl5tcf+NAYusodye3n2fNyXfsohACb6ITR8KfxcdYEmg44ZL1iwq/cKi
cUspBGiEx1DFpHTckRzHdpEk580nanOlruWyIS+P0XtTloPUfcOtFU25t8a/go3k
gLMw5YU4jkFcDDNVmyp0/m0lBHNA1oMiVBLxfBmndF5COk5nTEQusUQuK9e03HDD
XGi+T/ZC4xqn+pt0rYG05NuF1pANvg==
=ibhL
-----END PGP SIGNATURE-----

--Sig_/mtTtVY7XKF=aWFkX/2MNmCb--
