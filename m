Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2CCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A990926E75
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A990926E75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeFZRQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:16:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49904 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751171AbeFZRQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:16:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D5D59D24FC115;
        Wed, 27 Jun 2018 01:16:50 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 27 Jun 2018
 01:16:44 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com>
CC:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, <suzuki.poulose@arm.com>,
        <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B3274FC.7000206@hisilicon.com>
Date:   Wed, 27 Jun 2018 01:16:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5B2B6DEA.2090100@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018/6/21 17:20, Wei Xu wrote:
> Hi James,
>
> On 2018/6/21 9:38, James Morse wrote:
>> Hi Will, Wei,
>>
>> On 20/06/18 17:25, Wei Xu wrote:
>>> On 2018/6/20 23:54, James Morse wrote:
>>> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
>>> But I still got the stack overflow issue sometimes.
>>> Do you have more hint?
>>> The log is as below:
>>>      [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>>      [    0.000000] Linux version 4.17.0-45865-g2b31fe7-dirty
>> Could you reproduce this with v4.17? This says there are ~45,000 extra patches,
>> and un-committed changes. None of the hashes so far have been commits in
>> mainline, so we have no idea what this tree is.
>>
> I have tried v4.17 and log is as below and also it can be found in the first mail
> of this thread.
>
> 	[ 0.000000] Linux version 4.17.0-45864-g29dcea8-dirty
> 	(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
> 	linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #6 SMP PREEMPT Fri Jun
> 	15 21:39:52 CST 2018
>
> I will try v4.17.2 and v4.18-rc1.
>
>>> (joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
>>> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #10 SMP PREEMPT Wed Jun 20
>>> 23:59:05 CST 2018
>>>      [    0.000000] CPU0: using LPI pending table @0x000000007d860000
>>>      [    0.000000] GIC: PPI11 is secure or misconfigured
>>>      [    0.000000] arch_timer: WARNING: Invalid trigger for IRQ3, assuming level
>>> low
>>>      [    0.000000] arch_timer: WARNING: Please fix your firmware
>>>      [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
>> (No idea what these mean, but I doubt they are relevant)
>>
> I will try with mainline qemu 2.12.0.
>
> Thanks!

Today I tried the kernel 4.18-rc2(defconfig, no change on top) with qemu 
2.12.0.
The guest sometimes still failed to boot. But the crash reason is different.
Could you please share any hint?
Thanks!

The guest boot log is as below:
===========================

     estuary:/$ ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-v
     ersion=3 -cpu host -enable-kvm -smp 1 -m 1024 -kernel 
./Image-4.18-joyx -initrd
     ../mini-rootfs-arm64.cpio.gz -nographic -append "rdinit=init 
console=ttyAMA0 ear
     lycon=pl011,0x9000000"

     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
     [    0.000000] Linux version 4.18.0-rc2-58583-g7daf201-dirty 
(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #20 
SMP PREEMPT Tue Jun 26 23:43:35 CST 2018
     [    0.000000] Machine model: linux,dummy-virt
     [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
     [    0.000000] bootconsole [pl11] enabled
     [    0.000000] efi: Getting EFI parameters from FDT:
     [    0.000000] efi: UEFI not found.
     [    0.000000] cma: Reserved 32 MiB at 0x000000007e000000
     [    0.000000] NUMA: No NUMA configuration found
     [    0.000000] NUMA: Faking a node at [mem 
0x0000000000000000-0x000000007fffffff]
     [    0.000000] NUMA: NODE_DATA [mem 0x7dfe9a00-0x7dfeb1bf]
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
     [    0.000000] percpu: Embedded 23 pages/cpu @(____ptrval____) 
s56064 r8192 d29952 u94208
     [    0.000000] Detected VIPT I-cache on CPU0
     [    0.000000] CPU features: detected: Kernel page table isolation 
(KPTI)
     [    0.000000] CPU features: detected: Hardware dirty bit management
     [    0.000000] Built 1 zonelists, mobility grouping on.  Total 
pages: 258048
     [    0.000000] Policy zone: DMA32
     [    0.000000] Kernel command line: rdinit=init console=ttyAMA0 
earlycon=pl011,0x9000000
     [    0.000000] Memory: 951780K/1048576K available (10172K kernel 
code, 1362K rwdata, 4956K rodata, 1216K init, 392K bss, 64028K reserved, 
32768K cma-reserved)
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
@7c830000 (indirect, esz 8, psz 64K, shr 1)
     [    0.000000] ITS@0x0000000008080000: allocated 8192 Interrupt 
Collections @7c840000 (flat, esz 8, psz 64K, shr 1)
     [    0.000000] GIC: using LPI property table @0x000000007c850000
     [    0.000000] ITS: Allocated 1792 chunks for LPIs
     [    0.000000] GICv3: CPU0: found redistributor 0 region 
0:0x00000000080a0000
     [    0.000000] CPU0: using LPI pending table @0x000000007c860000
     [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
     [    0.000000] clocksource: arch_sys_counter: mask: 
0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
     [    0.000001] sched_clock: 56 bits at 100MHz, resolution 10ns, 
wraps every 4398046511100ns
     [    0.000828] Console: colour dummy device 80x25
     [    0.001279] Calibrating delay loop (skipped), value calculated 
using timer frequency.. 200.00 BogoMIPS (lpj=400000)
     [    0.002307] pid_max: default: 32768 minimum: 301
     [    0.002925] Security Framework initialized
     [    0.003494] Dentry cache hash table entries: 131072 (order: 8, 
1048576 bytes)
     [    0.004277] Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
     [    0.004968] Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.005628] Mountpoint-cache hash table entries: 2048 (order: 2, 
16384 bytes)
     [    0.031117] ASID allocator initialised with 32768 entries
     [    0.035124] Hierarchical SRCU implementation.
     [    0.039492] Platform MSI: its domain created
     [    0.039934] PCI/MSI: /intc/its domain created
     [    0.040509] EFI services will not be available.
     [    0.043153] smp: Bringing up secondary CPUs ...
     [    0.043606] smp: Brought up 1 node, 1 CPU
     [    0.044000] SMP: Total of 1 processors activated.
     [    0.044464] CPU features: detected: GIC system register CPU 
interface
     [    0.045112] CPU features: detected: Privileged Access Never
     [    0.045658] CPU features: detected: User Access Override
     [    0.046177] CPU features: detected: RAS Extension Support
     [    0.048119] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000288
     [    0.048991] Mem abort info:
     [    0.049267]   ESR = 0x96000004
     [    0.049567]   Exception class = DABT (current EL), IL = 32 bits
     [    0.050146]   SET = 0, FnV = 0
     [    0.050446]   EA = 0, S1PTW = 0
     [    0.050754] Data abort info:
     [    0.051038]   ISV = 0, ISS = 0x00000004
     [    0.051921]   CM = 0, WnR = 0
     [    0.054936] [0000000000000288] user address but active_mm is swapper
     [    0.061427] Internal error: Oops: 96000004 [#1] PREEMPT SMP
     [    0.067080] Modules linked in:
     [    0.070206] CPU: 0 PID: 13 Comm: migration/0 Not tainted 
4.18.0-rc2-58583-g7daf201-dirty #20
     [    0.078745] Hardware name: linux,dummy-virt (DT)
     [    0.083433] pstate: 60400085 (nZCv daIf +PAN -UAO)
     [    0.088258] pc : kpti_install_ng_mappings+0x154/0x214
     [    0.093319] lr : kpti_install_ng_mappings+0x120/0x214
     [    0.098483] sp : ffff0000093fbce0
     [    0.101854] x29: ffff0000093fbce0 x28: ffff000008ee5000
     [    0.107263] x27: ffff000008ee5000 x26: ffff00000923b000
     [    0.112568] x25: ffff0000090ac000 x24: ffff0000091d9000
     [    0.117983] x23: ffff000008ee5000 x22: 00000000411d8000
     [    0.123392] x21: ffff00000923b000 x20: 0000000000000000
     [    0.128801] x19: ffff0000091d8000 x18: 000000003455d99d
     [    0.134209] x17: 0000000000000001 x16: 00f8000040ffff13
     [    0.139513] x15: 000000007dff5000 x14: 000000007dff5000
     [    0.144920] x13: 00f800007fe00f11 x12: 000000007dff7000
     [    0.150329] x11: 000000007dff7000 x10: 0000000000000000
     [    0.155633] x9 : 000000007dff8000 x8 : 000000007dff8000
     [    0.161042] x7 : 0000000000000000 x6 : 000000004123c000
     [    0.166451] x5 : 000000004123c000 x4 : 0000000040a5f3d4
     [    0.171860] x3 : 0000000000000000 x2 : 000000004123b000
     [    0.177163] x1 : ffff0000090acd88 x0 : ffff80003ca627c0
     [    0.182577] Process migration/0 (pid: 13, stack limit = 
0x(____ptrval____))
     [    0.189561] Call trace:
     [    0.192081]  kpti_install_ng_mappings+0x154/0x214
     [    0.196892] Code: d503201f d503379f d5033fdf f94033a3 (f9414460)
     [    0.203029] ---[ end trace 3ca968ef0a151b33 ]---
     [    0.207722] note: migration/0[13] exited with preempt_count 1
     [    0.213610] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000000
     [    0.222393] Mem abort info:
     [    0.225273]   ESR = 0x86000004
     [    0.228396]   Exception class = IABT (current EL), IL = 32 bits
     [    0.234405]   SET = 0, FnV = 0
     [    0.237527]   EA = 0, S1PTW = 0
     [    0.240769] [0000000000000000] user address but active_mm is swapper
     [    0.247149] Internal error: Oops: 86000004 [#2] PREEMPT SMP
     [    0.252797] Modules linked in:
     [    0.255922] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G D           
4.18.0-rc2-58583-g7daf201-dirty #20
     [    0.265549] Hardware name: linux,dummy-virt (DT)
     [    0.270235] pstate: 60400085 (nZCv daIf +PAN -UAO)
     [    0.275155] pc :           (null)
     [    0.278520] lr :           (null)
     [    0.281886] sp : ffff00000802bb10
     [    0.285257] x29: 0000000000000000 x28: 0000000000000080
     [    0.290664] x27: ffff000008a82000 x26: ffff000008a52134
     [    0.296073] x25: ffff000009089000 x24: ffff80003ca30570
     [    0.301381] x23: ffff000009064000 x22: ffff0000090acd88
     [    0.306789] x21: ffff80003ca30000 x20: 0000000000000000
     [    0.312196] x19: 0000000000000000 x18: 000000000000000e
     [    0.317503] x17: 0000000000000001 x16: 0000000000000019
     [    0.322910] x15: 0000000000000033 x14: 000000000000004c
     [    0.328317] x13: 0000000000000068 x12: ffff0000093fb7f8
     [    0.333725] x11: 0000000000000108 x10: 0000000000000940
     [    0.339028] x9 : ffff00000802baf0 x8 : ffff80003ca309a0
     [    0.344434] x7 : 0000000000000000 x6 : 0000000000000000
     [    0.349842] x5 : 0000000002da3744 x4 : 0000000000000080
     [    0.355250] x3 : 0000000000000008 x2 : 0000800034f69000
     [    0.360554] x1 : ffff80003ca30000 x0 : ffff80003ca627c0
     [    0.365959] Process swapper/0 (pid: 1, stack limit = 
0x(____ptrval____))
     [    0.372801] Call trace:
     [    0.375322] Code: bad PC value
     [    0.378347] ---[ end trace 3ca968ef0a151b34 ]---


The faddr2line result is as :
========================

     ./scripts/faddr2line ../kernel-dev.build/vmlinux 
kpti_install_ng_mappings+0x150/0x214
     kpti_install_ng_mappings+0x150/0x214:
     __cpu_set_tcr_t0sz at arch/arm64/include/asm/mmu_context.h:94
     (inlined by) cpu_uninstall_idmap at 
arch/arm64/include/asm/mmu_context.h:125
     (inlined by) kpti_install_ng_mappings at 
arch/arm64/kernel/cpufeature.c:921


The assembler of kpti_install_ng_mappings is as:
=============================================

     Dump of assembler code for function kpti_install_ng_mappings:
        0xffff000008091f7c <+0>:     stp     x29, x30, [sp,#-112]!
        0xffff000008091f80 <+4>:     adrp    x0, 0xffff000009064000 
<bp_hardening_data>
        0xffff000008091f84 <+8>:     mov     x29, sp
        0xffff000008091f88 <+12>:    stp     x23, x24, [sp,#48]
        0xffff000008091f8c <+16>:    adrp    x24, 0xffff0000091d9000 
<reset_devices>
        0xffff000008091f90 <+20>:    add     x0, x0, #0x18
        0xffff000008091f94 <+24>:    add     x1, x24, #0x550
        0xffff000008091f98 <+28>:    stp     x19, x20, [sp,#16]
        0xffff000008091f9c <+32>:    stp     x21, x22, [sp,#32]
        0xffff000008091fa0 <+36>:    stp     x25, x26, [sp,#64]
        0xffff000008091fa4 <+40>:    stp     x27, x28, [sp,#80]
        0xffff000008091fa8 <+44>:    mrs     x2, tpidr_el1
        0xffff000008091fac <+48>:    ldrb    w1, [x1,#8]
        0xffff000008091fb0 <+52>:    ldr     w20, [x2,x0]
        0xffff000008091fb4 <+56>:    cbnz    w1, 0xffff00000809212c 
<kpti_install_ng_mappings+432>
        0xffff000008091fb8 <+60>:    adrp    x27, 0xffff000008ee5000 
<sve_vq_map+32>
        0xffff000008091fbc <+64>:    adrp    x19, 0xffff0000091d8000 
<empty_zero_page>
        0xffff000008091fc0 <+68>:    add     x19, x19, #0x0
        0xffff000008091fc4 <+72>:    adrp    x1, 0xffff000008a5f000 
<kimage_vaddr>
        0xffff000008091fc8 <+76>:    mov     x0, x19
        0xffff000008091fcc <+80>:    add     x1, x1, #0x3d8
        0xffff000008091fd0 <+84>:    ldr     x2, [x27,#1176]
        0xffff000008091fd4 <+88>:    sub     x4, x1, x2
        0xffff000008091fd8 <+92>:    sub     x0, x0, x2
        0xffff000008091fdc <+96>:    msr     ttbr0_el1, x0
        0xffff000008091fe0 <+100>:   isb
        0xffff000008091fe4 <+104>:   dsb     nshst
        0xffff000008091fe8 <+108>:   tlbi    vmalle1
        0xffff000008091fec <+112>:   nop
        0xffff000008091ff0 <+116>:   nop
        0xffff000008091ff4 <+120>:   dsb     nsh
        0xffff000008091ff8 <+124>:   isb
        0xffff000008091ffc <+128>:   adrp    x3, 0xffff000009096000 
<early_node_cpu_hwid+1440>
        0xffff000008092000 <+132>:   ldr     x0, [x3,#648]
        0xffff000008092004 <+136>:   cmp     x0, #0x10
        0xffff000008092008 <+140>:   b.ne    0xffff000008092178 
<kpti_install_ng_mappings+508>
        0xffff00000809200c <+144>:   adrp    x28, 0xffff000008ee5000 
<sve_vq_map+32>
        0xffff000008092010 <+148>:   ldr     x2, [x27,#1176]
        0xffff000008092014 <+152>:   adrp    x1, 0xffff000009237000
        0xffff000008092018 <+156>:   adrp    x26, 0xffff00000923b000
        0xffff00000809201c <+160>:   add     x1, x1, #0x0
        0xffff000008092020 <+164>:   add     x21, x26, #0x0
        0xffff000008092024 <+168>:   ldr     x0, [x28,#1160]
        0xffff000008092028 <+172>:   adrp    x23, 0xffff000008ee5000 
<sve_vq_map+32>
        0xffff00000809202c <+176>:   sub     x1, x1, x2
        0xffff000008092030 <+180>:   sub     x1, x1, x0
        0xffff000008092034 <+184>:   orr     x0, x1, #0xffff800000000000
        0xffff000008092038 <+188>:   cmp     x0, x21
        0xffff00000809203c <+192>:   b.eq    0xffff000008092174 
<kpti_install_ng_mappings+504>
        0xffff000008092040 <+196>:   mov     x22, x19
        0xffff000008092044 <+200>:   str     x3, [x29,#96]
        0xffff000008092048 <+204>:   str     x4, [x29,#104]
        0xffff00000809204c <+208>:   sub     x2, x22, x2
        0xffff000008092050 <+212>:   msr     ttbr0_el1, x2
        0xffff000008092054 <+216>:   isb
        0xffff000008092058 <+220>:   ldr     x0, [x28,#1160]
     ---Type <return> to continue, or q <return> to quit---
        0xffff00000809205c <+224>:   and     x1, x1, #0x7fffffffffff
        0xffff000008092060 <+228>:   adrp    x25, 0xffff0000090ac000 
<perf_cpu_clock+200>
        0xffff000008092064 <+232>:   add     x0, x1, x0
        0xffff000008092068 <+236>:   add     x1, x25, #0xd88
        0xffff00000809206c <+240>:   bl      0xffff0000080a0750 
<cpu_do_switch_mm>
        0xffff000008092070 <+244>:   adrp    x0, 0xffff000009089000 
<page_wait_table+5376>
        0xffff000008092074 <+248>:   mov     w1, 
#0x80                       // #128
        0xffff000008092078 <+252>:   add     x0, x0, #0xb48
        0xffff00000809207c <+256>:   bl      0xffff0000083e8144 
<__bitmap_weight>
        0xffff000008092080 <+260>:   mov     w1, w0
        0xffff000008092084 <+264>:   ldr     x5, [x23,#1176]
        0xffff000008092088 <+268>:   mov     w0, w20
        0xffff00000809208c <+272>:   ldr     x4, [x29,#104]
        0xffff000008092090 <+276>:   mov     x2, x21
        0xffff000008092094 <+280>:   sub     x2, x2, x5
        0xffff000008092098 <+284>:   blr     x4
        0xffff00000809209c <+288>:   ldr     x1, [x23,#1176]
        0xffff0000080920a0 <+292>:   mrs     x0, sp_el0
        0xffff0000080920a4 <+296>:   sub     x22, x22, x1
        0xffff0000080920a8 <+300>:   ldr     x1, [x0,#936]
        0xffff0000080920ac <+304>:   msr     ttbr0_el1, x22
        0xffff0000080920b0 <+308>:   isb
        0xffff0000080920b4 <+312>:   dsb     nshst
        0xffff0000080920b8 <+316>:   tlbi    vmalle1
        0xffff0000080920bc <+320>:   nop
        0xffff0000080920c0 <+324>:   nop
        0xffff0000080920c4 <+328>:   dsb     nsh
        0xffff0000080920c8 <+332>:   isb
        0xffff0000080920cc <+336>:   ldr     x3, [x29,#96]
        0xffff0000080920d0 <+340>:   ldr     x0, [x3,#648]
        0xffff0000080920d4 <+344>:   cmp     x0, #0x10
        0xffff0000080920d8 <+348>:   b.ne    0xffff00000809215c 
<kpti_install_ng_mappings+480>
        0xffff0000080920dc <+352>:   add     x25, x25, #0xd88
        0xffff0000080920e0 <+356>:   cmp     x1, x25
        0xffff0000080920e4 <+360>:   b.eq    0xffff00000809211c 
<kpti_install_ng_mappings+416>
        0xffff0000080920e8 <+364>:   ldr     x2, [x1,#64]
        0xffff0000080920ec <+368>:   add     x26, x26, #0x0
        0xffff0000080920f0 <+372>:   cmp     x2, x26
        0xffff0000080920f4 <+376>:   b.eq    0xffff000008092174 
<kpti_install_ng_mappings+504>
        0xffff0000080920f8 <+380>:   ldr     x0, [x27,#1176]
        0xffff0000080920fc <+384>:   sub     x19, x19, x0
        0xffff000008092100 <+388>:   msr     ttbr0_el1, x19
        0xffff000008092104 <+392>:   isb
        0xffff000008092108 <+396>:   tbz     x2, #47, 0xffff000008092148 
<kpti_install_ng_mappings+460>
        0xffff00000809210c <+400>:   ldr     x0, [x28,#1160]
        0xffff000008092110 <+404>:   and     x2, x2, #0x7fffffffffff
        0xffff000008092114 <+408>:   add     x0, x2, x0
        0xffff000008092118 <+412>:   bl      0xffff0000080a0750 
<cpu_do_switch_mm>
        0xffff00000809211c <+416>:   cbnz    w20, 0xffff00000809212c 
<kpti_install_ng_mappings+432>
        0xffff000008092120 <+420>:   add     x24, x24, #0x550
        0xffff000008092124 <+424>:   mov     w0, 
#0x1                        // #1
        0xffff000008092128 <+428>:   strb    w0, [x24,#8]
        0xffff00000809212c <+432>:   ldp     x19, x20, [sp,#16]
        0xffff000008092130 <+436>:   ldp     x21, x22, [sp,#32]
        0xffff000008092134 <+440>:   ldp     x23, x24, [sp,#48]
        0xffff000008092138 <+444>:   ldp     x25, x26, [sp,#64]
        0xffff00000809213c <+448>:   ldp     x27, x28, [sp,#80]
     ---Type <return> to continue, or q <return> to quit---
        0xffff000008092140 <+452>:   ldp     x29, x30, [sp],#112
        0xffff000008092144 <+456>:   ret
        0xffff000008092148 <+460>:   adrp    x0, 0xffff000008ee5000 
<sve_vq_map+32>
        0xffff00000809214c <+464>:   ldr     x0, [x0,#1176]
        0xffff000008092150 <+468>:   sub     x0, x2, x0
        0xffff000008092154 <+472>:   bl      0xffff0000080a0750 
<cpu_do_switch_mm>
        0xffff000008092158 <+476>:   b       0xffff00000809211c 
<kpti_install_ng_mappings+416>
        0xffff00000809215c <+480>:   mrs     x0, tcr_el1
        0xffff000008092160 <+484>:   and     x0, x0, #0xffffffffffffffc0
        0xffff000008092164 <+488>:   orr     x0, x0, #0x10
        0xffff000008092168 <+492>:   msr     tcr_el1, x0
        0xffff00000809216c <+496>:   isb
        0xffff000008092170 <+500>:   b       0xffff0000080920dc 
<kpti_install_ng_mappings+352>
        0xffff000008092174 <+504>:   brk     #0x800
        0xffff000008092178 <+508>:   mrs     x1, tcr_el1
        0xffff00000809217c <+512>:   and     x1, x1, #0xffffffffffffffc0
        0xffff000008092180 <+516>:   orr     x0, x1, x0
        0xffff000008092184 <+520>:   msr     tcr_el1, x0
        0xffff000008092188 <+524>:   isb
        0xffff00000809218c <+528>:   b       0xffff00000809200c 
<kpti_install_ng_mappings+144>
     End of assembler dump.


Best Regards,
Wei

