Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbeFAD7v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 23:59:51 -0400
Received: from ozlabs.org ([203.11.71.1]:51477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbeFAD7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 23:59:49 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 13:59:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20180601135943.66b90890@canb.auug.org.au>
In-Reply-To: <20180531073855.29c23fce@canb.auug.org.au>
References: <20180529132548.7f71c2ff@canb.auug.org.au>
        <20180531073855.29c23fce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/n.9LVszNWzS7qnUZXUD2hgH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n.9LVszNWzS7qnUZXUD2hgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 31 May 2018 07:38:55 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 29 May 2018 13:25:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the net-next tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > x86_64-linux-ld: unknown architecture of input file `net/bpfilter/bpfil=
ter_umh.o' is incompatible with i386:x86-64 output
> >=20
> > Caused by commit
> >=20
> >   d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> >=20
> > In my builds, the host is PowerPC 64 LE ...
> >=20
> > I have reverted that commit along with
> >=20
> >   61a552eb487f ("bpfilter: fix build dependency")
> >   13405468f49d ("bpfilter: don't pass O_CREAT when opening console for =
debug")
> >=20
> > for today. =20
>=20
> I am still getting this failure (well, at least yesterday I did).

Still happened today.  My guess is that bpfilter_umh needs to be built
with the kernel compiler (not the host compiler - since ir is meant to
run on the some machine as the kernel, right?) but will require the
kernel architecture libc etc


I replaced the reverts above with the following:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 1 Jun 2018 13:33:28 +1000
Subject: [PATCH] net: bpfilter: mark as BROKEN for now

This does not build in a cross compile environment

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/bpfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
index a948b072c28f..ea4be72fdf6e 100644
--- a/net/bpfilter/Kconfig
+++ b/net/bpfilter/Kconfig
@@ -2,6 +2,7 @@ menuconfig BPFILTER
 	bool "BPF based packet filtering framework (BPFILTER)"
 	default n
 	depends on NET && BPF && INET
+	depends on BROKEN
 	help
 	  This builds experimental bpfilter framework that is aiming to
 	  provide netfilter compatible functionality via BPF
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/n.9LVszNWzS7qnUZXUD2hgH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQxK8ACgkQAVBC80lX
0GwCHggAmx8CYmzcPprLmFQPnIWfgChZPxX3eYn/uNyzLGh37itxI78MsrzwIZ2x
vV4/Y+pEYeQHy8TLComcACQnP8cvgA4stM4/uTk0fgKVp5CO/D/IHr+tdlkeju/J
M6NQS7jpsCeXfCzZ131BN4+QTKM09NN5OfzmJxhNmW0upNr0Fm3ErxFv2ElgEY1b
YJwNWcae9+2v0/5P3D4py7JiFgmx2th62DTLxBaOXxRDGARxCH5hE22Wy5LkrGtE
RgJTcbV1csMinGj7quKxxqHcja04XVDzT1PPjpjd4zsmsCY1FdQP4P+R0pa2HLat
QIdHpIbtpb7u41WFy9tHCB2JT6/e/w==
=JYZW
-----END PGP SIGNATURE-----

--Sig_/n.9LVszNWzS7qnUZXUD2hgH--
