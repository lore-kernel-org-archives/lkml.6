Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85386C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F732146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/3jDeGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F732146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeK3UHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:07:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbeK3UHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:07:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FD12081C;
        Fri, 30 Nov 2018 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543568311;
        bh=LF7Es7jHKRU0hrJttA457Z328c0KCI5D9cqtLvqQK7M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=B/3jDeGbtUaK8+gypbwHBGmk8Pj6JmMh+e3k5pbLTpdxDGU2afY6yv4LBgIgq3s19
         iLrq4GfoPXxe//pwVHZIcNEQh6TIMQ/qeHUSaMW1tFMEf0ADb9efGjvgrwidzPQG2i
         OlQAw9r8GPefOc2b6vFWV79wIhPG3tbyp/Kyzlb0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Janek Kotas <jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <76BDCB72-CC05-41D1-93A0-6D71CBD97651@global.cadence.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <D3711617-229C-4FA5-9E73-A7A3C025893B@global.cadence.com>
 <154223394933.88331.14659021245427374668@swboyd.mtv.corp.google.com>
 <CAE55F09-516A-4737-8F74-07BBA3AF5737@global.cadence.com>
 <154353057449.88331.10017415440005548379@swboyd.mtv.corp.google.com>
 <76BDCB72-CC05-41D1-93A0-6D71CBD97651@global.cadence.com>
Message-ID: <154356831048.88331.9290972200429107619@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: Add Fixed MMIO clock driver
Date:   Fri, 30 Nov 2018 00:58:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janek Kotas (2018-11-30 00:52:16)
> =

>         We have a single register in a fixed location which contains =

>         the frequency of the main system clock.
>         This allows us to use the same image in emulation, FPGA
>         and simulation without any changes.
>         We usually don=E2=80=99t use a full bootloader, just a simple wra=
pper,
>         which initializes the necessary stuff and jumps to the kernel.
> =

> =

>     So the hardware team has decided to throw a frequency register in the=
re?
>     Alright! Does that fixed rate clk generate its fixed rate from some
>     other clk? I=E2=80=99m curious if this fixed rate clk has a parent so=
urce.
> =

> =

> It depends, in simulation and emulation we can just generate =

> a clock source with a given frequency.
> On FPGA it=E2=80=99s usually an external oscillator, sometimes a fixed PL=
L.
> The driver is not intended to be used in full, complex SoCs.

Ok, sounds like it isn't worth modeling this then.

> =

> =

>     It would also be good to make sure that any clks registered from this
>     driver can't be populated from regions of memory like DDR. Can you
>     confirm? I think it will fail, but it would be worth checking
> =


Please try this.

>     Yes I'd prefer a platform driver unless there's some reason it can't =
be
>     done. We may need to have both in case this needs to be populated very
>     early, but if that isn=E2=80=99t the case then just a platform driver=
 for now.
> =

> =

> I played with it a bit, and it and it looks like I need both.
> We use this clock source with some of our components, =

> and for some of them the platform driver was initialized too late.
> =


Ok. So do both then.

