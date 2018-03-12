Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932548AbeCLQef (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:34:35 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38579 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeCLQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:34:33 -0400
X-Google-Smtp-Source: AG47ELvwHM0j4RqIJy3m2BGdFLpHx05Y4xl9CuIYgahs3rXXHh0+/HXmN3AQGrMV1H5f2I6oQUWhcQ==
Date: Mon, 12 Mar 2018 13:34:26 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio:magnetometer: Remove duplications in iio_chan_spec
Message-ID: <20180312163426.djfdfzjtmni33bdq@smtp.gmail.com>
References: <20180306120011.pbnymd7izt2yxljl@smtp.gmail.com>
 <20180307202044.1d6e66f2@archlinux>
 <1520871676.15766.205.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520871676.15766.205.camel@intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12, Pandruvada, Srinivas wrote:
> On Wed, 2018-03-07 at 20:20 +0000, Jonathan Cameron wrote:
> > On Tue, 6 Mar 2018 09:00:11 -0300
> > Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> > 
> > > The magn_3d_channels array has multiple declarations of
> > > iio_chan_spec.
> > > Most of the iio_chan_spec are very similar, changing only by the
> > > .type
> > > and .channel2 field. This patch reduces the code duplication by
> > > adding a
> > > macro that can replace the iio_chan_spec  repetitions in the
> > > magn_3d_channels array.
> 
> I don't think it was tested otherwise channel registration would have
> failed. See below.

Hi,

Sorry for the mistake, I did not test it because I don't have the
hardware. I'll be more cautious.

Thanks for your review. I will send a v2.
 
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > 
> > Whilst this looks fine to me, I'd like Srinivas to take a look before
> > I apply it as this is his driver.  Please do make sure to cc the
> > author.
> > Whilst many such email addresses bounce as they have moved on they
> > don't always.
> > 
> > Jonathan
> > 
> > > ---
> > >  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 83 ++++++---------
> > > ------------
> > >  1 file changed, 19 insertions(+), 64 deletions(-)
> > > 
> > > diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > index a1fd9d591818..fff64711a6c8 100644
> > > --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > > @@ -74,72 +74,27 @@ static const u32
> > > magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
> > >  	HID_USAGE_SENSOR_ORIENT_TRUE_NORTH,
> > >  };
> > >  
> > > +#define HID_SENSOR_MAGN_3D_AXIS_CHANNEL(channel_type,
> > > characteristic)	\
> > > +	{								
> > > \
> > > +		.type = channel_type,				
> > > 	\
> > > +		.modified = 1,					
> > > 	\
> > > +		.channel2 = characteristic,			
> > > 	\
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	
> > > 	\
> > > +		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) | \
> > > +					BIT(IIO_CHAN_INFO_SCALE) |
> > > 	\
> > > +					BIT(IIO_CHAN_INFO_SAMP_FRE
> > > Q) |	\
> > > +					BIT(IIO_CHAN_INFO_HYSTERES
> > > IS),	\
> > > +	}								
> > > \
> > > +
> > >  /* Channel definitions */
> > >  static const struct iio_chan_spec magn_3d_channels[] = {
> > > -	{
> > > -		.type = IIO_MAGN,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_X,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}, {
> > > -		.type = IIO_MAGN,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_Y,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}, {
> > > -		.type = IIO_MAGN,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_Z,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}, {
> > > -		.type = IIO_ROT,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_NORTH_MAGN_TILT_COMP,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}, {
> > > -		.type = IIO_ROT,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_NORTH_TRUE_TILT_COMP,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}, {
> > > -		.type = IIO_ROT,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_NORTH_MAGN,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}, {
> > > -		.type = IIO_ROT,
> > > -		.modified = 1,
> > > -		.channel2 = IIO_MOD_NORTH_TRUE,
> > > -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> > > -		.info_mask_shared_by_type =
> > > BIT(IIO_CHAN_INFO_OFFSET) |
> > > -		BIT(IIO_CHAN_INFO_SCALE) |
> > > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > > -	}
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_X),
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Y),
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Z),
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > > IIO_MOD_NORTH_MAGN_TILT_COMP),
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > > IIO_MOD_NORTH_TRUE_TILT_COMP),
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > > IIO_MOD_NORTH_MAGN),
> > > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > > IIO_MOD_NORTH_MAGN),
> It should be 
> HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_TRUE)
> 
> Thanks,
> Srinivas
