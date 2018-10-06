Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA751C65BD0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC43921473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 09:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC43921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJFQXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 12:23:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38948 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbeJFQXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 12:23:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4CD9820802; Sat,  6 Oct 2018 11:20:59 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19B52206A2;
        Sat,  6 Oct 2018 11:20:49 +0200 (CEST)
Date:   Sat, 6 Oct 2018 11:20:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, robh@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-mips@linux-mips.org, Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 04/21] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20181006092050.GA32272@piout.net>
References: <S23990757AbeJCKjwPaYBe/20181003103952Z+1106@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <S23990757AbeJCKjwPaYBe/20181003103952Z+1106@eddie.linux-mips.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 12:32:51+0200, Paul Cercueil wrote:
> 
> Le 1 oct. 2018 10:48, Daniel Lezcano <daniel.lezcano@linaro.org> a écrit :
> >
> > On 31/07/2018 00:01, Paul Cercueil wrote: 
> >
> > [ ... ] 
> >
> > >>>  +- ingenic,timer-channel: Specifies the TCU channel that should be 
> > >>> used as 
> > >>>  +  system timer. If not provided, the TCU channel 0 is used for the 
> > >>> system timer. 
> > >>>  + 
> > >>>  +- ingenic,clocksource-channel: Specifies the TCU channel that 
> > >>> should be used 
> > >>>  +  as clocksource and sched_clock. It must be a different channel 
> > >>> than the one 
> > >>>  +  used as system timer. If not provided, neither a clocksource nor a 
> > >>>  +  sched_clock is instantiated. 
> > >> 
> > >> clocksource and sched_clock are Linux specific and don't belong in DT. 
> > >> You should define properties of the hardware or use existing properties 
> > >> like interrupts or clocks to figure out which channel to use. For 
> > >> example, if some channels don't have an interrupt, then use them for 
> > >> clocksource and not a clockevent. Or you could have timers that run in 
> > >> low-power modes or not. If all the channels are identical, then it 
> > >> shouldn't matter which ones the OS picks. 
> >
> > It can't work in this case because the pmw and the timer driver are not 
> > communicating and the first one can stole a channel to the last one. 
> 
> In that particular case the timer driver will always request its channels first; with no timer set the system hangs before subsys_initcall, and the PWM driver is a subnode of the timer node, so is probed only after the timer probed.
> 
> > > We already talked about that. All the TCU channels can be used for PWM. 
> > > The problem is I cannot know from the driver's scope which channels will 
> > > be free and which channels will be requested for PWM. You suggested that I 
> > > parse the devicetree for clients, and I did that in the V3/V4 patchset. But 
> > > it only works for clients requesting through devicetree, not from platform 
> > > code or even sysfs. 
> > > 
> > > One thing I can try is to dynamically change the channels the system timer 
> > > and clocksource are using when the current ones are requested for PWM. But 
> > > that sounds hardcore... 
> >
> > Yes, it is :/ 
> >
> > Sorry for letting you wasting time and effort to write an overkill code 
> > not suitable for upstream. 
> >
> > A very gross thought, wouldn't be possible to "register" a channel from 
> > the timer driver code in a shared data area (but well self-encapsulated) 
> > and the pwm code will check such channel isn't in use ? 
> 
> Probably, but it's the contrary I need to do. The timer driver code can use any channel, and probes first. The PWM driver code must use specific channels, and probes last. So either the timer driver knows what channels it can't use, thanks to a device property, or it adapts itself when a channel in use is requested for PWM, which is what I tried in v7.
> 
> I think we could find a way to use a devicetree property that doesn't trigger Rob. That would still be the easiest and cleanest solution. 
> 
> Maybe "ingenic,reserved-channels-mask", which would contain a mask of channels that can only be used by the timer driver. And what the timer driver does with these channels, would be specific to the implementation and would not appear in the bindings. I hope Rob can work with that.
> 

Rob did ack the following binding:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mfd/atmel-tcb.txt

another subdevice is a PWM (not documented here).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
