Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CEFC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC4920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC4920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754322AbeFTQZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:25:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49990 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754110AbeFTQZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:25:18 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 159C1D0B92342;
        Thu, 21 Jun 2018 00:25:15 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Thu, 21 Jun 2018
 00:25:06 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     James Morse <james.morse@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
CC:     Will Deacon <will.deacon@arm.com>, <catalin.marinas@arm.com>,
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
        <libeijian@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B2A7FE1.5040607@hisilicon.com>
Date:   Thu, 21 Jun 2018 00:25:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2018/6/20 23:54, James Morse wrote:
> Hi Wei,
>
> On 20/06/18 16:52, Wei Xu wrote:
>> On 2018/6/20 22:42, Will Deacon wrote:
>>> Hmm, I wonder if this is at all related to RAS, since we've just enabled
>>> that and if we take a fault whilst rewriting swapper then we're going to
>>> get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?
>> I will try it now.
> It's not just the Kconfig symbol, could you also revert:
>
> f751daa4f9d3 ("arm64: Unconditionally enable IESB on exception entry/return for
> firmware-first")
>
>
> (reverts and build cleanly on 4.17)

Thanks to point out this!
I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
But I still got the stack overflow issue sometimes.
Do you have more hint?
Thanks!

The log is as below:
     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
     [    0.000000] Linux version 4.17.0-45865-g2b31fe7-dirty 
(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #10 
SMP PREEMPT Wed Jun 20 23:59:05 CST 2018
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
     [    0.000001] sched_clock: 56 bits at 100MHz, resolution 10ns, 
wraps every 4398046511100ns
     [    0.000843] Console: colour dummy device 80x25
     [    0.001401] Calibrating delay loop (skipped), value calculated 
using timer frequency.. 200.00 BogoMIPS (lpj=400000)
     [    0.002453] pid_max: default: 32768 minimum: 301
     [    0.002941] Security Framework initialized
     [    0.003517] Dentry cache hash table entries: 131072 (order: 8, 
1048576 bytes)
     [    0.004317] Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
     [    0.005018] Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.005791] Mountpoint-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.025893] ASID allocator initialised with 32768 entries
     [    0.029901] Hierarchical SRCU implementation.
     [    0.034274] Platform MSI: its domain created
     [    0.034749] PCI/MSI: /intc/its domain created
     [    0.035317] EFI services will not be available.
     [    0.037930] smp: Bringing up secondary CPUs ...
     [    0.038396] smp: Brought up 1 node, 1 CPU
     [    0.038810] SMP: Total of 1 processors activated.
     [    0.039285] CPU features: detected: GIC system register CPU 
interface
     [    0.039930] CPU features: detected: Privileged Access Never
     [    0.040488] CPU features: detected: User Access Override
     [    0.042421] Insufficient stack space to handle exception!
     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
     [    0.043730] FAR: 0xffff0000093a80e0
     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45865-g2b31fe7-dirty #10
     [    0.072201] Hardware name: linux,dummy-virt (DT)
     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
     [    0.081727] pc : el1_sync+0x0/0xb0
     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
     [    0.090284] sp : ffff0000093a80e0
     [    0.093654] x29: ffff0000093abce0 x28: ffff000008ea9000
     [    0.099071] x27: ffff000008ea9000 x26: ffff0000091f7000
     [    0.104488] x25: ffff00000906d000 x24: ffff000009191000
     [    0.109798] x23: ffff000008ea9000 x22: 0000000041190000
     [    0.115217] x21: ffff0000091f7000 x20: 0000000000000000
     [    0.120633] x19: ffff000009190000 x18: 000000003455d99d
     [    0.125943] x17: 0000000000000001 x16: 00f8000040ffff13
     [    0.131358] x15: 000000007eff6000 x14: 000000007eff6000
     [    0.136773] x13: 00f800007fe00f11 x12: 000000007eff8000
     [    0.142082] x11: 000000007eff8000 x10: 0000000000000000
     [    0.147501] x9 : 000000007eff9000 x8 : 000000007eff9000
     [    0.152920] x7 : 0000000000000000 x6 : 00000000411f8000
     [    0.158230] x5 : 00000000411f8000 x4 : 0000000040a443d4
     [    0.163646] x3 : 00000000411f7000 x2 : 00000000411f7000
     [    0.169061] x1 : ffff00000906d7b0 x0 : ffff80003da61c00
     [    0.174372] Kernel panic - not syncing: kernel stack overflow
     [    0.180264] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45865-g2b31fe7-dirty #10
     [    0.188348] Hardware name: linux,dummy-virt (DT)
     [    0.193046] Call trace:
     [    0.195572]  dump_backtrace+0x0/0x180
     [    0.199304]  show_stack+0x14/0x1c
     [    0.202677]  dump_stack+0x90/0xb0
     [    0.206152]  panic+0x138/0x2a0
     [    0.209182]  __stack_chk_fail+0x0/0x18
     [    0.213029]  handle_bad_stack+0x118/0x124
     [    0.217120]  __bad_stack+0x88/0x8c
     [    0.220607]  el1_sync+0x0/0xb0
     [    0.223738] Unable to handle kernel paging request at virtual 
