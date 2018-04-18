Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDRJcx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:32:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750861AbeDRJcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:32:52 -0400
Date: Wed, 18 Apr 2018 10:32:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
CC: Jonathan Cameron <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
Subject: Re: [PATCH v3 03/11] iio: Add channel for Position Relative
Message-ID: <20180418103227.00003a2e@huawei.com>
In-Reply-To: <02533699-a2bc-7c0c-4d8a-c10bb0102667@microchip.com>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
        <1523350677-27106-4-git-send-email-eugen.hristev@microchip.com>
        <20180415202942.5c7d50a8@archlinux>
        <02533699-a2bc-7c0c-4d8a-c10bb0102667@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 10:30:46 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> On 15.04.2018 22:29, Jonathan Cameron wrote:
> > On Tue, 10 Apr 2018 11:57:49 +0300
> > Eugen Hristev <eugen.hristev@microchip.com> wrote:
> >   
> >> Add new channel type for relative position on a pad.
> >>
> >> These type of analog sensor offers the position of a pen
> >> on a touchpad, and is represented as a voltage, which can be
> >> converted to a position on X and Y axis on the pad.
> >> The channel will hand the relative position on the pad in both directions.
> >>
> >> The channel can then be consumed by a touchscreen driver or
> >> read as-is for a raw indication of the touchpen on a touchpad.
> >>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >> ---
> >> Changes in v2:
> >>   - modified channel name to relative position as suggested.
> >>   - modified kernel version to 4.18 (presumable)
> >>
> >>   Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
> >>   drivers/iio/industrialio-core.c         |  1 +
> >>   include/uapi/linux/iio/types.h          |  1 +
> >>   tools/iio/iio_event_monitor.c           |  2 ++
> >>   4 files changed, 16 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> >> index 6a5f34b..42a9287 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >> @@ -190,6 +190,18 @@ Description:
> >>   		but should match other such assignments on device).
> >>   		Units after application of scale and offset are m/s^2.
> >>   
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
> >> +What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
> >> +KernelVersion:	4.18
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Relative position in direction x or y on a pad (may be
> >> +		arbitrarily assigned but should match other such assignments on
> >> +		device).
> >> +		Units after application of scale and offset are milli percents
> >> +		from the pad's size in both directions. Should be calibrated by
> >> +		the consumer.  
> > I know the milli percent comes form the humidity equivalent, but I wonder
> > if we are right to follow that.  10^-5 is a pretty random base unit (though
> > I got argued into it being a standard choice for humidity sensors IIRC...
> > 
> > What do people think?  We could go with 1 for full range or just percent perhaps?
> > 
> > I'm not that fussed about staying consistent with humidity - we are unlikely
> > to end up with sensors doing both anytime soon so there shouldn't be
> > any confusion...
> > 
> > Jonathan  
> Hello Jonathan,
> 
> For my specific use case, percents are not enough, as this would mean 
> the resolution will be pretty low. If we have a touchpanel of a higher 
> resolution, having the position only ranged 0 to 100 is pretty bad.
> Having millipercents means we can have a resolution up to 100,000 points 
> in range, which is fine for the hardware as of this moment.
> Of course, specific drivers reporting these channels can define a 
> specific range if they desire (report just in the first percent if you 
> wish (0-1000) or so, which would mean a lower resolution.
> Centi-percent would work fine as well I believe (0-10,000 range), but to 
> keep consistent with your suggestion regarding relative humidity, I 
> picked this larger scale.
> In my specific case, since we have a 12 bit ADC, range is 0-4096 for 
> this value.
> Calibrating these values to the actual size of the touchpanel is left 
> for the consumer to do (map 4096x4096 to the actual resolution)
> 
> If you have a better idea than milli-percents I can change it, no problem.
> 

It doesn't actually matter what the defined 'base units' are from a question
of what we can represent.  That is just handled by suppling an appropriate
SCALE for the channel.  All this is about is trying to provide something
consistent rather than having any effect on the actual range.  Will let
this sit a while longer...

Jonathan

> Eugen
> >> +
> >>   [...]  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
