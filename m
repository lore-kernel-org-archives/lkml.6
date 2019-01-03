Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E53C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBDB208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QeyuFHan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfACOjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:39:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfACOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cpyYqlHvB58KkTNoC4Cjl0Icxb9x69XoxiEczy+KqYM=; b=QeyuFHanBW2Kzy081ggKqX4ggH
        /m7IpUxJmN7r/ckut+rupPEL+CmUISmVKcKsPzF3rdjPXdAlhLPhaDIHkPTfy3K+I0xG7M2fZoNzQ
        nKbMiMdqRF7I1Bc2ixOTX49RjW5PBwWON5MRRPTgSsY9rxCvV7jjBIEgZY41tsSPCrcX4TU6j5aVy
        vjzj3wd0oac0bB/muKz4HmcuzXGqMtsOh/z/uctUETDNmJ/y7kDoCVbYs+Rr6R+WPfHRNi7H9Fwuy
        i13FAUsfiP6y8irSP5MruWSXGbn1nRz29KptoYAHfJhcMd9UnSldtYSQiBBlU+7tkSQnCZxSYfeCr
        ytgjmakA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gf49N-0001F0-0s; Thu, 03 Jan 2019 14:39:09 +0000
Date:   Thu, 3 Jan 2019 06:39:08 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Initialise mmu_notifier_range correctly
Message-ID: <20190103143908.GQ6310@bombadil.infradead.org>
References: <20190103002126.GM6310@bombadil.infradead.org>
 <20190103015654.GB15619@redhat.com>
 <785af237-eb67-c304-595d-9080a2f48102@nvidia.com>
 <20190103041833.GN6310@bombadil.infradead.org>
 <20190103142959.GA3395@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190103142959.GA3395@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 09:29:59AM -0500, Jerome Glisse wrote:
> On Wed, Jan 02, 2019 at 08:18:33PM -0800, Matthew Wilcox wrote:
> > On Wed, Jan 02, 2019 at 07:32:08PM -0800, John Hubbard wrote:
> > > Having the range struct declared in separate places from the mmu_notifier_range_init()
> > > calls is not great. But I'm not sure I see a way to make it significantly cleaner, given
> > > that __follow_pte_pmd uses the range pointer as a way to decide to issue the mmn calls.
> > 
> > Yeah, I don't think there's anything we can do.  But I started reviewing
> > the comments, and they don't make sense together:
> > 
> >                 /*
> >                  * Note because we provide range to follow_pte_pmd it will
> >                  * call mmu_notifier_invalidate_range_start() on our behalf
> >                  * before taking any lock.
> >                  */
> >                 if (follow_pte_pmd(vma->vm_mm, address, &range,
> >                                    &ptep, &pmdp, &ptl))
> >                         continue;
> > 
> >                 /*
> >                  * No need to call mmu_notifier_invalidate_range() as we are
> >                  * downgrading page table protection not changing it to point
> >                  * to a new page.
> >                  *
> >                  * See Documentation/vm/mmu_notifier.rst
> >                  */
> > 
> > So if we don't call mmu_notifier_invalidate_range, why are we calling
> > mmu_notifier_invalidate_range_start and mmu_notifier_invalidate_range_end?
> > ie, why not this ...
> 
> Thus comments looks wrong to me ... we need to call
> mmu_notifier_invalidate_range() those are use by
> IOMMU. I might be to blame for those comments thought.

Yes, you're to blame for both of them.

a4d1a88525138 (Jérôme Glisse     2017-08-31 17:17:26 -0400  791)                 * Note because we provide start/end to follow_pte_pmd it will
a4d1a88525138 (Jérôme Glisse     2017-08-31 17:17:26 -0400  792)                 * call mmu_notifier_invalidate_range_start() on our behalf
a4d1a88525138 (Jérôme Glisse     2017-08-31 17:17:26 -0400  793)                 * before taking any lock.

0f10851ea475e (Jérôme Glisse     2017-11-15 17:34:07 -0800  794)                 * No need to call mmu_notifier_invalidate_range() as we are
0f10851ea475e (Jérôme Glisse     2017-11-15 17:34:07 -0800  795)                 * downgrading page table protection not changing it to point
0f10851ea475e (Jérôme Glisse     2017-11-15 17:34:07 -0800  796)                 * to a new page.

