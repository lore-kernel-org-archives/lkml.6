Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeCLSCo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:02:44 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:51606 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932586AbeCLSCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:02:41 -0400
Date: Mon, 12 Mar 2018 19:02:23 +0100
From: Alban <albeu@free.fr>
To: James Hogan <james.hogan@imgtec.com>
Cc: Alban <albeu@free.fr>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, Jonas Gorski <jogo@openwrt.org>,
        <linux-kernel@vger.kernel.org>,
        Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: Re: [PATCH v2] MIPS: Allow compressed images to be loaded at any
 address
Message-ID: <20180312190223.1cf292dd@avionic-0020>
In-Reply-To: <20170213221945.GM24226@jhogan-linux.le.imgtec.org>
References: <1487018290-10451-1-git-send-email-albeu@free.fr>
        <20170213221945.GM24226@jhogan-linux.le.imgtec.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rRur1r7a.OjfrDLM_HnxiJ4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rRur1r7a.OjfrDLM_HnxiJ4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Feb 2017 22:19:45 +0000
James Hogan <james.hogan@imgtec.com> wrote:

> Hi Alban,
>=20
> On Mon, Feb 13, 2017 at 09:38:08PM +0100, Alban wrote:
> > From: Alban Bedel <albeu@free.fr>
> >=20
> > Compressed images (vmlinuz.bin) have to be loaded at a specific
> > address that differ from the address normaly used for vmlinux.bin.
> > This is because the decompressor just write its output at the address
> > vmlinux.bin should be loaded at, and it shouldn't overwrite itself.
> > This limitation mean that the bootloader must be configured differently
> > when loading a vmlinux.bin or a vmlinuz.bin image, this is annoying
> > and a source of error.
> >=20
> > To workaround this we extend the compressed loader to cope with being
> > loaded at (nearly) any address. During the early init a jump is used
> > to compute the offset between the current address and the linked
> > address, if they differ the whole image is first copied to the linked
> > address before proceeding.
> >=20
> > Some load address won't work, for example if there is an overlap with
> > the range where vmlinuz.bin should be loaded. However for the typical
> > case of using the vmlinux.bin address that won't be the case.
> >=20
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> > Changelog:
> > v2: * Rework the code as suggested by Jonas Gorski to autodetect the
> >       load address and remove the need for a Kconfig option.
> > ---
> >  arch/mips/boot/compressed/head.S | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compress=
ed/head.S
> > index 409cb48..3c25a96 100644
> > --- a/arch/mips/boot/compressed/head.S
> > +++ b/arch/mips/boot/compressed/head.S
> > @@ -25,6 +25,29 @@ start:
> >  	move	s2, a2
> >  	move	s3, a3
> > =20
> > +	/* Get the offset between the current address and linked address */
> > +	PTR_LA	t0, reloc_label
> > +	bal	reloc_label
> > +	 nop
> > +reloc_label:
> > +	subu	t0, ra, t0
> > +
> > +	/* If there is no offset no reloc is needed */
> > +	beqz	t0, clear_bss
> > +	 nop
> > +
> > +	/* Move the text, data section and DTB to the correct address */
> > +	PTR_LA	a0, .text
> > +	addu	a1, t0, a0
> > +	PTR_LA	a2, _edata
> > +copy_vmlinuz:
> > +	lw	a3, 0(a1)
> > +	sw	a3, 0(a0)
> > +	addiu	a0, a0, 4
> > +	bne	a2, a0, copy_vmlinuz
> > +	 addiu	a1, a1, 4 =20
>=20
> Does this need to sync the icache and resolve the instruction hazard
> before jumping into the newly written code?
>
> E.g. on mips32/64 r2 and later you could I think "synci" at SYNCI_Step
> intervals (as determined by RDHWR instruction), followed by a "sync" and
> then using "jr.hb" instead of "jr" to clear the instruction hazard while
> jumping to the newly written code.
>=20
> That is roughly what arch/mips/kernel/relocate.c and
> arch/mips/kernel/head.S do, but as mentioned that assumes MIPS32/64 r2+,
> and at least 2 platforms selecting SYS_SUPPORTS_ZBOOT* also select
> CPU_HAS_CPU_MIPS32_R1.

This was a long time ago but I still like to finish this. However I'm
not very really versed into this kind of very low level subjects, so
I would appreciate if somebody could tell me if the cache sync is needed
here or not. All I can says is that it currently work on ATH79 which is
a mips32 r2, but that doesn't mean it is correct.

Also note that no such cache sync is done on the decompressed kernel,
wouldn't that also be needed?

Alban

--Sig_/rRur1r7a.OjfrDLM_HnxiJ4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJapsCwAAoJEHSUmkuduC28+SkP/itrqe29bBYrz3LlWTvwKXwv
awy/uskMz9tEY4YyOUxYWVmN2dfXLNaCLy4zKLHNscn5Sptp6KXm42kcz0yjJ0Qf
EVh7K/HpIWZwKq5d/aX/xGgfmXpmgLbqFMIv52T4SokFdiVx7oy1QJe5Y0hR21nv
TTZi2vpkVZRuGi/wM+88wTIZB9caxfQMJ7a2nRMpuxBS1nAbtqWeRDv9kFnSJryu
htdwQFptL+079Q3FVzEMNTDCGD/sWXa8vEt+lZmje9H3c/lnALISZi71RJ2+irlL
OM/ppM3o7aLAsbY1+8XpqUnQ+vYbJ5zY8GMyOZHEpRP/t+T5WzhZ/hP2tkPaR99U
YUL0Vx5Jl8n6C5nQH/Nua/jP2yf4qy1HmG0KEVoSNhjYMmMgzbKnZOYGNXcAA9P6
Hy3bYbVaRd6U7Cc2haO6m+9MuufLwIr9O/48AMS6vTGMiz6ABSVA0MuN6f9A3EgV
0VDRKcZE2mAykBBbeHNOWcc7weufjoQenyr0FLwiVn2VOffii/LUQknQOx+9l3BT
ZAYRuX90JmNAxN/zc/H8MxcsE0BiDTU5LaFPY2ryEQEDfpbEIhJ0S7yuQ5H5Y69v
fpks1SW2ZNKZcRnddbgiIfMoYeeljd/WL58T1/OxKAaDNAX5n2Nrqxcc5kWq49Z3
mnD00q9K+VgNh7Of1St5
=nQly
-----END PGP SIGNATURE-----

--Sig_/rRur1r7a.OjfrDLM_HnxiJ4--
