Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753863AbeEHB4a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 21:56:30 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34409 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753730AbeEHB42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 21:56:28 -0400
X-Google-Smtp-Source: AB8JxZp2fYQ33g/85bYG/5Yr9u+2KiA1Kvgl7PXee9VtbOgRAG17T3fHsFOAwhZiDjlEM0CVz3Qogw==
Date: Mon, 7 May 2018 18:56:25 -0700
From: Brian Norris <briannorris@chromium.org>
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when
 changing it's capability
Message-ID: <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
 <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
 <5AF0FF18.1050905@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AF0FF18.1050905@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 09:36:24AM +0800, Jeffy Chen wrote:
> On 05/08/2018 06:15 AM, Brian Norris wrote:
> > On the other hand...this also implies there may be a race condition
> > there, where we might lose an interrupt if there is an edge between the
> > re-configuration of the polarity in rockchip_irq_demux() and the
> > clearing/handling of the interrupt (handle_edge_irq() ->
> > chip->irq_ack()). If we have an edge between there, then we might ack
> > it, but leave the polarity such that we aren't ready for the next
> > (inverted) edge.
> 
> if let me guess, the unexpected irq we saw is the hardware trying to avoid
> losing irq? for example, we set a EDGE_RISING, and the hardware saw the gpio
> is already high, then though it might lost an irq, so fake one for safe?

I won't pretend to know what the IC designers were doing, but I don't
think that would resolve the problem I'm talking about. The sequence is
something like:
1. EDGE_BOTH IRQ occurs (e.g., low to high)
2. reconfigure polarity in rockchip_irq_demux() (polarity=low)
3. continue to handle_edge_irq()
4. another HW edge occurs (e.g., high to low)
5. handle_edge_irq() (from 3) acks (clears) IRQ (before a subsequent
   rockchip_irq_demux() gets a chance to run and flip the polarity)
...

Now the polarity is still low, but the next trigger should be a
low-to-high edge.

> i'll try to confirm it with IC guys.

Brian
