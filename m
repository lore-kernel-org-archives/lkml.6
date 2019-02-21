Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B34320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749427;
	bh=uxodDM8DcIH3DFJRf934Ta55iD7dtEytKxV92UjmqeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E7lElBryvZHInDaMoQbBw1WzlGOXVYi81ByEaAKnNU8M3OgsvLTeAK5ajMX9h5MoS
	 tOpJu9KEgo1TJwu/d8X4Y1oKjY/JBbfuArqKPFgf/6A+jAU72ZSrOrrnYdjs/xmNNY
	 uVCNvKa2Tl2AMTTCPLrWYrHO3DdgSG0oDM5PCwMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfBULnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBULnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:43:45 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF23218D8;
        Thu, 21 Feb 2019 11:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550749423;
        bh=uxodDM8DcIH3DFJRf934Ta55iD7dtEytKxV92UjmqeI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mWTLE8h/Lv6/fQgKksVECU0Esfe1cnrxar+Gpek8lGgTSmKdyrY+VCf1W58l2Bm2i
         b3Oke1FdCzh9MU7Z703X0PuIpHVogTMCjhGq47J2ULY5BjqymLAvNKg8LW9Vu5KQ9s
         hTLD6PasBETPnup5ZcQwIbLFVtqbWl0oWDrKPK6E=
Received: by mail-lj1-f172.google.com with SMTP id s5-v6so23646671ljd.12;
        Thu, 21 Feb 2019 03:43:43 -0800 (PST)
X-Gm-Message-State: AHQUAuZo9Yqv42qkNaz4T5zm00HGzzMHXqZ7EH+Erm48wPj1BUwaeiOg
        0Gx/yePNT5M3huUL4Vdhq1RPL/3zsFmexMuHSSE=
X-Google-Smtp-Source: AHgI3IZNZsanInxkXFUrNJne8zWhKWZSRpL4jzRErZ+/B+6LAWL7rvdLBlsvjSdwbsFS7QIgo54g0gcKMPfX700vRDQ=
X-Received: by 2002:a2e:3c10:: with SMTP id j16mr1213830lja.113.1550749421489;
 Thu, 21 Feb 2019 03:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
 <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com>
 <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com> <155070010208.77512.17397936280518534534@swboyd.mtv.corp.google.com>
In-Reply-To: <155070010208.77512.17397936280518534534@swboyd.mtv.corp.google.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Feb 2019 12:43:29 +0100
X-Gmail-Original-Message-ID: <CAJKOXPc=mKrNuw65qf=vPtRD7b7=5FZWdNcncvwhpDN+tqp0Bw@mail.gmail.com>
Message-ID: <CAJKOXPc=mKrNuw65qf=vPtRD7b7=5FZWdNcncvwhpDN+tqp0Bw@mail.gmail.com>
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Kukjin Kim <kgene@kernel.org>,
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

On Wed, 20 Feb 2019 at 23:01, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Krzysztof Kozlowski (2019-02-18 03:14:29)
> > On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Krzysztof,
> > >
> > > On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > The problem
> > > > ===========
> > > > Several device types (platform, amba, spi etc.) provide a driver_override
> > > > field.  On sysfs store or during device removal, they kfree() the
> > > > existing value.
> > > >
> > > > However the users are unaware of this and set the driver_override like:
> > > >
> > > >         pdev->driver_override = "exynos5-subcmu";
> > > >
> > > > which obviously leads to error.
> > >
> > > IMHO driver_override is not meant to be set by a driver, only from userspace,
> > > for binding the device to vfio (is there another use case?).
> > >
> > > >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> > > >     driver_override
> > > >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
> > >
> > > I see all users set override immediately after allocating a platform device.
> > > Can't they just allocate a platform device using the override name instead?
> > > What am I missing?
> >
> > For the clk-exynos5-subcmu.c case, driver registers several
> > sub-devices. Each sub-devices is a clock controller associated with
> > power domain. I guess the author wanted to have meaningful names of
> > these sub-devices (DISP, CAM etc. like names of power domains),
> > instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...
> >
> > If driver_override should not be used for such case, then I could
> > replace it with what you said.
>
> Looking at the introduction of the code into the platform bus makes it
> sound like it was all for vfio devices. If the clk driver doesn't need
> it for that purpose and can get by with more generic names then it seems
> best to avoid using it entirely. So can you do that and resend the first
> patch in this series too? Effectively splitting the clk parts from the
> larger issue of kfree()ing of const memory.

Sure, let me send just the clk parts.

BR,
Krzysztof
