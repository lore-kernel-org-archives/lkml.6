Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D3FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AFA20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEf9yEUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AFA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbeLDJV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:21:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40444 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:21:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so8457291wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZRSlY/mKwY7K9Dn7frNi1hQy6fHKFtSbQIraMA6on8M=;
        b=WEf9yEUpDD3oW3grLEUxRjaF670GLO4Vk+Q4CbH+W5U7Cud2qLT0oM+unfRSCw8Ozv
         tww3FuIO7Nf+ZUZxIEcHjIzs3xvBNnwObXBw7sTLnuPtIyFCv3xA8qe4OAyU7l4F2DfJ
         0DuqCkYzJj8QejG9r9i9tFIRU1GSYCvKzXirI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZRSlY/mKwY7K9Dn7frNi1hQy6fHKFtSbQIraMA6on8M=;
        b=sKkgTfJwh50QOWRygnXhvKelBBMsL7szg8eGgGKo3gZ8Sy/ShnZAXlN6SLmsrP78oF
         Ubuqh6AxGYaGq3WMOLOJX/BsntBYTa92Zmoz7KSLLFuS3Im7u+uhDPIjgqIIw6WOSAxl
         qc7c5rL8BbxGhtTF6AxIe8xqnIDJABY9siSX8Pft0Azhh4ibt6crRtMXedm7GQn+LUj2
         dWNU0Kti8jhGFv2LeHxcQYt05mVvRpykNIjgpMO8pmpl/1fCPclvOStRMJQoEmCKSokV
         5BeoysCF5of0PO4zw5Tp7A8A+tIIAo/hawBFtq+4nQ+mGp0DeQfcz9v3Ic/4GtaKn0+F
         5OLA==
X-Gm-Message-State: AA+aEWb31+8TFJyHWCqTtDtRaJJ0JXpRNEP4gT+dZ2s0ha+/lmEBwaav
        qyvjpcoaxSUVOQfNCNZbXecUiQ==
X-Google-Smtp-Source: AFSGD/XShMnJsci+7IZL4kDSAkejsDB+dYQtypxdsRAXECcN2JpUTs6DF84bz8FmF38HSB4ceOvdkQ==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr11192173wmf.132.1543915283710;
        Tue, 04 Dec 2018 01:21:23 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id m4sm5788563wmc.3.2018.12.04.01.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:21:22 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:21:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
Message-ID: <20181204092121.GR26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-3-enric.balletbo@collabora.com>
 <20181203103619.GD26661@dell>
 <59c6fa0a-e5d5-0e4a-9393-0c9a8b26332d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c6fa0a-e5d5-0e4a-9393-0c9a8b26332d@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018, Enric Balletbo i Serra wrote:
> On 3/12/18 11:36, Lee Jones wrote:
> > On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> > 
> >> The entire way how cros sysfs attibutes are created is broken.
> >> cros_ec_lightbar should be its own driver and its attributes should be
> >> associated with a lightbar driver not the mfd driver. In order to retain
> >> the path, the lightbar attributes are attached to the cros_class.
> > 
> > I'm not exactly clear on what a lightbar is, but shouldn't it live in
> > the appropriate subsystem.  Like LED for example?
> > 
> 
> The lightbar is a four-color indicator available on some Chromebook, but the
> fact that can you can program this lightbar with different sequences, including
> user defined sequences makes the device a bit special and very chrome platform
> specific. The same happens with the VBC driver.

Being Chrome specific doesn't necessarily mean that these drivers
shouldn't reside in a proper subsystem.  A lot of drivers in the
kernel are only relevant to very specific hardware/platforms.

IMHO code in drivers/platform should pertain only to the core platform
itself.  Any drivers for leaf hardware/functionality should be split
out into the subsystems, however niche you think they are.

I also understand the convenience factor of not having to go through
a !Google Maintainer, but this is not a loophole I'm prepared to
support. ;)

> Other subdevices like, rtc, keyboard, usbpd charger,etc. are already in their
> subsystems.
> 
> >> The patch also adds the sysfs documentation.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >> Changes in v3:
> >> - Removed unneded check for ec_dev.
> >>
> >> Changes in v2:
> >> - Removed the two exported functions to attach/detach to the cros_class.
> >> - Use dev_warn instead of dev_err when adding the lightbar.
> >>
> >>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
> >>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
> >>  drivers/mfd/cros_ec_dev.h                     |  6 --
> >>  drivers/platform/chrome/Kconfig               | 10 ++
> >>  drivers/platform/chrome/Makefile              |  3 +-
> >>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
> >>  include/linux/mfd/cros_ec.h                   |  1 -
> >>  7 files changed, 172 insertions(+), 41 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
