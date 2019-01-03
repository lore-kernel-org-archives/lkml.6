Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0BDC43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9578F214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 04:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8ePIrmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfACESh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 23:18:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfACESh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 23:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3+0TuKExyuXsncuMOhLfeVMB3tTRWVobvDSjw40AObE=; b=C8ePIrmQ8vZPxw8vruo/90/1D
        rJYJOMSETcKflG6S9m3DiVFbaiuofnZ9QtWdla9VkSjnEK5BzUtJK5TaHTXBZlNwakNhH0YGlcgF5
        ZRIPivmYpliU07biUYNauT1N/xDEX4+C9Nw2aXkYjCAon2wXV+yu/HGg/Ad/9IDg/ODvh5yFGY2li
        g/CMGU9FHogWcsR4RoFQvIpZETHFVn+dzUsGVHzkIb/SXiekUP5zHuXigSHCHSwcJq6j9Qw5514WE
        hN/s77THEhDShd3W7KFepMn7226KIKruQqqST8+U0K3nWLCrdXLfnC+0vb/aO7pKiBpZDfzZ/CmOq
        ZjvQh64RQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1geuSo-0002BE-56; Thu, 03 Jan 2019 04:18:34 +0000
Date:   Wed, 2 Jan 2019 20:18:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103041833.GN6310@bombadil.infradead.org>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103015654.GB15619@redhat.com>
 <785af237-eb67-c304-595d-9080a2f48102@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785af237-eb67-c304-595d-9080a2f48102@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 07:32:08PM -0800, John Hubbard wrote:
> Having the range struct declared in separate places from the mmu_notifier_range_init()
> calls is not great. But I'm not sure I see a way to make it significantly cleaner, given
> that __follow_pte_pmd uses the range pointer as a way to decide to issue the mmn calls.

Yeah, I don't think there's anything we can do.  But I started reviewing
the comments, and they don't make sense together:

                /*
                 * Note because we provide range to follow_pte_pmd it will
                 * call mmu_notifier_invalidate_range_start() on our behalf
                 * before taking any lock.
                 */
                if (follow_pte_pmd(vma->vm_mm, address, &range,
                                   &ptep, &pmdp, &ptl))
                        continue;

                /*
                 * No need to call mmu_notifier_invalidate_range() as we are
                 * downgrading page table protection not changing it to point
                 * to a new page.
                 *
                 * See Documentation/vm/mmu_notifier.rst
                 */

So if we don't call mmu_notifier_invalidate_range, why are we calling
mmu_notifier_invalidate_range_start and mmu_notifier_invalidate_range_end?
ie, why not this ...

diff --git a/fs/dax.c b/fs/dax.c
index 6959837cc465..905340149924 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -777,7 +777,6 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 
 	i_mmap_lock_read(mapping);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, index, index) {
-		struct mmu_notifier_range range;
 		unsigned long address;
 
 		cond_resched();
@@ -787,12 +786,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 
 		address = pgoff_address(index, vma);
 
-		/*
-		 * Note because we provide start/end to follow_pte_pmd it will
-		 * call mmu_notifier_invalidate_range_start() on our behalf
-		 * before taking any lock.
-		 */
-		if (follow_pte_pmd(vma->vm_mm, address, &range,
+		if (follow_pte_pmd(vma->vm_mm, address, NULL,
 				   &ptep, &pmdp, &ptl))
 			continue;
 
@@ -834,8 +828,6 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 unlock_pte:
 			pte_unmap_unlock(ptep, ptl);
 		}
-
-		mmu_notifier_invalidate_range_end(&range);
 	}
 	i_mmap_unlock_read(mapping);
 }
