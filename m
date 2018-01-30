Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeA3Sgf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:36:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45038 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeA3Sge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:36:34 -0500
Date: Tue, 30 Jan 2018 19:36:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Meelis Roos <mroos@linux.ee>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: 4.15: WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244
 __irq_startup+0x80/0x100
In-Reply-To: <alpine.DEB.2.20.1801291732092.1849@nanos>
Message-ID: <alpine.DEB.2.20.1801301935410.1797@nanos>
References: <alpine.LRH.2.21.1801291809460.13788@math.ut.ee> <alpine.DEB.2.20.1801291732092.1849@nanos>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018, Thomas Gleixner wrote:
> On Mon, 29 Jan 2018, Meelis Roos wrote:
> 
> > Upgraded some of my older machines to v4.15 today. On a quad P3 HP 
> > NetServer,
> 
> Your supply of vintage hardware is amazing.
> 
> > I get a bootup warning at kernel/irq/chip.c:244 
> > __irq_startup+0x80/0x100 (full dmesg below). It seems it was there 
> > before but I did not notice it.
> 
> > [   11.180167] WARNING: CPU: 3 PID: 258 at kernel/irq/chip.c:244 __irq_startup+0x80/0x100
> > [   11.180508] EIP: __irq_startup+0x80/0x100
> > [   11.180912]  irq_startup+0x7e/0x170
> > [   11.180977]  probe_irq_on+0x128/0x2b0
> > [   11.181054]  parport_irq_probe.constprop.18+0x8d/0x1af [parport_pc]
> > [   11.181127]  parport_pc_probe_port+0xf11/0x1260 [parport_pc]
> > [   11.181202]  parport_pc_init+0x78a/0xf10 [parport_pc]
> > [   11.181273]  ? parport_parse_param.constprop.16+0xf0/0xf0 [parport_pc]
> > [   11.181338]  do_one_initcall+0x45/0x1e0
> 
> Bah, that's the irq probing code, which I obviously missed... I'll have a look.

Does the patch below fix the issue for you?

Thanks,

	tglx

8<----------------
diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 4e8089b319ae..8c82ea26e837 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -71,7 +71,7 @@ unsigned long probe_irq_on(void)
 		raw_spin_lock_irq(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			desc->istate |= IRQS_AUTODETECT | IRQS_WAITING;
-			if (irq_startup(desc, IRQ_NORESEND, IRQ_START_FORCE))
+			if (irq_activate_and_startup(desc, IRQ_NORESEND))
 				desc->istate |= IRQS_PENDING;
 		}
 		raw_spin_unlock_irq(&desc->lock);
