Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626C2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F21420831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F21420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJ3Ssv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:48:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbeJ3Ssv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:48:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BAC4CA148B755;
        Tue, 30 Oct 2018 17:56:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 30 Oct 2018
 17:55:53 +0800
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
To:     Peter Zijlstra <peterz@infradead.org>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Will Deacon" <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>, Linuxarm <linuxarm@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
Date:   Tue, 30 Oct 2018 09:55:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181030092640.GE1459@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2018 09:26, Peter Zijlstra wrote:
> On Tue, Oct 23, 2018 at 11:30:11AM +0100, John Garry wrote:
>> Hi all,
>>
>> I have stumbled upon this crash on my arm64 system:
>>
>> [    7.040874] SMP: Total of 64 processors activated.
>> [    7.045720] CPU features: detected: GIC system register CPU interface
>> [    7.052240] CPU features: detected: 32-bit EL0 Support
>> [    7.144026] CPU: All CPU(s) started at EL2
>> [    7.148298] alternatives: patching kernel code
>> [    7.155277] Unable to handle kernel NULL pointer dereference at virtual
>> address 0000000000000000
>> [    7.164163] Mem abort info:
>> [    7.166978]   ESR = 0x96000004
>> [    7.170061]   Exception class = DABT (current EL), IL = 32 bits
>> [    7.176043]   SET = 0, FnV = 0
>> [    7.179121]   EA = 0, S1PTW = 0
>> [    7.182291] Data abort info:
>> [    7.185193]   ISV = 0, ISS = 0x00000004
>> [    7.189066]   CM = 0, WnR = 0
>> [    7.192056] [0000000000000000] user address but active_mm is swapper
>> [    7.198480] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [    7.204107] Modules linked in:
>> [    7.207189] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>> 4.19.0-00002-g3ed52fd-dirty #807
>> [    7.216596] Hardware name: Hisilicon Hip07 D05 Development Board (DT)
>> [    7.223102] pstate: 20000005 (nzCv daif -PAN -UAO)
>> [    7.227946] pc : __ll_sc_atomic_sub_return+0x4/0x20
>> [    7.232873] lr : free_sched_groups.part.1+0x40/0x98
>> [    7.237797] sp : ffff00000947bc60
>> [    7.241138] x29: ffff00000947bc60 x28: ffff801fb49ba000
>> [    7.246504] x27: ffff000009109b38 x26: ffff801fb4a38000
>> [    7.251869] x25: ffff801fb48cc000 x24: ffff000009109000
>> [    7.257235] x23: 0000000000000010 x22: 0000000000000001
>> [    7.262599] x21: ffff801fb4a0b000 x20: ffff801fb4a65f00
>> [    7.267964] x19: ffff801fb4a65f80 x18: 0000000000000400
>> [    7.273329] x17: 00000000ffffffff x16: 0000000000000000
>> [    7.278694] x15: ffff801ffbffef80 x14: ffff7e007ed14bc0
>> [    7.284059] x13: 00000000000000c0 x12: 000000000000003f
>> [    7.289423] x11: ffff801fb62258b8 x10: 0000000000000001
>> [    7.294788] x9 : ffff801fb44b0100 x8 : 000000000000000f
>> [    7.300153] x7 : ffff801fb48b1900 x6 : 0000801ff2efb000
>> [    7.305518] x5 : ffff0000091096f0 x4 : 0000000000000400
>> [    7.310882] x3 : ffff801fb4a65000 x2 : ffff801fb4a0b000
>> [    7.316247] x1 : 0000000000000000 x0 : 0000000000000001
>> [    7.321613] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
>> [    7.328382] Call trace:
>> [    7.330847]  __ll_sc_atomic_sub_return+0x4/0x20
>> [    7.335420]  destroy_sched_domain+0x20/0x70
>> [    7.339642]  cpu_attach_domain+0xc8/0x2e8
>> [    7.343687]  build_sched_domains+0xd44/0xde0
>> [    7.347996]  sched_init_domains+0x68/0x88
>> [    7.352044]  sched_init_smp+0x2c/0x7c
>> [    7.355738]  kernel_init_freeable+0xdc/0x244
>> [    7.360049]  kernel_init+0x10/0x108
>> [    7.363567]  ret_from_fork+0x10/0x18
>> [    7.367174] Code: 88107c31 35ffffb0 d65f03c0 f9800031 (885f7c31)
>> [    7.373400] ---[ end trace 8150af869a14363f ]---
>> [    7.378076] Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b
>> [    7.378076]
>> [    7.387320] SMP: stopping secondary CPUs
>> [    7.391297] ---[ end Kernel panic - not syncing: Attempted to kill init!
>> exitcode=0x0000000b
>> [    7.391297]  ]---
>>
>> I will straightaway note that I have been fiddling with my board's device
>> tree, specifically (breaking!) the NUMA distance map, like this:
>>
>> distance-matrix = <0 0 10>,
>>                    <0 1 15>,
>>                    <0 2 20>,
>>                    <0 3 25>,
>>                    <1 0 15>,
>>                    <1 1 10>,
>>                    <1 2 25>,
>>                    <1 3 30>,
>>                    <2 0 20>,
>>                    <2 1 25>,
>>                    <2 2 10>,
>>                    <2 3 15>,
>>                    <3 0 10>,* should be same as 0->3 and > 10
>>                    <3 1 10>,* should be same as 1->3 and > 10
>>                    <3 2 15>,
>>                    <3 3 15>;* should be 10
>>
>> However I don't think that this should crash the kernel. I'd say
>> of_numa_parse_distance_map_v1() should robustly handle broken maps, probably
>> by erroring and causing NUMA to be disabled.
>
> If build with CONFIG_SCHED_DEBUG=y and boot with "sched_debug" I think
> sched_init_numa() should yell at you for the above 'mistake'.
>

Right, I have since turned on debug and it was complaining - I'll 
provide a log.

>> However I am interested to know if the scheduler crash is a real problem.
>
> Ideally we'd not crash of course.. let me see if I can still make sense
> of that topology code.

JFYI, https://lkml.org/lkml/2018/10/26/527

So it seems to be that setting the distance between separate nodes to 
LOCAL_DISTANCE causes the problem. x86 NUMA code - like arm64 - allows 
this. However ACPI SLIT validation rejects this, unlike OF distance map 
parsing.

Thanks,
John

