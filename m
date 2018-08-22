Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A68C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FDA208E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jn+85Bs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FDA208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeHVUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 16:14:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 16:14:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7MGiY4H194592;
        Wed, 22 Aug 2018 16:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yzEcyHNI+e04uWUXe4LJ67nm4WfL+ACRq+zpwXIYj3Y=;
 b=Jn+85Bs4IZhwc0Pm5NxgpTUCXy5v6m+FAwsXvfyrYf0T79nGdkpIJ4gofXFMRRZZ8Ck0
 +k0tzB2S33mAkTkAWvG9gNtKTSAR+kpyw0uDoKAOHcxVeYJHENxt6iWBICg1+fz+n7NJ
 kZgPzNcEGbmtuGdDTxYCKUqf2ePwSTg9fipNEQEEq8MxWctHixv9KihkKCcHk4/FestF
 QChtUTB1XEL5XOBWRp3JxF7JXjNDtGsgs6MVT1FeLNth1EofS2SxDZLUCuiBpTg6Fy6n
 d3fS6wjlS5L03h9lfodKzQu17ouQmPY2xx1bNvtQyTunm8YGmSO6cNrpZOI10WfdiYMe gQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kxbdq3cuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 16:48:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7MGmK5Q024303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 16:48:20 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7MGmImu020330;
        Wed, 22 Aug 2018 16:48:18 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 09:48:18 -0700
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
To:     Michal Hocko <mhocko@kernel.org>
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4a95a24f-534f-0938-f358-2a410817a412@oracle.com>
Date:   Wed, 22 Aug 2018 09:48:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822122848.GL29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8993 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 05:28 AM, Michal Hocko wrote:
> On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
> [...]
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index eb477809a5c0..8cf853a4b093 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1362,11 +1362,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  	}
>>  
>>  	/*
>> -	 * We have to assume the worse case ie pmd for invalidation. Note that
>> -	 * the page can not be free in this function as call of try_to_unmap()
>> -	 * must hold a reference on the page.
>> +	 * For THP, we have to assume the worse case ie pmd for invalidation.
>> +	 * For hugetlb, it could be much worse if we need to do pud
>> +	 * invalidation in the case of pmd sharing.
>> +	 *
>> +	 * Note that the page can not be free in this function as call of
>> +	 * try_to_unmap() must hold a reference on the page.
>>  	 */
>>  	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
>> +	if (PageHuge(page)) {
>> +		/*
>> +		 * If sharing is possible, start and end will be adjusted
>> +		 * accordingly.
>> +		 */
>> +		(void)huge_pmd_sharing_possible(vma, &start, &end);
>> +	}
>>  	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
> 
> I do not get this part. Why don't we simply unconditionally invalidate
> the whole huge page range?

In this routine, we are only unmapping a single page.  The existing code
is limiting the invalidate range to that page size: 4K or 2M.  With shared
PMDs, we have the possibility of unmapping a PUD_SIZE area: 1G.  I don't
think we want to unconditionally invalidate 1G.  Is that what you are asking?

I do not know how often PMD sharing is exercised.  It certainly is used by
DBs for large shared areas.  I suspect it is less frequent than hugtlb pages
in general, and certainly less frequent than THP or base pages.

>>  
>>  	while (page_vma_mapped_walk(&pvmw)) {
>> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>>  		address = pvmw.address;
>>  
>> +		if (PageHuge(page)) {
>> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> 
> huge_pmd_unshare is documented to require a pte lock. Where do we take
> it?

It is somewhat hidden, but we are in the loop:

	while (page_vma_mapped_walk(&pvmw)) {

The routine page_vma_mapped_walk will acquire the lock, and it correctly
checks for huge pages and uses huge_pte_lockptr().

page_vma_mapped_walk_done() will release the lock.
-- 
Mike Kravetz
