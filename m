Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCOM6U convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:58:20 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10]:50295 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeCOM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:58:16 -0400
From: =?iso-8859-1?Q?Patrick_Br=FCnn?= <P.Bruenn@beckhoff.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>
Subject: Re: [PATCH] clk: imx51: uart4, uart5 gates only exist on imx50,
 imx53
Thread-Topic: Re: [PATCH] clk: imx51: uart4, uart5 gates only exist on
 imx50, imx53
Thread-Index: AdO8WYz/ePIY4Y4AR4ar/zJUI8ARRA==
Date: Thu, 15 Mar 2018 12:43:13 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01F81FD1B9@nt-mail04>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.64.133]
x-olx-disclaimer: Done
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

since v4.16-rc1 my board imx53-cx9020 shows multiple WARNINGs like this:
[    0.408673] ------------[ cut here ]------------
[    0.408713] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:811 clk_core_disable+0x1ac/0x1b0
[    0.408717] Modules linked in:
[    0.408736] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc5 #312
[    0.408741] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.408777] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.408792] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.408808] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.408820] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.408831] [<c012b62c>] (warn_slowpath_null) from [<c0475550>] (clk_core_disable+0x1ac/0x1b0)
[    0.408845] [<c0475550>] (clk_core_disable) from [<c0475858>] (clk_core_disable_lock+0x28/0x34)
[    0.408857] [<c0475858>] (clk_core_disable_lock) from [<c0475890>] (clk_disable+0x2c/0x30)
[    0.408872] [<c0475890>] (clk_disable) from [<c0b2c128>] (imx_clk_disable_uart+0x5c/0x70)
[    0.408887] [<c0b2c128>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.408905] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.408920] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.408932] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.408938] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.408946] dfa0:                                     00000000 00000000 00000000 00000000
[    0.408955] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.408963] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.408968] ---[ end trace 6801852caf2a2e4e ]---

At first I suspected the new rtc-mxc_v2 driver, but even with CONFIG_RTC_DRV_MXC_V2 not set
I get the same WARNINGs.
Reverting commit 59dc3d8c867370b4860c9df3eb5483da46823a4b made them disappear (w/o rtc driver).

I have no idea what's happening, as CX9020 is using uart2. Do you have an idea?

Thanks and regards,
Patrick

