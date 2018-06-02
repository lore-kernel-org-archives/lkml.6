Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbeFBFEG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 01:04:06 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56874 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFBFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 01:04:03 -0400
Message-ID: <1527915842.7898.93.camel@surriel.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
From: Rik van Riel <riel@surriel.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
        songliubraving@fb.com, kernel-team <kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Date: Sat, 02 Jun 2018 01:04:02 -0400
In-Reply-To: <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
References: <20180601082811.4c0d33ba@imladris.surriel.com>
         <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
         <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
         <1527882207.7898.86.camel@surriel.com>
         <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
         <1527885324.7898.88.camel@surriel.com>
         <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
         <20180601181327.367f0fe3@imladris.surriel.com>
         <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-osH7tjSHFzs3PbWNZDY2"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-osH7tjSHFzs3PbWNZDY2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-06-01 at 20:35 -0700, Andy Lutomirski wrote:
> On Fri, Jun 1, 2018 at 3:13 PM Rik van Riel <riel@surriel.com> wrote:
> >=20
> > On Fri, 1 Jun 2018 14:21:58 -0700
> > Andy Lutomirski <luto@kernel.org> wrote:
> >=20
> > > Hmm.  I wonder if there's a more clever data structure than a
> > > bitmap
> > > that we could be using here.  Each CPU only ever needs to be in
> > > one
> > > mm's cpumask, and each cpu only ever changes its own state in the
> > > bitmask.  And writes are much less common than reads for most
> > > workloads.
> >=20
> > It would be easy enough to add an mm_struct pointer to the
> > per-cpu tlbstate struct, and iterate over those.
> >=20
> > However, that would be an orthogonal change to optimizing
> > lazy TLB mode.
> >=20
> > Does the (untested) patch below make sense as a potential
> > improvement to the lazy TLB heuristic?
> >=20
> > ---8<---
> > Subject: x86,tlb: workload dependent per CPU lazy TLB switch
> >=20
> > Lazy TLB mode is a tradeoff between flushing the TLB and touching
> > the mm_cpumask(&init_mm) at context switch time, versus potentially
> > incurring a remote TLB flush IPI while in lazy TLB mode.
> >=20
> > Whether this pays off is likely to be workload dependent more than
> > anything else. However, the current heuristic keys off hardware
> > type.
> >=20
> > This patch changes the lazy TLB mode heuristic to a dynamic, per-
> > CPU
> > decision, dependent on whether we recently received a remote TLB
> > shootdown while in lazy TLB mode.
> >=20
> > This is a very simple heuristic. When a CPU receives a remote TLB
> > shootdown IPI while in lazy TLB mode, a counter in the same cache
> > line is set to 16. Every time we skip lazy TLB mode, the counter
> > is decremented.
> >=20
> > While the counter is zero (no recent TLB flush IPIs), allow lazy
> > TLB mode.
>=20
> Hmm, cute.  That's not a bad idea at all.  It would be nice to get
> some kind of real benchmark on both PCID and !PCID.  If nothing else,
> I would expect the threshold (16 in your patch) to want to be lower
> on
> PCID systems.

That depends on how well we manage to get rid of
the cpumask manipulation overhead. On the PCID
system we first found this issue, the atomic
accesses to the mm_cpumask took about 4x as much
CPU time as the TLB invalidation itself.

That kinda limits how much the cost of cheaper
TLB flushes actually help :)

I agree this code should get some testing.

--=20
All Rights Reversed.
--=-osH7tjSHFzs3PbWNZDY2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlsSJUIACgkQznnekoTE
3oPs9Qf9GTxeuEPlhkaGZCo0O6TFKjP2rhlKbFECQbuutKEOv9Vm0d+mVXp51lyj
pESm8qFR0h3TPSL5Id4Xslz/+rnrN0rdLji4HSnDjE4OnVn2xv5qQNS9zjLXmf2E
0XSRK0uH39DcHVND/P4yita3FS4JtQI/p9y47aIhZ8B5ESb9uCtf7PW6qnlMA1yC
3eWY2kESwkbsL7fCrCuqcD9OgWlTbnpGDwhlSbrkNE30KreIl5bMXjaMK4+zTY4V
FT7agq7381bwKbrDhiDMVzdE9y/rBtAFpAJXbSZ5swtlsxDOgZcPrP23alL/ZqOj
nW+68EFTcag2DHL07v+oGMITrbPYVA==
=u5lR
-----END PGP SIGNATURE-----

--=-osH7tjSHFzs3PbWNZDY2--
