Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576F72070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfACO7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:59:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfACO7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:59:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D01B14D4DD;
        Thu,  3 Jan 2019 14:59:54 +0000 (UTC)
Received: from redhat.com (ovpn-123-124.rdu2.redhat.com [10.10.123.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67C435C223;
        Thu,  3 Jan 2019 14:59:53 +0000 (UTC)
Date:   Thu, 3 Jan 2019 09:59:51 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103145950.GE3395@redhat.com>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103015654.GB15619@redhat.com>
 <785af237-eb67-c304-595d-9080a2f48102@nvidia.com>
 <20190103041833.GN6310@bombadil.infradead.org>
 <20190103142959.GA3395@redhat.com>
 <20190103143908.GQ6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190103143908.GQ6310@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 03 Jan 2019 14:59:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 06:39:08AM -0800, Matthew Wilcox wrote:
> On Thu, Jan 03, 2019 at 09:29:59AM -0500, Jerome Glisse wrote:
> > On Wed, Jan 02, 2019 at 08:18:33PM -0800, Matthew Wilcox wrote:
> > > On Wed, Jan 02, 2019 at 07:32:08PM -0800, John Hubbard wrote:
> > > > Having the range struct declared in separate places from the mmu_notifier_range_init()
> > > > calls is not great. But I'm not sure I see a way to make it significantly cleaner, given
> > > > that __follow_pte_pmd uses the range pointer as a way to decide to issue the mmn calls.
> > > 
> > > Yeah, I don't think there's anything we can do.  But I started reviewing
> > > the comments, and they don't make sense together:
> > > 
> > >                 /*
> > >                  * Note because we provide range to follow_pte_pmd it will
> > >                  * call mmu_notifier_invalidate_range_start() on our behalf
> > >                  * before taking any lock.
> > >                  */
> > >                 if (follow_pte_pmd(vma->vm_mm, address, &range,
> > >                                    &ptep, &pmdp, &ptl))
> > >                         continue;
> > > 
> > >                 /*
> > >                  * No need to call mmu_notifier_invalidate_range() as we are
> > >                  * downgrading page table protection not changing it to point
> > >                  * to a new page.
> > >                  *
> > >                  * See Documentation/vm/mmu_notifier.rst
> > >                  */
> > > 
> > > So if we don't call mmu_notifier_invalidate_range, why are we calling
> > > mmu_notifier_invalidate_range_start and mmu_notifier_invalidate_range_end?
> > > ie, why not this ...
> > 
> > Thus comments looks wrong to me ... we need to call
> > mmu_notifier_invalidate_range() those are use by
> > IOMMU. I might be to blame for those comments thought.
> 
> Yes, you're to blame for both of them.
> 
> a4d1a88525138 (Jérôme Glisse     2017-08-31 17:17:26 -0400  791)                 * Note because we provide start/end to follow_pte_pmd it will
> a4d1a88525138 (Jérôme Glisse     2017-08-31 17:17:26 -0400  792)                 * call mmu_notifier_invalidate_range_start() on our behalf
> a4d1a88525138 (Jérôme Glisse     2017-08-31 17:17:26 -0400  793)                 * before taking any lock.
> 
> 0f10851ea475e (Jérôme Glisse     2017-11-15 17:34:07 -0800  794)                 * No need to call mmu_notifier_invalidate_range() as we are
> 0f10851ea475e (Jérôme Glisse     2017-11-15 17:34:07 -0800  795)                 * downgrading page table protection not changing it to point
> 0f10851ea475e (Jérôme Glisse     2017-11-15 17:34:07 -0800  796)                 * to a new page.
> 

I remember now we do not need to call invalidate range because
invalidate_range_end() does call invalidate_range so it is fine.
Comments should be better thought. So existing code is fine.

Cheers,
Jérôme
