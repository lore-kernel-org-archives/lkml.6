Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeCYVpb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 17:45:31 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49738 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeCYVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 17:45:30 -0400
Message-ID: <1522014313.6308.48.camel@surriel.com>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
From: Rik van Riel <riel@surriel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Date: Sun, 25 Mar 2018 17:45:13 -0400
In-Reply-To: <5810003.D8QGLjubHr@aspire.rjw.lan>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
         <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>
         <5810003.D8QGLjubHr@aspire.rjw.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZFMY3iDGLZraJ1sd1QWH"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZFMY3iDGLZraJ1sd1QWH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
> >=20
> > --=3D-e8yLbs0aoH4SrxOskwwl
> > Content-Type: text/plain; charset=3D"UTF-8"
> > Content-Transfer-Encoding: quoted-printable
> >=20
> > On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
> > > =3D20
> > > +++ linux-pm/drivers/cpuidle/poll_state.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/sched/idle.h>
> > > =3D20
> > >  #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
> > > +#define POLL_IDLE_COUNT		1000
> > > =3D20
> > >  static int __cpuidle poll_idle(struct cpuidle_device *dev,
> > >  			       struct cpuidle_driver *drv, int
> > > index)
> > > @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
> > > =3D20
> > >  	local_irq_enable();
> > >  	if (!current_set_polling_and_test()) {
> > > +		unsigned int loop_count =3D3D 0;
> > > +
> > >  		while (!need_resched()) {
> > >  			cpu_relax();
> > > +			if (loop_count++ < POLL_IDLE_COUNT)
> > > +				continue;
> > > =3D20
> > > +			loop_count =3D3D 0;
> > >  			if (local_clock() - time_start >
> > > POLL_IDLE_TIME_LIMIT)
> > >  				break;
> > >  		}
> >=20
> > OK, I am still seeing a performance
> > degradation with the above, though
> > not throughout the entire workload.
> >=20
> > It appears that making the idle loop
> > do anything besides cpu_relax() for
> > a significant amount of time slows
> > things down.
>=20
> I see.
>=20
> > I plan to try two more things:
> >=20
> > 1) Disable polling on SMT systems, with
> >    the idea that putting one thread to
> >    sleep with monitor/mwait in C1 will
> >    allow the other thread to run faster.
>=20
> Sounds plausible.
>=20
> > 2) Insert more cpu_relax() calls into the
> >    main loop, so the CPU core spends more
> >    of its time in cpu_relax() and less
> >    time doing other things:
>=20
> Well, maybe it's a matter of doing cpu_relax() between any other bits
> of
> significant computation in there:

That sounds like a plausible thing to try.
Let me kick off a test with that variant, too.

>  drivers/cpuidle/poll_state.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> Index: linux-pm/drivers/cpuidle/poll_state.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/poll_state.c
> +++ linux-pm/drivers/cpuidle/poll_state.c
> @@ -10,6 +10,7 @@
>  #include <linux/sched/idle.h>
> =20
>  #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
> +#define POLL_IDLE_COUNT		200
> =20
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int
> index)
> @@ -18,11 +19,21 @@ static int __cpuidle poll_idle(struct cp
> =20
>  	local_irq_enable();
>  	if (!current_set_polling_and_test()) {
> +		unsigned int loop_count =3D 0;
> +
>  		while (!need_resched()) {
>  			cpu_relax();
> -
> +			if (loop_count++ < POLL_IDLE_COUNT) {
> +				cpu_relax();
> +				continue;
> +			}
> +			cpu_relax();
> +			loop_count =3D 0;
> +			cpu_relax();
>  			if (local_clock() - time_start >
> POLL_IDLE_TIME_LIMIT)
>  				break;
> +
> +			cpu_relax();
>  		}
>  	}
>  	current_clr_polling();
>=20
>=20
--=20
All Rights Reversed.
--=-ZFMY3iDGLZraJ1sd1QWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq4GGkACgkQznnekoTE
3oNmewf+LKhvCL9xrdPdPmTkvQSLjU5nwhCRDhQF3lr/yyJKDRbiAhrtYoSG/le6
1yypmhl14aFDY4ZmdAkcn9AMxLC7EsjsG6wFoOEBIE4PsddlNu3v9xe9iSuEuFin
nL03fNGOLQK/9vDePAUK8kZN3eHKRX0MrNhhATVw7Ry162+ICyjRlmj6kW4V63Uk
TWaC9BXIv/W70TAdOn0pd8PcG+BOfDd/R8cmqZd5CgfxzzKFTP0/ynwropKbySDl
xe35FL+bTYtnc1zaSWXUvyW+CszDyevoigk0WpVMKOcLRDWC/6e8jaf38Z9fCWxp
NGufFwQKD78qD22Wv/ZsSiNmDYYsOg==
=2I7/
-----END PGP SIGNATURE-----

--=-ZFMY3iDGLZraJ1sd1QWH--
