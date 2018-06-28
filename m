Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114DAC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EEE24B92
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EEE24B92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeF1KVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:21:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751519AbeF1KVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:21:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 074757D8705ED;
        Thu, 28 Jun 2018 18:20:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.42) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Thu, 28 Jun 2018
 18:20:43 +0800
Subject: Re: KVM guest sometimes failed to boot because of kernel stack
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
To:     James Morse <james.morse@arm.com>
References: <5B2A6218.3030201@hisilicon.com> <20180620144257.GB27776@arm.com>
 <5B2A7832.4010502@hisilicon.com>
 <ebfabb8f-dcd9-3fb4-3655-368a882d8f09@arm.com>
 <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com>
 <942e76b6-a46a-6c5e-5ec3-67daca636d43@arm.com>
 <5B339068.5020304@hisilicon.com>
 <9549e15d-4ec6-8dd3-2237-b6c9b52fc816@arm.com>
CC:     Will Deacon <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, Linuxarm <linuxarm@huawei.com>,
        Zhangyi ac <zhangyi.ac@huawei.com>, <suzuki.poulose@arm.com>,
        <marc.zyngier@arm.com>,
        "Xiongfanggou (James)" <james.xiong@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dave.martin@arm.com>,
        "Liyuan (Larry, Turing Solution)" <Larry.T@huawei.com>,
        <libeijian@hisilicon.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5B34B673.20803@hisilicon.com>
Date:   Thu, 28 Jun 2018 11:20:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <9549e15d-4ec6-8dd3-2237-b6c9b52fc816@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2018/6/28 9:45, James Morse wrote:
> Hi Wei,
> 
> On 27/06/18 14:26, Wei Xu wrote:
>> Sorry, I should highlight that I have only updated the default value
>> of CONFIG_NR_CPUS by menuconfig in the previous mail.
>> That is why it showed dirty.
> 
> (menuconfig changes don't show up like this)

Thanks!
Sorry, yes, you are right.
I did not see dirty after I reset the proc.S.

> 
> 
> More than 64 CPUs ... Is this system running more VMs than it has VMIDs? Too-few
> VMIDs does work with KVM, its just going to trigger rollover frequently.
>

No, we just ran one VM.

> Just to check, what kernel version is the host running? Does it have commit
> f0cf47d939d0 ("KVM: arm/arm64: Close VMID generation race")
> (looks like that went in as a fix for v4.17-rc3)

Yes, the host is runing 4.18-rc2 as the guest including above commit.

> 
> Are you running (lots) of other VMs whenever this happens? Do they have multiple
> vcpus? (I'm thinking of the scenario in that patch's description)

No, we just ran one VM with 1 cpu.

> 
> Is the host system otherwise idle when this happens?
> (If not, can you reproduce the issue without exhausting the VMIDs?)
> 
> 
> It may be that writing back the page-table entries with the MMU off, and
> changing the cache maintenance are just changing the timing of something else.
> 

Yes, maybe. Now we are debugging with the SoC guys together.
Thanks!

Best Regards,
Wei

> 
> Thanks,
> 
> James
> 
> .
> 

