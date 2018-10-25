Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1502FC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDA82082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDA82082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeJYTea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:34:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49551 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbeJYTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:34:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6ABD3E850E390;
        Thu, 25 Oct 2018 19:02:07 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Thu, 25 Oct 2018
 19:02:01 +0800
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Will Deacon" <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <suravee.suthikulpanit@amd.com>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
CC:     Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <cb61dd12-5319-b1fc-fafe-e258ce9e571d@huawei.com>
Date:   Thu, 25 Oct 2018 12:01:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2018 11:30, John Garry wrote:
> Hi all,
>
> I have stumbled upon this crash on my arm64 system:
>

JFYI, I bisected this issue to the following patch:

commit 58d5af59d55b4e9f3015207afa6a6648e9b005b1
Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Date:   Thu Sep 7 02:20:05 2017 -0500

     sched/topology: Introduce NUMA identity node sched domain

     On AMD Family17h-based (EPYC) system, a logical NUMA node can contain
     upto 8 cores (16 threads) with the following topology.

which either exposes or causes this issue.

John

> [    7.040874] SMP: Total of 64 processors activated.
> [    7.045720] CPU features: detected: GIC system register CPU interface
> [    7.052240] CPU features: detected: 32-bit EL0 Support
> [    7.144026] CPU: All CPU(s) started at EL2
> [    7.148298] alternatives: patching kernel code
> [    7.155277] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [    7.164163] Mem abort info:
> [    7.166978]   ESR = 0x96000004
> [    7.170061]   Exception class = DABT (current EL), IL = 32 bits
> [    7.176043]   SET = 0, FnV = 0
> [    7.179121]   EA = 0, S1PTW = 0
> [    7.182291] Data abort info:
> [    7.185193]   ISV = 0, ISS = 0x00000004
> [    7.189066]   CM = 0, WnR = 0
> [    7.192056] [0000000000000000] user address but active_mm is swapper
> [    7.198480] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    7.204107] Modules linked in:
> [    7.207189] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> 4.19.0-00002-g3ed52fd-dirty #807
> [    7.216596] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
> [    7.223102] pstate: 20000005 (nzCv daif -PAN -UAO)
> [    7.227946] pc : __ll_sc_atomic_sub_return+0x4/0x20
> [    7.232873] lr : free_sched_groups.part.1+0x40/0x98
> [    7.237797] sp : ffff00000947bc60
> [    7.241138] x29: ffff00000947bc60 x28: ffff801fb49ba000
> [    7.246504] x27: ffff000009109b38 x26: ffff801fb4a38000
> [    7.251869] x25: ffff801fb48cc000 x24: ffff000009109000
> [    7.257235] x23: 0000000000000010 x22: 0000000000000001
> [    7.262599] x21: ffff801fb4a0b000 x20: ffff801fb4a65f00
> [    7.267964] x19: ffff801fb4a65f80 x18: 0000000000000400
> [    7.273329] x17: 00000000ffffffff x16: 0000000000000000
> [    7.278694] x15: ffff801ffbffef80 x14: ffff7e007ed14bc0
> [    7.284059] x13: 00000000000000c0 x12: 000000000000003f
> [    7.289423] x11: ffff801fb62258b8 x10: 0000000000000001
> [    7.294788] x9 : ffff801fb44b0100 x8 : 000000000000000f
> [    7.300153] x7 : ffff801fb48b1900 x6 : 0000801ff2efb000
> [    7.305518] x5 : ffff0000091096f0 x4 : 0000000000000400
> [    7.310882] x3 : ffff801fb4a65000 x2 : ffff801fb4a0b000
> [    7.316247] x1 : 0000000000000000 x0 : 0000000000000001
> [    7.321613] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    7.328382] Call trace:
> [    7.330847]  __ll_sc_atomic_sub_return+0x4/0x20
> [    7.335420]  destroy_sched_domain+0x20/0x70
> [    7.339642]  cpu_attach_domain+0xc8/0x2e8
> [    7.343687]  build_sched_domains+0xd44/0xde0
> [    7.347996]  sched_init_domains+0x68/0x88
> [    7.352044]  sched_init_smp+0x2c/0x7c
> [    7.355738]  kernel_init_freeable+0xdc/0x244
> [    7.360049]  kernel_init+0x10/0x108
> [    7.363567]  ret_from_fork+0x10/0x18
> [    7.367174] Code: 88107c31 35ffffb0 d65f03c0 f9800031 (885f7c31)
> [    7.373400] ---[ end trace 8150af869a14363f ]---
> [    7.378076] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    7.378076]
> [    7.387320] SMP: stopping secondary CPUs
> [    7.391297] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b
> [    7.391297]  ]---
>
> I will straightaway note that I have been fiddling with my board's
> device tree, specifically (breaking!) the NUMA distance map, like this:
>
> distance-matrix = <0 0 10>,
>                    <0 1 15>,
>                    <0 2 20>,
>                    <0 3 25>,
>                    <1 0 15>,
>                    <1 1 10>,
>                    <1 2 25>,
>                    <1 3 30>,
>                    <2 0 20>,
>                    <2 1 25>,
>                    <2 2 10>,
>                    <2 3 15>,
>                    <3 0 10>,* should be same as 0->3 and > 10
>                    <3 1 10>,* should be same as 1->3 and > 10
>                    <3 2 15>,
>                    <3 3 15>;* should be 10
>
> However I don't think that this should crash the kernel. I'd say
> of_numa_parse_distance_map_v1() should robustly handle broken maps,
> probably by erroring and causing NUMA to be disabled.
>
> However I am interested to know if the scheduler crash is a real problem.
>
> The kernel is 4.19. Full log is below.
>
> Thanks,
> John
>
> Full log:
>
> EFI stub: Booting Linux Kernel...
> SmiGraphicsOutputQueryMode +
> SmiGraphicsOutputQueryMode -
> SmiGraphicsOutputQueryMode +
> SmiGraphicsOutputQueryMode -
> EFI stub: Using DTB from configuration table
> EFI stub: Exiting boot services and installing virtual address map...
> [SAL_ClearAffiliationSMP,325]it is going to hard reset
> dev:0x500E004AAAAAAA1F
> SAS ExitBootServicesEvent
> GMAC ExitBootServicesEvent
> GMAC ExitBootServicesEvent
> GMAC ExitBootServicesEvent
> GMAC ExitBootServicesEvent
> OHCI ExitBootServicesEvent
> IPMI ExitBootService Event
> TransferSmbiosToBMC EVENT.
> Transfer Smbios Table To iBMC Success.
> GetVariable Status : Not Found.
> [    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
> [    0.000000] Linux version 4.19.0-00002-g3ed52fd-dirty
> (johnpgarry@johnpgarry-ThinkCentre-M93p) (gcc version 7.3.1 20180425
> [linaro-7.3-2018.05-rc1 revision
> 38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1))
> #807 SMP PREEMPT Tue Oct 23 11:02:19 BST 2018
> [    0.000000] Machine model: Hisilicon Hip07 D05 Development Board
> [    0.000000] earlycon: pl11 at MMIO 0x00000000602b0000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi:  SMBIOS=0x3f050000  SMBIOS 3.0=0x39b00000
> ACPI=0x39bd0000  ACPI 2.0=0x39bd0014  MEMATTR=0x3cc99018
> [    0.000000] crashkernel reserved: 0x0000000002000000 -
> 0x0000000012000000 (256 MB)
> [    0.000000] cma: Reserved 32 MiB at 0x000000003d000000
> [    0.000000] earlycon: pl11 at MMIO32 0x00000000602b0000 (options
> '115200n8')
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] console 'pl11' already registered
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:2586
> register_console+0x58/0x3c8
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 4.19.0-00002-g3ed52fd-dirty #807
> [    0.000000] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : register_console+0x58/0x3c8
> [    0.000000] lr : register_console+0x58/0x3c8
> [    0.000000] sp : ffff000009103de0
> [    0.000000] x29: ffff000009103de0 x28: 0000000000fb0018
> [    0.000000] x27: 000000003cc81018 x26: ffff0000090d1098
> [    0.000000] x25: 0000000000004b10 x24: ffff0000090e4348
> [    0.000000] x23: ffff0000090d1098 x22: ffff000009262000
> [    0.000000] x21: ffff0000091fe150 x20: 0000000000004b10
> [    0.000000] x19: ffff0000091fe150 x18: ffffffffffffffff
> [    0.000000] x17: 0000000000000000 x16: 0000000000000000
> [    0.000000] x15: ffff0000091096c8 x14: ffff0000892626bf
> [    0.000000] x13: ffff0000092626cd x12: ffff000009109940
> [    0.000000] x11: ffff0000085ecd98 x10: ffff000009103ab0
> [    0.000000] x9 : 000000000000000d x8 : 7369676572207964
> [    0.000000] x7 : 6165726c61202731 x6 : 000000000000000d
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
> [    0.000000] x3 : ffffffffffffffff x2 : ffff0000091210f8
> [    0.000000] x1 : 0000000000000000 x0 : 0000000000000000
> [    0.000000] Call trace:
> [    0.000000]  register_console+0x58/0x3c8
> [    0.000000]  of_setup_earlycon+0x20c/0x22c
> [    0.000000]  early_init_dt_scan_chosen_stdout+0x158/0x19c
> [    0.000000]  acpi_boot_table_init+0x150/0x184
> [    0.000000]  setup_arch+0x1cc/0x530
> [    0.000000]  start_kernel+0x80/0x418
> [    0.000000] random: get_random_bytes called from
> print_oops_end_marker+0x48/0x68 with crng_init=0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] NUMA: NODE_DATA [mem 0x1ffbffe840-0x1ffbffffff]
> [    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
> [    0.000000] NUMA: NODE_DATA [mem 0x41ffbf41fc0-0x41ffbf4377f]
> [    0.000000] NUMA: NODE_DATA(1) on node 2
> [    0.000000] NUMA: NODE_DATA [mem 0x41ffbf40800-0x41ffbf41fbf]
> [    0.000000] NUMA: Initmem setup node 3 [<memory-less node>]
> [    0.000000] NUMA: NODE_DATA [mem 0x41ffbf3f040-0x41ffbf407ff]
> [    0.000000] NUMA: NODE_DATA(3) on node 2
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000041ffbffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000031902fff]
> [    0.000000]   node   0: [mem 0x0000000031903000-0x0000000031906fff]
> [    0.000000]   node   0: [mem 0x0000000031907000-0x000000003999ffff]
> [    0.000000]   node   0: [mem 0x00000000399a0000-0x0000000039a3ffff]
> [    0.000000]   node   0: [mem 0x0000000039a40000-0x0000000039a8ffff]
> [    0.000000]   node   0: [mem 0x0000000039a90000-0x0000000039a9ffff]
> [    0.000000]   node   0: [mem 0x0000000039aa0000-0x0000000039aeffff]
> [    0.000000]   node   0: [mem 0x0000000039af0000-0x0000000039bbffff]
> [    0.000000]   node   0: [mem 0x0000000039bc0000-0x0000000039bdffff]
> [    0.000000]   node   0: [mem 0x0000000039be0000-0x000000003a05ffff]
> [    0.000000]   node   0: [mem 0x000000003a060000-0x000000003f04ffff]
> [    0.000000]   node   0: [mem 0x000000003f050000-0x000000003f07ffff]
> [    0.000000]   node   0: [mem 0x000000003f080000-0x000000003fbfffff]
> [    0.000000]   node   0: [mem 0x0000001040000000-0x0000001ffbffffff]
> [    0.000000]   node   2: [mem 0x0000041000000000-0x0000041ffbffffff]
> [    0.000000] Initmem setup node 0 [mem
> 0x0000000000000000-0x0000001ffbffffff]
> [    0.000000] Could not find start_pfn for node 1
> [    0.000000] Initmem setup node 1 [mem
> 0x0000000000000000-0x0000000000000000]
> [    0.000000] Initmem setup node 2 [mem
> 0x0000041000000000-0x0000041ffbffffff]
> [    0.000000] Could not find start_pfn for node 3
> [    0.000000] Initmem setup node 3 [mem
> 0x0000000000000000-0x0000000000000000]
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s56408
> r8192 d29608 u94208
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: enabling workaround for EL2 vector hardening
> [    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
> [    0.000000] Built 4 zonelists, mobility grouping on.  Total pages:
> 32996880
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init
> crashkernel=256M@32M console=ttyAMA0,115200
> earlycon=pl011,mmio,0x602b0000 acpi=off pcie_aspm=off earlycon
> [    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
> [    0.000000] log_buf_len total cpu_extra contributions: 258048 bytes
> [    0.000000] log_buf_len min size: 131072 bytes
> [    0.000000] log_buf_len: 524288 bytes
> [    0.000000] early log buf free: 123488(94%)
> [    0.000000] software IO TLB: mapped [mem 0x359a0000-0x399a0000] (64MB)
> [    0.000000] Memory: 131332260K/134082560K available (10620K kernel
> code, 1370K rwdata, 4888K rodata, 1344K init, 380K bss, 2717532K
> reserved, 32768K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=4
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000]     Tasks RCU enabled.
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: Distributor has no Range Selector support
> [    0.000000] GICv3: VLPI support, direct LPI support
> [    0.000000] ITS [mem 0x4c000000-0x4c03ffff]
> [    0.000000] ITS@0x000000004c000000: Using ITS number 0
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000000004c000000: allocated 524288 Devices
> @1fbb000000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000000004c000000: allocated 65536 Virtual CPUs
> @1fbb980000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000000004c000000: allocated 512 Interrupt
> Collections @1fbb929000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x6c000000-0x6c03ffff]
> [    0.000000] ITS@0x000000006c000000: Using ITS number 1
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000000006c000000: allocated 524288 Devices
> @1fbac00000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000000006c000000: allocated 65536 Virtual CPUs
> @1fbba00000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000000006c000000: allocated 512 Interrupt
> Collections @1fbb92a000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0xc6000000-0xc603ffff]
> [    0.000000] ITS@0x00000000c6000000: Using ITS number 2
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices
> @1fba800000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000000c6000000: allocated 65536 Virtual CPUs
> @1fbba80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt
> Collections @1fbb92c000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x8c6000000-0x8c603ffff]
> [    0.000000] ITS@0x00000008c6000000: Using ITS number 3
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000008c6000000: allocated 524288 Devices
> @1fba400000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000008c6000000: allocated 65536 Virtual CPUs
> @1fbbb00000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000008c6000000: allocated 512 Interrupt
> Collections @1fbb92e000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x4004c000000-0x4004c03ffff]
> [    0.000000] ITS@0x000004004c000000: Using ITS number 4
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000004004c000000: allocated 524288 Devices
> @1fba000000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000004004c000000: allocated 65536 Virtual CPUs
> @1fbbb80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000004004c000000: allocated 512 Interrupt
> Collections @1fbb92f000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x4006c000000-0x4006c03ffff]
> [    0.000000] ITS@0x000004006c000000: Using ITS number 5
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x000004006c000000: allocated 524288 Devices
> @1fb9800000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x000004006c000000: allocated 65536 Virtual CPUs
> @1fb9c80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x000004006c000000: allocated 512 Interrupt
> Collections @1fb9c10000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x400c6000000-0x400c603ffff]
> [    0.000000] ITS@0x00000400c6000000: Using ITS number 6
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000400c6000000: allocated 524288 Devices
> @1fb9400000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000400c6000000: allocated 65536 Virtual CPUs
> @1fb9d00000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000400c6000000: allocated 512 Interrupt
> Collections @1fb9c11000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS [mem 0x408c6000000-0x408c603ffff]
> [    0.000000] ITS@0x00000408c6000000: Using ITS number 7
> [    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
> [    0.000000] ITS@0x00000408c6000000: allocated 524288 Devices
> @1fb9000000 (flat, esz 8, psz 16K, shr 1)
> [    0.000000] ITS@0x00000408c6000000: allocated 65536 Virtual CPUs
> @1fb9d80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt
> Collections @1fb9c13000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] GIC: using LPI property table @0x0000001fb9c40000
> [    0.000000] ITS: Using DirectLPI for VPE invalidation
> [    0.000000] ITS: Enabling GICv4 support
> [    0.000000] GICv3: CPU0: found redistributor 10000 region
> 0:0x000000004d100000
> [    0.000000] CPU0: using LPI pending table @0x0000001fb9c50000
> [    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
> [    0.000002] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
> every 4398046511100ns
> [    0.008248] Console: colour dummy device 80x25
> [    0.012791] mempolicy: Enabling automatic NUMA balancing. Configure
> with numa_balancing= or the kernel.numa_balancing sysctl
> [    0.024159] Calibrating delay loop (skipped), value calculated using
> timer frequency.. 100.00 BogoMIPS (lpj=200000)
> [    0.034713] pid_max: default: 65536 minimum: 512
> [    0.039438] Security Framework initialized
> [    0.065597] Dentry cache hash table entries: 8388608 (order: 14,
> 67108864 bytes)
> [    0.084013] Inode-cache hash table entries: 4194304 (order: 13,
> 33554432 bytes)
> [    0.091758] Mount-cache hash table entries: 131072 (order: 8, 1048576
> bytes)
> [    0.099226] Mountpoint-cache hash table entries: 131072 (order: 8,
> 1048576 bytes)
> [    0.150842] ASID allocator initialised with 32768 entries
> [    0.164305] rcu: Hierarchical SRCU implementation.
> [    0.177184] Platform MSI: interrupt-controller@4c000000 domain created
> [    0.183784] Platform MSI: interrupt-controller@6c000000 domain created
> [    0.190384] Platform MSI: interrupt-controller@c6000000 domain created
> [    0.196983] Platform MSI: interrupt-controller@8,c6000000 domain created
> [    0.203758] Platform MSI: interrupt-controller@400,4c000000 domain
> created
> [    0.210708] Platform MSI: interrupt-controller@400,6c000000 domain
> created
> [    0.217659] Platform MSI: interrupt-controller@400,c6000000 domain
> created
> [    0.224610] Platform MSI: interrupt-controller@408,c6000000 domain
> created
> [    0.231606] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
> [    0.240491] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
> [    0.249375] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
> [    0.258260] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain
> created
> [    0.267320] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain
> created
> [    0.276556] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain
> created
> [    0.285792] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain
> created
> [    0.295029] PCI/MSI:
> /interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain
> created
> [    0.304714] Remapping and enabling EFI services.
> [    0.317387] smp: Bringing up secondary CPUs ...
> [    0.404570] Detected PIPT I-cache on CPU1
> [    0.404582] GICv3: CPU1: found redistributor 10001 region
> 0:0x000000004d140000
> [    0.404611] CPU1: using LPI pending table @0x0000001fb5dc0000
> [    0.404728] CPU1: Booted secondary processor 0x0000010001 [0x410fd082]
> [    0.487192] Detected PIPT I-cache on CPU2
> [    0.487198] GICv3: CPU2: found redistributor 10002 region
> 0:0x000000004d180000
> [    0.487224] CPU2: using LPI pending table @0x0000001fb5e10000
> [    0.487329] CPU2: Booted secondary processor 0x0000010002 [0x410fd082]
> [    0.569818] Detected PIPT I-cache on CPU3
> [    0.569824] GICv3: CPU3: found redistributor 10003 region
> 0:0x000000004d1c0000
> [    0.569851] CPU3: using LPI pending table @0x0000001fb5e30000
> [    0.569953] CPU3: Booted secondary processor 0x0000010003 [0x410fd082]
> [    0.652445] Detected PIPT I-cache on CPU4
> [    0.652453] GICv3: CPU4: found redistributor 10100 region
> 0:0x000000004d200000
> [    0.652480] CPU4: using LPI pending table @0x0000001fb5e40000
> [    0.652584] CPU4: Booted secondary processor 0x0000010100 [0x410fd082]
> [    0.735070] Detected PIPT I-cache on CPU5
> [    0.735077] GICv3: CPU5: found redistributor 10101 region
> 0:0x000000004d240000
> [    0.735103] CPU5: using LPI pending table @0x0000001fb5e90000
> [    0.735206] CPU5: Booted secondary processor 0x0000010101 [0x410fd082]
> [    0.817697] Detected PIPT I-cache on CPU6
> [    0.817704] GICv3: CPU6: found redistributor 10102 region
> 0:0x000000004d280000
> [    0.817731] CPU6: using LPI pending table @0x0000001fb5ea0000
> [    0.817834] CPU6: Booted secondary processor 0x0000010102 [0x410fd082]
> [    0.900324] Detected PIPT I-cache on CPU7
> [    0.900331] GICv3: CPU7: found redistributor 10103 region
> 0:0x000000004d2c0000
> [    0.900358] CPU7: using LPI pending table @0x0000001fb5eb0000
> [    0.900461] CPU7: Booted secondary processor 0x0000010103 [0x410fd082]
> [    0.982952] Detected PIPT I-cache on CPU8
> [    0.982961] GICv3: CPU8: found redistributor 10200 region
> 0:0x000000004d300000
> [    0.982988] CPU8: using LPI pending table @0x0000001fb5f00000
> [    0.983092] CPU8: Booted secondary processor 0x0000010200 [0x410fd082]
> [    1.065578] Detected PIPT I-cache on CPU9
> [    1.065585] GICv3: CPU9: found redistributor 10201 region
> 0:0x000000004d340000
> [    1.065611] CPU9: using LPI pending table @0x0000001fb5f20000
> [    1.065714] CPU9: Booted secondary processor 0x0000010201 [0x410fd082]
> [    1.148205] Detected PIPT I-cache on CPU10
> [    1.148213] GICv3: CPU10: found redistributor 10202 region
> 0:0x000000004d380000
> [    1.148240] CPU10: using LPI pending table @0x0000001fb5f30000
> [    1.148343] CPU10: Booted secondary processor 0x0000010202 [0x410fd082]
> [    1.230833] Detected PIPT I-cache on CPU11
> [    1.230841] GICv3: CPU11: found redistributor 10203 region
> 0:0x000000004d3c0000
> [    1.230868] CPU11: using LPI pending table @0x0000001fb5f80000
> [    1.230971] CPU11: Booted secondary processor 0x0000010203 [0x410fd082]
> [    1.313460] Detected PIPT I-cache on CPU12
> [    1.313469] GICv3: CPU12: found redistributor 10300 region
> 0:0x000000004d400000
> [    1.313496] CPU12: using LPI pending table @0x0000001fb5fa0000
> [    1.313602] CPU12: Booted secondary processor 0x0000010300 [0x410fd082]
> [    1.396086] Detected PIPT I-cache on CPU13
> [    1.396094] GICv3: CPU13: found redistributor 10301 region
> 0:0x000000004d440000
> [    1.396121] CPU13: using LPI pending table @0x0000001fb5fb0000
> [    1.396226] CPU13: Booted secondary processor 0x0000010301 [0x410fd082]
> [    1.478713] Detected PIPT I-cache on CPU14
> [    1.478722] GICv3: CPU14: found redistributor 10302 region
> 0:0x000000004d480000
> [    1.478748] CPU14: using LPI pending table @0x0000001fb5fc0000
> [    1.478852] CPU14: Booted secondary processor 0x0000010302 [0x410fd082]
> [    1.561340] Detected PIPT I-cache on CPU15
> [    1.561348] GICv3: CPU15: found redistributor 10303 region
> 0:0x000000004d4c0000
> [    1.561374] CPU15: using LPI pending table @0x0000001fb5820000
> [    1.561477] CPU15: Booted secondary processor 0x0000010303 [0x410fd082]
> [    1.643629] Detected PIPT I-cache on CPU16
> [    1.643641] GICv3: CPU16: found redistributor 30000 region
> 1:0x000000006d100000
> [    1.643680] CPU16: using LPI pending table @0x0000001fb5860000
> [    1.643828] CPU16: Booted secondary processor 0x0000030000 [0x410fd082]
> [    1.726259] Detected PIPT I-cache on CPU17
> [    1.726268] GICv3: CPU17: found redistributor 30001 region
> 1:0x000000006d140000
> [    1.726305] CPU17: using LPI pending table @0x0000001fb58f0000
> [    1.726449] CPU17: Booted secondary processor 0x0000030001 [0x410fd082]
> [    1.808890] Detected PIPT I-cache on CPU18
> [    1.808900] GICv3: CPU18: found redistributor 30002 region
> 1:0x000000006d180000
> [    1.808936] CPU18: using LPI pending table @0x0000001fb5970000
> [    1.809080] CPU18: Booted secondary processor 0x0000030002 [0x410fd082]
> [    1.891523] Detected PIPT I-cache on CPU19
> [    1.891533] GICv3: CPU19: found redistributor 30003 region
> 1:0x000000006d1c0000
> [    1.891570] CPU19: using LPI pending table @0x0000001fb59b0000
> [    1.891713] CPU19: Booted secondary processor 0x0000030003 [0x410fd082]
> [    1.974158] Detected PIPT I-cache on CPU20
> [    1.974171] GICv3: CPU20: found redistributor 30100 region
> 1:0x000000006d200000
> [    1.974209] CPU20: using LPI pending table @0x0000001fb5a20000
> [    1.974356] CPU20: Booted secondary processor 0x0000030100 [0x410fd082]
> [    2.056788] Detected PIPT I-cache on CPU21
> [    2.056797] GICv3: CPU21: found redistributor 30101 region
> 1:0x000000006d240000
> [    2.056834] CPU21: using LPI pending table @0x0000001fb5ab0000
> [    2.056979] CPU21: Booted secondary processor 0x0000030101 [0x410fd082]
> [    2.139420] Detected PIPT I-cache on CPU22
> [    2.139430] GICv3: CPU22: found redistributor 30102 region
> 1:0x000000006d280000
> [    2.139466] CPU22: using LPI pending table @0x0000001fb5af0000
> [    2.139610] CPU22: Booted secondary processor 0x0000030102 [0x410fd082]
> [    2.222053] Detected PIPT I-cache on CPU23
> [    2.222063] GICv3: CPU23: found redistributor 30103 region
> 1:0x000000006d2c0000
> [    2.222100] CPU23: using LPI pending table @0x0000001fb5b70000
> [    2.222244] CPU23: Booted secondary processor 0x0000030103 [0x410fd082]
> [    2.304688] Detected PIPT I-cache on CPU24
> [    2.304701] GICv3: CPU24: found redistributor 30200 region
> 1:0x000000006d300000
> [    2.304739] CPU24: using LPI pending table @0x0000001fb5bb0000
> [    2.304888] CPU24: Booted secondary processor 0x0000030200 [0x410fd082]
> [    2.387319] Detected PIPT I-cache on CPU25
> [    2.387329] GICv3: CPU25: found redistributor 30201 region
> 1:0x000000006d340000
> [    2.387365] CPU25: using LPI pending table @0x0000001fb5430000
> [    2.387510] CPU25: Booted secondary processor 0x0000030201 [0x410fd082]
> [    2.469951] Detected PIPT I-cache on CPU26
> [    2.469961] GICv3: CPU26: found redistributor 30202 region
> 1:0x000000006d380000
> [    2.469998] CPU26: using LPI pending table @0x0000001fb54a0000
> [    2.470143] CPU26: Booted secondary processor 0x0000030202 [0x410fd082]
> [    2.552585] Detected PIPT I-cache on CPU27
> [    2.552595] GICv3: CPU27: found redistributor 30203 region
> 1:0x000000006d3c0000
> [    2.552632] CPU27: using LPI pending table @0x0000001fb54f0000
> [    2.552777] CPU27: Booted secondary processor 0x0000030203 [0x410fd082]
> [    2.635220] Detected PIPT I-cache on CPU28
> [    2.635234] GICv3: CPU28: found redistributor 30300 region
> 1:0x000000006d400000
> [    2.635271] CPU28: using LPI pending table @0x0000001fb5570000
> [    2.635419] CPU28: Booted secondary processor 0x0000030300 [0x410fd082]
> [    2.717851] Detected PIPT I-cache on CPU29
> [    2.717861] GICv3: CPU29: found redistributor 30301 region
> 1:0x000000006d440000
> [    2.717898] CPU29: using LPI pending table @0x0000001fb55b0000
> [    2.718043] CPU29: Booted secondary processor 0x0000030301 [0x410fd082]
> [    2.800486] Detected PIPT I-cache on CPU30
> [    2.800496] GICv3: CPU30: found redistributor 30302 region
> 1:0x000000006d480000
> [    2.800533] CPU30: using LPI pending table @0x0000001fb5790000
> [    2.800679] CPU30: Booted secondary processor 0x0000030302 [0x410fd082]
> [    2.883122] Detected PIPT I-cache on CPU31
> [    2.883133] GICv3: CPU31: found redistributor 30303 region
> 1:0x000000006d4c0000
> [    2.883169] CPU31: using LPI pending table @0x0000001fb57d0000
> [    2.883313] CPU31: Booted secondary processor 0x0000030303 [0x410fd082]
> [    2.965438] Detected PIPT I-cache on CPU32
> [    2.965479] GICv3: CPU32: found redistributor 50000 region
> 2:0x000004004d100000
> [    2.965541] CPU32: using LPI pending table @0x0000001fb57e0000
> [    2.965698] CPU32: Booted secondary processor 0x0000050000 [0x410fd082]
> [    3.048065] Detected PIPT I-cache on CPU33
> [    3.048089] GICv3: CPU33: found redistributor 50001 region
> 2:0x000004004d140000
> [    3.048145] CPU33: using LPI pending table @0x0000001fb5000000
> [    3.048252] CPU33: Booted secondary processor 0x0000050001 [0x410fd082]
> [    3.130711] Detected PIPT I-cache on CPU34
> [    3.130735] GICv3: CPU34: found redistributor 50002 region
> 2:0x000004004d180000
> [    3.130792] CPU34: using LPI pending table @0x0000001fb5010000
> [    3.130898] CPU34: Booted secondary processor 0x0000050002 [0x410fd082]
> [    3.213358] Detected PIPT I-cache on CPU35
> [    3.213383] GICv3: CPU35: found redistributor 50003 region
> 2:0x000004004d1c0000
> [    3.213439] CPU35: using LPI pending table @0x0000001fb5020000
> [    3.213545] CPU35: Booted secondary processor 0x0000050003 [0x410fd082]
> [    3.296005] Detected PIPT I-cache on CPU36
> [    3.296031] GICv3: CPU36: found redistributor 50100 region
> 2:0x000004004d200000
> [    3.296088] CPU36: using LPI pending table @0x0000001fb5030000
> [    3.296198] CPU36: Booted secondary processor 0x0000050100 [0x410fd082]
> [    3.378651] Detected PIPT I-cache on CPU37
> [    3.378676] GICv3: CPU37: found redistributor 50101 region
> 2:0x000004004d240000
> [    3.378733] CPU37: using LPI pending table @0x0000001fb5040000
> [    3.378840] CPU37: Booted secondary processor 0x0000050101 [0x410fd082]
> [    3.461298] Detected PIPT I-cache on CPU38
> [    3.461323] GICv3: CPU38: found redistributor 50102 region
> 2:0x000004004d280000
> [    3.461379] CPU38: using LPI pending table @0x0000001fb5050000
> [    3.461488] CPU38: Booted secondary processor 0x0000050102 [0x410fd082]
> [    3.543945] Detected PIPT I-cache on CPU39
> [    3.543970] GICv3: CPU39: found redistributor 50103 region
> 2:0x000004004d2c0000
> [    3.544028] CPU39: using LPI pending table @0x0000001fb5070000
> [    3.544134] CPU39: Booted secondary processor 0x0000050103 [0x410fd082]
> [    3.626593] Detected PIPT I-cache on CPU40
> [    3.626620] GICv3: CPU40: found redistributor 50200 region
> 2:0x000004004d300000
> [    3.626677] CPU40: using LPI pending table @0x0000001fb5080000
> [    3.626786] CPU40: Booted secondary processor 0x0000050200 [0x410fd082]
> [    3.709241] Detected PIPT I-cache on CPU41
> [    3.709266] GICv3: CPU41: found redistributor 50201 region
> 2:0x000004004d340000
> [    3.709323] CPU41: using LPI pending table @0x0000001fb5090000
> [    3.709428] CPU41: Booted secondary processor 0x0000050201 [0x410fd082]
> [    3.791888] Detected PIPT I-cache on CPU42
> [    3.791914] GICv3: CPU42: found redistributor 50202 region
> 2:0x000004004d380000
> [    3.791971] CPU42: using LPI pending table @0x0000001fb50b0000
> [    3.792078] CPU42: Booted secondary processor 0x0000050202 [0x410fd082]
> [    3.874536] Detected PIPT I-cache on CPU43
> [    3.874562] GICv3: CPU43: found redistributor 50203 region
> 2:0x000004004d3c0000
> [    3.874619] CPU43: using LPI pending table @0x0000001fb50c0000
> [    3.874726] CPU43: Booted secondary processor 0x0000050203 [0x410fd082]
> [    3.957185] Detected PIPT I-cache on CPU44
> [    3.957211] GICv3: CPU44: found redistributor 50300 region
> 2:0x000004004d400000
> [    3.957270] CPU44: using LPI pending table @0x0000001fb50d0000
> [    3.957378] CPU44: Booted secondary processor 0x0000050300 [0x410fd082]
> [    4.039832] Detected PIPT I-cache on CPU45
> [    4.039858] GICv3: CPU45: found redistributor 50301 region
> 2:0x000004004d440000
> [    4.039915] CPU45: using LPI pending table @0x0000001fb50f0000
> [    4.040022] CPU45: Booted secondary processor 0x0000050301 [0x410fd082]
> [    4.122477] Detected PIPT I-cache on CPU46
> [    4.122503] GICv3: CPU46: found redistributor 50302 region
> 2:0x000004004d480000
> [    4.122560] CPU46: using LPI pending table @0x0000001fb5100000
> [    4.122668] CPU46: Booted secondary processor 0x0000050302 [0x410fd082]
> [    4.205126] Detected PIPT I-cache on CPU47
> [    4.205152] GICv3: CPU47: found redistributor 50303 region
> 2:0x000004004d4c0000
> [    4.205209] CPU47: using LPI pending table @0x0000001fb5110000
> [    4.205316] CPU47: Booted secondary processor 0x0000050303 [0x410fd082]
> [    4.279425] Detected PIPT I-cache on CPU48
> [    4.279458] GICv3: CPU48: found redistributor 70000 region
> 3:0x000004006d100000
> [    4.279519] CPU48: using LPI pending table @0x0000001fb51b0000
> [    4.279669] CPU48: Booted secondary processor 0x0000070000 [0x410fd082]
> [    4.362072] Detected PIPT I-cache on CPU49
> [    4.362101] GICv3: CPU49: found redistributor 70001 region
> 3:0x000004006d140000
> [    4.362163] CPU49: using LPI pending table @0x0000001fb5250000
> [    4.362305] CPU49: Booted secondary processor 0x0000070001 [0x410fd082]
> [    4.444725] Detected PIPT I-cache on CPU50
> [    4.444753] GICv3: CPU50: found redistributor 70002 region
> 3:0x000004006d180000
> [    4.444817] CPU50: using LPI pending table @0x0000001fb5290000
> [    4.444962] CPU50: Booted secondary processor 0x0000070002 [0x410fd082]
> [    4.527375] Detected PIPT I-cache on CPU51
> [    4.527404] GICv3: CPU51: found redistributor 70003 region
> 3:0x000004006d1c0000
> [    4.527466] CPU51: using LPI pending table @0x0000001fb5310000
> [    4.527609] CPU51: Booted secondary processor 0x0000070003 [0x410fd082]
> [    4.610026] Detected PIPT I-cache on CPU52
> [    4.610058] GICv3: CPU52: found redistributor 70100 region
> 3:0x000004006d200000
> [    4.610122] CPU52: using LPI pending table @0x0000001fb5380000
> [    4.610273] CPU52: Booted secondary processor 0x0000070100 [0x410fd082]
> [    4.692677] Detected PIPT I-cache on CPU53
> [    4.692706] GICv3: CPU53: found redistributor 70101 region
> 3:0x000004006d240000
> [    4.692769] CPU53: using LPI pending table @0x0000001fb53d0000
> [    4.692912] CPU53: Booted secondary processor 0x0000070101 [0x410fd082]
> [    4.775327] Detected PIPT I-cache on CPU54
> [    4.775356] GICv3: CPU54: found redistributor 70102 region
> 3:0x000004006d280000
> [    4.775417] CPU54: using LPI pending table @0x0000001fb4c50000
> [    4.775561] CPU54: Booted secondary processor 0x0000070102 [0x410fd082]
> [    4.857978] Detected PIPT I-cache on CPU55
> [    4.858007] GICv3: CPU55: found redistributor 70103 region
> 3:0x000004006d2c0000
> [    4.858069] CPU55: using LPI pending table @0x0000001fb4cc0000
> [    4.858214] CPU55: Booted secondary processor 0x0000070103 [0x410fd082]
> [    4.940631] Detected PIPT I-cache on CPU56
> [    4.940663] GICv3: CPU56: found redistributor 70200 region
> 3:0x000004006d300000
> [    4.940726] CPU56: using LPI pending table @0x0000001fb4d10000
> [    4.940880] CPU56: Booted secondary processor 0x0000070200 [0x410fd082]
> [    5.023280] Detected PIPT I-cache on CPU57
> [    5.023309] GICv3: CPU57: found redistributor 70201 region
> 3:0x000004006d340000
> [    5.023372] CPU57: using LPI pending table @0x0000001fb4d80000
> [    5.023516] CPU57: Booted secondary processor 0x0000070201 [0x410fd082]
> [    5.105930] Detected PIPT I-cache on CPU58
> [    5.105959] GICv3: CPU58: found redistributor 70202 region
> 3:0x000004006d380000
> [    5.106021] CPU58: using LPI pending table @0x0000001fb4dc0000
> [    5.106166] CPU58: Booted secondary processor 0x0000070202 [0x410fd082]
> [    5.188582] Detected PIPT I-cache on CPU59
> [    5.188611] GICv3: CPU59: found redistributor 70203 region
> 3:0x000004006d3c0000
> [    5.188672] CPU59: using LPI pending table @0x0000001fb4e50000
> [    5.188815] CPU59: Booted secondary processor 0x0000070203 [0x410fd082]
> [    5.271235] Detected PIPT I-cache on CPU60
> [    5.271267] GICv3: CPU60: found redistributor 70300 region
> 3:0x000004006d400000
> [    5.271330] CPU60: using LPI pending table @0x0000001fb4ed0000
> [    5.271481] CPU60: Booted secondary processor 0x0000070300 [0x410fd082]
> [    5.353884] Detected PIPT I-cache on CPU61
> [    5.353913] GICv3: CPU61: found redistributor 70301 region
> 3:0x000004006d440000
> [    5.353979] CPU61: using LPI pending table @0x0000001fb4f00000
> [    5.354121] CPU61: Booted secondary processor 0x0000070301 [0x410fd082]
> [    5.436534] Detected PIPT I-cache on CPU62
> [    5.436563] GICv3: CPU62: found redistributor 70302 region
> 3:0x000004006d480000
> [    5.436626] CPU62: using LPI pending table @0x0000001fb4f90000
> [    5.436769] CPU62: Booted secondary processor 0x0000070302 [0x410fd082]
> [    5.519187] Detected PIPT I-cache on CPU63
> [    5.519217] GICv3: CPU63: found redistributor 70303 region
> 3:0x000004006d4c0000
> [    5.519280] CPU63: using LPI pending table @0x0000001fb4fc0000
> [    5.519421] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
> [    5.519506] smp: Brought up 4 nodes, 64 CPUs
> [    7.040874] SMP: Total of 64 processors activated.
> [    7.045720] CPU features: detected: GIC system register CPU interface
> [    7.052240] CPU features: detected: 32-bit EL0 Support
> [    7.144026] CPU: All CPU(s) started at EL2
> [    7.148298] alternatives: patching kernel code
> [    7.155277] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [    7.164163] Mem abort info:
> [    7.166978]   ESR = 0x96000004
> [    7.170061]   Exception class = DABT (current EL), IL = 32 bits
> [    7.176043]   SET = 0, FnV = 0
> [    7.179121]   EA = 0, S1PTW = 0
> [    7.182291] Data abort info:
> [    7.185193]   ISV = 0, ISS = 0x00000004
> [    7.189066]   CM = 0, WnR = 0
> [    7.192056] [0000000000000000] user address but active_mm is swapper
> [    7.198480] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    7.204107] Modules linked in:
> [    7.207189] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
> 4.19.0-00002-g3ed52fd-dirty #807
> [    7.216596] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
> [    7.223102] pstate: 20000005 (nzCv daif -PAN -UAO)
> [    7.227946] pc : __ll_sc_atomic_sub_return+0x4/0x20
> [    7.232873] lr : free_sched_groups.part.1+0x40/0x98
> [    7.237797] sp : ffff00000947bc60
> [    7.241138] x29: ffff00000947bc60 x28: ffff801fb49ba000
> [    7.246504] x27: ffff000009109b38 x26: ffff801fb4a38000
> [    7.251869] x25: ffff801fb48cc000 x24: ffff000009109000
> [    7.257235] x23: 0000000000000010 x22: 0000000000000001
> [    7.262599] x21: ffff801fb4a0b000 x20: ffff801fb4a65f00
> [    7.267964] x19: ffff801fb4a65f80 x18: 0000000000000400
> [    7.273329] x17: 00000000ffffffff x16: 0000000000000000
> [    7.278694] x15: ffff801ffbffef80 x14: ffff7e007ed14bc0
> [    7.284059] x13: 00000000000000c0 x12: 000000000000003f
> [    7.289423] x11: ffff801fb62258b8 x10: 0000000000000001
> [    7.294788] x9 : ffff801fb44b0100 x8 : 000000000000000f
> [    7.300153] x7 : ffff801fb48b1900 x6 : 0000801ff2efb000
> [    7.305518] x5 : ffff0000091096f0 x4 : 0000000000000400
> [    7.310882] x3 : ffff801fb4a65000 x2 : ffff801fb4a0b000
> [    7.316247] x1 : 0000000000000000 x0 : 0000000000000001
> [    7.321613] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> [    7.328382] Call trace:
> [    7.330847]  __ll_sc_atomic_sub_return+0x4/0x20
> [    7.335420]  destroy_sched_domain+0x20/0x70
> [    7.339642]  cpu_attach_domain+0xc8/0x2e8
> [    7.343687]  build_sched_domains+0xd44/0xde0
> [    7.347996]  sched_init_domains+0x68/0x88
> [    7.352044]  sched_init_smp+0x2c/0x7c
> [    7.355738]  kernel_init_freeable+0xdc/0x244
> [    7.360049]  kernel_init+0x10/0x108
> [    7.363567]  ret_from_fork+0x10/0x18
> [    7.367174] Code: 88107c31 35ffffb0 d65f03c0 f9800031 (885f7c31)
> [    7.373400] ---[ end trace 8150af869a14363f ]---
> [    7.378076] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    7.378076]
> [    7.387320] SMP: stopping secondary CPUs
> [    7.391297] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b
> [    7.391297]  ]---


