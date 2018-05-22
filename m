Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeEVRaG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:30:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45150 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeEVRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:30:04 -0400
Date: Tue, 22 May 2018 18:30:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: "Mahadevan, Girish" <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180522173000.GG24776@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline
In-Reply-To: <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
X-Cookie: I have not yet begun to byte!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 22, 2018 at 09:46:39AM -0700, Stephen Boyd wrote:
> Quoting Mahadevan, Girish (2018-05-21 08:52:47)

> > Not sure I follow, the intention is to run the controller clock based on
> > the slave's max frequency.

> That's good. The problem I see is that we have to specify the max
> frequency in the controller/bus node, and also in the child/slave node.
> It should only need to be specified in the slave node, so making the
> cur_speed_hz equal the max_speed_hz is problematic. The current speed of
> the master should be determined by calling clk_get_rate().

We don't require that the slaves all individually set a speed since it
gets a bit redundant, it should be enough to just use the default the
controller provides.  A bigger problem with this is that the driver will
never see a transfer which doesn't explicitly have a speed set as the
core will ensure something is set, open coding this logic in every
driver would obviously be tiresome.

> > The intention was to allow a client to specify slave specific timing
> > requirements, e.g CS-CLK delay (based on the slave's data sheet).
> > So that the client drivers could setup these delays and pass it in part
> > of the controller_data member of the spi_device data structure.
> > The header file was meant to expose these timing params that the client
> > could specify. I honestly didn't know how else a client could specify
> > these to the controller driver.

> Do you mean spi-rx-delay-us and spi-tx-delay-us properties? Those are
> documented but don't seem to be used. There's also the delay_usecs part
> of the spi_transfer structure, which may be what you're talking about.

delay_usecs is for inter-transfer delays within a message rather than
after the initial chip select assert (it can be used to keep chip select
asserted for longer after the final transfer too).  Obviously this is
also something that shouldn't be configured in a driver specific
fashion.

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsEU5cACgkQJNaLcl1U
h9AgKQf/f+zSQxgTA0ua8BkfUORt3URAfVT5QWAz7zlwRwnZNxYzxCtzaFH+amUJ
UVg4hNRLNE3esk/IMW08cIeZ/Av1Sf7bvKzGi+00nn9OzPrS7/CUCzs5h+YCidr8
rNtyWyEfH4fE1DAFG0wXLiUwUNX19ZWFEX/x0AV2PRxjEDa6YQKdCDfGxysktBI5
go+aSK/QrL0U+fMCHD/ZOBZshK3UEo44rsRaVn0TwgCQbbif9yjio/9t7+iD6ctH
eI5i6YoChrKmdmvIhUJOPvlQSYz2n/W6SzLsOE2mirG58PQK6cWCnWpQKQ96YMDw
dDSgKjHMWGevT53hWND8e5UQoRveDg==
=Kgdi
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
