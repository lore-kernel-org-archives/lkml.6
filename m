Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487DDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81B923F07
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81B923F07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753941AbeFVIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:33:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751243AbeFVIdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:33:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 01E00D3A24CCC;
        Fri, 22 Jun 2018 16:33:36 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 16:33:20 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com>
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
Message-ID: <5B2CB440.8040705@hisilicon.com>
Date:   Fri, 22 Jun 2018 09:33:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20180621105404.GB22505@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/6/21 11:54, Will Deacon wrote:
> Hi Wei,
> 
> On Thu, Jun 21, 2018 at 11:14:28AM +0100, Wei Xu wrote:
>> On 2018/6/21 10:18, Will Deacon wrote:
>>> On Thu, Jun 21, 2018 at 09:38:53AM +0100, James Morse wrote:
>>>> On 20/06/18 17:25, Wei Xu wrote:
>>>>>     [    0.042421] Insufficient stack space to handle exception!
>>>>>     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
>>>>>     [    0.043730] FAR: 0xffff0000093a80e0
>>>>>     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
>>>>
>>>> This was a level 2 translation fault on a write, to an address that is within
>>>> the stack....
>>>>
>>>>
>>>>>     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
>>>>>     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
>>>>>     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
>>>>> 4.17.0-45865-g2b31fe7-dirty #10
>>>>>     [    0.072201] Hardware name: linux,dummy-virt (DT)
>>>>
>>>>>     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>>>>     [    0.081727] pc : el1_sync+0x0/0xb0
>>>>
>>>> ... from the vectors.
>>>>
>>>>
>>>>>     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
>>>>
>>>> What I think is happening is: we come out of the kpti idmap with the stack
>>>> unmapped. Shortly after we access the stack, which faults. el1_sync faults as
>>>> well when it tries to push the registers to the stack, and we keep going until
>>>> we overflow the stack.
>>>>
>>>> I can't reproduce this with kvmtool or qemu in the model.
>>>
>>> Hmm, one thing that occurs to me is that the kpti_install_ng_mappings()
>>> code leaves the nG bit set in table entries, which is actually IGNORED in
>>> the architecture.
>>>
>>> Wei -- does the diff below help at all? Make sure you disable CONFIG_KASAN,
>>> otherwise your kernel will take an age to boot.
>>
>> Yes, amazing! This patch resolved the issue.
> 
> Great...
> 
>> I have tested 50 times and can not reproduce the issue any more.
>> Could you please tell more why this patch works?
> 
> You might need to ask your CPU design team ;)
> 
> Without this patch, the code in idmap_kpti_install_ng_mappings() sets
> bit 11 in table descriptors so that we can keep track of which parts of
> the page table we've visited. With this patch, we don't bother tracking
> and potentially rewalk parts of the page table (which takes a very long
> time if KASAN is enabled).

Got it. Thanks!

> 
> The architecture documents I've looked at are clear that bit 11 is IGNORED
> by the CPU, which:
> 
>   "Indicates that the architecture guarantees that the bit or field is not
>    interpreted or modified by hardware."
> 
> Please can you double-check that your CPU is indeed ignoring bit 11 in
> non-leaf (table) descriptors?

Do the non-leaf(table) descriptors mean the table descriptors
of the section D4.3.1 "VMSAv8-64 translation table level 0, level 1, and level 2 descriptor formats"
in the ARM Architecture Reference Manual ARMv8 for ARMv8-A(DDI0487C_a_armv8_arm.pdf)?

If yes, our hardware does ignore it(not interpret or modify).

Is there any other possible reason cause this?
Thanks!

Best Regards,
Wei

> 
> Thanks,
> 
> Will
> 
> .
> 

