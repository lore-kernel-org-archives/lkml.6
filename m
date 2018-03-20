Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELtatQTeV1pSUJ1iq54mcJWjxqnhnIgq/+Qi3QbNfUCFW4s9gc2vsrxL9Oghd79ySRsBxr2k
ARC-Seal: i=1; a=rsa-sha256; t=1521555865; cv=none;
        d=google.com; s=arc-20160816;
        b=wgCyNTY11DYrT7/Nf1bCfJ7crVunPR2uVN3LWD14quDJWdcktx7HVv/g5p0pq+68Hn
         ijh581dcrYFcORUzeYWJij1rJgdlxHS3Dy7zNYEpJnnlGB169S3pMqmgH0O5oQUcuvfs
         ZF12Zhfm+SjMEOrOnPmlef/FZ00/nLFiIyNSkj+EnyfKYhA1hiTY3rXFut6ZaqZsWLlW
         8jspBXdM7ZGXYzrkrHQUzZ8l9Xq3pKV/njcccklJFUrAOI5VsQ8l4sgX3T5TU3i3cE4Z
         ZSpZ/XkMi2oRliboJ7IqlY+qhDYutc3GlJr6pT3UyaQpLZsTaWGaE1IZQzezfjzO8eMl
         i1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+NCUIpVa17bIdY+VdzeYHJaMdDNxkX/SLEZRRWk2Wps=;
        b=j9D6MT+NOlRxabdltB/SMk73/P0uFK65gHQaPpkQ9aAecr430T8zrSxSe96LXV3w/3
         YSfZTS7dCsCVCsioVA5ePsr8USnD+FvC0TZM8dic7lV7E/S50PAlDWts2hTTKwBu4m7t
         1kNaY4lifk5x74vPQyyfmOdnohiMUpdLhQCWzhpHB/bUI3cJ+HAOUkc+ez3zYiMH2clG
         w6PT229X51Wiw+lLgjflKi9aqgZBvmiXc6+tVw3S+UiLlDEXgqcegrojC3g/ATDyQLw+
         FubWd9N0jucQE4HHoNX5UVPl3AGEKUNqPWvwTxyK1B4MtBEA+2VPkuUbnGgw4t+bS1qA
         27og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v7 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
 will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org,
 mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
 vkilari@codeaurora.org, ahs3@redhat.com, dietmar.eggemann@arm.com,
 morten.rasmussen@arm.com, palmer@sifive.com, lenb@kernel.org,
 john.garry@huawei.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-6-jeremy.linton@arm.com>
 <2844054.uKnBIypXtU@aspire.rjw.lan>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <65d44c09-b88c-3df1-c66b-7d12a4038c43@arm.com>
Date: Tue, 20 Mar 2018 08:25:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2844054.uKnBIypXtU@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684148891338280?=
X-GMAIL-MSGID: =?utf-8?q?1595466963190165682?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for taking a look at this.

On 03/19/2018 05:46 AM, Rafael J. Wysocki wrote:
> On Wednesday, February 28, 2018 11:06:11 PM CET Jeremy Linton wrote:
>> ACPI 6.2 adds a new table, which describes how processing units
>> are related to each other in tree like fashion. Caches are
>> also sprinkled throughout the tree and describe the properties
>> of the caches in relation to other caches and processing units.
>>
>> Add the code to parse the cache hierarchy and report the total
>> number of levels of cache for a given core using
>> acpi_find_last_cache_level() as well as fill out the individual
>> cores cache information with cache_setup_acpi() once the
>> cpu_cacheinfo structure has been populated by the arch specific
>> code.
>>
>> An additional patch later in the set adds the ability to report
>> peers in the topology using find_acpi_cpu_topology()
>> to report a unique ID for each processing unit at a given level
>> in the tree. These unique id's can then be used to match related
>> processing units which exist as threads, COD (clusters
>> on die), within a given package, etc.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> A couple of cosmetic comments.
> 
>> ---
>>   drivers/acpi/pptt.c | 488 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 488 insertions(+)
>>   create mode 100644 drivers/acpi/pptt.c
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> new file mode 100644
>> index 000000000000..883e4318c6cd
>> --- /dev/null
>> +++ b/drivers/acpi/pptt.c
>> @@ -0,0 +1,488 @@
> 
> Use an SPDX license ID here and then you don't need the license boilerplate
> below.

Sure, good point!

