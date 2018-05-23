Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934595AbeEWWDX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:03:23 -0400
Received: from shelob.surriel.com ([96.67.55.147]:54142 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934235AbeEWWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:03:21 -0400
Message-ID: <1527112995.7898.31.camel@surriel.com>
Subject: Re: [PATCH] bdi: Move cgroup bdi_writeback to a dedicated low
 concurrency workqueue
From: Rik van Riel <riel@surriel.com>
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Jan Kara <jack@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@fb.com
Date: Wed, 23 May 2018 18:03:15 -0400
In-Reply-To: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
References: <20180523175632.GO1718769@devbig577.frc2.facebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zn/EuV8ItMEpJ2BHvQB6"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zn/EuV8ItMEpJ2BHvQB6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-05-23 at 10:56 -0700, Tejun Heo wrote:

> The events leading to the lockup are...
>=20
> 1. A lot of cgwb_release_workfn() is queued at the same time and all
>    system_wq kworkers are assigned to execute them.
>=20
> 2. They all end up calling synchronize_rcu_expedited().  One of them
>    wins and tries to perform the expedited synchronization.
>=20
> 3. However, that invovles queueing rcu_exp_work to system_wq and
>    waiting for it.  Because #1 is holding all available kworkers on
>    system_wq, rcu_exp_work can't be executed.  cgwb_release_workfn()
>    is waiting for synchronize_rcu_expedited() which in turn is
> waiting
>    for cgwb_release_workfn() to free up some of the kworkers.
>=20
> We shouldn't be scheduling hundreds of cgwb_release_workfn() at the
> same time.  There's nothing to be gained from that.  This patch
> updates cgwb release path to use a dedicated percpu workqueue with
> @max_active of 1.

Dumb question.  Does setting max_active to 1 mean
that every cgwb_release_workfn() ends up forcing
another RCU grace period on the whole system, while
today you might have a bunch of them waiting on the
same RCU grace period advance?

Would it be faster to have some number (up to 16?)
push RCU once, at the same time, instead of having
each of them push RCU into a next grace period one
after another?

I may be overlooking something fundamental here,
but I thought I'd at least ask the question, just
in case :)

--=20
All Rights Reversed.
--=-zn/EuV8ItMEpJ2BHvQB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsF5SMACgkQznnekoTE
3oNNTAf/f24mYIPeDX8BSiV5F/tSrZWqKXEclKoYV35FC42keiipqk7VtpZcNcwF
WAYKk/HKq+mPUWMWKI0f5NOxHxVZW0ovAE9Lbb7GmH27XCyXdZzKlnR21qtB59dq
sVqllL2197MiHgbXM6yoTtGaAPrMbwApLKadujGrzpUn2i91FYbZrJHI/iz09Q/7
TX9jAOaselnaHKq0AJpm9slWM7oFCir/ANLahDAHagAMzk7jRp/n/LrVdpQkzBV6
2k7Z2BL3gxBcILzS6i3NURj4JTMq6tCg8jgWKgcTgesWjA2ba8CMmZek8J2bXaEf
SBgqcJ9RUi7rJQ9hUSzRtAPZna3ZnQ==
=CqVK
-----END PGP SIGNATURE-----

--=-zn/EuV8ItMEpJ2BHvQB6--
