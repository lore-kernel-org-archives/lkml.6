Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A0C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0852083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0852083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932385AbeFTQeE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:34:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754235AbeFTQeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:34:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 853C481A0842B;
        Thu, 21 Jun 2018 00:33:46 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Thu, 21 Jun 2018
 00:33:22 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com> <20180620162845.GD27776@arm.com>
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
        <libeijian@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B2A81D1.6070507@hisilicon.com>
Date:   Thu, 21 Jun 2018 00:33:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180620162845.GD27776@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/21 0:28, Will Deacon wrote:
> On Thu, Jun 21, 2018 at 12:25:05AM +0800, Wei Xu wrote:
>> Hi James,
>>
>> On 2018/6/20 23:54, James Morse wrote:
>>> Hi Wei,
>>>
>>> On 20/06/18 16:52, Wei Xu wrote:
>>>> On 2018/6/20 22:42, Will Deacon wrote:
>>>>> Hmm, I wonder if this is at all related to RAS, since we've just enabled
>>>>> that and if we take a fault whilst rewriting swapper then we're going to
>>>>> get stuck. What happens if you set CONFIG_ARM64_RAS_EXTN=n in the guest?
>>>> I will try it now.
>>> It's not just the Kconfig symbol, could you also revert:
>>>
>>> f751daa4f9d3 ("arm64: Unconditionally enable IESB on exception entry/return for
>>> firmware-first")
>>>
>>>
>>> (reverts and build cleanly on 4.17)
>> Thanks to point out this!
>> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
>> But I still got the stack overflow issue sometimes.
>> Do you have more hint?
> [...]
>
>>      [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>      [    0.081727] pc : el1_sync+0x0/0xb0
>>      [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> Please run:
>
> $ ./scripts/faddr2line vmlinux kpti_install_ng_mappings+0x120/0x214

Thanks for your kindly guide :)
The output is as below:

     joyx@Turing-Arch-b:~/plinth-kernel-v200$ ./scripts/faddr2line 
../kernel-dev.build/vmlinux kpti_install_ng_mappings+0x120/0x214
     kpti_install_ng_mappings+0x120/0x214:
     cpu_set_reserved_ttbr0 at arch/arm64/include/asm/mmu_context.h:52
     47      /*
     48       * Set TTBR0 to empty_zero_page. No translations will be 
possible via TTBR0.
     49       */
     50      static inline void cpu_set_reserved_ttbr0(void)
     51      {
     52              unsigned long ttbr = 
phys_to_ttbr(__pa_symbol(empty_zero_page));
     53
     54              write_sysreg(ttbr, ttbr0_el1);
     55              isb();
     56      }
     57
     (inlined by) cpu_uninstall_idmap at 
arch/arm64/include/asm/mmu_context.h:123
     118      */
     119     static inline void cpu_uninstall_idmap(void)
     120     {
     121             struct mm_struct *mm = current->active_mm;
     122
     123             cpu_set_reserved_ttbr0();
     124             local_flush_tlb_all();
     125             cpu_set_default_tcr_t0sz();
     126
     127             if (mm != &init_mm && !system_uses_ttbr0_pan())
     128                     cpu_switch_mm(mm->pgd, mm);
     (inlined by) kpti_install_ng_mappings at 
arch/arm64/kernel/cpufeature.c:922
     917
     918             remap_fn = (void 
*)__pa_symbol(idmap_kpti_install_ng_mappings);
     919
     920             cpu_install_idmap();
     921             remap_fn(cpu, num_online_cpus(), 
__pa_symbol(swapper_pg_dir));
     922             cpu_uninstall_idmap();
     923
     924             if (!cpu)
     925                     kpti_applied = true;
     926
     927             return;

Thanks!

Best Regards,
Wei

> as the GDB output wasn't helpful (it only showed local variable
> declarations?!).
>
> Will
>
> .
>


