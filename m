Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A3C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DCE2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DCE2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJaAaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:30:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41915 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeJaAaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:30:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CBCEAF32A590F;
        Tue, 30 Oct 2018 23:35:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Tue, 30 Oct 2018
 23:35:42 +0800
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
To:     Peter Zijlstra <peterz@infradead.org>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
Date:   Tue, 30 Oct 2018 15:35:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 09:55, John Garry wrote:
> On 30/10/2018 09:26, Peter Zijlstra wrote:
>> On Tue, Oct 23, 2018 at 11:30:11AM +0100, John Garry wrote:
>>> Hi all,
>>>
>>> I have stumbled upon this crash on my arm64 system:
>>>
>>> [    7.040874] SMP: Total of 64 processors activated.
>>> [    7.045720] CPU features: detected: GIC system register CPU interface
>>> [    7.052240] CPU features: detected: 32-bit EL0 Support
>>> [    7.144026] CPU: All CPU(s) started at EL2
>>> [    7.148298] alternatives: patching kernel code
>>> [    7.155277] Unable to handle kernel NULL pointer dereference at
>>> virtual
>>> address 0000000000000000
>>> [    7.164163] Mem abort info:
>>> [    7.166978]   ESR = 0x96000004
>>> [    7.170061]   Exception class = DABT (current EL), IL = 32 bits
>>> [    7.176043]   SET = 0, FnV = 0
>>> [    7.179121]   EA = 0, S1PTW = 0
>>> [    7.182291] Data abort info:
>>> [    7.185193]   ISV = 0, ISS = 0x00000004
>>> [    7.189066]   CM = 0, WnR = 0
>>> [    7.192056] [0000000000000000] user address but active_mm is swapper
>>> [    7.198480] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>> [    7.204107] Modules linked in:
>>> [    7.207189] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>>> 4.19.0-00002-g3ed52fd-dirty #807
>>> [    7.216596] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
>>> [    7.223102] pstate: 20000005 (nzCv daif -PAN -UAO)
>>> [    7.227946] pc : __ll_sc_atomic_sub_return+0x4/0x20
>>> [    7.232873] lr : free_sched_groups.part.1+0x40/0x98
>>> [    7.237797] sp : ffff00000947bc60
>>> [    7.241138] x29: ffff00000947bc60 x28: ffff801fb49ba000
>>> [    7.246504] x27: ffff000009109b38 x26: ffff801fb4a38000
>>> [    7.251869] x25: ffff801fb48cc000 x24: ffff000009109000
>>> [    7.257235] x23: 0000000000000010 x22: 0000000000000001
>>> [    7.262599] x21: ffff801fb4a0b000 x20: ffff801fb4a65f00
>>> [    7.267964] x19: ffff801fb4a65f80 x18: 0000000000000400
>>> [    7.273329] x17: 00000000ffffffff x16: 0000000000000000
>>> [    7.278694] x15: ffff801ffbffef80 x14: ffff7e007ed14bc0
>>> [    7.284059] x13: 00000000000000c0 x12: 000000000000003f
>>> [    7.289423] x11: ffff801fb62258b8 x10: 0000000000000001
>>> [    7.294788] x9 : ffff801fb44b0100 x8 : 000000000000000f
>>> [    7.300153] x7 : ffff801fb48b1900 x6 : 0000801ff2efb000
>>> [    7.305518] x5 : ffff0000091096f0 x4 : 0000000000000400
>>> [    7.310882] x3 : ffff801fb4a65000 x2 : ffff801fb4a0b000
>>> [    7.316247] x1 : 0000000000000000 x0 : 0000000000000001
>>> [    7.321613] Process swapper/0 (pid: 1, stack limit =
>>> 0x(____ptrval____))
>>> [    7.328382] Call trace:
>>> [    7.330847]  __ll_sc_atomic_sub_return+0x4/0x20
>>> [    7.335420]  destroy_sched_domain+0x20/0x70
>>> [    7.339642]  cpu_attach_domain+0xc8/0x2e8
>>> [    7.343687]  build_sched_domains+0xd44/0xde0
>>> [    7.347996]  sched_init_domains+0x68/0x88
>>> [    7.352044]  sched_init_smp+0x2c/0x7c
>>> [    7.355738]  kernel_init_freeable+0xdc/0x244
>>> [    7.360049]  kernel_init+0x10/0x108
>>> [    7.363567]  ret_from_fork+0x10/0x18
>>> [    7.367174] Code: 88107c31 35ffffb0 d65f03c0 f9800031 (885f7c31)
>>> [    7.373400] ---[ end trace 8150af869a14363f ]---
>>> [    7.378076] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>> [    7.378076]
>>> [    7.387320] SMP: stopping secondary CPUs
>>> [    7.391297] ---[ end Kernel panic - not syncing: Attempted to kill
>>> init!
>>> exitcode=0x0000000b
>>> [    7.391297]  ]---
>>>
>>> I will straightaway note that I have been fiddling with my board's
>>> device
>>> tree, specifically (breaking!) the NUMA distance map, like this:
>>>
>>> distance-matrix = <0 0 10>,
>>>                    <0 1 15>,
>>>                    <0 2 20>,
>>>                    <0 3 25>,
>>>                    <1 0 15>,
>>>                    <1 1 10>,
>>>                    <1 2 25>,
>>>                    <1 3 30>,
>>>                    <2 0 20>,
>>>                    <2 1 25>,
>>>                    <2 2 10>,
>>>                    <2 3 15>,
>>>                    <3 0 10>,* should be same as 0->3 and > 10
>>>                    <3 1 10>,* should be same as 1->3 and > 10
>>>                    <3 2 15>,
>>>                    <3 3 15>;* should be 10
>>>
>>> However I don't think that this should crash the kernel. I'd say
>>> of_numa_parse_distance_map_v1() should robustly handle broken maps,
>>> probably
>>> by erroring and causing NUMA to be disabled.
>>
>> If build with CONFIG_SCHED_DEBUG=y and boot with "sched_debug" I think
>> sched_init_numa() should yell at you for the above 'mistake'.
>>
>
> Right, I have since turned on debug and it was complaining - I'll
> provide a log.

