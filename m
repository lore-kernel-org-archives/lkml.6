Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C301C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD3C24B29
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD3C24B29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967501AbeF1RMK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:12:10 -0400
Received: from foss.arm.com ([217.140.101.70]:50652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967135AbeF1RMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:12:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3420A18A;
        Thu, 28 Jun 2018 10:12:09 -0700 (PDT)
Received: from [192.168.100.244] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FF583F318;
        Thu, 28 Jun 2018 10:12:08 -0700 (PDT)
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ard.biesheuvel@linaro.org, shunyong.yang@hxt-semitech.com,
        yu.zheng@hxt-semitech.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <d797ebc5-bd7b-4f72-d4fc-840ba7345a15@arm.com>
Date:   Thu, 28 Jun 2018 12:12:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/28/2018 11:30 AM, Sudeep Holla wrote:
> 
> 
> On 28/06/18 15:51, Andrew Jones wrote:
>> When booting with devicetree, and the devicetree has the cpu-map
>> node, the topology IDs that are visible from sysfs are generated
>> with counters. ACPI, on the other hand, uses ACPI table pointer
>> offsets, which, while guaranteed to be unique, look a bit weird.
>> Instead, we can generate DT identical topology IDs for ACPI by
>> just using counters for the leaf nodes and by remapping the
>> non-leaf table pointer offsets to counters.
>>
>> Cc: Jeremy Linton <jeremy.linton@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>> ---
>>
>> v1:
>> Reworked this since the RFC in order to make the algorithm more
>> obvious. It wasn't clear in the RFC that the ACPI nodes could be
>> in any order, although they could have been. I've tested that
>> this works with nodes in arbitrary order by hacking the QEMU
>> PPTT table generator[*].
>>
>> Note, while this produces equivalent topology IDs to what the
>> DT cpu-map node produces for all sane configs, if PEs are
>> threads (have MPIDR.MT set), but the cpu-map does not specify
>> threads, then, while the DT parsing code will happily call the
>> threads "cores", ACPI will see that the PPTT leaf nodes are for
>> threads and produce different topology IDs. I see this difference
>> as a bug with the DT parsing which can be addressed separately.
>>
>> [*] https://github.com/rhdrjones/qemu/commits/virt-cpu-topology
>>
>>
>>   arch/arm64/kernel/topology.c | 70 ++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 55 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index f845a8617812..7ef457401b24 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -316,6 +316,10 @@ static void __init reset_cpu_topology(void)
>>   }
>>   
>>   #ifdef CONFIG_ACPI
>> +
>> +#define acpi_topology_mktag(x)	(-((x) + 1))
>> +#define acpi_topology_istag(x)	((x) < 0)
>> +
>>   /*
>>    * Propagate the topology information of the processor_topology_node tree to the
>>    * cpu_topology array.
>> @@ -323,27 +327,31 @@ static void __init reset_cpu_topology(void)
>>   static int __init parse_acpi_topology(void)
>>   {
>>   	bool is_threaded;
>> -	int cpu, topology_id;
>> +	int package_id = 0;
>> +	int cpu, ret;
>>   
>>   	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>>   
>> +	/*
>> +	 * Loop through all PEs twice. In the first loop store parent
>> +	 * tags into the IDs. In the second loop we reset the IDs as
>> +	 * 0..N-1 per parent tag.
>> +	 */
>> +
>>   	for_each_possible_cpu(cpu) {
>>   		int i, cache_id;
>>   
>> -		topology_id = find_acpi_cpu_topology(cpu, 0);
>> -		if (topology_id < 0)
>> -			return topology_id;
>> -
>> -		if (is_threaded) {
>> -			cpu_topology[cpu].thread_id = topology_id;
>> -			topology_id = find_acpi_cpu_topology(cpu, 1);
>> -			cpu_topology[cpu].core_id   = topology_id;
>> -		} else {
>> -			cpu_topology[cpu].thread_id  = -1;
>> -			cpu_topology[cpu].core_id    = topology_id;
>> -		}
>> -		topology_id = find_acpi_cpu_topology_package(cpu);
>> -		cpu_topology[cpu].package_id = topology_id;
>> +		ret = find_acpi_cpu_topology(cpu, 0);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (is_threaded)
>> +			ret = find_acpi_cpu_topology(cpu, 1);
>> +		else
>> +			cpu_topology[cpu].thread_id = -1;
>> +		cpu_topology[cpu].core_id = acpi_topology_mktag(ret);
>> +		ret = find_acpi_cpu_topology_package(cpu);
>> +		cpu_topology[cpu].package_id = acpi_topology_mktag(ret);
> 
> I am not sure if we can ever guarantee that DT and ACPI will get the
> same ids whatever counter we use as it depends on the order presented in
> the firmware(DT or ACPI). So I am not for generating ids for core and
> threads in that way.
> 
> So I would like to keep it simple and just have this counters for
> package ids as demonstrated in Shunyong's patch.

So, currently on a non threaded system, the core id's look nice because 
they are just the ACPI ids. Its the package id's that look strange, we 
could just fix the package ids, but on threaded machines the threads 
have the nice acpi ids, and the core ids are then funny numbers. So, I 
suspect that is driving this as much as the strange package ids.

(and as a side, I actually like the PE has a acpi id behavior, but for 
threads its being lost with this patch...)

Given i've seen odd package/core ids on x86s a few years ago, it never 
bothered me much as a lot of userspace tools are just using what is 
effectively the logical processor number anyway.

Further, this table may be having some clarifications published for some 
of these fields. I'm not sure the final wording will help us, but it might.


> 
> 
> Also looking @ topology_get_acpi_cpu_tag again now, we should have
> valid flag check instead of level = 0. Jeremy ?

? I'm not sure I understand, but your saying for the leaf nodes we 
should be checking the valid flag rather than whether the caller 
requested level 0?

I don't think that is right. The original PPTT spec is unclear about 
proper use of the valid flag. So, while this part of the spec may be 
clarified in the near future, (AFAIK) there are already tables in the 
wild which fail to set valid on the leaf nodes! So I think using the 
level check is the safest at the moment.

Depending on what happens with the next rev of the ACPI spec (or 
whenever) some of this whole discussion might be bypassed simply by 
using whatever id is marked valid on the node, as you suggest, but until 
then...
