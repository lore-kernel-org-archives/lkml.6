Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D209C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC9E2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC9E2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLGDeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:34:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGDeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:34:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DCF130014CC;
        Fri,  7 Dec 2018 03:34:14 +0000 (UTC)
Received: from xz-x1 (ovpn-12-222.pek2.redhat.com [10.72.12.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6AD05D96E;
        Fri,  7 Dec 2018 03:34:09 +0000 (UTC)
Date:   Fri, 7 Dec 2018 11:34:07 +0800
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: thp: fix soft dirty for migration when split
Message-ID: <20181207033407.GB10726@xz-x1>
References: <20181206084604.17167-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206084604.17167-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 07 Dec 2018 03:34:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 04:46:04PM +0800, Peter Xu wrote:
> When splitting a huge migrating PMD, we'll transfer the soft dirty bit
> from the huge page to the small pages.  However we're possibly using a
> wrong data since when fetching the bit we're using pmd_soft_dirty()
> upon a migration entry.  Fix it up.

Note that if my understanding is correct about the problem then if
without the patch there is chance to lose some of the dirty bits in
the migrating pmd pages (on x86_64 we're fetching bit 11 which is part
of swap offset instead of bit 2) and it could potentially corrupt the
memory of an userspace program which depends on the dirty bit.

> 
> CC: Andrea Arcangeli <aarcange@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> CC: Matthew Wilcox <willy@infradead.org>
> CC: Michal Hocko <mhocko@suse.com>
> CC: Dave Jiang <dave.jiang@intel.com>
> CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> CC: Souptick Joarder <jrdr.linux@gmail.com>
> CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> CC: linux-mm@kvack.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> I noticed this during code reading.  Only compile tested.  I'm sending
> a patch directly for review comments since it's relatively
> straightforward and not easy to test.  Please have a look, thanks.
> ---
>  mm/huge_memory.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f2d19e4fe854..fb0787c3dd3b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2161,7 +2161,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		SetPageDirty(page);
>  	write = pmd_write(old_pmd);
>  	young = pmd_young(old_pmd);
> -	soft_dirty = pmd_soft_dirty(old_pmd);
> +	if (unlikely(pmd_migration))
> +		soft_dirty = pmd_swp_soft_dirty(old_pmd);
> +	else
> +		soft_dirty = pmd_soft_dirty(old_pmd);
>  
>  	/*
>  	 * Withdraw the table only after we mark the pmd entry invalid.
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
