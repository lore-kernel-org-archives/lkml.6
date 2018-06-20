Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF5AC1B0F7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326202083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326202083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754550AbeFTPwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:52:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39752 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754490AbeFTPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:52:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE96340A42196;
        Wed, 20 Jun 2018 23:52:24 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Wed, 20 Jun 2018
 23:52:19 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
CC:     <catalin.marinas@arm.com>, <suzuki.poulose@arm.com>,
        <dave.martin@arm.com>, <mark.rutland@arm.com>,
        <james.morse@arm.com>, <marc.zyngier@arm.com>,
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
Message-ID: <5B2A7832.4010502@hisilicon.com>
Date:   Wed, 20 Jun 2018 23:52:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180620144257.GB27776@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/20 22:42, Will Deacon wrote:
> Hi Wei,
>
> On Wed, Jun 20, 2018 at 10:18:00PM +0800, Wei Xu wrote:
>> We have observed KVM guest sometimes failed to boot because of kernel stack
>> overflow if KPTI is enabled on a hisilicon arm64 platform.
>>
>> We also tested with different kernel version and found it is only
>> happened if the KPTI and KVM(enable-kvm & cpu=host) are enabled on the
>> guest.
>> The detail result is as below table.
>>
>> +---------+----------+--------+------------+-------------------+
>>       |  host   |host KPTI | guest  | guest KPTI | kvm guest         |
>>       |  kernel |enabled   | kernel | enabled    | booting result    |
>> +---------+----------+--------+------------+-------------------+
>>       |  4.17   |     Y    |  4.17  |     Y      |  stack overflow   |
>> +---------+----------+--------+------------+-------------------+
>>       |  4.17   |     Y    |  4.16  |     NA     | OK          |
>> +---------+----------+--------+------------+-------------------+
>>       |  4.16   |     NA   |  4.17  |     Y      |  stack overflow   |
>> +---------+----------+--------+------------+-------------------+
>>       |  4.16   |     NA   |  4.16  |     NA     | OK          |
>> +---------+----------+--------+------------+-------------------+
>>
>> A simple walk-around is adding this platform into the "kpti_safe_list".
>> But it does not resolve the issue indeed.
>> Could you please share any hint how to resolve this kind issue?
>> Thanks!
>>
>> Another issue we found is "kpti_install_ng_mappings" will be invoked
>> even "kpti=off" has been added in the kernel command line. Is that expected?
>> This is because "kpti" is not a *early* param that "init_cpu_features" will
>> be invoked before parsing the param.
> That sounds like a straightforward bug, which means we should use
> early_param instead of __setup. I assume that doesn't fix your crash,
> though?

Thanks for you quick response!
It can fix our crash but just another walk-around.

>> The command we are using to run the guest is as:
>>
>>      ./qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3 -cpu
>> host
>>      -enable-kvm -smp 1 -m 1024 -kernel ./Image -initrd
>> ../mini-rootfs-arm64.cpio.gz
>>      -nographic -append "rdinit=init console=ttyAMA0
>> earlycon=pl011,0x9000000"
>>
>> The log is as below:
>>
>>          [    0.000000] Booting Linux on physical CPU 0x0000000000
>> [0x480fd010]
>>          [    0.000000] Linux version 4.17.0-45864-g29dcea8-dirty
>> (joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
>> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #6 SMP PREEMPT Fri Jun
>> 15 21:39:52 CST 2018
> ^^^ This is reproducible with vanilla v4.17 and defconfig, right?

Yes.

>
>>          [    0.038859] SMP: Total of 1 processors activated.
>>          [    0.039338] CPU features: detected: GIC system register CPU
>> interface
>>          [    0.039988] CPU features: detected: Privileged Access Never
>>          [    0.040560] CPU features: detected: User Access Override
>>          [    0.041093] CPU features: detected: RAS Extension Support
>>          [    0.042947] Insufficient stack space to handle exception!
>>          [    0.042949] ESR: 0x96000046 -- DABT (current EL)
>>          [    0.043963] FAR: 0xffff0000093a80e0
>>          [    0.045794] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
>>          [    0.052181] IRQ stack: [0xffff000008000000..0xffff000008004000]
>>          [    0.058572] Overflow stack:
>> [0xffff80003efce2f0..0xffff80003efcf2f0]
>>          [    0.065068] CPU: 0 PID: 12 Comm: migration/0 Not tainted
>> 4.17.0-45864-g29dcea8-dirty #6
>>          [    0.073138] Hardware name: linux,dummy-virt (DT)
>>          [    0.077831] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>          [    0.082661] pc : el1_sync+0x0/0xb0
>>          [    0.086152] lr : kpti_install_ng_mappings+0x120/0x214
> Can you use scripts/faddr2line to find out which line of code the lr is
> pointing at, please? It would be interesting to know if we managed to
> install the idmap.
I did not use addr2line before but with gdb we can get same info as below:

(gdb) list *kpti_install_ng_mappings+0x120/0x214
0xffff000008091d70 is in kpti_install_ng_mappings 
(/home/joyx/plinth-kernel-v200/arch/arm64/kernel/cpufeature.c:907).
902             return !has_cpuid_feature(entry, scope);
903     }
904
905     static void
906     kpti_install_ng_mappings(const struct arm64_cpu_capabilities 
*__unused)
907     {
908             typedef void (kpti_remap_fn)(int, int, phys_addr_t);
909             extern kpti_remap_fn idmap_kpti_install_ng_mappings;
910             kpti_remap_fn *remap_fn;
911

> Hmm, I wonder if this is at all related to RAS, since we've just enabled
> that and if we take a fault whilst rewriting swapper then we're going to
> get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?

I will try it now.
Thanks!

Best Regards,
Wei

> Will
>
> .
>


