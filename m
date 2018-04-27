Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeD0KZC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 06:25:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51552 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757810AbeD0KZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 06:25:00 -0400
X-Google-Smtp-Source: AB8JxZpRa1sYPcWR1uj9qBGFODEyIyQUU/lefhz3SZXqO1uwQfLGQk1qyPhOr0JOn3/i/WH+Rt6ziQ==
Date: Fri, 27 Apr 2018 12:24:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
Message-ID: <20180427102456.GA17137@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <675f74f82378b5f7d8f61d35e929614a0e156141.1523301400.git.digetx@gmail.com>
 <20180427093435.GB30388@ulmo>
 <882f14b8-78c8-95bb-326e-3917c9736faf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <882f14b8-78c8-95bb-326e-3917c9736faf@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 01:13:47PM +0300, Dmitry Osipenko wrote:
> On 27.04.2018 12:34, Thierry Reding wrote:
> > On Mon, Apr 09, 2018 at 10:28:31PM +0300, Dmitry Osipenko wrote:
> > [...]
> >> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> > [...]
> >> +#define MC_GART_ERROR_REQ		0x30
> >> +#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
> >> +#define MC_SECURITY_VIOLATION_STATUS	0x74
> > [...]
> >> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
> > [...]
> >> @@ -21,19 +21,30 @@
> >>  #define MC_INT_INVALID_SMMU_PAGE (1 << 10)
> >>  #define MC_INT_ARBITRATION_EMEM (1 << 9)
> >>  #define MC_INT_SECURITY_VIOLATION (1 << 8)
> >> +#define MC_INT_INVALID_GART_PAGE (1 << 7)
> >>  #define MC_INT_DECERR_EMEM (1 << 6)
> >> =20
> >>  static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
> >>  {
> >> +	if (mc->regs2 && offset >=3D 0x24)
> >> +		return readl(mc->regs2 + offset - 0x3c);
> >=20
> > I'm still not sure how this is supposed to work. If we pass in
> > MC_GART_ERROR_REQ as offset into mc_readl(), then the condition above
> > will be true (0x30 >=3D 0x24) but then the new offset will be computed
> > and we end up with:
> >=20
> > 	return readl(mc->regs2 + 0x30 - 0x3c);
> >=20
> > which means we'll be adding a negative offset (or rather a very large
> > offset because it will wrap around).
>=20
> Indeed! Thank you for pointing at it again, now I see the issue. It proba=
bly
> works because actual registers mapping is aligned to page(?) size and add=
ing the
> large offset with wraparound is equal to subtraction.
>=20
> That register belongs to the GART and we can't simply move interrupt hand=
ling to
> the GART driver because status register is within the MC in device tree. =
We can
> omit reading of MC_GART_ERROR_REQ and simply report GART page fault for t=
he
> starter and then reorganize drivers by making MC driver MFD and GART its
> sub-device, what do you think?

Sounds like a good idea. Can you send a fix on top of this that I can
squash into this when applying?

As for integrating GART with MC, I'd prefer something that doesn't use
MFD but rather does something similar to what we have for the SMMU. I
think that's simpler to do and has less boilerplate. I think it's also
warranted because the MC and GART are very tightly coupled, so an MFD
would be slightly over-engineered, in my opinion.

Thierry

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri+nYACgkQ3SOs138+
s6GYExAAimwXipgcyZTeIWvARB5qgXxFKtWdPsMmGXSiqsx/NfWGcn8Vl9Jr4xAC
OoreH4vXxFPQ64hakD2Pe6C7C0Y/Q5PPrg6Pq5rK4M9SGR8kdt2o8szNsn3P5AAg
QtUYAY6+w5LpbpRKeOmxPO1We5/X55HY7Prk+kzTS2qO3mfgPvlf8RkC3LaVTl78
VVUtBd8duG9PO+8lS91RaTZBrBYSNCwg47f1SGHR8UJGozvWEssqCqebbuCplMNZ
j9XjkA4MBE8ZgBgcpYDA+M4jnhjulN8RaURsM0vfSCo8SB4gId09aGk2Liq7ClsP
rdPOt8W/cCW3/3UYguxnjeGWV29+FM5J73WF4qj4mI2JA3bWoCYNPYs9hmeFi2+j
fihhbsotBf74XWNol660ILUZNXXWS9iwMo6Qu9+G+YAXihMdln6EA49asifCkCOg
R6Wybrj+6O+rrUjZxOxptA+jbLxOeBzk5XPD52VCTpjmY/iw3NKjyAEtfFm3am+k
4KXs0Lubo2HmDMO3LRLzqVEa391F9ef5JCK9C9OsUJp/yvKklwyJRDkVUYl5HnzS
CBgBCIUG50EWikLF3x/v+6PKwQOFSdhtDvBRDwuaIgxj5C6W8Mn+5gqZA/D4U/lJ
Ln2PAj1i6RvK7PnJjFu93Ni9pE93elJw7mbmC6QU+XlSdLDqclY=
=k/ub
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
