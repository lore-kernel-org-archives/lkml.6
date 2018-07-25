Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268AEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43A5205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcgJyIoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43A5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeGYGgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:36:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38892 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeGYGgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:36:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id t25-v6so4596908wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k1YuXU7tZHZkeS58DjzqRHPmbFF/tPLKrYQNoLD1akA=;
        b=OcgJyIoGoWrxH5s4Nuxf3ZKV04Erq/6nMnMSVWS5NTbcS6TbExF6aY0cIml0VOv+3Z
         iLc9CASWPYCgNpDKOZD9cX+/K5wae8z9nBz2GeOrmCQpcdse3jHFTdV5vDc3lJxukURC
         Bhz7jO7Md3gbZmloGjgzLdong+x3bAwQB1BEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k1YuXU7tZHZkeS58DjzqRHPmbFF/tPLKrYQNoLD1akA=;
        b=aqL3IW7NYnCRjLIxN1xK1NMF+F51bZhJiWOQTCL03ykI7x+tpwNMBgQ6Pl9bihLU11
         h27cOrRSvjbNCkt8kCSjtrM2Fi/YJEiVLhB3q0YJLlOl1y0DhpxEDJOkE9WjTm6/0Gui
         TfNk5GkDYo2Wl+W22flH8LV4VUg9RRNUxTSP72jIlfKExiQMfKRNK0thuMLWybU9cTBj
         UuZmrcgXq6dEsexDFRDZaBfQ2UFc9d2KVBTS/QZBCyRuENxH8/GFD3tDHl5apVASqSG3
         oH8CY4P3sI7iK/MXxAnSvIg1AfkX9JYhz6Tl3eya5Xb1Y7SWF7qe1j+JEYmb82T5P9yK
         pRdQ==
X-Gm-Message-State: AOUpUlHSGqBG3ebsnMFlAuxnTYKY0XQ5mlfbQDxn5xcUcFjf3DMLot54
        0HnqqZbYdNGL8P1uNo5GdW9zOUf1ZaI=
X-Google-Smtp-Source: AAOMgpe0YMrrKfm/89tO4C3hJg+4qpNhVVvlMi2J2XeYVN43xY9i3AXsES6RBt1JcSHSL1nwGF/xCw==
X-Received: by 2002:a1c:ec1b:: with SMTP id k27-v6mr3460288wmh.157.1532496383436;
        Tue, 24 Jul 2018 22:26:23 -0700 (PDT)
Received: from dell ([95.149.164.105])
        by smtp.gmail.com with ESMTPSA id 189-v6sm4904706wmd.17.2018.07.24.22.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 22:26:22 -0700 (PDT)
Date:   Wed, 25 Jul 2018 06:26:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 0/5] ti_am335x_tsc: Enable wakeup capability
Message-ID: <20180725052621.GB5835@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <dcb4a63b-9ecb-a72e-bfb8-ebb62017b4f7@ti.com>
 <20180718074736.GA4641@dell>
 <20180718170902.vk7rahyoaevucxbi@penguin>
 <20180723053708.GA4213@dell>
 <2236aa96-ca56-fa30-157d-2f484c6968cc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2236aa96-ca56-fa30-157d-2f484c6968cc@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Vignesh R wrote:
> On Monday 23 July 2018 11:07 AM, Lee Jones wrote:
> > On Wed, 18 Jul 2018, Dmitry Torokhov wrote:
> > 
> >> On Wed, Jul 18, 2018 at 08:47:36AM +0100, Lee Jones wrote:
> >>> On Tue, 17 Jul 2018, Vignesh R wrote:
> >>>
> >>>> Hi Dmitry,
> >>>>
> >>>> On Saturday 30 June 2018 04:03 PM, Vignesh R wrote:
> >>>>> On AM335x, resistive TSC can wakeup the system from low power state.
> >>>>> Currently, parent MFD device is marked as wakeup source, which is
> >>>>> inaccurate as its the touch event generated by TSC thats the wakeup
> >>>>> source. This series moves all wakeup related calls to operate on TSC
> >>>>> device instead of MFD. It also marks TSC IRQ as wakeup capable, so that
> >>>>> its not disabled during system suspend.
> >>>>>
> >>>>> This series is based on Dmitry's comments here:
> >>>>> https://lkml.org/lkml/2018/4/24/65
> >>>>>
> >>>>> There are many new patches in this series, hence did not mark this as v4.
> >>>>>
> >>>>> Vignesh R (5):
> >>>>>   mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
> >>>>>   Input: ti_am335x_tsc: Mark TSC device as wakeup source
> >>>>>   mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup
> >>>>>     capable
> >>>>>   iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
> >>>>>   Input: ti_am335x_tsc: Mark IRQ as wakeup capable
> >>>>>
> >>>>>  drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
> >>>>>  drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
> >>>>>  drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
> >>>>>  3 files changed, 34 insertions(+), 14 deletions(-)
> >>>>>
> >>>>
> >>>> Gentle ping... Could you review/pick this series? MFD amd IIO bits are
> >>>> already ACKed
> >>>
> >>> MFD patches are reviewed "for my own reference" meaning that we
> >>> haven't yet agreed on a merge plan yet.
> >>
> >> I think this series makes sense to be pushed through a single tree as
> >> opposed to being spread between 3, even if it could technically be
> >> possible. It looks like Jonathan is fine with going it through either
> >> his or some other tree, I am fine with it going through MFD.
> > 
> > I'm happy either way.
> > 
> Thanks Dmitry, Jonathan and Lee Jones!
> 
> Could this be applied to one of the trees now? MFD perhaps?

It'll be applied, when it's applied. ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
