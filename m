Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D07C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06A52177A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06A52177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeHUUIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:08:42 -0400
Received: from foss.arm.com ([217.140.101.70]:52138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbeHUUIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:08:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25178ED1;
        Tue, 21 Aug 2018 09:47:49 -0700 (PDT)
Received: from [10.37.12.203] (unknown [10.37.12.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9743F5BC;
        Tue, 21 Aug 2018 09:47:44 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
 /proc/iomem
From:   James Morse <james.morse@arm.com>
To:     John Stultz <john.stultz@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        G Gregory <graeme.gregory@linaro.org>, al.stone@linaro.org,
        bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
        hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        dyoung@redhat.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
 <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
 <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
Message-ID: <55a21245-7bc2-a700-20ce-1103fbadf72b@arm.com>
Date:   Tue, 21 Aug 2018 17:48:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 11:22 AM, James Morse wrote:
> On 08/21/2018 05:39 AM, John Stultz wrote:
>> On Sun, Jul 22, 2018 at 6:57 PM, AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> There has been some confusion around what is necessary to prevent kexec
>>> overwriting important memory regions. memblock: reserve, or nomap?
>>> Only memblock nomap regions are reported via /proc/iomem, kexec's
>>> user-space doesn't know about memblock_reserve()d regions.
>>>
>>> Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
>>> as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
>>> and thus possible for kexec to overwrite with the new kernel or initrd.
>>> But this was always broken, as the UEFI memory map is also reserved
>>> and not marked as nomap.
>>>
>>> Exporting both nomap and reserved memblock types is a nuisance as
>>> they live in different memblock structures which we can't walk at
>>> the same time.
>>>
>>> Take a second walk over memblock.reserved and add new 'reserved'
>>> subnodes for the memblock_reserved() regions that aren't already
>>> described by the existing code. (e.g. Kernel Code)
>>>
>>> We use reserve_region_with_split() to find the gaps in existing named
>>> regions. This handles the gap between 'kernel code' and 'kernel data'
>>> which is memblock_reserve()d, but already partially described by
>>> request_standard_resources(). e.g.:
>>> | 80000000-dfffffff : System RAM
>>> |   80080000-80ffffff : Kernel code
>>> |   81000000-8158ffff : reserved
>>> |   81590000-8237efff : Kernel data
>>> |   a0000000-dfffffff : Crash kernel
>>> | e00f0000-f949ffff : System RAM
>>>
>>> reserve_region_with_split needs kzalloc() which isn't available when
>>> request_standard_resources() is called, use an initcall.
> 
>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index 30ad2f085d1f..5b4fac434c84 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -241,6 +241,44 @@ static void __init request_standard_resources(void)
> 
>>> +static int __init reserve_memblock_reserved_regions(void)
> 
>>> +       for_each_reserved_mem_region(i, &start, &end) {
>>> +               if (end <= roundup_end)
>>> +                       continue; /* done already */
>>> +
>>> +               start = __pfn_to_phys(PFN_DOWN(start));
>>> +               end = __pfn_to_phys(PFN_UP(end)) - 1;
>>> +               roundup_end = end;
>>> +
>>> +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
>>> +               if (WARN_ON(!res))
>>> +                       return -ENOMEM;
>>> +               res->start = start;
>>> +               res->end = end;
>>> +               res->name  = "reserved";
>>> +               res->flags = IORESOURCE_MEM;
>>> +
>>> +               mem = request_resource_conflict(&iomem_resource, res);
>>> +               /*
>>> +                * We expected memblock_reserve() regions to conflict with
>>> +                * memory created by request_standard_resources().
>>> +                */
>>> +               if (WARN_ON_ONCE(!mem))


>> Since this patch landed, on the HiKey board at bootup I'm seeing:
>>
>> [    0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
>> reserve_memblock_reserved_regions+0xd4/0x13c

>>  From skimming the patch, it seems this is maybe expected? Or should
>> this warning raise eyebrows? I can't quite figure it out.
> 
> Ugh, sorry for the noise! This is warning that there is something wrong
> with our assumptions about what types of memory exist.
> 
> 
>> It seems to trigger on the pstore memory at 0x21f00000-0x21ffffff.
> 
> ... pmem ...


> So, this is a memblock_reserved() range that isn't actually memory.
> 
> This happens because your DT has carved these regions out of the memory
> node, but added a named 'reserved-memory' region for them, just in case?
> I'm not sure what it means if 'reserved-memory' is not also described as
> memory....
> 
> You do need the carve-out, otherwise this gets covered by the linear
> map, and when you throw in that 'unbuffered' property you get both a
> cacheable and uncacheable mapping of the same page.


Hmm, looks like its (even) more complicated than I thought, of_reserved_mem.c's 
definition of 'nomap' is memblock_remove(), not memblock_mark_nomap().

This might be more common to all users of DTs memreserve.


Thanks,

James
