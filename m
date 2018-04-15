Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx48LuwzIxforukg9iTxZlUBDxRsUzxn5BxuGC7vsKkE2Z3Seglb0qcM4rtWpUU/hkrF0rBok
ARC-Seal: i=1; a=rsa-sha256; t=1523804532; cv=none;
        d=google.com; s=arc-20160816;
        b=06wyivZ6z0vY8866rvsjb9swQHZ6S4I/m/Q4IZb7Oz+o+Q1HHX/qIS/K/8+9Zx/7Zw
         e4nHDpY6YyceiA6BuONdixlWwFAuJxIsdW/aVLquKZP0TnAXFgthGfrYWFbuVMrk3voZ
         yp/Buu6//+BlTZuxuVprg7fC9hBYKy18ypkgzzWqtVGbEEeZylO4sE34hT4ZRdA1+SNx
         6zuYLRAmrDt5gzfTLTnoT/hm3cYzBDQDgg2SI0Pav4njh+HQCRD3XKhA9vJMsPGZNe+W
         I93zzpRgZxa0bSiIUbuJlSV9veXzwIF/QDGeJvYwei2kQFNJEbuiIdUQwMmZjghgGXsz
         i5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=myTyCEexbq1mHESjhx141x0o75Ebf5QjvCXsi3pmxjI=;
        b=I7+Cd0WRmDGUL29LOcZdXRHFKFkalmIQUd4YdT3esFkLCThUNEtMGjXm3Qk8c728mj
         HiWfRdyae2Lofod0LQC+IKGfrBAnO6GhP+ryo01aSWVK4/hY2fjfZe+h4aIt0qzF97RQ
         cOlbJ6/3+t5aStsiooPRrnsIc22H0W9JoDwOc/GnKsP+muo86lnHw/pAg4YSc6pA4Oqy
         fg4ef/R9CMk3m1LYUAHw47pR5mKrVFKH0Semdtgh798iicWPvpSZdd3lbVetMi9GLLxt
         bfa/E1j/5BT0DSl0TJhRx4aOPwDF3NOZFP96GiaZv0y4QFx4wptoAlGEoQdvcpGU2AoX
         VM3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A3D20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:02:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] staging: iio: ad7746: Automatically swap
 values in readings/writings
Message-ID: <20180415160207.59f6b698@archlinux>
In-Reply-To: <1523637411-8531-2-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-2-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649678648759937?=
X-GMAIL-MSGID: =?utf-8?q?1597824861480952354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:38 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Data to read or write was being handled with the swab16() macro instead
> of using i2c_smbus_{read,write}_swapped.
>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/a=
d7746.c
> index 4882dbc..53e28ae 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -451,7 +451,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
> =20
> -		ret =3D i2c_smbus_write_word_data(chip->client, reg, swab16(val));
> +		ret =3D i2c_smbus_write_word_swapped(chip->client, reg, val);
>  		if (ret < 0)
>  			goto out;
> =20
> @@ -462,8 +462,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			ret =3D -EINVAL;
>  			goto out;
>  		}
> -		ret =3D i2c_smbus_write_word_data(chip->client,
> -				AD7746_REG_CAP_OFFH, swab16(val));
> +		ret =3D i2c_smbus_write_word_swapped(chip->client,
> +						   AD7746_REG_CAP_OFFH, val);
>  		if (ret < 0)
>  			goto out;
> =20
> @@ -594,21 +594,21 @@ static int ad7746_read_raw(struct iio_dev *indio_de=
v,
>  			goto out;
>  		}
> =20
> -		ret =3D i2c_smbus_read_word_data(chip->client, reg);
> +		ret =3D i2c_smbus_read_word_swapped(chip->client, reg);
>  		if (ret < 0)
>  			goto out;
>  		/* 1 + gain_val / 2^16 */
>  		*val =3D 1;
> -		*val2 =3D (15625 * swab16(ret)) / 1024;
> +		*val2 =3D (15625 * ret) / 1024;
> =20
>  		ret =3D IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		ret =3D i2c_smbus_read_word_data(chip->client,
> -					       AD7746_REG_CAP_OFFH);
> +		ret =3D i2c_smbus_read_word_swapped(chip->client,
> +						  AD7746_REG_CAP_OFFH);
>  		if (ret < 0)
>  			goto out;
> -		*val =3D swab16(ret);
> +		*val =3D ret;
> =20
>  		ret =3D IIO_VAL_INT;
>  		break;
