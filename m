Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD985C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D322054F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D322054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeJEOcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:32:18 -0400
Received: from foss.arm.com ([217.140.101.70]:46570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbeJEOcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:32:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95BF7A9;
        Fri,  5 Oct 2018 00:34:50 -0700 (PDT)
Received: from [10.163.1.107] (unknown [10.163.1.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7103F5B3;
        Fri,  5 Oct 2018 00:34:46 -0700 (PDT)
Subject: Re: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        catalin.marinas@arm.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <20181002123909.GS18290@dhcp22.suse.cz>
 <fae68a4e-b14b-8342-940c-ea5ef3c978af@arm.com>
 <20181003065833.GD18290@dhcp22.suse.cz>
 <7f0488b5-053f-0954-9b95-8c0890ef5597@arm.com>
 <20181003105926.GA4714@dhcp22.suse.cz>
 <34b25855-fcef-61ed-312d-2011f80bdec4@arm.com>
 <20181003114842.GD4714@dhcp22.suse.cz>
 <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
 <20181003133609.GG4714@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <5dc1dc4d-de60-43b9-aab6-3b3bb6a22a4b@arm.com>
Date:   Fri, 5 Oct 2018 13:04:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003133609.GG4714@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2018 07:06 PM, Michal Hocko wrote:
> On Wed 03-10-18 18:36:39, Anshuman Khandual wrote:
> [...]
>> So we have two checks here
>>
>> 1) platform specific arch_hugetlb_migration -> In principle go ahead
>>
>> 2) huge_movable() during allocation
>>
>> 	- If huge page does not have to be placed on movable zone
>>
>> 		- Allocate any where successfully and done !
>>  
>> 	- If huge page *should* be placed on a movable zone
>>
>> 		- Try allocating on movable zone
>>
>> 			- Successfull and done !
>>
>> 		- If the new page could not be allocated on movable zone
>> 		
>> 			- Abort the migration completely
>>
>> 					OR
>>
>> 			- Warn and fall back to non-movable
> 
> I guess you are still making it more complicated than necessary. The
> later is really only about __GFP_MOVABLE at this stage. I would just
> make it simple for now. We do not have to implement any dynamic
> heuristic right now. All that I am asking for is to split the migrate
> possible part from movable part.
> 
> I should have been more clear about that I guess from my very first
> reply. I do like how you moved the current coarse grained
> hugepage_migration_supported to be more arch specific but I merely
> wanted to point out that we need to do some other changes before we can
> go that route and that thing is to distinguish movable from migration
> supported.
> 
> See my point?

Does the following sound close enough to what you are looking for ?

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 9df1d59..070c419 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -504,6 +504,13 @@ static inline bool hugepage_migration_supported(struct hstate *h)
        return arch_hugetlb_migration_supported(h);
 }
 
+static inline bool hugepage_movable_required(struct hstate *h)
+{
+       if (hstate_is_gigantic(h))
+               return true;
+       return false;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
                                           struct mm_struct *mm, pte_t *pte)
 {
@@ -600,6 +607,11 @@ static inline bool hugepage_migration_supported(struct hstate *h)
        return false;
 }
 
+static inline bool hugepage_movable_required(struct hstate *h)
+{
+       return false;
+}
+
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
                                           struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3c21775..8b0afdc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1635,6 +1635,9 @@ struct page *alloc_huge_page_node(struct hstate *h, int nid)
        if (nid != NUMA_NO_NODE)
                gfp_mask |= __GFP_THISNODE;
 
+       if (hugepage_movable_required(h))
+               gfp_mask |= __GFP_MOVABLE;
+
        spin_lock(&hugetlb_lock);
        if (h->free_huge_pages - h->resv_huge_pages > 0)
                page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
@@ -1652,6 +1655,9 @@ struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
 {
        gfp_t gfp_mask = htlb_alloc_mask(h);
 
+       if (hugepage_movable_required(h))
+               gfp_mask |= __GFP_MOVABLE;
+
        spin_lock(&hugetlb_lock);
        if (h->free_huge_pages - h->resv_huge_pages > 0) {
                struct page *page;

