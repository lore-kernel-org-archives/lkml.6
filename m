Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeDKE7R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:59:17 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:41483 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeDKE7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:59:15 -0400
Date: Wed, 11 Apr 2018 06:59:03 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: Re: [Letux-kernel] [Bug]: mtd: onenand: omap2plus: kernel panic
 with OneNAND on OMAP3 (DM3730) device GTA04A5
Message-ID: <20180411065836.7e1bfc3f@aktux>
In-Reply-To: <20180410205643.GA2228@lenoch>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
        <20180410205643.GA2228@lenoch>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5/Hyp0xJawrtJEQyjiJt3nz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5/Hyp0xJawrtJEQyjiJt3nz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ladis,

On Tue, 10 Apr 2018 22:56:43 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> Hi Nikolaus,
>=20
> On Tue, Apr 10, 2018 at 06:25:17PM +0200, H. Nikolaus Schaller wrote:
> > Hi,
> > we just started testing the v4.16 kernel and found the
> > device no longer bootable (works with v4.15). It turned
> > out that there was a harmful modification somewhere between
> > v4.15.0 and v4.16-rc1.
> >=20
> > A git bisect points to this patch: =20
>=20
> Well, that's a shame... However, this code is in production for several
> months now, so could you, please put 'goto out_copy' if 'buf >=3D high_me=
mory'
> condition is met, ie:
> --- a/drivers/mtd/nand/onenand/omap2.c
> +++ b/drivers/mtd/nand/onenand/omap2.c
> @@ -392,6 +392,7 @@ static int omap2_onenand_read_bufferram(struct mtd_in=
fo *mtd, int area,
>  	if (buf >=3D high_memory) {
>  		struct page *p1;
> =20
> +		goto out_copy;
>  		if (((size_t)buf & PAGE_MASK) !=3D
>  		    ((size_t)(buf + count - 1) & PAGE_MASK))
>  			goto out_copy;

I had the same problem here, and that snippet  helps here. ubiattach
-p /dev/mtdX does not cause kernel oopses here anymore


Regards,
Andreas

--Sig_/5/Hyp0xJawrtJEQyjiJt3nz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlrNlhcACgkQfb1qx03i
kySL/w//QiGPNQLszeJGusKmtI7IAp4H+p1r/EqOfLuJU6cvfaJsax8iQSl5xozx
4vaM+Qo0MlDOjEqZKa72nmeADXge31twaQdxiZRzet0btDCk70oTP4QkT2D2TaAi
T/LqwkTI5sgE+e2AkXa6oVtOC70rZ6U26+MmOEDMAx+BfCshlz/4cNkJVyq60HEn
Qx6D82B+rES49Jf5uEqyQ9M883dqj4p61Pp04wc4pMMYt3X268cv8BZVeu6hlWEu
sQq8GR0sP/bpW3UmkUza1YdgZ8nztFFMg7YafmiFhAgJm1WDy8gKr+/dz4O7wT5c
vmKvaGVIxSDvgqffhIuJ85pOC/JlaerfIgfSDUa70x3jEDrAB29qOKgsW49Q0aIY
l7jM6AJ4MrzRH1LX0ran1DZCkD71OoMxeUK9gUD1kGoMJFPsYszRBJM9cDQxSsxi
JevwtQTFYu1jFiIA7Baa4ZiOiOSEpimWc3wcFTKe0H2CPjW0yNqurX56mbkx6iOV
7ikFLCUmbKHqqSwNHcCNFUZByRi7Hg25rsaySbj60aC7WBGvm2mPK/6KZJSCkIqO
UDxRj2yUGx3NMelXdvAjZF4D83lOK9nOJqAbMzBgTHpLirF9s8+mjtSYzAvUPyVc
DoM11WKKJB8/jJE0XD6H2hHAqDp011ELKTvg6oJUVpQlKUwq9YM=
=0Dl9
-----END PGP SIGNATURE-----

--Sig_/5/Hyp0xJawrtJEQyjiJt3nz--
