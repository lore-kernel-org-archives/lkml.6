Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeCPIQb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:16:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34333 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbeCPIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:16:26 -0400
X-Google-Smtp-Source: AG47ELtW+fckTiiVnvbOG9uEFQaX03rSaZlQQFlX69rc9DVW32Po0BuX+ea3couKKMlKMFMg7NMdnw==
X-ME-Sender: <xms:V32rWrkp-FVF1I-LmicmneQmixw4BRqPrYwoJmNBypRvRbcj7QaSpw>
Date: Fri, 16 Mar 2018 16:20:09 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 07/17] lockdep: Adjust
 check_redundant() for recursive read change
Message-ID: <20180316082009.r5rlfkedhnn3l7pa@tardis>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-8-boqun.feng@gmail.com>
 <20180222172906.GU25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wvwhhwjklbkuqla2"
Content-Disposition: inline
In-Reply-To: <20180222172906.GU25201@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wvwhhwjklbkuqla2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 06:29:06PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 22, 2018 at 03:08:54PM +0800, Boqun Feng wrote:
> > As we have four kinds of dependencies now, check_redundant() should only
> > report redundant if we have a dependency path which is equal or
> > _stronger_ than the current dependency. For example if in
> > check_prev_add() we have:
> >=20
> > 	prev->read =3D=3D 2 && next->read !=3D 2
> >=20
> > , we should only report redundant if we find a path like:
> >=20
> > 	prev--(RN)-->....--(*N)-->next
> >=20
> > and if we have:
> >=20
> > 	prev->read =3D=3D 2 && next->read =3D=3D 2
> >=20
> > , we could report redundant if we find a path like:
> >=20
> > 	prev--(RN)-->....--(*N)-->next
> >=20
> > or
> >=20
> > 	prev--(RN)-->....--(*R)-->next
> >=20
> > To do so, we need to pass the recursive-read status of @next into
> > check_redundant().
>=20
> Very hard to read that.
>=20

Right.. and I find a bug about this, let me explain below..

> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index e1be088a34c4..0b0ad3db78b4 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -1338,9 +1338,12 @@ print_circular_bug_header(struct lock_list *entr=
y, unsigned int depth,
> >  	return 0;
> >  }
> > =20
> > -static inline int class_equal(struct lock_list *entry, void *data)
> > +static inline int hlock_equal(struct lock_list *entry, void *data)
> >  {
> > -	return entry->class =3D=3D data;
> > +	struct held_lock *hlock =3D (struct held_lock *)data;
> > +
> > +	return hlock_class(hlock) =3D=3D entry->class &&
> > +	       (hlock->read =3D=3D 2 || !entry->is_rr);
> >  }
>=20
> So I guess @data =3D @next, and we're checking if @prev -> @next already
> exists.
>=20
> Since we only care about forward dependencies, @next->read=3D=3D2 means *R
> and if so, any existing link is equal or stronger. If @next->read!=3D2, it
> means *N and we must regard *R as weaker and not match.
>=20

Yep, the idea if we find a path @prev -> .. -> @next is RN, and @prev ->
@next is RR, then we treat RR as weaker and redundant. Basically, if we
find a strong path that could replace the about-to-add dependency
(the path is stronger than or equal to the dependency), we report
redundant (a match).

But I miss something here, as you may see both the start and end of the
path are important, so say we find a strong path RN, but the
about-to-add dependency is NR, we can not report it as redundant,
because the path can not replace the dependency.

To make sure we find a path whose start point is stronger than @prev, we
need a trick, we should initialize the ->only_xr (or ->have_xr) of the
root (start point) of __bfs() to be @prev->read !=3D 2, therefore if @prev
is N, __bfs() will pick N* for the first dependency, otherwise, __bfs()
can pick N* or R* for the first dependency.

I use a similar setup before check_noncircular(), which sets the initial
->only_xr to be @next->read =3D=3D 2, because we need @prev -> @next ->
<path> to be strong. But I should use a opposite setup for
check_redundant() as I describe above.

Anyway, I will fix this and prove (hopefully) enough comments for those
tricks.

Regards,
Boqun

> OK, that seems to be fine, but again, that function _really_ could do
> with a comment.
>=20
>=20

--wvwhhwjklbkuqla2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlqrfjQACgkQSXnow7UH
+rj5GwgAnivUInCIqkBuvYmMhl+kVccOjcp8ymSS1NH2FKQ0UQCjJWDezNU3yzJi
gCx7VewXHsSl/rDeMh9eUu1Ikkz9KyeyywZyHTCOuJzYJXDflkGey7K4sJ2bm9SY
P8fjsuCBz45oSy4WXlplxn89vVOR1Etktyr+uvjE4i5uC5JE957fT44dROj5iUzm
f5PJmD3bVxVXv6/r8bpytjWi3Qc1XeZaVOWSKXxUnhRjY8MQ/s4GGhJnQKc3OsGw
us3uoJcD5ndTl3V+xS3XiHVRvB7KFzahkjHkn8LamTio/lskQr7dEo7daMu9H+7l
YOP2yYeTKRxC8h2ieynQdRIRb7V46g==
=bOpP
-----END PGP SIGNATURE-----

--wvwhhwjklbkuqla2--
