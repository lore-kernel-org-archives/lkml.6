Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeBRXe5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:34:57 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37397 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbeBRXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:34:55 -0500
X-Google-Smtp-Source: AH8x224PZ2Iu/8W9pQoQre/IYpuZg9RpAe59epJINy/ZE6vdQV7hbLre9hGyDA0BxpFAnaoXaiPtfw==
Date: Sun, 18 Feb 2018 17:34:53 -0600
From: Rob Herring <robh@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
        briannorris@google.com, dtor@google.com, dianders@google.com,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] Input: gpio-keys - allow setting wakeup interrupt
 trigger type in DT
Message-ID: <20180218233453.ytvuvggnzx5rhbls@rob-hp-laptop>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
 <20180209115510.11868-3-jeffy.chen@rock-chips.com>
 <20180209234246.GA252335@ban.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209234246.GA252335@ban.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 03:42:47PM -0800, Brian Norris wrote:
> Hi Jeffy,
> 
> On Fri, Feb 09, 2018 at 07:55:09PM +0800, Jeffy Chen wrote:
> > Allow specifying a different interrupt trigger type for wakeup when
> > using the gpio-keys input device as a wakeup source.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> >  Documentation/devicetree/bindings/input/gpio-keys.txt | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> > index a94940481e55..61926cef708f 100644
> > --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> > +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> > @@ -26,6 +26,15 @@ Optional subnode-properties:
> >  	  If not specified defaults to 5.
> >  	- wakeup-source: Boolean, button can wake-up the system.
> >  			 (Legacy property supported: "gpio-key,wakeup")
> > +	- wakeup-trigger-type: Specifies the interrupt trigger type for wakeup.
> > +		 The value is defined in <dt-bindings/interrupt-controller/irq.h>
> 
> Do you really want to codify interrupt triggers here? It seems like most
> of the information about edge vs. level is already codified elsewhere,
> so this becomes a little redundant. And in fact, some bindings may be
> specifying a "gpio", not technically an interrupt (at least not
> directly), so it feels weird to apply IRQ_* flags to them right here.
> Anyway, I think he only piece you really want to describe here is, do we
> wake on "event asserted", "event deasserted", or both. (The "none" case
> would just mean you shouldn't have the "wakeup-source" property.)
> 
> So maybe:
> 
> 	wakeup-trigger-type: Specifies whether the key should wake the
> 	system when asserted, when deasserted, or both. This property is
> 	only valid for keys that wake up the system (e.g., when the
> 	"wakeup-source" property is also provided). Supported values
> 	are:
> 	  1: asserted

As wakeup is an IRQ, that's assumed.

> 	  2: deasserted

Just invert the flags for the IRQ.

> 	  3: both asserted and deasserted

I don't see what would be the usecase. But wouldn't this be any edge 
(because level certainly doesn't make sense)?

> 
> ? We could still make macros out of those, if we want
> (input/linux-event-codes.h?). And then leave it up to the driver to
> determine how to translate that into the appropriate edge or level
> triggers.
> 
> Brian
> 
> > +		 Only the following flags are supported:
> > +			IRQ_TYPE_NONE
> > +			IRQ_TYPE_EDGE_RISING
> > +			IRQ_TYPE_EDGE_FALLING
> > +			IRQ_TYPE_EDGE_BOTH
> > +			IRQ_TYPE_LEVEL_HIGH
> > +			IRQ_TYPE_LEVEL_LOW
> >  	- linux,can-disable: Boolean, indicates that button is connected
> >  	  to dedicated (not shared) interrupt which can be disabled to
> >  	  suppress events from the button.
> > -- 
> > 2.11.0
> > 
> > 
