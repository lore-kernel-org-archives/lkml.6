Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB02C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10EB20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10EB20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJCTzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:55:05 -0400
Received: from foss.arm.com ([217.140.101.70]:50950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeJCTzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:55:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FD707A9;
        Wed,  3 Oct 2018 06:06:45 -0700 (PDT)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04F713F5B7;
        Wed,  3 Oct 2018 06:06:41 -0700 (PDT)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
Date:   Wed, 3 Oct 2018 18:36:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181003114842.GD4714@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2018 05:18 PM, Michal Hocko wrote:
> On Wed 03-10-18 17:07:13, Anshuman Khandual wrote:
>>
>>
>> On 10/03/2018 04:29 PM, Michal Hocko wrote:
> [...]
>>> It is not the platform that decides. That is the whole point of the
>>> distinction. It is us to say what is feasible and what we want to
>>> support. Do we want to support giga pages in zone_movable? Under which
>>> conditions? See my point?
>>
>> So huge_movable() is going to be a generic MM function deciding on the
>> feasibility for allocating a huge page of 'size' from movable zone during
>> migration.
> 
> Yeah, this might be a more complex logic than just the size check. If
> there is a sufficient pre-allocated pool to migrate the page off it
> might be pre-reserved for future migration etc... Nothing to be done
> right now of course.

If the huge page has a pre-allocated pool, then it gets consumed first
through the current allocator logic (new_page_nodemask). Hence testing
for feasibility by looking into pool and (buddy / zone) together is not
going to change the policy unless there is also a new allocator which
goes and consumes (from reserved pool or buddy/zone) huge pages as
envisioned by the feasibility checker. But I understand your point.
That path can be explored as well.

> 
>> If the feasibility turns out to be negative, then migration
>> process is aborted there.
> 
> You are still confusing allocation and migration here I am afraid. The
> whole "feasible to migrate" is for the _allocation_ time when we decide
> whether the new page should be placed in zone_movable or not.

migrate_pages() -> platform specific arch_hugetlb_migration(in principle) ->
generic huge_movable() feasibility check while trying to allocate the
destination page -> move source to destination -> complete !

So we have two checks here

1) platform specific arch_hugetlb_migration -> In principle go ahead

2) huge_movable() during allocation

	- If huge page does not have to be placed on movable zone

		- Allocate any where successfully and done !
 
	- If huge page *should* be placed on a movable zone

		- Try allocating on movable zone

			- Successfull and done !

		- If the new page could not be allocated on movable zone
		
			- Abort the migration completely

					OR

			- Warn and fall back to non-movable


There is an important point to note here.

- Whether a huge size should be on movable zone can be determined
  looking into size and other parameters during feasibility test

- But whether a huge size can be allocated in actual on movable zone
  might not be determined without really allocating it which will
  further delay the decision to successfully complete the migration,
  warning about it or aborting it at this allocation phase itself

> 
>> huge_movable() will do something like these:
>>
>> - Return positive right away on smaller size huge pages
>> - Measure movable allocation feasibility for bigger huge pages
>> 	- Look out for free_pages in the huge page order in movable areas
>> 	- if (order > (MAX_ORDER - 1))
>> 		- Scan the PFN ranges in movable zone for possible allocation
>> 	- etc
>> 	- etc
>>
>> Did I get this right ?
> 
> Well, not really. I was thinking of something like this for the
> beginning
> 	if (!arch_hugepage_migration_supporte())
> 		return false;

First check: Platform check in principle as you mentioned before

> 	if (hstate_is_gigantic(h))
> 		return false;

Second check: Simplistic generic allocation feasibility check looking just at size

> 	return true;
> 
> further changes might be done on top of this.
Right.
