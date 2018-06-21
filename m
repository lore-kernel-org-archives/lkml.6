Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55282C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0E320837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0E320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbeFUJVR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:21:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932591AbeFUJVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:21:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 98E30B769C869;
        Thu, 21 Jun 2018 17:21:02 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Thu, 21 Jun 2018
 17:20:56 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
CC:     <catalin.marinas@arm.com>, <suzuki.poulose@arm.com>,
        <dave.martin@arm.com>, <mark.rutland@arm.com>,
        <marc.zyngier@arm.com>, <linux-arm-kernel@lists.infradead.org>,
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
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B2B6DEA.2090100@hisilicon.com>
Date:   Thu, 21 Jun 2018 10:20:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2018/6/21 9:38, James Morse wrote:
> Hi Will, Wei,
> 
> On 20/06/18 17:25, Wei Xu wrote:
>> On 2018/6/20 23:54, James Morse wrote:
>> I have disabled CONFIG_ARM64_RAS_EXTN and reverted that commit.
>> But I still got the stack overflow issue sometimes.
>> Do you have more hint?
> 
>> The log is as below:
>>     [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
>>     [    0.000000] Linux version 4.17.0-45865-g2b31fe7-dirty
> 
> Could you reproduce this with v4.17? This says there are ~45,000 extra patches,
> and un-committed changes. None of the hashes so far have been commits in
> mainline, so we have no idea what this tree is.
> 

I have tried v4.17 and log is as below and also it can be found in the first mail
of this thread.

	[ 0.000000] Linux version 4.17.0-45864-g29dcea8-dirty
	(joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
	linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #6 SMP PREEMPT Fri Jun
	15 21:39:52 CST 2018

I will try v4.17.2 and v4.18-rc1.

> 
>> (joyx@Turing-Arch-b) (gcc version 4.9.1 20140505 (prerelease) (crosstool-NG
>> linaro-1.13.1-4.9-2014.05 - Linaro GCC 4.9-2014.05)) #10 SMP PREEMPT Wed Jun 20
>> 23:59:05 CST 2018
> 
>>     [    0.000000] CPU0: using LPI pending table @0x000000007d860000
>>     [    0.000000] GIC: PPI11 is secure or misconfigured
>>     [    0.000000] arch_timer: WARNING: Invalid trigger for IRQ3, assuming level
>> low
>>     [    0.000000] arch_timer: WARNING: Please fix your firmware
>>     [    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
> 
> (No idea what these mean, but I doubt they are relevant)
> 

I will try with mainline qemu 2.12.0.

Thanks!

Best Regards,
Wei

> 
>>     [    0.042421] Insufficient stack space to handle exception!
>>     [    0.042423] ESR: 0x96000046 -- DABT (current EL)
>>     [    0.043730] FAR: 0xffff0000093a80e0
>>     [    0.044714] Task stack: [0xffff0000093a8000..0xffff0000093ac000]
> 
> This was a level 2 translation fault on a write, to an address that is within
> the stack....
> 
> 
>>     [    0.051113] IRQ stack: [0xffff000008000000..0xffff000008004000]
>>     [    0.057610] Overflow stack: [0xffff80003efce2f0..0xffff80003efcf2f0]
>>     [    0.064003] CPU: 0 PID: 12 Comm: migration/0 Not tainted
>> 4.17.0-45865-g2b31fe7-dirty #10
>>     [    0.072201] Hardware name: linux,dummy-virt (DT)
> 
>>     [    0.076797] pstate: 604003c5 (nZCv DAIF +PAN -UAO)
>>     [    0.081727] pc : el1_sync+0x0/0xb0
> 
> ... from the vectors.
> 
> 
>>     [    0.085217] lr : kpti_install_ng_mappings+0x120/0x214
> 
> What I think is happening is: we come out of the kpti idmap with the stack
> unmapped. Shortly after we access the stack, which faults. el1_sync faults as
> well when it tries to push the registers to the stack, and we keep going until
> we overflow the stack.
> 
> I can't reproduce this with kvmtool or qemu in the model.
> 
> 
> Thanks,
> 
> James
> 
> .
> 

