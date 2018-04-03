Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755297AbeDCIth (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:49:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51439 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755086AbeDCItf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:49:35 -0400
Date: Tue, 3 Apr 2018 10:49:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@ACULAB.COM>,
        "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>,
        "indranil@chelsio.com" <indranil@chelsio.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Fenghua Yu <fenghua.yu@intel.com>, Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [RFC PATCH 0/3] kernel: add support for 256-bit IO access
Message-ID: <20180403084932.GA3926@amd>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <7f0ddb3678814c7bab180714437795e0@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191557400.2010@nanos.tec.linutronix.de>
 <7f8d811e79284a78a763f4852984eb3f@AcuMS.aculab.com>
 <alpine.DEB.2.21.1803191625080.2010@nanos.tec.linutronix.de>
 <20180320082651.jmxvvii2xvmpyr2s@gmail.com>
 <alpine.DEB.2.21.1803200933320.6506@nanos.tec.linutronix.de>
 <20180320090802.qw4tqjmhy6yfd6sf@gmail.com>
 <alpine.DEB.2.21.1803201039460.6506@nanos.tec.linutronix.de>
 <20180320105427.bm4od7cpessbraag@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20180320105427.bm4od7cpessbraag@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > On Tue, 20 Mar 2018, Ingo Molnar wrote:
> > > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > >=20
> > > > > So I do think we could do more in this area to improve driver per=
formance, if the=20
> > > > > code is correct and if there's actual benchmarks that are showing=
 real benefits.
> > > >=20
> > > > If it's about hotpath performance I'm all for it, but the use case =
here is
> > > > a debug facility...
> > > >=20
> > > > And if we go down that road then we want a AVX based memcpy()
> > > > implementation which is runtime conditional on the feature bit(s) a=
nd
> > > > length dependent. Just slapping a readqq() at it and use it in a lo=
op does
> > > > not make any sense.
> > >=20
> > > Yeah, so generic memcpy() replacement is only feasible I think if the=
 most=20
> > > optimistic implementation is actually correct:
> > >=20
> > >  - if no preempt disable()/enable() is required
> > >=20
> > >  - if direct access to the AVX[2] registers does not disturb legacy F=
PU state in=20
> > >    any fashion
> > >=20
> > >  - if direct access to the AVX[2] registers cannot raise weird except=
ions or have
> > >    weird behavior if the FPU control word is modified to non-standard=
 values by=20
> > >    untrusted user-space
> > >=20
> > > If we have to touch the FPU tag or control words then it's probably o=
nly good for=20
> > > a specialized API.
> >=20
> > I did not mean to have a general memcpy replacement. Rather something l=
ike
> > magic_memcpy() which falls back to memcpy when AVX is not usable or the
> > length does not justify the AVX stuff at all.
>=20
> OK, fair enough.
>=20
> Note that a generic version might still be worth trying out, if and only =
if it's=20
> safe to access those vector registers directly: modern x86 CPUs will do t=
heir=20
> non-constant memcpy()s via the common memcpy_erms() function - which coul=
d in=20
> theory be an easy common point to be (cpufeatures-) patched to an AVX2 va=
riant, if=20
> size (and alignment, perhaps) is a multiple of 32 bytes or so.

How is AVX2 supposed to help the memcpy speed?

If the copy is small, constant overhead will dominate, and I don't
think AVX2 is going to be win there.

If the copy is big, well, the copy loop will likely run out of L1 and
maybe even out of L2, and at that point speed of the loop does not
matter because memory is slow...?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrDQBwACgkQMOfwapXb+vJC7wCdFJ9ASTxZjRfHbQWQbbXhKcJo
ADQAoIoi+qXwoXzoQ/BPF+rnCSbNrhT0
=Nuw2
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
