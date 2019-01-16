Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47081C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C9620675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn4egayT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfAPW7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:59:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34685 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfAPW7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:59:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so3500635pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 14:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDVWsplCmCZoQvbsUv+vaBJ5uZN+cqAhijuFmiT0DKE=;
        b=Wn4egayTTyrkb3wGYn/6fR4/LHPUkWUf38G8gS9SGPv55Fm6qYZU/ncKcSGIIZb83Q
         pbHbt387GlL1xKLO+7tnes8jHfQI7tFt7GrJJALfqWuO1rOtpvlbuIsRixhqPoTFYws/
         09fZFco7bwE2rvUSRxu5Bx2s9suhEyiPWZCbgTSl/FTFn23liwP8z3qnFlD9eXS+4/qn
         25gmRWNM23vcPYb4eJC5aARsuFAOaaD/yh9VtEjeaTFb/cWe3EpKKGQiW58w0qC+dN2Z
         yIIs9i8r2YvOVWVAD2V+L3HaAGu2F153EQqa83QKw5LeLLvvgQMAX2afrNODpOSxNsaS
         9NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDVWsplCmCZoQvbsUv+vaBJ5uZN+cqAhijuFmiT0DKE=;
        b=EQkLPdIpkAZI4z51RXbSqcxp6ASsVqG0+l4vc18c2fizkw6MxxN2UhFqJjBcb1DWvm
         So0z42NfZtVO2q3u3sKXRYkkXL9Zbv0GgSdsxt+GNaeXuVZJFbeiemokF7uLX0iOzQC+
         zjuha5QtXEcavBU3H+2z9K/5oFdsh0repQ9yMxDlqIW22LX6szHAw/weNWqQqWQHu7mO
         AU28zaCfj/RdbG6Qp6Kw8AOjBPSjtCZJR/t3rFEB/wNCBxJXpowIzEo93P0HP90VsPxr
         TYmUMRy79/UAczUDnqn6ZLdZVCUNmX93PSvZ9GOna7kAMiH9EwhD/aixpxHrjz6F7Zcg
         XPzA==
X-Gm-Message-State: AJcUukcWBguPbgi48U5uj9tyOcys2i+P1M259/bbwqXCubHYl8b02L3X
        wqAD3f3RL5h8TJ28zKbKzSA=
X-Google-Smtp-Source: ALg8bN4eCf2dl5W/W5CkMr4rPA+0P7iufAR4RgoikmB3ceXTbzD1kqWHRNkK0fVdX1CmK/wcLtZZUA==
X-Received: by 2002:a63:e950:: with SMTP id q16mr11180889pgj.138.1547679574042;
        Wed, 16 Jan 2019 14:59:34 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w184sm7442393pgd.34.2019.01.16.14.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 14:59:32 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:59:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tzungbi@chromium.org, Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Guenter Roeck <groeck@chromium.org>, dgreid@chromium.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v3 3/3] ASoC: cros_ec_codec: Add codec
 driver for Cros EC
Message-ID: <20190116225931.GA13512@roeck-us.net>
References: <20181226070317.72022-1-cychiang@chromium.org>
 <20181226070317.72022-3-cychiang@chromium.org>
 <20190116061802.GA31405@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116061802.GA31405@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:18:02PM -0800, Guenter Roeck wrote:
