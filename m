Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A637C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D10424191
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D10424191
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbeFVQDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:03:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeFVQDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:03:09 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8C56DF124F36;
        Sat, 23 Jun 2018 00:02:52 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Sat, 23 Jun 2018
 00:02:46 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
 <20180622142851.g3r4em3kidx5p3wv@lakrids.cambridge.arm.com>
 <5B2D1595.6020000@hisilicon.com> <20180622154117.GC1802@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <dave.martin@arm.com>,
        <marc.zyngier@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>,
        "Chenxin (Charles)" <charles.chenxin@huawei.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        <jonathan.cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>, <zhangbin011@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B2D1DA7.9040201@hisilicon.com>
Date:   Sat, 23 Jun 2018 00:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180622154117.GC1802@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Mark,

On 2018/6/22 23:41, Will Deacon wrote:
> On Fri, Jun 22, 2018 at 11:28:21PM +0800, Wei Xu wrote:
>> On 2018/6/22 22:28, Mark Rutland wrote:
>>> On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
>>>>      [    0.227507] Mem abort info:
>>>>      [    0.230390]   ESR = 0x96000006
>>>>      [    0.233517]   Exception class = DABT (current EL), IL = 32 bits
>>>>      [    0.239428]   SET = 0, FnV = 0
>>>>      [    0.242555]   EA = 0, S1PTW = 0
>>>>      [    0.245797] Data abort info:
>>>>      [    0.248795]   ISV = 0, ISS = 0x00000006
>>>>      [    0.252652]   CM = 0, WnR = 0
>>>>      [    0.255769] swapper pgtable: 4k pages, 48-bit VAs, pgdp =
>>>> (ptrval)
>>>>      [    0.262645] [ffff0000093abce0] pgd=00000000411f8803,
>>>> pud=00000000411f9803, pmd=0000000000000000
>>> ... and here the PMD for the task stack is all zeroes, so evidently
>>> that's getting corrupted somehow.
>>>
>>> It appears that the overflow stack (which IIRC is embedded within the
>>> kernel's data segment, as part of the image mapping), is fine.
>>>
>>> I wonder if there's some existing weirdness in the page tables for the
>>> vmalloc area that causes things to go wrong. Can you please:
>>>
>>> * enable ARM64_PTDUMP_DEBUGFS
>>>
>>> * boot with kpti=off (with Will's patch to make this work)
>>>
>>> * as root, cat /sys/kernel/debug/kernel_page_tables
>>>
>>> ... and dump the result here?
>> Thanks!
>> Can I do this later since Will's new patch works?
> Yes, you should probably go to bed now! Please note that my patch still
> isn't the right thing for mainline, since it avoids setting PTE_NG for
> tables and therefore won't solve the boot-time issue with KASAN enabled.
>
> We also don't understand why clean+invalidate is causing the issue on your
> CPU, whereas clean does not. It looks like clean+invalidate somehow results
> in page table entries being zeroed.
>
> Have a good weekend,

Got it. Thanks and enjoy the fifa world cup :)
Below is the log enabled ARM64_PTDUMP_DEBUGFS.
Only Will's kpti early_param patch on 4.17.0.
Hope it helps.

     ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-v
     ersion=3 -cpu host -enable-kvm -smp 1 -m 1024 -kernel 
./Image-4.17-joyx -initrd
     ../mini-rootfs-arm64.cpio.gz -nographic -append "kpti=off 
rdinit=init console=tt
     yAMA0 earlycon=pl011,0x9000000"
     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
     [    0.000000] Linux version 4.17.0-45865-ga3d6816 
(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #19 
SMP PREEMPT Fri Jun 22 23:47:07 CST 2018
     [    0.000000] Machine model: linux,dummy-virt
     [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
     [    0.000000] bootconsole [pl11] enabled
     [    0.000000] efi: Getting EFI parameters from FDT:
     [    0.000000] efi: UEFI not found.
     [    0.000000] cma: Reserved 16 MiB at 0x000000007f000000
     [    0.000000] NUMA: No NUMA configuration found
     [    0.000000] NUMA: Faking a node at [mem 
0x0000000000000000-0x000000007fffffff]
     [    0.000000] NUMA: NODE_DATA [mem 0x7efeb300-0x7efecdff]
     [    0.000000] Zone ranges:
     [    0.000000]   DMA32    [mem 0x0000000040000000-0x000000007fffffff]
     [    0.000000]   Normal   empty
     [    0.000000] Movable zone start for each node
     [    0.000000] Early memory node ranges
     [    0.000000]   node   0: [mem 0x0000000040000000-0x000000007fffffff]
     [    0.000000] Initmem setup node 0 [mem 
0x0000000040000000-0x000000007fffffff]
     [    0.000000] psci: probing for conduit method from DT.
     [    0.000000] psci: PSCIv1.0 detected in firmware.
     [    0.000000] psci: Using standard PSCI v0.2 function IDs
     [    0.000000] psci: Trusted OS migration not required
     [    0.000000] psci: SMC Calling Convention v1.1
     [    0.000000] random: get_random_bytes called from 
start_kernel+0xa8/0x418 with crng_init=0
     [    0.000000] percpu: Embedded 24 pages/cpu @        (ptrval) 
s57984 r8192 d32128 u98304
     [    0.000000] Detected VIPT I-cache on CPU0
     [    0.000000] CPU features: kernel page table isolation forced OFF 
by command line option
     [    0.000000] CPU features: detected: Hardware dirty bit management
     [    0.000000] Built 1 zonelists, mobility grouping on.  Total 
pages: 258048
     [    0.000000] Policy zone: DMA32
     [    0.000000] Kernel command line: kpti=off rdinit=init 
console=ttyAMA0 earlycon=pl011,0x9000000
     [    0.000000] Memory: 968436K/1048576K available (10044K kernel 
code, 1328K rwdata, 4840K rodata, 1216K init, 409K bss, 63756K reserved, 
16384K cma-reserved)
     [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, 
Nodes=1
     [    0.000000] Preemptible hierarchical RCU implementation.
     [    0.000000]     RCU restricting CPUs from NR_CPUS=128 to 
nr_cpu_ids=1.
     [    0.000000]     Tasks RCU enabled.
     [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, 
nr_cpu_ids=1
     [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
     [    0.000000] GICv3: Distributor has no Range Selector support
     [    0.000000] GICv3: no VLPI support, no direct LPI support
     [    0.000000] ITS [mem 0x08080000-0x0809ffff]
     [    0.000000] ITS@0x0000000008080000: allocated 8192 Devices 
@7d830000 (indirect, esz 8, psz 64K, shr 1)
     [    0.000000] ITS@0x0000000008080000: allocated 8192 Interrupt 
Collections @7d840000 (flat, esz 8, psz 64K, shr 1)
     [    0.000000] GIC: using LPI property table @0x000000007d850000
     [    0.000000] ITS: Allocated 1792 chunks for LPIs
     [    0.000000] GICv3: CPU0: found redistributor 0 region 
0:0x00000000080a0000
     [    0.000000] CPU0: using LPI pending table @0x000000007d860000
     [    0.000000] GIC: PPI11 is secure or misconfigured
     [    0.000000] arch_timer: WARNING: Invalid trigger for IRQ3, 
assuming level low
     [    0.000000] arch_timer: WARNING: Please fix your firmware
     [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
     [    0.000000] clocksource: arch_sys_counter: mask: 
0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
     [    0.000001] sched_clock: 56 bits at 100MHz, resolution 10ns, 
wraps every 4398046511100ns
     [    0.000859] Console: colour dummy device 80x25
     [    0.001459] Calibrating delay loop (skipped), value calculated 
using timer frequency.. 200.00 BogoMIPS (lpj=400000)
     [    0.002537] pid_max: default: 32768 minimum: 301
     [    0.003028] Security Framework initialized
     [    0.003606] Dentry cache hash table entries: 131072 (order: 8, 
1048576 bytes)
     [    0.004418] Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
     [    0.005129] Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.005938] Mountpoint-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.026041] ASID allocator initialised with 32768 entries
     [    0.030055] Hierarchical SRCU implementation.
     [    0.034426] Platform MSI: its domain created
     [    0.034885] PCI/MSI: /intc/its domain created
     [    0.035457] EFI services will not be available.
     [    0.038086] smp: Bringing up secondary CPUs ...
     [    0.038557] smp: Brought up 1 node, 1 CPU
     [    0.038966] SMP: Total of 1 processors activated.
     [    0.039447] CPU features: detected: GIC system register CPU 
interface
     [    0.040101] CPU features: detected: Privileged Access Never
     [    0.040667] CPU features: detected: User Access Override
     [    0.041988] CPU: All CPU(s) started at EL1
     [    0.042536] alternatives: patching kernel code
     [    0.044809] devtmpfs: initialized
     [    0.046662] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
     [    0.049470] futex hash table entries: 256 (order: 3, 32768 bytes)
     [    0.055780] pinctrl core: initialized pinctrl subsystem
     [    0.061504] DMI not present or invalid.
     [    0.065230] NET: Registered protocol family 16
     [    0.069514] audit: initializing netlink subsys (disabled)
     [    0.075351] cpuidle: using governor menu
     [    0.078855] audit: type=2000 audit(0.068:1): state=initialized 
audit_enabled=0 res=1
     [    0.086714] vdso: 2 pages (1 code @         (ptrval), 1 data 
@         (ptrval))
     [    0.094456] hw-breakpoint: found 6 breakpoint and 4 watchpoint 
registers.
     [    0.101869] DMA: preallocated 256 KiB pool for atomic allocations
     [    0.107408] Serial: AMBA PL011 UART driver
     [    0.114802] 9000000.pl011: ttyAMA0 at MMIO 0x9000000 (irq = 39, 
base_baud = 0) is a PL011 rev1
     [    0.120256] console [ttyAMA0] enabled
     [    0.120256] console [ttyAMA0] enabled
     [    0.127525] bootconsole [pl11] disabled
     [    0.127525] bootconsole [pl11] disabled
     [    0.135667] irq: type mismatch, failed to map hwirq-27 for intc!
     [    0.153827] HugeTLB registered 2.00 MiB page size, pre-allocated 
0 pages
     [    0.157547] cryptd: max_cpu_qlen set to 1000
     [    0.165692] ACPI: Interpreter disabled.
     [    0.166341] vgaarb: loaded
     [    0.166629] SCSI subsystem initialized
     [    0.169664] usbcore: registered new interface driver usbfs
     [    0.170139] usbcore: registered new interface driver hub
     [    0.174110] usbcore: registered new device driver usb
     [    0.179293] pps_core: LinuxPPS API ver. 1 registered
     [    0.184239] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
     [    0.193320] PTP clock support registered
     [    0.197360] EDAC MC: Ver: 3.0.0
     [    0.201468] Advanced Linux Sound Architecture Driver Initialized.
     [    0.207035] clocksource: Switched to clocksource arch_sys_counter
     [    0.212870] VFS: Disk quotas dquot_6.6.0
     [    0.216844] VFS: Dquot-cache hash table entries: 512 (order 0, 
4096 bytes)
     [    0.223782] pnp: PnP ACPI: disabled
     [    0.229309] NET: Registered protocol family 2
     [    0.232711] tcp_listen_portaddr_hash hash table entries: 512 
(order: 1, 8192 bytes)
     [    0.239478] TCP established hash table entries: 8192 (order: 4, 
65536 bytes)
     [    0.246564] TCP bind hash table entries: 8192 (order: 5, 131072 
bytes)
     [    0.253246] TCP: Hash tables configured (established 8192 bind 8192)
     [    0.259572] UDP hash table entries: 512 (order: 2, 16384 bytes)
     [    0.265610] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
     [    0.272044] NET: Registered protocol family 1
     [    0.288576] RPC: Registered named UNIX socket transport module.
     [    0.289058] RPC: Registered udp transport module.
     [    0.289434] RPC: Registered tcp transport module.
     [    0.291949] RPC: Registered tcp NFSv4.1 backchannel transport 
module.
     [    0.298471] Unpacking initramfs...
     [    0.835705] Freeing initrd memory: 29212K
     [    0.836273] hw perfevents: enabled with armv8_pmuv3 PMU driver, 
13 counters available
     [    0.837026] kvm [1]: HYP mode not available
     [    0.838111] Initialise system trusted keyrings
     [    0.838710] workingset: timestamp_bits=44 max_order=18 
bucket_order=0
     [    0.840716] squashfs: version 4.0 (2009/01/31) Phillip Lougher
     [    0.846449] NFS: Registering the id_resolver key type
     [    0.846892] Key type id_resolver registered
     [    0.847453] Key type id_legacy registered
     [    0.847789] nfs4filelayout_init: NFSv4 File Layout Driver 
Registering...
     [    0.848383] 9p: Installing v9fs 9p2000 file system support
     [    0.848878] pstore: using deflate compression
     [    0.849942] Key type asymmetric registered
     [    0.850303] Asymmetric key parser 'x509' registered
     [    0.850729] Block layer SCSI generic (bsg) driver version 0.4 
loaded (major 245)
     [    0.851480] io scheduler noop registered
     [    0.851801] io scheduler deadline registered
     [    0.852215] io scheduler cfq registered (default)
     [    0.852595] io scheduler mq-deadline registered
     [    0.852955] io scheduler kyber registered
     [    0.855192] pl061_gpio 9030000.pl061: PL061 GPIO chip 
@0x0000000009030000 registered
     [    0.857039] PCI: OF: host bridge /pcie@10000000 ranges:
     [    0.857481] PCI: OF:    IO 0x3eff0000..0x3effffff -> 0x00000000
     [    0.857953] PCI: OF:   MEM 0x10000000..0x3efeffff -> 0x10000000
     [    0.858435] PCI: OF:   MEM 0x8000000000..0xffffffffff -> 
0x8000000000
     [    0.858956] pci-host-generic 3f000000.pcie: ECAM at [mem 
0x3f000000-0x3fffffff] for [bus 00-0f]
     [    0.860042] pci-host-generic 3f000000.pcie: PCI host bridge to 
bus 0000:00
     [    0.860598] pci_bus 0000:00: root bus resource [bus 00-0f]
     [    0.861034] pci_bus 0000:00: root bus resource [io 0x0000-0xffff]
     [    0.861524] pci_bus 0000:00: root bus resource [mem 
0x10000000-0x3efeffff]
     [    0.862074] pci_bus 0000:00: root bus resource [mem 
0x8000000000-0xffffffffff]
     [    0.863568] pci 0000:00:01.0: BAR 6: assigned [mem 
0x10000000-0x1003ffff pref]
     [    0.864147] pci 0000:00:01.0: BAR 4: assigned [mem 
0x8000000000-0x8000003fff 64bit pref]
     [    0.864803] pci 0000:00:01.0: BAR 1: assigned [mem 
0x10040000-0x10040fff]
     [    0.865342] pci 0000:00:01.0: BAR 0: assigned [io 0x1000-0x101f]
     [    0.866470] EINJ: ACPI disabled.
     [    0.868836] virtio-pci 0000:00:01.0: enabling device (0000 -> 0003)
     [    0.874100] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
     [    0.875395] SuperH (H)SCI(F) driver initialized
     [    0.876757] msm_serial: driver initialized
     [    0.877328] cacheinfo: Unable to detect cache hierarchy for CPU 0
     [    0.880330] loop: module loaded
     [    0.881885] libphy: Fixed MDIO Bus: probed
     [    0.882499] tun: Universal TUN/TAP device driver, 1.6
     [    0.884820] thunder_xcv, ver 1.0
     [    0.885126] thunder_bgx, ver 1.0
     [    0.885415] nicpf, ver 1.0
     [    0.885764] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
     [    0.886246] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
     [    0.886927] igb: Intel(R) Gigabit Ethernet Network Driver - 
version 5.4.0-k
     [    0.887687] igb: Copyright (c) 2007-2014 Intel Corporation.
     [    0.888159] igbvf: Intel(R) Gigabit Virtual Function Network 
Driver - version 2.4.0-k
     [    0.888782] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
     [    0.889388] sky2: driver version 1.30
     [    0.889931] VFIO - User Level meta-driver version: 0.3
     [    0.890861] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) 
Driver
     [    0.891644] ehci-pci: EHCI PCI platform driver
     [    0.892043] ehci-platform: EHCI generic platform driver
     [    0.892515] ehci-orion: EHCI orion driver
     [    0.892880] ehci-exynos: EHCI EXYNOS driver
     [    0.893414] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
     [    0.893914] ohci-pci: OHCI PCI platform driver
     [    0.894308] ohci-platform: OHCI generic platform driver
     [    0.894765] ohci-exynos: OHCI EXYNOS driver
     [    0.895357] usbcore: registered new interface driver usb-storage
     [    0.896739] rtc-pl031 9010000.pl031: rtc core: registered pl031 
as rtc0
     [    0.897504] i2c /dev entries driver
     [    0.899576] sdhci: Secure Digital Host Controller Interface driver
     [    0.900086] sdhci: Copyright(c) Pierre Ossman
     [    0.900551] Synopsys Designware Multimedia Card Interface Driver
     [    0.901791] sdhci-pltfm: SDHCI platform and OF driver helper
     [    0.902636] ledtrig-cpu: registered to indicate activity on CPUs
     [    0.903644] usbcore: registered new interface driver usbhid
     [    0.904106] usbhid: USB HID core driver
     [    0.905520] NET: Registered protocol family 17
     [    0.905917] 9pnet: Installing 9P2000 support
     [    0.906304] Key type dns_resolver registered
     [    0.906814] registered taskstats version 1
     [    0.907542] Loading compiled-in X.509 certificates
     [    0.908155] input: gpio-keys as 
/devices/platform/gpio-keys/input/input0
     [    0.909760] rtc-pl031 9010000.pl031: setting system clock to 
2015-01-30 02:38:42 UTC (1422585522)
     [    0.918889] ALSA device list:
     [    0.921687]   No soundcards found.
     [    0.925317] uart-pl011 9000000.pl011: no DMA platform data
     [    0.930981] Freeing unused kernel memory: 1216K
     Starting rcS...
     ++ Mounting filesystem
     ifdown: interface lo not configured
     ifdown: interface eth0 not configured
     ++ Starting ssh daemon
     [    0.950291] random: sshd: uninitialized urandom read (32 bytes read)
     ip: RTNETLINK answers: File exists
     rcS Complete
     Welcome to Mini Linux
     GNU/Linux 4.17.0-45865-ga3d6816 aarch64
     Version: 1.1.6
             .--.
            |o_o |
            |:_/ |
           //   \ \
          (|     | )
         /'\_   _/`\
         \___)=(___/
     udhcpc: started, v1.29.0.git
     Setting IP address 0.0.0.0 on eth0
     Documentation: http://open-estuary.org
     E-mail: Chinafengliang@163.com
     estuary:/$ udhcpc: sending discover
     udhcpc: sending select for 10.0.2.15
     udhcpc: lease of 10.0.2.15 obtained, lease time 86400
     Setting IP address 10.0.2.15 on eth0
     Deleting routers
     route: SIOCDELRT: No such process
     Adding router 10.0.2.2
     Recreating /etc/resolv.conf
      Adding DNS server 10.0.2.3

     estuary:/$
     estuary:/$ cat /syestuary:/$ cat /sys/keestuary:/$ cat 
/sys/kernel/debestuary:/$ cat /sys/kernel/debug/keestuary:/$ cat 
/sys/kernel/debug/kernel_page_tables
     ---[ Modules start ]---
     ---[ Modules end ]---
     ---[ vmalloc() Area ]---
     0xffff000008000000-0xffff000008004000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008005000-0xffff000008009000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000800a000-0xffff00000800e000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008010000-0xffff000008020000          64K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000008021000-0xffff000008022000           4K PTE       ro NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008028000-0xffff00000802c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008030000-0xffff000008034000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008035000-0xffff000008036000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000008038000-0xffff00000803c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000803d000-0xffff00000803f000           8K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008040000-0xffff000008060000         128K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000008061000-0xffff000008065000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008066000-0xffff000008067000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000008068000-0xffff00000806c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008070000-0xffff000008074000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008078000-0xffff00000807c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008080000-0xffff000008200000        1536K PTE       ro x  
SHD AF    CON     UXN MEM/NORMAL
     0xffff000008200000-0xffff000008a00000           8M PMD       ro x  
SHD AF        BLK UXN MEM/NORMAL
     0xffff000008a00000-0xffff000008a50000         320K PTE       ro x  
SHD AF    CON     UXN MEM/NORMAL
     0xffff000008a50000-0xffff000008c00000        1728K PTE       ro NX 
SHD AF            UXN MEM/NORMAL
     0xffff000008c00000-0xffff000008e00000           2M PMD       ro NX 
SHD AF        BLK UXN MEM/NORMAL
     0xffff000008e00000-0xffff000008f10000        1088K PTE       ro NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009040000-0xffff0000091f0000        1728K PTE       RW NX 
SHD AF    CON     UXN MEM/NORMAL
     0xffff0000091f0000-0xffff0000091fa000          40K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000091fb000-0xffff0000092fb000           1M PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000092fc000-0xffff00000937c000         512K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009380000-0xffff000009384000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009388000-0xffff00000938c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009390000-0xffff000009394000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009398000-0xffff00000939c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093a0000-0xffff0000093a4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093a8000-0xffff0000093ac000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093b0000-0xffff0000093b4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093b8000-0xffff0000093bc000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093c0000-0xffff0000093c4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093c8000-0xffff0000093cc000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093d0000-0xffff0000093d4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff0000093d5000-0xffff0000093dd000          32K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009408000-0xffff00000940c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009410000-0xffff000009414000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000946d000-0xffff00000946e000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000009475000-0xffff000009476000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff00000947d000-0xffff00000947e000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000009485000-0xffff000009486000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff00000948d000-0xffff00000948e000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000009495000-0xffff000009496000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff000009595000-0xffff0000095d5000         256K PTE       RW NX 
SHD AF            UXN MEM/NORMAL-NC
     0xffff000009740000-0xffff000009744000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009c60000-0xffff000009c64000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff000009c70000-0xffff000009c74000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000a000000-0xffff00000af60000       15744K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff00000af61000-0xffff00000af65000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b020000-0xffff00000b024000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b028000-0xffff00000b02c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b030000-0xffff00000b034000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b038000-0xffff00000b03c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b048000-0xffff00000b04c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b0f8000-0xffff00000b0fc000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b170000-0xffff00000b174000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b208000-0xffff00000b20c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b230000-0xffff00000b234000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b238000-0xffff00000b23c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b48d000-0xffff00000b49d000          64K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b49e000-0xffff00000b4be000         128K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b4c0000-0xffff00000b4c4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b538000-0xffff00000b53c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000b7e8000-0xffff00000b7ec000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000c000000-0xffff00000d000000          16M PMD       RW NX 
SHD AF        BLK UXN DEVICE/nGnRnE
     0xffff00000d001000-0xffff00000d004000          12K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d260000-0xffff00000d264000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d760000-0xffff00000d764000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d770000-0xffff00000d774000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d778000-0xffff00000d77c000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d7b0000-0xffff00000d7b4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d7d8000-0xffff00000d7dc000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff00000d7e0000-0xffff00000d7e4000          16K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     0xffff7dffbffd8000-0xffff7dffbffdb000          12K PTE       RW NX 
SHD AF            UXN MEM/NORMAL
     ---[ vmalloc() End ]---
     ---[ Fixmap start ]---
     0xffff7dfffe7fa000-0xffff7dfffe7fb000           4K PTE       ro x  
SHD AF            UXN MEM/NORMAL
     0xffff7dfffe7ff000-0xffff7dfffe800000           4K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     0xffff7dfffe800000-0xffff7dfffea00000           2M PMD       ro NX 
SHD AF        BLK UXN MEM/NORMAL
     ---[ Fixmap end ]---
     ---[ PCI I/O start ]---
     0xffff7dfffee00000-0xffff7dfffee10000          64K PTE       RW NX 
SHD AF            UXN DEVICE/nGnRE
     ---[ PCI I/O end ]---
     ---[ vmemmap start ]---
     0xffff7e0000000000-0xffff7e0001000000          16M PMD       RW NX 
SHD AF        BLK UXN MEM/NORMAL
     ---[ vmemmap end ]---
     ---[ Linear Mapping ]---
     0xffff800000000000-0xffff800000080000         512K PTE       RW NX 
SHD AF    CON     UXN MEM/NORMAL
     0xffff800000080000-0xffff800000200000        1536K PTE       ro NX 
SHD AF            UXN MEM/NORMAL
     0xffff800000200000-0xffff800000e00000          12M PMD       ro NX 
SHD AF        BLK UXN MEM/NORMAL
     0xffff800000e00000-0xffff800000f10000        1088K PTE       ro NX 
SHD AF            UXN MEM/NORMAL
     0xffff800000f10000-0xffff800001000000         960K PTE       RW NX 
SHD AF    CON     UXN MEM/NORMAL
     0xffff800001000000-0xffff800002000000          16M PMD       RW NX 
SHD AF        BLK UXN MEM/NORMAL
     0xffff800002000000-0xffff800040000000         992M PMD       RW NX 
SHD AF    CON BLK UXN MEM/NORMAL
     estuary:/$

Thanks!

Best Regards,
Wei

> Will
>
> .
>


