Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4728FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12C1208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2VudeFa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12C1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeH0U3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:29:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeH0U3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:29:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7RGfLwf172661;
        Mon, 27 Aug 2018 16:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=C4UFNNpoQJ+Vb+BT3ZIXatvlh7s+JlRB2gZ8RrcFw2A=;
 b=2VudeFa30qhwLjZA4a3h0gu/Legb+Hu+f+EtCYa806d1V5Hi7qrrooaf+dYLzTEht552
 JqnnMDBJSyN/FT9KxjIFH29hKYdpjpJ38Un/31/4dag8aZhKPHWJk8O3RbLrMlNjGvWC
 /YA0qD42u1rmcnKWEQnmiEUFCoMbqj/bzd4apKvZ49Xq6hVg/qB9uovtNT4Fiz89qZqw
 m9mw299K9MMXZnRIWlT8sUHIM0NdUlwiUcqrl2mgqLWjKm4r+l26mvgDfAOz1LkDSr43
 KXCnBHtj3PplzBZiu90d1QmL3C3nkW3t5iT/TZlQcUwrj6Ozk7vOah13SdrCFjvE1sOG bA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrpy03q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 16:42:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7RGg6Zm017365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Aug 2018 16:42:07 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7RGg5ci013178;
        Mon, 27 Aug 2018 16:42:05 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Aug 2018 09:42:04 -0700
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3d9057ef-13ad-7796-ebb0-f86cf7936127@oracle.com>
Date:   Mon, 27 Aug 2018 09:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827074645.GB21556@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8998 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808270175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 12:46 AM, Michal Hocko wrote:
> On Fri 24-08-18 11:08:24, Mike Kravetz wrote:
>> On 08/24/2018 01:41 AM, Michal Hocko wrote:
>>> On Thu 23-08-18 13:59:16, Mike Kravetz wrote:
>>>
>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>> One nit below.
>>>
>>> [...]
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 3103099f64fd..a73c5728e961 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -4548,6 +4548,9 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
>>>>  	return saddr;
>>>>  }
>>>>  
>>>> +#define _range_in_vma(vma, start, end) \
>>>> +	((vma)->vm_start <= (start) && (end) <= (vma)->vm_end)
>>>> +
>>>
>>> static inline please. Macros and potential side effects on given
>>> arguments are just not worth the risk. I also think this is something
>>> for more general use. We have that pattern at many places. So I would
>>> stick that to linux/mm.h
>>
>> Thanks Michal,
>>
>> Here is an updated patch which does as you suggest above.
> [...]
>> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>>  		address = pvmw.address;
>>  
>> +		if (PageHuge(page)) {
>> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
>> +				/*
>> +				 * huge_pmd_unshare unmapped an entire PMD
>> +				 * page.  There is no way of knowing exactly
>> +				 * which PMDs may be cached for this mm, so
>> +				 * we must flush them all.  start/end were
>> +				 * already adjusted above to cover this range.
>> +				 */
>> +				flush_cache_range(vma, start, end);
>> +				flush_tlb_range(vma, start, end);
>> +				mmu_notifier_invalidate_range(mm, start, end);
>> +
>> +				/*
>> +				 * The ref count of the PMD page was dropped
>> +				 * which is part of the way map counting
>> +				 * is done for shared PMDs.  Return 'true'
>> +				 * here.  When there is no other sharing,
>> +				 * huge_pmd_unshare returns false and we will
>> +				 * unmap the actual page and drop map count
>> +				 * to zero.
>> +				 */
>> +				page_vma_mapped_walk_done(&pvmw);
>> +				break;
>> +			}
> 
> This still calls into notifier while holding the ptl lock. Either I am
> missing something or the invalidation is broken in this loop (not also
> for other invalidations).

As Jerome said ...

When creating this patch, I started by using the same flush/invalidation
routines used by the existing code.  This is because it is not obvious what
interfaces can be called in what context, and I didn't want to do anything
different.  The best 'documentation' are the comments in the mmu_notifier_ops
definition.

-- 
Mike Kravetz
