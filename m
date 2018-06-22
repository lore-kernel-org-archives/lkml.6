Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DD1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2842446A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2842446A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754502AbeFVPK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:10:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54434 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754454AbeFVPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:10:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: martyn)
        with ESMTPSA id 9D358263BFC
Message-ID: <1529680221.2395.26.camel@collabora.co.uk>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for  CP2102N
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Karoly Pados <pados@pados.hu>, Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Jun 2018 16:10:21 +0100
In-Reply-To: <7369694284fcea1a8d7c142f47ab361f@pados.hu>
References: <1529513516.2395.23.camel@collabora.co.uk>
         <20180620082507.GO32411@localhost> <20180617182503.23080-1-pados@pados.hu>
         <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
         <20180620105231.GQ32411@localhost>
         <7369694284fcea1a8d7c142f47ab361f@pados.hu>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 19:41 +0000, Karoly Pados wrote:
> Hi Martyn,
> 
> > The rationale for the pins being permanently configured as output
> > pins
> > is that these pins (at least on the cp2105) do not appear to
> > provide a
> > true input mode. They offer a "push-pull" mode (where the voltage
> > is
> > pulled directly to ground or supply rail) and an "open-drain" mode
> > (where the pin is weakly pulled high by an internal resistor and
> > can be
> > pulled to ground). Unless I missed something, there is no
> > tristate/high
> > impedance mode typically associated with a pin being used as input.
> 
> You didn't miss anything. It is the same for many (maybe all) SiLabs
> devices, in particular also for the cp2102n, which spawned this
> conversation.
> I sent in patches for its GPIO support, but in contrast to the
> cp2105,
> I try to emulate input mode by making sure that a pin is never pulled
> low
> when it is set as an input, and that you cannot set push-pull pins as
> inputs.
> The reason why you were invited is because we are trying to figure
> out which
> approach should be taken.
> 
> > Sure, you can use the open-drain mode as input as long as you
> > understand that the permanent pull up in the cp2015 might have an
> > impact on what you are reading. For example, if you have a signal
> > that
> > is externally weakly pulled down, it's going to depend on the
> > relative
> > resistances of the internal and external resistors as to what
> > voltage
> > the line rests at and therefore what state the line is considered
> > to be
> > in. This could stop things working if you naively think the cp2105
> > is
> > acting as a typical high-impedance input.
> 
> Here I argue the following multiple ways. First, I say that claiming
> that
> a pin which is used as an input is actually an output is not only
> confusing,
> but also much less correct than thinking of it as an input pin with a
> weak
> pullup to prevent floating signals. Second, the pullups - while not 
> explicitly listed in the datasheet - can be calculated from what is
> there, 
> and for the cp2105 are typically 132k, for the cp2102n even higher
> around 
> 165k. These are pretty weak pullups, so weak that they won't matter
> for
> the vast majority of applications as people rarely use pull-ups or
> pull-
> downs higher than 100k (not never, but rarely). So claiming that it
> can
> result in false expectation, while not completely wrong, is favoring
> the 
> needs of a few instead of the much more common practice.
> 
> Lastly, and maybe most importantly, I argue that calling everything
> an 
> "output" pin only in name does not actually avoid any design errors,
> as
> the same circuit that would case a false reading in one case would
> also
> cause the same false reading in the other, and the circuits are
> usually
> developed before the software. So it'll be too late anyway by the
> time 
> somebody realizes such a mistake. But on the contrary, it opens up
> more 
> opportunities for errors, because now you are open to software bugs
> that
> ignore a pin's direction because everything's an output either way
> even 
> when it really isn't, and think that they can treat it as
> as open-drain while for some reason it is in push-pull mode. Worse,
> even if it is in open-drain mode, it will only work with a specific
> output
> values - it must be high, which is not the default. With my
> proposal, 
> setting a pin's direction to "input" will make sure it cannot be
> actively 
> driven by the chip, avoiding such "misunderstandings" and errors,
> and 
> similar measures are also in place for the push-pull pins.
> 

Yeah, I'll go with that. :-)

> The only problem I can see is if there isn't a way for the cp2105 to 
> query the reset values of the pins (maybe there is, I just haven't 
> looked into it). Then I don't know how the direction could be 
> determined for an open-drain pin during initialization. But this is 
> solved for the cp2102n, and then it is a device-specific issue for 
> the cp2105, which shouldn't be forced onto other devices if we
> otherwise 
> decide the approach to be inferior.
> 

I'm pretty sure there is a way to determine the pin state, though
unfortunately I no longer have access to the HW to be able to test...

Martyn

> Karoly
