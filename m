Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFB5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067032064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067032064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeIFR3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:29:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:57422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbeIFR3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:29:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76149AC11;
        Thu,  6 Sep 2018 12:53:57 +0000 (UTC)
Date:   Thu, 6 Sep 2018 14:53:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        mpe@ellerman.id.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH V2 4/4] powerpc/mm/iommu: Allow migration of cma
 allocated pages during mm_iommu_get
Message-ID: <20180906125356.GX14951@dhcp22.suse.cz>
References: <20180906054342.25094-1-aneesh.kumar@linux.ibm.com>
 <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906054342.25094-4-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 11:13:42, Aneesh Kumar K.V wrote:
> Current code doesn't do page migration if the page allocated is a compound page.
> With HugeTLB migration support, we can end up allocating hugetlb pages from
> CMA region. Also THP pages can be allocated from CMA region. This patch updates
> the code to handle compound pages correctly.
> 
> This use the new helper get_user_pages_cma_migrate. It does one get_user_pages
> with right count, instead of doing one get_user_pages per page. That avoids
> reading page table multiple times.
> 
> The patch also convert the hpas member of mm_iommu_table_group_mem_t to a union.
> We use the same storage location to store pointers to struct page. We cannot
> update alll the code path use struct page *, because we access hpas in real mode
> and we can't do that struct page * to pfn conversion in real mode.

I am not fmailiar with this code so bear with me. I am completely
missing the purpose of this patch. The changelog doesn't really explain
that AFAICS. I can only guess that you do not want to establish long
pins on CMA pages, right? So whenever you are about to pin a page that
is in CMA you migrate it away to a different !__GFP_MOVABLE page, right?
If that is the case then how do you handle pins which are already in
zone_movable? I do not see any specific check for those.

Btw. why is this a proper thing to do? Problems with longterm pins are
not only for CMA/ZONE_MOVABLE pages. Pinned pages are not reclaimable as
well so there is a risk of OOMs if there are too many of them. We have
discussed approaches that would allow to force pin invalidation/revocation
at LSF/MM. Isn't that a more appropriate solution to the problem you are
seeing?
-- 
Michal Hocko
SUSE Labs
