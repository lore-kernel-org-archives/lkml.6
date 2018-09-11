Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A6C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BDF2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BDF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeIKTHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:07:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbeIKTHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:07:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BE5Uv7088483
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:08:16 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2meetv16a5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 10:08:15 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zaslonko@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 08:08:15 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 08:08:11 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BE8AVI56688714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 07:08:10 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CA013604F;
        Tue, 11 Sep 2018 08:08:10 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE989136051;
        Tue, 11 Sep 2018 08:08:08 -0600 (MDT)
Received: from [9.152.99.211] (unknown [9.152.99.211])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Sep 2018 08:08:08 -0600 (MDT)
Subject: Re: [PATCH] memory_hotplug: fix the panic when memory end is not on
 the section boundary
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "gerald.schaefer@de.ibm.com" <gerald.schaefer@de.ibm.com>
References: <20180910123527.71209-1-zaslonko@linux.ibm.com>
 <20180910131754.GG10951@dhcp22.suse.cz>
 <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
From:   Zaslonko Mikhail <zaslonko@linux.vnet.ibm.com>
Date:   Tue, 11 Sep 2018 16:08:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e8d75768-9122-332b-3b16-cad032aeb27f@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18091114-0004-0000-0000-00001487E7DD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009703; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01086780; UDB=6.00561133; IPR=6.00866791;
 MB=3.00023231; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-11 14:08:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091114-0005-0000-0000-000088C61226
Message-Id: <639fd656-033b-0fdb-a182-83d4acf7fe2b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.09.2018 15:46, Pasha Tatashin wrote:
>
> On 9/10/18 9:17 AM, Michal Hocko wrote:
>> [Cc Pavel]
>>
>> On Mon 10-09-18 14:35:27, Mikhail Zaslonko wrote:
>>> If memory end is not aligned with the linux memory section boundary, such
>>> a section is only partly initialized. This may lead to VM_BUG_ON due to
>>> uninitialized struct pages access from is_mem_section_removable() or
>>> test_pages_in_a_zone() function.
>>>
>>> Here is one of the panic examples:
>>>   CONFIG_DEBUG_VM_PGFLAGS=y
>>>   kernel parameter mem=3075M
>> OK, so the last memory section is not full and we have a partial memory
>> block right?
>>
>>>   page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>> OK, this means that the struct page is not fully initialized. Do you
>> have a specific place which has triggered this assert?
>>
>>>   ------------[ cut here ]------------
>>>   Call Trace:
>>>   ([<000000000039b8a4>] is_mem_section_removable+0xcc/0x1c0)
>>>    [<00000000009558ba>] show_mem_removable+0xda/0xe0
>>>    [<00000000009325fc>] dev_attr_show+0x3c/0x80
>>>    [<000000000047e7ea>] sysfs_kf_seq_show+0xda/0x160
>>>    [<00000000003fc4e0>] seq_read+0x208/0x4c8
>>>    [<00000000003cb80e>] __vfs_read+0x46/0x180
>>>    [<00000000003cb9ce>] vfs_read+0x86/0x148
>>>    [<00000000003cc06a>] ksys_read+0x62/0xc0
>>>    [<0000000000c001c0>] system_call+0xdc/0x2d8
>>>
>>> This fix checks if the page lies within the zone boundaries before
>>> accessing the struct page data. The check is added to both functions.
>>> Actually similar check has already been present in
>>> is_pageblock_removable_nolock() function but only after the struct page
>>> is accessed.
>>>
>> Well, I am afraid this is not the proper solution. We are relying on the
>> full pageblock worth of initialized struct pages at many other place. We
>> used to do that in the past because we have initialized the full
>> section but this has been changed recently. Pavel, do you have any ideas
>> how to deal with this partial mem sections now?
> We have:
>
> remove_memory()
> 	BUG_ON(check_hotplug_memory_range(start, size))
>
> That supposed to safely check for this condition: if [start, start +
> size) not block size aligned (and we know block size is section
> aligned), hot remove is not allowed. The problem is this check is late,
> and only happens when invalid range has already passed through previous
> checks.
>
> We could add check_hotplug_memory_range() to is_mem_section_removable():
>
> is_mem_section_removable(start_pfn, nr_pages)
>   if (check_hotplug_memory_range(PFN_PHYS(start_pfn), PFN_PHYS(nr_pages)))
>    return false;
>
> I think it should work.

I don't think so since is_mem_section_removable() is called for for the 
entire
section. Thus [start_pfn, start_pfn + nr_pages) is always memory block 
aligned.

>
> Pavel
>
>>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>>> Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>   mm/memory_hotplug.c | 20 +++++++++++---------
>>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index 9eea6e809a4e..8e20e8fcc3b0 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -1229,9 +1229,8 @@ static struct page *next_active_pageblock(struct page *page)
>>>   	return page + pageblock_nr_pages;
>>>   }
>>>   
>>> -static bool is_pageblock_removable_nolock(struct page *page)
>>> +static bool is_pageblock_removable_nolock(struct page *page, struct zone **zone)
>>>   {
>>> -	struct zone *zone;
>>>   	unsigned long pfn;
>>>   
>>>   	/*
>>> @@ -1241,15 +1240,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
>>>   	 * We have to take care about the node as well. If the node is offline
>>>   	 * its NODE_DATA will be NULL - see page_zone.
>>>   	 */
>>> -	if (!node_online(page_to_nid(page)))
>>> -		return false;
>>> -
>>> -	zone = page_zone(page);
>>>   	pfn = page_to_pfn(page);
>>> -	if (!zone_spans_pfn(zone, pfn))
>>> +	if (*zone && !zone_spans_pfn(*zone, pfn))
>>>   		return false;
>>> +	if (!node_online(page_to_nid(page)))
>>> +		return false;
>>> +	*zone = page_zone(page);
>>>   
>>> -	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
>>> +	return !has_unmovable_pages(*zone, page, 0, MIGRATE_MOVABLE, true);
>>>   }
>>>   
>>>   /* Checks if this range of memory is likely to be hot-removable. */
>>> @@ -1257,10 +1255,11 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
>>>   {
>>>   	struct page *page = pfn_to_page(start_pfn);
>>>   	struct page *end_page = page + nr_pages;
>>> +	struct zone *zone = NULL;
>>>   
>>>   	/* Check the starting page of each pageblock within the range */
>>>   	for (; page < end_page; page = next_active_pageblock(page)) {
>>> -		if (!is_pageblock_removable_nolock(page))
>>> +		if (!is_pageblock_removable_nolock(page, &zone))
>>>   			return false;
>>>   		cond_resched();
>>>   	}
>>> @@ -1296,6 +1295,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
>>>   				i++;
>>>   			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
>>>   				continue;
>>> +			/* Check if we got outside of the zone */
>>> +			if (zone && !zone_spans_pfn(zone, pfn))
>>> +				return 0;
>>>   			page = pfn_to_page(pfn + i);
>>>   			if (zone && page_zone(page) != zone)
>>>   				return 0;
>>> -- 
>>> 2.16.4

