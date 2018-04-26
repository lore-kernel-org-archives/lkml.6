Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeDZVLj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:11:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50255 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeDZVLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:11:38 -0400
Date: Thu, 26 Apr 2018 23:11:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Menzel <pmenzel+linux-x86@molgen.mpg.de>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Reducing time of smpboot
In-Reply-To: <a93a1222-cd94-3129-7a11-59fce1af12a5@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1804262308140.1596@nanos.tec.linutronix.de>
References: <a93a1222-cd94-3129-7a11-59fce1af12a5@molgen.mpg.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-726770841-1524777083=:1596"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-726770841-1524777083=:1596
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Paul,

On Thu, 5 Apr 2018, Paul Menzel wrote:
> Looking at the Linux 4.16 messages and the time stamps on the ASRock E350M1,
> there is the 100 ms jump below.
> 
> ```
> [    0.024000] Freeing SMP alternatives memory: 24K
> [    0.132000] smpboot: CPU0: AMD E-350D APU with Radeon(tm) HD Graphics
> (family: 0x14, model: 0x2, stepping: 0x0)
> […]
> [    0.132000] smp: Bringing up secondary CPUs ...
> [    0.132000] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.157950] CPU 1 irqstacks, hard=afb6c892 soft=83b5a704
> [    0.157956] x86: Booting SMP configuration:
> [    0.157959] .... node  #0, CPUs:      #1
> [    0.004000] Initializing CPU#1
> [    0.160213] smp: Brought up 1 node, 2 CPUs
> [    0.160213] smpboot: Max logical packages: 1
> [    0.160213] smpboot: Total of 2 processors activated (6400.34 BogoMIPS)
> ```
> 
> Also, the time stamp of the second CPU is out of order. Is that expected?

Kinda. It has not yet set up the proper infrastructure for printing correct
time stamps. That's a chicken and egg problem ...

> Are there debug options to figure out, what is happening in the 100 ms,
> without having to sprinkle print statements throughout the code?
> 
> Also, can the time be reduced? The firmware, coreboot in this case, should
> already set up the CPUs. So, can the second SMP init be avoided?

There is a difference between setup and bringup. The secondary CPU is
brought up via a special IPI or NMI and then it takes a break in the micro
code to prepare itself before magically making an appearance in the
kernel. There is not much we can do about that.

Thanks,

	tglx
--8323329-726770841-1524777083=:1596--
