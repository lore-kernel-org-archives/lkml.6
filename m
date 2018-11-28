Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF108C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9017C206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9017C206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbeK2EMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:12:47 -0500
Received: from shell.v3.sk ([90.176.6.54]:38980 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbeK2EMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:12:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0B29D9969B;
        Wed, 28 Nov 2018 18:10:24 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rAWdos0h46Qy; Wed, 28 Nov 2018 18:10:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 88700996A6;
        Wed, 28 Nov 2018 18:10:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GdtwA4z-aBwD; Wed, 28 Nov 2018 18:10:16 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3D6B9996A0;
        Wed, 28 Nov 2018 18:10:15 +0100 (CET)
Message-ID: <4158fda782575fbbe2c6abeab0f04ebed50efed4.camel@v3.sk>
Subject: Re: [PATCH v3 01/14] media: ov7670: split register setting from
 set_fmt() logic
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>
Date:   Wed, 28 Nov 2018 18:10:13 +0100
In-Reply-To: <20181122183730.GE3808@w540>
References: <20181120100318.367987-1-lkundrak@v3.sk>
         <20181120100318.367987-2-lkundrak@v3.sk> <20181122183730.GE3808@w540>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-22 at 19:37 +0100, jacopo mondi wrote:
> Hi Lubomir,
> 
> On Tue, Nov 20, 2018 at 11:03:06AM +0100, Lubomir Rintel wrote:
> > This will allow us to restore the last set format after the device
> > returns
> > from a power off.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v2:
> > - This patch was added to the series
> > 
> >  drivers/media/i2c/ov7670.c | 80 ++++++++++++++++++++++----------
> > ------
> >  1 file changed, 46 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/media/i2c/ov7670.c
> > b/drivers/media/i2c/ov7670.c
> > index bc68a3a5b4ec..ee2302fbdeee 100644
> > --- a/drivers/media/i2c/ov7670.c
> > +++ b/drivers/media/i2c/ov7670.c
> > @@ -240,6 +240,7 @@ struct ov7670_info {
> >  	};
> >  	struct v4l2_mbus_framefmt format;
> >  	struct ov7670_format_struct *fmt;  /* Current format */
> > +	struct ov7670_win_size *wsize;
> >  	struct clk *clk;
> >  	struct gpio_desc *resetb_gpio;
> >  	struct gpio_desc *pwdn_gpio;
> > @@ -1003,48 +1004,20 @@ static int ov7670_try_fmt_internal(struct
> > v4l2_subdev *sd,
> >  	return 0;
> >  }
> > 
> > -/*
> > - * Set a format.
> > - */
> > -static int ov7670_set_fmt(struct v4l2_subdev *sd,
> > -		struct v4l2_subdev_pad_config *cfg,
> > -		struct v4l2_subdev_format *format)
> > +static int ov7670_apply_fmt(struct v4l2_subdev *sd)
> >  {
> > -	struct ov7670_format_struct *ovfmt;
> > -	struct ov7670_win_size *wsize;
> >  	struct ov7670_info *info = to_state(sd);
> > -#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> > -	struct v4l2_mbus_framefmt *mbus_fmt;
> > -#endif
> > +	struct ov7670_win_size *wsize = info->wsize;
> >  	unsigned char com7, com10 = 0;
> >  	int ret;
> > 
> > -	if (format->pad)
> > -		return -EINVAL;
> > -
> > -	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
> > -		ret = ov7670_try_fmt_internal(sd, &format->format,
> > NULL, NULL);
> > -		if (ret)
> > -			return ret;
> > -#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> > -		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format-
> > >pad);
> > -		*mbus_fmt = format->format;
> > -		return 0;
> > -#else
> > -		return -ENOTTY;
> > -#endif
> > -	}
> > -
> > -	ret = ov7670_try_fmt_internal(sd, &format->format, &ovfmt,
> > &wsize);
> > -	if (ret)
> > -		return ret;
> >  	/*
> >  	 * COM7 is a pain in the ass, it doesn't like to be read then
> >  	 * quickly written afterward.  But we have everything we need
> >  	 * to set it absolutely here, as long as the format-specific
> >  	 * register sets list it first.
> >  	 */
> > -	com7 = ovfmt->regs[0].value;
> > +	com7 = info->fmt->regs[0].value;
> >  	com7 |= wsize->com7_bit;
> >  	ret = ov7670_write(sd, REG_COM7, com7);
> >  	if (ret)
> > @@ -1066,7 +1039,7 @@ static int ov7670_set_fmt(struct v4l2_subdev
> > *sd,
> >  	/*
> >  	 * Now write the rest of the array.  Also store start/stops
> >  	 */
> > -	ret = ov7670_write_array(sd, ovfmt->regs + 1);
> > +	ret = ov7670_write_array(sd, info->fmt->regs + 1);
> >  	if (ret)
> >  		return ret;
> > 
> > @@ -1081,8 +1054,6 @@ static int ov7670_set_fmt(struct v4l2_subdev
> > *sd,
> >  			return ret;
> >  	}
> > 
> > -	info->fmt = ovfmt;
> > -
> >  	/*
> >  	 * If we're running RGB565, we must rewrite clkrc after setting
> >  	 * the other parameters or the image looks poor.  If we're
> > *not*
> > @@ -1100,6 +1071,46 @@ static int ov7670_set_fmt(struct v4l2_subdev
> > *sd,
> >  	return 0;
> >  }
> > 
> > +/*
> > + * Set a format.
> > + */
> > +static int ov7670_set_fmt(struct v4l2_subdev *sd,
> > +		struct v4l2_subdev_pad_config *cfg,
> > +		struct v4l2_subdev_format *format)
> > +{
> > +	struct ov7670_info *info = to_state(sd);
> > +#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> > +	struct v4l2_mbus_framefmt *mbus_fmt;
> > +#endif
> > +	int ret;
> > +
> > +	if (format->pad)
> > +		return -EINVAL;
> > +
> > +	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
> > +		ret = ov7670_try_fmt_internal(sd, &format->format,
> > NULL, NULL);
> > +		if (ret)
> > +			return ret;
> > +#ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
> > +		mbus_fmt = v4l2_subdev_get_try_format(sd, cfg, format-
> > >pad);
> 
> This #ifdef CONFIG_VIDEO_V4L2_SUBDEV_API seems to be quite in some
> drivers... Maybe stubs should be defined in v4l2-subdev.h.

Actually, I've also thought it's sorta ugly. I'll send out a patch that
does what you suggest.

> Anway, that's unrealted, the patch seems fine to me:
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
Lubo

> 
> Thanks
>   j
> 
> 
> > +		*mbus_fmt = format->format;
> > +		return 0;
> > +#else
> > +		return -ENOTTY;
> > +#endif
> > +	}
> > +
> > +	ret = ov7670_try_fmt_internal(sd, &format->format, &info->fmt,
> > &info->wsize);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ov7670_apply_fmt(sd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> >  static int ov7670_get_fmt(struct v4l2_subdev *sd,
> >  			  struct v4l2_subdev_pad_config *cfg,
> >  			  struct v4l2_subdev_format *format)
> > @@ -1847,6 +1858,7 @@ static int ov7670_probe(struct i2c_client
> > *client,
> > 
> >  	info->devtype = &ov7670_devdata[id->driver_data];
> >  	info->fmt = &ov7670_formats[0];
> > +	info->wsize = &info->devtype->win_sizes[0];
> > 
> >  	ov7670_get_default_format(sd, &info->format);
> > 
> > --
> > 2.19.1
> > 

