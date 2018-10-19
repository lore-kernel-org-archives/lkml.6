Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8363FC67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B1121477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B1121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJSKgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:36:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46336 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJSKgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:36:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC45C341;
        Thu, 18 Oct 2018 19:32:32 -0700 (PDT)
Received: from [10.162.0.72] (p8cg001049571a15.blr.arm.com [10.162.0.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 338883F71D;
        Thu, 18 Oct 2018 19:32:28 -0700 (PDT)
Subject: Re: [PATCH V2 2/5] mm/hugetlb: Distinguish between migratability and
 movability
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "punit.agrawal@arm.com" <punit.agrawal@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Steven.Price@arm.com" <Steven.Price@arm.com>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
References: <1539316799-6064-1-git-send-email-anshuman.khandual@arm.com>
 <1539316799-6064-3-git-send-email-anshuman.khandual@arm.com>
 <20181019015931.GA18973@hori1.linux.bs1.fc.nec.co.jp>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <e7a3d5d8-dc65-72fc-5764-010af02d1517@arm.com>
Date:   Fri, 19 Oct 2018 08:02:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019015931.GA18973@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2018 07:29 AM, Naoya Horiguchi wrote:
> On Fri, Oct 12, 2018 at 09:29:56AM +0530, Anshuman Khandual wrote:
>> During huge page allocation it's migratability is checked to determine if
>> it should be placed under movable zones with GFP_HIGHUSER_MOVABLE. But the
>> movability aspect of the huge page could depend on other factors than just
>> migratability. Movability in itself is a distinct property which should not
>> be tied with migratability alone.
>>
>> This differentiates these two and implements an enhanced movability check
>> which also considers huge page size to determine if it is feasible to be
>> placed under a movable zone. At present it just checks for gigantic pages
>> but going forward it can incorporate other enhanced checks.
> 
> (nitpicking...)
> The following code just checks hugepage_migration_supported(), so maybe
> s/Movability/Migratability/ is expected in the comment?
> 
>   static int unmap_and_move_huge_page(...)
>   {
>           ...
>           /*
>            * Movability of hugepages depends on architectures and hugepage size.
>            * This check is necessary because some callers of hugepage migration
>            * like soft offline and memory hotremove don't walk through page
>            * tables or check whether the hugepage is pmd-based or not before
>            * kicking migration.
>            */
>           if (!hugepage_migration_supported(page_hstate(hpage))) {
> 
Sure, will update this patch only unless other changes are suggested.
