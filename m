Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6479B20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6479B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeFTOS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:18:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55310 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754136AbeFTOS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:18:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD7AEED5893EE;
        Wed, 20 Jun 2018 22:18:18 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Wed, 20 Jun 2018
 22:18:11 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
Subject: KVM guest sometimes failed to boot because of kernel stack overflow
 if KPTI is enabled on a hisilicon ARM64 platform.
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <suzuki.poulose@arm.com>, <dave.martin@arm.com>,
        <mark.rutland@arm.com>, <james.morse@arm.com>,
        <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>,
        "Chenxin (Charles)" <charles.chenxin@huawei.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        <jonathan.cameron@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>
Message-ID: <5B2A6218.3030201@hisilicon.com>
Date:   Wed, 20 Jun 2018 22:18:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have observed KVM guest sometimes failed to boot because of kernel stack
overflow if KPTI is enabled on a hisilicon arm64 platform.

We also tested with different kernel version and found it is only
happened if the KPTI and KVM(enable-kvm & cpu=host) are enabled on the 
guest.
The detail result is as below table.

+---------+----------+--------+------------+-------------------+
      |  host   |host KPTI | guest  | guest KPTI | kvm guest         |
      |  kernel |enabled   | kernel | enabled    | booting result    |
+---------+----------+--------+------------+-------------------+
      |  4.17   |     Y    |  4.17  |     Y      |  stack overflow   |
+---------+----------+--------+------------+-------------------+
      |  4.17   |     Y    |  4.16  |     NA     | OK          |
+---------+----------+--------+------------+-------------------+
      |  4.16   |     NA   |  4.17  |     Y      |  stack overflow   |
+---------+----------+--------+------------+-------------------+
      |  4.16   |     NA   |  4.16  |     NA     | OK          |
+---------+----------+--------+------------+-------------------+

A simple walk-around is adding this platform into the "kpti_safe_list".
But it does not resolve the issue indeed.
Could you please share any hint how to resolve this kind issue?
Thanks!

Another issue we found is "kpti_install_ng_mappings" will be invoked
even "kpti=off" has been added in the kernel command line. Is that expected?
This is because "kpti" is not a *early* param that "init_cpu_features" will
be invoked before parsing the param.

The command we are using to run the guest is as:

     ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3 
-cpu host
     -enable-kvm -smp 1 -m 1024 -kernel ./Image -initrd 
../mini-rootfs-arm64.cpio.gz
     -nographic -append "rdinit=init console=ttyAMA0 
earlycon=pl011,0x9000000"

The log is as below:

         [    0.000000] Booting Linux on physical CPU 0x0000000000 
[0x480fd010]
         [    0.000000] Linux version 4.17.0-45864-g29dcea8-dirty 
