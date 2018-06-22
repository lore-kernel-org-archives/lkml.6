Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0879DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907E6242F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 907E6242F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeFVNrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:47:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9119 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbeFVNrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:47:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 022AA1AD1D10F;
        Fri, 22 Jun 2018 21:46:57 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 21:46:52 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
 <20180622133133.GA1802@arm.com>
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
Message-ID: <5B2CFDCD.6040207@hisilicon.com>
Date:   Fri, 22 Jun 2018 21:46:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180622133133.GA1802@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/22 21:31, Will Deacon wrote:
> Hi again, Wei,
>
> On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
>> On 2018/6/22 19:16, Will Deacon wrote:
>>> On Fri, Jun 22, 2018 at 06:45:15PM +0800, Wei Xu wrote:
>>>> On 2018/6/22 17:23, Will Deacon wrote:
>>>>> Perhaps just writing back the table entries is enough to cause the issue,
>>>>> although I really can't understand why that would be the case. Can you try
>>>>> the diff below (without my previous change), please?
>>>> Thanks!
>>>> But it does not resolve the issue(only apply this patch based on 4.17.0).
>>> Thanks, that's a useful data point. It means that it still crashes even if
>>> we write back the same table entries, so it's the fact that we're writing
>>> them at all which causes the problem, not the value that we write.
>>>
>>> Whilst looking at the code, we noticed a missing DMB. On the off-chance
>>> that it helps, can you try this instead please?
>> Thanks!
>> Only apply below patch based on 4.17.0, we still got the crash.
> Oh well, it was worth a shot (and that's still a fix worth having). Please
> can you provide the complete disassembly for kpti_install_ng_mappings()
> (I'm referring to the C function in cpufeature.c) along with a corresponding
> crash log so that we can correlate the instruction stream with the crash?
Just let me know if you need more information.
Thanks!

The disassemble code is as below:
     Dump of assembler code for function kpti_install_ng_mappings:
        0xffff000008091d68 <+0>:     stp     x29, x30, [sp,#-112]!
        0xffff000008091d6c <+4>:     adrp    x0, 0xffff000009022000 
<bp_hardening_data>
        0xffff000008091d70 <+8>:     mov     x29, sp
        0xffff000008091d74 <+12>:    stp     x23, x24, [sp,#48]
        0xffff000008091d78 <+16>:    adrp    x24, 0xffff000009191000 
<reset_devices>
        0xffff000008091d7c <+20>:    add     x0, x0, #0x10
        0xffff000008091d80 <+24>:    add     x1, x24, #0x550
        0xffff000008091d84 <+28>:    stp     x19, x20, [sp,#16]
        0xffff000008091d88 <+32>:    stp     x21, x22, [sp,#32]
        0xffff000008091d8c <+36>:    stp     x25, x26, [sp,#64]
        0xffff000008091d90 <+40>:    stp     x27, x28, [sp,#80]
        0xffff000008091d94 <+44>:    mrs     x2, tpidr_el1
        0xffff000008091d98 <+48>:    ldrb    w1, [x1,#8]
        0xffff000008091d9c <+52>:    ldr     w20, [x2,x0]
        0xffff000008091da0 <+56>:    cbnz    w1, 0xffff000008091f18 
<kpti_install_ng_mappings+432>
        0xffff000008091da4 <+60>:    adrp    x27, 0xffff000008ea9000 
<cpu_ops+384>
        0xffff000008091da8 <+64>:    adrp    x19, 0xffff000009190000 
<empty_zero_page>
        0xffff000008091dac <+68>:    add     x19, x19, #0x0
        0xffff000008091db0 <+72>:    adrp    x1, 0xffff000008a44000 
<kimage_vaddr>
        0xffff000008091db4 <+76>:    mov     x0, x19
        0xffff000008091db8 <+80>:    add     x1, x1, #0x3d8
        0xffff000008091dbc <+84>:    ldr     x2, [x27,#672]
        0xffff000008091dc0 <+88>:    sub     x4, x1, x2
        0xffff000008091dc4 <+92>:    sub     x0, x0, x2
        0xffff000008091dc8 <+96>:    msr     ttbr0_el1, x0
        0xffff000008091dcc <+100>:   isb
        0xffff000008091dd0 <+104>:   dsb     nshst
        0xffff000008091dd4 <+108>:   tlbi    vmalle1
        0xffff000008091dd8 <+112>:   nop
        0xffff000008091ddc <+116>:   nop
        0xffff000008091de0 <+120>:   dsb     nsh
        0xffff000008091de4 <+124>:   isb
        0xffff000008091de8 <+128>:   adrp    x3, 0xffff000009056000 
<armv8_event_attr_sw_incr+8>
        0xffff000008091dec <+132>:   ldr     x0, [x3,#2248]
        0xffff000008091df0 <+136>:   cmp     x0, #0x10
        0xffff000008091df4 <+140>:   b.ne    0xffff000008091f64 
<kpti_install_ng_mappings+508>
        0xffff000008091df8 <+144>:   adrp    x28, 0xffff000008ea9000 
<cpu_ops+384>
        0xffff000008091dfc <+148>:   ldr     x2, [x27,#672]
        0xffff000008091e00 <+152>:   adrp    x1, 0xffff0000091f3000
        0xffff000008091e04 <+156>:   adrp    x26, 0xffff0000091f7000
        0xffff000008091e08 <+160>:   add     x1, x1, #0x0
        0xffff000008091e0c <+164>:   add     x21, x26, #0x0
        0xffff000008091e10 <+168>:   ldr     x0, [x28,#656]
        0xffff000008091e14 <+172>:   adrp    x23, 0xffff000008ea9000 
<cpu_ops+384>
        0xffff000008091e18 <+176>:   sub     x1, x1, x2
        0xffff000008091e1c <+180>:   sub     x1, x1, x0
        0xffff000008091e20 <+184>:   orr     x0, x1, #0xffff800000000000
        0xffff000008091e24 <+188>:   cmp     x0, x21
        0xffff000008091e28 <+192>:   b.eq    0xffff000008091f60 
<kpti_install_ng_mappings+504>
        0xffff000008091e2c <+196>:   mov     x22, x19
        0xffff000008091e30 <+200>:   str     x3, [x29,#96]
        0xffff000008091e34 <+204>:   str     x4, [x29,#104]
        0xffff000008091e38 <+208>:   sub     x2, x22, x2
        0xffff000008091e3c <+212>:   msr     ttbr0_el1, x2
        0xffff000008091e40 <+216>:   isb
        0xffff000008091e44 <+220>:   ldr     x0, [x28,#656]
        0xffff000008091e48 <+224>:   and     x1, x1, #0x7fffffffffff
        0xffff000008091e4c <+228>:   adrp    x25, 0xffff00000906d000 
<shmem_swaplist_mutex+16>
        0xffff000008091e50 <+232>:   add     x0, x1, x0
        0xffff000008091e54 <+236>:   add     x1, x25, #0x7b0
        0xffff000008091e58 <+240>:   bl      0xffff0000080a021c 
<cpu_do_switch_mm>
        0xffff000008091e5c <+244>:   adrp    x0, 0xffff00000904a000 
<__cpu_online_mask>
        0xffff000008091e60 <+248>:   mov     w1, 
#0x80                       // #128
        0xffff000008091e64 <+252>:   add     x0, x0, #0x0
        0xffff000008091e68 <+256>:   bl      0xffff0000083e22f0 
<__bitmap_weight>
        0xffff000008091e6c <+260>:   mov     w1, w0
        0xffff000008091e70 <+264>:   ldr     x5, [x23,#672]
        0xffff000008091e74 <+268>:   mov     w0, w20
        0xffff000008091e78 <+272>:   ldr     x4, [x29,#104]
        0xffff000008091e7c <+276>:   mov     x2, x21
        0xffff000008091e80 <+280>:   sub     x2, x2, x5
        0xffff000008091e84 <+284>:   blr     x4
        0xffff000008091e88 <+288>:   ldr     x1, [x23,#672]
        0xffff000008091e8c <+292>:   mrs     x0, sp_el0
        0xffff000008091e90 <+296>:   sub     x22, x22, x1
        0xffff000008091e94 <+300>:   ldr     x1, [x0,#1128]
        0xffff000008091e98 <+304>:   msr     ttbr0_el1, x22
        0xffff000008091e9c <+308>:   isb
        0xffff000008091ea0 <+312>:   dsb     nshst
        0xffff000008091ea4 <+316>:   tlbi    vmalle1
        0xffff000008091ea8 <+320>:   nop
        0xffff000008091eac <+324>:   nop
        0xffff000008091eb0 <+328>:   dsb     nsh
        0xffff000008091eb4 <+332>:   isb
        0xffff000008091eb8 <+336>:   ldr     x3, [x29,#96]
        0xffff000008091ebc <+340>:   ldr     x0, [x3,#2248]
        0xffff000008091ec0 <+344>:   cmp     x0, #0x10
        0xffff000008091ec4 <+348>:   b.ne    0xffff000008091f48 
<kpti_install_ng_mappings+480>
        0xffff000008091ec8 <+352>:   add     x25, x25, #0x7b0
        0xffff000008091ecc <+356>:   cmp     x1, x25
        0xffff000008091ed0 <+360>:   b.eq    0xffff000008091f08 
<kpti_install_ng_mappings+416>
        0xffff000008091ed4 <+364>:   ldr     x2, [x1,#64]
        0xffff000008091ed8 <+368>:   add     x26, x26, #0x0
        0xffff000008091edc <+372>:   cmp     x2, x26
        0xffff000008091ee0 <+376>:   b.eq    0xffff000008091f60 
<kpti_install_ng_mappings+504>
        0xffff000008091ee4 <+380>:   ldr     x0, [x27,#672]
        0xffff000008091ee8 <+384>:   sub     x19, x19, x0
        0xffff000008091eec <+388>:   msr     ttbr0_el1, x19
        0xffff000008091ef0 <+392>:   isb
        0xffff000008091ef4 <+396>:   tbz     x2, #47, 0xffff000008091f34 
<kpti_install_ng_mappings+460>
        0xffff000008091ef8 <+400>:   ldr     x0, [x28,#656]
        0xffff000008091efc <+404>:   and     x2, x2, #0x7fffffffffff
        0xffff000008091f00 <+408>:   add     x0, x2, x0
        0xffff000008091f04 <+412>:   bl      0xffff0000080a021c 
<cpu_do_switch_mm>
        0xffff000008091f08 <+416>:   cbnz    w20, 0xffff000008091f18 
<kpti_install_ng_mappings+432>
        0xffff000008091f0c <+420>:   add     x24, x24, #0x550
        0xffff000008091f10 <+424>:   mov     w0, 
#0x1                        // #1
        0xffff000008091f14 <+428>:   strb    w0, [x24,#8]
        0xffff000008091f18 <+432>:   ldp     x19, x20, [sp,#16]
        0xffff000008091f1c <+436>:   ldp     x21, x22, [sp,#32]
        0xffff000008091f20 <+440>:   ldp     x23, x24, [sp,#48]
        0xffff000008091f24 <+444>:   ldp     x25, x26, [sp,#64]
        0xffff000008091f28 <+448>:   ldp     x27, x28, [sp,#80]
        0xffff000008091f2c <+452>:   ldp     x29, x30, [sp],#112
        0xffff000008091f30 <+456>:   ret
        0xffff000008091f34 <+460>:   adrp    x0, 0xffff000008ea9000 
<cpu_ops+384>
        0xffff000008091f38 <+464>:   ldr     x0, [x0,#672]
        0xffff000008091f3c <+468>:   sub     x0, x2, x0
        0xffff000008091f40 <+472>:   bl      0xffff0000080a021c 
<cpu_do_switch_mm>
        0xffff000008091f44 <+476>:   b       0xffff000008091f08 
<kpti_install_ng_mappings+416>
        0xffff000008091f48 <+480>:   mrs     x0, tcr_el1
        0xffff000008091f4c <+484>:   and     x0, x0, #0xffffffffffffffc0
        0xffff000008091f50 <+488>:   orr     x0, x0, #0x10
        0xffff000008091f54 <+492>:   msr     tcr_el1, x0
        0xffff000008091f58 <+496>:   isb
        0xffff000008091f5c <+500>:   b       0xffff000008091ec8 
<kpti_install_ng_mappings+352>
        0xffff000008091f60 <+504>:   brk     #0x800
        0xffff000008091f64 <+508>:   mrs     x1, tcr_el1
        0xffff000008091f68 <+512>:   and     x1, x1, #0xffffffffffffffc0
        0xffff000008091f6c <+516>:   orr     x0, x1, x0
        0xffff000008091f70 <+520>:   msr     tcr_el1, x0
        0xffff000008091f74 <+524>:   isb
        0xffff000008091f78 <+528>:   b       0xffff000008091df8 
<kpti_install_ng_mappings+144>
     End of assembler dump.


The crash log for it is as :
     estuary:/$ ./qemu-system-aarch64 -machine 
virt,kernel_irqchip=on,gic-version=3
      -cpu host -enable-kvm -smp 1 -m 1024 -kernel ./Image-4.17-joyx 
-initrd
     ../mini-rootfs-arm64.cpio.gz -nographic -append "rdinit=init 
console=ttyAMA0 earlycon=pl011,0x9000000"
         [    0.000000] Booting Linux on physical CPU 0x0000000000 
[0x480fd010]
         [    0.000000] Linux version 4.17.0-45864-g29dcea8-dirty 
(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) 
(crosstool-NG linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #16 
SMP PREEMPT Fri Jun 22 21:05:10 CST 2018
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
         [    0.000000] percpu: Embedded 24 pages/cpu @ (ptrval) s57984 
r8192 d32128 u98304
         [    0.000000] Detected VIPT I-cache on CPU0
         [    0.000000] CPU features: detected: Kernel page table 
isolation (KPTI)
         [    0.000000] CPU features: detected: Hardware dirty bit 
management
         [    0.000000] Built 1 zonelists, mobility grouping on. Total 
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
         [    0.000849] Console: colour dummy device 80x25
         [    0.001427] Calibrating delay loop (skipped), value 
calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
         [    0.002485] pid_max: default: 32768 minimum: 301
         [    0.002966] Security Framework initialized
         [    0.003549] Dentry cache hash table entries: 131072 (order: 
8, 1048576 bytes)
         [    0.004353] Inode-cache hash table entries: 65536 (order: 7, 
524288 bytes)
         [    0.005068] Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
         [    0.005858] Mountpoint-cache hash table entries: 2048 
(order: 2, 16384 bytes)
         [    0.025962] ASID allocator initialised with 32768 entries
         [    0.029972] Hierarchical SRCU implementation.
         [    0.034341] Platform MSI: its domain created
         [    0.034793] PCI/MSI: /intc/its domain created
         [    0.035360] EFI services will not be available.
         [    0.038002] smp: Bringing up secondary CPUs ...
         [    0.038472] smp: Brought up 1 node, 1 CPU
         [    0.038878] SMP: Total of 1 processors activated.
         [    0.039354] CPU features: detected: GIC system register CPU 
interface
         [    0.040004] CPU features: detected: Privileged Access Never
         [    0.040566] CPU features: detected: User Access Override
         [    0.042462] Insufficient stack space to handle exception!
         [    0.042464] ESR: 0x96000046 -- DABT (current EL)
         [    0.043781] FAR: 0xffff0000093a80e0
         [    0.044239] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
         [    0.046967] IRQ stack: [0xffff000008000000..0xffff000008004000]
         [    0.053361] Overflow stack: 
[0xffff80003efce2f0..0xffff80003efcf2f0]
         [    0.059754] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45864-g29dcea8-dirty #16
         [    0.067946] Hardware name: linux,dummy-virt (DT)
         [    0.072644] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
         [    0.077480] pc : el1_sync+0x0/0xb0
         [    0.080970] lr : kpti_install_ng_mappings+0x120/0x214
         [    0.086143] sp : ffff0000093a80e0
         [    0.089513] x29: ffff0000093abce0 x28: ffff000008ea9000
         [    0.094929] x27: ffff000008ea9000 x26: ffff0000091f7000
         [    0.100241] x25: ffff00000906d000 x24: ffff000009191000
         [    0.105657] x23: ffff000008ea9000 x22: 0000000041190000
         [    0.111448] x21: ffff0000091f7000 x20: 0000000000000000
         [    0.116437] x19: ffff000009190000 x18: 000000003455d99d
         [    0.121739] x17: 0000000000000001 x16: 00f8000040ffff13
         [    0.127155] x15: 000000007eff6000 x14: 000000007eff6000
         [    0.132576] x13: 00f800007fe00f11 x12: 000000007eff8000
         [    0.137886] x11: 000000007eff8000 x10: 0000000000000000
         [    0.143300] x9 : 000000007eff9000 x8 : 000000007eff9000
         [    0.148717] x7 : 0000000000000000 x6 : 00000000411f8000
         [    0.154028] x5 : 00000000411f8000 x4 : 0000000040a443d4
         [    0.159444] x3 : 00000000411f7000 x2 : 00000000411f7000
         [    0.164862] x1 : ffff00000906d7b0 x0 : ffff80003da61c00
         [    0.170179] Kernel panic - not syncing: kernel stack overflow
         [    0.176069] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45864-g29dcea8-dirty #16
         [    0.184152] Hardware name: linux,dummy-virt (DT)
         [    0.188851] Call trace:
         [    0.191380]  dump_backtrace+0x0/0x180
         [    0.195113]  show_stack+0x14/0x1c
         [    0.198488]  dump_stack+0x90/0xb0
         [    0.201862]  panic+0x138/0x2a0
         [    0.204989]  __stack_chk_fail+0x0/0x18
         [    0.208836]  handle_bad_stack+0x118/0x124
         [    0.212927]  __bad_stack+0x88/0x8c
         [    0.216414]  el1_sync+0x0/0xb0
         [    0.219544] Unable to handle kernel paging request at 
virtual address ffff0000093abce0
         [    0.227507] Mem abort info:
         [    0.230390]   ESR = 0x96000006
         [    0.233517]   Exception class = DABT (current EL), IL = 32 bits
         [    0.239428]   SET = 0, FnV = 0
         [    0.242555]   EA = 0, S1PTW = 0
         [    0.245797] Data abort info:
         [    0.248795]   ISV = 0, ISS = 0x00000006
         [    0.252652]   CM = 0, WnR = 0
         [    0.255769] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)
         [    0.262645] [ffff0000093abce0] pgd=00000000411f8803, 
pud=00000000411f9803, pmd=0000000000000000
         [    0.271438] Internal error: Oops: 96000006 [#1] PREEMPT SMP
         [    0.277098] Modules linked in:
         [    0.280227] CPU: 0 PID: 12 Comm: migration/0 Not tainted 
4.17.0-45864-g29dcea8-dirty #16
         [    0.288310] Hardware name: linux,dummy-virt (DT)
         [    0.293004] pstate: 204003c5 (nzCv DAIF +PAN -UAO)
         [    0.297931] pc : unwind_frame+0x28/0xc8
         [    0.301792] lr : dump_backtrace+0x12c/0x180
         [    0.306114] sp : ffff80003efcf000
         [    0.309483] x29: ffff80003efcf000 x28: ffff80003da61c00
         [    0.314798] x27: ffff000008ea9000 x26: ffff0000091f7000
         [    0.320216] x25: ffff00000906d000 x24: ffff0000093a80e0
         [    0.325527] x23: 0000000000000000 x22: ffff000008dbada8
         [    0.330941] x21: 0000000000000000 x20: ffff000009049000
         [    0.336355] x19: ffff80003da61c00 x18: 000000003455d99d
         [    0.341770] x17: 0000000000000001 x16: 00f8000040ffff13
         [    0.347078] x15: 000000007eff6000 x14: 642d386165636439
         [    0.352491] x13: 0000000000000000 x12: cc26f77952f87e00
         [    0.357905] x11: ffffffffffffffff x10: 0000000000000075
         [    0.363214] x9 : ffff0000085ae9e8 x8 : ffff80003efcec90
         [    0.368628] x7 : 0000000000000000 x6 : ffff0000091befe1
         [    0.374053] x5 : 0000000000000000 x4 : ffff0000093ac000
         [    0.379363] x3 : ffff0000093a8000 x2 : ffff0000093abce0
         [    0.384779] x1 : ffff80003efcf048 x0 : ffff80003da61c00
         [    0.390196] Process migration/0 (pid: 12, stack limit = 
0x        (ptrval))
         [    0.397188] Call trace:
         [    0.399712]  unwind_frame+0x28/0xc8
         [    0.403316]  show_stack+0x14/0x1c
         [    0.406689]  dump_stack+0x90/0xb0
         [    0.410065]  panic+0x138/0x2a0
         [    0.413193]  __stack_chk_fail+0x0/0x18
         [    0.416934]  handle_bad_stack+0x118/0x124
         [    0.421025]  __bad_stack+0x88/0x8c
         [    0.424513]  el1_sync+0x0/0xb0
         [    0.427643] Unable to handle kernel paging request at 
virtual address ffff0000093abce0
         [    0.435604] Mem abort info:
         [    0.438488]   ESR = 0x96000006
         [    0.441615]   Exception class = DABT (current EL), IL = 32 bits
         [    0.447635]   SET = 0, FnV = 0
         [    0.450759]   EA = 0, S1PTW = 0
         [    0.454002] Data abort info:
         [    0.456896]   ISV = 0, ISS = 0x00000006
         [    0.460863]   CM = 0, WnR = 0
         [    0.463874] swapper pgtable: 4k pages, 48-bit VAs, pgdp 
=         (ptrval)
         [    0.470750] [ffff0000093abce0] pgd=00000000411f8803, 
pud=00000000411f9803, pmd=0000000000000000

Best Regards,
Wei

> Thanks,
>
> Will
>
> .
>


