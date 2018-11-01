Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8415C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F2920820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F2920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeKATDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:03:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727453AbeKATDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:03:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71E4CD3E764F5;
        Thu,  1 Nov 2018 18:01:16 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 18:01:12 +0800
Subject: Re: Crash report: Broken NUMA distance map causes crash on arm64
 system
To:     Peter Zijlstra <peterz@infradead.org>
References: <b89bf686-05bd-a3de-e7ef-4ab9ab7bdb6c@huawei.com>
 <20181030092640.GE1459@hirez.programming.kicks-ass.net>
 <d126099d-2698-8e3a-06ca-f229e57c3052@huawei.com>
 <ae352fe1-3c59-dcde-fd00-2c03b4491dc6@huawei.com>
 <20181031204622.GB3141@hirez.programming.kicks-ass.net>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bf2b890a-4ce7-d0f6-0663-84a1a6e8dbd2@huawei.com>
Date:   Thu, 1 Nov 2018 10:01:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181031204622.GB3141@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2018 20:46, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 03:35:35PM +0000, John Garry wrote:
>> [    7.154740] ERROR: Node-distance not symmetric
>> [    7.154740]
>> [    7.160724]   10 15 20 25
>> [    7.163456]   15 10 25 30
>> [    7.166190]   20 25 10 15
>> [    7.168921]   10 10 15 10
>> [    7.171655]
>
> But I'm not getting the rest of those errors with my 'reproducer':
>
>   kvm -smp 4 -m 4G -display none -monitor null -serial stdio -kernel defconfig-build/arch/x86/boot/bzImage -append "sched_debug debug ignore_loglevel earlyprintk=serial,ttyS0,115200,keep numa=fake=4:10,15,20,25,15,10,25,30,20,25,10,15,10,10,15,10,0"
>
> [    0.828331] ERROR: Node-distance not symmetric
> [    0.828331]
> [    0.829081]   10 15 20 25
> [    0.830079]   15 10 25 30
> [    0.831079]   20 25 10 15
> [    0.832079]   10 10 15 10
> [    0.833079]
> [    0.834373] CPU0 attaching sched-domain(s):
> [    0.835082]  domain-0: span=0-3 level=DIE
> [    0.836079]   groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }
> [    0.837082] CPU1 attaching sched-domain(s):
> [    0.838081]  domain-0: span=0-3 level=DIE
> [    0.839079]   groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 0:{ span=0 }
> [    0.840082] CPU2 attaching sched-domain(s):
> [    0.841080]  domain-0: span=0-3 level=DIE
> [    0.842079]   groups: 2:{ span=2 }, 3:{ span=3 }, 0:{ span=0 }, 1:{ span=1 }
> [    0.843094] ------------[ cut here ]------------
> [    0.844076] kernel BUG at ../mm/slub.c:3901!
> [    0.844083] invalid opcode: 0000 [#1] SMP PTI
> [    0.845076] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc8+ #305
> [    0.845076] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.845076] RIP: 0010:kfree+0x113/0x160
> [    0.845076] Code: 18 48 89 da 4c 89 e6 e8 db 01 c5 00 48 8b 45 00 48 85 c0 75 e4 e9 0e ff ff ff 49 8b 02 f6 c4 80 75 0a 49 8b 42 08 a8 01 75 02 <0f> 0b 49 8b 02 31 f6 f6 c4 80 74 05 41 0f b6 72 51 5b 5d 41 5c 4c
> [    0.845076] RSP: 0000:ffffabc080633dc8 EFLAGS: 00010246
> [    0.845076] RAX: ffff9f973fff8da0 RBX: ffff9f970000001e RCX: 00000000000000f9
> [    0.845076] RDX: 0000000000000000 RSI: ffff9f963ea23c80 RDI: 0000606980000000
> [    0.845076] RBP: 0000000000020ac0 R08: 0000000000023c80 R09: ffffffff9f8a10db
> [    0.845076] R10: fffff17204000000 R11: 0000000000000001 R12: ffffffff9f8a113d
> [    0.845076] R13: 0000000000000003 R14: ffffffffa0ab4820 R15: ffff9f973e5bde00
> [    0.845076] FS:  0000000000000000(0000) GS:ffff9f963ea00000(0000) knlGS:0000000000000000
> [    0.845076] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.845076] CR2: 00000000ffffffff CR3: 000000008ea0a000 CR4: 00000000000006f0
> [    0.845076] Call Trace:
> [    0.845076]  destroy_sched_domain+0x3d/0x50
> [    0.845076]  cpu_attach_domain+0x378/0x680
> [    0.845076]  ? update_group_capacity+0x20/0x2c0
> [    0.845076]  build_sched_domains+0xde9/0xed0
> [    0.845076]  ? set_debug_rodata+0xc/0xc
> [    0.845076]  sched_init_domains+0x80/0x90
> [    0.845076]  sched_init_smp+0x1d/0x63
> [    0.845076]  kernel_init_freeable+0x101/0x23f
> [    0.845076]  ? rest_init+0xb0/0xb0
> [    0.845076]  kernel_init+0x5/0x100
> [    0.845076]  ret_from_fork+0x35/0x40
>
> I'll work on that crash though..

The actual crash callchain seems to be
destroy_sched_domain()->free_sched_groups():

static void free_sched_groups(struct sched_group *sg, int free_sgc)
{
...
     do {
         tmp = sg->next;

         if (free_sgc && atomic_dec_and_test(&sg->sgc->ref))***
             kfree(sg->sgc);

...
}

*** crash occurs when free_sgc is non-zero and sg->sgc is NULL

And, as I mentioned earlier, I bisected this problem to 58d5af59d55b.

>
>> I also note that if I apply the patch, below, to reject the invalid NUMA
>> distance, we're still getting a warning/error:
>>
>> [    7.144407] CPU: All CPU(s) started at EL2
>> [    7.148678] alternatives: patching kernel code
>> [    7.153557] ERROR: Node-0 not representative
>> [    7.153557]
>> [    7.159365]   10 15 20 25
>> [    7.162097]   15 10 25 30
>> [    7.164832]   20 25 10 15
>> [    7.167562]   25 30 15 10
>
> Yeah, that's an 'obviously' broken topology too.
>

AFAICT, this conforms to ACPI spec SLIT rules, and the kernel SLIT 
validation allows this also. So maybe we should shout louder here or 
even mark the SLIT as invalid if totally broken.

> Clearly you're far more creative than the ACPI BIOS people have been so
> far.

Cheers,
John


