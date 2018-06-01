Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeFATnc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:43:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45108 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbeFATnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:43:31 -0400
Message-ID: <1527882207.7898.86.camel@surriel.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Rik van Riel <riel@surriel.com>
To: Mike Galbraith <efault@gmx.de>, Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date: Fri, 01 Jun 2018 15:43:27 -0400
In-Reply-To: <1527878882.4448.11.camel@gmx.de>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
         <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tG/UWhCWVHmIem3ZGXtD"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tG/UWhCWVHmIem3ZGXtD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-01 at 20:48 +0200, Mike Galbraith wrote:
> On Fri, 2018-06-01 at 14:22 -0400, Rik van Riel wrote:
> > On Fri, 2018-06-01 at 08:11 -0700, Andy Lutomirski wrote:
> > > On Fri, Jun 1, 2018 at 5:28 AM Rik van Riel <riel@surriel.com>
> > > wrote:
> > > >=20
> > > > Song noticed switch_mm_irqs_off taking a lot of CPU time in
> > > > recent
> > > > kernels,using 2.4% of a 48 CPU system during a netperf to
> > > > localhost
> > > > run.
> > > > Digging into the profile, we noticed that cpumask_clear_cpu and
> > > > cpumask_set_cpu together take about half of the CPU time taken
> > > > by
> > > > switch_mm_irqs_off.
> > > >=20
> > > > However, the CPUs running netperf end up switching back and
> > > > forth
> > > > between netperf and the idle task, which does not require
> > > > changes
> > > > to the mm_cpumask. Furthermore, the init_mm cpumask ends up
> > > > being
> > > > the most heavily contended one in the system.`
> > > >=20
> > > > Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
> > > > (mostly the idle task) reduced CPU use of switch_mm_irqs_off
> > > > from 2.4% of the CPU to 1.9% of the CPU, with the following
> > > > netperf commandline:
> > >=20
> > > I'm conceptually fine with this change.  Does
> > > mm_cpumask(&init_mm)
> > > end
> > > up in a deterministic state?
> >=20
> > Given that we do not touch mm_cpumask(&init_mm)
> > any more, and that bitmask never appears to be
> > used for things like tlb shootdowns (kernel TLB
> > shootdowns simply go to everybody), I suspect
> > it ends up in whatever state it is initialized
> > to on startup.
> >=20
> > I had not looked into this much, because it does
> > not appear to be used for anything.
> >=20
> > > Mike, depending on exactly what's going on with your benchmark,
> > > this
> > > might help recover a bit of your performance, too.
> >=20
> > It will be interesting to know how this change
> > impacts others.
>=20
> previous pipe-test numbers
> 4.13.16         2.024978 usecs/loop -- avg 2.045250 977.9 KHz
> 4.14.47         2.234518 usecs/loop -- avg 2.227716 897.8 KHz
> 4.15.18         2.287815 usecs/loop -- avg 2.295858 871.1 KHz
> 4.16.13         2.286036 usecs/loop -- avg 2.279057 877.6 KHz
> 4.17.0.g88a8676 2.288231 usecs/loop -- avg 2.288917 873.8 KHz
>=20
> new numbers
> 4.17.0.g0512e01 2.268629 usecs/loop -- avg 2.269493 881.3 KHz
> 4.17.0.g0512e01 2.035401 usecs/loop -- avg 2.038341 981.2 KHz +andy
> 4.17.0.g0512e01 2.238701 usecs/loop -- avg 2.231828 896.1 KHz
> -andy+rik
>=20
> There might be something there with your change Rik, but it's small
> enough to be wary of variance.  Andy's "invert the return of
> tlb_defer_switch_to_init_mm()" is OTOH pretty clear.

If inverting the return value of that function helps
some systems, chances are the other value might help
other systems.

That makes you wonder whether it might make sense
to always switch to lazy TLB mode, and only call
switch_mm at TLB flush time, regardless of whether
the CPU supports PCID...

--=20
All Rights Reversed.
--=-tG/UWhCWVHmIem3ZGXtD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsRod8ACgkQznnekoTE
3oP1EQf/XuXPXE8my67vZzEP0gIrym48d6NH+c1FJ7ke42Ct0z2SSysfh78S3N+H
itvjBJDxMJc6t6HNLxtklRRzUEe/mk1amtBjqdztfRWUUa35BQQRpv3CPM2DeB7l
jTNrspt+nCm+9aup0T/jZpt51F+WXcnJRiYWGCRqr8cHQfN0kMxAWkfZEUfwq8Mi
jwmBHneNbc+GmWgj/NDuXNm36o2riFAX9L2bp81Sh2k3omq/M/xZgiZFwv9uljCf
oRNxHIOasYUIJrnjYMXGqueqzFo9rXy4iylu6cRmG+zVgClKOvCYeOtCachUkui8
5LalQYqtJ9LJL4eN7x9I2wb2gSuA2w==
=CrZ+
-----END PGP SIGNATURE-----

--=-tG/UWhCWVHmIem3ZGXtD--
