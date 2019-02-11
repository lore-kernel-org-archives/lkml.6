Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F311C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF2F218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfBKMzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:55:13 -0500
Received: from sauhun.de ([88.99.104.3]:54252 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfBKMzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:55:12 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 4C4DA2E3542;
        Mon, 11 Feb 2019 13:55:10 +0100 (CET)
Date:   Mon, 11 Feb 2019 13:55:09 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V18 4/6] i2c: tegra: Add DMA support
Message-ID: <20190211125509.tnsgfl3yoobdpnmj@ninjato>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6grvdmutaaewrqua"
Content-Disposition: inline
In-Reply-To: <1549652382-5476-4-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6grvdmutaaewrqua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 10:59:40AM -0800, Sowjanya Komatineni wrote:
> This patch adds DMA support for Tegra I2C.
>=20
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
>=20
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
>=20
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

I am not sure if you are aware of this document, so I mention it:

Documentation/i2c/DMA-considerations

I am not pushing you to use the i2c_get_dma_safe_msg_buf() helpers, just
wanted to make sure you know about them. I am also fine with an
incremental patch on top of this if you want to add usage of those
helpers somewhen later.

That all being said, I'd accept the patch as is, except for:

> +static const struct tegra_i2c_hw_feature tegra186_i2c_hw =3D {
> +	.has_continue_xfer_support =3D true,
> +	.has_per_pkt_xfer_complete_irq =3D true,
> +	.has_single_clk_source =3D true,
> +	.clk_divisor_hs_mode =3D 1,
> +	.clk_divisor_std_fast_mode =3D 0x19,
> +	.clk_divisor_fast_plus_mode =3D 0x10,
> +	.has_config_load_reg =3D true,
> +	.has_multi_master_mode =3D true,
> +	.has_slcg_override_reg =3D true,
> +	.has_mst_fifo =3D true,
> +	.quirks =3D &tegra_i2c_quirks,
> +	.supports_bus_clear =3D true,
> +	.has_apb_dma =3D false,
>  };
> =20
>  /* Match table for of_platform binding */
>  static const struct of_device_id tegra_i2c_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra194-i2c", .data =3D &tegra194_i2c_hw, },
> +	{ .compatible =3D "nvidia,tegra186-i2c", .data =3D &tegra186_i2c_hw, },
>  	{ .compatible =3D "nvidia,tegra210-i2c", .data =3D &tegra210_i2c_hw, },
>  	{ .compatible =3D "nvidia,tegra124-i2c", .data =3D &tegra124_i2c_hw, },
>  	{ .compatible =3D "nvidia,tegra114-i2c", .data =3D &tegra114_i2c_hw, },

Shouldn't this be a seperate patch?

> -static int __init tegra_i2c_init_driver(void)
> -{
> -	return platform_driver_register(&tegra_i2c_driver);
> -}
> -
> -static void __exit tegra_i2c_exit_driver(void)
> -{
> -	platform_driver_unregister(&tegra_i2c_driver);
> -}
> -
> -subsys_initcall(tegra_i2c_init_driver);
> -module_exit(tegra_i2c_exit_driver);
> +module_platform_driver(tegra_i2c_driver);

This should definately be a seperate patch. While I am all for taking
it, are you sure it does not regress on older Tegra platforms?


--6grvdmutaaewrqua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhcK0ACgkQFA3kzBSg
Kbavrw/8Dbu06tEzHDxhHxYtcIfidsA0eVjiTMI9xUYMNf6W9P0xbk2o0aJTG5Hp
YagcRjZ9q32zAp1JVWqeTLVRDkXRzfw3uI3yxdYI2mmrpFhcMQngHy9FNMi9DaRx
YTYw+xa0SEpPE70Bvvv5fchZIvEkAHX/EZZWVyjhX5QW7RUp+cd7oBzB55GcX9V2
dpFhkmvkfYSzdndb8GKAaEmEIbUlRGU6iVckVTijhCqOF299m/67ldoF6Zi0iWXV
enbjnkx7dvssRH7r1OQEMAeeRaHSLsy7Re/a4K/1CRbvEnHiLxobr8AatgyOPdI2
Ni1qdzxmdIc9CA825Bq/qXbZ/MkOtdboJOxQ0m8FbIoVXB76npt/ROwgNktKCa4u
x2tru5w5YPbTd0f5Mpx57vgunT/7v6xvM4l2uQQLlB+/9oBty3GEXPutJUM4vF9G
qMVlk00SO9dMjME9MPwWro0j/jaOedgCiRi11kNT2qOl0Z9H88NiL/dY+1kp/6wL
hpxlMwqG4gkz3fNYid9XLqQmbBsLm7QdK814iNxmiwClg6hNwpvo0oB1Gf02mW5D
3kXpGp0J+sQ/d30iJ9ZsPF0A89FRmXxnzAOMyOsoyfx8E03V/sPbtu+da96nCaPq
paomg+9t2RSUs04LF033tVGAbv2Y5SJvtJVIirFaAN3sL4My3yo=
=72n6
-----END PGP SIGNATURE-----

--6grvdmutaaewrqua--
