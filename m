Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2209920578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbeLQPez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:34:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:33376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387522AbeLQPeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:34:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28E1FAC15;
        Mon, 17 Dec 2018 15:34:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Dec 2018 16:34:48 +0100
From:   osalvador@suse.de
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        owner-linux-mm@kvack.org
Subject: Re: [PATCH] mm, page_alloc: Fix has_unmovable_pages for HugePages
In-Reply-To: <20181217152936.GR30879@dhcp22.suse.cz>
References: <20181217150651.16176-1-osalvador@suse.de>
 <20181217152936.GR30879@dhcp22.suse.cz>
Message-ID: <a4cf58c096f2f521e2b53745621c4562@suse.de>
X-Sender: osalvador@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-17 16:29, Michal Hocko wrote:
> On Mon 17-12-18 16:06:51, Oscar Salvador wrote:
> [...]
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a6e7bfd18cde..18d41e85f672 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8038,11 +8038,12 @@ bool has_unmovable_pages(struct zone *zone, 
>> struct page *page, int count,
>>  		 * handle each tail page individually in migration.
>>  		 */
>>  		if (PageHuge(page)) {
>> +			struct page *head = compound_head(page);
>> 
>> -			if (!hugepage_migration_supported(page_hstate(page)))
>> +			if (!hugepage_migration_supported(page_hstate(head)))
>>  				goto unmovable;
> 
> OK, this makes sense.
> 
>> 
>> -			iter = round_up(iter + 1, 1<<compound_order(page)) - 1;
>> +			iter = round_up(iter + 1, 1<<compound_order(head)) - 1;
> 
> but this less so. You surely do not want to move by the full hugetlb
> page when you got a tail page, right? You could skip too much. You have
> to consider page - head into the equation.

Argh, you're quite right.
I will amend it in the next version.


