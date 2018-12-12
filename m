Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39997C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BFF20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BFF20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kleine-koenig.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeLLKzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:55:11 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:45850 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:55:11 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 5B4C54DA83E; Wed, 12 Dec 2018 11:55:08 +0100 (CET)
Date:   Wed, 12 Dec 2018 11:55:06 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2/3] pwm: imx: Use bitops and bitfield macros to define
 register values
Message-ID: <20181212105506.GB9268@taurus.defre.kleine-koenig.org>
References: <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <1538403588-68850-2-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 01, 2018 at 04:19:47PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Use existing macros to define register fields instead of manually shifting
> the bit masks. Also define some more register bits.

I didn't check, but wonder if these additional register bits are then
used in the next patch. Maybe I'd change this patch to not introduce
something new, only let it modify the already existing stuff and then
introduce the new bits in the patch that makes use of them.

> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
> ---
>  drivers/pwm/pwm-imx.c | 78 ++++++++++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 58 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index bcbcac4..7a4907b 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -5,6 +5,8 @@
>   * Derived from pxa PWM driver by eric miao <eric.miao@marvell.com>
>   */
> =20
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -23,7 +25,7 @@
>  #define MX1_PWMS			0x04   /* PWM Sample Register */
>  #define MX1_PWMP			0x08   /* PWM Period Register */
> =20
> -#define MX1_PWMC_EN			(1 << 4)
> +#define MX1_PWMC_EN			BIT(4)
> =20
>  /* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
> =20
> @@ -31,18 +33,53 @@
>  #define MX3_PWMSR			0x04    /* PWM Status Register */
>  #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>  #define MX3_PWMPR			0x10    /* PWM Period Register */
> -#define MX3_PWMCR_PRESCALER(x)		((((x) - 1) & 0xFFF) << 4)
> -#define MX3_PWMCR_STOPEN		(1 << 25)
> -#define MX3_PWMCR_DOZEEN		(1 << 24)
> -#define MX3_PWMCR_WAITEN		(1 << 23)
> -#define MX3_PWMCR_DBGEN			(1 << 22)
> -#define MX3_PWMCR_POUTC			(1 << 18)
> -#define MX3_PWMCR_CLKSRC_IPG_HIGH	(2 << 16)
> -#define MX3_PWMCR_CLKSRC_IPG		(1 << 16)
> -#define MX3_PWMCR_SWR			(1 << 3)
> -#define MX3_PWMCR_EN			(1 << 0)
> -#define MX3_PWMSR_FIFOAV_4WORDS		0x4
> -#define MX3_PWMSR_FIFOAV_MASK		0x7
> +
> +#define MX3_PWMCR_FWM			GENMASK(27, 26)
> +#define MX3_PWMCR_STOPEN		BIT(25)
> +#define MX3_PWMCR_DOZEN			BIT(24)
> +#define MX3_PWMCR_WAITEN		BIT(23)
> +#define MX3_PWMCR_DBGEN			BIT(22)
> +#define MX3_PWMCR_BCTR			BIT(21)
> +#define MX3_PWMCR_HCTR			BIT(20)
> +
> +#define MX3_PWMCR_POUTC			GENMASK(19, 18)
> +#define MX3_PWMCR_POUTC_NORMAL		0
> +#define MX3_PWMCR_POUTC_INVERTED	1
> +#define MX3_PWMCR_POUTC_OFF		2
> +
> +#define MX3_PWMCR_CLKSRC		GENMASK(17, 16)
> +#define MX3_PWMCR_CLKSRC_OFF		0
> +#define MX3_PWMCR_CLKSRC_IPG		1
> +#define MX3_PWMCR_CLKSRC_IPG_HIGH	2
> +#define MX3_PWMCR_CLKSRC_IPG_32K	3
> +
> +#define MX3_PWMCR_PRESCALER		GENMASK(15, 4)
> +
> +#define MX3_PWMCR_SWR			BIT(3)
> +
> +#define MX3_PWMCR_REPEAT		GENMASK(2, 1)
> +#define MX3_PWMCR_REPEAT_1X		0
> +#define MX3_PWMCR_REPEAT_2X		1
> +#define MX3_PWMCR_REPEAT_4X		2
> +#define MX3_PWMCR_REPEAT_8X		3
> +
> +#define MX3_PWMCR_EN			BIT(0)
> +
> +#define MX3_PWMSR_FWE			BIT(6)
> +#define MX3_PWMSR_CMP			BIT(5)
> +#define MX3_PWMSR_ROV			BIT(4)
> +#define MX3_PWMSR_FE			BIT(3)
> +
> +#define MX3_PWMSR_FIFOAV		GENMASK(2, 0)
> +#define MX3_PWMSR_FIFOAV_EMPTY		0
> +#define MX3_PWMSR_FIFOAV_1WORD		1
> +#define MX3_PWMSR_FIFOAV_2WORDS		2
> +#define MX3_PWMSR_FIFOAV_3WORDS		3
> +#define MX3_PWMSR_FIFOAV_4WORDS		4
> +
> +#define MX3_PWMCR_PRESCALER_SET(x)	FIELD_PREP(MX3_PWMCR_PRESCALER, (x) -=
 1)
