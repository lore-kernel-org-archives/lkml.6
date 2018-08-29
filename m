Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC668C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DC320644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cICWqh6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DC320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeH2VXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:23:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38232 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeH2VXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:23:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7THNuxS158637;
        Wed, 29 Aug 2018 17:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9PWUiGkbTOyGy5NBYV1CROY6X9aEQwuLVY1CeA2bfJs=;
 b=cICWqh6Nh+fZqTdRN5ibro4SoE67eBnuqDMRIeU6Q61zrf8MiR2yLL6/y+lPrdO/kGqO
 Tfzyf58MAsx9kA8DMfC+Ec+xAAFRVvoCe9mRBRnExyrGK9RMUlp1dnQOuJyhwxep2BjS
 OUUzXBHVrBT6nYHS1HNNztBPAt6nOqUATv/hpSz8v5jrjdEFcvupyoivG7+RhkSXjHkh
 9BFWyW8EIYihQ6UROlta5t7iqjXr+Ydnzp7RWjFxh/Yookfcb9nMhwlfeWd+I9R9GFfF
 gAG2DOZoeQVTqvq9JeoS1X+0aPPt0EWNQwZVKcORW75LTkIQ25Rg/BRlqWcbDMXSXcEP tA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m2xhtu8gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 17:24:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7THOkwH003529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 17:24:46 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7THOjIH001072;
        Wed, 29 Aug 2018 17:24:45 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 10:24:45 -0700
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
To:     Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz> <20180827134633.GB3930@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
Date:   Wed, 29 Aug 2018 10:24:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827134633.GB3930@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 06:46 AM, Jerome Glisse wrote:
> On Mon, Aug 27, 2018 at 09:46:45AM +0200, Michal Hocko wrote:
>> On Fri 24-08-18 11:08:24, Mike Kravetz wrote:
>>> Here is an updated patch which does as you suggest above.
>> [...]
>>> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>>>  		address = pvmw.address;
>>>  
>>> +		if (PageHuge(page)) {
>>> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
>>> +				/*
>>> +				 * huge_pmd_unshare unmapped an entire PMD
>>> +				 * page.  There is no way of knowing exactly
>>> +				 * which PMDs may be cached for this mm, so
>>> +				 * we must flush them all.  start/end were
>>> +				 * already adjusted above to cover this range.
>>> +				 */
>>> +				flush_cache_range(vma, start, end);
>>> +				flush_tlb_range(vma, start, end);
>>> +				mmu_notifier_invalidate_range(mm, start, end);
>>> +
>>> +				/*
>>> +				 * The ref count of the PMD page was dropped
>>> +				 * which is part of the way map counting
>>> +				 * is done for shared PMDs.  Return 'true'
>>> +				 * here.  When there is no other sharing,
>>> +				 * huge_pmd_unshare returns false and we will
>>> +				 * unmap the actual page and drop map count
>>> +				 * to zero.
>>> +				 */
>>> +				page_vma_mapped_walk_done(&pvmw);
>>> +				break;
>>> +			}
>>
>> This still calls into notifier while holding the ptl lock. Either I am
>> missing something or the invalidation is broken in this loop (not also
>> for other invalidations).
> 
> mmu_notifier_invalidate_range() is done with pt lock held only the start
> and end versions need to happen outside pt lock.

Hi Jérôme (and anyone else having good understanding of mmu notifier API),

Michal and I have been looking at backports to stable releases.  If you look
at the v4.4 version of try_to_unmap_one(), it does not use the
mmu_notifier_invalidate_range_start/end interfaces. Rather, it uses the
mmu_notifier_invalidate_page(), passing in the address of the page it
unmapped.  This is done after releasing the ptl lock.  I'm not even sure if
this works for huge pages, as it appears some THP supporting code was added
to try_to_unmap_one() after v4.4.

But, we were wondering what mmu notifier interface to use in the case where
try_to_unmap_one() unmaps a shared pmd huge page as addressed in the patch
above.  In this case, a PUD sized area is effectively unmapped.  In the
code/patch above we have the invalidate range (start and end as well) take
the PUD sized area into account.

What would be the best mmu notifier interface to use where there are no
start/end calls?
Or, is the best solution to add the start/end calls as is done in later
versions of the code?  If that is the suggestion, has there been any change
in invalidate start/end semantics that we should take into account?

-- 
Mike Kravetz
