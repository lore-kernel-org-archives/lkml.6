Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166950AbeBOSuL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:50:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52834 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162126AbeBOPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:21:40 -0500
Date: Thu, 15 Feb 2018 16:21:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
Message-ID: <20180215152139.GA23145@amd>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
 <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-02-13 09:02:25, Paolo Bonzini wrote:
> On 12/02/2018 16:27, David Woodhouse wrote:
> > The original IBRS hack in microcode is horribly slow. For the next
> > generation of CPUs, as a stopgap until we get a proper fix, Intel
> > promise an "Enhanced IBRS" which will be fast.
> >=20
> > The assumption is that predictions in the BTB/RSB will be tagged with
> > the VMX mode and ring that they were learned in, and thus the CPU will
> > avoid consuming unsafe predictions without a performance penalty.
> >=20
> > Intel's documentation says that it is still required to set the IBRS bit
> > in the SPEC_CTRL MSR and ensure that it remains set.
> >=20
> > Cope with this by trapping and emulating *all* access to SPEC_CTRL from
> > KVM guests when the IBRS_ALL feature is present, so it can never be
> > turned off. Guests who see IBRS_ALL should never do anything except
> > turn it on at boot anyway. And if they didn't know about IBRS_ALL and
> > they keep frobbing IBRS on every kernel entry/exit... well the vmexit
> > for a no-op is probably going to be faster than they were expecting
> > anyway, so they'll live.
> >=20
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Acked-by: Arjan van de Ven <arjan.van.de.ven@intel.com>
> > ---
> >  arch/x86/include/asm/nospec-branch.h |  9 ++++++++-
> >  arch/x86/kernel/cpu/bugs.c           | 16 ++++++++++++++--
> >  arch/x86/kvm/vmx.c                   | 17 ++++++++++-------
> >  3 files changed, 32 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/as=
m/nospec-branch.h
> > index 788c4da..524bb86 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -140,9 +140,16 @@ enum spectre_v2_mitigation {
> >  	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
> >  	SPECTRE_V2_RETPOLINE_GENERIC,
> >  	SPECTRE_V2_RETPOLINE_AMD,
> > -	SPECTRE_V2_IBRS,
> > +	SPECTRE_V2_IBRS_ALL,
> >  };
> > =20
> > +extern enum spectre_v2_mitigation spectre_v2_enabled;
> > +
> > +static inline bool spectre_v2_ibrs_all(void)
> > +{
> > +	return spectre_v2_enabled =3D=3D SPECTRE_V2_IBRS_ALL;
> > +}
> > +
> >  extern char __indirect_thunk_start[];
> >  extern char __indirect_thunk_end[];
> > =20
> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > index debcdda..047538a 100644
> > --- a/arch/x86/kernel/cpu/bugs.c
> > +++ b/arch/x86/kernel/cpu/bugs.c
> > @@ -88,12 +88,13 @@ static const char *spectre_v2_strings[] =3D {
> >  	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	=3D "Vulnerable: Minimal AMD ASM r=
etpoline",
> >  	[SPECTRE_V2_RETPOLINE_GENERIC]		=3D "Mitigation: Full generic retpoli=
ne",
> >  	[SPECTRE_V2_RETPOLINE_AMD]		=3D "Mitigation: Full AMD retpoline",
> > +	[SPECTRE_V2_IBRS_ALL]			=3D "Mitigation: Enhanced IBRS",
> >  };

Hmm. Probably not just your problem but these should really get
documentation somewhere -- and adding another one should be treated
like changing the ABI.

How is poor userland expected to do anything inteligent with that
file?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqFpYMACgkQMOfwapXb+vKxnACfZXWBOKiOPMD8FGNAxIUlT46p
xBgAnRZMYyDH18Yd+od9Krz84LYjXjfx
=8gfT
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
