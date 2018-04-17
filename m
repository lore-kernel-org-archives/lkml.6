Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeDQGBs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:01:48 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:42717 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeDQGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:01:45 -0400
X-Google-Smtp-Source: AIpwx49CouApUExKgoPfprRL+39H+uHIAFO/daTmVNEDS22kDqHTTuKzmDSzic3FQ6B1yzODb8yWLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180416160818.GC1209@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, devicetree@vger.kernel.org
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-3-ilina@codeaurora.org>
 <152306368031.94378.14957212064809086345@swboyd.mtv.corp.google.com>
 <20180409160800.GC19682@codeaurora.org>
 <152346054406.180276.4468371342222361883@swboyd.mtv.corp.google.com>
 <20180411212431.GG19682@codeaurora.org>
 <152365923361.51482.7839380101584600308@swboyd.mtv.corp.google.com>
 <20180416160818.GC1209@codeaurora.org>
Message-ID: <152394490349.51482.12712738252386761377@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 02/10] dt-bindings: introduce RPMH RSC bindings for Qualcomm
 SoCs
Date: Mon, 16 Apr 2018 23:01:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3H61tkO009780

Quoting Lina Iyer (2018-04-16 09:08:18)
> On Fri, Apr 13 2018 at 16:40 -0600, Stephen Boyd wrote:
> >Well it seems like an RSC contains many DRVs and those DRVs contain many
> >TCSes. This is what I get after talking with Bjorn on IRC.
> >
> >       +--------------------------------------------------+ (0x00000)
> >       |                                                  |
> >       |                  DRV #0                          |
> >       |                                                  |
> >       |----------                          --------------| (tcs-offset (0xd00))
> >       |                  DRV0_TCS0                       |
> >       |                common space                      |
> >       |                cmd sequencer                     | 0xd00 + 0x14
> >       |                                                  |
> >       |                  DRV0_TCS1                       |
> >       |                common space                      | 0xd00 + 0x2a0
> >       |                cmd sequencer                     | 0xd00 + 0x2a0 + 0x14
> >       |                                                  |
> >       |                  DRV0_TCS2                       |
> >       |                                                  |
> >       |                                                  |
> >       +--------------------------------------------------+ (0x10000)
> >       |                                                  |
> >       |                  DRV #1                          |
> >       |                                                  |
> >       |----------                          --------------| (tcs-offset)
> >       |                  DRV1_TCS0                       |
> >       |                  DRV1_TCS1                       |
> >       |                  DRV1_TCS2                       |
> >       +--------------------------------------------------+ (0x20000)
> >       |                                                  |
> >       |                  DRV #2                          |
> >       |                                                  |
> >       |----------                          --------------|
> >       |                  DRV2_TCS0                       |
> >       |                  DRV2_TCS1                       |
> >       |                  DRV2_TCS2                       |
> >       |                  DRV2_TCS3                       |
> >       |                  DRV2_TCS4                       |
> >       |                  DRV2_TCS5                       |
> >       +--------------------------------------------------+
> >
> >I think I understand it now. There aren't any "RSC common" registers
> >that are common to the entire RSC. Instead, everything goes into a DRV,
> >or into a common TCS space, or into a TCS "queue".
> >
> >> >Put another way, even if the "apps" RSC is complicated, we should be
> >> >describing it to the best of our abilities in the binding so that when
> >> >it is used by non-linux OSes things still work by simply tweaking the
> >> >drv-id that we use to pick the right things out of the node.
> >> >
> >> >Or we're describing the RSC but it's really a container node that
> >> >doesn't do much besides hold DRVs? So this is described at the wrong
> >> >level?
> >> What we are describing is a DRV, but a standalone DRV alone is useless
> >> without the necessary RSC registers. So its a unique RSC+DRV combination
> >> that is represented here.
> >>
> >
> >If my understanding is correct up there then the binding could either
> >describe a single RSC DRV, or it could describe all the RSC DRV
> >instances and interrupts going into the RSC "block" and then we can use
> >drv-id to pick the offset we jump to.
> >
> Your understanding is correct.
> 
> >I imagine we don't have any practical use-case for the entire RSC space
> >because there aren't any common RSC registers to deal with.
> Not true.

So then my understanding is not correct! :/

> 
> >So we've
> >boiled this all down to describing one DRV and then I wonder why we care
> >about having drv-id at all? It looks to be used to check for a max
> >number of TCS, but that's already described by DT so it doesn't seem
> >very useful to double check what the hardware can tells us.
> >
> There is also a number of commands per TCS (NCPT), that may way vary
> between different RSCs. The RSC of the application processor has 16
> commands in each TCS, but that is variable. I am not saying it cannot be
> described in DT, but it is something I read from the common RSC
> registers, currently.
> Also, I will using common/DRV0 registers to write wakeup time value,
> when the processor subsystem goes into power down. This is not DRV2
> register, but is a DRV0 register that we will have special access to.
> The patches for those I intend to publish, when we have support for
> sleep/suspend with this new architecture. So the address of the start of
> the RSC (=DRV0) is necessary.
> 
> >Long story short, we can remove drv-id and just describe drvs by
> >themselves?
> Yes, we may. As long as I have a way to describe the register addresss
> of the start of the DRV (0x20000 for DRV#2)  and the tcs-offset (0xd00),
> we can work with the RSC-DRV in the driver.
> 

>From this new information it seems like we need to know about all the
DRVs in the RSC then. So let's go back to my previous binding proposal
describing all of them and having the qcom,drv-id property describe
which one to use most of the time and hardcode the assumption to use
DRV0 in the driver when we need to do things for sleep/suspend? Then
we're back to describing the whole RSC and configuring the picker to
pick the right DRV depending on firmware configuration.
