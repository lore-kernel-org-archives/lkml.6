Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB8DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84355218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBKMof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:44:35 -0500
Received: from sauhun.de ([88.99.104.3]:54092 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbfBKMof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:44:35 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 718AF2E3542;
        Mon, 11 Feb 2019 13:44:32 +0100 (CET)
Date:   Mon, 11 Feb 2019 13:44:32 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com,
        peda@axentia.se, digetx@gmail.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V18 2/6] i2c: tegra: add bus clear Master Support
Message-ID: <20190211124431.kys66uzp5hwa5ret@ninjato>
References: <1549652382-5476-1-git-send-email-skomatineni@nvidia.com>
 <1549652382-5476-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yt4liwd2sdc4itsr"
Content-Disposition: inline
In-Reply-To: <1549652382-5476-2-git-send-email-skomatineni@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yt4liwd2sdc4itsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 08, 2019 at 10:59:38AM -0800, Sowjanya Komatineni wrote:
> Bus clear feature of Tegra I2C controller helps to recover from
> bus hang when I2C master loses the bus arbitration due to the
> slave device holding SDA LOW continuously for some unknown reasons.
>=20
> Per I2C specification, the device that held the bus LOW should
> release it within 9 clock pulses.
>=20
> During bus clear operation, Tegra I2C controller sends 9 clock
> pulses and terminates the transaction with STOP condition.
> Upon successful bus clear operation, bus goes to idle state and
> driver retries the transaction.
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

We have a bus recovery infrastructure in the core. Tying your code into
it should be easy. You probably just need a 'struct
i2c_bus_recovery_info', populate the 'recover_bus' callback with
'tegra_i2c_issue_bus_clear()', and attach this struct to the 'struct
adapter' if the IP core supports bus recovery, otherwise leave it empty.
Then, you can...

> +static int tegra_i2c_issue_bus_clear(struct tegra_i2c_dev *i2c_dev)
> +{
> +	int err;
> +	unsigned long time_left;
> +	u32 reg;
> +
> +	if (i2c_dev->hw->supports_bus_clear) {

=2E.. remove the if here because the core will check for a valid
i2c_bus_recovery_info...

> @@ -759,6 +818,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *=
i2c_dev,
>  		return 0;
> =20
>  	tegra_i2c_init(i2c_dev);
> +	/* start recovery upon arbitration loss in single master mode */
> +	if (i2c_dev->msg_err =3D=3D I2C_ERR_ARBITRATION_LOST) {
> +		if (!i2c_dev->is_multimaster_mode)
> +			return tegra_i2c_issue_bus_clear(i2c_dev);

=2E.. and use simply i2c_recover_bus() here.

This will help making bus recovery use consistent across drivers.

Thanks,

   Wolfram

--yt4liwd2sdc4itsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhbisACgkQFA3kzBSg
KbaXfw/8D5oseEP3Y/5D8I63l1EVBNyE3QSoHKp6mPkNltlBc+AS6LlZqo5rbu+R
nW61wGlOxlIFyCknQu2hcOk1+nqmGCeeHdXTS3qu9VN+Lb3oeMPQigLLrPnE/To+
2EUJQtX54Tp17YwJLBQjllKwBuCUDue78Sn8BaEV6e7HzuIY/UaeezWVXU4/K7uA
t1xM8vU+G38Pi1FK68EnFo0rT/OGqrNLLBv3yT/zUj+6SAtE8lbQzboq9HRnWMmD
9TlsiBlZBV2eDgT2yEOA6e4v2FPEg/wMcY0CBb5FGYVGcOb3PRRg6xAUON0fy9Kn
qVQePBgOLsX+KooENUsvPsECZLhHtRHWw6BEs7r+rZq8zf3OCb3uk5fkG0fnl1xE
tTtB0RUSRWrHmZiT40qT7ElxmLHkjbM/sNZ+weCv9/V4NRnzpcPP0HQR14kg/bey
MM9b+BhxhiGZR112eqP0Fe7HHBWz6s27aCKNUayd6il/Vv+jhYt/WGPj5S1eSVYp
ASFxOxioRyOgH8nOBNFsy1Xh1C/T7PHlmTuhdUEOD1SDjZ/GeDCbVvt8kU3Pq1j5
+XPH4mCPzl9BSJaJ6RsDRVr5AY4wIR+WJNiWIA7mGQjb7d/1a2ET2vhU85H8otTF
+rk0Sw/R8GFrfN1k3vsCjNAfDLY4FFkJmt+mNJhNhMB5fG67zI0=
=nRY5
-----END PGP SIGNATURE-----

--yt4liwd2sdc4itsr--
