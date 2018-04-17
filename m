Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDQXJ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeDQXJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:09:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14588217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Wed, 18 Apr 2018 00:09:21 +0100
From: James Hogan <jhogan@kernel.org>
To: Matt Redfearn <matt.redfearn@mips.com>
Cc: Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v6 3/4] MIPS: vmlinuz: Use generic ashldi3
Message-ID: <20180417230921.GA29046@saruman>
References: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
 <1523433019-17419-3-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <1523433019-17419-3-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 08:50:18AM +0100, Matt Redfearn wrote:
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compress=
ed/Makefile
> index adce180f3ee4..e03f522c33ac 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -46,9 +46,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_=
printk.c
> =20
>  vmlinuzobjs-$(CONFIG_KERNEL_XZ) +=3D $(obj)/ashldi3.o $(obj)/bswapsi.o
> =20
> -extra-y +=3D ashldi3.c bswapsi.c
> -$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS +=3D -I$(srctree)/arch/=
mips/lib
> -$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/=
%.c
> +extra-y +=3D ashldi3.c
> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
> +	$(call cmd,shipped)
> +
> +extra-y +=3D bswapsi.c
> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>  	$(call cmd,shipped)

ci20_defconfig:

arch/mips/boot/compressed/ashldi3.c:4:10: fatal error: libgcc.h: No such fi=
le or directory
 #include "libgcc.h"
           ^~~~~~~~~~

It looks like it had already copied ashldi3.c from arch/mips/lib/ when
building an older commit, and it hasn't been regenerated from lib/ since
the Makefile changed, so its still using the old version.

I think it should be using FORCE and if_changed like this:

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed=
/Makefile
index e03f522c33ac..abe77add8789 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -47,12 +47,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_p=
rintk.c
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) +=3D $(obj)/ashldi3.o $(obj)/bswapsi.o
=20
 extra-y +=3D ashldi3.c
-$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
-	$(call cmd,shipped)
+$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c FORCE
+	$(call if_changed,shipped)
=20
 extra-y +=3D bswapsi.c
-$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
-	$(call cmd,shipped)
+$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c FORCE
+	$(call if_changed,shipped)
=20
 targets :=3D $(notdir $(vmlinuzobjs-y))
=20
That resolves the build failures when checking out old -> new without
cleaning, since the .ashldi3.c.cmd is missing so it gets rebuilt.

It should also resolve issues if the path it copies from is updated in
future since the .ashldi3.c.cmd will get updated.

If you checkout new -> old without cleaning, the now removed
arch/mips/lib/ashldi3.c will get added which will trigger regeneration,
so it won't error.

However if you do new -> old -> new then the .ashldi3.cmd file isn't
updated while at old, so you get the same error as above. I'm not sure
there's much we can practically do about that, aside perhaps avoiding
the issue in future by somehow auto-deleting stale .*.cmd files.

Cc'ing kbuild folk in case they have any bright ideas.

At least the straightforward old->new upgrade will work with the above
fixup though. If you're okay with it I'm happy to apply as a fixup.

Cheers
James

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrWfqAACgkQbAtpk944
dnoDNBAAiLDAByhKyodGxTvmswaP+ef8q2hYzGxvjWKYS+U9bXYqvuDIys6iBPYZ
q/Srcq3q7rV5LeGpMmHcIHjlmcbVg1y5aK7PipGQWiEhiKExzYmgYWlmugLT6Ra9
lHrJz91FXzunw5hFW7kF2v87JNB2A+pI/e+/060tU6mzFNGAOsGWiDcf2j41tK57
jqDZUdAd4XWsFZOU+DJRxXI7j2N8LUkwlWL4NmVmq7G5pa+ntodH6MhC19vFPfzL
gFriqcg6T+cbi/wh9r9Mxe1XNI4ybrakIqXUf+x4TctM7eu4ZOpXVEWhsh6Z07DC
XT3+/gR1fv/myTbsvp4H9EgOK5qxCGD36kMaahnZ215n+Cwng++5nPmJbrPTNK0n
udBdYT4S5GM0RaBCbDLiegBVEPlAW3Npj+ZtiGNKKDCIXfr9DWXCgS6BBgQVP70x
o3tGrp4kcBt1B/2Qk8K9RnB69IrtZyzcpL0wWLobaNhvXc65jbZ54KkRcI5c4D/J
ZeePCg8k439wQqzLmEAW3pUeF/OBgnFHxj2lxUUq9OJCJuVVvDJXsOV/wnttIayn
44oMfGn6DpBwqChvYw2DloAnLvByBaCX1i+0C63h1ExnXT6bbZlLDQhJJ0gVPlNk
gz16P609lcrr3p6AO3HekMmVkhsPyfkMq7iIivefgWhYzog6UIE=
=nbi6
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
