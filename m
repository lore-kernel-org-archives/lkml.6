Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeEKI1H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:27:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34035 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750852AbeEKI1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:27:05 -0400
Date: Fri, 11 May 2018 10:26:53 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] arm64: arch_timer: Workaround for Allwinner A64
 timer instability
Message-ID: <20180511082653.qhfdjliofmelmtwp@flea>
References: <20180511022751.9096-1-samuel@sholland.org>
 <20180511022751.9096-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adgppgpa5h4wdngh"
Content-Disposition: inline
In-Reply-To: <20180511022751.9096-2-samuel@sholland.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adgppgpa5h4wdngh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2018 at 09:27:50PM -0500, Samuel Holland wrote:
> The Allwinner A64 SoC is known [1] to have an unstable architectural
> timer, which manifests itself most obviously in the time jumping forward
> a multiple of 95 years [2][3]. This coincides with 2^56 cycles at a
> timer frequency of 24 MHz, implying that the time went slightly backward
> (and this was interpreted by the kernel as it jumping forward and
> wrapping around past the epoch).
>=20
> Further investigation revealed instability in the low bits of CNTVCT at
> the point a high bit rolls over. This leads to power-of-two cycle
> forward and backward jumps. (Testing shows that forward jumps are about
> twice as likely as backward jumps.)
>=20
> Without trapping reads to CNTVCT, a userspace program is able to read it
> in a loop faster than it changes. A test program running on all 4 CPU
> cores that reported jumps larger than 100 ms was run for 13.6 hours and
> reported the following:
>=20
>  Count | Event
> -------+---------------------------
>   9940 | jumped backward      699ms
>    268 | jumped backward     1398ms
>      1 | jumped backward     2097ms
>  16020 | jumped forward       175ms
>   6443 | jumped forward       699ms
>   2976 | jumped forward      1398ms
>      9 | jumped forward    356516ms
>      9 | jumped forward    357215ms
>      4 | jumped forward    714430ms
>      1 | jumped forward   3578440ms
>=20
> This works out to a jump larger than 100 ms about every 5.5 seconds on
> each CPU core.
>=20
> The largest jump (almost an hour!) was the following sequence of reads:
>       0x0000007fffffffff =E2=86=92 0x00000093feffffff =E2=86=92 0x0000008=
000000000
>=20
> Note that the middle bits don't necessarily all read as all zeroes or
> all ones during the anomalous behavior; however the low 11 bits checked
> by the function in this patch have never been observed with any other
> value.
>=20
> Also note that smaller jumps are much more common, with the smallest
> backward jumps of 2048 cycles observed over 400 times per second on each
> core. (Of course, this is partially due to lower bits rolling over more
> frequently.) Any one of these could have caused the 95 year time skip.
>=20
> Similar anomalies were observed while reading CNTPCT (after patching the
> kernel to allow reads from userspace). However, the jumps are much less
> frequent, and only small jumps were observed. The same program as before
> (except now reading CNTPCT) observed after 72 hours:
>=20
>  Count | Event
> -------+---------------------------
>     17 | jumped backward      699ms
>     52 | jumped forward       175ms
>   2831 | jumped forward       699ms
>      5 | jumped forward      1398ms
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Because the CPU can read the CNTPCT/CNTVCT registers faster than they
> change, performing two reads of the register and comparing the high bits
> (like other workarounds) is not a workable solution. And because the
> timer can jump both forward and backward, no pair of reads can
> distinguish a good value from a bad one. The only way to guarantee a
> good value from consecutive reads would be to read _three_ times, and
> take the middle value iff the three values are 1) individually unique
> and 2) increasing. This takes at minimum 3 cycles (125 ns), or more if
> an anomaly is detected.
>=20
> However, since there is a distinct pattern to the bad values, we can
> optimize the common case (2046/2048 of the time) to a single read by
> simply ignoring values that match the pattern. This still takes no more
> than 3 cycles in the worst case, and requires much less code.

That's an awesome commit log, thanks!

For both patches:
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

> [1]: https://github.com/armbian/build/commit/a08cd6fe7ae9
> [2]: https://forum.armbian.com/topic/3458-a64-datetime-clock-issue/

Sigh. So armbian knew about this for more than a year and had a fix,
and didn't judge necessary to report it anywhere. That's some solid,
responsible, development right there...

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--adgppgpa5h4wdngh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr1U8wACgkQ0rTAlCFN
r3SzchAAk91YVuEtowCWOcBh9xw590KAzR87N7WlkBOEu0vh4P1wKSfnlGTNErV9
xaVltNt4BlnK3+Up/z5QhC/pLBNlDev7zmFBbGkmMCF/tux50CjqDdEAJRmgVpmv
0fdyykpOd1oUE9SYz9ekUdCzvmSSnYzqr5HZv6ar7arVX8CF+QYUsZEJ9K/SsjhJ
pXJQkHYo6zbpq/bMwvXWWEKIC11sWWdyJfAk+MfA/h+aEVc4RZ72C4C5glSjdofn
hIdGUFt4uYvvvy2r35FJlKjVHwavzYhxjeYxzaWCLpYuN8GQhk24ESBFtTJMHPjC
r/Cy3HjMkSlVCw2L/s0ViJOQTB/IB+vn7uKX0FT9izXJbm8i01gHatvAcBh3lFwz
Es5IB2OuLBY5G33sKLhEU3OAhv7qDyW/B2riBhYz1MCVnITJf+u07vLH+0h2MXGy
0fJrlqNilKz5OHT2LqsktZkFGmofdMGTxOVFnfp8guO7sfAyMacns1ne87sp6B/C
PFBCGyyEPPQFUBmOSDNis7GO7GYUE745KEpdGDlA+d2ZJmzL7TekXh/STbhuzHSa
iGW5CvB4tIAzeDEU5zS8vZ1F5ElJIwtLbsgU9+KxUd4+yEWM94/IHT0aLK+D7u1B
ttJIhkH6Dq8Nu+84R1SYCvArlV1oxd2uVb9el0idCE4hFRA/Hjk=
=BHZR
-----END PGP SIGNATURE-----

--adgppgpa5h4wdngh--
