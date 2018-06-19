Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D7BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92E5204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92E5204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966551AbeFSPAM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:00:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51950 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965698AbeFSPAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:00:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 678E480D;
        Tue, 19 Jun 2018 08:00:10 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73B723F557;
        Tue, 19 Jun 2018 08:00:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        graeme.gregory@linaro.org, al.stone@linaro.org,
        bhsharma@redhat.com, tbaicar@codeaurora.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com,
        linux-arm-kernel@lists.infradead.org
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
 <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com>
Date:   Tue, 19 Jun 2018 16:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 19/06/18 14:37, Dave Kleikamp wrote:
> On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:
>> +static int __init reserve_memblock_reserved_regions(void)
>> +{
>> +	phys_addr_t start, end, roundup_end = 0;
>> +	struct resource *mem, *res;
>> +	u64 i;
>> +
>> +	for_each_reserved_mem_region(i, &start, &end) {
>> +		if (end <= roundup_end)
>> +			continue; /* done already */
>> +
>> +		start = __pfn_to_phys(PFN_DOWN(start));
>> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
>> +		roundup_end = end;
>> +
>> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
>> +		if (WARN_ON(!res))
>> +			return -ENOMEM;
>> +		res->start = start;
>> +		res->end = end;
>> +		res->name  = "reserved";
>> +		res->flags = IORESOURCE_MEM;
>> +
>> +		mem = request_resource_conflict(&iomem_resource, res);
>> +		/*
>> +		 * We expected memblock_reserve() regions to conflict with
>> +		 * memory created by request_standard_resources().
>> +		 */
>> +		if (WARN_ON_ONCE(!mem))
>> +			continue;
>> +		kfree(res);
> 
> Why is kfree() after the conditional continue? This is a memory leak.

request_resource_conflict() inserts res into the iomem_resource tree, or returns
the conflict if there is already something at this address.

We expect something at this address: a 'System RAM' section added by
request_resource(). This code wants the conflicting 'System RAM' entry so that
reserve_region_with_split() can fill in the gaps below it with 'reserved'. See
the commit-message for an example.

If there was no conflict, it means the memory map doesn't look like we expect,
we can't pass NULL to reserve_region_with_split(), and we just inserted the
'reserved' at the top level. Freeing res at this point would be a use-after-free
hanging from /proc/iomem.
This code generates a WARN_ON_ONCE() and leaves the 'reserved' description where
it is.

Trying to cleanup here is pointless, we can remove the resource entry and free
it ... but we still want to report it as reserved, which is what just happened,
just not quite how we we wanted it.

If you ever see this warning, it means some RAM stopped being nomap between
request_resources() and reserve_memblock_reserved_regions(). I can't find any
case where that ever happens.


If all that makes sense: how can I improve the comment above the WARN_ON_ONCE()
to make it clearer?


Thanks,

James


>> +
>> +		reserve_region_with_split(mem, start, end, "reserved");
>> +	}
>> +
>> +	return 0;
>> +}
>> +arch_initcall(reserve_memblock_reserved_regions);
>> +
>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>  
>>  void __init setup_arch(char **cmdline_p)
>>

