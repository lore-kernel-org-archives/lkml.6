Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeD0Jem (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:34:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37691 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757917AbeD0Jej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:34:39 -0400
X-Google-Smtp-Source: AB8JxZoU2icUT4Q/dr22mozK30QUzYzHGOcg6Qm5tgKFfGglysBjeZL5sRRaeay9XmiJOAU4pCg5ww==
Date: Fri, 27 Apr 2018 11:34:35 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] memory: tegra: Squash tegra20-mc into common
 tegra-mc driver
Message-ID: <20180427093435.GB30388@ulmo>
References: <cover.1523301400.git.digetx@gmail.com>
 <675f74f82378b5f7d8f61d35e929614a0e156141.1523301400.git.digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <675f74f82378b5f7d8f61d35e929614a0e156141.1523301400.git.digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 10:28:31PM +0300, Dmitry Osipenko wrote:
[...]
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
[...]
> +#define MC_GART_ERROR_REQ		0x30
> +#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
> +#define MC_SECURITY_VIOLATION_STATUS	0x74
[...]
> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
[...]
> @@ -21,19 +21,30 @@
>  #define MC_INT_INVALID_SMMU_PAGE (1 << 10)
>  #define MC_INT_ARBITRATION_EMEM (1 << 9)
>  #define MC_INT_SECURITY_VIOLATION (1 << 8)
> +#define MC_INT_INVALID_GART_PAGE (1 << 7)
>  #define MC_INT_DECERR_EMEM (1 << 6)
> =20
>  static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
>  {
> +	if (mc->regs2 && offset >=3D 0x24)
> +		return readl(mc->regs2 + offset - 0x3c);

I'm still not sure how this is supposed to work. If we pass in
MC_GART_ERROR_REQ as offset into mc_readl(), then the condition above
will be true (0x30 >=3D 0x24) but then the new offset will be computed
and we end up with:

	return readl(mc->regs2 + 0x30 - 0x3c);

which means we'll be adding a negative offset (or rather a very large
offset because it will wrap around).

Thierry

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri7qsACgkQ3SOs138+
s6Huow/+Lubm4qV0XNorEeW/fNQLPsFNooMAMtEn9uM/bKtDbNAWeQwFc//pw9ji
gTCNgLBHhGxgZp9Y8woT0itfLBN2J9N3uSR3of2i8hMek0NuNtHWj7fa8oFZ4C49
7V2j2jKooTxCP5p+9ONUSoDOEpbYpgvQmXkZEt37AnY7ntiEeFzAHcn6WbA72wIS
eiFzWe0JqD1dqNGDvA0Odo2v3/GIOG0/jsdySvPPc5db0G+kpTVIjVJENGYvNcli
mOxlT0FVLQ00cNUZDxKOuj0N/FiZjwrbVq0paMoez2VAghIa7MoSZsONgSB1oD9e
RCMOsC3dosHzRSrmES0lVo7gCb5xobKbO6ztM6I5jXbtYiphJ4NfkB0+viJ65fBh
zsSABXJF6Kfb4GbZCQBLC6Nru10+jJh6hZH5LfUrbBRdnY43Ic3bXuSPj+HoTz+B
JHspvdmXrn1OZCek+sLOsPwMt9hdqk0lil0ruVCrSvUyRpCCEWsYBG5A8asX9XiL
cZ+wI7prBvfyNQnrDGpdtuBL/CrpsKwrKTrGPjFvQrHdVM+EWBtR2oLxauu8dXNj
o4r8CayWUIBK4yjELKJWdsqxTuGLz+QekprzkdV5j+I3fpjAkD1pTcMcvqfqWKJ7
0bfRyFyQ0DSoF39vReNBcShyNSPe5HErwnQGFCOZx6XxfdUNJxk=
=UQSC
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
