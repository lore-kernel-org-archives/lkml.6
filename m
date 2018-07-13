Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ACECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A432124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DXm437ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A432124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGMHjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:39:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35412 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbeGMHjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:39:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so23824951edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qO9mNzsDQ+LGFEnBAi0O/hnQl2YU15tJUf1iGnZayw=;
        b=DXm437ly6/VH+jBHgXjO82xjCr0BIS8jTeNv2gBuSIu3+hioGlF9m8ziHYs5sXhf7P
         dArTAb/2bEf/7/muAJ1pNpBEjkBaJXASDJ3w05KOGgjD3a4TR3Hq+/WwnRhulurGArdw
         07KW4EhgCfd/9dgGU4vteiKuFgCEYLdDvgsW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3qO9mNzsDQ+LGFEnBAi0O/hnQl2YU15tJUf1iGnZayw=;
        b=YKssjNXC7LlRahXJoq8hvtYUcWD/+ywASec1XjI2gdePhbDc9uncAvUD+g+RtC9kzT
         vtjuvLM69gUf/OIjotyYQNJvKHM+/QWUGDhs7/Y3t6XXGGd9tHAaK0ETwCteK9KXRxuT
         yYPpObaNpWOrTRxQQpFVtwY8I/+4p145f/xqqKYvB9OyouHXtHVlTfxJHrgcxMd75prK
         rTrxR1QVBKyv2RM0sHhKWc6APzNkFHZU3dN2mJpvVwCx65ruXjiKg2tImFMzYVTl6TFf
         RBKnvtuxJDE6vwoVbn/jgFEwWKME79D7CVxau3LI+tjrcqVvLz94Yl0r+I/lS931zdTQ
         phOA==
X-Gm-Message-State: AOUpUlHcG5Jm1gOKezw/liVRo9eu/+OmmR1QvSR9p/j1pVb0N37rStXa
        xMbDyAQH75YZyf1eEUhtlDpsmg==
X-Google-Smtp-Source: AAOMgpfbIfOCl+gqbmaFhH/vLrMopJc6P5NR3Y+B9TamsZYPPUrcxDCPTmBjM2LcqrbArHlmik9gZQ==
X-Received: by 2002:a50:ba6e:: with SMTP id 43-v6mr5943569eds.292.1531466739752;
        Fri, 13 Jul 2018 00:25:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id d15-v6sm272583edm.66.2018.07.13.00.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:25:38 -0700 (PDT)
Date:   Fri, 13 Jul 2018 09:25:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Marek Vasut <marex@denx.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-ID: <20180713072536.GX3008@phenom.ffwll.local>
Mail-Followup-To: Marek Vasut <marex@denx.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
 <fd22085f646d97f66cff5b7f22785500@agner.ch>
 <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
 <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
 <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
 <039b2914-3393-5e81-82a6-7d517c5818a9@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039b2914-3393-5e81-82a6-7d517c5818a9@denx.de>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 03:14:57PM +0200, Marek Vasut wrote:
> On 07/12/2018 03:03 PM, Leonard Crestez wrote:
> > On Thu, 2018-07-12 at 11:21 +0200, Stefan Agner wrote:
> >> On 10.07.2018 11:11, Marek Vasut wrote:
> >>> On 07/10/2018 11:06 AM, Stefan Agner wrote:
> >>>> This is one of the situation where states quo is kinda the worst
> >>>> situation.
> >>>>
> >>>> Currently imx_v6_v7_defconfig and mxs_defconfig actually still uses
> >>>> CONFIG_FB_MXS.
> >>>>
> >>>> I understand that you'd rather prefer to move forward. I suggest we do
> >>>> it in steps.
> >>>>
> >>>> In 4.19:
> >>>>
> >>>> - Change DRM driver.name to mxsfb-drm so we avoid conflicts for now
> >>>
> >>> But this will break mesa if it depends on mxsfb name for ie. etnaviv
> >>> binding.
> >>
> >> Does it? grep -r -e mxsfb in libdrm and mesa master returns nothing.
> >>
> >> There is also .name in struct drm_driver, which is already set to
> >> mxsfb-drm... Is that the one exposed to user space?
> > 
> > Running etnaviv+x11 with a renamed mxsfb driver works fine on imx6sx-
> > sdb.
> > 
> > Tools like modetest already need -M mxsfb-drm, the drm_driver.name
> > seems to be what matters.
> > 
> >> - Remove CONFIG_FB_MXS from imx_v6_v7_defconfig/mxs_defconfig now, and
> >> only enable CONFIG_DRM_MXSFB=y
> > 
> > If one of the drivers is renamed then they can coexist: since the
> > bindings are distinct one driver will return a probe error and the
> > other will bind successfully. This can even be adjusted so that it
> > doesn't even print ugly scary errors.
> > 
> > This can last until somebody implements support for old bindings in the
> > drm driver and then FB_MXS can just be deleted.
> 
> So why don't we just convert the DT bindings on boards supported
> upstream and zap the old driver ? What is the problem with that?

+1 on zapping drivers :-)

> Realistically, how many MXS boards in the field use old DT and new kernel ?

Yeah I think occasionally that entire "DT is API, can't ever change it"
song is overblown. The rule with regressions isn't that you're never
allowed to break anything, but that you're only allowed to break stuff no
one will notice and report.

If there's realistically no users, go ahead and break (instead of huge and
drawn-out compat plan).

If there's a solid (and automatic enough) fallback like the drm driver,
go ahead and break.

We're doing this all the time in graphics with userspace ABI, I don't
think DT is any different. Every once in a while there's a bit of regrets
and a revert because we missed something, but overal it's much less effort
than always trying to do a perfect job with backwards compat.

Is it really a regression if no one reports it? No.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
