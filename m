Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965216AbeCGUQ6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:16:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965012AbeCGUQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:16:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C78820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:16:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.baluta@nxp.com
Subject: Re: [PATCH] iio: Replace occurrences of magic number 0 by
 IIO_CHAN_INFO_RAW
Message-ID: <20180307201644.4d5e449a@archlinux>
In-Reply-To: <20180306120257.eo6kh3b65qmpotoe@smtp.gmail.com>
References: <20180306120257.eo6kh3b65qmpotoe@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 09:02:57 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> Usually, functions responsible for reading raw data typically relies on
> values from iio_chan_info_enum to correctly identify the type of data to
> be read. There is a set of a device driver that uses the magic number 0
> instead of IIO_CHAN_INFO_RAW. This patch improves the readability by
> replaces the magic number 0 for the appropriate IIO_CHAN_INFO_RAW in six
> devices driver in the IIO subsystem.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Just for reference this is a result of a weird piece of history
where 0 used to be deliberately not in the enum (also the reason
the variable is called mask in a lot of drivers which doesn't
make all that much sense.)  We used to pass through bit mask
with just one bit ever set.  Hence 0 was spcial.

Anyhow, good to clear these up.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
>  drivers/iio/dac/ad5380.c                | 2 +-
>  drivers/iio/dac/ad5764.c                | 2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c   | 2 +-
>  drivers/iio/light/hid-sensor-als.c      | 2 +-
>  drivers/iio/light/lm3533-als.c          | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index c066a3bdbff7..41d97faf5013 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -155,7 +155,7 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>  	*val = 0;
>  	*val2 = 0;
>  	switch (mask) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		hid_sensor_power_state(&accel_state->common_attributes, true);
>  		report_id = accel_state->accel[chan->scan_index].report_id;
>  		address = accel_3d_addresses[chan->scan_index];
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index 845fd1c0fd9d..873c2bf637c0 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -158,7 +158,7 @@ static unsigned int ad5380_info_to_reg(struct iio_chan_spec const *chan,
>  	long info)
>  {
>  	switch (info) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		return AD5380_REG_DATA(chan->address);
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		return AD5380_REG_OFFSET(chan->address);
> diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
> index 033f20eca616..9333177062c0 100644
> --- a/drivers/iio/dac/ad5764.c
> +++ b/drivers/iio/dac/ad5764.c
> @@ -168,7 +168,7 @@ static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
>  static int ad5764_chan_info_to_reg(struct iio_chan_spec const *chan, long info)
>  {
>  	switch (info) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		return AD5764_REG_DATA(chan->address);
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		return AD5764_REG_OFFSET(chan->address);
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index f59995a90387..36941e69f959 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -115,7 +115,7 @@ static int gyro_3d_read_raw(struct iio_dev *indio_dev,
>  	*val = 0;
>  	*val2 = 0;
>  	switch (mask) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		hid_sensor_power_state(&gyro_state->common_attributes, true);
>  		report_id = gyro_state->gyro[chan->scan_index].report_id;
>  		address = gyro_3d_addresses[chan->scan_index];
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index befd693a4a31..406caaee9a3c 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -97,7 +97,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  	*val = 0;
>  	*val2 = 0;
>  	switch (mask) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		switch (chan->scan_index) {
>  		case  CHANNEL_SCAN_INDEX_INTENSITY:
>  		case  CHANNEL_SCAN_INDEX_ILLUM:
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 36208a3652e9..ff5a3324b489 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -199,7 +199,7 @@ static int lm3533_als_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (mask) {
> -	case 0:
> +	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_LIGHT:
>  			ret = lm3533_als_get_adc(indio_dev, false, val);
