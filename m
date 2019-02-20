Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D1EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9D02086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfBTTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:55:53 -0500
Received: from sauhun.de ([88.99.104.3]:58246 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfBTTzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:55:52 -0500
Received: from localhost (p54B33552.dip0.t-ipconnect.de [84.179.53.82])
        by pokefinder.org (Postfix) with ESMTPSA id 403F22C33D1;
        Wed, 20 Feb 2019 20:55:49 +0100 (CET)
Date:   Wed, 20 Feb 2019 20:55:48 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] i2c: designware: Add support for a bus clock
Message-ID: <20190220195548.GB2523@kunai>
References: <1550677803-29716-1-git-send-email-gareth.williams.jx@renesas.com>
 <1550677803-29716-3-git-send-email-gareth.williams.jx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <1550677803-29716-3-git-send-email-gareth.williams.jx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 03:50:03PM +0000, Gareth Williams wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>=20
> The Synopsys I2C Controller has a bus clock, but most SoCs hide this away.
> However, on some SoCs you need to explicity enable the bus clock in order
> to access the registers. Therefore, add support for an optional bus clock.
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>

Code looks good to me. For clarity, though, s/bus clock/peripheral
clock/ in the commit message and code comments.

After that:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> ---
> v3:
>  - busclk renamed to pclk.
>  - Added comment with dw_i2c_dev struct definition describing pclk.
>  - Added enable rollback of first clock if second fails to enable.
> v2:
>  - Use new devm_clk_get_optional() function as it simplifies handling when
>    the optional clock is not present.
> ---
>  drivers/i2c/busses/i2c-designware-common.c  | 18 ++++++++++++++++--
>  drivers/i2c/busses/i2c-designware-core.h    |  2 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c |  5 +++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/bus=
ses/i2c-designware-common.c
> index a473011..5f70078 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -251,13 +251,27 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *de=
v)
> =20
>  int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
>  {
> +	int ret;
> +
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
> =20
> -	if (prepare)
> -		return clk_prepare_enable(dev->clk);
> +	if (prepare) {
> +		/* Optional bus clock */
> +		ret =3D clk_prepare_enable(dev->pclk);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D clk_prepare_enable(dev->clk);
> +		if (ret)
> +			clk_disable_unprepare(dev->pclk);
> +
> +		return ret;
> +	}
> =20
>  	clk_disable_unprepare(dev->clk);
> +	clk_disable_unprepare(dev->pclk);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busse=
s/i2c-designware-core.h
> index b4a0b2b..e88c711 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -177,6 +177,7 @@
>   * @base: IO registers pointer
>   * @cmd_complete: tx completion indicator
>   * @clk: input reference clock
> + * @pclk: clock required to access the registers
>   * @slave: represent an I2C slave device
>   * @cmd_err: run time hadware error code
>   * @msgs: points to an array of messages currently being transferred
> @@ -226,6 +227,7 @@ struct dw_i2c_dev {
>  	void __iomem		*ext;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> +	struct clk		*pclk;
>  	struct reset_control	*rst;
>  	struct i2c_client		*slave;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index 9eaac3b..c550fb2 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -346,6 +346,11 @@ static int dw_i2c_plat_probe(struct platform_device =
*pdev)
>  	else
>  		i2c_dw_configure_master(dev);
> =20
> +	/* Optional bus clock */
> +	dev->pclk =3D devm_clk_get_optional(&pdev->dev, "pclk");
> +	if (IS_ERR(dev->pclk))
> +		return PTR_ERR(dev->pclk);
> +
>  	dev->clk =3D devm_clk_get(&pdev->dev, NULL);
>  	if (!i2c_dw_prepare_clk(dev, true)) {
>  		u64 clk_khz;
> --=20
> 2.7.4
>=20

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxtsMQACgkQFA3kzBSg
KbbdsxAAmhaMB1dpKj21S+7CppitlLMLV4i9Hs2+yh8VhOE4w3pQUGR5LrYNi6h8
IDZFP7IHOFhUbH1PZskSfiUwiRRqpMv84gBIgOOhmuh97hAb4gYMZX8kzPCq4P3z
dnqqfzQ6uXKfYi/ceToTLpDn+lPxtmKktqan5MePXT24yxT+5rv0GYSExjQLe8xR
mpTGUZ8XFDg4YweJrOitxOit0h384XYMeL5nlY64/UtYgxLEypyyn5NFEwOgfZoj
j9FGAHENEdIBiz9ooBEO6JxAypuJrhewP1NnVAqsOgm9kkP9JwlqwXJYIhyV5ERu
OgfKU6WFj/1WA3E3jx+MZuoTeJ7RC5oK77+ZxXCIdKCh4PyiVWbokIDG4tnPqsOR
hJBbjgklhDPukpwfziNR9au8Apm4Wtr3MnIvlpCXog+27fpHB3p8AfVVROVuRPI1
1fZVttPOXkx1l+r/ChHENJSlZWO/fg6bF349WnOL0QlBoX+prIFsZVpYveIRMR+u
XhxHwQL6qCAnuMFIN12SZuq3fI5ydjVhxn6CT35z6ltMmhxRjgMlC3BfhZg+FZzd
vPkRnNPnVNr/7a6TjdjXrwk3+ps7Oai6Jw7KFdhEiyz7huoTlKeh7BFR4MpToT87
XEjdAbGeY/1OuvdljvZlveztP0WBDWbpdv3MQuZNYjs0QCW6AHM=
=73Ie
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
