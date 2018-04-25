Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeDYVf0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:35:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46527 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753501AbeDYVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:35:21 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, jeffy.chen@rock-chips.com,
        enric.balletbo@collabora.com, josephl@nvidia.com, opendmb@gmail.com
Subject: Re: Lack of suspend/resume/shutdown ordering between GPIO providers and consumers
Date: Wed, 25 Apr 2018 23:35:10 +0200
Message-ID: <3827893.QJdhME6hrl@aspire.rjw.lan>
In-Reply-To: <aecab723-be30-91ba-3fd5-cb61243e572f@ti.com>
References: <dc0c15eb-3dab-f512-aed6-045528fcec2c@gmail.com> <b562c5e3-7073-1b86-6f1f-1d2a5712b28b@ti.com> <aecab723-be30-91ba-3fd5-cb61243e572f@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 25, 2018 9:29:59 PM CEST Grygorii Strashko wrote:
> 
> On 04/25/2018 02:10 PM, Grygorii Strashko wrote:
> > 
> > 
> > On 04/25/2018 01:57 PM, Florian Fainelli wrote:
> >> On 04/25/2018 11:47 AM, Grygorii Strashko wrote:
> >>>
> >>>
> >>> On 04/25/2018 01:29 PM, Florian Fainelli wrote:
> >>>> On 04/25/2018 11:06 AM, Grygorii Strashko wrote:
> >>>>>
> >>>>>
> >>>>> On 04/24/2018 05:58 PM, Florian Fainelli wrote:
> >>>>>> Hi Linus, Rafael, all
> >>>>>>
> >>>>>> Our GPIO controller driver: gpio-brcmstb.c has a shutdown callback
> >>>>>> which
> >>>>>> gets invoked when the system is brought into poweroff aka S5. So far so
> >>>>>> good, except that we also wish to use gpio_keys.c as a possible wake-up
> >>>>>> source, so we may have a number of GPIO pins declared as gpio-keys that
> >>>>>> allow the system to wake-up from deep slumber.
> >>>>>>
> >>>>>> Recently we noticed that we could easily get into a state where
> >>>>>> gpio-brcmstb.c::brcmstb_gpio_shutdown() gets called first, and then
> >>>>>> gpio_keys.c::gpio_keys_suspend() gets called later, which is too
> >>>>>> late to
> >>>>>> have the enable_irq_wake() call do anything sensible since we have
> >>>>>> suspend its parent interrupt controller before. This is completely
> >>>>>> expected unfortunately because these two drivers are both platform
> >>>>>> device instances with no connection to one another except via Device
> >>>>>> Tree and the use of the GPIOLIB APIs.
> >>>>>
> >>>>> You can take a look at device_link_add() and Co.
> >>>>
> >>>> OK, though that requires a struct device references, so while I could
> >>>> certainly resolve the device_node -> struct device that corresponds to
> >>>> the GPIO provider , that poses a number of issues:
> >>>>
> >>>> - not all struct device_node have a corresponding struct device
> >>>> reference (e.g: clock providers, interrupt controllers, and possibly
> >>>> other custom drivers), though in this case, they most likely do have one
> >>>>
> >>>> - resolving a struct device associated with a struct device_node is
> >>>> often done in a "bus" specific way, e.g: of_find_device_by_node(), so if
> >>>> the GPIO provider is e.g: i2c_device, pci_device etc. etc. this might
> >>>> not work that easily
> >>>>
> >>>> I think this is what Dmitry just indicated in his email as well.
> >>>>
> >>>>>
> >>>>> But it's little bit unclear what exactly you have issue with:
> >>>>> - shutdown
> >>>>> - suspend
> >>>>>
> >>>>> above are different (at least as it was before) and gpio-brcmstb.c
> >>>>>     brcmstb_gpio_shutdown() should not be called as part of suspend !?
> >>>>> may be you mean brcmstb_gpio_suspend?
> >>>>
> >>>> The issue exists with shutdown (through the use of "poweroff"), that is
> >>>> confirmed, but I cannot see how it does not exist with any suspend state
> >>>> as well, for the same reason that the ordering is not strictly enforced.
> >>>
> >>> Sry, but it still required some clarification :( - poweroff calls
> >>> device_shutdown() which, in turn, should not call .suspend(), so
> >>> how have you got both .shutdown() and .suspend() callbacks called during
> >>> poweroff? Am I missing smth?
> >>
> >> You are missing me telling you the whole story, sorry I got confused,
> >> but you are absolutely right these are separate lists and on
> >> poweroff/shutdown only ->shutdown() is called. What I had missed in the
> >> report I was submitted was that there was a .shutdown() callback being
> >> added to gpio_keys.c, which of course, because it's an Android based
> >> project is not in the upstream Linux kernel.
> >>
> >> The problem does remain valid though AFAICT. Thanks Grygorii!
> >>
> > 
> > Thanks. But that means you should not see this problem :(
> > There is devices_kset_move_last() call in really_probe() which moves probed dev
> > at the end of kset, and gpio_keys should never be probed before gpio-brcmstb because
> > both devm_fwnode_get_gpiod_from_child() and devm_gpio_request_one() expected to return
> > -EPROBE_DEFER otherwise.
> > 
> > Theoretically issue still might happen with suspend.
> > 
> 
> FYI https://lkml.org/lkml/2015/9/10/218

And also https://patchwork.kernel.org/patch/10334661/
