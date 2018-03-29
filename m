Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbeC2LbX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:31:23 -0400
Received: from mail.thorsis.com ([92.198.35.195]:42543 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752983AbeC2LbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:31:21 -0400
From: Alexander Dahl <ada@thorsis.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
Date: Thu, 29 Mar 2018 13:31:18 +0200
Message-ID: <3103570.fW0XyqvKVi@ada>
In-Reply-To: <20180329104542.GK13942@piout.net>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com> <3478710.yJBBt3uoRT@ada> <20180329104542.GK13942@piout.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2TBVTAA005456

Hello Alexandre,

Am Donnerstag, 29. März 2018, 12:45:42 CEST schrieb Alexandre Belloni:
> > This is the result:
> > 
> > INT                NAME          RATE             MAX
> > 
> >  17 [vel     timer@fffa]  1837 Ints/s     (max:  1912)
> >  26 [      vel     eth0]     3 Ints/s     (max:    11)
> > 
> > This is not much lower than the ~2150 I reported yesterday?
> > 
> > I'm sorry I can just test this on at91sam9g20 currently, I have no
> > understanding of the subsystem, I can't do a decent review.
> 
> Hum, are you sure, I went from:
> 
> INT                NAME          RATE             MAX
>  16 [evel     timer@fc0]  1027 Ints/s     (max:  1028)
>  21 [ evel     at_xdmac]     3 Ints/s     (max:     3)
>  30 [    evel     ttyS0]     2 Ints/s     (max:     2)
> 
> to:
> 
> INT                NAME          RATE             MAX
>  16 [evel     timer@fc0]     6 Ints/s     (max:     9)
>  21 [ evel     at_xdmac]     2 Ints/s     (max:     2)
>  30 [    evel     ttyS0]     2 Ints/s     (max:     2)

Pretty sure. I rebuilt the whole BSP and added another line to the kernel 
source to see if the tree I applied the patches to, was actually built:


diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7fde9cfbf203..f85affc74a86 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -222,7 +222,8 @@ static int __init tc_clkevt_register(struct device_node *node,
                goto err_slow;
        clk_disable(tce.clk);
 
-       clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
+       pr_info( "*** bits: 0x%x, BIT(bits): 0x%lx\n", bits, BIT(bits) );
+       clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
 
        ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
                          tce.clkevt.name, &tce);


See the more complete serial console output (including the additional 
message):


Starting kernel ...

** 15 printk messages dropped **
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 28624K/32768K available (2934K kernel code, 113K rwdata, 436K rodata, 144K init, 73K bss, 4144K reserved, 0K cma-reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc2800000 - 0xff800000   ( 976 MB)
    lowmem  : 0xc0000000 - 0xc2000000   (  32 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0x(ptrval) - 0x(ptrval)   (2936 kB)
      .init : 0x(ptrval) - 0x(ptrval)   ( 144 kB)
      .data : 0x(ptrval) - 0x(ptrval)   ( 114 kB)
       .bss : 0x(ptrval) - 0x(ptrval)   (  74 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
        Tasks RCU enabled.
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
clocksource: timer@fffa0000:0,1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 115749784805 ns
sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every 130055938017ns
*** bits: 0x10, BIT(bits): 0x10000
Console: colour dummy device 80x30
Calibrating delay loop... 197.01 BogoMIPS (lpj=985088)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x20008400 - 0x2000843c
Hierarchical SRCU implementation.
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 3072 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
gpio-at91 fffff400.gpio: at address 82332323
gpio-at91 fffff600.gpio: at address a4bf53d9
gpio-at91 fffff800.gpio: at address 31e4ab7c
pinctrl-at91 ahb:apb:pinctrl@fffff400: initialized AT91 pinctrl driver
AT91: Detected SoC: at91sam9g20, revision 1
clocksource: Switched to clocksource timer@fffa0000:0,1
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
workingset: timestamp_bits=30 max_order=13 bucket_order=0
io scheduler noop registered (default)
fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 18, base_baud = 8256000) is a ATMEL_SERIAL
console [ttyS0] enabled
rtc rtc0: invalid alarm value: 1900-1-29 0:0:0
rtc-at91sam9 fffffd20.rtc: rtc core: registered fffffd20.rtc as rtc0
nand: device found, Manufacturer ID: 0x01, Chip ID: 0xda
nand: AMD/Spansion S34ML02G1
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64


Greets
Alex