(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #6 
SMP PREEMPT Fri Jun 15 21:39:52 CST 2018
         [    0.000000] Machine model: linux,dummy-virt
         [    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 
(options '')
         [    0.000000] bootconsole [pl11] enabled
         [    0.000000] efi: Getting EFI parameters from FDT:
         [    0.000000] efi: UEFI not found.
         [    0.000000] cma: Reserved 16 MiB at 0x000000007f000000
         [    0.000000] NUMA: No NUMA configuration found
         [    0.000000] NUMA: Faking a node at [mem 
0x0000000000000000-0x000000007fffffff]
         [    0.000000] NUMA: NODE_DATA [mem 0x7efeb300-0x7efecdff]
         [    0.000000] Zone ranges:
         [    0.000000]   DMA32    [mem 
0x0000000040000000-0x000000007fffffff]
         [    0.000000]   Normal   empty
         [    0.000000] Movable zone start for each node
         [    0.000000] Early memory node ranges
         [    0.000000]   node   0: [mem 
0x0000000040000000-0x000000007fffffff]
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
         [    0.000000] CPU features: detected: Kernel page table 
isolation (KPTI)
         [    0.000000] CPU features: detected: Hardware dirty bit 
management
         [    0.000000] Built 1 zonelists, mobility grouping on.  Total 
pages: 258048
         [    0.000000] Policy zone: DMA32
         [    0.000000] Kernel command line: rdinit=init console=ttyAMA0 
earlycon=pl011,0x9000000
         [    0.000000] Memory: 968436K/1048576K available (10044K 
kernel code, 1328K rwdata, 4840K rodata, 1216K init, 409K bss, 63756K 
reserved, 16384K cma-reserved)
         [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, 
CPUs=1, Nodes=1
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
         [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz 
(virt).
         [    0.000000] clocksource: arch_sys_counter: mask: 
0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
         [    0.000001] sched_clock: 56 bits at 100MHz, resolution 10ns, 
wraps every 4398046511100ns
         [    0.000854] Console: colour dummy device 80x25
         [    0.001423] Calibrating delay loop (skipped), value 
calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
         [    0.002478] pid_max: default: 32768 minimum: 301
         [    0.002962] Security Framework initialized
         [    0.003541] Dentry cache hash table entries: 131072 (order: 
8, 1048576 bytes)
         [    0.004347] Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
         [    0.005058] Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
         [    0.005844] Mountpoint-cache hash table entries: 2048 
(order: 2, 16384 bytes)
         [    0.025949] ASID allocator initialised with 32768 entries
         [    0.029958] Hierarchical SRCU implementation.
         [    0.034328] Platform MSI: its domain created
         [    0.034787] PCI/MSI: /intc/its domain created
         [    0.035359] EFI services will not be available.
         [    0.037987] smp: Bringing up secondary CPUs ...
         [    0.038454] smp: Brought up 1 node, 1 CPU
         [    0.038859] SMP: Total of 1 processors activated.
         [    0.039338] CPU features: detected: GIC system register CPU 
interface
         [    0.039988] CPU features: detected: Privileged Access Never
         [    0.040560] CPU features: detected: User Access Override
         [    0.041093] CPU features: detected: RAS Extension Support
         [    0.042947] Insufficient stack space to handle exception!
         [    0.042949] ESR: 0x96000046 -- DABT (current EL)
         [    0.043963] FAR: 0xffff0000093a80e0
         [    0.045794] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
         [    0.052181] IRQ stack: [0xffff000008000000..0xffff000008004000]
         [    0.058572] Overflow stack: 
[0xffff80003efce2f0..0xffff80003efcf2f0]
         [    0.065068] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45864-g29dcea8-dirty #6
         [    0.073138] Hardware name: linux,dummy-virt (DT)
         [    0.077831] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
         [    0.082661] pc : el1_sync+0x0/0xb0
         [    0.086152] lr : kpti_install_ng_mappings+0x120/0x214
         [    0.091219] sp : ffff0000093a80e0
         [    0.094589] x29: ffff0000093abce0 x28: ffff000008ea9000
         [    0.100004] x27: ffff000008ea9000 x26: ffff0000091f7000
         [    0.105424] x25: ffff00000906d000 x24: ffff000009191000
         [    0.110733] x23: ffff000008ea9000 x22: 0000000041190000
         [    0.116148] x21: ffff0000091f7000 x20: 0000000000000000
         [    0.121564] x19: ffff000009190000 x18: 000000003455d99d
         [    0.126977] x17: 0000000000000001 x16: 00f8000040ffff13
         [    0.132288] x15: 000000007eff6000 x14: 000000007eff6000
         [    0.137704] x13: 00f800007fe00f11 x12: 000000007eff8000
         [    0.143013] x11: 000000007eff8000 x10: 0000000000000000
         [    0.148426] x9 : 000000007eff9000 x8 : 000000007eff9000
         [    0.153841] x7 : 0000000000000000 x6 : 00000000411f8000
         [    0.159154] x5 : 00000000411f8000 x4 : 0000000040a443d4
         [    0.164567] x3 : 00000000411f7000 x2 : 00000000411f7000
         [    0.169981] x1 : ffff00000906d7b0 x0 : ffff80003da61c00
         [    0.175395] Kernel panic - not syncing: kernel stack overflow
         [    0.181178] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45864-g29dcea8-dirty #6
         [    0.189248] Hardware name: linux,dummy-virt (DT)
         [    0.193945] Call trace:
         [    0.196470]  dump_backtrace+0x0/0x180
         [    0.200201]  show_stack+0x14/0x1c
         [    0.203574]  dump_stack+0x90/0xb0
         [    0.206946]  panic+0x138/0x2a0
         [    0.210075]  __stack_chk_fail+0x0/0x18
         [    0.213922]  handle_bad_stack+0x118/0x124
         [    0.218012]  __bad_stack+0x88/0x8c
         [    0.221393]  el1_sync+0x0/0xb0
         [    0.224520] Unable to handle kernel paging request at 
virtual address ffff0000093abce0
         [    0.232586] Mem abort info:
         [    0.235362]   ESR = 0x96000006
         [    0.238488]   Exception class = DABT (current EL), IL = 32 bits
         [    0.244506]   SET = 0, FnV = 0
         [    0.247632]   EA = 0, S1PTW = 0
         [    0.250873] Data abort info:
         [    0.253765]   ISV = 0, ISS = 0x00000006
         [    0.257725]   CM = 0, WnR = 0
         [    0.260735] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)


Best Regards,
Wei

