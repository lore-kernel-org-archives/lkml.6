Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330CAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70BB26351
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70BB26351
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965381AbeF0NW2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:22:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57230 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S965276AbeF0NW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:22:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 01E864A3AF9C;
        Wed, 27 Jun 2018 21:22:23 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Wed, 27 Jun 2018
 21:22:14 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
CC:     James Morse <james.morse@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, <suzuki.poulose@arm.com>,
        <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>, <zhangxiquan@hisilicon.com>,
        <wxf.wang@hisilicon.com>, <dingshuai1@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B338F7B.9070500@hisilicon.com>
Date:   Wed, 27 Jun 2018 14:22:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180626174746.GO23375@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/26 18:47, Will Deacon wrote:
> Hi Wei,
> 
> On Wed, Jun 27, 2018 at 01:16:44AM +0800, Wei Xu wrote:
>> Today I tried the kernel 4.18-rc2(defconfig, no change on top) with qemu
>> 2.12.0.
>> The guest sometimes still failed to boot. But the crash reason is different.
>> Could you please share any hint?
>> Thanks!
>>
>> The guest boot log is as below:
>> ===========================
>>
>>     estuary:/$ ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-v
>>     ersion=3 -cpu host -enable-kvm -smp 1 -m 1024 -kernel ./Image-4.18-joyx
>> -initrd
>>     ../mini-rootfs-arm64.cpio.gz -nographic -append "rdinit=init
>> console=ttyAMA0 ear
>>     lycon=pl011,0x9000000"
>>
>>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>     [    0.000000] Linux version 4.18.0-rc2-58583-g7daf201-dirty
> 
> I'm still suspicious that this is 4.18-rc2 with "no change on top" ^^^ !

Sorry, I should highlight that I have updated the default value
of CONFIG_NR_CPUS by menuconfig in the previous mail.
That is why it showed dirty.

> 
>>     [    0.048119] Unable to handle kernel NULL pointer dereference at
>> virtual address 0000000000000288
>>     [    0.048991] Mem abort info:
>>     [    0.049267]   ESR = 0x96000004
>>     [    0.049567]   Exception class = DABT (current EL), IL = 32 bits
>>     [    0.050146]   SET = 0, FnV = 0
>>     [    0.050446]   EA = 0, S1PTW = 0
>>     [    0.050754] Data abort info:
>>     [    0.051038]   ISV = 0, ISS = 0x00000004
>>     [    0.051921]   CM = 0, WnR = 0
>>     [    0.054936] [0000000000000288] user address but active_mm is swapper
>>     [    0.061427] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>     [    0.067080] Modules linked in:
>>     [    0.070206] CPU: 0 PID: 13 Comm: migration/0 Not tainted
>> 4.18.0-rc2-58583-g7daf201-dirty #20
>>     [    0.078745] Hardware name: linux,dummy-virt (DT)
>>     [    0.083433] pstate: 60400085 (nZCv daIf +PAN -UAO)
>>     [    0.088258] pc : kpti_install_ng_mappings+0x154/0x214
>>     [    0.093319] lr : kpti_install_ng_mappings+0x120/0x214
>>     [    0.098483] sp : ffff0000093fbce0
>>     [    0.101854] x29: ffff0000093fbce0 x28: ffff000008ee5000
>>     [    0.107263] x27: ffff000008ee5000 x26: ffff00000923b000
>>     [    0.112568] x25: ffff0000090ac000 x24: ffff0000091d9000
>>     [    0.117983] x23: ffff000008ee5000 x22: 00000000411d8000
>>     [    0.123392] x21: ffff00000923b000 x20: 0000000000000000
>>     [    0.128801] x19: ffff0000091d8000 x18: 000000003455d99d
>>     [    0.134209] x17: 0000000000000001 x16: 00f8000040ffff13
>>     [    0.139513] x15: 000000007dff5000 x14: 000000007dff5000
>>     [    0.144920] x13: 00f800007fe00f11 x12: 000000007dff7000
>>     [    0.150329] x11: 000000007dff7000 x10: 0000000000000000
>>     [    0.155633] x9 : 000000007dff8000 x8 : 000000007dff8000
>>     [    0.161042] x7 : 0000000000000000 x6 : 000000004123c000
>>     [    0.166451] x5 : 000000004123c000 x4 : 0000000040a5f3d4
>>     [    0.171860] x3 : 0000000000000000 x2 : 000000004123b000
>>     [    0.177163] x1 : ffff0000090acd88 x0 : ffff80003ca627c0
> 
> So looking at the disassembly, we access idmap_t0sz as part of
> cpu_install_idmap() and it looks like we push its page address to the
> stack:
> 
>>        0xffff000008091ffc <+128>:   adrp    x3, 0xffff000009096000 <early_node_cpu_hwid+1440>
> 
> [...]
> 
>>        0xffff000008092044 <+200>:   str     x3, [x29,#96]
> 
> Then after we've come back from the asm call, we want to access idmap_t0sz
> again as part of cpu_uninstall_idmap() so we pop it back off:
> 
>>        0xffff0000080920cc <+336>:   ldr     x3, [x29,#96]
>>        0xffff0000080920d0 <+340>:   ldr     x0, [x3,#648]
> 
> And this access is the one that faults, because we popped off NULL.
> 

Thanks for your kindly explanation!

> So actually, rather than faulting on the stack access, we're managing to
> load zeroes from somewhere, so it could still be indicative of page table
> corruption for the stack mapping.
> 
> If you look at the __idmap_kpti_put_pgtable_ent_ng asm macro, can you try
> replacing:
> 
> 	dc      civac, cur_\()\type\()p
> 
> with:
> 
> 	dc      ivac, cur_\()\type\()p
> 
> please? Only do this for the guest kernel, not the host. KVM will upgrade
> the clean to a clean+invalidate, so it's interesting to see if this has
> an effect on the behaviour.

Only changed the guest kernel, the guest still failed to boot and the log
is same with the last mail.

But if I changed to cvac as below for the guest, it is kind of stable.
	dc      cvac, cur_\()\type\()p

I have synced with our SoC guys about this and hope we can find the reason.
Do you have any more suggestion?
Thanks!

Best Regards,
Wei

> 
> Will
> 
> .
> 

