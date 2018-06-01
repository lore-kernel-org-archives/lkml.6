Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeFAUf2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 16:35:28 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51490 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeFAUf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 16:35:27 -0400
Message-ID: <1527885324.7898.88.camel@surriel.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Rik van Riel <riel@surriel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        songliubraving@fb.com, kernel-team <kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Date: Fri, 01 Jun 2018 16:35:24 -0400
In-Reply-To: <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
         <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
         <1527882207.7898.86.camel@surriel.com>
         <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GtiTV3AwJIHP4jCNxLU9"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GtiTV3AwJIHP4jCNxLU9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-01 at 13:03 -0700, Andy Lutomirski wrote:
> Mike, you never did say: do you have PCID on your CPU?  Also, what is
> your workload doing to cause so many switches back and forth between
> init_mm and a task.
>=20
> The point of the optimization is that switching to init_mm() should
> be
> fairly fast on a PCID system, whereas an IPI to do the deferred flush
> is very expensive regardless of PCID.=20

While I am sure that bit is true, Song and I
observed about 4x as much CPU use in the atomic
operations in cpumask_clear_cpu and cpumask_set_cpu
(inside switch_mm_irqs_off) as we saw CPU used
in the %cr3 reload itself.

Given how expensive those cpumask updates are,
lazy TLB mode might always be worth it, especially
on larger systems.

--=20
All Rights Reversed.
--=-GtiTV3AwJIHP4jCNxLU9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsRrgwACgkQznnekoTE
3oPnRQf/ZjcriO3NRg9VYf7kzBxHbWxIB7AHs5cI44GdNJXmHQjgyZK94TXMrc3B
5IS24tcTR02uszMkNYLppAeRzPNyH989PC6qc2zUUALC2rgZo/XNnRl/zvqUKYwP
R2oSxsxByxGHH0uPnf16kEwQaOpR5EkM6NOvao3OMbG6FzWpz2jgcul8iuEFl+R2
aUnhiBYwJ7vxfarla/xWAlA7tK9rU92HleYxmmz/+YT+CUbFjZVlKdAXKvq0ckKp
nOtN18cldhgqwSwdGjP0EqSh3ogNam91EWmCSNJFjXXgC/3hI2k5GnQuLtU/7Um3
dEUDpIqoutqo/UJUUcszZfBVRlaxNA==
=5PkX
-----END PGP SIGNATURE-----

--=-GtiTV3AwJIHP4jCNxLU9--