address ffff0000093abce0
     [    0.231704] Mem abort info:
     [    0.234586]   ESR = 0x96000006
     [    0.237714]   Exception class = DABT (current EL), IL = 32 bits
     [    0.243628]   SET = 0, FnV = 0
     [    0.246758]   EA = 0, S1PTW = 0
     [    0.250001] Data abort info:
     [    0.253000]   ISV = 0, ISS = 0x00000006
     [    0.256859]   CM = 0, WnR = 0
     [    0.259871] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)
     [    0.266862] [ffff0000093abce0] pgd=00000000411f8803, 
pud=00000000411f9803, pmd=0000000000000000
     [    0.275659] Internal error: Oops: 96000006 [#1] PREEMPT SMP
     [    0.281213] Modules linked in:
     [    0.284447] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45865-g2b31fe7-dirty #10
     [    0.292534] Hardware name: linux,dummy-virt (DT)
     [    0.297229] pstate: 204003c5 (nzCv DAIF +PAN -UAO)
     [    0.302053] pc : unwind_frame+0x28/0xc8
     [    0.306022] lr : dump_backtrace+0x12c/0x180
     [    0.310245] sp : ffff80003efcf000
     [    0.313616] x29: ffff80003efcf000 x28: ffff80003da61c00
     [    0.319033] x27: ffff000008ea9000 x26: ffff0000091f7000
     [    0.324348] x25: ffff00000906d000 x24: ffff0000093a80e0
     [    0.329764] x23: 0000000000000000 x22: ffff000008dbae28
     [    0.335179] x21: 0000000000000000 x20: ffff000009049000
     [    0.340488] x19: ffff80003da61c00 x18: 000000003455d99d
     [    0.345906] x17: 0000000000000001 x16: 00f8000040ffff13
     [    0.351322] x15: 000000007eff6000 x14: 3031232079747269
     [    0.356633] x13: 0000000000000000 x12: cc26f77952f87e00
     [    0.362046] x11: ffffffffffffffff x10: 0000000000000076
     [    0.367466] x9 : ffff0000085aea28 x8 : ffff80003efcec90
     [    0.372880] x7 : 0000000000000000 x6 : ffff0000091befe1
     [    0.378190] x5 : 0000000000000000 x4 : ffff0000093ac000
     [    0.383605] x3 : ffff0000093a8000 x2 : ffff0000093abce0
     [    0.389021] x1 : ffff80003efcf048 x0 : ffff80003da61c00
     [    0.394330] Process migration/0 (pid: 12, stack limit = 
0x        (ptrval))
     [    0.401427] Call trace:
     [    0.403852]  unwind_frame+0x28/0xc8
     [    0.407455]  show_stack+0x14/0x1c
     [    0.410828]  dump_stack+0x90/0xb0
     [    0.414201]  panic+0x138/0x2a0
     [    0.417329]  __stack_chk_fail+0x0/0x18
     [    0.421177]  handle_bad_stack+0x118/0x124
     [    0.425273]  __bad_stack+0x88/0x8c
     [    0.428762]  el1_sync+0x0/0xb0
     [    0.431891] Unable to handle kernel paging request at virtual 
address ffff0000093abce0
     [    0.439851] Mem abort info:
     [    0.442734]   ESR = 0x96000006
     [    0.445861]   Exception class = DABT (current EL), IL = 32 bits
     [    0.451774]   SET = 0, FnV = 0
     [    0.454900]   EA = 0, S1PTW = 0
     [    0.458142] Data abort info:
     [    0.461144]   ISV = 0, ISS = 0x00000006
     [    0.465001]   CM = 0, WnR = 0
     [    0.468013] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)
     [    0.474996] [ffff0000093abce0] pgd=00000000411f8803, 
pud=00000000411f9803, pmd=0000000000000000

Best Regards,
Wei

>
> Thanks,
>
> James
>
> .
>

