Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE65C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6AE208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iYbPlXRb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6AE208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755122AbeFRHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:43:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33953 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754721AbeFRHnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:43:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id l15-v6so13872404wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOG2pfeWl9hb6IAzVdoeUIDCAhZ05eNoe2uT6cijC2s=;
        b=iYbPlXRb4+RBdfVt8Ihw520iZodyw0rbhUIm5Bid9fycISyhhFs8qjQt/BQ4PS+yTS
         tX4dTPnIDMyzoCmkD55iJpwpA2KfERYrVkD93SN/P/FY4VhMngMTi9DuM8LfgmjIkJO8
         aaYoBwydmODyL/zy5js7JM7KYJxBjjS+IZfJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=tOG2pfeWl9hb6IAzVdoeUIDCAhZ05eNoe2uT6cijC2s=;
        b=cVP9KKxMGyy8InUL5FfEJInkCOZSx5zOmkXqG/MXz5jHxoH5Kzm5sGCQpQBxVd2AAK
         K1db5b61edBp0+2Q0g2j8z7ZJfYfPsLycfU7qpqg+UhU4z70c7eIGglKLPkOVRSyMEFW
         CUoTDAhDebthMBtnGdiQkWvcnwsEwxseENzh/oJg4P9/q51zU4yU6fPH2JO4ZaV+bnCO
         EEGzLoICW2wktZ29frJQ2X1cjtNaaOPO6RFwJmiCR0vqo29ij/h6/pOqWUZDDnzTggqM
         KqOADJOnJTJkXMyAntBUDQJU2DQFywAsTakFRemEjzhAwiiXkMriBu5uStUy3bHsH3gD
         s+8g==
X-Gm-Message-State: APt69E2OeqmfhzVnZ/RD79iUZx5sS3KFvLqRuh/Lp6guzqmwyQXYnIiP
        jXdFAa/ARyqgyi2HNqa220Spiw==
X-Google-Smtp-Source: ADUXVKIp/ZS+ZLtVCXs+PMM5PKol+zhAE9zMl5f1FPkva9ujdeAAYOtlDVH0hJoa2rTut1tkVuPQ8w==
X-Received: by 2002:a50:ad07:: with SMTP id y7-v6mr10560103edc.78.1529307803291;
        Mon, 18 Jun 2018 00:43:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:d0c7:bcda:eea:9e5d])
        by smtp.gmail.com with ESMTPSA id d16-v6sm7458237ede.21.2018.06.18.00.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 00:43:22 -0700 (PDT)
Date:   Mon, 18 Jun 2018 09:43:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Message-ID: <20180618074320.GS3438@phenom.ffwll.local>
Mail-Followup-To: Marek Vasut <marek.vasut@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "marex@denx.de" <marex@denx.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 01:32:44AM +0200, Marek Vasut wrote:
> On 06/16/2018 12:42 AM, Leonard Crestez wrote:
> > On Fri, 2018-06-15 at 23:36 +0200, Marek Vasut wrote:
> >> On 06/15/2018 10:58 PM, Leonard Crestez wrote:
> >>> On Fri, 2018-06-15 at 16:47 -0300, Fabio Estevam wrote:
> >>>> On Fri, Jun 15, 2018 at 4:43 PM, Leonard Crestez
> >>>> <leonard.crestez@nxp.com> wrote:
> > 
> >>>>> The FBDEV driver uses the same name and both can't be registered at the
> >>>>> same time. Fix this by renaming the drm driver to mxsfb-drm
> >>>>
> >>>> Stefan sent the same patch a few days ago:
> >>>
> >>> In that thread there is a proposal for removing the old fbdev/mxsfb
> >>> driver entirely.
> >>>
> >>> That would break old DTBs, isn't this generally considered bad? Also,
> >>> are we sure the removal of fbdev/mxsfb wouldn't lose any features?
> >>>
> >>> What my series does is make both drivers work with the same kernel
> >>> image and turns the choice into a board-level dtb decision. Supporting
> >>> everything at once seems desirable to me and it allows for a very
> >>> smooth upgrade path.
> >>
> >> Having two drivers in the kernel with different set of bugs is always bad.
> >>
> >>> The old driver could be removed later, after all users are converted.
> >>
> >> Both drivers were in for long enough already. And let's be realistic,
> >> how many MX23/MX28 users of old DTs with new kernels are there who
> >> cannot update the DT as well ?
> > 
> > Grepping for "display =" in arch/arm/boot/dts/imx* I see that old
> > bindings are also used by 3rd-party boards for imx6/7:
> >  * imx6sx-nitrogen6sx
> >  * imx6ul-geam
> >  * imx6ul-isiot
> >  * imx6ul-opos6uldev
> >  * imx6ul-pico-hobbit
> >  * imx6ul-tx6ul
> >  * imx7d-nitrogen7
> 
> Er, yes, a handful of boards which could be updated :)
> 
> > Converting everything might be quite a bit of work, and explicitly
> > supporting old bindings is also work.
> 
> Does adding support for old bindings justify the effort invested ? I
> doubt so, it only adds more code to maintain.
> 
> > It is very confusing that there is a whole set of displays for imx6/7
> > which are supported by upstream but only with a non-default config.
> > While it is extremely common in the embedded field to have custom
> > configs the default one in the kernel should try to "just work".
> > 
> > Couldn't this patch series be considered a bugfix? It was also
> > surprisingly small.
> 
> I think it's just a workaround which allows you to postpone the real
> fix, and I don't like that.

Yeah agreed, imo the proper fix here would be to either update the dts for
the affected boards and/or make mxsfb accept the old dt bindings for
backwards compat. Artificially extending the life of the fbdev drivers
seems silly.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
