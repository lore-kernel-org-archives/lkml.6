Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754261AbeD2Uvi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 16:51:38 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:33526 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeD2Uvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 16:51:36 -0400
X-Google-Smtp-Source: AB8JxZoWiiFH29txD4vImmG8pk3wAb6AWw2PSsOvdXB2SU55/nz5aCqzakhiAUvgBGVGANdnJhV9K2CP9hWsA3rUDvQ=
MIME-Version: 1.0
In-Reply-To: <20180429055417.GA10221@mithrandir>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com> <20180429055417.GA10221@mithrandir>
From: Wesley Terpstra <wesley@sifive.com>
Date: Sun, 29 Apr 2018 13:51:34 -0700
Message-ID: <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver documentation
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 10:54 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Fri, Apr 27, 2018 at 03:59:56PM -0700, Wesley W. Terpstra wrote:
>> +Unlike most other PWM controllers, the SiFive PWM controller currently only
>> +supports one period for all channels in the PWM. This is set globally in DTS.
>> +The period also has significant restrictions on the values it can achieve,
>> +which the driver rounds to the nearest achievable frequency.
>
> How about you encode this in the driver rather than DT? We have several
> drivers with similar restrictions and they usually allow the first PWM
> channel to choose an arbitrary period and return an error if subsequent
> channels request a period that can't be supported.
>
> I think something similar could work with that second restriction. Why
> not return an error if the exact period can't be set? Or perhaps allow
> some percentage of deviation.

Interesting. There are two ways to use this PWM. In one mode you use
all channels of the PWM as outputs. This is the mode the driver
supports because the HiFive Unleashed board uses all channels
connected to LEDs.

In this case, the PWM period must always be a power-of-two reduction
from the core bus clock frequency. The core bus clock frequency can
vary. Therefore, even if the caller's frequency can be achieved at the
time of the method call, it may not remain achievable. You might say
this is a ridiculous PWM design, and I'd agree with you, but sadly
this is what is found in these chips. So effectively, the only thing
we can guarantee is that the period is within a multiple of sqrt(2)
from the requested period, except even that is not true due to
saturation restrictions that could push the period even further from
what you ask.

In the other mode (where you sacrifice one of the output channels),
you have finer control of the period, but it still affects all
channels. This mode might be a better fit for your proposed API,
except that the driver would still be subject to saturation
restrictions on the period. And those restrictions will change as the
core bus frequency is changed, which means that again, even if your
target period can be achieved (common to all channels) at invocation,
it might not be achievable later.

IMO the only real control this PWM can offer reliably is the duty
cycle, which is why I've written it how I have.

If you see a better solution to the above problems, I am open to suggestions.

>> +Required properties:
>> +- compatible: should be "sifive,pwm0"
>
> Why not simply "sifive,pwm"? If this is supposed to be some sort of
> version number, then it is more customary to use the name of the first
> SoC that integrates the IP. There are some exceptions, like for example
> when the IP is third-party and is integrated in a number of different
> SoCs. In such cases the IP is often properly versioned. But that doesn't
> seem to be the case here.

It is indeed a version number. The first SoC which integrated this IP
cannot run linux. We've put a version number like this into all of our
IP blocks. Isn't an increasing number, which clearly indicates
increased functionality, better than a reference to a sequence of SoCs
whose relationships are not all that clear?
