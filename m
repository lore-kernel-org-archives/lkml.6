Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935116AbeCENT0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:19:26 -0500
Received: from shelob.surriel.com ([96.67.55.147]:58122 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCENTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:19:22 -0500
Message-ID: <1520255955.6857.18.camel@surriel.com>
Subject: Re: [RFC/RFT][PATCH 6/7] sched: idle: Predict idle duration before
 stopping the tick
From: Rik van Riel <riel@surriel.com>
To: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Date: Mon, 05 Mar 2018 08:19:15 -0500
In-Reply-To: <20180305123552.GY25181@hirez.programming.kicks-ass.net>
References: <1657351.s4RTvEoqBQ@aspire.rjw.lan>
         <2048240.1dZKXsSxFh@aspire.rjw.lan>
         <20180305123552.GY25181@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0b09lUM/l59o8UkYIN1K"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0b09lUM/l59o8UkYIN1K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-03-05 at 13:35 +0100, Peter Zijlstra wrote:
> On Sun, Mar 04, 2018 at 11:28:56PM +0100, Rafael J. Wysocki wrote:
> > Index: linux-pm/kernel/sched/idle.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/kernel/sched/idle.c
> > +++ linux-pm/kernel/sched/idle.c
> > @@ -188,13 +188,14 @@ static void cpuidle_idle_call(void)
> >  	} else {
> >  		unsigned int duration_us;
> > =20
> > -		tick_nohz_idle_go_idle(true);
> > -		rcu_idle_enter();
> > -
> >  		/*
> >  		 * Ask the cpuidle framework to choose a
> > convenient idle state.
> >  		 */
> >  		next_state =3D cpuidle_select(drv, dev,
> > &duration_us);
> > +
> > +		tick_nohz_idle_go_idle(duration_us > USEC_PER_SEC
> > / HZ);
>=20
> (FWIW we have TICK_USEC for this)
>=20
> > +		rcu_idle_enter();
> > +
> >  		entered_state =3D call_cpuidle(drv, dev,
> > next_state);
> >  		/*
> >  		 * Give the governor an opportunity to reflect on
> > the outcome
>=20
> Also, I think that at this point you've introduced a problem; by not
> disabling the tick unconditionally, we'll have extra wakeups due to
> the
> (now still running) tick, which will bias the estimation, as per
> reflect(), downwards.
>=20
> We should effectively discard tick wakeups when we could have entered
> nohz but didn't, accumulating the idle period in reflect and only
> commit
> once we get a !tick wakeup.

How much of a problem would that actually be?

Don't all but the very deepest C-states have
target residencies that are orders of magnitude
smaller than the tick period?

In other words, if our sleeps end up getting
"cut short" to 600us, we will still select C6,
and it will not result in picking C3 by mistake.

This only seems to affect C7 states and deeper.

It may be worth fixing in the long run, but that
would require keeping track of whether anything
non-idle was done in-between two invocations of
do_idle(), and then checking that there.

That would include not just seeing whether there
have been any context switches on the CPU (easy?),
but also whether any non-timer interrupts were run.

--=20
All Rights Reversed.
--=-0b09lUM/l59o8UkYIN1K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqdQ9MACgkQznnekoTE
3oNafQf/Yt7n0V/5BZ4LJZJKtPO546aCYpBcCMq1D3Z0U49BJ7sjZtmAbd/ZQqe7
6AuIfQaYmUge3MhtFVHP/TOBj2Bna/dOgvyta+TbFqDH0YYvTqmwcj36NFf5/2uL
g70VLT6mjxztU5hpeW3KeXk5zr6KypoA2yZsMiH/+Jw4hdjp3KASuzZ+F9gImJNw
jNcWsBCo8JyPCP9lDtgAJ1V4E3JOcRrHxm6qfg+eaLcfwt0kQOzhuTOEc9a0ePDv
gSEJOZg4vWwTOhU+dDnWZD2nPnOBwj+zBho3QzTJSC8mTKjt51cDj6ixeLWqznYf
5m7EU49GMlsIAuICqrpBhlIjdX4iAA==
=9r5u
-----END PGP SIGNATURE-----

--=-0b09lUM/l59o8UkYIN1K--
