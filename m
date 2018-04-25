Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756187AbeDYSOr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:14:47 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38052 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755223AbeDYSOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:14:40 -0400
X-Google-Smtp-Source: AIpwx48c9NGk2XYN88exWfSPnmtSOxrSTVX15oF6munzvl49IfooEtFlYH9kknb4sJV7SUAfdnyQYA==
Date: Wed, 25 Apr 2018 11:14:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Joseph Lo <josephl@nvidia.com>, Doug Berger <opendmb@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Lack of suspend/resume/shutdown ordering between GPIO providers
 and consumers
Message-ID: <20180425181435.GA200812@dtor-ws>
References: <dc0c15eb-3dab-f512-aed6-045528fcec2c@gmail.com>
 <CAL_JsqJ6Avm+zPRd40aUq=BWFE45xQpaOWG-8d5d8+dqJZCZaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ6Avm+zPRd40aUq=BWFE45xQpaOWG-8d5d8+dqJZCZaQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 10:00:31AM -0500, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 5:58 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > Hi Linus, Rafael, all
> >
> > Our GPIO controller driver: gpio-brcmstb.c has a shutdown callback which
> > gets invoked when the system is brought into poweroff aka S5. So far so
> > good, except that we also wish to use gpio_keys.c as a possible wake-up
> > source, so we may have a number of GPIO pins declared as gpio-keys that
> > allow the system to wake-up from deep slumber.
> >
> > Recently we noticed that we could easily get into a state where
> > gpio-brcmstb.c::brcmstb_gpio_shutdown() gets called first, and then
> > gpio_keys.c::gpio_keys_suspend() gets called later, which is too late to
> > have the enable_irq_wake() call do anything sensible since we have
> > suspend its parent interrupt controller before. This is completely
> > expected unfortunately because these two drivers are both platform
> > device instances with no connection to one another except via Device
> > Tree and the use of the GPIOLIB APIs.
> >
> > First solution is to make sure that gpio-keys nodes are declared in
> > Device Tree *before* the GPIO controller. This works because Device Tree
> > nodes are probed in the order in which they are declared in Device Tree
> > and that directly influences the order in which platform devices are
> > created. Problem with that is that this is easy to miss and it may not
> > work with overlays, kexec reconstructing DT etc. etc.
> 
> I'm going to make of_platform_populate randomize the order it creates devices...
> 
> > Another possible solution would be have the GPIO controller nodes have
> > the GPIO consumers nodes such as gpio-keys, gpio-leds etc., and that
> > would allow the Linux device driver model to create an appropriate
> > child/parent relationship. This would unfortunately require Device Tree
> > changes everywhere to make that consistent, and it would be a special
> > case, because not all GPIO consumers are eligible as child nodes of
> > their parent GPIO controller, there are plenty of other consumers that
> > are not suitable for being moved under a parent GPIO controller node.
> > This would also mean that we need to "probe" GPIO controller nodes to
> > populate their child nodes (e.g: of_platform_bus_populate).
> >
> > I am thinking a more generic solution might involve some more complex
> > tracking of the provider <-> consumer, but there is room for breakage.
> 
> That's what device connections are for. It probably just needs the
> GPIO core to create the links. (but I've not looked into it at all).

Not all APIs accept device as parameter to easily create links. But I
wonder, for cases like this, if we could not simply move the device to
the end of the dpm list after successful binding it to a driver. The
assumption that when GOPIs or other resources are not ready they'll
return -EPROBE_DEFER and probing would fail.

Thanks.

-- 
Dmitry
