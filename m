Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4C8C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713572408B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713572408B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933391AbeFVKqT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:46:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55160 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751338AbeFVKqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:46:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B6A2B4702404;
        Fri, 22 Jun 2018 18:46:10 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 18:45:15 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com>
CC:     James Morse <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <dave.martin@arm.com>,
        <mark.rutland@arm.com>, <marc.zyngier@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
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
Message-ID: <5B2CD33B.9020702@hisilicon.com>
Date:   Fri, 22 Jun 2018 18:45:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180622092330.GD7601@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/22 17:23, Will Deacon wrote:
> Hi Wei,
>
> On Fri, Jun 22, 2018 at 09:33:04AM +0100, Wei Xu wrote:
>> On 2018/6/21 11:54, Will Deacon wrote:
>>> On Thu, Jun 21, 2018 at 11:14:28AM +0100, Wei Xu wrote:
>>>> On 2018/6/21 10:18, Will Deacon wrote:
>>>>> Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
>>>>> otherwise your kernel will take an age to boot.
>>>> Yes, amazing! This patch resolved the issue.
>>> Great...
>>>
>>>> I have tested 50 times and can not reproduce the issue any more.
>>>> Could you please tell more why this patch works?
>>> You might need to ask your CPU design team ;)
>>>
>>> Without this patch, the code in idmap_kpti_install_ng_mappings() sets
>>> bit 11 in table descriptors so that we can keep track of which parts of
>>> the page table we've visited. With this patch, we don't bother tracking
>>> and potentially rewalk parts of the page table (which takes a very long
>>> time if KASAN is enabled).
>> Got it. Thanks!
>>
>>> The architecture documents I've looked at are clear that bit 11 is IGNORED
>>> by the CPU, which:
>>>
>>>    "Indicates that the architecture guarantees that the bit or field is not
>>>     interpreted or modified by hardware."
>>>
>>> Please can you double-check that your CPU is indeed ignoring bit 11 in
>>> non-leaf (table) descriptors?
>> Do the non-leaf(table) descriptors mean the table descriptors
>> of the section D4.3.1 "VMSAv8-64 translation table level 0, level 1, and level 2 descriptor formats"
>> in the ARM Architecture Reference Manual ARMv8 for ARMv8-A(DDI0487C_a_armv8_arm.pdf)?
>>
>> If yes, our hardware does ignore it(not interpret or modify).
> Ok, thanks for checking.
>
>> Is there any other possible reason cause this?
> Perhaps just writing back the table entries is enough to cause the issue,
> although I really can't understand why that would be the case. Can you try
> the diff below (without my previous change), please?

Thanks!
But it does not resolve the issue(only apply this patch based on 4.17.0).
The log is as below:

     estuary:/$ ./qemu-system-aarch64 -machine 
virt,kernel_irqchip=on,gic-version=3
      -cpu host -enable-kvm -smp 1 -m 1024 -kernel ./Image-4.17-joyx 
-initrd
     ../mini-rootfs-arm64.cpio.gz -nographic -append "rdinit=init 
console=ttyAMA0 earlycon=pl011,0x9000000"
     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
     [    0.000000] Linux version 4.17.0-45865-gc58dc48 
(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #14 
SMP PREEMPT Fri Jun 22 18:26:01 CST 2018
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
     [    0.000000] CPU features: detected: Kernel page table isolation 
(KPTI)
     [    0.000000] CPU features: detected: Hardware dirty bit management
     [    0.000000] Built 1 zonelists, mobility grouping on.  Total 
pages: 258048
     [    0.000000] Policy zone: DMA32
     [    0.000000] Kernel command line: rdinit=init console=ttyAMA0 
earlycon=pl011,0x9000000
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
     [    0.000002] sched_clock: 56 bits at 100MHz, resolution 10ns, 
wraps every 4398046511100ns
     [    0.000844] Console: colour dummy device 80x25
     [    0.001406] Calibrating delay loop (skipped), value calculated 
using timer frequency.. 200.00 BogoMIPS (lpj=400000)
     [    0.002458] pid_max: default: 32768 minimum: 301
     [    0.002944] Security Framework initialized
     [    0.003521] Dentry cache hash table entries: 131072 (order: 8, 
1048576 bytes)
     [    0.004322] Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
     [    0.005022] Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.005797] Mountpoint-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.025904] ASID allocator initialised with 32768 entries
     [    0.029913] Hierarchical SRCU implementation.
     [    0.034285] Platform MSI: its domain created
     [    0.034740] PCI/MSI: /intc/its domain created
     [    0.035318] EFI services will not be available.
     [    0.037943] smp: Bringing up secondary CPUs ...
     [    0.038410] smp: Brought up 1 node, 1 CPU
     [    0.038815] SMP: Total of 1 processors activated.
     [    0.039300] CPU features: detected: GIC system register CPU 
