Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeCXW4d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:56:33 -0400
Received: from sauhun.de ([88.99.104.3]:44726 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbeCXW4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:56:32 -0400
Date: Sat, 24 Mar 2018 23:56:30 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] i2c: i2c-stm32f7: Implement I2C recovery mechanism
Message-ID: <20180324225630.6jen6mvboxbhyp7n@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-7-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5dzygghgbjypbybi"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-7-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dzygghgbjypbybi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:49:00PM +0100, Pierre-Yves MORDRET wrote:
> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
> and releases SCL/SDA signals but preserves I2C registers.
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>   Version history:
>     v1:
>        * Initial
>     v2:
>        * Don't use i2c engine recovery mechanism since driver
>          procedure only recover master and not the slave.

s/recovery/release/ throughout the patch, please. Recovery is really
something else. Also, I think the dev_info's are too noisy in the log
files. I'd think the whole driver could be lifted from quite some
logging...

> ---
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-st=
m32f7.c
> index 91f73e0..9a9c469 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -718,6 +718,20 @@ static void stm32f7_i2c_smbus_reload(struct stm32f7_=
i2c_dev *i2c_dev)
>  	writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
>  }
> =20
> +static int stm32f7_i2c_recover_bus(struct i2c_adapter *i2c_adap)
> +{
> +	struct stm32f7_i2c_dev *i2c_dev =3D i2c_get_adapdata(i2c_adap);
> +
> +	dev_info(i2c_dev->dev, "Trying to recover bus\n");
> +
> +	stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1,
> +			     STM32F7_I2C_CR1_PE);
> +
> +	stm32f7_i2c_hw_config(i2c_dev);
> +
> +	return 0;
> +}
> +
>  static int stm32f7_i2c_wait_free_bus(struct stm32f7_i2c_dev *i2c_dev)
>  {
>  	u32 status;
> @@ -727,12 +741,18 @@ static int stm32f7_i2c_wait_free_bus(struct stm32f7=
_i2c_dev *i2c_dev)
>  					 status,
>  					 !(status & STM32F7_I2C_ISR_BUSY),
>  					 10, 1000);
> +	if (!ret)
> +		return 0;
> +
> +	dev_info(i2c_dev->dev, "bus busy\n");
> +
> +	ret =3D stm32f7_i2c_recover_bus(&i2c_dev->adap);
>  	if (ret) {
> -		dev_dbg(i2c_dev->dev, "bus busy\n");
> -		ret =3D -EBUSY;
> +		dev_err(i2c_dev->dev, "Failed to recover the bus (%d)\n", ret);
> +		return ret;
>  	}
> =20
> -	return ret;
> +	return -EBUSY;
>  }
> =20
>  static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_dev *i2c_dev,
> @@ -1474,6 +1494,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, v=
oid *data)
>  	if (status & STM32F7_I2C_ISR_BERR) {
>  		dev_err(dev, "<%s>: Bus error\n", __func__);
>  		writel_relaxed(STM32F7_I2C_ICR_BERRCF, base + STM32F7_I2C_ICR);
> +		stm32f7_i2c_recover_bus(&i2c_dev->adap);
>  		f7_msg->result =3D -EIO;
>  	}
> =20
> --=20
> 2.7.4
>=20

--5dzygghgbjypbybi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq2154ACgkQFA3kzBSg
KbbawxAAoUJEkzVgRc9G3hSNXNQr+fGgbL2zXJySwNx3ps8EsW22qCM2ROrABtqS
uAy6YJyWoF/bcjlVTK9uHc1Jxv8P2DXQuj8GgCUSpKK+Uh/VoNV/2Pshj5iRIPMo
ZwCWqFUpER11RKW3UDY9wqPiy6+TglI/5KHzaXvfyj4//7haLs9kc8QKg2Juq9uZ
VXCIHrhkekIbHIPDOhh5iASKQ+DsTfb40Jb0K34VFT2hgF8/WGqZnqIJ9zfVFi+6
6NnlbQqGoPmjBe6CUWgXrL510GueMG0/dyeZITlQ5SHI1+LI1NIYleCaAnDSWI1v
/ijL5cfQBPQvkzcSvR3AWLp7pv6/2OqHqLQTxvXOdweb/GovpecRcsKdYFC8rW/Z
o+rgF1iqmg8NkqgLn4FtIcrH/HawIfTHAmU/NFihQZKLqwlET9voizrM0fGUexRN
VrddMntfaFyTkOokeyiylR00egDyRMWhR5ZiYK+OgPxG8QT5l6CbCUSD9He3oVls
d6YZrM2A11o0ScPTloTqMaBPSDedpUojhIkLz0EtjxqdEI4zxAA3INwcko13zByV
+UCMYo3jZ3eI2RrA6uFUAVYlRV+8ftgB8MYxyLF8MaUSrB/l2UX6AfIc7m2F63Z/
S7JJdeYxRspkWdvqeO3yFZt/QW+w4BGniG/ugui+N4oZu+XmHGA=
=sZuR
-----END PGP SIGNATURE-----

--5dzygghgbjypbybi--
