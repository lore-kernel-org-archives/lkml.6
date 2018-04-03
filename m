Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755348AbeDCIvs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:51:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbeDCIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:51:13 -0400
Date: Tue, 3 Apr 2018 10:51:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression caused by commit bc976233a872, ethernet r8169 stops
 working after system S3
In-Reply-To: <4ABF72ED-A0C3-405D-8F02-785ED111F9FB@canonical.com>
Message-ID: <alpine.DEB.2.21.1804031050020.2511@nanos.tec.linutronix.de>
References: <E3F55561-8733-4056-ABEC-5AF87AC288CB@canonical.com> <alpine.DEB.2.21.1803302137510.1479@nanos.tec.linutronix.de> <4ABF72ED-A0C3-405D-8F02-785ED111F9FB@canonical.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2018, Kai-Heng Feng wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Sat, 31 Mar 2018, Kai-Heng Feng wrote:
> > > A user reported [1] that the Realtek ethernet r8169 stops working after S3
> > > since v4.15-rc6. The issue still exists in Linus' tree:
> > > 
> > > [ 150.877998] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
> > > [ 150.944101] do_IRQ: 3.37 No irq handler for vector
> > > [ 150.944105] r8169 0000:01:00.0 enp1s0: link down
> > > [ 150.944180] IPv6: ADDRCONF(NETDEV_UP): enp1s0: link is not ready
> > > 
> > > My desktop also has this device, which is also affected by this
> > > regression. So
> > > I did a bisect, and this is the bad commit:
> > > bc976233a872 genirq/msi x86/vector: Prevent reservation mode for non
> > > maskable
> > > MSI
> > > 
> > > After this commit gets reverted, the issue is gone.
> > 
> > Sigh. Can you please apply the debug patch below and provide the output of
> > 
> > # cat /proc/interrupts
> > 
> > and full dmesg after resume.
> 
> Weird. I don't see this issue with this debug patch.

Bah. The patch is broken. New version written with brain awake below.

Thanks,

	tglx

8<---------------------
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -134,6 +134,10 @@ static bool migrate_one_irq(struct irq_d
 		brokeaff = false;
 	}
 
+	pr_info("IRQ%u: New affinity: %*pbl effective: %*pbl\n",
+		d->irq, cpumask_pr_args(affinity),
+		cpumask_pr_args(irq_data_get_effective_affinity_mask(d)));
+
 	if (maskchip && chip->irq_unmask)
 		chip->irq_unmask(d);
 
