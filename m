Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54612C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A83218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Up0S9Iu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfAZMOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:14:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39505 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:14:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so10512256ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 04:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieK0upQLqMJui7RpQs8JVtiE3Kg8Nd2QYVCYl1nFVRM=;
        b=Up0S9Iu06Gzi06mgB5q0MgUvkoz1CBmalcB+VQNGgfY+NUJ90QkacpCR8Xess7s0Bd
         CGrUsrv7MilsNBMg98otNhmUETwLPdc0ZBDlFmuZp1JsaWyo201n0yo3/dVkDKLO4dZv
         xsOz0Xz4iczxzdguwe6X0DOzrbKKG+BmriPE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieK0upQLqMJui7RpQs8JVtiE3Kg8Nd2QYVCYl1nFVRM=;
        b=qDmSmFP5ymfkI6RiCtzTS6xRMmRuL9uXmR+nvi0JWtSEN/S9FJBfNyoh/s+c8XlvGv
         WMN9BSbzS2FqtYryYCzUeS9Md+35eBk2AvfuvrIAdZ8OAm1MID4sSd4fm1QWj+xbUiRr
         SX0NsMgba+7r787wfaSHyowBeUoXpYXF98IRiRJ4acqhFrrqtRP3sGz3jflnMV5CX50w
         hKLv8hyJvZjV/bh6kga6gHaBzZDGPM0ISXTy77UMwUCYI/Bo1M2DxF1h/v2wcfEaWkU7
         fS+Al3gx8fufetOfxqg6ctnmNiTslCPjlrhhK1A0V83JBE40KlhFQkO9oV8L44FxshTq
         3o3g==
X-Gm-Message-State: AJcUukfYdCRnCQlsRVJB+tjQhHM8B5mllO6Qi3kYrQtMc1UFisarnWIY
        ijgW8LuO9ltMHggzWECzJczDZ/mGynll31TOKCW3Zw==
X-Google-Smtp-Source: ALg8bN6X8sE48K+SC5dokcRjPoKpevxROiXfyPdf8CDtnpUCqxTqDwGvXHd0NE4ENUXM1g1hmaXzoLmWjE9rwfYls+E=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr11634232ljh.135.1548504855080;
 Sat, 26 Jan 2019 04:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com> <20190125174442.GR9224@smile.fi.intel.com>
In-Reply-To: <20190125174442.GR9224@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Jan 2019 13:14:03 +0100
Message-ID: <CACRpkdZecFta8JaW85C0HyuH-LLD3bFsPf8DNna9o83OdkfU5w@mail.gmail.com>
Subject: Re: [RFT][PATCH v2] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 6:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Jan 21, 2019 at 02:03:09PM +0100, Linus Walleij wrote:
> > On Wed, Jan 9, 2019 at 11:52 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > New quirk enforces search for GPIO based on its type,
> > > i.e. iterate over GpioIo resources only.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >
> > > - it was sent few weeks ago to Hans for testing, but better to re-test
> > > - it's supposed to go via ASoC subsystem due to recent changes made for
> > >   sound driver
> > >
> > > v2:
> > > - Expand explanation why this quirk might be needed (Mika)
> >
> > I tried to apply this but it doesn't apply on the GPIO devel
> > branch.
> >
> > I suppose because of Hans de Goede's
> > commit 72893f0c6bd399ce84e3c1c9fc69d234fe37d098
> > Author: Hans de Goede <hdegoede@redhat.com>
> > Date:   Mon Dec 31 21:55:21 2018 +0100
> >
> >     gpiolib-acpi: Preserve non direction flags when updating gpiod_flags
> >
> > Could you rebase and resend?
>
> Linus, as I mentioned in comments above this should go via ASoC tree, there is
> no conflicts with gpio/devel for GPIO matters.
>
> So, please, give your Ack and hopefully Mark will apply this soon.

OK with me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
