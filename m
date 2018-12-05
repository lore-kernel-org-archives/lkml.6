Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C82C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A1D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1aSbESR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A1D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeLEHZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:25:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39141 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:25:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so9297775wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jQI5QB2zWD2HACaA3OnxgaHUN8Kq2Iivz0sMx7foRUg=;
        b=M1aSbESRvmrvwm+NG2oIYxhwlJUPCz9vPU/3QnDosw58OsujpHEvLI95bQkMLnzvGh
         OVgnzN7tTWK18UOfH220x7qLN8sQyjgbfUm21pOB03itfV5O7nVRxL5XSc8VSJcONk8H
         tYgxrNsy4Qokb/oM2mteIHjg3m3sz0ywPzyNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jQI5QB2zWD2HACaA3OnxgaHUN8Kq2Iivz0sMx7foRUg=;
        b=asBPiNiLeK6XIGXkcE1sGw6s8rOR2vNAoMsR7cY1w4pyCGJfWPt57YQx3jORZzK2Ly
         wZKiFjJHCzp4eXaLVWpVQLECQ1DKR97B3wLPwN5cMUDBnLrB1+7goYkosrwdl9dcxgb8
         tf7vQfql/VJfOYV65QgOpLl3/UR8nF7Xtm/v0ADQDRedYXP4ySHf8mQTyc2iFfRb4kNd
         gSUzHLj63VXrTIWPf9O09E8cYztzoPfXWyHmQ50okHdKncswh5AjxlONEoR9ddBFIEeJ
         kLxoJmNsFKY0CtVG/s2JiXZ4SF8b8ogLg8jSVs0gDqflIptAf1bkVshAJqOmtEvoRqi1
         MlQA==
X-Gm-Message-State: AA+aEWai4VP1+gpSzQYM1aSLfz9Qiaw0M52ReXk8zQU34SV8iCeNGabE
        SK4ifRQBLmll75rid+3Vl2xdVg==
X-Google-Smtp-Source: AFSGD/Wp26pPW/gb4Q2HPFqZ4bCCsiQVScMx56ysnlpk/eQReM7xDQgLoSjB7fQta+IesBzVYIhLYg==
X-Received: by 2002:a1c:20cb:: with SMTP id g194mr14272235wmg.77.1543994726408;
        Tue, 04 Dec 2018 23:25:26 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id d2sm14136352wrs.97.2018.12.04.23.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 23:25:25 -0800 (PST)
Date:   Wed, 5 Dec 2018 07:25:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
Message-ID: <20181205072523.GW26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-3-enric.balletbo@collabora.com>
 <20181203103619.GD26661@dell>
 <59c6fa0a-e5d5-0e4a-9393-0c9a8b26332d@collabora.com>
 <20181204092121.GR26661@dell>
 <8dcf0fb8-697f-8443-68c3-0faae6fe412e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8dcf0fb8-697f-8443-68c3-0faae6fe412e@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018, Enric Balletbo i Serra wrote:
> On 4/12/18 10:21, Lee Jones wrote:
> > On Mon, 03 Dec 2018, Enric Balletbo i Serra wrote:
> >> On 3/12/18 11:36, Lee Jones wrote:
> >>> On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> >>>
> >>>> The entire way how cros sysfs attibutes are created is broken.
> >>>> cros_ec_lightbar should be its own driver and its attributes should be
> >>>> associated with a lightbar driver not the mfd driver. In order to retain
> >>>> the path, the lightbar attributes are attached to the cros_class.
> >>>
> >>> I'm not exactly clear on what a lightbar is, but shouldn't it live in
> >>> the appropriate subsystem.  Like LED for example?
> >>>
> >>
> >> The lightbar is a four-color indicator available on some Chromebook, but the
> >> fact that can you can program this lightbar with different sequences, including
> >> user defined sequences makes the device a bit special and very chrome platform
> >> specific. The same happens with the VBC driver.
> > 
> > Being Chrome specific doesn't necessarily mean that these drivers
> > shouldn't reside in a proper subsystem.  A lot of drivers in the
> > kernel are only relevant to very specific hardware/platforms.
> 
> Agree, and we try to put these drivers in their subsystem when we think it is
> appropriate (we have in rtc, power, iio, keyboard, etc.)

Right.  I can see that.  This is good.

> > IMHO code in drivers/platform should pertain only to the core platform
> > itself.  Any drivers for leaf hardware/functionality should be split
> > out into the subsystems, however niche you think they are.
> 
> To be honest, I don't have a hard opinion yet on if the drivers/platform should
> pertain only to the core platform itself.
> 
> The cros_ec_lightbar.c file already exists in drivers/platform, the patch just
> converts it to a kernel module (only adds few lines). The main purpose of the se
> patches was have cros-ec mfd code and their subdrivers separated instead of
> having crossed calls.

Right.  I have no intention of blocking *this* patch.  All we're doing
here is highlighting potential issues I see.

> I don't mind to move to another subsystem (I need to discuss with the chromium
> guys

Wonderful.  That's exactly what I wanted to hear.

> and I am still not sure if LED fits very well in this case, I can look in
> more detail)

Sure.

> but shouldn't be this a follow up patch?

Absolutely.

> I am also worried on how this could affect the current user interface. Well,
> something to look, right.

Right.

Thanks again for looking into this.  I will re-review your patch, this
time *not* taking the location of the driver into consideration.

> > I also understand the convenience factor of not having to go through
> > a !Google Maintainer, but this is not a loophole I'm prepared to
> > support. ;)
> > 
> >> Other subdevices like, rtc, keyboard, usbpd charger,etc. are already in their
> >> subsystems.
> >>
> >>>> The patch also adds the sysfs documentation.
> >>>>
> >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>> ---
> >>>>
> >>>> Changes in v3:
> >>>> - Removed unneded check for ec_dev.
> >>>>
> >>>> Changes in v2:
> >>>> - Removed the two exported functions to attach/detach to the cros_class.
> >>>> - Use dev_warn instead of dev_err when adding the lightbar.
> >>>>
> >>>>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
> >>>>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
> >>>>  drivers/mfd/cros_ec_dev.h                     |  6 --
> >>>>  drivers/platform/chrome/Kconfig               | 10 ++
> >>>>  drivers/platform/chrome/Makefile              |  3 +-
> >>>>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
> >>>>  include/linux/mfd/cros_ec.h                   |  1 -
> >>>>  7 files changed, 172 insertions(+), 41 deletions(-)
> >>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
> >>>
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
