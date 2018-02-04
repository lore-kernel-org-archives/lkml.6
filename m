Return-Path: <jic23@jic23.retrosnub.co.uk>
X-Google-Smtp-Source: AH8x226wVnrVld6ypuqMeNQEpa6xZn/aAPSqgcnVI6T/VQS570w+fYIhwsM39V7PvNBPM0s4gSAa
ARC-Seal: i=1; a=rsa-sha256; t=1517779373; cv=none;
        d=google.com; s=arc-20160816;
        b=Oqqkg1CWqz3SsoGPVbKOb5fWI3ZHSzOUG4qWa+otuQIVWWxWE63LMbbj74hvU5fRh1
         JnoxSm+SVoZtdweUfSV0MfjQ6FsUFGumCliHNqzYEff6d6zemaqdDt1SJIPH3fwDtXxC
         ny5iZYRSDORuXG9VrdHXoApfDYS2l9+zIVrM606MNp7/T7ZialninnsFqHhKoA48QExy
         J2f8esPcLsL6bR1VqYyBXH24+HbeqQx7tbAAoR5EFEZGVM15SnZkOXTVOcexRHfccclk
         f3DnLNgJElJopUn2hpSHriWIwgDUTMy3cfHBgQJR5hFJolAVp7i79mvUjEsBqjTMYi4i
         0F2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:content-transfer-encoding
         :mime-version:references:in-reply-to:user-agent:date
         :arc-authentication-results;
        bh=7OlFV5VL8nsgvjyh6IrYvoIVopfgdholtTlZiweyLZc=;
        b=iAvE7JviePLCcHeZ6212AB4mRBKC7PC0w9uJXBL1cP4QF+xf+04KaU7RncI3AIUHe5
         3G46+nIdl+a8FSm/8TDr0zF2RLgnCcpJ5WzwMilpPquDeK2oAXO099hz7EIilHZ3oy2W
         Ff+mWkykT3mMC01QT/tRZuID8ultpWP8t6k1qz7KI+NzT9Q7OtSRB/jXZJLUFw1bSv5N
         5D1Da0o5QOAl6kye2fB1BPSWF0Gh9jqzMT5TCtRMjx//kE8ObXnA+Bk7KNhsATuf7vvu
         nHVWQm6C6tPtc7zAg0/6ZbPTg4C0mgZfqiklhtnnUYgaTX3UslrwDC7N3li+EwQe9Evu
         9Plw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jic23@jic23.retrosnub.co.uk designates 178.18.118.26 as permitted sender) smtp.mailfrom=jic23@jic23.retrosnub.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jic23@jic23.retrosnub.co.uk designates 178.18.118.26 as permitted sender) smtp.mailfrom=jic23@jic23.retrosnub.co.uk
Date: Sun, 04 Feb 2018 21:22:47 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <1517778185.2292.10.camel@gmail.com>
References: <1517671892-4045-1-git-send-email-shreeya.patel23498@gmail.com> <20180204111022.0e6d08f6@archlinux> <1517778185.2292.10.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] Staging: iio: ade7758: Expand buf_lock to cover both buffer and state protection
To: Shreeya Patel <shreeya.patel23498@gmail.com>,Jonathan Cameron <jic23@kernel.org>
CC: lars@metafoo.de,Michael.Hennerich@analog.com,knaack.h@gmx.de,pmeerw@pmeerw.net,gregkh@linuxfoundation.org,linux-iio@vger.kernel.org,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DB5C46AC-0A4E-4C0F-A80F-F730E8A21DAD@jic23.retrosnub.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591394340588810531?=
X-GMAIL-MSGID: =?utf-8?q?1591507023590717674?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4 February 2018 21:03:05 GMT, Shreeya Patel <shreeya=2Epatel23498@gmail=
=2Ecom> wrote:
>On Sun, 2018-02-04 at 11:10 +0000, Jonathan Cameron wrote:
>> On Sat,=C2=A0=C2=A03 Feb 2018 21:01:32 +0530
>> Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom> wrote:
>>=20
>> >=20
>> > iio_dev->mlock is to be used only by the IIO core for protecting
>> > device mode changes between INDIO_DIRECT and INDIO_BUFFER=2E
>> >=20
>> > This patch replaces the use of mlock with the already established
>> > buf_lock mutex=2E
>> >=20
>> > Introducing 'unlocked' forms of read and write registers=2E The
>> > read/write frequency functions now require buf_lock to be held=2E
>> > That's not obvious so avoid this but moving the locking inside
>> > the functions where it is then clear that they are taking the
>> > unlocked forms of the register read/write=2E
>> >=20
>> > It isn't readily apparent that write frequency function requires
>> > the locks to be taken, so move it inside the function to where it
>> > is required to protect=2E
>> >=20
>> > Signed-off-by: Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom>
>> Hi Shreeya,
>>=20
>Hello sir,
>
>> Unfortunately this introduces a new bug - you end up unlocking
>> a mutex that you never locked in one of the error paths=2E
>> See inline=2E
>I'll make this change=2E
>>=20
>> We are also still taking the mlock around the read of the
>> frequency which doesn't make any sense given there is
>> no reason to protect that against state changes=2E
>> Arguably fixing that could be a separate patch as it never
>> made much sense, but it should probably be in this same series
>> at least=2E=C2=A0=C2=A0I would have no real problem with it being in it=
 this
