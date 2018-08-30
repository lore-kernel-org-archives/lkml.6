Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998E6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E99320661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5IjLZbyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E99320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbeH3EkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:40:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59182 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeH3EkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:40:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7U0YMn7076017;
        Thu, 30 Aug 2018 00:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Vei724ma6UVFHBG7jVOwVQZlTqSlis9BmW86siupHwM=;
 b=5IjLZbyqFH43tv4hU8w42/uTogYlME+YfNmVpWDnUaCXHr2jLFdeJK/hs9R3dWnCy+Ba
 R0HyTydZ468ojweg8KrjiupZnkM4+GCHUIclFVS8Nwg27ibGp3WcZF84JDWXyppt09Yt
 JuaKXrsmFjVgzuCeIIrAlcoVkFlD+XzWKvqnhnDP34HwPJdRjL232JyfklOimKYAfnDj
 QlXtmqHz+mJqhaqdJ5zrOtRt4biMyWCRH7Nbqcqpyv6dt7F0WZe1wH7J5XAzo9F3Wlk6
 Hfe7NTF/riVUJUysD6KfzVEjgW00u+FQ7y9pH79C/ufTsfTO0Rt621Mc92saiBLCUSPF DQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2m2yrqcpve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 00:40:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7U0eGfF023596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 00:40:16 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7U0eEx5006536;
        Thu, 30 Aug 2018 00:40:14 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 17:40:14 -0700
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
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz> <20180827134633.GB3930@redhat.com>
 <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
 <20180829181424.GB3784@redhat.com> <20180829183906.GF10223@dhcp22.suse.cz>
 <20180829211106.GC3784@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8689d0ba-1303-9765-4cae-ad24d2a1435b@oracle.com>
Date:   Wed, 29 Aug 2018 17:40:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829211106.GC3784@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 02:11 PM, Jerome Glisse wrote:
> On Wed, Aug 29, 2018 at 08:39:06PM +0200, Michal Hocko wrote:
>> On Wed 29-08-18 14:14:25, Jerome Glisse wrote:
>>> On Wed, Aug 29, 2018 at 10:24:44AM -0700, Mike Kravetz wrote:
>> [...]
>>>> What would be the best mmu notifier interface to use where there are no
>>>> start/end calls?
>>>> Or, is the best solution to add the start/end calls as is done in later
>>>> versions of the code?  If that is the suggestion, has there been any change
>>>> in invalidate start/end semantics that we should take into account?
>>>
>>> start/end would be the one to add, 4.4 seems broken in respect to THP
>>> and mmu notification. Another solution is to fix user of mmu notifier,
>>> they were only a handful back then. For instance properly adjust the
>>> address to match first address covered by pmd or pud and passing down
>>> correct page size to mmu_notifier_invalidate_page() would allow to fix
>>> this easily.
>>>
>>> This is ok because user of try_to_unmap_one() replace the pte/pmd/pud
>>> with an invalid one (either poison, migration or swap) inside the
>>> function. So anyone racing would synchronize on those special entry
>>> hence why it is fine to delay mmu_notifier_invalidate_page() to after
>>> dropping the page table lock.
>>>
>>> Adding start/end might the solution with less code churn as you would
>>> only need to change try_to_unmap_one().
>>
>> What about dependencies? 369ea8242c0fb sounds like it needs work for all
>> notifiers need to be updated as well.
> 
> This commit remove mmu_notifier_invalidate_page() hence why everything
> need to be updated. But in 4.4 you can get away with just adding start/
> end and keep around mmu_notifier_invalidate_page() to minimize disruption.
> 
> So the new semantic in 369ea8242c0fb is that all page table changes are
> bracketed with mmu notifier start/end calls and invalidate_range right
> after tlb flush. This simplify thing and make it more reliable for mmu
> notifier users like IOMMU or ODP or GPUs drivers.

Here is what I came up with by adding the start/end calls to the 4.4 version
of try_to_unmap_one.  Note that this assumes/uses the new routine
adjust_range_if_pmd_sharing_possible to adjust the notifier/flush range if
huge pmd sharing is possible.  I changed the mmu_notifier_invalidate_page
to a mmu_notifier_invalidate_range, but am not sure if that needs to happen
earlier in the routine (like right after tlb flush as you said above).
Does this look reasonable?

diff --git a/mm/rmap.c b/mm/rmap.c
index b577fbb98d4b..7ba8bfeddb4b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1302,11 +1302,30 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	pte_t pteval;
 	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
+	unsigned long start = address, end;
 	enum ttu_flags flags = (enum ttu_flags)arg;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
-		goto out;
+		return ret;
+
+	/*
+	 * For THP, we have to assume the worse case ie pmd for invalidation.
+	 * For hugetlb, it could be much worse if we need to do pud
+	 * invalidation in the case of pmd sharing.
+	 *
+	 * Note that the page can not be free in this function as call of
+	 * try_to_unmap() must hold a reference on the page.
+	 */
+	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
+	if (PageHuge(page)) {
+		/*
+		 * If sharing is possible, start and end will be adjusted
+		 * accordingly.
+		 */
+		adjust_range_if_pmd_sharing_possible(vma, &start, &end);
+	}
+	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
 
 	pte = page_check_address(page, mm, address, &ptl, 0);
 	if (!pte)
@@ -1334,6 +1353,29 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		}
   	}
 
+	if (PageHuge(page) && huge_pmd_unshare(mm, &address, pte)) {
+		/*
+		 * huge_pmd_unshare unmapped an entire PMD page.  There is
+		 * no way of knowing exactly which PMDs may be cached for
+		 * this mm, so flush them all.  start/end were already
+		 * adjusted to cover this range.
+		 */
+		flush_cache_range(vma, start, end);
+		flush_tlb_range(vma, start, end);
+
+		/*
+		 * The ref count of the PMD page was dropped which is part
+		 * of the way map counting is done for shared PMDs.  When
+		 * there is no other sharing, huge_pmd_unshare returns false
+		 * and we will unmap the actual page and drop map count
+		 * to zero.
+		 *
+		 * Note that huge_pmd_unshare modified address and is likely
+		 * not what you would expect.
+		 */
+		goto out_unmap;
+	}
+
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
 	if (should_defer_flush(mm, flags)) {
@@ -1424,10 +1466,11 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	page_cache_release(page);
 
 out_unmap:
-	pte_unmap_unlock(pte, ptl);
 	if (ret != SWAP_FAIL && ret != SWAP_MLOCK && !(flags & TTU_MUNLOCK))
-		mmu_notifier_invalidate_page(mm, address);
+		mmu_notifier_invalidate_range(mm, start, end);
+	pte_unmap_unlock(pte, ptl);
 out:
+	mmu_notifier_invalidate_range_end(vma->vm_mm, start, end);
 	return ret;
 }
 
-- 
Mike Kravetz
