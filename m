Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1478C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC3520868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 12:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC3520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK3XKB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:10:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50697 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbeK3XKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:10:01 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6012C207BC; Fri, 30 Nov 2018 13:00:54 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0706E2037D;
        Fri, 30 Nov 2018 13:00:54 +0100 (CET)
Date:   Fri, 30 Nov 2018 13:00:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 0/2] Link consumer with clock driver
Message-ID: <20181130130053.4f944b3b@xps13>
In-Reply-To: <154356989722.88331.10134203618475749179@swboyd.mtv.corp.google.com>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
        <154356989722.88331.10134203618475749179@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

+Maxime

Stephen Boyd <sboyd@kernel.org> wrote on Fri, 30 Nov 2018 01:24:57
-0800:

> Quoting Miquel Raynal (2018-11-22 13:22:10)
> > Hello,
> > 
> > While working on suspend to RAM feature, I ran into troubles multiple
> > times when clocks where not suspending/resuming at the desired time. I
> > had a look at the core and I think the same logic as in the
> > regulator's core may be applied here to (very easily) fix this issue:
> > using device links.  
> 
> Thanks! I've wanted to add device links to the clk framework for a while
> now but haven't gotten around to it. Can you expand on the scenario that
> you've run into where you need this?

Well, it happened that when working on suspend support on an
ESPRESSObin, the peripheral clock driver (armada_37xx_periph.c) was not
suspended after/resumed before all the drivers depending on it.

> 
> > 
> > The only additional change I had to do was to always (when available)
> > populate the device entry of the core clock structure so that it could
> > be used later. This is the purpose of patch 1. Patch 2 actually adds
> > support for device links.  
> 
> That's fine. We should do it into clk_core all the time for other
> reasons too.
> 
> > 
> > As I am not used to hack into the clock subsystem I might have missed
> > something big preventing such change but so far I could not see
> > anything wrong with it. As this touches core code, I am of course
> > entirely open to suggestions.
> >   
> 
> Two questions:
> 
>  1) Do device links work if we make a loop between devices? I'm thinking
>  of the case where we have two clock controllers that provide clks to
>  each other and could potentially register some clks and then clk_get()
>  the ones they depend on. I suspect loops don't work and so we need to
>  be aware of this and somehow prevent it.

For what I understand, when requesting the creation of a link there is
a check with "device_is_dependent()" that prevents reverse
dependencies, see [1].

Could you please share a situation where there is a loop between clocks
or between a device and its clock source? I don't see any.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L214

> 
>  2) Do we need to link clk consumers to anything besides the device
>  providing the clk they get from clk_get()? Put another way, do we need
>  to make links through the clk tree and any potential parent clks of
>  whatever the device is using at the time. Would clk tree changing
>  topology because some new parent is chosen need to affect
>  suspend/resume ordering? Or would that all need to be handled by clk
>  framework figuring out the ordering of the tree at suspend/resume time
>  and suspending clock controller drivers in the right order?
> 

In the v2 (coming) I followed Maxime Ripard suggestion and what you
describe above is handled automatically, let me explain the scenario.


The order of probe has no importance because the framework already
handles orphaned clocks so let's be simple and say there are two root
clocks, not depending on anything, that are probed first: xtal0 and
xtal1. None of these clocks have a parent, there is no device link in
the game, yet.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +----------------+
 
Then, a peripheral clock periph0 is probed. His parent is xtal1. The
clock_register_*() call will run __clk_init_parent() and a link between
periph0's core and xtal1's core will be created and stored in
periph0's core->parent_clk_link entry.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +-------^--------+
                                         |
                                         |
                          +--------------+
                          |   ->parent_clk_link
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                |
                  |                |
                  +-------^^-------+
                          ||
                          ||
                  +----------------+
                  |                |
                  |  periph0 clk 0 |
                  |                |
                  +----------------+

Then, device0 is probed and "get" the periph0 clock. clk_get() will be
called and a struct clk will be instantiated for device0 (called in
the figure clk 1). A link between device0 and the new clk 1 instance of
periph0 will be created and stored in the clk->consumer_link entry.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +-------^--------+
                                         |
                                         |
                          +--------------+
                          |   ->parent_clk_link
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                <-------------+
                  |                <-------------|
                  +-------^^-------+            ||
                          ||                    ||
                          ||                    ||
                  +----------------+    +----------------+
                  |                |    |                |
                  |  periph0 clk 0 |    |  periph0 clk 1 |
                  |                |    |                |
                  +----------------+    +----------------+
                                                |
                                                | ->consumer_link
                                                |
                                                |
                                                |
                                        +-------v--------+
                                        |    device0     |
                                        +----------------+

Right now, device0 is linked to periph0, itself linked to xtal1 so
everything is fine.

Now let's get some fun: the new parent of periph0 is xtal1. The process
will call clk_reparent(), periph0's core->parent_clk_link will be
destroyed and a new link to xtal1 will be setup and stored. The
situation is now that device0 is linked to periph0 and periph0 is
linked to xtal1, so the dependency between device0 and xtal1 is still
clear.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +-------^--------+            +----------------+
           |
           |                           \ /
           +----------------------------x
      ->parent_clk_link   |            / \
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                <-------------+
                  |                <-------------|
                  +-------^^-------+            ||
                          ||                    ||
                          ||                    ||
                  +----------------+    +----------------+
                  |                |    |                |
                  |  periph0 clk 0 |    |  periph0 clk 1 |
                  |                |    |                |
                  +----------------+    +----------------+
                                                |
                                                | ->consumer_link
                                                |
                                                |
                                                |
                                        +-------v--------+
                                        |    device0     |
                                        +----------------+

I assume periph0 cannot be removed while there are devices using it,
same for xtal0.

What can happen is that device0 'put' the clock periph0. The relevant
link is deleted and the clk instance dropped.

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +-------^--------+            +----------------+
           |
           |                           \ /
           +----------------------------x
      ->parent_clk_link   |            / \
                          |
                  +----------------+
                  |                |
                  |                |
                  |  periph0 core  |
                  |                |
                  |                |
                  +-------^^-------+
                          ||
                          ||
                  +----------------+
                  |                |
                  |  periph0 clk 0 |
                  |                |
                  +----------------+

Now we can unregister periph0: link with the parent will be destroyed
and the clock may be safely removed. 

   +----------------+            +----------------+
   |                |            |                |
   |                |            |                |
   |   xtal0 core   |            |   xtal1 core   |
   |                |            |                |
   |                |            |                |
   +-------^^-------+            +-------^^-------+
           ||                            ||
           ||                            ||
   +----------------+            +----------------+
   |                |            |                |
   |   xtal0 clk    |            |   xtal1 clk    |
   |                |            |                |
   +----------------+            +----------------+


This is my understanding of the common clock framework and how links
can be added to it. I hope this was clear enough :)


Thanks,
Miquèl
