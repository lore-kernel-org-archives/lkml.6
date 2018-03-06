Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeCFXS6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:18:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53664 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754150AbeCFXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:18:57 -0500
Date: Wed, 7 Mar 2018 00:18:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: LKML <linux-kernel@vger.kernel.org>, pageexec@freemail.hu
Subject: Re: C tricks for efficient stack zeroing
Message-ID: <20180306231856.GA28911@amd>
References: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <CAHmME9phM2+ZrdA8jGxOAVnQSvrcO94ekvcgCH4X1xD8Dndiuw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> do_something(u8 *output, const u8 *input)
>     thing1(...)
>     thing2(...)
>         thinga(...)
>         thingb(...)
>            thingi(...)
>         thingc(...)
>     thing3(...)
>     thing4(...)
>         thinga(...)
>         thingc(...)
>=20
> Each one of these functions have a few stack variables. The current
> solution is to call memzero_explicit() on each of those stack
> variables when each function return. But let's say that thingb uses as
> much or more stack as thinga. In this case, I'm wasting cycles (and
> gcc optimizations) by clearing the stack in both thinga and thingb,
> and I could probably get away with doing this in thingb only.
> Probably. But to hand estimate those seems a bit brittle.
>=20
> What would be really nice would be to somehow keep track of the
> maximum stack depth, and just before the function returns, clear from
> the maximum depth to its stack base, all in one single call. This
> would not only make the code faster and less brittle, but it would
> also clean up some algorithms quite a bit.
>=20
> Ideally this would take the form of a gcc attribute on the function,
> but I was unable to find anything of that nature. I started looking
> for little C tricks for this, and came up dry too. I realize I could

I'll probably not help you but...

Is it possible that code running _with_ zeroing would be actually
faster, performance-wise?

You know, after calling the crypto function, CPU has 2K of dirty data
in its caches. You really don't need that data to be written back to
DRAM, you'd prefer that data to be simply discarded.  (And it should
be easier to discard zeros than to discard non-zero data).

Now, I'm not saying common CPUs could take advantage of this, but I
believe at least belt machine did something similar in hw (
https://www.youtube.com/watch?v=3DQGw-cy0ylCc&list=3DPLx54dE17v2I2WG7tMybzh=
bJ81rTyJMJdU&index=3D2
)

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqfIeAACgkQMOfwapXb+vKzOACcCoxBJmNlXleQsSciL4A63llB
2mkAn1Vg2gYSZoygq10Tjtqd7q+NxJF5
=3ix7
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
