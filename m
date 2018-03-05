Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeCEQRn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:17:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:17:41 -0500
Date: Mon, 5 Mar 2018 16:17:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: david@lechnology.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] regmap: debugfs: Do not print warning when no device is
 associated
Message-ID: <20180305161739.GN8588@sirena.org.uk>
References: <1520017960-5120-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KCXyoJ//PRyfzsc9"
Content-Disposition: inline
In-Reply-To: <1520017960-5120-1-git-send-email-festevam@gmail.com>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KCXyoJ//PRyfzsc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 02, 2018 at 04:12:40PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>

> Commit 9b947a13e7f6 ("regmap: use debugfs even when no device")
> allows the usage of regmap debugfs even when there is no device
> associated, which causes several warnings like this:

> (NULL device *): Failed to create debugfs directory

> Do not print the warning in the case there is no associated device.=20

>  	map->debugfs =3D debugfs_create_dir(name, regmap_debugfs_root);
>  	if (!map->debugfs) {
> -		dev_warn(map->dev, "Failed to create debugfs directory\n");
> +		if (map->dev)
> +			dev_warn(map->dev,
> +				 "Failed to create debugfs directory\n");

This then means that we will just randomly not create a debugfs for
anything except the first device that tries to do so with no device
which doesn't seem right.  We should try harder to create a name here,
for example we could try printing the pointer to the map.  Or keep a
counter and use dummy0 and so on.

--KCXyoJ//PRyfzsc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqdbaIACgkQJNaLcl1U
h9BV0Qf9FSCQqej8bGaMWc3N/4xaVGqlY8/s3ZAiviQd1k4AbpgHceffY3JC4Nu9
YQguQyBN16t6A+uP7fMXPJkvqcnytExkOcHL23ssZCMZNlIPbMgtKJO8oUXVv+dm
fdkOlLJYhI2LGv5wHSPwYp9NIbQSGckcJHsflN+bPWWCWTVOr/qSSspm3rd+MQY/
Dp18rHTa/elHfQ53tqCfh9jxXQ4a5ueodNcave7QfT5+oynApFSjhRJnjCPpQRox
1nI3CeqONtvX0OV+bNkdhXcpCjgs7w9h6SRwFwnsZhxViKvgl1XQhbUQCxirQ/N1
kw2hDOzsMBtO/Lqxe59Kbu469Nfoqg==
=gEA7
-----END PGP SIGNATURE-----

--KCXyoJ//PRyfzsc9--
