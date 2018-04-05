Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeDEJTR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:19:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37812 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751928AbeDEJTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:19:15 -0400
Date: Thu, 5 Apr 2018 11:19:13 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
Message-ID: <20180405091913.ky4dnmszoobn2xry@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-4-ssuloev@orpaltech.com>
 <20180404065048.n76r3ytuznd6fqsl@flea>
 <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bizuw3gdhbmhbial"
Content-Disposition: inline
In-Reply-To: <a6044902-8977-3ce1-d7d5-c6797341a5d0@orpaltech.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bizuw3gdhbmhbial
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 04, 2018 at 02:35:14PM +0300, Sergey Suloev wrote:
> On 04/04/2018 09:50 AM, Maxime Ripard wrote:
> > On Tue, Apr 03, 2018 at 06:44:46PM +0300, Sergey Suloev wrote:
> > > There is no need to handle 3/4 empty interrupt as the maximum
> > > supported transfer length in PIO mode is equal to FIFO depth,
> > > i.e. 128 bytes for sun6i and 64 bytes for sun8i SoCs.
> > >=20
> > > Changes in v3:
> > > 1) Restored processing of 3/4 FIFO full interrupt.
> > >=20
> > > Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
> > > ---
> > >   drivers/spi/spi-sun6i.c | 41 +++++++++++++++++---------------------=
---
> > >   1 file changed, 17 insertions(+), 24 deletions(-)
> > >=20
> > > diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> > > index 78acc1f..c09ad10 100644
> > > --- a/drivers/spi/spi-sun6i.c
> > > +++ b/drivers/spi/spi-sun6i.c
> > > @@ -207,7 +207,10 @@ static void sun6i_spi_set_cs(struct spi_device *=
spi, bool enable)
> > >   static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
> > >   {
> > > -	return SUN6I_MAX_XFER_SIZE - 1;
> > > +	struct spi_master *master =3D spi->master;
> > > +	struct sun6i_spi *sspi =3D spi_master_get_devdata(master);
> > > +
> > > +	return sspi->fifo_depth;
> > Doesn't that effectively revert 3288d5cb40c0 ?
> >=20
> > Why do you need to do so?
>
> Need what?

Why do you need to revert that change.

> Change is supposed to restrict max transfer size for PIO mode otherwise it
> will fail.
> The maximum transfer length =3D FIFO depth for PIO mode.

The point of that patch was precisely to allow to send more data than
the FIFO. You're breaking that behaviour without any justification,
and this is not ok.

> >=20
> > >   }
> > >   static int sun6i_spi_prepare_message(struct spi_master *master,
> > > @@ -255,8 +258,14 @@ static int sun6i_spi_transfer_one(struct spi_mas=
ter *master,
> > >   	int ret =3D 0;
> > >   	u32 reg;
> > > -	if (tfr->len > SUN6I_MAX_XFER_SIZE)
> > > -		return -EINVAL;
> > > +	/* A zero length transfer never finishes if programmed
> > > +	   in the hardware */
> > Improper comment style here. Please make sure to run checkpatch before
> > sending your patches.
> ok
> >=20
> > > +	if (!tfr->len)
> > > +		return 0;
> > Can that case even happen?
> Not sure, just for safety.
> >=20
> > > +	/* Don't support transfer larger than the FIFO */
> > > +	if (tfr->len > sspi->fifo_depth)
> > > +		return -EMSGSIZE;
> > You're changing the return type, why?
> As=A0 a more appropriate one

The fact that it's more appropriate should be justified.

> >=20
> > >   	reinit_completion(&sspi->done);
> > >   	sspi->tx_buf =3D tfr->tx_buf;
> > > @@ -278,8 +287,7 @@ static int sun6i_spi_transfer_one(struct spi_mast=
er *master,
> > >   	 */
> > >   	trig_level =3D sspi->fifo_depth / 4 * 3;
> > >   	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG,
> > > -			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS) |
> > > -			(trig_level << SUN6I_FIFO_CTL_TF_ERQ_TRIG_LEVEL_BITS));
> > > +			(trig_level << SUN6I_FIFO_CTL_RF_RDY_TRIG_LEVEL_BITS));
> > >   	reg =3D sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> > > @@ -343,11 +351,8 @@ static int sun6i_spi_transfer_one(struct spi_mas=
ter *master,
> > >   	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
> > >   	/* Enable the interrupts */
> > > -	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
> > >   	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
> > >   					 SUN6I_INT_CTL_RF_RDY);
> > > -	if (tx_len > sspi->fifo_depth)
> > > -		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
> > This would also need to be explained in your commit log.
> What exactly and in what way ?

You should explain, at least:
A) What is the current behaviour
B) Why that is a problem, or what problem does it cause
C) What solution you implement and why you think it's justified

> >=20
> > >   	/* Start the transfer */
> > >   	reg =3D sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
> > > @@ -376,7 +381,9 @@ out:
> > >   static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
> > >   {
> > >   	struct sun6i_spi *sspi =3D dev_id;
> > > -	u32 status =3D sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
> > > +	u32 status;
> > > +
> > > +	status =3D sun6i_spi_read(sspi, SUN6I_INT_STA_REG);
> > Why is this change needed?
> A minor one, for readability.

That's arguable, and you should have a single logical change per
patch. So this doesn't belong in this one.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bizuw3gdhbmhbial
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrF6hAACgkQ0rTAlCFN
r3TzSQ//WWD5+GpoGLjM7FzSp1AMOAYm7GxC+iIE+kdTWQkaXoDOrWYtnQ1iQd9b
tGWPz9bENI6ttrR9UideK76dBaB/9OMT2vIOYPeIu0wBJHVzDPWuEecVsEN2P3ZE
TelYQSpd3UjLDQlWPvAuMqqpGJ7kNRWo+M3SV/J/F0VzPKlKkgnTM4gZXQ743fSn
ESygxZ0B0ucNgpolPwU1adbAY5FgKaDWscBlHs7FNjf6cNPEz2gyGUZZu2Q1xdbO
kFMtGninZlbZ7WTswLg18RNPxOIBogcvQ0R6PjXwQ4Hyd9G8NkvK5XEqOsSNASJJ
NgKNg7bS+e1xODs35ocGmAkPRWd3tF9oCTh0eEm/TKoVPK4mkfPDwXcXiNf51BjW
J+gjj9KnNY5PnETt6Mb42S9mB8FFCQHvbaqWLFHULy3sxPooVeXuw+fnPxhg4MH5
B6797UmoCiBD47gaqZoBA32zvR0P7QGZ2FsLKmU7P7iJnzLYRXXQOO+CiaI9nat/
dU51+o1PBeGLYLIAuM1zcemeLFYr69IHk1rFZAAdiGXWCD9ofxxpqdTHlm4tnrUh
Rld3NXFNy1tNNOkxDqqsn/XCJjJmcE/tb6kOmILQh5uB7dsm69V5rC+A6HwTuOGc
iN2FOBoEEKxwaT7H3hTXT5udr+a3fVUK3w60tSQg/TDaTLhBk5c=
=jDrv
-----END PGP SIGNATURE-----

--bizuw3gdhbmhbial--
