Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B36DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559C0217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfACObU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:31:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51395 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbfACObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:31:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CADFC059B71;
        Thu,  3 Jan 2019 14:31:20 +0000 (UTC)
Received: from redhat.com (ovpn-123-124.rdu2.redhat.com [10.10.123.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC60F5D9C5;
        Thu,  3 Jan 2019 14:31:18 +0000 (UTC)
Date:   Thu, 3 Jan 2019 09:31:16 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103143116.GB3395@redhat.com>
References: <20190103002126.GM6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103002126.GM6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 03 Jan 2019 14:31:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 04:21:26PM -0800, Matthew Wilcox wrote:
> 
> One of the paths in follow_pte_pmd() initialised the mmu_notifier_range
> incorrectly.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Fixes: ac46d4f3c432 ("mm/mmu_notifier: use structure for invalidate_range_start/end calls v2")
> Tested-by: Dave Chinner <dchinner@redhat.com>

Actually now that i have read the code again this is not ok to
do so. The caller of follow_pte_pmd() will call range_init and
follow pmd will only update the range address. So existing code
is ok.

I know this is kind of ugly but i do not see a way around that
uglyness.

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2dd2f9ab57f4..21a650368be0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4078,8 +4078,8 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
>  		goto out;
>  
>  	if (range) {
> -		range->start = address & PAGE_MASK;
> -		range->end = range->start + PAGE_SIZE;
> +		mmu_notifier_range_init(range, mm, address & PAGE_MASK,
> +				     (address & PAGE_MASK) + PAGE_SIZE);
>  		mmu_notifier_invalidate_range_start(range);
>  	}
>  	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
