Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeCEWhm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752508AbeCEWhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:37:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0E920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date: Mon, 5 Mar 2018 22:37:36 +0000
From: James Hogan <jhogan@kernel.org>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: ralf@linux-mips.org, paul.gortmaker@windriver.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TXx9: Add missing iounmap
Message-ID: <20180305221833.GJ4197@saruman>
References: <1511473795-20137-1-git-send-email-gomonovych@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <1511473795-20137-1-git-send-email-gomonovych@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 10:49:55PM +0100, Vasyl Gomonovych wrote:
> Add the missing iounmap() before put_device and
> return from txx9_sramc_init().
>=20
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
>  arch/mips/txx9/generic/setup.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setu=
p.c
> index 1791a44ee570..6ef5edb85d68 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -965,6 +965,8 @@ void __init txx9_sramc_init(struct resource *r)
>  	}
>  	return;
>  exit_put:
> +	if (dev->base)
> +		iounmap(dev->base);

I think if dev->base was NULL then a different error path would have
been taken already.

More concerning to be honest though is the sysfs_create_bin_file() error
handling just above here, which seems to iounmap() and kfree() *after*
device_unregister(). txx9_device_release() already kfrees it.

The iounmap() call should prresumably move before the kfree() in
txx9_device_release(), and the kfree() after device_unregister() should
be removed?

Cheers
James

>  	put_device(&dev->dev);
>  	return;
>  }
> --=20
> 1.9.1
>=20

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdxq4ACgkQbAtpk944
dnqrgA//c5yKC1sXPNhPfR2Am6vC3Lh/V2KaV8LEgTZlYNMCVUOeTJYtbV7yVlVY
oY4PsX3lXgzWDHUg+zOr6YNHb4bOOhQ/Fo5Tbep0aybviosbEyx4kgBGIAWnPxuj
1UDNWNcMFYLtCWsIrbziXCKXeOgjJ4zCxb3d3c7a7YXs1HIfRkH2TZV8E6AjnVkI
x0bV/3pF6G+jjtGMn1b5UOgXQLn6/rzYSWDBnXan4xZUpLEXHN9PF/C6zU6ibOFz
egdEigrt1seXx6meLlDpeph0vLhVhNsBekON7FskLq6+8vPxfZlCIkl5y2aSBWnS
zI8Y5Lx0Z0Mx7yg8o4HRWQZVYKjfzjw11Ax0OjGqPGaHsDckDUUVFcycj5naUipu
j2laZjTljAULGZ2pFOEKG4dyGfCIpPZV6wUNZSnZ7rC1J2/eTEMu8dRshGHYtXY6
Gj7JuWu61LrQjeDTqjuCVU3ckqqpFUL66qd1I3usqlZJ5m6EjA0r99Wx34rLt+OX
Kskf4FNhMtDqneb39s6g/pBA8WCTXb/pAg1/C0uEKjzyBfXfxgt2JrAPgFtqehuc
OnlhSkw3PKqauN4FpmOBfHlRBn43ysqiceupNcCAIx0/7e8lAFr0z7eFDSc8PWxz
qixmiwfsXsMuG8xL+AUwqPahT+zxm2V9p8v+1LJ95W+3yeIaoek=
=Z91+
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
