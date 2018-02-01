Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AH8x225is/zCnS5UVWkXIMVcNDkbbCh+6CAlMbjXEsieAhsH1B4ANkdEM0Hizb7kaQEvJIEfLGBq
ARC-Seal: i=1; a=rsa-sha256; t=1517478838; cv=none;
        d=google.com; s=arc-20160816;
        b=tpuhKAU8yYXv+CHs9FGiL5uKP85wbNlxTVHOd6XydlwI1EjoHCS4Y3+skbHkLQAk/4
         IOAPUXgCvXx7zQffhVkEwmEQ/Ea5trr+rVrbG6mKofGXo6dqWpCeosnPGYqisSYaPtBj
         QhugQRlu3dtNJXGLIADnQG893q1AY3Rc9Au2P56VSjkPf7IMjLn/aN3hZKB/Qm7kLp29
         mQZqEeNcEOUa7/S/xQVmw8pVDkj05IB/UAtQG96/epiMPIHQWTH2AfkVNKCQ2SzLxpxL
         J9AIsEc72a+GbwlQ6VZtJ6zIn/RbhveqD84woEPCNDC97DjB5/PcWoavyVKAad2DPm/8
         eGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=59p7ieuMGw5DGsE3jhBqI/KkvpWwM115mHGoFtLbdPo=;
        b=l5ktmu7mhkdCM+OP3ycozEQCy5U6pHLehzuyxsP0bVePoxPeyGvYdIUiPM3A0fIx4e
         NW5BG+Hsu/tYpCgknhJm26O8U0NcfAJtAc23tUw4woRw6gJFD25EEg8bm/6c3NJvRk3N
         Ee4Mvm58Hbpl3xT+bfv9Nifxh1zPTukaEdwP4lSKzaxiPtGMtwkLpsZOGxFaKgeUtTUy
         v+U5+VgBQnbEqt57tVzE2bppC4yTyPNPVVqpbouJberiLatUazvierAapMUGGwAwuqtQ
         zN8gD1SG1zgcxg4PTt/n6j+8Yqo0u6+e5hRq5+m+ZgOCi3FjplKo5kvYtjQBxV0Mho08
         ANhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Thu, 1 Feb 2018 09:53:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Staging: iio: ade7758: Expand buf_lock to cover both
 buffer and state protection
Message-ID: <20180201095303.000066b2@huawei.com>
In-Reply-To: <1517335217-6163-1-git-send-email-shreeya.patel23498@gmail.com>
References: <1517335217-6163-1-git-send-email-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591041300601619369?=
X-GMAIL-MSGID: =?utf-8?q?1591191891185957372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 30 Jan 2018 23:30:17 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> iio_dev->mlock is to be used only by the IIO core for protecting
> device mode changes between INDIO_DIRECT and INDIO_BUFFER.
> 
> This patch replaces the use of mlock with the already established
> buf_lock mutex.
> 
> Introducing 'unlocked' forms of read and write registers. The
> read/write frequency functions now require buf_lock to be held.
> That's not obvious so avoid this but moving the locking inside
> the functions where it is then clear that they are taking the
> unlocked forms of the register read/write.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>

Good, this should now work nicely.  I have suggested a further
improvement inline which I think will improve code clarity by
moving the lock to where it is obvious what it is protecting.

Thanks,

Jonathan
> ---
> 
> Changes in v2
>   -Add static keyword to newly introduced functions and remove some
> added comments which are not required.
> 
> Changes in v3
>   -Remove some useless mlocks and send it as another patch.
> Also make the necessary change in the current patch associated with 
> the new patch with commit id 88eba33. Make commit message more 
> appropriate.
> 
> 
>  drivers/staging/iio/meter/ade7758.h      |  2 +-
>  drivers/staging/iio/meter/ade7758_core.c | 40 ++++++++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
> index 6ae78d8..2de81b5 100644
> --- a/drivers/staging/iio/meter/ade7758.h
> +++ b/drivers/staging/iio/meter/ade7758.h
> @@ -111,7 +111,7 @@
>   * @trig:		data ready trigger registered with iio
>   * @tx:			transmit buffer
>   * @rx:			receive buffer
> - * @buf_lock:		mutex to protect tx and rx
> + * @buf_lock:		mutex to protect tx, rx, read and write frequency
>   **/
>  struct ade7758_state {
>  	struct spi_device	*us;
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index 227dbfc..38e5d67 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -24,17 +24,25 @@
>  #include "meter.h"
>  #include "ade7758.h"
>  
> -int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +static int __ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
>  {
> -	int ret;
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7758_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7758_WRITE_REG(reg_address);
>  	st->tx[1] = val;
>  
> -	ret = spi_write(st->us, st->tx, 2);
> +	return spi_write(st->us, st->tx, 2);
> +}
> +
> +int ade7758_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7758_spi_write_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
>  
>  	return ret;
> @@ -91,7 +99,7 @@ static int ade7758_spi_write_reg_24(struct device *dev, u8 reg_address,
>  	return ret;
>  }
>  
> -int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> +static int __ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ade7758_state *st = iio_priv(indio_dev);
> @@ -111,7 +119,6 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  		},
>  	};
>  
> -	mutex_lock(&st->buf_lock);
>  	st->tx[0] = ADE7758_READ_REG(reg_address);
>  	st->tx[1] = 0;
>  
> @@ -124,7 +131,19 @@ int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
>  	*val = st->rx[0];
>  
>  error_ret:
> +	return ret;
> +}
> +
> +int ade7758_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ade7758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->buf_lock);
> +	ret = __ade7758_spi_read_reg_8(dev, reg_address, val);
>  	mutex_unlock(&st->buf_lock);
> +
>  	return ret;
>  }
>  
> @@ -503,14 +522,14 @@ static int ade7758_write_samp_freq(struct device *dev, int val)
>  		goto out;
>  	}
>  
> -	ret = ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
> +	ret = __ade7758_spi_read_reg_8(dev, ADE7758_WAVMODE, &reg);
>  	if (ret)
>  		goto out;
>  
>  	reg &= ~(5 << 3);
>  	reg |= t << 5;
>  
> -	ret = ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
> +	ret = __ade7758_spi_write_reg_8(dev, ADE7758_WAVMODE, reg);
>  
>  out:
>  	return ret;
> @@ -540,14 +559,15 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	int ret;
> +	struct ade7758_state *st = iio_priv(indio_dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (val2)
>  			return -EINVAL;
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->buf_lock);
>  		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
> -		mutex_unlock(&indio_dev->mlock);

Hmm. There is a trade off here between complexity of patch
(this is the minimal version on that side) and neatness of
the result.

It isn't readily apparent that ade7758_write_samp_freq requires the locks
to be taken so I think we should really move them inside the function.
(it's the only function that does other than the obvious unlocked
variants you introduce).

That would mean changing the function definition to take indio_dev
instead of the device pointer.

I think that would be a nice further improvement to the patch.

Thanks,

Jonathan
> +		mutex_unlock(&st->buf_lock);
>  		return ret;
>  	default:
>  		return -EINVAL;
