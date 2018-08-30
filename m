Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B0BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1821120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jov4ia54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1821120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeH3WKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:10:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeH3WKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:10:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UI3YXU113299;
        Thu, 30 Aug 2018 18:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cOGjuEpLf/Sa6WS9GX/gaY3ba60iuc//jOLQoMeXSn8=;
 b=jov4ia54yJcf5Yue1K6i+2CW6lJNmV2h/QPsor34mp4vmnbSIweBTVOMic7swa77uipx
 EigVf25sCMw0rzEfdcD5CrODMt59ziqcUoOKrVhJYdr2qj5AwyxDQGjRtQskHCETOIkv
 ZXfTMPRNN50ECqgkCk23pZyRKHHO/pqKnp/pzk7ehceplQS5BYT7bnv7G13AfE9L70aj
 ZiW6gXnweIKwSwbYxneIg+tdwCPR9sQ4ON8TyuvvwUhSCtzxeuZTyWZLiziEcKYYMYuw
 Bv2ADAx9rWioDK0DYsxYkDasakclccMNuhYX/5HkluQbMmfD8jhAeEJxt6ArYnqbQ64S Fg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrqp6q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 18:05:21 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UI5JBk005554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 18:05:20 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UI5Ick028246;
        Thu, 30 Aug 2018 18:05:18 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 11:05:18 -0700
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
        stable@vger.kernel.org, linux-rdma@vger.kernel.org,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dimitri Sivanich <sivanich@sgi.com>
References: <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz> <20180827134633.GB3930@redhat.com>
 <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
 <20180829181424.GB3784@redhat.com> <20180829183906.GF10223@dhcp22.suse.cz>
 <20180829211106.GC3784@redhat.com> <20180830105616.GD2656@dhcp22.suse.cz>
 <20180830140825.GA3529@redhat.com> <20180830161800.GJ2656@dhcp22.suse.cz>
 <20180830165751.GD3529@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e0c0c966-6706-4ca2-4077-e79322756a9b@oracle.com>
Date:   Thu, 30 Aug 2018 11:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830165751.GD3529@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 09:57 AM, Jerome Glisse wrote:
> On Thu, Aug 30, 2018 at 06:19:52PM +0200, Michal Hocko wrote:
>> On Thu 30-08-18 10:08:25, Jerome Glisse wrote:
>>> On Thu, Aug 30, 2018 at 12:56:16PM +0200, Michal Hocko wrote:
>>>> On Wed 29-08-18 17:11:07, Jerome Glisse wrote:
>>>>> On Wed, Aug 29, 2018 at 08:39:06PM +0200, Michal Hocko wrote:
>>>>>> On Wed 29-08-18 14:14:25, Jerome Glisse wrote:
>>>>>>> On Wed, Aug 29, 2018 at 10:24:44AM -0700, Mike Kravetz wrote:
>>>>>> [...]
>>>>>>>> What would be the best mmu notifier interface to use where there are no
>>>>>>>> start/end calls?
>>>>>>>> Or, is the best solution to add the start/end calls as is done in later
>>>>>>>> versions of the code?  If that is the suggestion, has there been any change
>>>>>>>> in invalidate start/end semantics that we should take into account?
>>>>>>>
>>>>>>> start/end would be the one to add, 4.4 seems broken in respect to THP
>>>>>>> and mmu notification. Another solution is to fix user of mmu notifier,
>>>>>>> they were only a handful back then. For instance properly adjust the
>>>>>>> address to match first address covered by pmd or pud and passing down
>>>>>>> correct page size to mmu_notifier_invalidate_page() would allow to fix
>>>>>>> this easily.
>>>>>>>
>>>>>>> This is ok because user of try_to_unmap_one() replace the pte/pmd/pud
>>>>>>> with an invalid one (either poison, migration or swap) inside the
>>>>>>> function. So anyone racing would synchronize on those special entry
>>>>>>> hence why it is fine to delay mmu_notifier_invalidate_page() to after
>>>>>>> dropping the page table lock.
>>>>>>>
>>>>>>> Adding start/end might the solution with less code churn as you would
>>>>>>> only need to change try_to_unmap_one().
>>>>>>
>>>>>> What about dependencies? 369ea8242c0fb sounds like it needs work for all
>>>>>> notifiers need to be updated as well.
>>>>>
>>>>> This commit remove mmu_notifier_invalidate_page() hence why everything
>>>>> need to be updated. But in 4.4 you can get away with just adding start/
>>>>> end and keep around mmu_notifier_invalidate_page() to minimize disruption.
>>>>
>>>> OK, this is really interesting. I was really worried to change the
>>>> semantic of the mmu notifiers in stable kernels because this is really
>>>> a hard to review change and high risk for anybody running those old
>>>> kernels. If we can keep the mmu_notifier_invalidate_page and wrap them
>>>> into the range scope API then this sounds like the best way forward.
>>>>
>>>> So just to make sure we are at the same page. Does this sounds goo for
>>>> stable 4.4. backport? Mike's hugetlb pmd shared fixup can be applied on
>>>> top. What do you think?
>>>
>>> You need to invalidate outside page table lock so before the call to
>>> page_check_address(). For instance like below patch, which also only
>>> do the range invalidation for huge page which would avoid too much of
>>> a behavior change for user of mmu notifier.
>>
>> Right. I would rather not make this PageHuge special though. So the
>> fixed version should be.
> 
> Why not testing for huge ? Only huge is broken and thus only that
> need the extra range invalidation. Doing the double invalidation
> for single page is bit overkill.