> On Wed, Dec 26, 2018 at 03:03:19PM +0800, Cheng-Yi Chiang wrote:
> > Add a codec driver to control ChromeOS EC codec.
> > 
> > Use EC Host command to enable/disable I2S recording and control other
> > configurations.
> > 
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> > Changes in v3:
> > 1.remove cros_ec_codec.h.
> > 2.Fix error code overriding in
> >     set_i2s_config
> >     set_i2s_sample_depth
> >     set_bclk
> >     get_ec_mic_gain
> >     set_ec_mic_gain
> >     enable_i2s
> > 3.Fix missing return code in cros_ec_i2s_set_dai_fmt.
> > 4.Simplify return code in cros_ec_i2s_hw_params and mic_gain_put.
> > 5.Remove useless debug message in cros_ec_codec_platform_probe.
> > 
> >  MAINTAINERS                      |   2 +
> >  sound/soc/codecs/Kconfig         |   8 +
> >  sound/soc/codecs/Makefile        |   2 +
> >  sound/soc/codecs/cros_ec_codec.c | 454 +++++++++++++++++++++++++++++++
> >  4 files changed, 466 insertions(+)
> >  create mode 100644 sound/soc/codecs/cros_ec_codec.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 05e1922624e58..d66f80f3252d7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3638,8 +3638,10 @@ F:	drivers/platform/chrome/
> >  
> >  CHROMEOS EC CODEC DRIVER
> >  M:	Cheng-Yi Chiang <cychiang@chromium.org>
> > +R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.txt
> > +F:	sound/soc/codecs/cros_ec_codec.*
> >  
> >  CIRRUS LOGIC AUDIO CODEC DRIVERS
> >  M:	Brian Austin <brian.austin@cirrus.com>
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 87cb9c51e6f5a..0b36428159b71 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -50,6 +50,7 @@ config SND_SOC_ALL_CODECS
> >  	select SND_SOC_BT_SCO
> >  	select SND_SOC_BD28623
> >  	select SND_SOC_CQ0093VC
> > +	select SND_SOC_CROS_EC_CODEC
> 
> This unconditionally selects SND_SOC_CROS_EC_CODEC, but SND_SOC_CROS_EC_CODEC
> depends on MFD_CROS_EC. This is missing an "if MFD_CROS_EC" qualifier.
> 
> >  	select SND_SOC_CS35L32 if I2C
> >  	select SND_SOC_CS35L33 if I2C
> >  	select SND_SOC_CS35L34 if I2C
> > @@ -457,6 +458,13 @@ config SND_SOC_CPCAP
> >  config SND_SOC_CQ0093VC
> >  	tristate
> >  
> > +config SND_SOC_CROS_EC_CODEC
> > +	tristate "codec driver for ChromeOS EC"
> > +	depends on MFD_CROS_EC
> > +	help
> > +	  If you say yes here you will get support for the
> > +	  ChromeOS Embedded Controller's Audio Codec.
> > +
> >  config SND_SOC_CS35L32
> >  	tristate "Cirrus Logic CS35L32 CODEC"
> >  	depends on I2C
> > diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> > index 9bb3346fab2fe..3cfd8f5f61705 100644
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -42,6 +42,7 @@ snd-soc-bd28623-objs := bd28623.o
> >  snd-soc-bt-sco-objs := bt-sco.o
> >  snd-soc-cpcap-objs := cpcap.o
> >  snd-soc-cq93vc-objs := cq93vc.o
> > +snd-soc-cros-ec-codec-objs := cros_ec_codec.o
> >  snd-soc-cs35l32-objs := cs35l32.o
> >  snd-soc-cs35l33-objs := cs35l33.o
> >  snd-soc-cs35l34-objs := cs35l34.o
> > @@ -310,6 +311,7 @@ obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
> >  obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
> >  obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
> >  obj-$(CONFIG_SND_SOC_CPCAP)	+= snd-soc-cpcap.o
> > +obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)	+= snd-soc-cros-ec-codec.o
> >  obj-$(CONFIG_SND_SOC_CS35L32)	+= snd-soc-cs35l32.o
> >  obj-$(CONFIG_SND_SOC_CS35L33)	+= snd-soc-cs35l33.o
> >  obj-$(CONFIG_SND_SOC_CS35L34)	+= snd-soc-cs35l34.o
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> > new file mode 100644
> > index 0000000000000..85ea23f4b681c
> > --- /dev/null
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -0,0 +1,454 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for ChromeOS Embedded Controller codec.
> > + *
> > + * This driver uses the cros-ec interface to communicate with the ChromeOS
> > + * EC for audio function.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/cros_ec.h>
> > +#include <linux/mfd/cros_ec_commands.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <sound/pcm.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include <sound/tlv.h>
> > +
> > +#define MAX_GAIN 43
> 
> Is there some reason for this magic number ? What does it reflect ? 
> 
> > +
> > +#define DRV_NAME "cros-ec-codec"
> > +
> > +/**
> > + * struct cros_ec_codec_data - ChromeOS EC codec driver data.
> > + * @dev:         Device structure used in sysfs.
> > + * @ec_device:   cros_ec_device structure to talk to the physical device.
> > + * @component:   Pointer to the component.
> > + */
> > +struct cros_ec_codec_data {
> > +	struct device *dev;
> > +	struct cros_ec_device *ec_device;
> > +	struct snd_soc_component *component;
> > +};
> > +
> > +static const DECLARE_TLV_DB_SCALE(ec_mic_gain_tlv, 0, 100, 0);
> > +/*
> > + * Wrapper for EC command.
> > + */
> > +static int ec_command(struct snd_soc_component *component, int version,
> > +		      int command, u8 *outdata, int outsize,
> > +		      u8 *indata, int insize)
> > +{
> > +	struct cros_ec_codec_data *codec_data =
> > +		snd_soc_component_get_drvdata(component);
> > +	struct cros_ec_device *ec_device = codec_data->ec_device;
> > +	struct cros_ec_command *msg;
> > +	int ret;
> > +
> > +	msg = kzalloc(sizeof(*msg) + max(insize, outsize), GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> 
> As far as I can see, the calling parameter is always "struct ec_param_codec_i2s".
> With that in mind, this code seems unnecessarily complex. Is this code expected
> to be called multiple times in parallel and requires multiple instances of
> struct ec_param_codec_i2s to be allocated ? Even if so, why not just use
> a local variable / array ?
> 
> [ This makes me wonder how EC transfers are synchronized in
>   cros_ec_cmd_xfer_status() and below. Does anyone know ? I don't immedately
>   see it.
> ]
> 
Answering this part myself: locking is implemented in cros_ec_cmd_xfer(),
which is called from cros_ec_cmd_xfer_status(). No idea why I didn't see
that earlier.

Guenter
