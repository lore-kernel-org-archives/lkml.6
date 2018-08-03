Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A3C46469
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89679217AF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 22:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQuzLYI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89679217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeHDAWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 20:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbeHDAWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:17 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4828B217AF;
        Fri,  3 Aug 2018 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533335044;
        bh=ydjNEWFd20a2gWMYc44d58Aernzlbu8Jnrqs0Vi74F8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jQuzLYI7MRWYLdeaxxHB6+sahw9om+QBBnHnc+B2wSSmum6KuLdLQcETV1l99ks4O
         nHaLxJCrjqvE9Xk1SCaqiPjWQHPGMHvtKaJuHt+PUWZi1lQbZTsybml11zIp/XMv5v
         DjiOWnNEHXYqFuIWlGMFUOdPIznCBfXtg7GHJEPw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Evan Green <evgreen@google.com>, skannan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
Cc:     tdas@codeaurora.org, rjw@rjwysocki.net,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        anischal@codeaurora.org, devicetree@vger.kernel.org,
        robh@kernel.org, amit.kucheria@linaro.org
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org>
 <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
 <1ddda4b9e6dcd7ad415235f4d6af2dc7@codeaurora.org>
Message-ID: <153333504360.10763.8964005567051510823@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date:   Fri, 03 Aug 2018 15:24:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting skannan@codeaurora.org (2018-08-03 12:52:48)
> On 2018-08-03 12:40, Evan Green wrote:
> > Hi Taniya,
> > =

> > On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
> >> =

> >> +               if (src)
> >> +                       c->table[i].frequency =3D c->xo_rate * lval / =

> >> 1000;
> >> +               else
> >> +                       c->table[i].frequency =3D INIT_RATE / 1000;
> > =

> > I don't know much about how this hardware works, but based on the
> > mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
> > and 3 all mean xo_rate?
> > =

> > Also, is INIT_RATE really constant? It sounds like gpll0 (or
> > gpll0_out_even?). You're already getting the xo clock, why not get
> > gpll0's real rate as well?
> =

> Actually I was about to comment and say NOT to get clocks just to get =

> their rate. The XO_RATE is just a multiplication factor. This HW/FW can =

> change in the future and make the multiplication factor to 1KHz.

So future changes to this hardware are going to make this register
return the final frequency that we should use? Sounds great! But that
isn't how it's working right now. We need to have XO in the binding here
so the driver can work with different XO frequencies in case that ever
happens. Same story for GPLL0. Hardcoding this stuff in the driver just
means we'll have to swizzle things in the driver when it changes.

> We also =

> can't really control any of the clocks going to this block from Linux =

> (it's all locked down).

This shouldn't matter. The clocks going to this hardware block are
described by the firmware to the OS by means of the DT node. If the
firmware or the hardware decides to change the input clks then the
binding can have different clk nodes used.

> Adding clk_get significantly delays when this =

> driver can be probed and increases boot up time.

Huh? Please fix your bootloader to increase the CPU frequency before
booting the kernel. I really doubt probe defer is going to happen if we
send GPLL0 here (XO is a DT clk so it's definitely registered before
this driver), and trying to work around probe defer because the CPU
won't go fast before that is papering over a larger problem with both
probe defer and bootloaders not supplying enough CPU speed for you.

> The INIT_RATE will =

> always be 300 MHz independent of what source it's coming from (as in, if =

> GPLL0 can't give 300, the HW design will be so that we'll find a =

> different source).
> =

> So, I'd like to remove any clock bindings for this driver.

No. Bindings describe how the hardware is connected. Please don't remove
clocks from the binding just because probe defer is a concern.

