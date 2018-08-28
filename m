Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2962C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11520891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeH1SeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:34:10 -0400
Received: from foss.arm.com ([217.140.101.70]:39454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbeH1SeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:34:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F9B18A;
        Tue, 28 Aug 2018 07:42:11 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D93A43F557;
        Tue, 28 Aug 2018 07:42:10 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list\:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
References: <1534869685-22221-1-git-send-email-vincent.guittot@linaro.org>
        <87ftz6ww1h.fsf@e105922-lin.cambridge.arm.com>
        <CAKfTPtBGJf3tPgUXwVGbQBxgCwuW4TKhLtyeXYp5SZZxmyXEsg@mail.gmail.com>
Date:   Tue, 28 Aug 2018 15:42:09 +0100
In-Reply-To: <CAKfTPtBGJf3tPgUXwVGbQBxgCwuW4TKhLtyeXYp5SZZxmyXEsg@mail.gmail.com>
        (Vincent Guittot's message of "Wed, 22 Aug 2018 16:32:39 +0200")
Message-ID: <87k1oaa6ym.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> Hi Amit,
>
> On Wed, 22 Aug 2018 at 12:11, Punit Agrawal <punit.agrawal@arm.com> wrote:
>>
>> Hi Vincent,
>>
>> Thanks for the patch. One comment about the choice of units below.
>>
>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>>
>> > The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
>> > its usage in the code assumes that unit is mW/GHz/V^2
>>
>> Instead of choosing GHz as the base, I'd prefer to use uW/MHz/V^2. It'll
>> avoid introducing fractional GHz value for frequency calculations.
>
> I don't understand your concern about fractional Ghz value for
> frequency calculation ?
> I mean, why it's a problem for frequency with Ghz vs Mhz but not a
> problem for voltage with V vs mV ?
> Don't we have the same "problem" in both case ?

You're right. It's the same problem in both cases.

>>
>> > In drivers/thermal/cpu_cooling.c, the code is :
>> >
>> > power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
>> > do_div(power, 1000000000);
>> >
>> > which can be summarized as :
>> > power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
>>
>> Which would then translate to -
>>
>> power (mW) = power (uW) / 1000 = capacitance * freq_mhz * (voltage_mv/1000)^2
>
> Not sure that the equation above is correct. If we consider uW/MHz/V^2
> for the unit, the equation becomes :
> power (mW) = power (uW) / 1000 = capacitance * freq_mhz *
> (voltage_mv/1000)^2 / 1000

Yes, I missed the "/ 1000" at the end.

> which can be rearranged as
> power (mW) = power (uW) / 1000 = capacitance * freq_mhz/ 1000 *
> (voltage_mv/1000)^2
>
> TBH, I don't really mind between  mW/GHz/V^2 or uW/MHz/V^2 as they are
> the same at the end
> but I don't catch your reasoning

The problem I was thinking of doesn't hold as it's the same issue with
voltage.

One benefit to go with uW/MHz/V^2 might be the extra resolution that it
provides. I'd prefer to go with uW/MHz/V^2 if there's no compelling
reason to go with anything else.


[...]

>> >
>> > Furthermore, if we test basic values like :
>> > voltage_mv = 1000mV = 1V
>> > freq_mhz = 1000Mhz = 1Ghz
>> >
>> > The minimum possible power, when dynamic-power-coefficient equals 1, will
>> > be :
>> > min power = 1 * 1000  * (1000000)^2 = 10^15 mW
>> > which is not realistic
>> >
>> > With the unit used by the code, the min power is
>> > min power =  1 * 1 * 1^2 = 1mW which is far more realistic
>> >
>> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> > ---
>> >  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> > index 29e1dc5..0148d7d 100644
>> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> > @@ -274,7 +274,7 @@ described below.
>> >               Usage: optional
>> >               Value type: <prop-encoded-array>
>> >               Definition: A u32 value that represents the running time dynamic
>> > -                         power coefficient in units of mW/MHz/uV^2. The
>> > +                         power coefficient in units of mW/GHz/V^2. The
>> >                           coefficient can either be calculated from power
>> >                           measurements or derived by analysis.
>> >
>> > @@ -285,7 +285,7 @@ described below.
>> >
>> >                           Pdyn = dynamic-power-coefficient * V^2 * f
>> >
>> > -                         where voltage is in uV, frequency is in MHz.
>> > +                         where voltage is in V, frequency is in GHz.
>> >
>> >  Example 1 (dual-cluster big.LITTLE system 32-bit):
