Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeCQVDE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 17:03:04 -0400
Received: from sauhun.de ([88.99.104.3]:38762 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeCQVDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 17:03:03 -0400
Date: Sat, 17 Mar 2018 22:03:00 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: Re: [PATCH v2] i2c: xlp9xx: Add support for SMBAlert
Message-ID: <20180317210300.yyft3errf3opj2t3@ninjato>
References: <1520347594-184146-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gqocpd2od3bxsp7n"
Content-Disposition: inline
In-Reply-To: <1520347594-184146-1-git-send-email-george.cherian@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gqocpd2od3bxsp7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 06:46:34AM -0800, George Cherian wrote:
> Add support for SMBus alert mechanism to i2c-xlp9xx driver.
> The second interrupt is parsed to use for SMBus alert.
> The first interrupt is the i2c controller main interrupt.
>=20
> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Are the previous reviewers happy now?

> ---
>  drivers/i2c/busses/i2c-xlp9xx.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp=
9xx.c
> index eb8913e..d5cadb6 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c-smbus.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
>  	struct device *dev;
>  	struct i2c_adapter adapter;
>  	struct completion msg_complete;
> +	struct i2c_smbus_alert_setup alert_data;
> +	struct i2c_client *ara;
>  	int irq;
>  	bool msg_read;
>  	bool len_recv;
> @@ -447,6 +450,19 @@ static int xlp9xx_i2c_get_frequency(struct platform_=
device *pdev,
>  	return 0;
>  }
> =20
> +static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
> +				  struct platform_device *pdev)
> +{
> +	if (!priv->alert_data.irq)
> +		return -EINVAL;
> +
> +	priv->ara =3D i2c_setup_smbus_alert(&priv->adapter, &priv->alert_data);
> +	if (!priv->ara)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  static int xlp9xx_i2c_probe(struct platform_device *pdev)
>  {
>  	struct xlp9xx_i2c_dev *priv;
> @@ -467,6 +483,10 @@ static int xlp9xx_i2c_probe(struct platform_device *=
pdev)
>  		dev_err(&pdev->dev, "invalid irq!\n");
>  		return priv->irq;
>  	}
> +	/* SMBAlert irq */
> +	priv->alert_data.irq =3D platform_get_irq(pdev, 1);
> +	if (priv->alert_data.irq <=3D 0)

'< 0' should do, or?

> +		priv->alert_data.irq =3D 0;
> =20
>  	xlp9xx_i2c_get_frequency(pdev, priv);
>  	xlp9xx_i2c_init(priv);
> @@ -493,6 +513,10 @@ static int xlp9xx_i2c_probe(struct platform_device *=
pdev)
>  	if (err)
>  		return err;
> =20
> +	err =3D xlp9xx_i2c_smbus_setup(priv, pdev);
> +	if (err)
> +		dev_info(&pdev->dev, "No active SMBus alert %d\n", err);
> +

Do you really want to print this info every time SMBus alert is not
used? Is it common on this platform

>  	platform_set_drvdata(pdev, priv);
>  	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
> =20
> --=20
> 1.8.3.1
>=20

--gqocpd2od3bxsp7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqtgoMACgkQFA3kzBSg
KbY67A/+NMz9SSfbt6tHhA8S37QIb3QRg0JNE/zcBhcJ4pKb8GaFDbCpvDSV33WR
+9lXFJCKndoALgPUTh0wkR2cNKecX8FKNo81CROzquzhZ8EizcqEHNK5Wnixci+7
BDSY4fks5FN51Lly85o37PJWgHRRJZ9ZL+Bv9Jh3oFWgjXH83dZONyHqgxK2XoP1
ARnTvuho/gWnv/VSWNx40mOXv53WxLSG4Xe4yZRLg5mG7h2YPFldIZk/ppfuGWdK
ldLnRU943jOPp8Q036tBM4msT+Pa/0uXQcGz5Th/ALHDbDatvIhvaBavYF9TXOaR
QQiupJN+KjZ9d3EYHYSWUfMWq3jngsA6gEPF1EShDApEskqsOklitnkUTYhwmGMC
hUkqYJS6xNcmWr9fBt90MK5/rK3ALPVnxL1D6BfJxXyGR8+t+5YTj09L/KzR25Tn
M3z+dSGOFZDNY/2fplAEsVpr5ynNOeD97m7Q441xjVgpSMadiz0VmYfUXszwX8JJ
VPQZDaeLWfgWhbZ1BIdz2qOzJ57STmgkoRQCDZw/7G7kfRr2fgI103NWK756B5Eh
f4kYcrAmew5a+nyyI1X08z9c3kued+glUJeHLd4r7omxZSb81j94M32bM6bWZNn+
lavbG+LzEA8UVtI8HeWknZkdIGi2eTL4bNLcd3EdBoICGOV9EFs=
=g3yx
-----END PGP SIGNATURE-----

--gqocpd2od3bxsp7n--
