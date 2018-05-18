Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeERHzb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:55:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42742 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeERHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:55:29 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RFC] platform: detach from PM domains on shutdown
Date: Fri, 18 May 2018 09:54:54 +0200
Message-ID: <1580300.sK9GS2NB4b@aspire.rjw.lan>
In-Reply-To: <HE1PR04MB3004EF83E7AE2250E44C49A088910@HE1PR04MB3004.eurprd04.prod.outlook.com>
References: <20180515090110.26820-1-peng.fan@nxp.com> <CAJZ5v0ibwRXqaGJW0vFcy+YqMEc_ao9itBErP_w1YjLQWVVtQg@mail.gmail.com> <HE1PR04MB3004EF83E7AE2250E44C49A088910@HE1PR04MB3004.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 17, 2018 2:37:31 PM CEST Peng Fan wrote:
> 
> > -----Original Message-----
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael
> > J. Wysocki
> > Sent: 2018年5月17日 16:01
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Ulf Hansson
> > <ulf.hansson@linaro.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.com>;
> > Fabio Estevam <fabio.estevam@nxp.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> > dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [RFC] platform: detach from PM domains on shutdown
> > 
> > On Thu, May 17, 2018 at 4:33 AM, Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
> > >> Rafael J. Wysocki
> > >> Sent: 2018年5月17日 5:35
> > >> To: Ulf Hansson <ulf.hansson@linaro.org>
> > >> Cc: Peng Fan <peng.fan@nxp.com>; Rafael J. Wysocki
> > >> <rafael.j.wysocki@intel.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> > >> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Linux Kernel Mailing
> > >> List <linux-kernel@vger.kernel.org>; Linux PM
> > >> <linux-pm@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> > >> Subject: Re: [RFC] platform: detach from PM domains on shutdown
> > >>
> > >> On Wed, May 16, 2018 at 11:52 AM, Ulf Hansson
> > >> <ulf.hansson@linaro.org>
> > >> wrote:
> > >> > On 15 May 2018 at 11:01, Peng Fan <peng.fan@nxp.com> wrote:
> > >> >> When reboot Linux, the PM domains attached to a device are not
> > >> >> shutdown. To SoCs which relys on reset the whole SoC, there is no
> > >> >> need to shutdown PM domains, but to Linux running in a virtual
> > >> >> machine with devices pass-through, we could not reset the whole SoC.
> > >> >> Currently we need Linux to shutdown its PM domains when reboot.
> > >> >
> > >> > I am not sure I understand exactly why the PM domain needs to be
> > >> > shutdown for these cases, could you please elaborate a bit on that.
> > >> >
> > >> > BTW, what platform are you running on and also what PM domains are
> > >> > being
> > >> used?
> > >> >
> > >> > Anyway, it seems like there may be need for certain cases, but
> > >> > certainly not all - especially since it may slow down the shutdown
> > >> > process, when not needed.
> > >> >
> > >> > Can we make this runtime configurable, via sysfs or whatever that
> > >> > makes
> > >> sense!?
> > >> >
> > >> >>
> > >> >> commit 2d30bb0b3889 ("platform: Do not detach from PM domains on
> > >> >> shutdown"), removes what this patch tries to add, because of a warning.
> > >> >> commit e79aee49bcf9 ("PM: Avoid false-positive warnings in
> > >> >> dev_pm_domain_set()") already fixes the false alarm warning. So
> > >> >> let's detach the power domain to shutdown PM domains after driver
> > shutdown.
> > >> >>
> > >> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >> >> ---
> > >> >>
> > >> >> I do not find a better place to shutdown power domain when reboot
> > >> >> Linux, so add back the line that commit 2d30bb0b3889 removes,
> > >> >> because it is a false alarm warning as commit e79aee49bcf9 describes.
> > >> >>
> > >> >>  drivers/base/platform.c | 1 +
> > >> >>  1 file changed, 1 insertion(+)
> > >> >>
> > >> >> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > >> >> index 8075ddc70a17..a5929f24dc3c 100644
> > >> >> --- a/drivers/base/platform.c
> > >> >> +++ b/drivers/base/platform.c
> > >> >> @@ -616,6 +616,7 @@ static void platform_drv_shutdown(struct
> > >> >> device
> > >> >> *_dev)
> > >> >>
> > >> >>         if (drv->shutdown)
> > >> >>                 drv->shutdown(dev);
> > >> >> +       dev_pm_domain_detach(_dev, true);
> > >> >
> > >> > This would somewhat work, but only for platform devices. To make
> > >> > this fully work, we need to call dev_pm_domain_detach() from amba,
> > >> > spi, etc as well.
> > >> >
> > >> > Perhaps another option to manage this more generally, an without
> > >> > having detach devices, could be to extend the struct dev_pm_domain
> > >> > with a new callback, "->shutdown()" and then make the driver core
> > >> > call it from device_shutdown().
> > >>
> > >> I'm sensing a possible ordering slippery slope with this (it will
> > >> only work if all of the drivers/bus types etc do the right thing in
> > >> their
> > >> ->shutdown callbacks so nothing depends on the domain going forward).
> > >>
> > >> > Typically, for genpd, I would probably count the number of calls
> > >> > being made to ->shutdown() per PM domain, then when it reaches the
> > >> > number of attached devices to it, allow to power off it.
> > >> >
> > >> > Let's see what Rafael thinks about it.
> > >>
> > >> I'm not sure about the use case.  The hypervisor should be able to
> > >> take care of turning power domains off on the client OS reboot in
> > >> theory.  If the client OS leaving the hypervisor needs to worry about
> > >> what state it leaves behind, the design of the hypervisor is sort of
> > questionable IMO.
> > >
> > > This is valid concern. But moving the power domain logic into
> > > hypervisor mostly micro-kernel design will introduce more complexity and
> > make certification harder.
> > > Currently, Let Linux shutdown it's power domain is the easiest way to
> > > me and make things work well after reboot.
> > 
> > Well, to put it bluntly, if your hypervisor depends on the guest to do the right
> > thing on exit, it doesn't do its job.  I wouldn't have certified it for you if that was
> > my decision.
> 
> It is guest os not work well after guest os reboot. The hypervisor is not affected.
> 
> Thinking another case without hypervisor, M4 core run RTOS, A35 Core run Linux, when Linux rebooting,
> RTOS should not be affected. After Linux reboot itself, because its power domain is not
> paired with open/shutdown, some devices not function well.

The question boils down to whether or not devices should be detached from
PM domains on shutdown IMO.

They are detached from PM domains on driver removal, so I guess one answer is
"yes, in analogy with that".  However, the point about performace brought up
by Ulf seems to be valid too.

In any case, the change should be made for all of the bus types using PM
domains, not just one.
