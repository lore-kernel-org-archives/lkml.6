Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeEKNEP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:04:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeEKNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:04:14 -0400
Message-ID: <f6f7b18644136323f4485d6123b330d0dde207a4.camel@pengutronix.de>
Subject: Re: Delivery Status Notification (Failure)
From: Lucas Stach <l.stach@pengutronix.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Pintu Kumar <pintu.ping@gmail.com>
Cc: open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernelnewbies@kernelnewbies.org
Date: Fri, 11 May 2018 15:04:09 +0200
In-Reply-To: <20180511123915.GC16141@n2100.armlinux.org.uk>
References: <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
         <CAOuPNLjqJVsPOVPCnswtFyXudAJ88_F0QVUq-Z6qWE=UpH0mBA@mail.gmail.com>
         <5af57fea.1c69fb81.885f0.2377.GMRIR@mx.google.com>
         <CAOuPNLgbT59h=Jm5YiOCbrqFkDokJ8xutQ_OkpsFYzKazKhTHg@mail.gmail.com>
         <20180511123915.GC16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 11.05.2018, 13:39 +0100 schrieb Russell King - ARM Linux:
> On Fri, May 11, 2018 at 05:07:37PM +0530, Pintu Kumar wrote:
> > Hi,
> > 
> > I need one help.
> > I am using i.MX7 Sabre board with kernel version 4.1.15
> > 
> > Let's say I am interested in GPIO number: 21
> > I wanted to set CPU affinity for particular GPIO->IRQ number, so I
> > tried the below steps:
> > root@10:~# echo 21 > /sys/class/gpio/export
> > root@10:~# echo "rising" > /sys/class/gpio/gpio21/edge
> > root@10:~# cat /proc/interrupts | grep 21
> >   47: 0 0 gpio-mxc 21 Edge gpiolib
> > root@10:~# cat /sys/class/gpio/gpio21/direction
> > in
> > root@10:~# cat /proc/irq/47/smp_affinity
> > 3
> > root@10:~# echo 2 > /proc/irq/47/smp_affinity
> > -bash: echo: write error: Input/output error
> > 
> > But I get input/output error.
> > When I debug further, found that irq_can_set_affinity is returning 0:
> > [    0.000000] genirq: irq_can_set_affinity (0): balance: 1,
> > irq_data.chip: a81b7e48, irq_set_affinity:   (null)
> > [    0.000000] write_irq_affinity: FAIL
> > 
> > I also tried first setting /proc/irq/default_smp_affinity to 2 (from 3).
> > This change is working, but the smp_affinity setting for the new IRQ
> > is not working.
> > 
> > When I try to set smp_affinity for mmc0, then it works.
> > # cat /proc/interrupts | grep mmc
> > 295:         55          0     GPCV2  22 Edge      mmc0
> > 296:          0          0     GPCV2  23 Edge      mmc1
> > 297:         52          0     GPCV2  24 Edge      mmc2
> > 
> > root@10:~# echo 2 > /proc/irq/295/smp_affinity
> > root@10:~#
> > 
> > 
> > So, I wanted to know what are the conditions for which setting
> > smp_affinity for an IRQ will work ?
> > 
> > Is there any way by which I can set CPU affinity to a GPIO -> IRQ ?
> > Whether, irq_set_affinity_hint() will work in this case ?
> 
> IRQ affinity is only supported where interrupts are _directly_ wired to
> the GIC.  It's the GIC which does the interrupt steering to the CPU
> cores.
> 
> Interrupts on downstream interrupt controllers (such as GPCV2) have no
> ability to be directed independently to other CPUs - the only possible
> way to change the mapping is to move _all_ interrupts on that controller,
> and any downstream chained interrupts at GIC level.
> 
> Hence why Interrupt 295 has no irq_set_affinity function: there is no way
> for the interrupt controller itself to change the affinity of the input
> interrupt.

The GPCv2 though is a secondary IRQ controller which has a 1:1 mapping
of its input IRQs to the upstream GIC IRQ lines. Affinity can thus be
handled by forwarding the request to the GIC by
irq_chip_set_affinity_parent().

As this is handled correctly in the upstream kernel since the first
commit introducing support for the GPCv2, it seems the issue is only
present in some downstream kernel.

Regards,
Lucas
