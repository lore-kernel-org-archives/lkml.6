Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3807C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCE320647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCE320647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeH3BJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:09:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbeH3BJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C34DB804B4B9;
        Wed, 29 Aug 2018 21:11:09 +0000 (UTC)
Received: from redhat.com (ovpn-126-69.rdu2.redhat.com [10.10.126.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B55252166B41;
        Wed, 29 Aug 2018 21:11:08 +0000 (UTC)
Date:   Wed, 29 Aug 2018 17:11:07 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-rdma@vger.kernel.org,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180829211106.GC3784@redhat.com>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz>
 <20180827134633.GB3930@redhat.com>
 <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
 <20180829181424.GB3784@redhat.com>
 <20180829183906.GF10223@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180829183906.GF10223@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 21:11:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 29 Aug 2018 21:11:09 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:39:06PM +0200, Michal Hocko wrote:
> On Wed 29-08-18 14:14:25, Jerome Glisse wrote:
> > On Wed, Aug 29, 2018 at 10:24:44AM -0700, Mike Kravetz wrote:
> [...]
> > > What would be the best mmu notifier interface to use where there are no
> > > start/end calls?
> > > Or, is the best solution to add the start/end calls as is done in later
> > > versions of the code?  If that is the suggestion, has there been any change
> > > in invalidate start/end semantics that we should take into account?
> > 
> > start/end would be the one to add, 4.4 seems broken in respect to THP
> > and mmu notification. Another solution is to fix user of mmu notifier,
> > they were only a handful back then. For instance properly adjust the
> > address to match first address covered by pmd or pud and passing down
> > correct page size to mmu_notifier_invalidate_page() would allow to fix
> > this easily.
> > 
> > This is ok because user of try_to_unmap_one() replace the pte/pmd/pud
> > with an invalid one (either poison, migration or swap) inside the
> > function. So anyone racing would synchronize on those special entry
> > hence why it is fine to delay mmu_notifier_invalidate_page() to after
> > dropping the page table lock.
> > 
> > Adding start/end might the solution with less code churn as you would
> > only need to change try_to_unmap_one().
> 
> What about dependencies? 369ea8242c0fb sounds like it needs work for all
> notifiers need to be updated as well.

This commit remove mmu_notifier_invalidate_page() hence why everything
need to be updated. But in 4.4 you can get away with just adding start/
end and keep around mmu_notifier_invalidate_page() to minimize disruption.

So the new semantic in 369ea8242c0fb is that all page table changes are
bracketed with mmu notifier start/end calls and invalidate_range right
after tlb flush. This simplify thing and make it more reliable for mmu
notifier users like IOMMU or ODP or GPUs drivers.


> Anyway, I am wondering why we haven't see any bugs coming from
> incomplete range invalidation. How would those exhibit?

Reading back the 4.4 code try_to_unmap() can only be call against a
huge tlb page and only when migrating one ie through migrate_pages()
So this highly limit the cases where issues would happen. I believe
no one use hugetlb fs has backing for guest memory so xen and kvm
would never face such case.

So what is left is ODP, i915, radeon, amd gpu, SGI and IOMMU drivers.

The IOMMU drivers are never use that way AFAICT in 4.4 their was no
drivers upstream for a PCIE device that would support ATS/PASID and
thus the notifier path would never be use. Back then the only device
was AMD APU AFAIK which were never really use with that features
due to lack of mature userspace to use this.

For i915,radeon and amd GPU we would never see this either as the
mmu notifier is only use for uptr GEM object which are only use
to upload texture with either anonymous vma or file back vma. I
never heard of an xorg server or ddx or mesa drivers which would
use hugetlb fs.

So the only ones that might have issues AFAICT are ODP and SGI.
I am unsure on how likely either can be use in conjunction with a
hugetlb fs. CCing maintainers for those so they could comment.


The symptoms would either be memory corruption ie RDMA or SGI would
write to the old huge page and not the new one. Or even harder to
spot use of stall/invalid data ie RDMA or SGI are reading from
the old huge page and instead of the new one.

Corruption to hugetlbfs page can likely go unoticed.

Cheers,
Jérôme
