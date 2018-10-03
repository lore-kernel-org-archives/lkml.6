Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B39C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71BE2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71BE2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJCR62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:58:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbeJCR62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:58:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A4118A;
        Wed,  3 Oct 2018 04:10:33 -0700 (PDT)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671AB3F5A0;
        Wed,  3 Oct 2018 04:10:30 -0700 (PDT)
Subject: Re: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     punit.agrawal@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        catalin.marinas@arm.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <835085a2-79c2-4eb5-2c10-13bb2893f611@arm.com>
 <c0689b0c-4810-e0e8-354e-55c45d59b6d0@arm.com>
 <a6b96126-5571-2aa2-6deb-09a457afd781@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bad51030-5f02-4fc9-741c-0fffbd690aca@arm.com>
Date:   Wed, 3 Oct 2018 16:40:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a6b96126-5571-2aa2-6deb-09a457afd781@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2018 03:52 PM, Suzuki K Poulose wrote:
> 
> 
> On 02/10/18 13:56, Anshuman Khandual wrote:
>>
>>
>> On 10/02/2018 06:08 PM, Suzuki K Poulose wrote:
>>> Hi Anshuman
>>>
>>> On 02/10/18 13:15, Anshuman Khandual wrote:
>>>> Architectures like arm64 have PUD level HugeTLB pages for certain configs
>>>> (1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
>>>> enabled for migration. It can be achieved through checking for PUD_SHIFT
>>>> order based HugeTLB pages during migration.
>>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>    include/linux/hugetlb.h | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index 6b68e34..9c1b77f 100644
>>>> --- a/include/linux/hugetlb.h
>>>> +++ b/include/linux/hugetlb.h
>>>> @@ -483,7 +483,8 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>>>>    {
>>>>    #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>>>>        if ((huge_page_shift(h) == PMD_SHIFT) ||
>>>> -        (huge_page_shift(h) == PGDIR_SHIFT))
>>>> +        (huge_page_shift(h) == PUD_SHIFT) ||
>>>
>>>
>>>> +            (huge_page_shift(h) == PGDIR_SHIFT))
>>>
>>> nit: Extra Tab ^^.
>>
>> The tab is in there when you apply this patch and all three checks are tab separated
>> in a newline.
> 
> Well, with the patch applied, at least I can see 2 tabs for the
> PUD_SHIFT check and 3 tabs for PGDIR_SHIFT check. Which seems
> inconsistent. Is it just me (my mail client) ?

I am sorry, you are right. Did not understand your point earlier. Yeah there is
increasing number of tabs for each new line with a conditional check. Is there
a problem with this style of indentation ? Though I will be happy to change.
