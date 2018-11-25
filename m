Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1B3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668A820855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 10:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668A820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeKYVNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:13:17 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59678 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeKYVNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:13:16 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 82C218092E; Sun, 25 Nov 2018 11:22:25 +0100 (CET)
Date:   Sun, 25 Nov 2018 11:22:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Nishad Kamdar <nishadkamdar@gmail.com>, lkundrak@v3.sk
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the
 gpio descriptor interface
Message-ID: <20181125102227.GA25471@amd>
References: <20181107124849.GA21899@nishad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20181107124849.GA21899@nishad>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Use the gpiod interface instead of the deprecated old non-descriptor
> interface in olpc_dcon_xo_1.c.
>=20
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

You may want to cc: lkundrak@v3.sk, he was doing great work on OLPC
lately...

Best regards,
								Pavel

> ---
> Changes in v4:
>  - Move changelog after signed-off line.
> Changes in v3:
>  - Resolve a few compilation errors.
> Changes in v2:
>  - Resolve a few compilation errors.
>  - Add a level of indirection to read and write gpios.
> ---
>  drivers/staging/olpc_dcon/olpc_dcon_xo_1.c | 90 +++++++++++-----------
>  1 file changed, 47 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging=
/olpc_dcon/olpc_dcon_xo_1.c
> index ff145d493e1b..80b8d4153414 100644
> --- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
> +++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
> @@ -11,35 +11,51 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/cs5535.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
> +#include <linux/i2c.h>
>  #include <asm/olpc.h>
> =20
>  #include "olpc_dcon.h"
> =20
> +enum dcon_gpios {
> +	OLPC_DCON_STAT0,
> +	OLPC_DCON_STAT1,
> +	OLPC_DCON_IRQ,
> +	OLPC_DCON_LOAD,
> +	OLPC_DCON_BLANK,
> +};
> +
> +struct dcon_gpio {
> +	const char *name;
> +	unsigned long flags;
> +};
> +
> +static const struct dcon_gpio gpios_asis[] =3D {
> +	[OLPC_DCON_STAT0] =3D { .name =3D "dcon_stat0", .flags =3D GPIOD_ASIS },
> +	[OLPC_DCON_STAT1] =3D { .name =3D "dcon_stat1", .flags =3D GPIOD_ASIS },
> +	[OLPC_DCON_IRQ] =3D { .name =3D "dcon_irq", .flags =3D GPIOD_ASIS },
> +	[OLPC_DCON_LOAD] =3D { .name =3D "dcon_load", .flags =3D GPIOD_ASIS },
> +	[OLPC_DCON_BLANK] =3D { .name =3D "dcon_blank", .flags =3D GPIOD_ASIS },
> +};
> +
> +struct gpio_desc *gpios[5];
> +
>  static int dcon_init_xo_1(struct dcon_priv *dcon)
>  {
>  	unsigned char lob;
> -
> -	if (gpio_request(OLPC_GPIO_DCON_STAT0, "OLPC-DCON")) {
> -		pr_err("failed to request STAT0 GPIO\n");
> -		return -EIO;
> -	}
> -	if (gpio_request(OLPC_GPIO_DCON_STAT1, "OLPC-DCON")) {
> -		pr_err("failed to request STAT1 GPIO\n");
> -		goto err_gp_stat1;
> -	}
> -	if (gpio_request(OLPC_GPIO_DCON_IRQ, "OLPC-DCON")) {
> -		pr_err("failed to request IRQ GPIO\n");
> -		goto err_gp_irq;
> -	}
> -	if (gpio_request(OLPC_GPIO_DCON_LOAD, "OLPC-DCON")) {
> -		pr_err("failed to request LOAD GPIO\n");
> -		goto err_gp_load;
> -	}
> -	if (gpio_request(OLPC_GPIO_DCON_BLANK, "OLPC-DCON")) {
> -		pr_err("failed to request BLANK GPIO\n");
> -		goto err_gp_blank;
> +	int ret, i;
> +	struct dcon_gpio *pin =3D &gpios_asis[0];
> +
> +	for (i =3D 0; i < ARRAY_SIZE(gpios_asis); i++) {
> +		gpios[i] =3D devm_gpiod_get(&dcon->client->dev, pin[i].name,
> +					  pin[i].flags);
> +		if (IS_ERR(gpios[i])) {
> +			ret =3D PTR_ERR(gpios[i]);
> +			pr_err("failed to request %s GPIO: %d\n", pin[i].name,
> +			       ret);
> +			return ret;
> +		}
>  	}
> =20
>  	/* Turn off the event enable for GPIO7 just to be safe */
> @@ -61,12 +77,12 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
>  	dcon->pending_src =3D dcon->curr_src;
> =20
>  	/* Set the directions for the GPIO pins */
> -	gpio_direction_input(OLPC_GPIO_DCON_STAT0);
> -	gpio_direction_input(OLPC_GPIO_DCON_STAT1);
> -	gpio_direction_input(OLPC_GPIO_DCON_IRQ);
> -	gpio_direction_input(OLPC_GPIO_DCON_BLANK);
> -	gpio_direction_output(OLPC_GPIO_DCON_LOAD,
> -			      dcon->curr_src =3D=3D DCON_SOURCE_CPU);
> +	gpiod_direction_input(gpios[OLPC_DCON_STAT0]);
> +	gpiod_direction_input(gpios[OLPC_DCON_STAT1]);
> +	gpiod_direction_input(gpios[OLPC_DCON_IRQ]);
> +	gpiod_direction_input(gpios[OLPC_DCON_BLANK]);
> +	gpiod_direction_output(gpios[OLPC_DCON_LOAD],
> +			       dcon->curr_src =3D=3D DCON_SOURCE_CPU);
> =20
>  	/* Set up the interrupt mappings */
> =20
> @@ -84,7 +100,7 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
>  	/* Register the interrupt handler */
>  	if (request_irq(DCON_IRQ, &dcon_interrupt, 0, "DCON", dcon)) {
>  		pr_err("failed to request DCON's irq\n");
> -		goto err_req_irq;
> +		return -EIO;
>  	}
> =20
>  	/* Clear INV_EN for GPIO7 (DCONIRQ) */
> @@ -125,18 +141,6 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
>  	cs5535_gpio_set(OLPC_GPIO_DCON_BLANK, GPIO_EVENTS_ENABLE);
> =20
>  	return 0;
> -
> -err_req_irq:
> -	gpio_free(OLPC_GPIO_DCON_BLANK);
> -err_gp_blank:
> -	gpio_free(OLPC_GPIO_DCON_LOAD);
> -err_gp_load:
> -	gpio_free(OLPC_GPIO_DCON_IRQ);
> -err_gp_irq:
> -	gpio_free(OLPC_GPIO_DCON_STAT1);
> -err_gp_stat1:
> -	gpio_free(OLPC_GPIO_DCON_STAT0);
> -	return -EIO;
>  }
> =20
>  static void dcon_wiggle_xo_1(void)
> @@ -180,13 +184,13 @@ static void dcon_wiggle_xo_1(void)
> =20
>  static void dcon_set_dconload_1(int val)
>  {
> -	gpio_set_value(OLPC_GPIO_DCON_LOAD, val);
> +	gpiod_set_value(gpios[OLPC_DCON_LOAD], val);
>  }
> =20
>  static int dcon_read_status_xo_1(u8 *status)
>  {
> -	*status =3D gpio_get_value(OLPC_GPIO_DCON_STAT0);
> -	*status |=3D gpio_get_value(OLPC_GPIO_DCON_STAT1) << 1;
> +	*status =3D gpiod_get_value(gpios[OLPC_DCON_STAT0]);
> +	*status |=3D gpiod_get_value(gpios[OLPC_DCON_STAT1]) << 1;
> =20
>  	/* Clear the negative edge status for GPIO7 */
>  	cs5535_gpio_set(OLPC_GPIO_DCON_IRQ, GPIO_NEGATIVE_EDGE_STS);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv6d+MACgkQMOfwapXb+vI8vQCfaulEg6M9u3s3r49J+kTsofdu
0awAnjQJ9HWAKKb/JmXZnIl21GY79ZoJ
=iBOB
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
