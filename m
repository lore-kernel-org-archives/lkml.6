Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563522087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfAaH7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:59:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaH7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:59:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1DFD9D435;
        Thu, 31 Jan 2019 07:59:45 +0000 (UTC)
Received: from xz-x1 (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B41C21001938;
        Thu, 31 Jan 2019 07:59:43 +0000 (UTC)
Date:   Thu, 31 Jan 2019 15:59:41 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Message-ID: <20190131075941.GB25119@xz-x1>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
 <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 31 Jan 2019 07:59:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:27:40PM +0000, Jean-Philippe Brucker wrote:
> Hi Peter,

Hi, Jean,

> 
> On 30/01/2019 05:57, Peter Xu wrote:
> > AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> > but that's actually already covered by invalidate_range().  Remove the
> > extra notifier and the chunks.
> 
> Aren't uses of clear_flush_young() and invalidate_range() orthogonal? If
> I understood correctly, when doing reclaim the kernel clears the young
> bit from the PTE. This requires flushing secondary TLBs (ATCs), so that
> new accesses from devices will go through the IOMMU, set the young bit
> again and the kernel can accurately track page use. I didn't see
> invalidate_range() being called by rmap or vmscan in this case, but
> might just be missing it.
> 
> Two MMU notifiers are used for the young bit, clear_flush_young() and
> clear_young(). I believe the former should invalidate ATCs so that DMA
> accesses participate in PTE aging. Otherwise the kernel can't know that
> the device is still using entries marked 'old'. The latter,
> clear_young() is exempted from invalidating the secondary TLBs by
> mmu_notifier.h and the IOMMU driver doesn't need to implement it.

Yes I agree most of your analysis, but IMHO the problem is that the
AMD IOMMU is not really participating in the PTE aging after all.
Please have a look at mn_clear_flush_young() below at [1] - it's
always returning zero, no matter whether the page has been accessed by
device or not.  A real user of it could be someone like KVM (please
see kvm_mmu_notifier_clear_flush_young) where we'll try to lookup the
shadow PTEs and do test-and-clear on that, then return the result to
the core mm.  That's why I think currently the AMD driver was only
trying to use that as a way to do an extra flush however IMHO it's
redundant.

Thanks,

> > -static int mn_clear_flush_young(struct mmu_notifier *mn,
> > -				struct mm_struct *mm,
> > -				unsigned long start,
> > -				unsigned long end)
> > -{
> > -	for (; start < end; start += PAGE_SIZE)
> > -		__mn_flush_page(mn, start);
> > -
> > -	return 0;

[1]

-- 
Peter Xu
