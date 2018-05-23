Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932516AbeEWKkn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:40:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37509 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbeEWKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:40:40 -0400
Date: Wed, 23 May 2018 12:40:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>
Subject: Re: [PATCH] vsprintf: Fix memory barriers of ptr_key to
 have_filed_random_ptr_key
Message-ID: <20180523104037.GD15312@amd>
References: <20180515100558.21df515e@gandalf.local.home>
 <CA+55aFyBHRmXLo07f_7qt7szaDvppMStfX5Sq9Df6mZSy+qYvA@mail.gmail.com>
 <20180515145744.3bdcbbe9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20180515145744.3bdcbbe9@gandalf.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-05-15 14:57:44, Steven Rostedt wrote:
> On Tue, 15 May 2018 09:55:13 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
> > On Tue, May 15, 2018 at 7:06 AM Steven Rostedt <rostedt@goodmis.org> wr=
ote:
> > > -       smp_mb();
> > > +       smp_wmb();
> > >          WRITE_ONCE(have_filled_random_ptr_key, true); =20
> >=20
> >=20
> > > +       /* Read ptr_key after reading have_filled_random_ptr_key */
> > > +       smp_rmb();
> > > +
> > >   #ifdef CONFIG_64BIT
> > >          hashval =3D (unsigned long)siphash_1u64((u64)ptr, &ptr_key);=
 =20
> >=20
> > Hmm. smp_wmb/rmb are basically free on x86, but on some architectures
> > smp_rmb() in particular can be pretty expensive.
> >=20
> > So when you have a "handoff" situation like this, it's _probably_ bette=
r to
> > use use "smp_store_release()" and "smp_load_acquire()". To some degree =
that
> > might also be better for documentation purposes, because that's exactly=
 the
> > "release-acquire" pattern.
> >=20
> > That said, I'm not convinced this really matters all that much for a
> > boot-time flag like this. The race is pretty theoretical.
> >
>=20
> I was thinking the same. But since the smp_mb() is there, then it
> should be correct, which it currently isn't.
>=20
> We could change this to a static key, and enable it after we set up
> the ptr_key. That would be a one time change at boot up, wont have
> races, and have no overhead.

OTOH... fixing theoretical races is nice, but probably should not go
to stable?
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsFRSUACgkQMOfwapXb+vJsCQCeKXyxrrMqeNo75baa1rmeRqGn
nzgAoKFndt91MU+qHxBXYUhubNrucZDo
=PEme
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
