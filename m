Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965160AbeCGUUv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933935AbeCGUUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:20:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11662172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:20:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] iio:magnetometer: Remove duplications in iio_chan_spec
Message-ID: <20180307202044.1d6e66f2@archlinux>
In-Reply-To: <20180306120011.pbnymd7izt2yxljl@smtp.gmail.com>
References: <20180306120011.pbnymd7izt2yxljl@smtp.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 09:00:11 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The magn_3d_channels array has multiple declarations of iio_chan_spec.
> Most of the iio_chan_spec are very similar, changing only by the .type
> and .channel2 field. This patch reduces the code duplication by adding a
> macro that can replace the iio_chan_spec  repetitions in the
> magn_3d_channels array.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Whilst this looks fine to me, I'd like Srinivas to take a look before
I apply it as this is his driver.  Please do make sure to cc the author.
Whilst many such email addresses bounce as they have moved on they
don't always.

Jonathan

> ---
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 83 ++++++---------------------
>  1 file changed, 19 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index a1fd9d591818..fff64711a6c8 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -74,72 +74,27 @@ static const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
>  	HID_USAGE_SENSOR_ORIENT_TRUE_NORTH,
>  };
>  
> +#define HID_SENSOR_MAGN_3D_AXIS_CHANNEL(channel_type, characteristic)	\
> +	{								\
> +		.type = channel_type,					\
> +		.modified = 1,						\
> +		.channel2 = characteristic,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) | \
> +					BIT(IIO_CHAN_INFO_SCALE) |	\
> +					BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +					BIT(IIO_CHAN_INFO_HYSTERESIS),	\
> +	}								\
> +
>  /* Channel definitions */
>  static const struct iio_chan_spec magn_3d_channels[] = {
> -	{
> -		.type = IIO_MAGN,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_X,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}, {
> -		.type = IIO_MAGN,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_Y,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}, {
> -		.type = IIO_MAGN,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_Z,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}, {
> -		.type = IIO_ROT,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_NORTH_MAGN_TILT_COMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}, {
> -		.type = IIO_ROT,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_NORTH_TRUE_TILT_COMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}, {
> -		.type = IIO_ROT,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_NORTH_MAGN,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}, {
> -		.type = IIO_ROT,
> -		.modified = 1,
> -		.channel2 = IIO_MOD_NORTH_TRUE,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -	}
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_X),
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Y),
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Z),
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_MAGN_TILT_COMP),
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_TRUE_TILT_COMP),
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_MAGN),
> +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_MAGN),
>  };
>  
>  /* Adjust channel real bits based on report descriptor */
