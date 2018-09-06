Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D0EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D122075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D122075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeIFPyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:54:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:38992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbeIFPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:54:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 309ECAD25;
        Thu,  6 Sep 2018 11:19:05 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:19:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/hugetlb: make hugetlb_lock irq safe
Message-ID: <20180906111904.GB26069@dhcp22.suse.cz>
References: <20180905112341.21355-1-aneesh.kumar@linux.ibm.com>
 <20180905130440.GA3729@bombadil.infradead.org>
 <d76771e6-1664-5d38-a5a0-e98f1120494c@linux.ibm.com>
 <20180905134848.GB3729@bombadil.infradead.org>
 <20180905125846.eb0a9ed907b293c1b4c23c23@linux-foundation.org>
 <78b08258-14c8-0e90-97c7-d647a11acb30@oracle.com>
 <20180905150008.59d477c1f78f966a8f9c3cc8@linux-foundation.org>
 <20180905230737.GA14977@bombadil.infradead.org>
 <c03c8851-ce18-56c6-3f37-47f585d70b19@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c03c8851-ce18-56c6-3f37-47f585d70b19@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-09-18 16:51:00, Mike Kravetz wrote:
> On 09/05/2018 04:07 PM, Matthew Wilcox wrote:
> > On Wed, Sep 05, 2018 at 03:00:08PM -0700, Andrew Morton wrote:
> >> On Wed, 5 Sep 2018 14:35:11 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >>>>                                            so perhaps we could put some
> >>>> stopgap workaround into that site and add a runtime warning into the
> >>>> put_page() code somewhere to detect puttage of huge pages from hardirq
> >>>> and softirq contexts.
> >>>
> >>> I think we would add the warning/etc at free_huge_page.  The issue would
> >>> only apply to hugetlb pages, not THP.
> >>>
> >>> But, the more I think about it the more I think Aneesh's patch to do
> >>> spin_lock/unlock_irqsave is the right way to go.  Currently, we only
> >>> know of one place where a put_page of hugetlb pages is done from softirq
> >>> context.  So, we could take the spin_lock/unlock_bh as Matthew suggested.
> >>> When the powerpc iommu code was added, I doubt this was taken into account.
> >>> I would be afraid of someone adding put_page from hardirq context.
> >>
> >> Me too.  If we're going to do this, surely we should make hugepages
> >> behave in the same fashion as PAGE_SIZE pages.
> > 
> > But these aren't vanilla hugepages, they're specifically hugetlbfs pages.
> > I don't believe there's any problem with calling put_page() on a normally
> > allocated huge page or THP.
> 
> Right
> The powerpc iommu code (at least) treated hugetlbfs pages as any other page
> (huge, THP or base) and called put_page from softirq context.
> 
> It seems there are at least two ways to address this:
> 1) Prohibit this behavior for hugetlbfs pages
> 2) Try to make hugetlbfs pages behave like other pages WRT put_page

Hugetlb pages have always been special and that has caused us more
headache than necessary. So if there is a user calling put_page from the
soft IRQ context (which is a news to me) then we can expect somebody
will do that from the hard IRQ context sooner or later. So rather than
make hugetlb a special snow flake again I vote for 2) and make it
consistent with other pages.
-- 
Michal Hocko
SUSE Labs
