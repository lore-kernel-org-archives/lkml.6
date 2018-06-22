Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE460C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9616E244C8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9616E244C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933802AbeFVP0v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:26:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933304AbeFVP0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:26:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4BAD6C46BBEEC;
        Fri, 22 Jun 2018 23:26:35 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 23:26:27 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
 <20180622133133.GA1802@arm.com> <5B2CFDCD.6040207@hisilicon.com>
 <20180622144346.GB1802@arm.com>
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
Message-ID: <5B2D1524.4060803@hisilicon.com>
Date:   Fri, 22 Jun 2018 23:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180622144346.GB1802@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/22 22:43, Will Deacon wrote:
> On Fri, Jun 22, 2018 at 09:46:53PM +0800, Wei Xu wrote:
>> On 2018/6/22 21:31, Will Deacon wrote:
>>> On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
>>>> On 2018/6/22 19:16, Will Deacon wrote:
>>>>> On Fri, Jun 22, 2018 at 06:45:15PM +0800, Wei Xu wrote:
>>>>>> On 2018/6/22 17:23, Will Deacon wrote:
>>>>>>> Perhaps just writing back the table entries is enough to cause the issue,
>>>>>>> although I really can't understand why that would be the case. Can you try
>>>>>>> the diff below (without my previous change), please?
>>>>>> Thanks!
>>>>>> But it does not resolve the issue(only apply this patch based on 4.17.0).
>>>>> Thanks, that's a useful data point. It means that it still crashes even if
>>>>> we write back the same table entries, so it's the fact that we're writing
>>>>> them at all which causes the problem, not the value that we write.
>>>>>
>>>>> Whilst looking at the code, we noticed a missing DMB. On the off-chance
>>>>> that it helps, can you try this instead please?
>>>> Thanks!
>>>> Only apply below patch based on 4.17.0, we still got the crash.
>>> Oh well, it was worth a shot (and that's still a fix worth having). Please
>>> can you provide the complete disassembly for kpti_install_ng_mappings()
>>> (I'm referring to the C function in cpufeature.c) along with a corresponding
>>> crash log so that we can correlate the instruction stream with the crash?
>> Just let me know if you need more information.
> Thanks; the disassembly and log are really helpful.
>
> I have another patch for you to try below. Please can you let me know how
> you get on, and sorry for the back-and-forth on this.

No worry.
Great, I have tried 30 times and it works well with this patch applying 
on the 4.17.0.
And is it possible to let me know how you are using the disassemble and 
log to debug
this kind issue?
Thanks!

Best Regards,
Wei

> Will
>
> --->8
>
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 5f9a73a4452c..26c5c3fabca8 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -216,9 +216,14 @@ ENDPROC(idmap_cpu_replace_ttbr1)
>   	.endm
>   
>   	.macro __idmap_kpti_put_pgtable_ent_ng, type
> -	orr	\type, \type, #PTE_NG		// Same bit for blocks and pages
> +	eor	\type, \type, #PTE_NG		// Same bit for blocks and pages
>   	str	\type, [cur_\()\type\()p]	// Update the entry and ensure it
> +	tbz	\type, #11, 1234f
>   	dc	civac, cur_\()\type\()p		// is visible to all CPUs.
> +	b	1235f
> +	1234:
> +	dc	cvac, cur_\()\type\()p
> +	1235:
>   	.endm
>   
>   /*
> @@ -298,6 +303,7 @@ skip_pgd:
>   	/* PUD */
>   walk_puds:
>   	.if CONFIG_PGTABLE_LEVELS > 3
> +	eor	pgd, pgd, #PTE_NG
>   	pte_to_phys	cur_pudp, pgd
>   	add	end_pudp, cur_pudp, #(PTRS_PER_PUD * 8)
>   do_pud:	__idmap_kpti_get_pgtable_ent	pud
> @@ -319,6 +325,7 @@ next_pud:
>   	/* PMD */
>   walk_pmds:
>   	.if CONFIG_PGTABLE_LEVELS > 2
> +	eor	pud, pud, #PTE_NG
>   	pte_to_phys	cur_pmdp, pud
>   	add	end_pmdp, cur_pmdp, #(PTRS_PER_PMD * 8)
>   do_pmd:	__idmap_kpti_get_pgtable_ent	pmd
> @@ -339,6 +346,7 @@ next_pmd:
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