I am a bit confused, and hope this does not add to any confusion by others.

IIUC, the patch below does not attempt to 'fix' anything.  It is simply
there to add the start/end notifiers to the v4.4 version of this routine
so that a subsequent patch can use them (with modified ranges) to handle
unmapping a shared pmd huge page.  That is the mainline fix which started
this thread.

Since we are only/mostly interested in fixing the shared pmd issue in
4.4, how about just adding the start/end notifiers to the very specific
case where pmd sharing is possible?

I can see the value in trying to back port dependent patches such as this
so that stable releases look more like mainline.  However, I am not sure of
the value in this case as this patch was part of a larger set changing
notifier semantics.

-- 
Mike Kravetz

> Also below is bogus you need to add a out_notify: label to avoid
> an inbalance in start/end callback.
> 
>>
>> From c05849f6789ec36e2ff11adcd8fa6cfb05e870a9 Mon Sep 17 00:00:00 2001
>> From: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
>> Date: Thu, 31 Aug 2017 17:17:27 -0400
>> Subject: [PATCH] mm/rmap: update to new mmu_notifier semantic v2
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> commit 369ea8242c0fb5239b4ddf0dc568f694bd244de4 upstrea.
>>
>> Please note that this patch differs from the mainline because we do not
>> really replace mmu_notifier_invalidate_page by mmu_notifier_invalidate_range
>> because that requires changes to most of existing mmu notifiers. We also
>> do not want to change the semantic of this API in old kernels. Anyway
>> Jerome has suggested that it should be sufficient to simply wrap
>> mmu_notifier_invalidate_page by *_invalidate_range_start()/end() to fix
>> invalidation of larger than pte mappings (e.g. THP/hugetlb pages during
>> migration). We need this change to handle large (hugetlb/THP) pages
>> migration properly.
>>
>> Note that because we can not presume the pmd value or pte value we have
>> to assume the worst and unconditionaly report an invalidation as
>> happening.
>>
>> Changed since v2:
>>   - try_to_unmap_one() only one call to mmu_notifier_invalidate_range()
>>   - compute end with PAGE_SIZE << compound_order(page)
>>   - fix PageHuge() case in try_to_unmap_one()
>>
>> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
>> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
>> Cc: Bernhard Held <berny156@gmx.de>
>> Cc: Adam Borowski <kilobyte@angband.pl>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Wanpeng Li <kernellwp@gmail.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Nadav Amit <nadav.amit@gmail.com>
>> Cc: Mike Galbraith <efault@gmx.de>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: axie <axie@amd.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Michal Hocko <mhocko@suse.com> # backport to 4.4
>> ---
>>  mm/rmap.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1bceb49aa214..aba994f55d6c 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1324,12 +1324,21 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  	pte_t pteval;
>>  	spinlock_t *ptl;
>>  	int ret = SWAP_AGAIN;
>> +	unsigned long start = address, end;
>>  	enum ttu_flags flags = (enum ttu_flags)arg;
>>  
>>  	/* munlock has nothing to gain from examining un-locked vmas */
>>  	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
>>  		goto out;
>>  
>> +	/*
>> +	 * We have to assume the worse case ie pmd for invalidation. Note that
>> +	 * the page can not be free in this function as call of try_to_unmap()
>> +	 * must hold a reference on the page.
>> +	 */
>> +	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
>> +	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
>> +
>>  	pte = page_check_address(page, mm, address, &ptl, 0);
>>  	if (!pte)
>>  		goto out;
> 
> Instead
> 
>>  		goto out_notify;
> 
>> @@ -1450,6 +1459,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>  	if (ret != SWAP_FAIL && ret != SWAP_MLOCK && !(flags & TTU_MUNLOCK))
>>  		mmu_notifier_invalidate_page(mm, address);
> 
> +out_notify:
> 
>> +	mmu_notifier_invalidate_range_end(vma->vm_mm, start, end);
>>  out:
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.18.0
>>
>> -- 
>> Michal Hocko
>> SUSE Labs