p.s.: full kernel log:
dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.16.0-rc5 (patrickbr@lbs1) (gcc version 6.3.0 20170516 (Debian 6.3.0-18)) #312 PREEMPT Thu Mar 15 13:20:28 CET 2018
[    0.000000] CPU: ARMv7 Processor [412fc085] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Beckhoff CX9020 Embedded PC
[    0.000000] Memory policy: Data cache writeback
[    0.000000] cma: Reserved 16 MiB at 0xcf000000
[    0.000000] On node 0 totalpages: 262144
[    0.000000]   Normal zone: 1152 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 131072 pages, LIFO batch:31
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] random: fast init done
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260992
[    0.000000] Kernel command line: console=ttymxc1,115200 libphy.num_phys=2 console=tty0 quiet root=/dev/mmcblk0p1 ro rootfstype=ext4 rootwait fixrtc
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 1009948K/1048576K available (7168K kernel code, 542K rwdata, 2280K rodata, 1024K init, 690K bss, 22244K reserved, 16384K cma-reserved, 507904K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
                   lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
                     .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
                     .data : 0x(ptrval) - 0x(ptrval)   ( 543 kB)
                      .bss : 0x(ptrval) - 0x(ptrval)   ( 691 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] ftrace: allocating 24415 entries in 72 pages
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Tasks RCU enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] TrustZone Interrupt Controller (TZIC) initialized
[    0.000000] CPU identified as i.MX53, unknown revision
[    0.000000] Switching to timer-based delay loop, resolution 29ns
[    0.000010] sched_clock: 32 bits at 33MHz, resolution 29ns, wraps every 64424507889ns
[    0.000023] clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57337812242 ns
[    0.000697] Console: colour dummy device 80x30
[    0.000716] console [tty0] enabled
[    0.000746] Calibrating delay loop (skipped), value calculated using timer frequency.. 66.66 BogoMIPS (lpj=333333)
[    0.000761] pid_max: default: 32768 minimum: 301
[    0.001062] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.001075] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.001910] CPU: Testing write buffer coherency: ok
[    0.002695] Setting up static identity map for 0x70100000 - 0x7010003c
[    0.002865] Hierarchical SRCU implementation.
[    0.006423] devtmpfs: initialized
[    0.011240] VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 2
[    0.011525] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.011544] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.012785] pinctrl core: initialized pinctrl subsystem
[    0.013833] NET: Registered protocol family 16
[    0.015747] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.019106] hw-breakpoint: debug architecture 0x4 unsupported.
[    0.022635] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl driver
[    0.043050] SCSI subsystem initialized
[    0.043379] libata version 3.00 loaded.
[    0.043626] usbcore: registered new interface driver usbfs
[    0.043678] usbcore: registered new interface driver hub
[    0.043759] usbcore: registered new device driver usb
[    0.043919] usb_phy_generic usbphy-0: usbphy-0 supply vcc not found, using dummy regulator
[    0.044105] usb_phy_generic usbphy-1: usbphy-1 supply vcc not found, using dummy regulator
[    0.044921] i2c i2c-1: IMX I2C adapter registered
[    0.044938] i2c i2c-1: can't use DMA, using PIO instead.
[    0.045040] pps_core: LinuxPPS API ver. 1 registered
[    0.045046] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.045065] PTP clock support registered
[    0.046347] clocksource: Switched to clocksource mxc_timer1
[    0.119772] NET: Registered protocol family 2
[    0.120518] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    0.120545] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.120584] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.120621] TCP: Hash tables configured (established 4096 bind 4096)
[    0.120772] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.120788] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.120942] NET: Registered protocol family 1
[    0.121589] hw perfevents: no interrupt-affinity property for /pmu, guessing.
[    0.121681] hw perfevents: enabled with armv7_cortex_a8 PMU driver, 5 counters available
[    0.123109] workingset: timestamp_bits=14 max_order=18 bucket_order=4
[    0.128601] zbud: loaded
[    0.130396] fuse init (API version 7.26)
[    0.135702] bounce: pool size: 64 pages
[    0.135815] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    0.136033] io scheduler noop registered
[    0.136040] io scheduler deadline registered
[    0.136453] io scheduler cfq registered (default)
[    0.136463] io scheduler mq-deadline registered
[    0.139061] imx-sdma 63fb0000.sdma: Direct firmware load for imx/sdma/sdma-imx53.bin failed with error -2
[    0.139073] imx-sdma 63fb0000.sdma: Falling back to user helper
[    0.141381] Serial: 8250/16550 driver, 6 ports, IRQ sharing disabled
[    0.143414] 53fc0000.serial: ttymxc1 at MMIO 0x53fc0000 (irq = 48, base_baud = 4166666) is a IMX
[    0.143679] console [ttymxc1] enabled
[    0.145425] tfp410-bridge dvi-converter: Connector's ddc i2c bus found
[    0.146948] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.146957] [drm] No driver support for vblank timestamp query.
[    0.147158] imx-drm display-subsystem: bound imx-ipuv3-crtc.2 (ops ipu_crtc_ops)
[    0.147260] imx-drm display-subsystem: bound imx-ipuv3-crtc.3 (ops ipu_crtc_ops)
[    0.147371] imx-drm display-subsystem: bound display-0 (ops imx_pd_ops)
[    0.260163] Console: switching to colour frame buffer device 240x75
[    0.275934] imx-drm display-subsystem: fb0:  frame buffer device
[    0.276637] [drm] Initialized imx-drm 1.0.0 20120507 for display-subsystem on minor 0
[    0.276686] imx-ipuv3 18000000.ipu: IPUv3M probed
[    0.278061] libphy: Fixed MDIO Bus: probed
[    0.278975] fec 63fec000.ethernet: 63fec000.ethernet supply phy not found, using dummy regulator
[    0.286076] libphy: fec_enet_mii_bus: probed
[    0.287846] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.287873] ehci-platform: EHCI generic platform driver
[    0.292128] ci_hdrc ci_hdrc.0: doesn't support gadget
[    0.292140] ci_hdrc ci_hdrc.0: no supported roles
[    0.300260] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    0.300513] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
[    0.326390] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    0.326667] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.326676] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.326683] usb usb1: Product: EHCI Host Controller
[    0.326689] usb usb1: Manufacturer: Linux 4.16.0-rc5 ehci_hcd
[    0.326696] usb usb1: SerialNumber: ci_hdrc.1
[    0.327293] hub 1-0:1.0: USB hub found
[    0.327340] hub 1-0:1.0: 1 port detected
[    0.328670] mousedev: PS/2 mouse device common for all mice
[    0.328678] i2c /dev entries driver
[    0.329890] imx2-wdt 53f98000.wdog: timeout 60 sec (nowayout=1)
[    0.330272] sdhci: Secure Digital Host Controller Interface driver
[    0.330277] sdhci: Copyright(c) Pierre Ossman
[    0.330281] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.330982] sdhci-esdhc-imx 50004000.esdhc: Got CD GPIO
[    0.356584] mmc0: SDHCI controller on 50004000.esdhc [50004000.esdhc] using ADMA
[    0.357342] sdhci-esdhc-imx 50008000.esdhc: Got CD GPIO
[    0.382616] mmc1: SDHCI controller on 50008000.esdhc [50008000.esdhc] using ADMA
[    0.383766] hidraw: raw HID events driver (C) Jiri Kosina
[    0.384195] usbcore: registered new interface driver usbhid
[    0.384201] usbhid: USB HID core driver
[    0.385807] NET: Registered protocol family 10
[    0.387827] Segment Routing with IPv6
[    0.387906] mip6: Mobile IPv6
[    0.387922] NET: Registered protocol family 17
[    0.387964] Key type dns_resolver registered
[    0.388149] ThumbEE CPU extension supported.
[    0.388742] registered taskstats version 1
[    0.388946] zswap: loaded using pool lzo/zbud
[    0.390385] Key type encrypted registered
[    0.391467] mmc0: host does not support reading read-only switch, assuming write-enable
[    0.394571] mmc0: new high speed SD card at address b368
[    0.396122] mmcblk0: mmc0:b368 AF UD 471 MiB
[    0.405724] hctosys: unable to open rtc device (rtc0)
[    0.406481]  mmcblk0: p1
[    0.408673] ------------[ cut here ]------------
[    0.408713] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:811 clk_core_disable+0x1ac/0x1b0
[    0.408717] Modules linked in:
[    0.408736] CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc5 #312
[    0.408741] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.408777] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.408792] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.408808] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.408820] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.408831] [<c012b62c>] (warn_slowpath_null) from [<c0475550>] (clk_core_disable+0x1ac/0x1b0)
[    0.408845] [<c0475550>] (clk_core_disable) from [<c0475858>] (clk_core_disable_lock+0x28/0x34)
[    0.408857] [<c0475858>] (clk_core_disable_lock) from [<c0475890>] (clk_disable+0x2c/0x30)
[    0.408872] [<c0475890>] (clk_disable) from [<c0b2c128>] (imx_clk_disable_uart+0x5c/0x70)
[    0.408887] [<c0b2c128>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.408905] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.408920] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.408932] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.408938] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.408946] dfa0:                                     00000000 00000000 00000000 00000000
[    0.408955] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.408963] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.408968] ---[ end trace 6801852caf2a2e4e ]---
[    0.408974] ------------[ cut here ]------------
[    0.408985] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:684 clk_core_unprepare+0x1a8/0x1c0
[    0.408988] Modules linked in:
[    0.408999] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.409003] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.409014] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.409024] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.409034] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.409043] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.409054] [<c012b62c>] (warn_slowpath_null) from [<c04751e8>] (clk_core_unprepare+0x1a8/0x1c0)
[    0.409067] [<c04751e8>] (clk_core_unprepare) from [<c0476714>] (clk_unprepare+0x34/0x3c)
[    0.409078] [<c0476714>] (clk_unprepare) from [<c0b2c130>] (imx_clk_disable_uart+0x64/0x70)
[    0.409089] [<c0b2c130>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.409100] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.409110] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.409120] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.409125] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.409132] dfa0:                                     00000000 00000000 00000000 00000000
[    0.409141] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.409148] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.409153] ---[ end trace 6801852caf2a2e4f ]---
[    0.409158] ------------[ cut here ]------------
[    0.409166] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:811 clk_core_disable+0x1ac/0x1b0
[    0.409169] Modules linked in:
[    0.409178] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.409182] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.409193] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.409202] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.409211] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.409221] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.409231] [<c012b62c>] (warn_slowpath_null) from [<c0475550>] (clk_core_disable+0x1ac/0x1b0)
[    0.409242] [<c0475550>] (clk_core_disable) from [<c0475858>] (clk_core_disable_lock+0x28/0x34)
[    0.409253] [<c0475858>] (clk_core_disable_lock) from [<c0475890>] (clk_disable+0x2c/0x30)
[    0.409263] [<c0475890>] (clk_disable) from [<c0b2c128>] (imx_clk_disable_uart+0x5c/0x70)
[    0.409273] [<c0b2c128>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.409283] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.409293] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.409303] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.409307] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.409314] dfa0:                                     00000000 00000000 00000000 00000000
[    0.409323] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.409331] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.409336] ---[ end trace 6801852caf2a2e50 ]---
[    0.409340] ------------[ cut here ]------------
[    0.409349] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:684 clk_core_unprepare+0x1a8/0x1c0
[    0.409352] Modules linked in:
[    0.409361] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.409365] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.409375] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.409384] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.409393] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.409402] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.409412] [<c012b62c>] (warn_slowpath_null) from [<c04751e8>] (clk_core_unprepare+0x1a8/0x1c0)
[    0.409423] [<c04751e8>] (clk_core_unprepare) from [<c0476714>] (clk_unprepare+0x34/0x3c)
[    0.409434] [<c0476714>] (clk_unprepare) from [<c0b2c130>] (imx_clk_disable_uart+0x64/0x70)
[    0.409445] [<c0b2c130>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.409455] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.409465] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.409475] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.409480] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.409486] dfa0:                                     00000000 00000000 00000000 00000000
[    0.409495] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.409503] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.409508] ---[ end trace 6801852caf2a2e51 ]---
[    0.409512] ------------[ cut here ]------------
[    0.409521] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:811 clk_core_disable+0x1ac/0x1b0
[    0.409524] Modules linked in:
[    0.409533] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.409537] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.409547] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.409556] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.409565] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.409574] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.409585] [<c012b62c>] (warn_slowpath_null) from [<c0475550>] (clk_core_disable+0x1ac/0x1b0)
[    0.409596] [<c0475550>] (clk_core_disable) from [<c0475858>] (clk_core_disable_lock+0x28/0x34)
[    0.409607] [<c0475858>] (clk_core_disable_lock) from [<c0475890>] (clk_disable+0x2c/0x30)
[    0.409617] [<c0475890>] (clk_disable) from [<c0b2c128>] (imx_clk_disable_uart+0x5c/0x70)
[    0.409627] [<c0b2c128>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.409637] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.409647] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.409656] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.409661] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.409668] dfa0:                                     00000000 00000000 00000000 00000000
[    0.409677] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.409684] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.409689] ---[ end trace 6801852caf2a2e52 ]---
[    0.409693] ------------[ cut here ]------------
[    0.409702] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:684 clk_core_unprepare+0x1a8/0x1c0
[    0.409704] Modules linked in:
[    0.409714] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.409718] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.409728] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.409737] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.409746] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.409755] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.409766] [<c012b62c>] (warn_slowpath_null) from [<c04751e8>] (clk_core_unprepare+0x1a8/0x1c0)
[    0.409776] [<c04751e8>] (clk_core_unprepare) from [<c0476714>] (clk_unprepare+0x34/0x3c)
[    0.409787] [<c0476714>] (clk_unprepare) from [<c0b2c130>] (imx_clk_disable_uart+0x64/0x70)
[    0.409797] [<c0b2c130>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.409808] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.409818] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.409827] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.409832] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.409839] dfa0:                                     00000000 00000000 00000000 00000000
[    0.409848] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.409856] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.409861] ---[ end trace 6801852caf2a2e53 ]---
[    0.409865] ------------[ cut here ]------------
[    0.409873] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:811 clk_core_disable+0x1ac/0x1b0
[    0.409876] Modules linked in:
[    0.409885] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.409889] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.409899] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.409908] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.409917] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.409926] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.409936] [<c012b62c>] (warn_slowpath_null) from [<c0475550>] (clk_core_disable+0x1ac/0x1b0)
[    0.409947] [<c0475550>] (clk_core_disable) from [<c0475858>] (clk_core_disable_lock+0x28/0x34)
[    0.409958] [<c0475858>] (clk_core_disable_lock) from [<c0475890>] (clk_disable+0x2c/0x30)
[    0.409968] [<c0475890>] (clk_disable) from [<c0b2c128>] (imx_clk_disable_uart+0x5c/0x70)
[    0.409978] [<c0b2c128>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.409988] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.409999] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.410008] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.410013] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.410020] dfa0:                                     00000000 00000000 00000000 00000000
[    0.410028] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.410036] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.410041] ---[ end trace 6801852caf2a2e54 ]---
[    0.410045] ------------[ cut here ]------------
[    0.410054] WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:684 clk_core_unprepare+0x1a8/0x1c0
[    0.410056] Modules linked in:
[    0.410066] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        4.16.0-rc5 #312
[    0.410070] Hardware name: Freescale i.MX53 (Device Tree Support)
[    0.410080] [<c011057c>] (unwind_backtrace) from [<c010db3c>] (show_stack+0x20/0x24)
[    0.410089] [<c010db3c>] (show_stack) from [<c07a0034>] (dump_stack+0x24/0x28)
[    0.410098] [<c07a0034>] (dump_stack) from [<c012b524>] (__warn+0x100/0x118)
[    0.410108] [<c012b524>] (__warn) from [<c012b62c>] (warn_slowpath_null+0x50/0x58)
[    0.410118] [<c012b62c>] (warn_slowpath_null) from [<c04751e8>] (clk_core_unprepare+0x1a8/0x1c0)
[    0.410129] [<c04751e8>] (clk_core_unprepare) from [<c0476714>] (clk_unprepare+0x34/0x3c)
[    0.410140] [<c0476714>] (clk_unprepare) from [<c0b2c130>] (imx_clk_disable_uart+0x64/0x70)
[    0.410150] [<c0b2c130>] (imx_clk_disable_uart) from [<c01029a4>] (do_one_initcall+0x64/0x19c)
[    0.410160] [<c01029a4>] (do_one_initcall) from [<c0b00fac>] (kernel_init_freeable+0x14c/0x1e0)
[    0.410170] [<c0b00fac>] (kernel_init_freeable) from [<c07b5a30>] (kernel_init+0x18/0x124)
[    0.410179] [<c07b5a30>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
[    0.410184] Exception stack(0xdf90dfb0 to 0xdf90dff8)
[    0.410191] dfa0:                                     00000000 00000000 00000000 00000000
[    0.410200] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.410208] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    0.410213] ---[ end trace 6801852caf2a2e55 ]---
[    0.416573] EXT4-fs (mmcblk0p1): mounted filesystem without journal. Opts: (null)
[    0.416661] VFS: Mounted root (ext4 filesystem) readonly on device 179:1.
[    0.420559] devtmpfs: mounted
[    0.425193] Freeing unused kernel memory: 1024K
[    0.696469] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    0.809863] systemd[1]: System time before build time, advancing clock.
[    0.839865] systemd[1]: Failed to insert module 'autofs4': No such file or directory
[    0.873145] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    0.873826] systemd[1]: Detected architecture arm.
[    0.874785] systemd[1]: Set hostname to <CX9020>.
[    0.897151] usb 1-1: New USB device found, idVendor=0424, idProduct=2514
[    0.897168] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    0.897873] hub 1-1:1.0: USB hub found
[    0.897991] hub 1-1:1.0: 4 ports detected
[    1.216525] usb 1-1.1: new high-speed USB device number 3 using ci_hdrc
[    1.360035] systemd[1]: Reached target Swap.
[    1.360585] systemd[1]: Reached target Remote File Systems.
[    1.360946] systemd[1]: Listening on fsck to fsckd communication Socket.
[    1.361440] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    1.361811] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    1.362201] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    1.363297] systemd[1]: Created slice System Slice.
[    1.377182] usb 1-1.1: New USB device found, idVendor=05e3, idProduct=0610
[    1.377198] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.377205] usb 1-1.1: Product: USB2.0 Hub
[    1.377211] usb 1-1.1: Manufacturer: GenesysLogic
[    1.379076] hub 1-1.1:1.0: USB hub found
[    1.380676] hub 1-1.1:1.0: 4 ports detected
[    3.676492] usb 1-1.1.2: new high-speed USB device number 4 using ci_hdrc
[    3.827769] usb 1-1.1.2: New USB device found, idVendor=0451, idProduct=8142
[    3.827788] usb 1-1.1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    3.827796] usb 1-1.1.2: SerialNumber: 7A030869B55E
[    3.828516] hub 1-1.1.2:1.0: USB hub found
[    3.828753] hub 1-1.1.2:1.0: 4 ports detected
[    3.867227] EXT4-fs (mmcblk0p1): re-mounted. Opts: errors=remount-ro
[    4.110288] systemd-journald[91]: Received request to flush runtime journal from PID 1
[    4.146573] usb 1-1.1.2.4: new high-speed USB device number 5 using ci_hdrc
[    4.301003] usb 1-1.1.2.4: New USB device found, idVendor=0451, idProduct=8142
[    4.301018] usb 1-1.1.2.4: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    4.301026] usb 1-1.1.2.4: SerialNumber: 7A030849B55E
[    4.301778] hub 1-1.1.2.4:1.0: USB hub found
[    4.302002] hub 1-1.1.2.4:1.0: 4 ports detected
[    4.616480] usb 1-1.1.2.4.3: new full-speed USB device number 6 using ci_hdrc
[    4.790027] usb 1-1.1.2.4.3: New USB device found, idVendor=0451, idProduct=ca01
[    4.790047] usb 1-1.1.2.4.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.790055] usb 1-1.1.2.4.3: Product: Texas Instruments USBtoI2C Solution
[    4.790062] usb 1-1.1.2.4.3: Manufacturer: Texas Instruments
[    4.790068] usb 1-1.1.2.4.3: SerialNumber:
[    4.804574] hid-generic 0003:0451:CA01.0001: hiddev0,hidraw0: USB HID v1.00 Device [Texas Instruments Texas Instruments USBtoI2C Solution] on usb-ci_hdrc.1-1.1.2.4.3/input0
[    4.873609] Generic PHY 63fec000.ethernet-1:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=63fec000.ethernet-1:01, irq=POLL)
[    4.873815] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    5.106386] usb 1-1.1.2.4.2: new low-speed USB device number 7 using ci_hdrc
[    5.266510] usb 1-1.1.2.4.2: New USB device found, idVendor=046a, idProduct=0011
[    5.266524] usb 1-1.1.2.4.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.282646] input: HID 046a:0011 as /devices/platform/soc/50000000.aips/53f80200.usb/ci_hdrc.1/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2.4/1-1.1.2.4.2/1-1.1.2.4.2:1.0/0003:046A:0011.0002/input/input0
[    5.346763] hid-generic 0003:046A:0011.0002: input,hidraw1: USB HID v1.11 Keyboard [HID 046a:0011] on usb-ci_hdrc.1-1.1.2.4.2/input0
[    6.966965] fec 63fec000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[    6.967001] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   19.811909] random: crng init done
---
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
