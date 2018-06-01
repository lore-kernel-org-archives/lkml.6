Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeFASWN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:22:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45004 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeFASWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:22:11 -0400
Message-ID: <1527877328.7898.80.camel@surriel.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Rik van Riel <riel@surriel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>
Date: Fri, 01 Jun 2018 14:22:08 -0400
In-Reply-To: <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-qgI/NAFv7Q15VQ0JKHkt"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qgI/NAFv7Q15VQ0JKHkt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-01 at 08:11 -0700, Andy Lutomirski wrote:
> On Fri, Jun 1, 2018 at 5:28 AM Rik van Riel <riel@surriel.com> wrote:
> >=20
> > Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
> > kernels,using 2.4% of a 48 CPU system during a netperf to localhost
> > run.
> > Digging into the profile, we noticed that cpumask_clear_cpu and
> > cpumask_set_cpu together take about half of the CPU time taken by
> > switch_mm_irqs_off.
> >=20
> > However, the CPUs running netperf end up switching back and forth
> > between netperf and the idle task, which does not require changes
> > to the mm_cpumask. Furthermore, the init_mm cpumask ends up being
> > the most heavily contended one in the system.`
> >=20
> > Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
> > (mostly the idle task) reduced CPU use of switch_mm_irqs_off
> > from 2.4% of the CPU to 1.9% of the CPU, with the following
> > netperf commandline:
>=20
> I'm conceptually fine with this change.  Does mm_cpumask(&init_mm)
> end
> up in a deterministic state?

Given that we do not touch mm_cpumask(&init_mm)
any more, and that bitmask never appears to be
used for things like tlb shootdowns (kernel TLB
shootdowns simply go to everybody), I suspect
it ends up in whatever state it is initialized
to on startup.

I had not looked into this much, because it does
not appear to be used for anything.

> Mike, depending on exactly what's going on with your benchmark, this
> might help recover a bit of your performance, too.

It will be interesting to know how this change
impacts others.

--=20
All Rights Reversed.
--=-qgI/NAFv7Q15VQ0JKHkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsRjtAACgkQznnekoTE
3oOkpgf/RK/ZIuHh+noFuTMpqf8dUsHWmMrhtHfwa1ZPaKyJFWJJTWvGgyno0Zh0
wYiNcvhi0Lxwfv5eVVbRHWmh4xxyCiFgzjT2NE/s1oKwVJ+M1+hPQVJEnRwmM9dt
a9zpYwhSvcqXoFRGMwfe4rVANxa6F62FXtOyNoqOENZ6rOuNgkXj2FJykWoq3ObL
cv0J2fxImryLACOt9bHesv8D38sPTj4ebcxBaR9jZRNFctY27g9G3TBLItQMfpCT
fo1X3ANN+HhytfN5zfzY2Gw2WDJuA2cvtXRD4Yqpm1NB4PzzTT7Bvr6p6x4ElgcJ
5u1agNfppwzDIRxO0V/1xtGfaWDbdQ==
=j6b+
-----END PGP SIGNATURE-----

--=-qgI/NAFv7Q15VQ0JKHkt--
