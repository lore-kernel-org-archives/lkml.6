Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA57C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE8D2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RwzazEmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391310AbeLUSUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:20:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50882 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbeLUSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:20:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBLI9I8Y048419;
        Fri, 21 Dec 2018 18:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yc+7dCD4ily5kT6Pm+0h+S/myHo5gljalEENBHZXJm8=;
 b=RwzazEmIggngGdVXvNwOj6UHMP1yj/XmLmg9yclHkpilyXXskcOc3CM0P4X/SmWYgZOk
 MXpaYp+f3kE+e+A+8Exsce6uY54IcN7OBbdNvfw3DA30fI5E7RVUuXEepmorqHj64Cyq
 fuxxEJ4bgFRkZvZC4dAeR3xGNp3ccYYZzTpyxBVR8PhnkuOXxi7tRT0LA6UIfBroDDqG
 zDRxkdXLxjZUALs9khrRkvePPiO//JjAQmbyiNk9TU3Z4zrwqsIzC3bIsCJ7sfv5lOn4
 sKuIeLy9NfwyJEBKp5Dr1CgAiFHnhvvgJ5t7eOWAccCD1+94F82lENg5Sqh7bagngmzy Cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pf8gfqgd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 18:20:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBLIKM24012267
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 18:20:22 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBLIKKaB009045;
        Fri, 21 Dec 2018 18:20:20 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Dec 2018 10:20:20 -0800
Subject: Re: [PATCH v2 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing
 synchronization
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20181218223557.5202-1-mike.kravetz@oracle.com>
 <20181218223557.5202-2-mike.kravetz@oracle.com>
 <20181221100528.bkvddcqom7qaxwbe@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6b91dd42-b903-1f6c-729a-bd9f51273986@oracle.com>
Date:   Fri, 21 Dec 2018 10:20:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181221100528.bkvddcqom7qaxwbe@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9114 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 2:05 AM, Kirill A. Shutemov wrote:
> On Tue, Dec 18, 2018 at 02:35:56PM -0800, Mike Kravetz wrote:
>> While looking at BUGs associated with invalid huge page map counts,
>> it was discovered and observed that a huge pte pointer could become
>> 'invalid' and point to another task's page table.  Consider the
>> following:
>>
>> A task takes a page fault on a shared hugetlbfs file and calls
>> huge_pte_alloc to get a ptep.  Suppose the returned ptep points to a
>> shared pmd.
>>
>> Now, another task truncates the hugetlbfs file.  As part of truncation,
>> it unmaps everyone who has the file mapped.  If the range being
>> truncated is covered by a shared pmd, huge_pmd_unshare will be called.
>> For all but the last user of the shared pmd, huge_pmd_unshare will
>> clear the pud pointing to the pmd.  If the task in the middle of the
>> page fault is not the last user, the ptep returned by huge_pte_alloc
>> now points to another task's page table or worse.  This leads to bad
>> things such as incorrect page map/reference counts or invalid memory
>> references.
>>
>> To fix, expand the use of i_mmap_rwsem as follows:
>> - i_mmap_rwsem is held in read mode whenever huge_pmd_share is called.
>>   huge_pmd_share is only called via huge_pte_alloc, so callers of
>>   huge_pte_alloc take i_mmap_rwsem before calling.  In addition, callers
>>   of huge_pte_alloc continue to hold the semaphore until finished with
>>   the ptep.
>> - i_mmap_rwsem is held in write mode whenever huge_pmd_unshare is called.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: 39dde65c9940 ("shared page table for hugetlb page")
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Other the few questions below. The patch looks reasonable to me.

Thanks for taking a look.

> 
>> @@ -3252,11 +3253,23 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>  
>>  	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
>>  		spinlock_t *src_ptl, *dst_ptl;
>> +
>>  		src_pte = huge_pte_offset(src, addr, sz);
>>  		if (!src_pte)
>>  			continue;
>> +
>> +		/*
>> +		 * i_mmap_rwsem must be held to call huge_pte_alloc.
>> +		 * Continue to hold until finished  with dst_pte, otherwise
>> +		 * it could go away if part of a shared pmd.
>> +		 *
>> +		 * Technically, i_mmap_rwsem is only needed in the non-cow
>> +		 * case as cow mappings are not shared.
>> +		 */
>> +		i_mmap_lock_read(mapping);
> 
> Any reason you do lock/unlock on each iteration rather than around whole
> loop?

I am simply mirroring the page table locking.  This is not necessary.
The page table lock can change while processing the range, but the
i_mmap_rwsem can not.  Therefore, we can hold around the whole loop.

I will modify, test and put out an updated patch later today.

>>  		dst_pte = huge_pte_alloc(dst, addr, sz);
>>  		if (!dst_pte) {
>> +			i_mmap_unlock_read(mapping);
>>  			ret = -ENOMEM;
>>  			break;
>>  		}
> 
> ...
> 
>> @@ -3772,14 +3789,18 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>  			};
>>  
>>  			/*
>> -			 * hugetlb_fault_mutex must be dropped before
>> -			 * handling userfault.  Reacquire after handling
>> -			 * fault to make calling code simpler.
>> +			 * hugetlb_fault_mutex and i_mmap_rwsem must be
>> +			 * dropped before handling userfault.  Reacquire
>> +			 * after handling fault to make calling code simpler.
>>  			 */
>>  			hash = hugetlb_fault_mutex_hash(h, mm, vma, mapping,
>>  							idx, haddr);
>>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>> +			i_mmap_unlock_read(mapping);
>> +
> 
> Do we have order of hugetlb_fault_mutex vs. i_mmap_lock documented?
> I *looks* correct to me, but it's better to write it down somewhere.
> Mayby add to the header of mm/rmap.c?

No it is not documented.  I don't think there is much/any documentation
for hugetlb_fault_mutex at all.  I will add it to the lock documentation
in mm/rmap.c as you suggest.

-- 
Mike Kravetz
