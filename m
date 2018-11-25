Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC90CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E0820865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 08:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E0820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeKYTZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 14:25:44 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34320 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeKYTZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 14:25:44 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B1A8F9E76F8;
        Sun, 25 Nov 2018 08:35:08 +0000 (GMT)
Date:   Sun, 25 Nov 2018 08:35:07 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: add IIO_MASSCONCENTRATION channel type
Message-ID: <20181125083507.1b155cc8@archlinux>
In-Reply-To: <20181124221415.10081-2-tduszyns@gmail.com>
References: <20181124221415.10081-1-tduszyns@gmail.com>
        <20181124221415.10081-2-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2018 23:14:13 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Measuring particulate matter in ug / m3 (micro-grams per cubic meter)
> is de facto standard. Existing air quality sensors usually follow
> this convention and are capable of returning measurements using
> this unit.
> 
> IIO currently does not offer suitable channel type for this
> type of measurements hence this patch adds this.
> 
> In addition, two modifiers are introduced used for distinguishing
> between coarse (PM10) and fine particles (PM2p5) measurements, i.e
> IIO_MOD_PM10 and IIO_MOD_PM2p5.
I initially wondered why these particular numbers and why don't
we provide an attribute specify this separately?

However google suggests these two are pretty much the only
ones anyone worries about in pollution sensors.  I ended
up fairly quickly at the EPA website
https://www.epa.gov/pm-pollution/table-historical-particulate-matter-pm-national-ambient-air-quality-standards-naaqs
which tells me these two have be used since about 1987.

So I think the modifier route is the right approach here
(I think we've gotten this wrong in the past such as light
sensor colours where the list keeps on growing).

I would like a reference or two in the docs though to point
people to these definitions.

Thanks,

Jonathan

> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 ++++++++++-
>  drivers/iio/industrialio-core.c         |  3 +++
>  include/uapi/linux/iio/types.h          |  3 +++
>  tools/iio/iio_event_monitor.c           |  6 ++++++
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 8127a08e366d..ce0ed140660d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1684,4 +1684,13 @@ KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) phase difference reading from channel Y
> -		that can be processed to radians.
> \ No newline at end of file
> +		that can be processed to radians.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm2p5_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm2p5_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentration_pm10_input
> +What:		/sys/bus/iio/devices/iio:deviceX/in_massconcentrationY_pm10_input
> +KernelVersion:	4.21
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Mass concentration reading of particulate matter in ug / m3.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a062cfddc5af..2a9ef600c1fb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_GRAVITY]  = "gravity",
>  	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  	[IIO_PHASE] = "phase",
> +	[IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> @@ -127,6 +128,8 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Q] = "q",
>  	[IIO_MOD_CO2] = "co2",
>  	[IIO_MOD_VOC] = "voc",
> +	[IIO_MOD_PM2p5] = "pm2p5",
> +	[IIO_MOD_PM10] = "pm10",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 92baabc103ac..465044b42af5 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -46,6 +46,7 @@ enum iio_chan_type {
>  	IIO_GRAVITY,
>  	IIO_POSITIONRELATIVE,
>  	IIO_PHASE,
> +	IIO_MASSCONCENTRATION,
>  };
>  
>  enum iio_modifier {
> @@ -87,6 +88,8 @@ enum iio_modifier {
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
>  	IIO_MOD_LIGHT_DUV,
> +	IIO_MOD_PM2p5,
> +	IIO_MOD_PM10,
>  };
>  
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index ac2de6b7e89f..f0fcfeddba2b 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -60,6 +60,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_GRAVITY] = "gravity",
>  	[IIO_POSITIONRELATIVE] = "positionrelative",
>  	[IIO_PHASE] = "phase",
> +	[IIO_MASSCONCENTRATION] = "massconcentration",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -115,6 +116,8 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Q] = "q",
>  	[IIO_MOD_CO2] = "co2",
>  	[IIO_MOD_VOC] = "voc",
> +	[IIO_MOD_PM2p5] = "pm2p5",
> +	[IIO_MOD_PM10] = "pm10",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -156,6 +159,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_GRAVITY:
>  	case IIO_POSITIONRELATIVE:
>  	case IIO_PHASE:
> +	case IIO_MASSCONCENTRATION:
>  		break;
>  	default:
>  		return false;
> @@ -200,6 +204,8 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_Q:
>  	case IIO_MOD_CO2:
>  	case IIO_MOD_VOC:
> +	case IIO_MOD_PM2p5:
> +	case IIO_MOD_PM10:
>  		break;
>  	default:
>  		return false;

