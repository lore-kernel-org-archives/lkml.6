Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeFCBiN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 21:38:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51404 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFCBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 21:38:11 -0400
Message-ID: <1527989886.7898.96.camel@surriel.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Rik van Riel <riel@surriel.com>
To: Song Liu <songliubraving@fb.com>, Andy Lutomirski <luto@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date: Sat, 02 Jun 2018 21:38:06 -0400
In-Reply-To: <A87157D6-4A0A-44F8-8AC8-4411F5EDC57A@fb.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
         <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
         <1527882207.7898.86.camel@surriel.com>
         <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
         <1527885324.7898.88.camel@surriel.com>
         <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
         <20180601181327.367f0fe3@imladris.surriel.com>
         <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
         <1527915842.7898.93.camel@surriel.com>
         <CALCETrW5m3Y3CGnRZwDTMT9g-1an_LO6Fp_6FWOokydhN9BDLQ@mail.gmail.com>
         <A87157D6-4A0A-44F8-8AC8-4411F5EDC57A@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-h3yk7JwEJZpzw9XdwCzk"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h3yk7JwEJZpzw9XdwCzk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-06-03 at 00:51 +0000, Song Liu wrote:

> > Just to check: in the workload where you're seeing this problem,
> > are
> > you using an mm with many threads?  I would imagine that, if you
> > only
> > have one or two threads, the bit operations aren't so bad.
>=20
> Yes, we are running netperf/netserver with 300 threads. We don't see
> this much overhead in with real workload.=20

We may not, but there are some crazy workloads out
there in the world. Think of some Java programs with
thousands of threads, causing a million context
switches a second on a large system.

I like Andy's idea of having one cache line with
a cpumask per node. That seems like it will have
fewer downsides for tasks with fewer threads running
on giant systems.

I'll throw out the code I was working on, and look
into implementing that :)

--=20
All Rights Reversed.
--=-h3yk7JwEJZpzw9XdwCzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsTRn4ACgkQznnekoTE
3oPaMQgAq5xPTacrYUKSsta96lHdwFuAwwbsm3sLmSAj88nkB2afKkUMV/GNpTY8
owFFxx6vpTsxFSiOSSlYhUS0LStpkDRZMAJkYO/zU1IZHlL5k9prnZ6EuldHepSO
6ayoeI1MgVqbE1dWSDUclmiMywDJHbRjIrDYn6h0h8jAu0p4wNS2StFv2c73gstm
V6eD6m3ZWPR8H6g0IdWX/owpC/rau85FHuhJ/GMzIOk6J2oDxuepIyAUNFV3BVZ/
XbIIK+mE5QE5gsK0HFKZNdwbFefcGDCK20EFjy/BJSMoCcuqDSlxLEyU4uGIS06g
Y90baRuPnHxUTQv74gIT0Q4d2EgORw==
=zqPx
-----END PGP SIGNATURE-----

--=-h3yk7JwEJZpzw9XdwCzk--
