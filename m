Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C629EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744D720779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 05:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+NskZxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744D720779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbeGWGgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 02:36:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38188 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbeGWGgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 02:36:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so16550402wro.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i7kPww1zXm0Dz70Xi9r0KKXyCnMshXgW3Zzef+NATMo=;
        b=E+NskZxkF08C6FWH2LzrB8kzny2vPkoxRthgNJ3sT8+10vJ2eL9FBD4tjmASFW0p9+
         Nktp6/oprhwLP6/ZiWEO38wNTyhz3V47PyPB+TrMy8xEMao//HG12218gjylM9QtAC+I
         cTrUcYd/oMEH3NQnDVrcSShm7KgrTk9dvLiL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i7kPww1zXm0Dz70Xi9r0KKXyCnMshXgW3Zzef+NATMo=;
        b=EsGVBcxIF4TMVndIUmqJX1BX0gPnUUcfHhGANigMUll9wBnsdUKmOcAtF8Oea3XAMQ
         iFRq8gSjA86vweAg5bgJCNinzp47VZP5obMV0/8GxNtBJ+aG3sEwSJz6qp2FqaMnkCGk
         bc5CpxAXAkVQVqzLw0JXsFf4W06ozXUexYUQ9+E4cEz/VF9wMGzfoVS2Wr/+2N1DT/Ld
         a4hQUEGxpOcgRhOlBJqIvKiZuF3lIiediBaODIrPuIdTT0qzNg0BYnTqLZ/ANOPhF909
         mBrzuEwDaTwUxQjq6zQU0KoBzOYyxuniGhqPphUNRx46GEeYHrdqUdzrP4kkhzcsO688
         WQwg==
X-Gm-Message-State: AOUpUlHUGP6gU7EIRJJPuAzIdfx+jLBVk1wekiP9pB2sbQNUgbOfsw8i
        MzydsfMz8dKLtkN6kjEdQBFlrw==
X-Google-Smtp-Source: AAOMgpcoIPzSeO+QjF3juc0T1aZYjRHjSoKUBNvtEty3a8VcbPEnt9eWKgTvwb/8wRa4yxjMZsFrBg==
X-Received: by 2002:adf:b456:: with SMTP id v22-v6mr7608803wrd.187.1532324231703;
        Sun, 22 Jul 2018 22:37:11 -0700 (PDT)
Received: from dell ([2a02:c7d:1faf:e900:9403:d00:d6f3:4419])
        by smtp.gmail.com with ESMTPSA id u14-v6sm14226080wrs.57.2018.07.22.22.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 22:37:10 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:37:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Vignesh R <vigneshr@ti.com>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/5] ti_am335x_tsc: Enable wakeup capability
Message-ID: <20180723053708.GA4213@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <dcb4a63b-9ecb-a72e-bfb8-ebb62017b4f7@ti.com>
 <20180718074736.GA4641@dell>
 <20180718170902.vk7rahyoaevucxbi@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180718170902.vk7rahyoaevucxbi@penguin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Dmitry Torokhov wrote:

> On Wed, Jul 18, 2018 at 08:47:36AM +0100, Lee Jones wrote:
> > On Tue, 17 Jul 2018, Vignesh R wrote:
> > 
> > > Hi Dmitry,
> > > 
> > > On Saturday 30 June 2018 04:03 PM, Vignesh R wrote:
> > > > On AM335x, resistive TSC can wakeup the system from low power state.
> > > > Currently, parent MFD device is marked as wakeup source, which is
> > > > inaccurate as its the touch event generated by TSC thats the wakeup
> > > > source. This series moves all wakeup related calls to operate on TSC
> > > > device instead of MFD. It also marks TSC IRQ as wakeup capable, so that
> > > > its not disabled during system suspend.
> > > > 
> > > > This series is based on Dmitry's comments here:
> > > > https://lkml.org/lkml/2018/4/24/65
> > > > 
> > > > There are many new patches in this series, hence did not mark this as v4.
> > > > 
> > > > Vignesh R (5):
> > > >   mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
> > > >   Input: ti_am335x_tsc: Mark TSC device as wakeup source
> > > >   mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup
> > > >     capable
> > > >   iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
> > > >   Input: ti_am335x_tsc: Mark IRQ as wakeup capable
> > > > 
> > > >  drivers/iio/adc/ti_am335x_adc.c           | 12 ++++--------
> > > >  drivers/input/touchscreen/ti_am335x_tsc.c | 22 +++++++++++++++++-----
> > > >  drivers/mfd/ti_am335x_tscadc.c            | 14 +++++++++++++-
> > > >  3 files changed, 34 insertions(+), 14 deletions(-)
> > > > 
> > > 
> > > Gentle ping... Could you review/pick this series? MFD amd IIO bits are
> > > already ACKed
> > 
> > MFD patches are reviewed "for my own reference" meaning that we
> > haven't yet agreed on a merge plan yet.
> 
> I think this series makes sense to be pushed through a single tree as
> opposed to being spread between 3, even if it could technically be
> possible. It looks like Jonathan is fine with going it through either
> his or some other tree, I am fine with it going through MFD.

I'm happy either way.

> I just Acked the 2 input-related patches.

Thanks Dmitry.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
