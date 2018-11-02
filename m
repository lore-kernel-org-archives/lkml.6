Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13121C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14222081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14222081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeKBTRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:17:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbeKBTRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:17:46 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 826568AAB09BF;
        Fri,  2 Nov 2018 18:11:04 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 2 Nov 2018
 18:10:55 +0800
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
To:     Peter Zijlstra <peterz@infradead.org>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
 <20181031204622.GB3141@hirez.programming.kicks-ass.net>
 <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
 <20181102093904.GJ3178@hirez.programming.kicks-ass.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        <suravee.suthikulpanit@amd.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d6d7485a-a7c9-5327-fb47-f279d260ec44@huawei.com>
Date:   Fri, 2 Nov 2018 10:10:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181102093904.GJ3178@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> static void free_sched_groups(struct sched_group *sg, int free_sgc)
>> {
>> ...
>>     do {
>>         tmp = sg->next;
>>
>>         if (free_sgc && atomic_dec_and_test(&sg->sgc->ref))***
>>             kfree(sg->sgc);
>>
>> ...
>> }
>>
>> *** crash occurs when free_sgc is non-zero and sg->sgc is NULL
>
> Yeah, turns out to be random memory corruption; I've had the crash in a
> number of weird places; also GCC version dependent.
>
> KASAN is awesome and pinpointed the problem though.
>
>> And, as I mentioned earlier, I bisected this problem to 58d5af59d55b.
>
> You mean:
>
>   051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")
>
> right? and yes indeed! The below fixes my reproducer:
>

Yes, that's the one.

>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9d74371e4aad..039578429c25 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1337,7 +1348,7 @@ void sched_init_numa(void)
>  	int level = 0;
>  	int i, j, k;
>
> -	sched_domains_numa_distance = kzalloc(sizeof(int) * nr_node_ids, GFP_KERNEL);
> +	sched_domains_numa_distance = kzalloc(sizeof(int) * (nr_node_ids + 1), GFP_KERNEL);

Good find.

>  	if (!sched_domains_numa_distance)
>  		return;
>
>

So what about this:
 >>> I also note that if I apply the patch, below, to reject the invalid 
NUMA
 >>> distance, we're still getting a warning/error:
 >>>
 >>> [    7.144407] CPU: All CPU(s) started at EL2
 >>> [    7.148678] alternatives: patching kernel code
 >>> [    7.153557] ERROR: Node-0 not representative
 >>> [    7.153557]
 >>> [    7.159365]   10 15 20 25
 >>> [    7.162097]   15 10 25 30
 >>> [    7.164832]   20 25 10 15
 >>> [    7.167562]   25 30 15 10
 >>
 >> Yeah, that's an 'obviously' broken topology too.
 >>
 >
 > AFAICT, this conforms to ACPI spec SLIT rules, and the kernel SLIT
 > validation allows this also. So maybe we should shout louder here or
 > even mark the SLIT as invalid if totally broken.
 >

I plan to fix up OF map parsing to reject invalid distance maps.

However is this distance map so broken for the scheduler that it's 
better to reject this "valid" distance map also? If not, it may be nice 
for the user to know about it without having to enable scheduler debugging.

Thanks,
John

