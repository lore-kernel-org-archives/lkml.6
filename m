Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F536C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F222218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7bpzApd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfAYTnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:43:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36683 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYTnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:43:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so4618007pgm.3;
        Fri, 25 Jan 2019 11:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQO1PTT0Ok9BIQryVdeo//V3RAzC/JEpl5AvgvqLqys=;
        b=l7bpzApdN9NPb6OoWIHMYZiqAx2uDx1DAYOPd0ahUNey1d36c3CtEDQTzjnYX16mui
         jWbKPEpXUmA4wn/blIvUMnZq6MZSFRe0af3uGfdNAlNl8MX27ux4mNeOw7PhVOY4qRK6
         g/vzafBRorEE/udMhWBxLesngZSjE8WKMu0fJvHrdwmX54DCQ6Ycgoc3IDotqNHAiXhy
         TXyQnAtgTSLWpLTnEyRIRymh1w6AWYrzZc3uPZQzHiaEZm5bx/qSVHNo8g+0JgtJSWf6
         wvxyjVxT3oS8n9P9x2l/Nl0+MRK7bxBMij3yy6bQIurRSy8o/Pwr7CN1A64hpeGh6bRG
         qjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQO1PTT0Ok9BIQryVdeo//V3RAzC/JEpl5AvgvqLqys=;
        b=IDzcrMkb186P4XT+6VMIFl2ozL1N9lEa8AEmrrrj8onDEhH75OX4kS0HkUE8dc/S3q
         U2lhH3xm83XTORESIKgqUDbj9XkiKJFQCxwjpCDmHukE8qZ8Y3mXplMUUUitj06RzHd3
         1QA0EIFM31pi0roMrbJZD4rL+xGcn5LMLGodVq70JXVbEV9M8H+akzxnPtqP+4k+gDdB
         6XNnA75oZXUQPKTU4XIyQLsClSYoit+kdLDVwdTIWgXede1UK1WWQ/YIwbSjXFDio8Di
         eArZtps5obX26SJ1nBkrkWcdPtLLQmbEQRXwCYQlMMe9NdS7NqcWEGK1SleERK30gNTR
         BoCQ==
X-Gm-Message-State: AJcUukfC4rAZJM1Q+9W6pI2CGIDuHoxfzEVeOQ3ls/06iYcP3aR63nWB
        wsmGjphtbkn6OT0jrJ2MlK4=
X-Google-Smtp-Source: ALg8bN4O2ycBQh2rVYGKCrxCoq6doUgi0JJE+oV5NaaDWpueqTo5VDWdFgr4OBP2puzxLxQdWX12qg==
X-Received: by 2002:a63:7512:: with SMTP id q18mr10242712pgc.231.1548445401729;
        Fri, 25 Jan 2019 11:43:21 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n78sm51193550pfk.19.2019.01.25.11.43.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 11:43:21 -0800 (PST)
Date:   Fri, 25 Jan 2019 11:43:16 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
References: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
 <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 11:14:27AM +0000, Viorel Suman wrote:
> Add the DT binding documentation for NXP Audio Mixer
> CPU DAI driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.txt       | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> new file mode 100644
> index 0000000..45f807e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> @@ -0,0 +1,54 @@
> +NXP Audio Mixer (AUDMIX).
> +
> +The Audio Mixer is a on-chip functional module that allows mixing of two
> +audio streams into a single audio stream. Audio Mixer has two input serial
> +audio interfaces. These are driven by two Synchronous Audio interface
> +modules (SAI). Each input serial interface carries 8 audio channels in its
> +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> +from two interfaces into a single sample. Before mixing, audio samples of
> +two inputs can be attenuated based on configuration. The output of the
> +Audio Mixer is also a serial audio interface. Like input interfaces it has
> +the same TDM frame format. This output is used to drive the serial DAC TDM
> +interface of audio codec and also sent to the external pins along with the
> +receive path of normal audio SAI module for readback by the CPU.
> +
> +The output of Audio Mixer can be selected from any of the three streams
> + - serial audio input 1
> + - serial audio input 2
> + - mixed audio
> +
> +Mixing operation is independent of audio sample rate but the two audio
> +input streams must have same audio sample rate with same number of channels
> +in TDM frame to be eligible for mixing.
> +
> +Device driver required properties:
> +=================================
> +  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - clocks		: Must contain an entry for each entry in clock-names.
> +
> +  - clock-names		: Must include the "ipg" for register access.
> +
> +  - power-domains	: Must contain the phandle to AUDMIX power domain node
> +
> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.
> +
> +  - model		: Must contain machine driver name which will configure
> +			  and instantiate the appropriate audio card.

I don't feel this is necessary for DT node. The driver should be
able to figure out a proper name for the machine driver: it could
use the compatible string to get "imx8qm-audmix" as the name like
fsl_ssi; Or it could have built-in "imx-audmix" of_device_id data
corresponding to "fsl,imx8qm-audmix" compatible string -- for any
non-imx compatible in the future, use something else.

Thanks
Nic

> +
> +Device driver configuration example:
> +======================================
> +  audmix: audmix@59840000 {
> +    compatible = "fsl,imx8qm-audmix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AUDMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_audmix>;
> +    dais = <&sai4>, <&sai5>;
> +    model = "imx-audmix";
> +  };
> -- 
> 2.7.4
> 
