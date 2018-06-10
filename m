Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id L00PCI1nHFvXMQAAmS7hNA
	; Sun, 10 Jun 2018 00:05:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5A97F6074D; Sun, 10 Jun 2018 00:05:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxOxbkGa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B9F40605A2;
	Sun, 10 Jun 2018 00:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9F40605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeFJAFk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 20:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753486AbeFJAFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 20:05:39 -0400
Received: from mail.kernel.org (host-091-097-086-238.ewe-ip-backbone.de [91.97.86.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D1320874;
        Sun, 10 Jun 2018 00:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528589138;
        bh=Pk2EdMQYBsya8NHHAWlKOj5eZBEuvaEfiRymv5c2xmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxOxbkGafZq3I7pzb2Z1yqShYWaZG6SRCyLw32Fnw44VYCzP8OCObi/9EAotR4y3z
         c4XGCKLsHkUvn0J1+BdMXwoC6YnHTh+KZZpNfxv6c4Trbkrg7DEd8MgqOqfez7Ek2S
         SXY1k747tWXfl3NA+2pHxVJJR2CINTw55IF4PziI=
Date: Sun, 10 Jun 2018 02:05:35 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: omap3isp: zero-initialize the isp
 cam_xclk{a,b} initial data
Message-ID: <20180610000535.32ouofio7n5b6rmj@earth.universe>
References: <20180609122245.29636-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmtdtfxmf372mvgo"
Content-Disposition: inline
In-Reply-To: <20180609122245.29636-1-javierm@redhat.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmtdtfxmf372mvgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 09, 2018 at 02:22:45PM +0200, Javier Martinez Canillas wrote:
> The struct clk_init_data init variable is declared in the isp_xclk_init()
> function so is an automatic variable allocated in the stack. But it's not
> explicitly zero-initialized, so some init fields are left uninitialized.
>=20
> This causes the data structure to have undefined values that may confuse
> the common clock framework when the clock is registered.
>=20
> For example, the uninitialized .flags field could have the CLK_IS_CRITICAL
> bit set, causing the framework to wrongly prepare the clk on registration.
> This leads to the isp_xclk_prepare() callback being called, which in turn
> calls to the omap3isp_get() function that increments the isp dev refcount.
>=20
> Since this omap3isp_get() call is unexpected, this leads to an unbalanced
> omap3isp_get() call that prevents the requested IRQ to be later enabled,
> due the refcount not being 0 when the correct omap3isp_get() call happens.
>=20
> Fixes: 9b28ee3c9122 ("[media] omap3isp: Use the common clock framework")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

good catch!

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>=20
> ---
>=20
> Changes in v2:
> - Correct some typos in the commit message.
>=20
>  drivers/media/platform/omap3isp/isp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platfo=
rm/omap3isp/isp.c
> index f22cf351e3e..ae0ef8b241a 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -300,7 +300,7 @@ static struct clk *isp_xclk_src_get(struct of_phandle=
_args *clkspec, void *data)
>  static int isp_xclk_init(struct isp_device *isp)
>  {
>  	struct device_node *np =3D isp->dev->of_node;
> -	struct clk_init_data init;
> +	struct clk_init_data init =3D { 0 };
>  	unsigned int i;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(isp->xclks); ++i)
> --=20
> 2.17.1
>=20

--gmtdtfxmf372mvgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsca0wACgkQ2O7X88g7
+pqSBxAAhvow3XuAgndl8DsB0DuK/iyz7Hjk7nqsaGMkHyG8bCv+q/d0+WwGhEq7
S7gg4GMz/qBKU4dBJDbzBFSULNmwrJOCE3zTMNLx2sub/MeRL/zTIwt4v9Ue8uRx
C9ldukWJmxuElvBSchmWdyAbgFGOCePjWvxxQumL3pTIzAGGoXU1JuwAcydThV+2
d3l4ZnRrRIhU6vcPbRi0T+6r5tFJbjJ5s7dpsDlqFsGISLE0WL4EoXx//eGnhoSS
hNmUwvkHsFJuBdMndNFGScCXNeR0CtvteSjGoDuxm1ziXdgupd/xZ2Wlf0OMt+9K
FdPGflCR8PTD4runnSFJaGm6Gf7cDl8ciZPoqKG2Z0hu13NtJ10hOvfuVN29sjx1
HdLuyqFwcQhlcafGZ8ZQ6OJw2EwbQq3EtXZm9zjcPsVFSi+1GYIYxM9w3r+RbZWd
ezjz/2XI0SdRiG4xNULQ2sGj8553aBzAdP313JHHso3f4EOyWgOTY7D1YjH4k30y
kmQ2RUF4ONAKX78BE4t8Xj9UximfJyk11MMHc0uum7AvxmqkOZjv/wHv3jGoJZ/P
18rnrcmbaG42fz+pYBqemVidoscmXPNdDx1L2qiAEbTU0Mp/QMnGbsbe6zmjx8XI
AW9wktfxYWLxszFambJtvHFNvoq+l9XtjBgRVWdLfNVHlJfHUOc=
=MbGL
-----END PGP SIGNATURE-----

--gmtdtfxmf372mvgo--