As promised:

EFI stub: Booting Linux Kernel...
SmiGraphicsOutputQueryMode +
SmiGraphicsOutputQueryMode -
SmiGraphicsOutputQueryMode +
SmiGraphicsOutputQueryMode -
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[SAL_ClearAffiliationSMP,325]it is going to hard reset 
dev:0x500E004AAAAAAA1F
SAS ExitBootServicesEvent
GMAC ExitBootServicesEvent
GMAC ExitBootServicesEvent
GMAC ExitBootServicesEvent
GMAC ExitBootServicesEvent
OHCI ExitBootServicesEvent
IPMI ExitBootService Event
TransferSmbiosToBMC EVENT.
Transfer Smbios Table To iBMC Success.
GetVariable Status : Not Found.
[    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
[    0.000000] Linux version 4.19.0-rc6-00002-gea67197-dirty 
(johnpgarry@johnpgarry-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
[linaro-7.3-2018.05-rc1 revision 
38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
#877 SMP PREEMPT Tue Oct 30 15:10:30 GMT 2018
[    0.000000] Machine model: Hisilicon Hip07 D05 Development Board
[    0.000000] earlycon: pl11 at MMIO 0x00000000602b0000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS=0x3f050000  SMBIOS 3.0=0x39b00000 
ACPI=0x39bd0000  ACPI 2.0=0x39bd0014  MEMATTR=0x3cc99018
[    0.000000] crashkernel reserved: 0x0000000002000000 - 
0x0000000012000000 (256 MB)
[    0.000000] cma: Reserved 32 MiB at 0x000000003d000000
[    0.000000] earlycon: pl11 at MMIO32 0x00000000602b0000 (options 
'115200n8')
[    0.000000] ------------[ cut here ]------------
[    0.000000] console 'pl11' already registered
[    0.000000] WARNING: CPU: 0 PID: 0 at kernel/printk/printk.c:2586 
register_console+0x58/0x3c8
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 
4.19.0-rc6-00002-gea67197-dirty #877
[    0.000000] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
[    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    0.000000] pc : register_console+0x58/0x3c8
[    0.000000] lr : register_console+0x58/0x3c8
[    0.000000] sp : ffff000009113de0
[    0.000000] x29: ffff000009113de0 x28: 0000000000fc0018
[    0.000000] x27: 000000003cc81018 x26: ffff0000090e2098
[    0.000000] x25: 0000000000004b10 x24: ffff0000090f5348
[    0.000000] x23: ffff0000090e2098 x22: ffff000009274000
[    0.000000] x21: ffff00000920e6d0 x20: 0000000000004b10
[    0.000000] x19: ffff00000920e6d0 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffff0000091196c8 x14: ffff0000892746ef
[    0.000000] x13: ffff0000092746fd x12: ffff000009119940
[    0.000000] x11: ffff0000085f42b8 x10: ffff000009113ab0
[    0.000000] x9 : 000000000000000d x8 : 722079646165726c
[    0.000000] x7 : 61202731316c7027 x6 : 000000000000000d
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : ffffffffffffffff x2 : ffff000009131640
[    0.000000] x1 : 0000000000000000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  register_console+0x58/0x3c8
[    0.000000]  of_setup_earlycon+0x20c/0x22c
[    0.000000]  early_init_dt_scan_chosen_stdout+0x158/0x19c
[    0.000000]  acpi_boot_table_init+0x150/0x184
[    0.000000]  setup_arch+0x1cc/0x514
[    0.000000]  start_kernel+0x80/0x418
[    0.000000] random: get_random_bytes called from 
print_oops_end_marker+0x48/0x68 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] OF: NUMA: parsing numa-distance-map-v1
[    0.000000] NUMA: Warning: invalid distance parameter, from=3 to=3 
distance=15
[    0.000000] NUMA: NODE_DATA [mem 0x1ffbffe840-0x1ffbffffff]
[    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x41ffbf41fc0-0x41ffbf4377f]
[    0.000000] NUMA: NODE_DATA(1) on node 2
[    0.000000] NUMA: NODE_DATA [mem 0x41ffbf40800-0x41ffbf41fbf]
[    0.000000] NUMA: Initmem setup node 3 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x41ffbf3f040-0x41ffbf407ff]
[    0.000000] NUMA: NODE_DATA(3) on node 2
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x0000041ffbffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000031902fff]
[    0.000000]   node   0: [mem 0x0000000031903000-0x0000000031906fff]
[    0.000000]   node   0: [mem 0x0000000031907000-0x000000003999ffff]
[    0.000000]   node   0: [mem 0x00000000399a0000-0x0000000039a3ffff]
[    0.000000]   node   0: [mem 0x0000000039a40000-0x0000000039a8ffff]
[    0.000000]   node   0: [mem 0x0000000039a90000-0x0000000039a9ffff]
[    0.000000]   node   0: [mem 0x0000000039aa0000-0x0000000039aeffff]
[    0.000000]   node   0: [mem 0x0000000039af0000-0x0000000039bbffff]
[    0.000000]   node   0: [mem 0x0000000039bc0000-0x0000000039bdffff]
[    0.000000]   node   0: [mem 0x0000000039be0000-0x000000003a05ffff]
[    0.000000]   node   0: [mem 0x000000003a060000-0x000000003f04ffff]
[    0.000000]   node   0: [mem 0x000000003f050000-0x000000003f07ffff]
[    0.000000]   node   0: [mem 0x000000003f080000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000001040000000-0x0000001ffbffffff]
[    0.000000]   node   2: [mem 0x0000041000000000-0x0000041ffbffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x0000001ffbffffff]
[    0.000000] Could not find start_pfn for node 1
[    0.000000] Initmem setup node 1 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] Initmem setup node 2 [mem 
0x0000041000000000-0x0000041ffbffffff]
[    0.000000] Could not find start_pfn for node 3
[    0.000000] Initmem setup node 3 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) s56408 
r8192 d29608 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for EL2 vector hardening
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 
32996880
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init 
crashkernel=256M@32M console=ttyAMA0,115200 
earlycon=pl011,mmio,0x602b0000 acpi=off pcie_aspm=off earlycon sched_debug
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 258048 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 123328(94%)
[    0.000000] software IO TLB: mapped [mem 0x359a0000-0x399a0000] (64MB)
[    0.000000] Memory: 131332180K/134082560K available (10684K kernel 
code, 1374K rwdata, 4896K rodata, 1344K init, 384K bss, 2717612K 
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=64, Nodes=4
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]     Tasks RCU enabled.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: VLPI support, direct LPI support
[    0.000000] ITS [mem 0x4c000000-0x4c03ffff]
[    0.000000] ITS@0x000000004c000000: Using ITS number 0
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x000000004c000000: allocated 524288 Devices 
@1fbb000000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000000004c000000: allocated 65536 Virtual CPUs 
@1fbb980000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000000004c000000: allocated 512 Interrupt 
Collections @1fbb929000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x6c000000-0x6c03ffff]
[    0.000000] ITS@0x000000006c000000: Using ITS number 1
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x000000006c000000: allocated 524288 Devices 
@1fbac00000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000000006c000000: allocated 65536 Virtual CPUs 
@1fbba00000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000000006c000000: allocated 512 Interrupt 
Collections @1fbb92a000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0xc6000000-0xc603ffff]
[    0.000000] ITS@0x00000000c6000000: Using ITS number 2
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x00000000c6000000: allocated 524288 Devices 
@1fba800000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 65536 Virtual CPUs 
@1fbba80000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000000c6000000: allocated 512 Interrupt 
Collections @1fbb92c000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x8c6000000-0x8c603ffff]
[    0.000000] ITS@0x00000008c6000000: Using ITS number 3
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x00000008c6000000: allocated 524288 Devices 
@1fba400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000008c6000000: allocated 65536 Virtual CPUs 
@1fbbb00000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000008c6000000: allocated 512 Interrupt 
Collections @1fbb92e000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x4004c000000-0x4004c03ffff]
[    0.000000] ITS@0x000004004c000000: Using ITS number 4
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x000004004c000000: allocated 524288 Devices 
@1fba000000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000004004c000000: allocated 65536 Virtual CPUs 
@1fbbb80000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000004004c000000: allocated 512 Interrupt 
Collections @1fbb92f000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x4006c000000-0x4006c03ffff]
[    0.000000] ITS@0x000004006c000000: Using ITS number 5
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x000004006c000000: allocated 524288 Devices 
@1fb9800000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x000004006c000000: allocated 65536 Virtual CPUs 
@1fb9c80000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x000004006c000000: allocated 512 Interrupt 
Collections @1fb9c10000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x400c6000000-0x400c603ffff]
[    0.000000] ITS@0x00000400c6000000: Using ITS number 6
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x00000400c6000000: allocated 524288 Devices 
@1fb9400000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000400c6000000: allocated 65536 Virtual CPUs 
@1fb9d00000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000400c6000000: allocated 512 Interrupt 
Collections @1fb9c11000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS [mem 0x408c6000000-0x408c603ffff]
[    0.000000] ITS@0x00000408c6000000: Using ITS number 7
[    0.000000] GIC: enabling workaround for ITS: Hip07 erratum 161600802
[    0.000000] ITS@0x00000408c6000000: allocated 524288 Devices 
@1fb9000000 (flat, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x00000408c6000000: allocated 65536 Virtual CPUs 
@1fb9d80000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] ITS@0x00000408c6000000: allocated 512 Interrupt 
Collections @1fb9c13000 (flat, esz 8, psz 4K, shr 1)
[    0.000000] GIC: using LPI property table @0x0000001fb9c40000
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv3: CPU0: found redistributor 10000 region 
0:0x000000004d100000
[    0.000000] CPU0: using LPI pending table @0x0000001fb9c50000
[    0.000000] arch_timer: cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000001] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps 
every 4398046511100ns
[    0.008253] Console: colour dummy device 80x25
[    0.012797] mempolicy: Enabling automatic NUMA balancing. Configure 
with numa_balancing= or the kernel.numa_balancing sysctl
[    0.024161] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.034714] pid_max: default: 65536 minimum: 512
[    0.039437] Security Framework initialized
[    0.066552] Dentry cache hash table entries: 8388608 (order: 14, 
67108864 bytes)
[    0.085423] Inode-cache hash table entries: 4194304 (order: 13, 
33554432 bytes)
[    0.093195] Mount-cache hash table entries: 131072 (order: 8, 1048576 
bytes)
[    0.100677] Mountpoint-cache hash table entries: 131072 (order: 8, 
1048576 bytes)
[    0.152289] ASID allocator initialised with 32768 entries
[    0.157776] rcu: Hierarchical SRCU implementation.
[    0.170653] Platform MSI: interrupt-controller@4c000000 domain created
[    0.177254] Platform MSI: interrupt-controller@6c000000 domain created
[    0.183853] Platform MSI: interrupt-controller@c6000000 domain created
[    0.190452] Platform MSI: interrupt-controller@8,c6000000 domain created
[    0.197227] Platform MSI: interrupt-controller@400,4c000000 domain 
created
[    0.204178] Platform MSI: interrupt-controller@400,6c000000 domain 
created
[    0.211129] Platform MSI: interrupt-controller@400,c6000000 domain 
created
[    0.218079] Platform MSI: interrupt-controller@408,c6000000 domain 
created
[    0.225076] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@4c000000 domain created
[    0.233960] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@6c000000 domain created
[    0.242844] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@c6000000 domain created
[    0.251729] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@8,c6000000 domain 
created
[    0.260790] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@400,4c000000 domain 
created
[    0.270026] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@400,6c000000 domain 
created
[    0.279261] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@400,c6000000 domain 
created
[    0.288497] PCI/MSI: 
/interrupt-controller@4d000000/interrupt-controller@408,c6000000 domain 
created
[    0.298192] Remapping and enabling EFI services.
[    0.310865] smp: Bringing up secondary CPUs ...
[    0.398048] Detected PIPT I-cache on CPU1
[    0.398060] GICv3: CPU1: found redistributor 10001 region 
0:0x000000004d140000
[    0.398118] CPU1: using LPI pending table @0x0000041fb81e0000
[    0.398238] CPU1: Booted secondary processor 0x0000010001 [0x410fd082]
[    0.480668] Detected PIPT I-cache on CPU2
[    0.480674] GICv3: CPU2: found redistributor 10002 region 
0:0x000000004d180000
[    0.480730] CPU2: using LPI pending table @0x0000041fb81f0000
[    0.480833] CPU2: Booted secondary processor 0x0000010002 [0x410fd082]
[    0.563294] Detected PIPT I-cache on CPU3
[    0.563301] GICv3: CPU3: found redistributor 10003 region 
0:0x000000004d1c0000
[    0.563360] CPU3: using LPI pending table @0x0000041fb8200000
[    0.563466] CPU3: Booted secondary processor 0x0000010003 [0x410fd082]
[    0.645921] Detected PIPT I-cache on CPU4
[    0.645929] GICv3: CPU4: found redistributor 10100 region 
0:0x000000004d200000
[    0.645988] CPU4: using LPI pending table @0x0000041fb8210000
[    0.646092] CPU4: Booted secondary processor 0x0000010100 [0x410fd082]
[    0.728547] Detected PIPT I-cache on CPU5
[    0.728554] GICv3: CPU5: found redistributor 10101 region 
0:0x000000004d240000
[    0.728611] CPU5: using LPI pending table @0x0000041fb8220000
[    0.728714] CPU5: Booted secondary processor 0x0000010101 [0x410fd082]
[    0.811174] Detected PIPT I-cache on CPU6
[    0.811181] GICv3: CPU6: found redistributor 10102 region 
0:0x000000004d280000
[    0.811238] CPU6: using LPI pending table @0x0000041fb8230000
[    0.811342] CPU6: Booted secondary processor 0x0000010102 [0x410fd082]
[    0.893801] Detected PIPT I-cache on CPU7
[    0.893808] GICv3: CPU7: found redistributor 10103 region 
0:0x000000004d2c0000
[    0.893864] CPU7: using LPI pending table @0x0000041fb8240000
[    0.893969] CPU7: Booted secondary processor 0x0000010103 [0x410fd082]
[    0.976430] Detected PIPT I-cache on CPU8
[    0.976438] GICv3: CPU8: found redistributor 10200 region 
0:0x000000004d300000
[    0.976494] CPU8: using LPI pending table @0x0000041fb8250000
[    0.976599] CPU8: Booted secondary processor 0x0000010200 [0x410fd082]
[    1.059056] Detected PIPT I-cache on CPU9
[    1.059063] GICv3: CPU9: found redistributor 10201 region 
0:0x000000004d340000
[    1.059118] CPU9: using LPI pending table @0x0000041fb8260000
[    1.059221] CPU9: Booted secondary processor 0x0000010201 [0x410fd082]
[    1.141682] Detected PIPT I-cache on CPU10
[    1.141689] GICv3: CPU10: found redistributor 10202 region 
0:0x000000004d380000
[    1.141745] CPU10: using LPI pending table @0x0000041fb8270000
[    1.141848] CPU10: Booted secondary processor 0x0000010202 [0x410fd082]
[    1.224310] Detected PIPT I-cache on CPU11
[    1.224317] GICv3: CPU11: found redistributor 10203 region 
0:0x000000004d3c0000
[    1.224375] CPU11: using LPI pending table @0x0000041fb8280000
[    1.224477] CPU11: Booted secondary processor 0x0000010203 [0x410fd082]
[    1.306938] Detected PIPT I-cache on CPU12
[    1.306948] GICv3: CPU12: found redistributor 10300 region 
0:0x000000004d400000
[    1.307004] CPU12: using LPI pending table @0x0000041fb8290000
[    1.307110] CPU12: Booted secondary processor 0x0000010300 [0x410fd082]
[    1.389564] Detected PIPT I-cache on CPU13
[    1.389571] GICv3: CPU13: found redistributor 10301 region 
0:0x000000004d440000
[    1.389629] CPU13: using LPI pending table @0x0000041fb82a0000
[    1.389733] CPU13: Booted secondary processor 0x0000010301 [0x410fd082]
[    1.472190] Detected PIPT I-cache on CPU14
[    1.472198] GICv3: CPU14: found redistributor 10302 region 
0:0x000000004d480000
[    1.472252] CPU14: using LPI pending table @0x0000041fb82b0000
[    1.472598] CPU14: Booted secondary processor 0x0000010302 [0x410fd082]
[    1.   1.554883] CPU15: using LPI pending table @0x0000041fb82c0000
[    1.554988] CPU15: Booted secondary processor 0x0000010303 [0x410fd082]
[    1.637107] Detected PIPT I-cache on CPU16
[    1.637119] GICv3: CPU16: found redistributor 30000 region 
1:0x000000006d100000
[    1.637182] CPU16: using LPI pending table @0x0000041fb82d0000
[    1.637329] CPU16: Booted secondary processor 0x0000030000 [0x410fd082]
[    1.719738] Detected PIPT I-cache on CPU17
[    1.719747] GICv3: CPU17: found redistributor 30001 region 
1:0x000000006d140000
[    1.719806] CPU17: using LPI pending table @0x0000041fb82e0000
[    1.719948] CPU17: Booted secondary processor 0x0000030001 [0x410fd082]
[    1.802371] Detected PIPT I-cache on CPU18
[    1.802380] GICv3: CPU18: found redistributor 30002 region 
1:0x000000006d180000
[    1.802441] CPU18: using LPI pending table @0x0000041fb82f0000
[    1.802585] CPU18: Booted secondary processor 0x0000030002 [0x410fd082]
[    1.885004] Detected PIPT I-cache on CPU19
[    1.885013] GICv3: CPU19: found redistributor 30003 region 
1:0x000000006d1c0000
[    1.885074] CPU19: using LPI pending table @0x0000041fb8300000
[    1.885215] CPU19: Booted secondary processor 0x0000030003 [0x410fd082]
[    1.967639] Detected PIPT I-cache on CPU20
[    1.967651] GICv3: CPU20: found redistributor 30100 region 
1:0x000000006d200000
[    1.967713] CPU20: using LPI pending table @0x0000041fb8310000
[    1.967860] CPU20: Booted secondary processor 0x0000030100 [0x410fd082]
[    2.050270] Detected PIPT I-cache on CPU21
[    2.050279] GICv3: CPU21: found redistributor 30101 region 
1:0x000000006d240000
[    2.050341] CPU21: using LPI pending table @0x0000041fb8320000
[    2.050483] CPU21: Booted secondary processor 0x0000030101 [0x410fd082]
[    2.132903] Detected PIPT I-cache on CPU22
[    2.132913] GICv3: CPU22: found redistributor 30102 region 
1:0x000000006d280000
[    2.132973] CPU22: using LPI pending table @0x0000041fb8330000
[    2.133115] CPU22: Booted secondary processor 0x0000030102 [0x410fd082]
[    2.215536] Detected PIPT I-cache on CPU23
[    2.215546] GICv3: CPU23: found redistributor 30103 region 
1:0x000000006d2c0000
[    2.215606] CPU23: using LPI pending table @0x0000041fb8340000
[    2.215749] CPU23: Booted secondary processor 0x0000030103 [0x410fd082]
[    2.298171] Detected PIPT I-cache on CPU24
[    2.298184] GICv3: CPU24: found redistributor 30200 region 
1:0x000000006d300000
[    2.298248] CPU24: using LPI pending table @0x0000041fb8350000
[    2.298394] CPU24: Booted secondary processor 0x0000030200 [0x410fd082]
[    2.380801] Detected PIPT I-cache on CPU25
[    2.380811] GICv3: CPU25: found redistributor 30201 region 
1:0x000000006d340000
[    2.380872] CPU25: using LPI pending table @0x0000041fb8360000
[    2.381013] CPU25: Booted secondary processor 0x0000030201 [0x410fd082]
[    2.463433] Detected PIPT I-cache on CPU26
[    2.463443] GICv3: CPU26: found redistributor 30202 region 
1:0x000000006d380000
[    2.463504] CPU26: using LPI pending table @0x0000041fb8370000
[    2.463646] CPU26: Booted secondary processor 0x0000030202 [0x410fd082]
[    2.546066] Detected PIPT I-cache on CPU27
[    2.546076] GICv3: CPU27: found redistributor 30203 region 
1:0x000000006d3c0000
[    2.546139] CPU27: using LPI pending table @0x0000041fb8380000
[    2.546282] CPU27: Booted secondary processor 0x0000030203 [0x410fd082]
[    2.628701] Detected PIPT I-cache on CPU28
[    2.628713] GICv3: CPU28: found redistributor 30300 region 
1:0x000000006d400000
[    2.628775] CPU28: using LPI pending table @0x0000041fb8390000
[    2.628921] CPU28: Booted secondary processor 0x0000030300 [0x410fd082]
[    2.711331] Detected PIPT I-cache on CPU29
[    2.711342] GICv3: CPU29: found redistributor 30301 region 
1:0x000000006d440000
[    2.711403] CPU29: using LPI pending table @0x0000041fb83a0000
[    2.711545] CPU29: Booted secondary processor 0x0000030301 [0x410fd082]
[    2.793969] Detected PIPT I-cache on CPU30
[    2.793979] GICv3: CPU30: found redistributor 30302 region 
1:0x000000006d480000
[    2.794040] CPU30: using LPI pending table @0x0000041fb83b0000
[    2.794184] CPU30: Booted secondary processor 0x0000030302 [0x410fd082]
[    2.876604] Detected PIPT I-cache on CPU31
[    2.876615] GICv3: CPU31: found redistributor 30303 region 
1:0x000000006d4c0000
[    2.876677] CPU31: using LPI pending table @0x0000041fb83c0000
[    2.876818] CPU31: Booted secondary processor 0x0000030303 [0x410fd082]
[    2.958920] Detected PIPT I-cache on CPU32
[    2.958961] GICv3: CPU32: found redistributor 50000 region 
2:0x000004004d100000
[    2.958994] CPU32: using LPI pending table @0x0000041fb83e0000
[    2.959149] CPU32: Booted secondary processor 0x0000050000 [0x410fd082]
[    3.041547] Detected PIPT I-cache on CPU33
[    3.041572] GICv3: CPU33: found redistributor 50001 region 
2:0x000004004d140000
[    3.041597] CPU33: using LPI pending table @0x0000041fb83f0000
[    3.041703] CPU33: Booted secondary processor 0x0000050001 [0x410fd082]
[    3.124194] Detected PIPT I-cache on CPU34
[    3.124218] GICv3: CPU34: found redistributor 50002 region 
2:0x000004004d180000
[    3.124244] CPU34: using LPI pending table @0x0000041fb7850000
[    3.124351] CPU34: Booted secondary processor 0x0000050002 [0x410fd082]
[    3.206841] Detected PIPT I-cache on CPU35
[    3.206866] GICv3: CPU35: found redistributor 50003 region 
2:0x000004004d1c0000
[    3.206892] CPU35: using LPI pending table @0x0000041fb7860000
[    3.206998] CPU35: Booted secondary processor 0x0000050003 [0x410fd082]
[    3.289488] Detected PIPT I-cache on CPU36
[    3.289514] GICv3: CPU36: found redistributor 50100 region 
2:0x000004004d200000
[    3.289540] CPU36: using LPI pending table @0x0000041fb7870000
[    3.289649] CPU36: Booted secondary processor 0x0000050100 [0x410fd082]
[    3.372137] Detected PIPT I-cache on CPU37
[    3.372162] GICv3: CPU37: found redistributor 50101 region 
2:0x000004004d240000
[    3.372188] CPU37: using LPI pending table @0x0000041fb78d0000
[    3.372294] CPU37: Booted secondary processor 0x0000050101 [0x410fd082]
[    3.454782] Detected PIPT I-cache on CPU38
[    3.454808] GICv3: CPU38: found redistributor 50102 region 
2:0x000004004d280000
[    3.454833] CPU38: using LPI pending table @0x0000041fb78e0000
[    3.454940] CPU38: Booted secondary processor 0x0000050102 [0x410fd082]
[    3.537432] Detected PIPT I-cache on CPU39
[    3.537457] GICv3: CPU39: found redistributor 50103 region 
2:0x000004004d2c0000
[    3.537483] CPU39: using LPI pending table @0x0000041fb78f0000
[    3.537589] CPU39: Booted secondary processor 0x0000050103 [0x410fd082]
[    3.620080] Detected PIPT I-cache on CPU40
[    3.620106] GICv3: CPU40: found redistributor 50200 region 
2:0x000004004d300000
[    3.620134] CPU40: using LPI pending table @0x0000041fb7940000
[    3.620244] CPU40: Booted secondary processor 0x0000050200 [0x410fd082]
[    3.702727] Detected PIPT I-cache on CPU41
[    3.702752] GICv3: CPU41: found redistributor 50201 region 
2:0x000004004d340000
[    3.702778] CPU41: using LPI pending table @0x0000041fb7950000
[    3.702885] CPU41: Booted secondary processor 0x0000050201 [0x410fd082]
[    3.785375] Detected PIPT I-cache on CPU42
[    3.785400] GICv3: CPU42: found redistributor 50202 region 
2:0x000004004d380000
[    3.785427] CPU42: using LPI pending table @0x0000041fb7960000
[    3.785534] CPU42: Booted secondary processor 0x0000050202 [0x410fd082]
[    3.868026] Detected PIPT I-cache on CPU43
[    3.868052] GICv3: CPU43: found redistributor 50203 region 
2:0x000004004d3c0000
[    3.868080] CPU43: using LPI pending table @0x0000041fb79c0000
[    3.868187] CPU43: Booted secondary processor 0x0000050203 [0x410fd082]
[    3.950673] Detected PIPT I-cache on CPU44
[    3.950700] GICv3: CPU44: found redistributor 50300 region 
2:0x000004004d400000
[    3.950728] CPU44: using LPI pending table @0x0000041fb79d0000
[    3.950837] CPU44: Booted secondary processor 0x0000050300 [0x410fd082]
[    4.033322] Detected PIPT I-cache on CPU45
[    4.033348] GICv3: CPU45: found redistributor 50301 region 
2:0x000004004d440000
[    4.033374] CPU45: using LPI pending table @0x0000041fb79e0000
[    4.033480] CPU45: Booted secondary processor 0x0000050301 [0x410fd082]
[    4.115970] Detected PIPT I-cache on CPU46
[    4.115996] GICv3: CPU46: found redistributor 50302 region 
2:0x000004004d480000
[    4.116023] CPU46: using LPI pending table @0x0000041fb7a40000
[    4.116131] CPU46: Booted secondary processor 0x0000050302 [0x410fd082]
[    4.198621] Detected PIPT I-cache on CPU47
[    4.198647] GICv3: CPU47: found redistributor 50303 region 
2:0x000004004d4c0000
[    4.198674] CPU47: using LPI pending table @0x0000041fb7a50000
[    4.198779] CPU47: Booted secondary processor 0x0000050303 [0x410fd082]
[    4.280925] Detected PIPT I-cache on CPU48
[    4.280958] GICv3: CPU48: found redistributor 70000 region 
3:0x000004006d100000
[    4.280996] CPU48: using LPI pending table @0x0000041fb7a60000
[    4.281148] CPU48: Booted secondary processor 0x0000070000 [0x410fd082]
[    4.363577] Detected PIPT I-cache on CPU49
[    4.363606] GICv3: CPU49: found redistributor 70001 region 
3:0x000004006d140000
[    4.363643] CPU49: using LPI pending table @0x0000041fb7ae0000
[    4.363788] CPU49: Booted secondary processor 0x0000070001 [0x410fd082]
[    4.446225] Detected PIPT I-cache on CPU50
[    4.446254] GICv3: CPU50: found redistributor 70002 region 
3:0x000004006d180000
[    4.446291] CPU50: using LPI pending table @0x0000041fb7af0000
[    4.446438] CPU50: Booted secondary processor 0x0000070002 [0x410fd082]
[    4.528875] Detected PIPT I-cache on CPU51
[    4.528904] GICv3: CPU51: found redistributor 70003 region 
3:0x000004006d1c0000
[    4.528942] CPU51: using LPI pending table @0x0000041fb7b00000
[    4.529089] CPU51: Booted secondary processor 0x0000070003 [0x410fd082]
[    4.611527] Detected PIPT I-cache on CPU52
[    4.611559] GICv3: CPU52: found redistributor 70100 region 
3:0x000004006d200000
[    4.611598] CPU52: using LPI pending table @0x0000041fb7b10000
[    4.611750] CPU52: Booted secondary processor 0x0000070100 [0x410fd082]
[    4.694176] Detected PIPT I-cache on CPU53
[    4.694205] GICv3: CPU53: found redistributor 70101 region 
3:0x000004006d240000
[    4.694242] CPU53: using LPI pending table @0x0000041fb7b20000
[    4.694389] CPU53: Booted secondary processor 0x0000070101 [0x410fd082]
[    4.776826] Detected PIPT I-cache on CPU54
[    4.776855] GICv3: CPU54: found redistributor 70102 region 
3:0x000004006d280000
[    4.776892] CPU54: using LPI pending table @0x0000041fb7b30000
[    4.777039] CPU54: Booted secondary processor 0x0000070102 [0x410fd082]
[    4.859476] Detected PIPT I-cache on CPU55
[    4.859505] GICv3: CPU55: found redistributor 70103 region 
3:0x000004006d2c0000
[    4.859543] CPU55: using LPI pending table @0x0000041fb7b40000
[    4.859689] CPU55: Booted secondary processor 0x0000070103 [0x410fd082]
[    4.942127] Detected PIPT I-cache on CPU56
[    4.942160] GICv3: CPU56: found redistributor 70200 region 
3:0x000004006d300000
[    4.942197] CPU56: using LPI pending table @0x0000041fb7b50000
[    4.942352] CPU56: Booted secondary processor 0x0000070200 [0x410fd082]
[    5.024775] Detected PIPT I-cache on CPU57
[    5.024804] GICv3: CPU57: found redistributor 70201 region 
3:0x000004006d340000
[    5.024841] CPU57: using LPI pending table @0x0000041fb7b60000
[    5.024988] CPU57: Booted secondary processor 0x0000070201 [0x410fd082]
[    5.107423] Detected PIPT I-cache on CPU58
[    5.107453] GICv3: CPU58: found redistributor 70202 region 
3:0x000004006d380000
[    5.107489] CPU58: using LPI pending table @0x0000041fb7b70000
[    5.107635] CPU58: Booted secondary processor 0x0000070202 [0x410fd082]
[    5.190075] Detected PIPT I-cache on CPU59
[    5.190105] GICv3: CPU59: found redistributor 70203 region 
3:0x000004006d3c0000
[    5.190143] CPU59: using LPI pending table @0x0000041fb7b80000
[    5.190289] CPU59: Booted secondary processor 0x0000070203 [0x410fd082]
[    5.272725] Detected PIPT I-cache on CPU60
[    5.272758] GICv3: CPU60: found redistributor 70300 region 
3:0x000004006d400000
[    5.272795] CPU60: using LPI pending table @0x0000041fb7b90000
[    5.272950] CPU60: Booted secondary processor 0x0000070300 [0x410fd082]
[    5.355374] Detected PIPT I-cache on CPU61
[    5.355403] GICv3: CPU61: found redistributor 70301 region 
3:0x000004006d440000
[    5.355441] CPU61: using LPI pending table @0x0000041fb7ba0000
[    5.355587] CPU61: Booted secondary processor 0x0000070301 [0x410fd082]
[    5.438022] Detected PIPT I-cache on CPU62
[    5.438052] GICv3: CPU62: found redistributor 70302 region 
3:0x000004006d480000
[    5.438089] CPU62: using LPI pending table @0x0000041fb7bb0000
[    5.438235] CPU62: Booted secondary processor 0x0000070302 [0x410fd082]
[    5.520675] Detected PIPT I-cache on CPU63
[    5.520705] GICv3: CPU63: found redistributor 70303 region 
3:0x000004006d4c0000
[    5.520743] CPU63: using LPI pending table @0x0000041fb7bc0000
[    5.520888] CPU63: Booted secondary processor 0x0000070303 [0x410fd082]
[    5.520975] smp: Brought up 4 nodes, 64 CPUs
[    7.042259] SMP: Total of 64 processors activated.
[    7.047105] CPU features: detected: GIC system register CPU interface
[    7.053625] CPU features: detected: 32-bit EL0 Support
[    7.145591] CPU: All CPU(s) started at EL2
[    7.149856] alternatives: patching kernel code
[    7.154740] ERROR: Node-distance not symmetric
[    7.154740]
[    7.160724]   10 15 20 25
[    7.163456]   15 10 25 30
[    7.166190]   20 25 10 15
[    7.168921]   10 10 15 10
[    7.171655]
[    7.175589] ERROR: groups don't span domain->span
[    7.180352] ERROR: groups don't span domain->span
[    7.185164] ERROR: groups don't span domain->span
[    7.189926] ERROR: groups don't span domain->span
[    7.194734] ERROR: groups don't span domain->span
[    7.199495] ERROR: groups don't span domain->span
[    7.204303] ERROR: groups don't span domain->span
[    7.209064] ERROR: groups don't span domain->span
[    7.213872] ERROR: groups don't span domain->span
[    7.218632] ERROR: groups don't span domain->span
[    7.223440] ERROR: groups don't span domain->span
[    7.228201] ERROR: groups don't span domain->span
[    7.233009] ERROR: groups don't span domain->span
[    7.237770] ERROR: groups don't span domain->span
[    7.242577] ERROR: groups don't span domain->span
[    7.247337] ERROR: groups don't span domain->span
[    7.252144] ERROR: groups don't span domain->span
[    7.256905] ERROR: groups don't span domain->span
[    7.261714] ERROR: groups don't span domain->span
[    7.266474] ERROR: groups don't span domain->span
[    7.271282] ERROR: groups don't span domain->span
[    7.276042] ERROR: groups don't span domain->span
[    7.280851] ERROR: groups don't span domain->span
[    7.285611] ERROR: groups don't span domain->span
[    7.290420] ERROR: groups don't span domain->span
[    7.295180] ERROR: groups don't span domain->span
[    7.299988] ERROR: groups don't span domain->span
[    7.304748] ERROR: groups don't span domain->span
[    7.309555] ERROR: groups don't span domain->span
[    7.314315] ERROR: groups don't span domain->span
[    7.319122] ERROR: groups don't span domain->span
[    7.323883] ERROR: groups don't span domain->span
[    7.328642] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
[    7.337525] Mem abort info:
[    7.340339]   ESR = 0x96000004
[    7.343421]   Exception class = DABT (current EL), IL = 32 bits
[    7.349403]   SET = 0, FnV = 0
[    7.352482]   EA = 0, S1PTW = 0
[    7.355651] Data abort info:
[    7.358554]   ISV = 0, ISS = 0x00000004
[    7.362427]   CM = 0, WnR = 0
[    7.365418] [0000000000000000] user address but active_mm is swapper
[    7.371840] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    7.377468] Modules linked in:
[    7.380550] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W 
4.19.0-rc6-00002-gea67197-dirty #877
[    7.390308] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
[    7.396815] pstate: 20000005 (nzCv daif -PAN -UAO)
[    7.401659] pc : __ll_sc_atomic_sub_return+0x4/0x20
[    7.406585] lr : free_sched_groups.part.1+0x40/0x98
[    7.411509] sp : ffff00000947bc40
[    7.414851] x29: ffff00000947bc40 x28: ffff801fb4eae000
[    7.420216] x27: 0000000000000010 x26: ffff000009119000
[    7.425581] x25: 0000000000000010 x24: ffff801fb4e30000
[    7.430946] x23: ffffffffffffe830 x22: 0000000000000001
[    7.436311] x21: ffff801fb4e83000 x20: ffff801fb4eddf00
[    7.441675] x19: ffff801fb4eddf80 x18: ffffffffffffffff
[    7.447040] x17: 00000000ffffffff x16: 0000000000000000
[    7.452405] x15: ffff0000091196c8 x14: ffff0000892746ef
[    7.457770] x13: ffff0000092746fd x12: ffff000009119940
[    7.463134] x11: ffff801fb62258b8 x10: 0000000000000001
[    7.468499] x9 : ffff801fb49e4100 x8 : 000000000000000f
[    7.473865] x7 : ffff801fb4d25700 x6 : 0000801ff2eea000
[    7.479229] x5 : ffff0000091196f0 x4 : 0000000000000400
[    7.484594] x3 : ffff801fb4edd000 x2 : ffff801fb4e83000
[    7.489959] x1 : 0000000000000000 x0 : 0000000000000001
[    7.495325] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    7.502094] Call trace:
[    7.504559]  __ll_sc_atomic_sub_return+0x4/0x20
[    7.509133]  destroy_sched_domain+0x20/0x70
[    7.513354]  cpu_attach_domain+0xd8/0x688
[    7.517401]  build_sched_domains+0xd60/0xe38
[    7.521709]  sched_init_domains+0x6c/0x98
[    7.525757]  sched_init_smp+0x2c/0x7c
[    7.529452]  kernel_init_freeable+0xdc/0x244
[    7.533762]  kernel_init+0x10/0x108
[    7.537281]  ret_from_fork+0x10/0x18
[    7.540888] Code: 88107c31 35ffffb0 d65f03c0 f9800031 (885f7c31)
[    7.547113] ---[ end trace 137e0781b6e939ab ]---
[    7.551789] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    7.551789]
[    7.561033] SMP: stopping secondary CPUs
[    7.565010] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b
[    7.565010]  ]---

