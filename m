Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9D20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD9D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbeIKTGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:06:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbeIKTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:06:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BE4Krf087302
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:06:30 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2medw54246-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:06:30 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 08:06:27 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 08:06:25 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BE6Og141484348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 07:06:24 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C4E4136053;
        Tue, 11 Sep 2018 08:06:24 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB48C136051;
        Tue, 11 Sep 2018 08:06:22 -0600 (MDT)
Received: from [9.152.99.211] (unknown [9.152.99.211])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Sep 2018 08:06:22 -0600 (MDT)
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
To:     Michal Hocko <mhocko@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        osalvador@suse.de, gerald.schaefer@de.ibm.com
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
From:   Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>
Date:   Tue, 11 Sep 2018 16:06:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910131754.GG10951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091114-0020-0000-0000-00000E62682A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009703; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01086779; UDB=6.00561133; IPR=6.00866791;
 MB=3.00023231; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-11 14:06:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091114-0021-0000-0000-000062FD2808
Message-Id: <04b427ad-df4e-67bd-2942-2a7a2cccf1aa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.09.2018 15:17, Michal Hocko wrote:
> [Cc Pavel]
>
> On Mon 10-09-18 14:35:27, Mikhail Zaslonko wrote:
>> If memory end is not aligned with the linux memory section boundary, such
>> a section is only partly initialized. This may lead to VM_BUG_ON due to
>> uninitialized struct pages access from is_mem_section_removable() or
>> test_pages_in_a_zone() function.
>>
>> Here is one of the panic examples:
>>   CONFIG_DEBUG_VM_PGFLAGS=y
>>   kernel parameter mem=3075M
> OK, so the last memory section is not full and we have a partial memory
> block right?

Right. In my example above, I define 3075M (3Gig + 3Meg) of base memory 
in the
kernel parameters. As a result we end up with the last memory block 
having only
3 megabytes initialized. The initialization takes place within
memmap_init_zone(unsigned long size, ...) function called from
free_area_init_core() with the size = zone->spanned_pages. Thus, only three
megabytes of the last memory block are initialized (till the end of the zone
Normal). And with the page poisoning introduced by Pavel we fail on such a
memory block processing in memory_hotplug code (no actual memory hotplug
is involved here).

>
>>   page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> OK, this means that the struct page is not fully initialized. Do you
> have a specific place which has triggered this assert?

This assert is triggered in page_to_nid() function when it is called for
uninitialized page. I found two places where that can happen:
1) is_pageblock_removable_nolock() - direct call
2) test_pages_in_a_zone() - via page_zone() call

>
>>   ------------[ cut here ]------------
>>   Call Trace:
>>   ([<000000000039b8a4>] is_mem_section_removable+0xcc/0x1c0)
>>    [<00000000009558ba>] show_mem_removable+0xda/0xe0
>>    [<00000000009325fc>] dev_attr_show+0x3c/0x80
>>    [<000000000047e7ea>] sysfs_kf_seq_show+0xda/0x160
>>    [<00000000003fc4e0>] seq_read+0x208/0x4c8
>>    [<00000000003cb80e>] __vfs_read+0x46/0x180
>>    [<00000000003cb9ce>] vfs_read+0x86/0x148
>>    [<00000000003cc06a>] ksys_read+0x62/0xc0
>>    [<0000000000c001c0>] system_call+0xdc/0x2d8
>>
>> This fix checks if the page lies within the zone boundaries before
>> accessing the struct page data. The check is added to both functions.
>> Actually similar check has already been present in
>> is_pageblock_removable_nolock() function but only after the struct page
>> is accessed.
>>
> Well, I am afraid this is not the proper solution. We are relying on the
> full pageblock worth of initialized struct pages at many other place. We
> used to do that in the past because we have initialized the full
> section but this has been changed recently. Pavel, do you have any ideas
> how to deal with this partial mem sections now?

I think this is not related to the recent changes of memory 
initialization. If
you mean deferred init case, the problem exists even without
CONFIG_DEFERRED_STRUCT_PAGE_INIT kernel option.

>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   mm/memory_hotplug.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 9eea6e809a4e..8e20e8fcc3b0 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1229,9 +1229,8 @@ static struct page *next_active_pageblock(struct page *page)
>>   	return page + pageblock_nr_pages;
>>   }
>>   
>> -static bool is_pageblock_removable_nolock(struct page *page)
>> +static bool is_pageblock_removable_nolock(struct page *page, struct zone **zone)
>>   {
>> -	struct zone *zone;
>>   	unsigned long pfn;
>>   
>>   	/*
>> @@ -1241,15 +1240,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
>>   	 * We have to take care about the node as well. If the node is offline
>>   	 * its NODE_DATA will be NULL - see page_zone.
>>   	 */
>> -	if (!node_online(page_to_nid(page)))
>> -		return false;
>> -
>> -	zone = page_zone(page);
>>   	pfn = page_to_pfn(page);
>> -	if (!zone_spans_pfn(zone, pfn))
>> +	if (*zone && !zone_spans_pfn(*zone, pfn))
>>   		return false;
>> +	if (!node_online(page_to_nid(page)))
>> +		return false;
>> +	*zone = page_zone(page);
>>   
>> -	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
>> +	return !has_unmovable_pages(*zone, page, 0, MIGRATE_MOVABLE, true);
>>   }
>>   
>>   /* Checks if this range of memory is likely to be hot-removable. */
>> @@ -1257,10 +1255,11 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
>>   {
>>   	struct page *page = pfn_to_page(start_pfn);
>>   	struct page *end_page = page + nr_pages;
>> +	struct zone *zone = NULL;
>>   
>>   	/* Check the starting page of each pageblock within the range */
>>   	for (; page < end_page; page = next_active_pageblock(page)) {
>> -		if (!is_pageblock_removable_nolock(page))
>> +		if (!is_pageblock_removable_nolock(page, &zone))
>>   			return false;
>>   		cond_resched();
>>   	}
>> @@ -1296,6 +1295,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
>>   				i++;
>>   			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
>>   				continue;
>> +			/* Check if we got outside of the zone */
>> +			if (zone && !zone_spans_pfn(zone, pfn))
>> +				return 0;
>>   			page = pfn_to_page(pfn + i);
>>   			if (zone && page_zone(page) != zone)
>>   				return 0;
>> -- 
>> 2.16.4

