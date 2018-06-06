Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JibJHGsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0353B601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933045AbeFFQd3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:33:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932514AbeFFQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:33:26 -0400
X-Google-Smtp-Source: ADUXVKLLKJZA4FYsz+szuj0J0SkewPHzPoSmowmI6jFKNaofYX7Ir2Q1POao6jUpigrXPbJ7hbvyrOXx6JJuHpx6eu4=
MIME-Version: 1.0
In-Reply-To: <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-2-git-send-email-ray.jui@broadcom.com> <20180605194124.GA26885@rob-hp-laptop>
 <e91c75f3-f7a4-6f51-9911-7e22d5d05084@roeck-us.net>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Jun 2018 11:33:04 -0500
X-Gmail-Original-Message-ID: <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
Message-ID: <CABGGisxEvWDy16SKE2RG-vhUHBZHSCCHyfwJsPY16B1fQS-=cA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] Documentation: DT: Consolidate SP805 binding docs
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:19 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 06/05/2018 12:41 PM, Rob Herring wrote:
>>
>> On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
>>>
>>> Consolidate two SP805 binding documents "arm,sp805.txt" and
>>> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
>>> desired compatible string to be used
>>>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> ---
>>>   .../devicetree/bindings/watchdog/arm,sp805.txt     | 27
>>> ++++++++++++++-----
>>>   .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31
>>> ----------------------
>>>   2 files changed, 20 insertions(+), 38 deletions(-)
>>>   delete mode 100644
>>> Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>
>>
>> Would be good to get a ACK from FSL/NXP person on this. It looks to me
>> like the driver fetches the wrong clock as it gets the first one and the
>> driver really wants 'wdog_clk'. In any case, their dts files should be
>> updated.
>>
>
> This is really confusing, since he deleted file lists apb_pclk first.
> Does the watchdog driver need apb_pclk or wdog_clk ? That isn't clear to me.
> arch/arm64/boot/dts/hisilicon/hi3660.dtsi only provides apb_pclk, or at
> least
> it says so.

Note that that clock source is 32KHz. That is obviously a mistake
because no one clocks their bus/register interface at 32KHz. Someone
just filled in something that happened to work.

> The fsl dts files all have apb_pclk first.

It's all kind of a mess, but fortunately one we should be able to clean-up.

The compatible string changes too, but AMBA bus devices don't actually
use the compatible string as they use the ID registers to match. I
suppose some other OS could do things differently. Worth the risk to
clean-up IMO.

>
> Either case, why are two clocks asked for in the first place ? Are there
> situations where the second clock is actually used/useful ?

For clocks, the bus needs "apb_pclk" and the driver just gets the
first clock. The driver is obviously going to want the functional
clock that determines the counter rate. That should

Primecell peripherals are about the only ones that have clear specs
WRT clock inputs. Yet we've still managed to screw them up. There are
2 clocks in the spec, so the DT has (or should have) 2 clocks.

Rob