I also note that if I apply the patch, below, to reject the invalid NUMA 
distance, we're still getting a warning/error:

[    7.144407] CPU: All CPU(s) started at EL2
[    7.148678] alternatives: patching kernel code
[    7.153557] ERROR: Node-0 not representative
[    7.153557]
[    7.159365]   10 15 20 25
[    7.162097]   15 10 25 30
[    7.164832]   20 25 10 15
[    7.167562]   25 30 15 10
[    7.170296]
[    7.175103] ERROR: groups don't span domain->span
[    7.179929] ERROR: groups don't span domain->span
[    7.184751] ERROR: groups don't span domain->span
[    7.189572] ERROR: groups don't span domain->span
[    7.194392] ERROR: groups don't span domain->span
[    7.199212] ERROR: groups don't span domain->span
[    7.204032] ERROR: groups don't span domain->span
[    7.208851] ERROR: groups don't span domain->span
[    7.213672] ERROR: groups don't span domain->span
[    7.218492] ERROR: groups don't span domain->span
[    7.223313] ERROR: groups don't span domain->span
[    7.228133] ERROR: groups don't span domain->span
[    7.232952] ERROR: groups don't span domain->span
[    7.237773] ERROR: groups don't span domain->span
[    7.242591] ERROR: groups don't span domain->span
[    7.247412] ERROR: groups don't span domain->span
[    7.252238] ERROR: groups don't span domain->span
[    7.257063] ERROR: groups don't span domain->span
[    7.261888] ERROR: groups don't span domain->span
[    7.266712] ERROR: groups don't span domain->span
[    7.271536] ERROR: groups don't span domain->span
[    7.276361] ERROR: groups don't span domain->span
[    7.281185] ERROR: groups don't span domain->span
[    7.286010] ERROR: groups don't span domain->span
[    7.290835] ERROR: groups don't span domain->span
[    7.295659] ERROR: groups don't span domain->span
[    7.300483] ERROR: groups don't span domain->span
[    7.305307] ERROR: groups don't span domain->span
[    7.310132] ERROR: groups don't span domain->span
[    7.314957] ERROR: groups don't span domain->span
[    7.319782] ERROR: groups don't span domain->span
[    7.324609] ERROR: groups don't span domain->span
[    7.329432] ERROR: groups don't span domain->span
[    7.334254] ERROR: groups don't span domain->span
[    7.339080] ERROR: groups don't span domain->span
[    7.343903] ERROR: groups don't span domain->span
[    7.348725] ERROR: groups don't span domain->span
[    7.353547] ERROR: groups don't span domain->span
[    7.358368] ERROR: groups don't span domain->span
[    7.363191] ERROR: groups don't span domain->span
[    7.368012] ERROR: groups don't span domain->span
[    7.372835] ERROR: groups don't span domain->span
[    7.377658] ERROR: groups don't span domain->span
[    7.382480] ERROR: groups don't span domain->span
[    7.387303] ERROR: groups don't span domain->span
[    7.392124] ERROR: groups don't span domain->span
[    7.396949] ERROR: groups don't span domain->span
[    7.401771] ERROR: groups don't span domain->span
[    7.406601] ERROR: groups don't span domain->span
[    7.411428] ERROR: groups don't span domain->span
[    7.416256] ERROR: groups don't span domain->span
[    7.421086] ERROR: groups don't span domain->span
[    7.425913] ERROR: groups don't span domain->span
[    7.430740] ERROR: groups don't span domain->span
[    7.435566] ERROR: groups don't span domain->span
[    7.440393] ERROR: groups don't span domain->span
[    7.445220] ERROR: groups don't span domain->span
[    7.450047] ERROR: groups don't span domain->span
[    7.454877] ERROR: groups don't span domain->span
[    7.459705] ERROR: groups don't span domain->span
[    7.464533] ERROR: groups don't span domain->span
[    7.469361] ERROR: groups don't span domain->span
[    7.474189] ERROR: groups don't span domain->span
[    7.479016] ERROR: groups don't span domain->span
[    7.483786] root domain span: 0-63 (max cpu_capacity = 1024)
[    7.504868] devtmpfs: initialized
[    7.510342] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns

John

>
>>> However I am interested to know if the scheduler crash is a real
>>> problem.
>>
>> Ideally we'd not crash of course.. let me see if I can still make sense
>> of that topology code.
>
> JFYI, https://lkml.org/lkml/2018/10/26/527
>
> So it seems to be that setting the distance between separate nodes to
> LOCAL_DISTANCE causes the problem. x86 NUMA code - like arm64 - allows
> this. However ACPI SLIT validation rejects this, unlike OF distance map
> parsing.
>
> Thanks,
> John
>
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
>
> .
>


