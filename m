Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeDPXaR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 19:30:17 -0400
Received: from ozlabs.org ([203.11.71.1]:41085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeDPXaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 19:30:15 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 17 Apr 2018 09:28:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: linux-next: build failure after merge of the netfilter tree
Message-ID: <20180417092859.358573be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xGmb.tbd_m2j/9+ca6DNz7="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xGmb.tbd_m2j/9+ca6DNz7=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the netfilter tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

net/netfilter/nf_conntrack_extend.c: In function 'nf_ct_ext_
add':
net/netfilter/nf_conntrack_extend.c:74:2: error: implicit declaration of fu=
nction 'kmemleak_not_leak' [-Werror=3Dimplicit-function-declaration]
  kmemleak_not_leak(old);
  ^~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Caused by commit

  114aa35d06d4 ("netfilter: conntrack: silent a memory leak warning")

I have added this patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 17 Apr 2018 09:26:49 +1000
Subject: [PATCH] netfilter: conntrack: include kmemleak.h for
 kmemleak_not_leak()

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/netfilter/nf_conntrack_extend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_conntrack_extend.c b/net/netfilter/nf_conntra=
ck_extend.c
index bd71a828ebde..277bbfe26478 100644
--- a/net/netfilter/nf_conntrack_extend.c
+++ b/net/netfilter/nf_conntrack_extend.c
@@ -9,6 +9,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 #include <linux/kernel.h>
+#include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
--=20
2.16.3

--=20
Cheers,
Stephen Rothwell

--Sig_/xGmb.tbd_m2j/9+ca6DNz7=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrVMbsACgkQAVBC80lX
0GxZ7wf/WOhRUi85MTU9MkKgs5QnmbKMxPMN1AMN4JHpCtFH8GhZrOJoHKBeRnI8
nNlcCHW0P5tN8IzoDdUgvxX41g4IQc/doujuktE8nozsH5EbeshN3n5BT3BAssYK
/5pnMNrpziCsxdFJnAQ99gsWAc1NScAsfcqxvH5JnnW5Tk//QPNcC3cDM3XGja0n
QAH8JVSclPcnKZfcfbYpp3CFOacvF87WnsV0AgsMdUj8bGC8gR0gAv9Hiq0LFUwX
FVwMmvBwrsQKozYxhZgACzJXdxWDwjLsKez5jjVnSbtAjnIBECQRUs2SJh8L/2Tj
y2zMopyfzkNUHeu18vUnD/lZeTJ0JA==
=bv6w
-----END PGP SIGNATURE-----

--Sig_/xGmb.tbd_m2j/9+ca6DNz7=--
