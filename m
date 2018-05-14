Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753676AbeENNLo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:11:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43271 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbeENNLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:11:41 -0400
Message-ID: <1526303498.3494.11.camel@pengutronix.de>
Subject: Re: Delivery Status Notification (Failure)
From: Lucas Stach <l.stach@pengutronix.de>
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernelnewbies@kernelnewbies.org
Date: Mon, 14 May 2018 15:11:38 +0200
In-Reply-To: <CAOuPNLiFr3qbNVAwF4wj2aAG0UXRVsgRo-8JfaKFCsoL+Ggk9w@mail.gmail.com>
References: <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
         <5af57fea.1c69fb81.885f0.2377.GMRIR@mx.google.com>
         <CAOuPNLgbT59h=Jm5YiOCbrqFkDokJ8xutQ_OkpsFYzKazKhTHg@mail.gmail.com>
         <20180511123915.GC16141@n2100.armlinux.org.uk>
         <f6f7b18644136323f4485d6123b330d0dde207a4.camel@pengutronix.de>
         <CAOuPNLgRHCasmsXTVwcy5ohq8TYjbr4MThxm4Q-HFWihJ7ARww@mail.gmail.com>
         <CAOuPNLiFr3qbNVAwF4wj2aAG0UXRVsgRo-8JfaKFCsoL+Ggk9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 14.05.2018, 17:42 +0530 schrieb Pintu Kumar:
> Hi,
> 
> Is there any work around possible to set IRQ affinity for some GPIO
> interrupt ?
> How to avoid CPU0 to receive the current GPIO interrupt ?
> How do we assign GPIO interrupts to any CPU other than CPU0 ?
> Is it possible to isolate CPU0 for a sometime, from my GPIO driver so
> that GPIO interrupt can be served by another CPU ?
> 
> Need your inputs to decide whether it is still possible to set
> affinity for GPIO interrupt, or its impossible ?

This is not possible. The GPIO IRQs are aggregated into one GPC/GIC IRQ
line per GPIO bank, so it is not possible to change affinity of a
single GPIO interrupt to another CPU. Best we could do is change the
affinity of the whole bank, but given the limited usefulness of
something like that, nobody bothered to implement such a thing.

Regards,
Lucas

> 
> 
> On Fri, May 11, 2018 at 8:07 PM, Pintu Kumar <pintu.ping@gmail.com>
> wrote:
> > On Fri, May 11, 2018 at 6:34 PM, Lucas Stach <l.stach@pengutronix.d
> > e> wrote:
> > > Am Freitag, den 11.05.2018, 13:39 +0100 schrieb Russell King -
> > > ARM Linux:
> > > > On Fri, May 11, 2018 at 05:07:37PM +0530, Pintu Kumar wrote:
> > > > > Hi,
> > > > > 
> > > > > I need one help.
> > > > > I am using i.MX7 Sabre board with kernel version 4.1.15
> > > > > 
> > > > > Let's say I am interested in GPIO number: 21
> > > > > I wanted to set CPU affinity for particular GPIO->IRQ number,
> > > > > so I
> > > > > tried the below steps:
> > > > > root@10:~# echo 21 > /sys/class/gpio/export
> > > > > root@10:~# echo "rising" > /sys/class/gpio/gpio21/edge
> > > > > root@10:~# cat /proc/interrupts | grep 21
> > > > >   47: 0 0 gpio-mxc 21 Edge gpiolib
> > > > > root@10:~# cat /sys/class/gpio/gpio21/direction
> > > > > in
> > > > > root@10:~# cat /proc/irq/47/smp_affinity
> > > > > 3
> > > > > root@10:~# echo 2 > /proc/irq/47/smp_affinity
> > > > > -bash: echo: write error: Input/output error
> > > > > 
> > > > > But I get input/output error.
> > > > > When I debug further, found that irq_can_set_affinity is
> > > > > returning 0:
> > > > > [    0.000000] genirq: irq_can_set_affinity (0): balance: 1,
> > > > > irq_data.chip: a81b7e48, irq_set_affinity:   (null)
> > > > > [    0.000000] write_irq_affinity: FAIL
> > > > > 
> > > > > I also tried first setting /proc/irq/default_smp_affinity to
> > > > > 2 (from 3).
> > > > > This change is working, but the smp_affinity setting for the
> > > > > new IRQ
> > > > > is not working.
> > > > > 
> > > > > When I try to set smp_affinity for mmc0, then it works.
> > > > > # cat /proc/interrupts | grep mmc
> > > > > 295:         55          0     GPCV2  22 Edge      mmc0
> > > > > 296:          0          0     GPCV2  23 Edge      mmc1
> > > > > 297:         52          0     GPCV2  24 Edge      mmc2
> > > > > 
> > > > > root@10:~# echo 2 > /proc/irq/295/smp_affinity
> > > > > root@10:~#
> > > > > 
> > > > > 
> > > > > So, I wanted to know what are the conditions for which
> > > > > setting
> > > > > smp_affinity for an IRQ will work ?
> > > > > 
> > > > > Is there any way by which I can set CPU affinity to a GPIO ->
> > > > > IRQ ?
> > > > > Whether, irq_set_affinity_hint() will work in this case ?
> > > > 
> > > > IRQ affinity is only supported where interrupts are _directly_
> > > > wired to
> > > > the GIC.  It's the GIC which does the interrupt steering to the
> > > > CPU
> > > > cores.
> > > > 
> > > > Interrupts on downstream interrupt controllers (such as GPCV2)
> > > > have no
> > > > ability to be directed independently to other CPUs - the only
> > > > possible
> > > > way to change the mapping is to move _all_ interrupts on that
> > > > controller,
> > > > and any downstream chained interrupts at GIC level.
> > > > 
> > > > Hence why Interrupt 295 has no irq_set_affinity function: there
> > > > is no way
> > > > for the interrupt controller itself to change the affinity of
> > > > the input
> > > > interrupt.
> > > 
> > > The GPCv2 though is a secondary IRQ controller which has a 1:1
> > > mapping
> > > of its input IRQs to the upstream GIC IRQ lines. Affinity can
> > > thus be
> > > handled by forwarding the request to the GIC by
> > > irq_chip_set_affinity_parent().
> > > 
> > > As this is handled correctly in the upstream kernel since the
> > > first
> > > commit introducing support for the GPCv2, it seems the issue is
> > > only
> > > present in some downstream kernel.
> > > 
> > 
> > OK. Thanks so much for your reply.
> > 
> > I saw some of the drivers using irq_set_affinity_hint() to force
> > the
> > IRQ affinity to a particular CPU.
> > This is the sample:
> > {
> > cpumask_clear(mask);
> > cpumask_set_cpu(cpu, mask);
> > irq_set_affinity_hint(irq, mask);
> > }
> > 
> > Whether this logic will work for a particular GPIO pin ?
> > 
> > 
> > > Regards,
> > > Lucas
