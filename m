Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D20DE605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeFFTAP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:00:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58334 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeFFTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:00:14 -0400
Message-ID: <1528311603.7898.136.camel@surriel.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Rik van Riel <riel@surriel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: songliubraving@fb.com, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date: Wed, 06 Jun 2018 15:00:03 -0400
In-Reply-To: <CALCETrU6bqVyBzeMu9RSoXq1Fm6rdHA6rDskqVqo5+W9snkz=A@mail.gmail.com>
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
         <1527989886.7898.96.camel@surriel.com>
         <CALCETrU6bqVyBzeMu9RSoXq1Fm6rdHA6rDskqVqo5+W9snkz=A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LCjf6p29+1YfR1ZTNNDP"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LCjf6p29+1YfR1ZTNNDP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-06-06 at 11:17 -0700, Andy Lutomirski wrote:
> On Sat, Jun 2, 2018 at 6:38 PM Rik van Riel <riel@surriel.com> wrote:
> >=20
> > On Sun, 2018-06-03 at 00:51 +0000, Song Liu wrote:
> >=20
> > > > Just to check: in the workload where you're seeing this
> > > > problem,
> > > > are
> > > > you using an mm with many threads?  I would imagine that, if
> > > > you
> > > > only
> > > > have one or two threads, the bit operations aren't so bad.
> > >=20
> > > Yes, we are running netperf/netserver with 300 threads. We don't
> > > see
> > > this much overhead in with real workload.
> >=20
> > We may not, but there are some crazy workloads out
> > there in the world. Think of some Java programs with
> > thousands of threads, causing a million context
> > switches a second on a large system.
> >=20
> > I like Andy's idea of having one cache line with
> > a cpumask per node. That seems like it will have
> > fewer downsides for tasks with fewer threads running
> > on giant systems.
> >=20
> > I'll throw out the code I was working on, and look
> > into implementing that :)
> >=20
>=20
> I'm not sure you should throw your patch out.  It's a decent idea,
> too.

Oh, I still have it saved, but the cpumask per
NUMA node looks like it could have a big impact,
with less guesswork or side effects.

--=20
All Rights Reversed.
--=-LCjf6p29+1YfR1ZTNNDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsYLzMACgkQznnekoTE
3oNszAf+NKgcWemfrvXn3Q2F0t/G3rsVK7GO0Vcb+yf2JBV+7T8T+o8g8IVHojg0
1ORWhCEUO341C9hkqIsdBG7tGmjX5rKGX+SP83rZkl+7pob3rZ+4UGxi3wsckWKW
VT7yFymPSEUdJch9NAg/L2elVVECkB002ONGJ0pk4NOrOYNezJAFrlC/CjpIKKjU
/VenPIQcHmSxnbvGYhBRUWfVPL/93gvT07bX5lVhZ1FB7GSKcwj698LjyHgjVBZb
S9andh4NWSP5i+9YIwHD9hgmuNtLXNlekDni11XdGJhsIUGRhxrbv9gEyDOk5frL
qnQ7D1LsfLekodhRmMxVcrGTKnkNQw==
=QEBU
-----END PGP SIGNATURE-----

--=-LCjf6p29+1YfR1ZTNNDP--