>> same patch as long as the description above mentions it=2E
>>=20
>> Thanks,
>>=20
>> Jonathan
>>=20
>> >=20
>> > ---
>> >=20
>> > Changes in v2
>> > =C2=A0 -Add static keyword to newly introduced functions and remove s=
ome
>> > added comments which are not required=2E
>> >=20
>> > Changes in v3
>> > =C2=A0 -Remove some useless mlocks and send it as another patch=2E
>> > Also make the necessary change in the current patch associated
>> > with=C2=A0
>> > the new patch with commit id 88eba33=2E Make commit message more=C2=
=A0
>> > appropriate=2E
>> >=20
>> > Changes in v4
>> > =C2=A0 -Write frequency function do not require lock so move it insid=
e
>> > the function to where it is required to protect=2E
>> >=20
>> >=20
>> > =C2=A0drivers/staging/iio/meter/ade7758=2Eh=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A02 +-
>> > =C2=A0drivers/staging/iio/meter/ade7758_core=2Ec | 49
>> > ++++++++++++++++++++++++--------
>> > =C2=A02 files changed, 38 insertions(+), 13 deletions(-)
>> >=20
>> > diff --git a/drivers/staging/iio/meter/ade7758=2Eh
>> > b/drivers/staging/iio/meter/ade7758=2Eh
>> > index 6ae78d8=2E=2E2de81b5 100644
>> > --- a/drivers/staging/iio/meter/ade7758=2Eh
>> > +++ b/drivers/staging/iio/meter/ade7758=2Eh
>> > @@ -111,7 +111,7 @@
>> > =C2=A0 * @trig:		data ready trigger registered with iio
>> > =C2=A0 * @tx:			transmit buffer
>> > =C2=A0 * @rx:			receive buffer
>> > - * @buf_lock:		mutex to protect tx and rx
>> > + * @buf_lock:		mutex to protect tx, rx, read and
>> > write frequency
>> > =C2=A0 **/
>> > =C2=A0struct ade7758_state {
>> > =C2=A0	struct spi_device	*us;
>> > diff --git a/drivers/staging/iio/meter/ade7758_core=2Ec
>> > b/drivers/staging/iio/meter/ade7758_core=2Ec
>> > index 227dbfc=2E=2Eff19d46 100644
>> > --- a/drivers/staging/iio/meter/ade7758_core=2Ec
>> > +++ b/drivers/staging/iio/meter/ade7758_core=2Ec
>> > @@ -24,17 +24,25 @@
>> > =C2=A0#include "meter=2Eh"
>> > =C2=A0#include "ade7758=2Eh"
>> > =C2=A0
>> > -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8
>> > val)
>> > +static int __ade7758_spi_write_reg_8(struct device *dev, u8
>> > reg_address, u8 val)
>> > =C2=A0{
>> > -	int ret;
>> > =C2=A0	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> > =C2=A0	struct ade7758_state *st =3D iio_priv(indio_dev);
>> > =C2=A0
>> > -	mutex_lock(&st->buf_lock);
>> > =C2=A0	st->tx[0] =3D ADE7758_WRITE_REG(reg_address);
>> > =C2=A0	st->tx[1] =3D val;
>> > =C2=A0
>> > -	ret =3D spi_write(st->us, st->tx, 2);
>> > +	return spi_write(st->us, st->tx, 2);
>> > +}
>> > +
>> > +int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8
>> > val)
>> > +{
>> > +	int ret;
>> > +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> > +	struct ade7758_state *st =3D iio_priv(indio_dev);
>> > +
>> > +	mutex_lock(&st->buf_lock);
>> > +	ret =3D __ade7758_spi_write_reg_8(dev, reg_address, val);
>> > =C2=A0	mutex_unlock(&st->buf_lock);
>> > =C2=A0
>> > =C2=A0	return ret;
>> > @@ -91,7 +99,7 @@ static int ade7758_spi_write_reg_24(struct device
>> > *dev, u8 reg_address,
>> > =C2=A0	return ret;
>> > =C2=A0}
>> > =C2=A0
>> > -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8
>> > *val)
>> > +static int __ade7758_spi_read_reg_8(struct device *dev, u8
>> > reg_address, u8 *val)
>> > =C2=A0{
>> > =C2=A0	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> > =C2=A0	struct ade7758_state *st =3D iio_priv(indio_dev);
>> > @@ -111,7 +119,6 @@ int ade7758_spi_read_reg_8(struct device *dev,
>> > u8 reg_address, u8 *val)
>> > =C2=A0		},
>> > =C2=A0	};
>> > =C2=A0
>> > -	mutex_lock(&st->buf_lock);
>> > =C2=A0	st->tx[0] =3D ADE7758_READ_REG(reg_address);
>> > =C2=A0	st->tx[1] =3D 0;
>> > =C2=A0
>> > @@ -124,7 +131,19 @@ int ade7758_spi_read_reg_8(struct device *dev,
>> > u8 reg_address, u8 *val)
>> > =C2=A0	*val =3D st->rx[0];
>> > =C2=A0
>> > =C2=A0error_ret:
>> > +	return ret;
>> > +}
>> > +
>> > +int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8
>> > *val)
>> > +{
>> > +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
>> > +	struct ade7758_state *st =3D iio_priv(indio_dev);
>> > +	int ret;
>> > +
>> > +	mutex_lock(&st->buf_lock);
>> > +	ret =3D __ade7758_spi_read_reg_8(dev, reg_address, val);
>> > =C2=A0	mutex_unlock(&st->buf_lock);
>> > +
>> > =C2=A0	return ret;
>> > =C2=A0}
>> > =C2=A0
>> > @@ -480,10 +499,12 @@ static int ade7758_read_samp_freq(struct
>> > device *dev, int *val)
>> > =C2=A0	return 0;
>> > =C2=A0}
>> > =C2=A0
>> > -static int ade7758_write_samp_freq(struct device *dev, int val)
>> > +static int ade7758_write_samp_freq(struct iio_dev *indio_dev, int
>> > val)
>> > =C2=A0{
>> > =C2=A0	int ret;
>> > =C2=A0	u8 reg, t;
>> > +	struct ade7758_state *st =3D iio_priv(indio_dev);
>> > +	struct device *dev =3D &indio_dev->dev;
>> > =C2=A0
>> > =C2=A0	switch (val) {
>> > =C2=A0	case 26040:
>> > @@ -503,16 +524,20 @@ static int ade7758_write_samp_freq(struct
>> > device *dev, int val)
>> > =C2=A0		goto out;
>> This goto out results in an unlock but the lock hasn't been locked
>> for a few more lines=2E=2E=2E
>>=20
>> Change this to a direct return here rather than a goto to fix this=2E
>> return -EINVAL;
>>=20
>> >=20
>> > =C2=A0	}
>> > =C2=A0
>> > -	ret =3D ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
>> > +	mutex_lock(&st->buf_lock);
>> > +
>> > +	ret =3D __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE,
>> > &reg);
>> > =C2=A0	if (ret)
>> > =C2=A0		goto out;
>
>Here, can I move the above lock after the calling of the read register
>but before the if(ret) statement?
>With this we can avoid locks over the read cases=2E
>Mostly, this shouldn't create any problem but yet I thought of first
>confirming it from you=2E

Don't do that=2E We need to protect against another caller doing that read=
 before the write is done=2E
>
>Thank you=C2=A0
>
>> > =C2=A0
>> > =C2=A0	reg &=3D ~(5 << 3);
>> > =C2=A0	reg |=3D t << 5;
>> > =C2=A0
>> > -	ret =3D ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
>> > +	ret =3D __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE,
>> > reg);
>> > =C2=A0
>> > =C2=A0out:
>> > +	mutex_unlock(&st->buf_lock);
>> > +
>> > =C2=A0	return ret;
>> > =C2=A0}
>> > =C2=A0
>> > @@ -545,9 +570,9 @@ static int ade7758_write_raw(struct iio_dev
>> > *indio_dev,
>> > =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
>> > =C2=A0		if (val2)
>> > =C2=A0			return -EINVAL;
>> > -		mutex_lock(&indio_dev->mlock);
>> > -		ret =3D ade7758_write_samp_freq(&indio_dev->dev,
>> > val);
>> > -		mutex_unlock(&indio_dev->mlock);
>> > +
>> > +		ret =3D ade7758_write_samp_freq(indio_dev, val);
>> > +
>> > =C2=A0		return ret;
>> > =C2=A0	default:
>> > =C2=A0		return -EINVAL;
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
