Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6266FC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B803E208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XH2iTeFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B803E208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHWUQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:16:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeHWUQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:16:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7NGhYMx156032;
        Thu, 23 Aug 2018 16:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=n1UcC0J3W1xQQ1jUGMBjTb2LtXT7QTA//g+I1NPMQ40=;
 b=XH2iTeFLUwNjGC6uXCSpIgpgdnGgmzh7gFYqG0UZ/Vd+pkXgo6RE0jCGvszSjFjpVT/E
 iQwOX/0yH7OjdO/3XAiEsDZWiHylU6h+ssVNeQaXEW34vx1vl+n4/BZa5s6O/XGogrIB
 +D3imZWxgctjKuDmpxAzKySlMP0U8tyvvVd1rGQEIozvULEm1ggt7slDzrjsWuUY/jwU
 TnUu7ZtkCXccbUZ1MjgVbCMbEimHqrYGPNOz825BJd02iApkrRPgXpNE/E8E5RjH0TXY
 jpXQKnZmcvHgDR9lJ/RhxQaYsoc0VL5xvQrCvp/fXvk2MVnrOfCO2g1g5l7GIFSQpjix UA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kxbdqam7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 16:45:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7NGjMhT003154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 16:45:23 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7NGjJVu029943;
        Thu, 23 Aug 2018 16:45:19 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 16:45:19 +0000
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
 <20180822122848.GL29735@dhcp22.suse.cz>
 <4a95a24f-534f-0938-f358-2a410817a412@oracle.com>
 <20180823073035.GT29735@dhcp22.suse.cz>
 <20180823082112.xln7rinqcwt54teg@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e003ff5e-3d95-be07-266c-eb8e32fae3c4@oracle.com>
Date:   Thu, 23 Aug 2018 09:45:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823082112.xln7rinqcwt54teg@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808230173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 01:21 AM, Kirill A. Shutemov wrote:
> On Thu, Aug 23, 2018 at 09:30:35AM +0200, Michal Hocko wrote:
>> On Wed 22-08-18 09:48:16, Mike Kravetz wrote:
>>> On 08/22/2018 05:28 AM, Michal Hocko wrote:
>>>> On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
>>>> [...]
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index eb477809a5c0..8cf853a4b093 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1362,11 +1362,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>>>  	}
>>>>>  
>>>>>  	/*
>>>>> -	 * We have to assume the worse case ie pmd for invalidation. Note that
>>>>> -	 * the page can not be free in this function as call of try_to_unmap()
>>>>> -	 * must hold a reference on the page.
>>>>> +	 * For THP, we have to assume the worse case ie pmd for invalidation.
>>>>> +	 * For hugetlb, it could be much worse if we need to do pud
>>>>> +	 * invalidation in the case of pmd sharing.
>>>>> +	 *
>>>>> +	 * Note that the page can not be free in this function as call of
>>>>> +	 * try_to_unmap() must hold a reference on the page.
>>>>>  	 */
>>>>>  	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
>>>>> +	if (PageHuge(page)) {
>>>>> +		/*
>>>>> +		 * If sharing is possible, start and end will be adjusted
>>>>> +		 * accordingly.
>>>>> +		 */
>>>>> +		(void)huge_pmd_sharing_possible(vma, &start, &end);
>>>>> +	}
>>>>>  	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
>>>>
>>>> I do not get this part. Why don't we simply unconditionally invalidate
>>>> the whole huge page range?
>>>
>>> In this routine, we are only unmapping a single page.  The existing code
>>> is limiting the invalidate range to that page size: 4K or 2M.  With shared
>>> PMDs, we have the possibility of unmapping a PUD_SIZE area: 1G.  I don't
>>> think we want to unconditionally invalidate 1G.  Is that what you are asking?
>>
>> But we know that huge_pmd_unshare unmapped a shared pte so we know when
>> to flush 2MB or 1GB. I really do not like how huge_pmd_sharing_possible
>> a) duplicates some checks and b) it updates start/stop out of line.
> 
> My reading on this is that mmu_notifier_invalidate_range_start() has to be
> called from sleepable context on the full range that *can* be invalidated
> before following mmu_notifier_invalidate_range_end().
> 
> In this case huge_pmd_unshare() may unmap aligned PUD_SIZE around the PMD
> page that effectively enlarge range that has to be covered by
> mmu_notifier_invalidate_range_start(). We cannot yet know if there's any
> shared page tables in the range, so we need to go with worst case
> scenario.

Yes, that is a good summary.  We can not know for sure if there is PMD
sharing until we hold the page table lock.  So, we don't know if we should
invalidate/flush 2M or 1G.  Yet, we need to call
mmu_notifier_invalidate_range_start before taking the lock.  And, the notifiers
need to know the range of the worst possible case.  The best approach I came up
with is to adjust the range if sharing is 'possible'.

> 
> I don't see conceptually better solution than what is proposed.
> 

I have updated the patches based on Kirill's previous comments and will send out
a new version later today.

-- 
Mike Kravetz
