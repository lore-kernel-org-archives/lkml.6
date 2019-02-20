Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9788DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBBD20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550700106;
	bh=b1V4X8VwoeogINSDrQvu6rQo79wgvQir/lEC/Oqv/ys=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=om469ZBuvaaQsUJ/vW3Jmg0i5y0LxFf67ssNCoedr+8KVwagxLTeOPq3TgnBqsFko
	 NxujAMxHrWRRgoympdjjlTg5mSC/kL4rgM78h1pF5Uj5WG27EbQ9tJsIunXfOEqKeU
	 sQ1ObQ9bOArOHVQUnytblFlxN0op4e12taNLEDGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfBTWBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:01:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBTWBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:01:44 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74FE2086C;
        Wed, 20 Feb 2019 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550700103;
        bh=b1V4X8VwoeogINSDrQvu6rQo79wgvQir/lEC/Oqv/ys=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=vnFq9iOxmiCkVYTOsgqNCTLHSQu2AiCJIHfYaPkmJUl1mP6IGrndGai/jIUvXsjYx
         TH5XFVxz2zErxThADQf6TsCK/IjYan0QNoo9ketF8be69Kt4+2u4RVJ5P5nH3Ag9be
         8UaJMIOD9OBcnPijkDp6BxjhOs6B2w7Eohxmzi1Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on setting driver_override
Message-ID: <155070010208.77512.17397936280518534534@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550484960-2392-1-git-send-email-krzk@kernel.org> <CAMuHMdWXy_0zL8FZWapPj4+cXRd0wHy9buLhf0D0txpAHPkK7Q@mail.gmail.com> <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAJKOXPe1CW4k4ivbh4QhKEbuVc3RRNmzUwQcL0BsrAn=hCdjZg@mail.gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
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
Date:   Wed, 20 Feb 2019 14:01:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2019-02-18 03:14:29)
> On Mon, 18 Feb 2019 at 11:40, Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
> >
> > Hi Krzysztof,
> >
> > On Mon, Feb 18, 2019 at 11:27 AM Krzysztof Kozlowski <krzk@kernel.org> =
wrote:
> > > The problem
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Several device types (platform, amba, spi etc.) provide a driver_over=
ride
> > > field.  On sysfs store or during device removal, they kfree() the
> > > existing value.
> > >
> > > However the users are unaware of this and set the driver_override lik=
e:
> > >
> > >         pdev->driver_override =3D "exynos5-subcmu";
> > >
> > > which obviously leads to error.
> >
> > IMHO driver_override is not meant to be set by a driver, only from user=
space,
> > for binding the device to vfio (is there another use case?).
> >
> > >   clk: samsung: exynos5: Fix kfree() of const memory on setting
> > >     driver_override
> > >   slimbus: ngd: Fix kfree() of const memory on setting driver_override
> >
> > I see all users set override immediately after allocating a platform de=
vice.
> > Can't they just allocate a platform device using the override name inst=
ead?
> > What am I missing?
>=20
> For the clk-exynos5-subcmu.c case, driver registers several
> sub-devices. Each sub-devices is a clock controller associated with
> power domain. I guess the author wanted to have meaningful names of
> these sub-devices (DISP, CAM etc. like names of power domains),
> instead of just exynos5-subcmu.1, exynos5-subcmu.2 ...
>=20
> If driver_override should not be used for such case, then I could
> replace it with what you said.

Looking at the introduction of the code into the platform bus makes it
sound like it was all for vfio devices. If the clk driver doesn't need
it for that purpose and can get by with more generic names then it seems
best to avoid using it entirely. So can you do that and resend the first
patch in this series too? Effectively splitting the clk parts from the
larger issue of kfree()ing of const memory.