interface
     [    0.039946] CPU features: detected: Privileged Access Never
     [    0.040506] CPU features: detected: User Access Override
     [    0.042439] Insufficient stack space to handle exception!
     [    0.042441] ESR: 0x96000046 -- DABT (current EL)
     [    0.043752] FAR: 0xffff0000093a80e0
     [    0.044207] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
     [    0.046511] IRQ stack: [0xffff000008000000..0xffff000008004000]
     [    0.052899] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
     [    0.059396] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45865-gc58dc48 #14
     [    0.067018] Hardware name: linux,dummy-virt (DT)
     [    0.071710] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
     [    0.076532] pc : el1_sync+0x0/0xb0
     [    0.080028] lr : kpti_install_ng_mappings+0x120/0x214
     [    0.085197] sp : ffff0000093a80e0
     [    0.088566] x29: ffff0000093abce0 x28: ffff000008ea9000
     [    0.093979] x27: ffff000008ea9000 x26: ffff0000091f7000
     [    0.099293] x25: ffff00000906d000 x24: ffff000009191000
     [    0.104706] x23: ffff000008ea9000 x22: 0000000041190000
     [    0.110015] x21: ffff0000091f7000 x20: 0000000000000000
     [    0.115428] x19: ffff000009190000 x18: 000000003455d99d
     [    0.120842] x17: 0000000000000001 x16: 00f8000040ffff13
     [    0.126255] x15: 000000007eff6000 x14: 000000007eff6000
     [    0.131566] x13: 00f800007fe00f11 x12: 000000007eff8000
     [    0.136983] x11: 000000007eff8000 x10: 0000000000000000
     [    0.142396] x9 : 000000007eff9000 x8 : 000000007eff9000
     [    0.147704] x7 : 0000000000000000 x6 : 00000000411f8000
     [    0.153116] x5 : 00000000411f8000 x4 : 0000000040a443d4
     [    0.158530] x3 : 00000000411f7000 x2 : 00000000411f7000
     [    0.163943] x1 : ffff00000906d7b0 x0 : ffff80003da61c00
     [    0.169251] Kernel panic - not syncing: kernel stack overflow
     [    0.175140] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45865-gc58dc48 #14
     [    0.182732] Hardware name: linux,dummy-virt (DT)
     [    0.187424] Call trace:
     [    0.189948]  dump_backtrace+0x0/0x180
     [    0.193678]  show_stack+0x14/0x1c
     [    0.197051]  dump_stack+0x90/0xb0
     [    0.200423]  panic+0x138/0x2a0
     [    0.203549]  __stack_chk_fail+0x0/0x18
     [    0.207398]  handle_bad_stack+0x118/0x124
     [    0.211489]  __bad_stack+0x88/0x8c
     [    0.214870]  el1_sync+0x0/0xb0
     [    0.217998] Unable to handle kernel paging request at virtual 
address ffff0000093abce0
     [    0.226061] Mem abort info:
     [    0.228839]   ESR = 0x96000006
     [    0.231965]   Exception class = DABT (current EL), IL = 32 bits
     [    0.237980]   SET = 0, FnV = 0
     [    0.241105]   EA = 0, S1PTW = 0
     [    0.244346] Data abort info:
     [    0.247239]   ISV = 0, ISS = 0x00000006
     [    0.251199]   CM = 0, WnR = 0
     [    0.254209] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)
     [    0.261191] [ffff0000093abce0] pgd=00000000411f8003, 
