Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4020872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPsT3Ngy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390312AbfAKTNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:13:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbfAKTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:13:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so7155151plm.8;
        Fri, 11 Jan 2019 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=16mOFIrgq9qvlgahtvjFRJUWsQwKf4nzaXkL4ESzLV4=;
        b=aPsT3Ngy3IefUanD691TLd4DMxIM4JrXP9BMHrFS7V5nlAOk59E8wXyFE0P2lv58At
         7s4fpmzbNvKXkFZBXLgUoxDnn7spTVY4kc1Z5nc+kINWxb/1e6/5YTfcKsSI81cy2PWP
         Y1O2ClGC91Riy+IcwkbThdhPUseNo3wPDtHeQguYX4TcA4UIK++Or+1QTsYlKzMel2EV
         q0qnQSNCuxXfG/f9K+w8FYCn5mMrXoq0ALRSnKKhF6qjDRru+Af4RLDz3lHEqR1hjJOv
         qJCj5VeK6H0eMUAYwm//yrv/7Y+7ZxZCvptijDnz8kQnRHuk4+GJXKIXas1PHIDWb8qg
         9xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=16mOFIrgq9qvlgahtvjFRJUWsQwKf4nzaXkL4ESzLV4=;
        b=ksNZKdOQQSH3u0ZIcvguqQo43vY5pqhvpdOVLslB8GsZDMwcGozvJDrGocDLCEqq5b
         TjLJQeGwscKseOW82Z8ByOfuahHzoowmjGUtP8H0pJbElbBtUlVgm+4GBFS9Fa3IgPIF
         W8jx0dknuRrrGhnp5NZI0EiUWiEBF3wf7RkMA62z/VYbTcCXcn7OvcueGdWWmoAg7LYq
         qgtLIEi2QdKGpuJyIMPVn+BdHWbg6tiwgHIi6G+BehHiC0D2PdxSy5z/PTDRx1mB+AK2
         Up1MHEbHN2/+jxR76jZngTw9LqD8rKKyCSfw5bmckYQ3D26TWiclbFZzy8XkMEuBSN6g
         rktQ==
X-Gm-Message-State: AJcUukd9xp/+P21Mepallw6vlGHUFsu6zISou5ZhT5T6JoCgReWJ5+qr
        nZ8yQfllwfi6UM34uhyTEn8=
X-Google-Smtp-Source: ALg8bN7JxPMKRx3wni+Mtxt3F59/lQPjcb8Xynb2edI12ZqRDYx10kx25q8ZUoYW0ioNVwKFT/Gq5A==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr15378748plo.123.1547233992086;
        Fri, 11 Jan 2019 11:13:12 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r4sm159594554pgn.54.2019.01.11.11.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:13:11 -0800 (PST)
Date:   Fri, 11 Jan 2019 11:13:07 -0800
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
Subject: Re: [PATCH v2 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190111191306.GA8463@Asurada-Nvidia.nvidia.com>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 01:05:43PM +0000, Viorel Suman wrote:
> The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> drivers and related DT bindings documentation.
> 
> Changes since V1:
> 1. Original patch split into distinct patches for the device driver and
>   DT binding documentation.
> 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
>   RM-compliant.
> 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> 4. Added machine driver and related DT binding documentation.
> 
> Viorel Suman (4):
>   ASoC: fsl: Add Audio Mixer CPU DAI driver
>   ASoC: add fsl_audmix DT binding documentation
>   ASoC: fsl: Add Audio Mixer machine driver
>   ASoC: add imx-audmix DT binding Documentation

For this series,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> 
>  .../devicetree/bindings/sound/fsl,audmix.txt       |  44 ++
>  .../devicetree/bindings/sound/imx-audmix.txt       |  24 +
>  sound/soc/fsl/Kconfig                              |  16 +
>  sound/soc/fsl/Makefile                             |   5 +
>  sound/soc/fsl/fsl_audmix.c                         | 551 +++++++++++++++++++++
>  sound/soc/fsl/fsl_audmix.h                         | 101 ++++
>  sound/soc/fsl/imx-audmix.c                         | 328 ++++++++++++
>  7 files changed, 1069 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
>  create mode 100644 sound/soc/fsl/fsl_audmix.c
>  create mode 100644 sound/soc/fsl/fsl_audmix.h
>  create mode 100644 sound/soc/fsl/imx-audmix.c
> 
> -- 
> 2.7.4
> 
