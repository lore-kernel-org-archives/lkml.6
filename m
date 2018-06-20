Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D682C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F2420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F2420846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeFTQwA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:52:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43302 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbeFTQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:51:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: martyn)
        with ESMTPSA id 225A7275273
Message-ID: <1529513516.2395.23.camel@collabora.co.uk>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Johan Hovold <johan@kernel.org>, Karoly Pados <pados@pados.hu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Jun 2018 17:51:56 +0100
In-Reply-To: <20180620105231.GQ32411@localhost>
References: <20180620082507.GO32411@localhost>
         <20180617182503.23080-1-pados@pados.hu>
         <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
         <20180620105231.GQ32411@localhost>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-20 at 12:52 +0200, Johan Hovold wrote:
> > > [ Adding Martyn who implemented the cp2105 gpio support. ]
> > > So for cp2105 we decided against implementing an input mode. We
> > > at least
> > > need to be consistent here, so I suggest starting with dropping
> > > those
> > > 
> > 
> > Again, you're the boss, but I do find this odd. These are different
> > devices and thankfully now there'd be better support for the
> > cp2102n,
> > and you're asking me to remove input support for consistency
> > reasons.
> > To remove a feature for one device just because it wasn't correctly
> > implemented in another and wanting to stay consistent with the
> > missing
> > support is very odd for me tbh.
> > I know I'm in no position, but please let me ask you once to please
> > reconsider this.
> 
> We're not removing anything from the kernel since nothing has yet
> been
> merged. I'm asking you to separate it into a follow up patch, which
> if
> we find it useful and correct would allow the same functionality for
> cp2105 as well.
> 
> The gpio pins on cp2102n and cp2105 share the same electrical
> characteristics and there's no good reason why we should treat them
> differently.
> 
> > The way it was done for the cp2105 where we make everything and
> > everyone on the system think that a pin is "out" but in reality is
> > an
> > input is quirky to say the least, while at the same time it also
> > does
> > not make sure that an input pin (which is of course not marked as
> > such) is really an input.  Why amputate the cp2102n like this if it
> > has been already implemented correctly?  If we wanted to stay
> > consistent with half-developed and incomplete drivers then there'd
> > be
> > no improvements to Linux.
> 

The rationale for the pins being permanently configured as output pins
is that these pins (at least on the cp2105) do not appear to provide a
true input mode. They offer a "push-pull" mode (where the voltage is
pulled directly to ground or supply rail) and an "open-drain" mode
(where the pin is weakly pulled high by an internal resistor and can be
pulled to ground). Unless I missed something, there is no tristate/high
impedance mode typically associated with a pin being used as input.

Sure, you can use the open-drain mode as input as long as you
understand that the permanent pull up in the cp2015 might have an
impact on what you are reading. For example, if you have a signal that
is externally weakly pulled down, it's going to depend on the relative
resistances of the internal and external resistors as to what voltage
the line rests at and therefore what state the line is considered to be
in. This could stop things working if you naively think the cp2105 is
acting as a typical high-impedance input.

So, with that in mind, we came to the decision that as you *can* read
the state of the output when in open-drain mode, doing it that way may
avoid such potential issues. I didn't do an exhaustive search of other
GPIO devices at the time, so if it can be shown that the majority of
other GPIO drivers with such limitations can be placed into an input
state, I'd be happy for it to be changed so as to remain consistent.


Martyn
