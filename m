Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBUFiw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 00:38:52 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36024 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeBUFiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 00:38:50 -0500
X-Google-Smtp-Source: AH8x224QX279tfhTfChqvGjZLH4jWU965kH3NW5xea47d+G3+2Zj8qRLhwKneXJu4Akf/jYHhqmN2Q==
Date: Tue, 20 Feb 2018 21:38:46 -0800
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        briannorris@google.com, dtor@google.com, dianders@google.com,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] Input: gpio-keys - allow setting wakeup interrupt
 trigger type in DT
Message-ID: <20180221053845.GA196881@rodete-desktop-imager.corp.google.com>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
 <20180209115510.11868-3-jeffy.chen@rock-chips.com>
 <20180209234246.GA252335@ban.mtv.corp.google.com>
 <20180218233453.ytvuvggnzx5rhbls@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218233453.ytvuvggnzx5rhbls@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 18, 2018 at 05:34:53PM -0600, Rob Herring wrote:
> On Fri, Feb 09, 2018 at 03:42:47PM -0800, Brian Norris wrote:
> > On Fri, Feb 09, 2018 at 07:55:09PM +0800, Jeffy Chen wrote:
> > > Allow specifying a different interrupt trigger type for wakeup when
> > > using the gpio-keys input device as a wakeup source.
> > > 
> > > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/input/gpio-keys.txt | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> > > index a94940481e55..61926cef708f 100644
> > > --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> > > +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> > > @@ -26,6 +26,15 @@ Optional subnode-properties:
> > >  	  If not specified defaults to 5.
> > >  	- wakeup-source: Boolean, button can wake-up the system.
> > >  			 (Legacy property supported: "gpio-key,wakeup")
> > > +	- wakeup-trigger-type: Specifies the interrupt trigger type for wakeup.
> > > +		 The value is defined in <dt-bindings/interrupt-controller/irq.h>
> > 
> > Do you really want to codify interrupt triggers here? It seems like most
> > of the information about edge vs. level is already codified elsewhere,
> > so this becomes a little redundant. And in fact, some bindings may be
> > specifying a "gpio", not technically an interrupt (at least not
> > directly), so it feels weird to apply IRQ_* flags to them right here.
> > Anyway, I think he only piece you really want to describe here is, do we
> > wake on "event asserted", "event deasserted", or both. (The "none" case
> > would just mean you shouldn't have the "wakeup-source" property.)
> > 
> > So maybe:
> > 
> > 	wakeup-trigger-type: Specifies whether the key should wake the
> > 	system when asserted, when deasserted, or both. This property is
> > 	only valid for keys that wake up the system (e.g., when the
> > 	"wakeup-source" property is also provided). Supported values
> > 	are:
> > 	  1: asserted
> 
> As wakeup is an IRQ, that's assumed.
> 
> > 	  2: deasserted
> 
> Just invert the flags for the IRQ.

What? Wouldn't that change the meaning of the key?

> > 	  3: both asserted and deasserted
> 
> I don't see what would be the usecase. But wouldn't this be any edge 
> (because level certainly doesn't make sense)?

Well, #3 is how the driver happens to currently interpret the binding ;)
I believe the idea is that you get wakeup triggers on all events
(pressed or released). I'm not actually sure why though, since it
doesn't really make for a good use case. (We want both edges in S0, but
not really in S3.)

For some background: the case that inspired this is SW_PEN_INSERTED. We
want to receive events on both edges (PEN_INSERTED = "asserted"; and
!PEN_INSERTED = "deasserted", meaning pen ejected) in S0 (e.g., to
show/hide special UI menus when we think the pen is "in use"). But in
S3, we tend to want to wake only when the pen is ejected. We can't
invert the IRQ, because then ejection and insertion get swapped...
Also, per the above, the current wakeup condition is for both edges. We
want to override that.

Brian

> > 
> > ? We could still make macros out of those, if we want
> > (input/linux-event-codes.h?). And then leave it up to the driver to
> > determine how to translate that into the appropriate edge or level
> > triggers.
> > 
> > Brian
> > 
> > > +		 Only the following flags are supported:
> > > +			IRQ_TYPE_NONE
> > > +			IRQ_TYPE_EDGE_RISING
> > > +			IRQ_TYPE_EDGE_FALLING
> > > +			IRQ_TYPE_EDGE_BOTH
> > > +			IRQ_TYPE_LEVEL_HIGH
> > > +			IRQ_TYPE_LEVEL_LOW
> > >  	- linux,can-disable: Boolean, indicates that button is connected
> > >  	  to dedicated (not shared) interrupt which can be disabled to
> > >  	  suppress events from the button.
> > > -- 
> > > 2.11.0
> > > 
> > > 
