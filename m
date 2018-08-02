Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE5FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B13214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhvAokP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B13214FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeHBLsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:48:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42017 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbeHBLsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:48:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so1464392wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tebFwpcT0fXv0Wndqx54cj5GZH3DroiuVfifBPq9OM0=;
        b=JhvAokP1lzYvNDNHp6/nNDsNdKrqwm2o4jFQASag/w25Nju2LQ/jQTk4lp9AmQqc/1
         mNvkbjR2KhtX2EAGkDX5f6yfTZdQZnvznPAroyn7lnOHtrzEFKhh37wmq+9AJT76VXl7
         /1z7uTpDJa2Cam25kL5URYTexmJV7tncTLQkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tebFwpcT0fXv0Wndqx54cj5GZH3DroiuVfifBPq9OM0=;
        b=l9KTtezZ9I2ksWVJd/yxGACBBHVJb//JygE9MRG+quXm4jvtUVXgtAIHtBRgzOvrGO
         6ZrmYS+7iRksvRjiEjyDOj8UKdh/UFDKF4YEOSmyx5mwY6ArY6ppdA0mSnXZuHJ8sgP+
         kvK3vUxGDfm2o39R7A3bAnZ3pfm336x+i8W6uDbH6p43i6dtQgFQwz4z4l142Zlgfwbh
         Se3PxSTiztixj/fFcK5N/Ls6w1Ig+o4SgNAd5p7jNvNcTGjmnH4VU5b4N+DjvGXeKf6S
         Yba5JrT3BdhYO7DM7nBAb6wds/nHUseuYMI8QgIjS04uL1DQfbWMC0pQx/4hGJnHtCvE
         x7RQ==
X-Gm-Message-State: AOUpUlGewxf7sMuQ9/WaNke6Aeh3ctwV0sZosqkqNiiPy1YJsU9MVbEr
        ZK9MusRr2PNTxg38DzH5Ux3JMw==
X-Google-Smtp-Source: AAOMgpcO1go3fvBTyA3ggP2JeSi8KHLVyb14XEo54R4EtaIVUvmLwze78soI3L8dSbkSMIk1sSju8A==
X-Received: by 2002:a5d:4b90:: with SMTP id b16-v6mr1362010wrt.168.1533203864038;
        Thu, 02 Aug 2018 02:57:44 -0700 (PDT)
Received: from dell ([95.149.160.4])
        by smtp.gmail.com with ESMTPSA id d14-v6sm1062543wrr.12.2018.08.02.02.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 02:57:43 -0700 (PDT)
Date:   Thu, 2 Aug 2018 10:57:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180802095741.GP4662@dell>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
 <20180802083351.GN4662@dell>
 <9a33e0ce-a385-cdad-f610-655562bec1f5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a33e0ce-a385-cdad-f610-655562bec1f5@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2018, Srinivas Kandagatla wrote:
> On 02/08/18 09:33, Lee Jones wrote:
> > On Fri, 27 Jul 2018, Srinivas Kandagatla wrote:
> > 
> > > Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> > > It has mulitple blocks like Soundwire controller, codec,
> > > Codec processing engine, ClassH controller, interrupt mux.
> > > It supports both I2S/I2C and SLIMbus audio interfaces.
> > > 
> > > This patch adds support to SLIMbus audio interface.
> > > 
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   drivers/mfd/Kconfig                   |  18 ++
> > >   drivers/mfd/Makefile                  |   4 +
> > >   drivers/mfd/wcd9335-core.c            | 268 ++++++++++++++++
> > >   include/linux/mfd/wcd9335/registers.h | 580 ++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/wcd9335/wcd9335.h   |  42 +++
> > >   5 files changed, 912 insertions(+)
> > >   create mode 100644 drivers/mfd/wcd9335-core.c
> > >   create mode 100644 include/linux/mfd/wcd9335/registers.h
> > >   create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
> > > 
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index f3fa516011ec..6e5b5f3cfe20 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1807,6 +1807,24 @@ config MFD_WM97xx
> > >   	  support for the WM97xx, in order to use the actual functionaltiy of
> > >   	  the device other drivers must be enabled.
> > > +config MFD_WCD9335
> > > +	tristate
> > > +	select MFD_CORE
> > > +	select REGMAP
> > > +	select REGMAP_IRQ
> > > +
> > > +config MFD_WCD9335_SLIM
> > > +	tristate "Qualcomm WCD9335 with SLIMbus"
> > > +	select MFD_WCD9335
> > > +	select REGMAP_SLIMBUS
> > > +	depends on SLIMBUS
> > > +	help
> > > +	The WCD9335 is a standalone Hi-Fi audio codec IC, supports
> > 
> > s/codec/CODEC/
> Yep.

If you agree with something, best just to snip it.

No need to reply at all if you agree with everything.

[...]

> > > +static int wcd9335_power_on_reset(struct wcd9335 *wcd)
> > > +{
> > > +	struct device *dev = wcd->dev;
> > > +	int ret;
> > > +
> > > +	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
> > > +	if (ret != 0) {
> > > +		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/*
> > > +	 * For WCD9335, it takes about 600us for the Vout_A and
> > > +	 * Vout_D to be ready after BUCK_SIDO is powered up.
> > > +	 * SYS_RST_N shouldn't be pulled high during this time
> > > +	 */
> > > +	usleep_range(600, 650);
> > > +
> > > +	gpio_direction_output(wcd->reset_gpio, 0);
> > > +	msleep(20);
> > 
> > What's this for?  Why can't you just:
> > 
> This is just making sure that reset line is low before actual the chip is
> taken out of reset.

If it confused me, it might confuse others.

Best to add a comment to the tune of:

  "Toggle reset line off/on to ensure ... "

> >    gpio_direction_output(wcd->reset_gpio, 1);
> > 
> > ... and drop the next 2 lines?

[...]

> > > +static const struct mfd_cell wcd9335_devices[] = {
> > > +	{
> > > +		.name = "wcd9335-codec",
> > > +	},
> > > +};
> > 
> > When are you going to add the other devices?
> > 
> We are trying to sort of hw setup to test other devices like soundwire
> controller, will add these once we are in a position to test them.

Ensure that you do, or I'll revert the whole driver as "not an MFD" :)

> > By the way, one line entries should be placed on one line.
> > 
> > > +	{ .name = "wcd9335-codec" },

[...]

> > > +static int wcd9335_slim_status(struct slim_device *sdev,
> > > +				 enum slim_device_status s)
> > 
> > 's' is not a good variable name.  Suggest 'status'.
> > 
> Agreed!
> > > +{
> > > +	struct device_node *ifd_np;
> > 
> > What's 'ifd'?
> > 
> SLIMbus Interface device.

That's a terrible variable name. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