> 
>> +/*
>> + * Copyright (C) 2018, ARM
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * This file implements parsing of Processor Properties Topology Table (PPTT)
>> + * which is optionally used to describe the processor and cache topology.
>> + * Due to the relative pointers used throughout the table, this doesn't
>> + * leverage the existing subtable parsing in the kernel.
>> + *
>> + * The PPTT structure is an inverted tree, with each node potentially
>> + * holding one or two inverted tree data structures describing
>> + * the caches available at that level. Each cache structure optionally
>> + * contains properties describing the cache at a given level which can be
>> + * used to override hardware probed values.
>> + */
>> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cacheinfo.h>
>> +#include <acpi/processor.h>
>> +
>> +/*
>> + * Given the PPTT table, find and verify that the subtable entry
>> + * is located within the table
>> + */
> 
> If you add a comment above a function, make it a kerneldoc.  That
> never hurts, but really helps sometimes.

Sure, I did that for the visible symbols. I will convert the internal 
ones as well.

> 
>> +static struct acpi_subtable_header *fetch_pptt_subtable(
> 
> Don't break the line here, it can be broken after the first arg.
> 
> That's OK even if it is more than 80 chars long.
> 
>> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
>> +{
>> +	struct acpi_subtable_header *entry;
>> +
>> +	/* there isn't a subtable at reference 0 */
>> +	if (pptt_ref < sizeof(struct acpi_subtable_header))
>> +		return NULL;
>> +
>> +	if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
>> +		return NULL;
>> +
>> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
>> +
>> +	if (pptt_ref + entry->length > table_hdr->length)
>> +		return NULL;
>> +
>> +	return entry;
>> +}
>> +
>> +static struct acpi_pptt_processor *fetch_pptt_node(
>> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
>> +{
>> +	return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr,
>> +								 pptt_ref);
> 
> You don't need to break this line too.

Sure.

> 
>> +}
>> +
>> +static struct acpi_pptt_cache *fetch_pptt_cache(
>> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
>> +{
>> +	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr,
>> +							     pptt_ref);
> 
> And here.
> 
>> +}
>> +
>> +static struct acpi_subtable_header *acpi_get_pptt_resource(
>> +	struct acpi_table_header *table_hdr,
>> +	struct acpi_pptt_processor *node, int resource)
>> +{
>> +	u32 *ref;
>> +
>> +	if (resource >= node->number_of_priv_resources)
>> +		return NULL;
>> +
>> +	ref = ACPI_ADD_PTR(u32, node, sizeof(struct acpi_pptt_processor));
>> +	ref += resource;
>> +
>> +	return fetch_pptt_subtable(table_hdr, *ref);
>> +}
>> +
>> +/*
>> + * Match the type passed and special case the TYPE_UNIFIED so that
>> + * it match both ACPI_PPTT_CACHE_TYPE_UNIFIED(_ALT) types.
>> + */
>> +static inline bool acpi_pptt_match_type(int table_type, int type)
>> +{
>> +	return (((table_type & ACPI_PPTT_MASK_CACHE_TYPE) == type) ||
>> +		(table_type & ACPI_PPTT_CACHE_TYPE_UNIFIED & type));
>> +}
>> +
>> +/*
>> + * Attempt to find a given cache level, while counting the max number
>> + * of cache levels for the cache node.
>> + *
>> + * Given a pptt resource, verify that it is a cache node, then walk
>> + * down each level of caches, counting how many levels are found
>> + * as well as checking the cache type (icache, dcache, unified). If a
>> + * level & type match, then we set found, and continue the search.
>> + * Once the entire cache branch has been walked return its max
>> + * depth.
>> + */
>> +static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>> +				int local_level,
>> +				struct acpi_subtable_header *res,
>> +				struct acpi_pptt_cache **found,
>> +				int level, int type)
>> +{
>> +	struct acpi_pptt_cache *cache;
>> +
>> +	if (res->type != ACPI_PPTT_TYPE_CACHE)
>> +		return 0;
>> +
>> +	cache = (struct acpi_pptt_cache *) res;
>> +	while (cache) {
>> +		local_level++;
>> +
>> +		if ((local_level == level) &&
>> +		    (cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) &&
>> +		    acpi_pptt_match_type(cache->attributes, type)) {
>> +			if ((*found != NULL) && (cache != *found))
> 
> Inner parens are not necessary (and above and in some other places too).
Sure.

> 
>> +				pr_err("Found duplicate cache level/type unable to determine uniqueness\n");
> 
> This is not an error, rather a statement that something is inconsistent in the
> ACPI table, so please consider using a different log level here.

pr_warn seems to be the other common choice in the acpi directory for 
table errors, I will will use that.


> 
> [cut]
> 
> I guess I could post similar comments for the other general ACPI patches in
> this series, so please address them in there too if applicable.
> 

Ok, I will look over them again.

Thanks,


> Thanks!
> 
