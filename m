Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCYUQG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 16:16:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48004 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCYUQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 16:16:04 -0400
Message-ID: <1522008952.6308.46.camel@surriel.com>
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
Date: Sun, 25 Mar 2018 16:15:52 -0400
In-Reply-To: <4731938.EeADOapqQb@aspire.rjw.lan>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>
         <1521736343.6308.25.camel@surriel.com> <4731938.EeADOapqQb@aspire.rjw.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-e8yLbs0aoH4SrxOskwwl"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e8yLbs0aoH4SrxOskwwl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
>=20
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

OK, I am still seeing a performance
degradation with the above, though
not throughout the entire workload.

It appears that making the idle loop
do anything besides cpu_relax() for
a significant amount of time slows
things down.

I plan to try two more things:

1) Disable polling on SMT systems, with
   the idea that putting one thread to
   sleep with monitor/mwait in C1 will
   allow the other thread to run faster.

2) Insert more cpu_relax() calls into the
   main loop, so the CPU core spends more
   of its time in cpu_relax() and less
   time doing other things:

static int __cpuidle poll_idle(struct cpuidle_device *dev,
             struct cpuidle_driver *drv, int index)
{
  u64 time_start =3D local_clock();

  local_irq_enable();
  if (!current_set_polling_and_test()) {
    unsigned int loop_count =3D 0;

    while (!need_resched()) {
      cpu_relax();
      cpu_relax();
      cpu_relax();
      cpu_relax();
      cpu_relax();
      cpu_relax();
      cpu_relax();
      cpu_relax();
      if (loop_count++ < POLL_IDLE_COUNT)
        continue;

      loop_count =3D 0;
      if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
        break;
    }
  }
  current_clr_polling();
                                        =20
  return index;
}

I will let you know how they perform.

--=20
All Rights Reversed.
--=-e8yLbs0aoH4SrxOskwwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlq4A3gACgkQznnekoTE
3oNTZAf8Cfx2k97upi2SLJvjdg7oB4MfiCCpT0BzHvIDkfZul6cSxH5sS4D5TulC
rqdTbMmlqAqe2pR9e0SgpHDK84vkljXopW9zuSpTYhLV+djUrZV6bxy3IyRqvLgM
XkK2qJtrOV6RfKn3OurkRdGDHwLdkAPhhLDQ2pOdUGURuq6MUGw5WG3mZo1AxemH
SluRXfOBEuE1E2gpu+ZbtrsWjZZNoWRy+gpe09CAKTNLgWzhz6ICeW4xPCTtAilD
9AIBJdmS88YGvIm7rTiEL3MZ1Kmryu+8MuscN+c3R0X4boAVxSvEaIq1CVIv24GE
J6MsAI09xT/ZkBpXOHvCgrq+y1jZ4w==
=EGoc
-----END PGP SIGNATURE-----

--=-e8yLbs0aoH4SrxOskwwl--
