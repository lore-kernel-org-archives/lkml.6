Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6C8C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8486321708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2nR3yZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8486321708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeHHIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbeHHIkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:40:23 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BEC821708;
        Wed,  8 Aug 2018 06:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533709333;
        bh=11LZTQvG81fkK+6D8MDEkTpiuu7m77ullkP3u0jM1Nc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=m2nR3yZTcjqdGkgvSp3oFVtxEmQP8TSeiUGELTzVOQGTv8sLwN+aV2PljZx+fJik7
         uaiZKUhAuNAPo5ktb9GWMtaG+HQTJp3prvxdFz2P2eowoUHKYUdqDfvXUI1fNEuTXU
         WgaW6uH8deArF2a92sTFkCNRDfEzYR7OzJGpe5+Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     skannan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
Cc:     Evan Green <evgreen@google.com>, tdas@codeaurora.org,
        rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, amit.kucheria@linaro.org
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
 <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
 <4d37a1ee4f2d5b30da3f62cbfca756a8@codeaurora.org>
Message-ID: <153370933225.220756.12056174025047430491@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Tue, 07 Aug 2018 23:22:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting skannan@codeaurora.org (2018-08-06 13:46:05)
> On 2018-08-03 15:24, Stephen Boyd wrote:
> > Quoting skannan@codeaurora.org (2018-08-03 12:52:48)
> >> On 2018-08-03 12:40, Evan Green wrote:
> >> > Hi Taniya,
> >> >
> >> > On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wro=
te:
> >> >>
> >> >> +               if (src)
> >> >> +                       c->table[i].frequency =3D c->xo_rate * lval=
 /
> >> >> 1000;
> >> >> +               else
> >> >> +                       c->table[i].frequency =3D INIT_RATE / 1000;
> >> >
> >> > I don't know much about how this hardware works, but based on the
> >> > mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
> >> > and 3 all mean xo_rate?
> >> >
> >> > Also, is INIT_RATE really constant? It sounds like gpll0 (or
> >> > gpll0_out_even?). You're already getting the xo clock, why not get
> >> > gpll0's real rate as well?
> >> =

> >> Actually I was about to comment and say NOT to get clocks just to get
> >> their rate. The XO_RATE is just a multiplication factor. This HW/FW =

> >> can
> >> change in the future and make the multiplication factor to 1KHz.
> > =

> > So future changes to this hardware are going to make this register
> > return the final frequency that we should use? Sounds great! But that
> > isn't how it's working right now. We need to have XO in the binding =

> > here
> > so the driver can work with different XO frequencies in case that ever
> > happens. Same story for GPLL0. Hardcoding this stuff in the driver just
> > means we'll have to swizzle things in the driver when it changes.
> =

> XO being a different frequency in a Qualcomm chip is way way less likely =

> than anything else we are discussing here. In the 10+years I've been =

> there this has never changed.
> =

> So, how about making this binding optional? If it's not present we can =

> make assumptions for XO rate and init rate. That'll handle your =

> hypothetical use case while also being optimized.

Optional properties are almost never correct for clks. Either the clk
goes there or it doesn't go there. The only time it's optional is if the
HW has the choice of generating the clk itself internally or to use an
external clk as input.

In this case, it's not optional, it's actually used so marking it
optional is highly confusing.

> =

> >> We also
> >> can't really control any of the clocks going to this block from Linux
> >> (it's all locked down).
> > =

> > This shouldn't matter. The clocks going to this hardware block are
> > described by the firmware to the OS by means of the DT node. If the
> > firmware or the hardware decides to change the input clks then the
> > binding can have different clk nodes used.
> =

> There are tons of clocks that are input to blocks in an SoC that are =

> never controlled by Linux. Or are expose in DT because they are set up =

> ahead of time and can't change. So, why make an exception here?

Because the driver doesn't have to hard-code some frequency that can
easily come from the DT, making it more flexible for frequency plan
changes. It doesn't matter about control of clks at all here, so this
comparison is just plain wrong.

> =

> >> The INIT_RATE will
> >> always be 300 MHz independent of what source it's coming from (as in, =

> >> if
> >> GPLL0 can't give 300, the HW design will be so that we'll find a
> >> different source).
> >> =

> >> So, I'd like to remove any clock bindings for this driver.
> > =

> > No. Bindings describe how the hardware is connected. Please don't =

> > remove
> > clocks from the binding just because probe defer is a concern.
> =

> Binding describes hardware controllable by the OS. That's the reality. =

> Let's not add mandatory clock bindings for clocks that the OS can't do =

> anything about.
> =


It seems that you believe clks should only be used to turn on/off and
control rates. That is not the whole truth. Sometimes clks are there
just to express the clk frequencies that are present in the design so
that drivers can figure out what to do.

