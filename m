Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4/aEWe3CMOl5LSUFIQqgtdB4zsB2Wv0uH1qZrNStC3G1M1OV4WgnJ4kvwSKhltCXcbCtzhH
ARC-Seal: i=1; a=rsa-sha256; t=1523805554; cv=none;
        d=google.com; s=arc-20160816;
        b=Vk2f3QwYyvy/EKuYVZ2zB4TrnEWz4X6oF3G56LDT4hqSP5unO1ycUmoAcnagR1eZfB
         Xpq1+1dLKIkeE7qhp/M8IU+fBXJ197wl7f/3g39BkTkc9tv/Nc2TV8g+pDRQcuPDQv3Z
         1WYfJFArAlIF9LNh/ZS72tOa0TgA6Y51+TVH9IqxAkwcnppp5skV33FV2z3+mXR3WD4Z
         Pz5c5wiAWld/4E/4Q/B/7TSK5XssqNUDX8sLFn0+NLw31RoH+RMwciLCvpRt2E43zrDz
         HXFfocsLnTrWHSCjjqSfs9DLIPcp47H4P0fM0kM23ArP2yKGu+ufTC92SHkA84t5SwNM
         H7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=Hu9tiiO1Cs3e0ZYXNOR7FSWOeZjWzmcDLBgjXRUasWk=;
        b=ssqDbnkudWkePnoPophMW5a5pLLT5icCW3V1cqZlHbZxkyt/S2/xiLt7N1zWr67ymw
         lNthxGpIt46qjR7lWH2jcIoVuNhFQyGYCFME35VS2bdeeFIYwn7s39UirhAJATmO8nQH
         1jpLh5iSOLjkISnfN5yThduV+5Ja0meWR71rSD7AnYcCu5SUz+rdThjcpSKf3Q8TgjrT
         4uLmep/amND4SaYYiEbEBvBRuug9uPkSHDx5hYQ5AjLwA6NsmWUBrRQJhBNBgQ9nHW4W
         T/ddr65TbJGsc24DL5suA/ys5k5Hx2JNN0kNWxPNefRMMgoUi8SZngHoZ73r+zvIODPu
         qnmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B63206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:19:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] staging: iio: ad7746: Add dt-bindings
Message-ID: <20180415161909.34877620@archlinux>
In-Reply-To: <1523637411-8531-9-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-9-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649726803282916?=
X-GMAIL-MSGID: =?utf-8?q?1597825933464341727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:45 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> This patch adds dt bindings by populating a pdata struct in order to
> modify as little as possible the existing code. It supports both
> platform_data and dt-bindings but uses only one depending on
> CONFIG_OF's value.
>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>

Please reorder the patches in the next version to put the bindings
patch next to this one (before preferably, but after is fine as
well.)

Hmm. I can see why you want to minimize the effect of the older
code, but given that we will probably (eventually) drop the
platform data option, I wonder if it wouldn't be better
to move the data to a sensible location rather than faking
platform_data.

The pdata is only used in probe and only two bits of
it at that so it would be fine to use some local variables and
fill them from platform data or device tree as appropriate.

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 54 ++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index d39ab34..c29a221 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -666,6 +666,43 @@ static const struct iio_info ad7746_info =3D {
>  /*
>   * device probe and remove
>   */
> +#ifdef CONFIG_OF
> +static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> +{
> +	struct device_node *np =3D dev->of_node;
> +	struct ad7746_platform_data *pdata;
> +	unsigned int tmp;
> +	int ret;
> +
> +	/* The default excitation outputs are not inverted, it should be stated
Please use standard multiline comment syntax.

/*
 * The...
 */
> +	 * in the dt if needed.
> +	 */
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	ret =3D of_property_read_u32(np, "adi,exclvl", &tmp);
> +	if (ret || tmp > 3) {
> +		dev_warn(dev, "Wrong exclvl value, using default\n");

Seems a little odd to have the check in here rather than generic.

> +		pdata->exclvl =3D 3; /* default value */
> +	} else {
> +		pdata->exclvl =3D tmp;
> +	}
> +
> +	pdata->exca_en =3D true;
> +	pdata->excb_en =3D true;
> +	pdata->exca_inv_en =3D of_property_read_bool(np, "adi,nexca_en");
> +	pdata->excb_inv_en =3D of_property_read_bool(np, "adi,nexcb_en");
> +
> +	return pdata;
> +}
> +#else
> +static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> =20
>  static int ad7746_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
> @@ -676,6 +713,11 @@ static int ad7746_probe(struct i2c_client *client,
>  	unsigned char regval =3D 0;
>  	int ret =3D 0;
> =20
> +	if (client->dev.of_node)
> +		pdata =3D ad7746_parse_dt(&client->dev);
> +	else
> +		pdata =3D client->dev.platform_data;
> +
>  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -739,12 +781,22 @@ static const struct i2c_device_id ad7746_id[] =3D {
>  	{ "ad7747", 7747 },
>  	{}
>  };
> -
>  MODULE_DEVICE_TABLE(i2c, ad7746_id);
> =20
> +#ifdef CONFIG_OF
> +static const struct of_device_id ad7746_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7745" },
> +	{ .compatible =3D "adi,ad7746" },
> +	{ .compatible =3D "adi,ad7747" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7746_of_match);
> +#endif
> +
>  static struct i2c_driver ad7746_driver =3D {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
> +		.of_match_table =3D of_match_ptr(ad7746_of_match),
>  	},
>  	.probe =3D ad7746_probe,
>  	.id_table =3D ad7746_id,
