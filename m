Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeCVRTV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:19:21 -0400
Received: from shelob.surriel.com ([96.67.55.147]:41698 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCVRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:19:19 -0400
Message-ID: <1521739156.6308.30.camel@surriel.com>
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
Date: Thu, 22 Mar 2018 13:19:16 -0400
In-Reply-To: <4731938.EeADOapqQb@aspire.rjw.lan>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
         <1521736343.6308.25.camel@surriel.com> <4731938.EeADOapqQb@aspire.rjw.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pwv/vi74uTWesiFR0EFi"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pwv/vi74uTWesiFR0EFi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
> On Thursday, March 22, 2018 5:32:23 PM CET Rik van Riel wrote:
> > On Wed, 2018-03-14 at 15:08 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
> > > If poll_idle() is allowed to spin until need_resched() returns
> > > 'true',
> > > it may actually spin for a much longer time than expected by the
> > > idle
> > > governor, since set_tsk_need_resched() is not always called by
> > > the
> > > timer interrupt handler.  If that happens, the CPU may spend much
> > > more time than anticipated in the "polling" state.
> > >=20
> > > To prevent that from happening, limit the time of the spinning
> > > loop
> > > in poll_idle().
> > >=20
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > So ... about bisecting that other patch series...
> >=20
> > It turned out I had this patch, which looks so
> > obviously correct, as patch #1 in my series.
> >=20
> > It also turned out that this patch is responsible
> > for the entire 5-10% increase in CPU use for the
> > memcache style workload.
> >=20
> > I wonder if keeping an idle HT thread much busier
> > than before slows down its sibling, or something
> > like that.
>=20
> Uhm, sorry about this.

No worries, this is why we do patch reviews and
tests in the first place.

> Does it improve if you do something like the below on top of it?

That was my next thing to try, after testing just
the idle nohz series by itself :)

I'll push both into the test systems, and will
get back to you when I have answers.

> > Let me go test the nohz idle series by itself,
> > without this patch.
>=20
> OK
>=20
> ---
>  drivers/cpuidle/poll_state.c |    6 ++++++
>  1 file changed, 6 insertions(+)
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
> +#define POLL_IDLE_COUNT		1000
> =20
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int
> index)
> @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
> =20
>  	local_irq_enable();
>  	if (!current_set_polling_and_test()) {
> +		unsigned int loop_count =3D 0;
> +
>  		while (!need_resched()) {
>  			cpu_relax();
> +			if (loop_count++ < POLL_IDLE_COUNT)
> +				continue;
> =20
> +			loop_count =3D 0;
>  			if (local_clock() - time_start >
> POLL_IDLE_TIME_LIMIT)
>  				break;
>  		}
>=20
>=20
--=20
All Rights Reversed.
--=-pwv/vi74uTWesiFR0EFi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlqz5ZQACgkQznnekoTE
3oNFrQf8DEyzSxGl81SSuqLvoqJNc8WPJ2t978eE5i3AAV/UBB9BOGx/xPSEfvaK
Ku35fcrwnu5qoskv6GgCYsr4fWBi5brmo8O3uWu/R6UWl08ORiXstIbz4zQ56ScK
vAyrL1fxIwfaLofe/ZHN7LqipEkME2BNukU1RfhPfiY2JnFWx08V8qTmdkOKQpSZ
E2yXXDkOqu7AFPo2HUQUIHgSO8Mn0tOjslrZhrnjYyg32EYhejS4pq4iDtl9KfEK
mdSqnQz9ACKNo21unqFSsVuaVrHc/0ZgVJDAhuRWmE6mmIRXfg7OQYOjmNVdnZFF
soUiGXi3Nsi7hEV+G2pEdu6aKBAcYQ==
=swy+
-----END PGP SIGNATURE-----

--=-pwv/vi74uTWesiFR0EFi--
