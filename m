Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeDRXx3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:53:29 -0400
Received: from ozlabs.org ([203.11.71.1]:58411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbeDRXx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:53:27 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 19 Apr 2018 09:51:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Russell King <rmk@armlinux.org.uk>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the arm-current tree
Message-ID: <20180419095155.194217f5@canb.auug.org.au>
In-Reply-To: <20180418181722.GA7852@flint.armlinux.org.uk>
References: <20180418133155.0931baf7@canb.auug.org.au>
        <20180418175442.GA7234@flint.armlinux.org.uk>
        <20180418181722.GA7852@flint.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4=PHvLC0GIfZzkMd5bMVCQB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4=PHvLC0GIfZzkMd5bMVCQB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Russell,

On Wed, 18 Apr 2018 19:17:23 +0100 Russell King <rmk@armlinux.org.uk> wrote:
>
> Hmm, I guess it's a result of:
>=20
> # echo $(( ))
> dash: 4: arithmetic expression: expecting primary: " "
>=20
> which points to the sed expression producing no output.  If that's the
> case, then something else went wrong with the build earlier - there
> should be no case where the built vmlinux does not contain the
> __bss_start and __bss_stop symbols on ARM, since every kernel contains
> a .bss section.
>=20
> Olof's autobuilder shows no errors, but that could be because it's
> using bash - I don't know.  kernelci.org also shows no failures.
>=20
> I think more information is needed to debug this, such as:
>=20
> - does nm of the vmlinux contain the __bss_start and __bss_stop
>   symbols, and are they formatted as one would expect (iow, marked
>   as a global BSS symbol?)

$ /opt/cross/gcc-4.6.3-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-lin=
ux-gnueabi-nm vmlinux | grep __bss_st
008af260 A __bss_start
008b4394 A __bss_stop

so, that's our problem.  Note we are building with gcc 4.6.3 and binutils 2=
.22

> - does the nm | sed pipeline produce the expected output when run
>   outside of everything else?
> - does dash evaluate the output correctly outside of the makefile?

so dash returns the above error for 'echo $(( ))' and bash returns '0'

I had to actually symlink /bin/sh to dash to get it to fail - running
with in dash and setting SHELL to /bin/dash was not sufficient.

So under bash, we don't get an error, but we use 0 as the bss length :-(

I will this patch to linux-next today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Apr 2018 09:46:22 +1000
Subject: [PATCH] arm: check for A as well as B type sybols when calculating=
 BSS size

older compilers produce those

Fixes: 429f7a062e3b ("ARM: decompressor: fix BSS size calculation")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/M=
akefile
index b0354dfc7055..6a4e7341ecd3 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -118,8 +118,8 @@ asflags-y :=3D -DZIMAGE
=20
 # Supply kernel BSS size to the decompressor via a linker symbol.
 KBSS_SZ =3D $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmli=
nux | \
-		sed -n -e 's/^\([^ ]*\) B __bss_start$$/-0x\1/p' \
-		       -e 's/^\([^ ]*\) B __bss_stop$$/+0x\1/p') )) )
+		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
+		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux =3D --defsym _kernel_bss_size=3D$(KBSS_SZ)
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/4=PHvLC0GIfZzkMd5bMVCQB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrX2hsACgkQAVBC80lX
0GzYsQf/WTxeJVKQ5E/6ivajKOTbEb0YqdDNG2WIxHRkkTcQzR9129g3k7WYTzfV
atM0QnnJWhGFLxyHQyOVpph+9o+bjupmFPnf/xj5Ya0jCQCBVIP3DmAE2VBbAPBX
B6vv1C6IaxomJbbTiudxW7HwLFHjJcjbjIDXTn+z7F0c2qF/fylNviqXaixkeqAS
SY5pZcV0vOfZqCcUfXUOJdgkeDyOaFT0+fueAyx/9JvOeMG/92IFTjktHKstOTKy
ViI01hN1ngTTGUybzBAnCyhricYoM8axox2MSockoOImSAIiEY1wlZO5sYegIFZH
yZ4oybECkZySjsnFKEaKWTQxptnFcQ==
=6DMN
-----END PGP SIGNATURE-----

--Sig_/4=PHvLC0GIfZzkMd5bMVCQB--
