Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+U0NMY6OXff8++N7YwReNq6ie43yg/tK9pEF4yGusiK0f1yYMrYvQFBA+Nm2+upsg2laz7
ARC-Seal: i=1; a=rsa-sha256; t=1523806267; cv=none;
        d=google.com; s=arc-20160816;
        b=whVEMe0pmFpS51DlnKCOzBkvOQbCwxPCPwRTtraFJ8K2ohNkMs2hJbNlZg68w6FX71
         MWz+flnH4CzUAKRC9WlBqm3eUOWVyaVnUJTjAZzZ9+yeE+1K3WtwUa7WAiuF8Rcd/cD8
         dsoIU/wAcyGUTdAB3uVGJ/E6hFhGJC5ifF9tCwL8nlykHcyWq9UX8nG6C7B3UCiSvy3c
         e8M+s5EaPC0L8TVzpgRdT6SzjZlf8LxyMmc+gt9S17xjuSEksLHg0Y/3C3BojSjXYsuo
         I6c/7V7rRGsRxa8JyLsiUbeRJoaZRTRPshYZvj71qkAjgYejThUQSAtoBlvL162I9WKp
         AuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=8VdgWMXDcxCe87yaCEmogVQgi6iREpwQrUtjZfAwi9M=;
        b=t16VHdiIinEaq1y9Qpfz7BOTMTy0wWAXNQ5722+exWxVExIZ+CFIdQyv5Ukq7s+MTf
         cktCJuZcxRvdtJT81HEj7XBDCjC3FVqWHTtdchDtLNuhDqZUsubV8wKMjwFtNgW2eMKL
         I+Xg2Jy3acADdLgQLvQIuTRa+7VCo9AYda9hlqVgBwUXRujh1u0cn2g2fhRJBMkmjT5+
         z9ClkMCT3e+hc6FROWGsShKk1yytb3OP0jKlb1xGG8fhSW1+Klcu8Rn1P948xQ4dRMY8
         PjMAuWHzGbcoNb7zKuptyoM2L6DTojnUVzqDt47vbRSwGbRShQOQBjOoLBDeudWHsmOp
         SSIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C98E2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:31:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] staging: iio: ad7746: Add remove()
Message-ID: <20180415163101.6ab15cbc@archlinux>
In-Reply-To: <1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-10-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649731441296741?=
X-GMAIL-MSGID: =?utf-8?q?1597826680342168603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:46 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> This allows the driver to be probed and removed as a module powering it
> down on remove().
>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index c29a221..05506bf9 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -775,6 +775,31 @@ static int ad7746_probe(struct i2c_client *client,
>  	return 0;
>  }
> =20
> +static int ad7746_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +	struct ad7746_chip_info *chip =3D iio_priv(indio_dev);
> +	unsigned char regval;
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	regval =3D chip->config | AD7746_CONF_MODE_PWRDN;
> +	ret =3D i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
As this is a one off operation, perhaps it would be better to factor
it out to a utility function then use devm_add_action_or_reset in
the probe?

Also, I am nervous about this change as there doesn't seem to be
path in probe by which this is deliberately reversed?
It seems to be 'accidentally' handled by the read_raw write to the
CFG register.

The data sheet doesn't really mention much about this register
at all.  It may have special requirements to exit from power down - I have
no idea, but if it is costless, why do we bother with idle mode?

Perhaps Michael can confirm if this is safe to do or not.


> +
> +	mutex_unlock(&chip->lock);
> +
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "Could NOT Power Down!\n");
> +		goto out;
> +	}
> +
> +	iio_device_unregister(indio_dev);
You can't safely do this against the devm_iio_device_register.

> +
> +out:
> +	return ret;
> +}
> +
>  static const struct i2c_device_id ad7746_id[] =3D {
>  	{ "ad7745", 7745 },
>  	{ "ad7746", 7746 },
> @@ -799,6 +824,7 @@ static struct i2c_driver ad7746_driver =3D {
>  		.of_match_table =3D of_match_ptr(ad7746_of_match),
>  	},
>  	.probe =3D ad7746_probe,
> +	.remove =3D ad7746_remove,
>  	.id_table =3D ad7746_id,
>  };
>  module_i2c_driver(ad7746_driver);
