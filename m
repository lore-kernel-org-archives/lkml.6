Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B90C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09C123E71
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09C123E71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeFVP2r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:28:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8727 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933304AbeFVP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:28:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72A22185ACF18;
        Fri, 22 Jun 2018 23:28:28 +0800 (CST)
Received: from [127.0.0.1] (10.57.101.250) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.382.0; Fri, 22 Jun 2018
 23:28:20 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     Mark Rutland <mark.rutland@arm.com>
References: <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <20180621091850.GA22505@arm.com> <5B2B7A84.8090309@hisilicon.com>
 <20180621105404.GB22505@arm.com> <5B2CB440.8040705@hisilicon.com>
 <20180622092330.GD7601@arm.com> <5B2CD33B.9020702@hisilicon.com>
 <20180622111614.GA1150@arm.com> <5B2CF723.7010600@hisilicon.com>
 <20180622142851.g3r4em3kidx5p3wv@lakrids.cambridge.arm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <dave.martin@arm.com>,
        <marc.zyngier@arm.com>, <linux-arm-kernel@lists.infradead.org>,
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
Message-ID: <5B2D1595.6020000@hisilicon.com>
Date:   Fri, 22 Jun 2018 23:28:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180622142851.g3r4em3kidx5p3wv@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018/6/22 22:28, Mark Rutland wrote:
> On Fri, Jun 22, 2018 at 09:18:27PM +0800, Wei Xu wrote:
>>      [    0.042462] Insufficient stack space to handle exception!
>>      [    0.042464] ESR: 0x96000046 -- DABT (current EL)
>>      [    0.043781] FAR: 0xffff0000093a80e0
>>      [    0.044239] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
> Here, the FAR points somewhere in the task stack, so we're evidently
> faulting on that...
>
>>      [    0.046967] IRQ stack: [0xffff000008000000..0xffff000008004000]
>>      [    0.053361] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
>>      [    0.059754] CPU: 0 PID: 12 Comm: migration/0 Not tainted
>> 4.17.0-45864-g29dcea8-dirty #16
>>      [    0.067946] Hardware name: linux,dummy-virt (DT)
>>      [    0.072644] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>      [    0.077480] pc : el1_sync+0x0/0xb0
>>      [    0.080970] lr : kpti_install_ng_mappings+0x120/0x214
>>      [    0.086143] sp : ffff0000093a80e0
>>      [    0.089513] x29: ffff0000093abce0 x28: ffff000008ea9000
>>      [    0.094929] x27: ffff000008ea9000 x26: ffff0000091f7000
>>      [    0.100241] x25: ffff00000906d000 x24: ffff000009191000
>>      [    0.105657] x23: ffff000008ea9000 x22: 0000000041190000
>>      [    0.111448] x21: ffff0000091f7000 x20: 0000000000000000
>>      [    0.116437] x19: ffff000009190000 x18: 000000003455d99d
>>      [    0.121739] x17: 0000000000000001 x16: 00f8000040ffff13
>>      [    0.127155] x15: 000000007eff6000 x14: 000000007eff6000
>>      [    0.132576] x13: 00f800007fe00f11 x12: 000000007eff8000
>>      [    0.137886] x11: 000000007eff8000 x10: 0000000000000000
>>      [    0.143300] x9 : 000000007eff9000 x8 : 000000007eff9000
>>      [    0.148717] x7 : 0000000000000000 x6 : 00000000411f8000
>>      [    0.154028] x5 : 00000000411f8000 x4 : 0000000040a443d4
>>      [    0.159444] x3 : 00000000411f7000 x2 : 00000000411f7000
>>      [    0.164862] x1 : ffff00000906d7b0 x0 : ffff80003da61c00
>>      [    0.170179] Kernel panic - not syncing: kernel stack overflow
>>      [    0.176069] CPU: 0 PID: 12 Comm: migration/0 Not tainted
>> 4.17.0-45864-g29dcea8-dirty #16
>>      [    0.184152] Hardware name: linux,dummy-virt (DT)
>>      [    0.188851] Call trace:
>>      [    0.191380]  dump_backtrace+0x0/0x180
>>      [    0.195113]  show_stack+0x14/0x1c
>>      [    0.198488]  dump_stack+0x90/0xb0
>>      [    0.201862]  panic+0x138/0x2a0
>>      [    0.204989]  __stack_chk_fail+0x0/0x18
>>      [    0.208836]  handle_bad_stack+0x118/0x124
>>      [    0.212927]  __bad_stack+0x88/0x8c
>>      [    0.216414]  el1_sync+0x0/0xb0
>>      [    0.219544] Unable to handle kernel paging request at virtual address
>> ffff0000093abce0
> Likewise, here we're faulting on an address within the task stack,
> presumably as part of the unwinding process...
>
>>      [    0.227507] Mem abort info:
>>      [    0.230390]   ESR = 0x96000006
>>      [    0.233517]   Exception class = DABT (current EL), IL = 32 bits
>>      [    0.239428]   SET = 0, FnV = 0
>>      [    0.242555]   EA = 0, S1PTW = 0
>>      [    0.245797] Data abort info:
>>      [    0.248795]   ISV = 0, ISS = 0x00000006
>>      [    0.252652]   CM = 0, WnR = 0
>>      [    0.255769] swapper pgtable: 4k pages, 48-bit VAs, pgdp =
>> (ptrval)
>>      [    0.262645] [ffff0000093abce0] pgd=00000000411f8803,
>> pud=00000000411f9803, pmd=0000000000000000
> ... and here the PMD for the task stack is all zeroes, so evidently
> that's getting corrupted somehow.
>
> It appears that the overflow stack (which IIRC is embedded within the
> kernel's data segment, as part of the image mapping), is fine.
>
> I wonder if there's some existing weirdness in the page tables for the
> vmalloc area that causes things to go wrong. Can you please:
>
> * enable ARM64_PTDUMP_DEBUGFS
>
> * boot with kpti=off (with Will's patch to make this work)
>
> * as root, cat /sys/kernel/debug/kernel_page_tables
>
> ... and dump the result here?
Thanks!
Can I do this later since Will's new patch works?

Best Regards,
Wei

> Thanks,
> Mark.
>
> .
>


