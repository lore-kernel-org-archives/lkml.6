Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeDVUwO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:52:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45747 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeDVUwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:52:10 -0400
Date: Sun, 22 Apr 2018 22:52:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: How to disable Linux =?utf-8?Q?kernel_?=
 =?utf-8?Q?self-extraction_=28KERNEL=5FGZIP=2C_KERNEL=5FBZIP2=2C_=E2=80=A6?=
 =?utf-8?B?KT8=?=
Message-ID: <20180422205208.GA8672@amd>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
 <20180422102033.GB26243@amd>
 <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>I try to decrease boot time, and my system has an SSD and enough space,=
 so
> >>loading 18 instead of 12 MB doesn=E2=80=99t make a difference, but the
> >>self-extraction is noticeable. So, I like to disable it.
> >
> >How long does GZIP extraction take on your hardware?
>=20
> It=E2=80=99s hard to measure =E2=80=93 at least I didn=E2=80=99t find a w=
ay to do so =E2=80=93, but counting
> from the last GRUB message to the first message of Linux (with `quiet`
> removed from the the command line), it takes roughly *two* seconds.
>=20
> ```
> $ ls -l /boot/vmlinuz-4.15.0-3-686-pae
> -rw-r--r-- 1 root root  3987200 Apr 19 12:13 /boot/vmlinuz-4.15.0-3-686-p=
ae
> $ ls -lh /boot/vmlinuz-4.15.0-3-686-pae
> -rw-r--r-- 1 root root 3,9M Apr 19 12:13 /boot/vmlinuz-4.15.0-3-686-pae
> $ time scripts/extract-vmlinux vmlinuz-4.15.0-3-686-pae > bla.txt
>=20
> real    0m1,204s
> user    0m1,041s
> sys     0m0,245s
> ```

Interesting; looks like I have faster machine (thinkpad X220).

pavel@duo:/data/l/linux$ time scripts/extract-vmlinux /tmp/vmlinux.bin
> /tmp/delme
0.21user 0.15system 0.66 (0m0.660s) elapsed 56.36%CPU
pavel@duo:/data/l/linux$ ls -al /tmp/delme
-rw-r--r-- 1 pavel pavel 18275356 Apr 22 22:44 /tmp/delme
pavel@duo:/data/l/linux$ gzip /tmp/delme
pavel@duo:/data/l/linux$ time gzip -d /tmp/delme.gz
0.21user 0.02system 0.23 (0m0.232s) elapsed 100.03%CPU
pavel@duo:/data/l/linux$ gzip -1 /tmp/delme
pavel@duo:/data/l/linux$ time gzip -d /tmp/delme.gz
0.22user 0.03system 0.25 (0m0.257s) elapsed 100.11%CPU
pavel@duo:/data/l/linux$ time gzip -d /tmp/delme.gz

=2E.and it also looks like extract-kernel is significantly slower than
gzip -9, because it is not using all the CPU. Strange.

Interesting. I somehow assumed gzip -d would be faster than that on
modern machines.

So yes, looks like uncompressed kernel image may be good idea.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrc9fgACgkQMOfwapXb+vIQMACfWKL7S7CGpnJHs0CZePLCUqx1
XtQAoKIsOW38Rxqj0S7UFG5FBrEGHQux
=sfCt
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
