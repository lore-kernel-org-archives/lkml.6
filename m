Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B299AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D3620867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="odfpNRVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D3620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeKYV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 16:59:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeKYV7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 16:59:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605FC20855;
        Sun, 25 Nov 2018 11:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543144124;
        bh=GIEtklm0N5P5qr+IzcaKqDZ08yG7u8cVtaAwGDUbbCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=odfpNRVVbjHDW5rgbQ+y017McagTN9jDTkZgc3UZsUvP7wYC665LnQq42DKQ03c0x
         xmLhBpvOGy0t9rDwhAigcs29ujCwHMlqxFMcg6bqDLI4k2vHjVIcZ/IEmHKdnFH8v0
         1Ka35lLOXKNqTa9cn+ZSzZbfKGnrsDTSuhOCXwyc=
Date:   Sun, 25 Nov 2018 11:08:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <20181125110839.4a3aecf9@archlinux>
In-Reply-To: <1542884458.30645.22.camel@analog.com>
References: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
        <1542884458.30645.22.camel@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 11:01:00 +0000
"Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote:

> On Mi, 2018-11-21 at 16:04 -0200, Giuliano Belinassi wrote:
> > Previously, the AD7780 driver only supported gpio for the 'powerdown'
> > pin. This commit adds suppport for the 'gain' and 'filter' pin. =20
> Hey,
>=20
> Comments inline.
> >=20
> > Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> > ---
> > =C2=A0drivers/staging/iio/adc/ad7780.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 61 ++++++++++++++++++++++++--
> > =C2=A0include/linux/iio/adc/ad_sigma_delta.h |=C2=A0=C2=A05 +++
> > =C2=A02 files changed, 62 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index c4a85789c2db..69794f06dbcd 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -39,6 +39,9 @@
> > =C2=A0#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
> > =C2=A0#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 |
> > AD7170_PAT2)
> > =C2=A0
> > +#define AD7780_GAIN_GPIO	0
> > +#define AD7780_FILTER_GPIO	1
> > +
> > =C2=A0struct ad7780_chip_info {
> > =C2=A0	struct iio_chan_spec	channel;
> > =C2=A0	unsigned int		pattern_mask;
> > @@ -50,6 +53,8 @@ struct ad7780_state {
> > =C2=A0	const struct ad7780_chip_info	*chip_info;
> > =C2=A0	struct regulator		*reg;
> > =C2=A0	struct gpio_desc		*powerdown_gpio;
> > +	struct gpio_desc		*gain_gpio;
> > +	struct gpio_desc		*filter_gpio;
> > =C2=A0	unsigned int	gain;
> > =C2=A0
> > =C2=A0	struct ad_sigma_delta sd;
> > @@ -115,18 +120,51 @@ static int ad7780_read_raw(struct iio_dev
> > *indio_dev,
> > =C2=A0	return -EINVAL;
> > =C2=A0}
> > =C2=A0
> > +static int ad7780_write_raw(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0struct iio_chan_spec const *chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0int val,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0int val2,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0long m)
> > +{
> > +	struct ad7780_state *st =3D iio_priv(indio_dev);
> > +
> > +	if (m !=3D IIO_CHAN_INFO_RAW)
> > +		return -EINVAL;
> > +
> > +	if (st->chip_info->is_ad778x) {
> > +		switch(val) {
> > +		case AD7780_GAIN_GPIO: =20
>=20
> I think that instead of setting the gain directly, we should use
> the=C2=A0IIO_CHAN_INFO_SCALE attribute. At page 12 of the ad7780 datashee=
t there
> is a formula from which the output code can be calculated:
> Code =3D 2^(N =E2=88=92 1)
> =C3=97 [(AIN =C3=97 Gain /VREF) + 1]. So, by setting the scale from user =
space, the
> driver can calculate the correct gain by using the formula above. Also, it
> would be useful to introduce scale available.
> Furthermore, there is a new
> ad7124 adc driver which does this exact thing. Take a look here:=C2=A0htt=
ps://gi
> thub.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ad7124.c#L337.
>=20
> > +			gpiod_set_value(st->gain_gpio, val2);
> > +		break;
> > +		case AD7780_FILTER_GPIO: =20
>=20
> The attribute that should be used to configure the filter gpio is
> IIO_CHAN_INFO_SAMP_FREQ. So, we should have 10 Hz and 16.7 Hz available
> sampling frequencies. If from user space the 10 Hz sampling freq is
> requested, then we set the FILTER pin high, while for 16.7 Hz the FILTER
> pin will be low.

Absolutely agreed with Stefan here.  If it had been decoupled from sampling
frequency (sometimes they are) then we have specific controls for filters
as well.  Here it directly effects the sampling frequency.

Please in future avoid any driver specific control like you have here.
I haven't really worked out what the interface is beyond some sort
of bitmap passed through a write to a magic channel?

If there isn't an existing interface in IIO for what you want to do
please propose one rather than doing something that will only work
with a particular userspace.  One of the primary purposes of having
a subsystem is to standardise interfaces.  This definitely doesn't
do that!

Will be good to have the support along the lines Stefan suggested though!

Thanks,

Jonathan



>=20
> > +			gpiod_set_value(st->filter_gpio, val2);
> > +		break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > =C2=A0static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma=
_delta,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int raw_sample)
> > =C2=A0{
> > =C2=A0	struct ad7780_state *st =3D ad_sigma_delta_to_ad7780(sigma_delta=
);
> > =C2=A0	const struct ad7780_chip_info *chip_info =3D st->chip_info;
> > +	int val;
> > =C2=A0
> > =C2=A0	if ((raw_sample & AD7780_ERR) ||
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0((raw_sample & chip_info->pattern_mask) =
!=3D chip_info- =20
> > >pattern)) =20
> > =C2=A0		return -EIO;
> > =C2=A0
> > =C2=A0	if (chip_info->is_ad778x) {
> > -		if (raw_sample & AD7780_GAIN)
> > +		val =3D raw_sample & AD7780_GAIN;
> > +
> > +		if (val !=3D gpiod_get_value(st->gain_gpio))
> > +			return -EIO;
> > +
> > +		if (val)
> > =C2=A0			st->gain =3D 1;
> > =C2=A0		else
> > =C2=A0			st->gain =3D 128;
> > @@ -141,18 +179,20 @@ static const struct ad_sigma_delta_info
> > ad7780_sigma_delta_info =3D {
> > =C2=A0	.has_registers =3D false,
> > =C2=A0};
> > =C2=A0
> > -#define AD7780_CHANNEL(bits, wordsize) \
> > +#define AD7170_CHANNEL(bits, wordsize) \
> > =C2=A0	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
> > +#define AD7780_CHANNEL(bits, wordsize) \
> > +	AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
> > =C2=A0
> > =C2=A0static const struct ad7780_chip_info ad7780_chip_info_tbl[] =3D {
> > =C2=A0	[ID_AD7170] =3D {
> > -		.channel =3D AD7780_CHANNEL(12, 24),
> > +		.channel =3D AD7170_CHANNEL(12, 24),
> > =C2=A0		.pattern =3D AD7170_PATTERN,
> > =C2=A0		.pattern_mask =3D AD7170_PATTERN_MASK,
> > =C2=A0		.is_ad778x =3D false,
> > =C2=A0	},
> > =C2=A0	[ID_AD7171] =3D {
> > -		.channel =3D AD7780_CHANNEL(16, 24),
> > +		.channel =3D AD7170_CHANNEL(16, 24),
> > =C2=A0		.pattern =3D AD7170_PATTERN,
> > =C2=A0		.pattern_mask =3D AD7170_PATTERN_MASK,
> > =C2=A0		.is_ad778x =3D false,
> > @@ -173,6 +213,7 @@ static const struct ad7780_chip_info
> > ad7780_chip_info_tbl[] =3D {
> > =C2=A0
> > =C2=A0static const struct iio_info ad7780_info =3D {
> > =C2=A0	.read_raw =3D ad7780_read_raw,
> > +	.write_raw =3D ad7780_write_raw,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static int ad7780_probe(struct spi_device *spi)
> > @@ -222,6 +263,18 @@ static int ad7780_probe(struct spi_device *spi)
> > =C2=A0		goto error_disable_reg;
> > =C2=A0	}
> > =C2=A0
> > +	if (st->chip_info->is_ad778x) {
> > +		st->gain_gpio =3D devm_gpiod_get_optional(&spi->dev,
> > +							"gain",
> > +							GPIOD_OUT_HIGH);
> > +		if (IS_ERR(st->gain_gpio)) {
> > +			ret =3D PTR_ERR(st->gain_gpio);
> > +			dev_err(&spi->dev, "Failed to request gain GPIO:
> > %d\n",
> > +				ret);
> > +			goto error_disable_reg;
> > +		}
> > +	}
> > +
> > =C2=A0	ret =3D ad_sd_setup_buffer_and_trigger(indio_dev);
> > =C2=A0	if (ret)
> > =C2=A0		goto error_disable_reg;
> > diff --git a/include/linux/iio/adc/ad_sigma_delta.h
> > b/include/linux/iio/adc/ad_sigma_delta.h
> > index 730ead1a46df..6cadab6fd5fd 100644
> > --- a/include/linux/iio/adc/ad_sigma_delta.h
> > +++ b/include/linux/iio/adc/ad_sigma_delta.h
> > @@ -173,6 +173,11 @@ int ad_sd_validate_trigger(struct iio_dev
> > *indio_dev, struct iio_trigger *trig);
> > =C2=A0	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> > =C2=A0		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
> > =C2=A0
> > +#define AD_SD_CHANNEL_GAIN_FILTER(_si, _channel, _address, _bits, \
> > +	_storagebits, _shift) \
> > +	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> > +		_storagebits, _shift, NULL, IIO_VOLTAGE,
> > BIT(IIO_CHAN_INFO_RAW))
> > +
> > =C2=A0#define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _s=
hift) \
> > =C2=A0	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
> > =C2=A0		_storagebits, _shift, NULL, IIO_TEMP,  =20