pud=00000000411f9003, pmd=0000000000000000
     [    0.269982] Internal error: Oops: 96000006 [#1] PREEMPT SMP
     [    0.275538] Modules linked in:
     [    0.278664] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45865-gc58dc48 #14
     [    0.286361] Hardware name: linux,dummy-virt (DT)
     [    0.291053] pstate: 204003c5 (nzCv DAIF +PAN -UAO)
     [    0.295874] pc : unwind_frame+0x28/0xc8
     [    0.299836] lr : dump_backtrace+0x12c/0x180
     [    0.304055] sp : ffff80003efcf000
     [    0.307429] x29: ffff80003efcf000 x28: ffff80003da61c00
     [    0.312841] x27: ffff000008ea9000 x26: ffff0000091f7000
     [    0.318255] x25: ffff00000906d000 x24: ffff0000093a80e0
     [    0.323563] x23: 0000000000000000 x22: ffff000008dbada0
     [    0.328975] x21: 0000000000000000 x20: ffff000009049000
     [    0.334388] x19: ffff80003da61c00 x18: 000000003455d99d
     [    0.339698] x17: 0000000000000001 x16: 00f8000040ffff13
     [    0.345111] x15: 000000007eff6000 x14: 3431232038346364
     [    0.350523] x13: 0000000000000000 x12: cc26f77952f87e00
     [    0.355832] x11: ffffffffffffffff x10: 0000000000000075
     [    0.361245] x9 : ffff0000085ae9e8 x8 : 78302f3078302b63
     [    0.366666] x7 : 6e79735f316c6520 x6 : ffff0000091befe1
     [    0.371976] x5 : 0000000000000000 x4 : ffff0000093ac000
     [    0.377389] x3 : ffff0000093a8000 x2 : ffff0000093abce0
     [    0.382801] x1 : ffff80003efcf048 x0 : ffff80003da61c00
     [    0.388214] Process migration/0 (pid: 12, stack limit = 
0x        (ptrval))
     [    0.395204] Call trace:
     [    0.397726]  unwind_frame+0x28/0xc8
     [    0.401224]  show_stack+0x14/0x1c
     [    0.404699]  dump_stack+0x90/0xb0
     [    0.408070]  panic+0x138/0x2a0
     [    0.411198]  __stack_chk_fail+0x0/0x18
     [    0.414944]  handle_bad_stack+0x118/0x124
     [    0.419035]  __bad_stack+0x88/0x8c
     [    0.422520]  el1_sync+0x0/0xb0
     [    0.425648] Unable to handle kernel paging request at virtual 
address ffff0000093abce0
     [    0.433601] Mem abort info:
     [    0.436486]   ESR = 0x96000006
     [    0.439611]   Exception class = DABT (current EL), IL = 32 bits
     [    0.445626]   SET = 0, FnV = 0
     [    0.448754]   EA = 0, S1PTW = 0
     [    0.451995] Data abort info:
     [    0.454888]   ISV = 0, ISS = 0x00000006
     [    0.458849]   CM = 0, WnR = 0
     [    0.461860] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)
     [    0.468843] [ffff0000093abce0] pgd=00000000411f8003, 
pud=00000000411f9003, pmd=0000000000000000


> Will
>
> --->8
>
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 5f9a73a4452c..e2a8e88f95a0 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -216,7 +216,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
>   	.endm
>   
>   	.macro __idmap_kpti_put_pgtable_ent_ng, type
> -	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
> +	eor	\type, \type, #PTE_NG		// Same bit for blocks and pages
>   	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
>   	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
>   	.endm
> @@ -298,6 +298,7 @@ skip_pgd:
>   	/* PUD */
>   walk_puds:
>   	.if CONFIG_PGTABLE_LEVELS > 3
> +	eor	pgd, pgd, #PTE_NG
>   	pte_to_phys	cur_pudp, pgd
>   	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
>   do_pud:	__idmap_kpti_get_pgtable_ent	pud
> @@ -319,6 +320,7 @@ next_pud:
>   	/* PMD */
>   walk_pmds:
>   	.if CONFIG_PGTABLE_LEVELS > 2
> +	eor	pud, pud, #PTE_NG
>   	pte_to_phys	cur_pmdp, pud
>   	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
>   do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
> @@ -339,6 +341,7 @@ next_pmd:
>   
>   	/* PTE */
>   walk_ptes:
> +	eor	pmd, pmd, #PTE_NG
>   	pte_to_phys	cur_ptep, pmd
>   	add	end_ptep, cur_ptep, #(PTRS_PER_PTE * 8)
>   do_pte:	__idmap_kpti_get_pgtable_ent	pte
>
> .
>