> +#define MX3_PWMCR_PRESCALER_GET(x)	(FIELD_GET(MX3_PWMCR_PRESCALER, \
> +						   (x)) + 1)

I wouldn't hide the +1 and -1 in a macro but as this was already the
case before your patch, that's ok.

>  #define MX3_PWM_SWR_LOOP		5
> =20
> @@ -142,14 +179,14 @@ static void imx_pwm_wait_fifo_slot(struct pwm_chip =
*chip,
>  	u32 sr;
> =20
>  	sr =3D readl(imx->mmio_base + MX3_PWMSR);
> -	fifoav =3D sr & MX3_PWMSR_FIFOAV_MASK;
> +	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>  	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
>  		period_ms =3D DIV_ROUND_UP(pwm_get_period(pwm),
>  					 NSEC_PER_MSEC);
>  		msleep(period_ms);
> =20
>  		sr =3D readl(imx->mmio_base + MX3_PWMSR);
> -		if (fifoav =3D=3D (sr & MX3_PWMSR_FIFOAV_MASK))
> +		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
>  			dev_warn(dev, "there is no free FIFO slot\n");
>  	}
>  }
> @@ -207,13 +244,14 @@ static int imx_pwm_apply_v2(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>  		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> =20
> -		cr =3D MX3_PWMCR_PRESCALER(prescale) |
> -		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEEN | MX3_PWMCR_WAITEN |
> -		     MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC_IPG_HIGH |
> -		     MX3_PWMCR_EN;
> +		cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> +		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> +		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> +		     MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
> =20
>  		if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> -			cr |=3D MX3_PWMCR_POUTC;
> +			cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> +					MX3_PWMCR_POUTC_INVERTED);
> =20
>  		writel(cr, imx->mmio_base + MX3_PWMCR);
>  	} else if (cstate.enabled) {

Best regards
Uwe

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlwQ6QcACgkQwfwUeK3K
7An0EQf/U/abZnK5uMZ8s9+bR5WjAO/QDzYKy8negD0scOLVGCmfbtyzWoA6iIWx
CV+TqoH4kmf3pqh/Tnc4u03QNpYbjeZPP27aWLbqjEtFn+NA/pkzeZKxPSxENx5d
CmajABb8VlG2tgScUOJSS3LX2I/auLIgx6nys88M/AqcLfg5S+1ii3lmkbRhK6I7
TH8fMhL3qlRZe+Muy3JNVOus34s6nxifDVyi/37HnxkhkowaZpT4Ltcw9JOCDG6L
UgOH4BtLfIVK3F8T91rKjgOKJWctmXMLM6xGDJmQW2/Mepex/QaePZlXh1mj9Bb3
eMpv2DjEEYUOypFAp7FxCYVSkyRd9w==
=Nc4F
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
