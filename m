Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08853C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B6E217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550488486;
	bh=l8/9w6Kg/HHsnA8sN8sMtyT/9DJbnt7UQ+0dwdA0srs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e+f66sIlaDQqwtYNBNsVU/Ge02rlbsigumkzzWlqg/qut1OlURPEvC2JWPdfLVyIy
	 oJy50wo14yI+O2XENNUxzMdSUBXjx+QxU1oztO22FN4G7l91br5NwQiMA/mW6o+X+f
	 zQsb8sq4Q8tCU1xiy5KALoMG8WD33qnbcyB298V8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfBRLOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbfBRLOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:14:44 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE43121873;
        Mon, 18 Feb 2019 11:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550488483;
        bh=l8/9w6Kg/HHsnA8sN8sMtyT/9DJbnt7UQ+0dwdA0srs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HU0x6AtcWVoOlImdWayNlRcexgbQ0gIOtgEh5oUqYbP2vKp8OiBrstluSYsZS1aPY
         oOALT4iY1810zG3xNYsZL4ysJByrbor7U50TEXsJrqL3rzTycv5oI7xAexDoAT1n82
         vMK5jCmM2UYI2jVK+C++8oe0zKEtnk3H8l8ZAHR8=
Received: by mail-lf1-f52.google.com with SMTP id v7so12010229lfd.2;
        Mon, 18 Feb 2019 03:14:42 -0800 (PST)
X-Gm-Message-State: AHQUAuaXFwtdlSn2+8OOadesJlF6qP0loSB37GVbuzuRCEJhfTqK1RGh
        kMh8hqI6CZz2+CxRxhPQcb9QegmEAfq3BzA9jzQ=
X-Google-Smtp-Source: AHgI3IYGbp2ThDqPrK0+LuwjhtPDUOImmT3j8Qojj2Dqt4lNUi8vf64u/CyDAOCL7Ui3jFkbOlffZuvWvxNpYWQAbes=
X-Received: by 2002:a19:4948:: with SMTP id l8mr14548354lfj.156.1550488481012;
 Mon, 18 Feb 2019 03:14:41 -0800 (PST)
MIME-Version: 1.0
References: <1550484960-2392-1-git-send-email-krzk@kernel.org> <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Feb 2019 12:14:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
Message-ID: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > The problem
> > ===========
> > Several device types (platform, amba, spi etc.) provide a driver_override
> > field.  On sysfs store or during device removal, they kfree() the
> > existing value.
> >
> > However the users are unaware of this and set the driver_override like:
> >
> >         pdev->driver_override = "exynos5-subcmu";
> >
> > which obviously leads to error.
>
> IMHO driver_override is not meant to be set by a driver, only from userspace,
> for binding the device to vfio (is there another use case?).
>
> >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> >     driver_override
> >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
>
> I see all users set override immediately after allocating a platform device.
> Can't they just allocate a platform device using the override name instead?
> What am I missing?

For the clk-exynos5-subcmu.c case, driver registers several
sub-devices. Each sub-devices is a clock controller associated with
power domain. I guess the author wanted to have meaningful names of
these sub-devices (DISP, CAM etc. like names of power domains),
instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...

If driver_override should not be used for such case, then I could
replace it with what you said.

For the other uses of driver_override (drivers/rpmsg/rpmsg_internal.h
and drivers/slimbus/qcom-ngd-ctrl.c) I don't know.

Best regards,
Krzysztof
