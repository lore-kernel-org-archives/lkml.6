Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC06C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DC02084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAhhNjYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DC02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeLEIJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:09:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42131 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:09:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so18596044wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 00:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NohrWxKwj05KFHSFSUyN4vzhRc36GwAw98ReZCIpXN0=;
        b=dAhhNjYev6iBwDtmeAeiWKUOhn1k0RsbmuIYBzGVlT+fzucd581d/gd/9ziMgvDUXM
         wztRmWxsiWpeUzlBacqkiQhHO3cIO06inEjvd4YnRq8KpYEIaxHWRm1yyKUI7JQfbxQO
         sDlEhHlBzBjSa/dzUDlMNrxrt7cPO5Ubj/HVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NohrWxKwj05KFHSFSUyN4vzhRc36GwAw98ReZCIpXN0=;
        b=Kvgk9vkaSQ18vY/6Et6HUkcLhi36afXpXH3u2U0MGvGIFZjG8CvUE+Sza0e0yPOqGR
         hs6WUfryfXoThuf5hXXjlQjmGOygMywgy6+oubM4RJIGdeliOfzD95ejErlK4NyVZfz1
         5FKNPEzyimRrYebnirGQ3c2IhwUY1U2dwvJ6mmWyt6A3e+Ym9IE1RTY2GKVdGVDZLlAr
         Ll+b/u6U38tV9mzHCgo00ZN3lnGbLGaQMUTUexodzplwc+qcCkRsGVPIHXif8CONdwGI
         +9iVv6urrA4nnu09lKvLCTfP6N5N6yFnINXex8FQryecJ4RMPry0X1gJuUmloOWYQTw5
         fglw==
X-Gm-Message-State: AA+aEWYBs3M1R6o4BgX4UK6jg7iLeA51ycuMgXnQ9UzEeMSJIUTJlaZc
        kLNLqVrlF13tIt56Qh6eOsdGyA==
X-Google-Smtp-Source: AFSGD/VVMkehnws9vv168lsn2DoXoyeJAYNqwq/PCfTvpUqFGf7QoiEqLS/XFIONmraSG74Oo9bvQg==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr21720324wrx.298.1543997377180;
        Wed, 05 Dec 2018 00:09:37 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id h131sm17467784wmd.17.2018.12.05.00.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 00:09:36 -0800 (PST)
Date:   Wed, 5 Dec 2018 08:09:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
Message-ID: <20181205080934.GX26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-3-enric.balletbo@collabora.com>
 <20181203103619.GD26661@dell>
 <59c6fa0a-e5d5-0e4a-9393-0c9a8b26332d@collabora.com>
 <20181204092121.GR26661@dell>
 <8dcf0fb8-697f-8443-68c3-0faae6fe412e@collabora.com>
 <CABXOdTfMC01nmV97x6kKKqavp9qEesXWVYOU3q0ib8hq0_g4+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTfMC01nmV97x6kKKqavp9qEesXWVYOU3q0ib8hq0_g4+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018, Guenter Roeck wrote:
> On Tue, Dec 4, 2018 at 3:52 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> > On 4/12/18 10:21, Lee Jones wrote:
> > > On Mon, 03 Dec 2018, Enric Balletbo i Serra wrote:
> > >> On 3/12/18 11:36, Lee Jones wrote:
> > >>> On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> > >>>
> > >>>> The entire way how cros sysfs attibutes are created is broken.
> > >>>> cros_ec_lightbar should be its own driver and its attributes should be
> > >>>> associated with a lightbar driver not the mfd driver. In order to retain
> > >>>> the path, the lightbar attributes are attached to the cros_class.
> > >>>
> > >>> I'm not exactly clear on what a lightbar is, but shouldn't it live in
> > >>> the appropriate subsystem.  Like LED for example?
> > >>>
> > >>
> > >> The lightbar is a four-color indicator available on some Chromebook, but the
> > >> fact that can you can program this lightbar with different sequences, including
> > >> user defined sequences makes the device a bit special and very chrome platform
> > >> specific. The same happens with the VBC driver.
> > >
> > > Being Chrome specific doesn't necessarily mean that these drivers
> > > shouldn't reside in a proper subsystem.  A lot of drivers in the
> > > kernel are only relevant to very specific hardware/platforms.
> >
> > Agree, and we try to put these drivers in their subsystem when we think it is
> > appropriate (we have in rtc, power, iio, keyboard, etc.)
> >
> > > IMHO code in drivers/platform should pertain only to the core platform
> > > itself.  Any drivers for leaf hardware/functionality should be split
> > > out into the subsystems, however niche you think they are.
> > >
> >
> > To be honest, I don't have a hard opinion yet on if the drivers/platform should
> > pertain only to the core platform itself.
> >
> > The cros_ec_lightbar.c file already exists in drivers/platform, the patch just
> > converts it to a kernel module (only adds few lines). The main purpose of the se
> > patches was have cros-ec mfd code and their subdrivers separated instead of
> > having crossed calls.
> >
> > I don't mind to move to another subsystem (I need to discuss with the chromium
> > guys and I am still not sure if LED fits very well in this case, I can look in
> > more detail) but shouldn't be this a follow up patch?
> 
> Separate patch, please, if anything.

Agreed.

> I would not know which subsystem to move this to, though, and moving
> it to misc just for the sake of it would seem odd, since this most
> definitely _is_ platform related code. What is platform for if not for
> platform specific code ?

"platform" has very broad and varying meanings in Computer Science
nomenclature.  Unfortunately, it can be used to describe quite a lot
of different aspects of the (I wanted to say platform then) hardware.

All drivers are 'platform' device drivers, that's why we have the
platform_device_*/platform_driver_* API.  Saying that "platform
specific code" should live in */platform reminds me of the
arch/*/<platform> days when similar arguments were put forward with
respect to jamming all "platform specific code" into arch/*.  A great
deal of effort was put in to relocate it all into the proper
subsystems.

What I see here is the backslide into the same mind-set.

My guess is that defining what 'platform' means in the context of
drivers/platform is not going to be straight forward, however; I have
always seen it as a place to put *core* platform code, perhaps an API
akin to the one used for the EC in the Chromium context is a good
example.  Drivers required to control peripherals that, for instance,
operate a set of LEDs, I would not consider core platform code.

In my mind, *any* and *all* leaf and peripheral drivers should be
relocated into a proper subsystem.  Even if that is drivers/misc.

> > I am also worried on how this could affect the current user interface. Well,
> > something to look, right.
> 
> No ABI changes, please.

Without seeing the way in which a user controls this stuff, it's
difficult to comment, but a change in subsystem usually means a shift
in control.  Particularly if that control is operated via SYSFS.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
