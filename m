Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D341C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27752206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27752206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLDSpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:45:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:3821 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDSpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:45:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 10:45:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="280903225"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 04 Dec 2018 10:45:08 -0800
Message-ID: <b8841553115fb63b348e466995338a4d4b13b6f5.camel@linux.intel.com>
Subject: Re: [PATCH RFC 0/3] Fix KVM misinterpreting Reserved page as an
 MMIO page
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Yi Zhang <yi.z.zhang@linux.intel.com>
Cc:     dan.j.williams@intel.com, pbonzini@redhat.com, brho@google.com,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com, pagupta@redhat.com,
        david@redhat.com, jack@suse.cz, hch@lst.de, rkrcmar@redhat.com,
        jglisse@redhat.com
Date:   Tue, 04 Dec 2018 10:45:08 -0800
In-Reply-To: <20181204065914.GB73736@tiger-server>
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
         <20181204065914.GB73736@tiger-server>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 14:59 +0800, Yi Zhang wrote:
> On 2018-12-03 at 11:25:20 -0800, Alexander Duyck wrote:
> > I have loosely based this patch series off of the following patch series
> > from Zhang Yi:
> > https://lore.kernel.org/lkml/cover.1536342881.git.yi.z.zhang@linux.intel.com
> > 
> > The original set had attempted to address the fact that DAX pages were
> > treated like MMIO pages which had resulted in reduced performance. It
> > attempted to address this by ignoring the PageReserved flag if the page
> > was either a DEV_DAX or FS_DAX page.
> > 
> > I am proposing this as an alternative to that set. The main reason for this
> > is because I believe there are a few issues that were overlooked with that
> > original set. Specifically KVM seems to have two different uses for the
> > PageReserved flag. One being whether or not we can pin the memory, the other
> > being if we should be marking the pages as dirty or accessed. I believe
> > only the pinning really applies so I have split the uses of
> > kvm_is_reserved_pfn and updated the function uses to determine support for
> > page pinning to include a check of the pgmap to see if it supports pinning.
> 
> kvm is not the only one users of the dax page.

Yes, but KVM and virtualization in general seems to be the place where
the code carrying the assumption that PageReserved == MMIO exists.

> A similar user of PageReserved to look at is:
>  drivers/vfio/vfio_iommu_type1.c:is_invalid_reserved_pfn(
> vfio is also want to know the page is capable for pinning.

I would lump vfio in with virtualization as I said above.

A quick search also shows that there is also
arch/x86/kvm/mmu.c:kvm_is_mmio_pfn() which had a similar assumption but
is already carrying workarounds.

> I throught that you have removed the reserved flag on the dax page
> 
> in https://patchwork.kernel.org/patch/10707267/
> 
> is something I missing here?

That patch wasn't about DAX memory. That patch was about the fact that
the reserved flag was expensive as a __set_bit operation. I was leaving
the bit set for DAX and all other hot-plug memory and not setting it
for deferred memory init.

The reserved bit is essentially meant to flag everything that is not
standard system RAM page. Historically speaking most of that was MMIO,
now that isn't necessarily the case with the introduction of
ZONE_DEVICE pages.

The issue is DAX isn't necessarily system RAM either. So if we don't
set the reserved bit for DAX then we have to go through and start
adding exception cases to the paths that handle system RAM to split it
off from DAX. Dan had pointed out one such example in
kernel/power/snapshot.c:saveable_page() as I recall.

> > 
> > ---
> > 
> > Alexander Duyck (3):
> >       kvm: Split use cases for kvm_is_reserved_pfn to kvm_is_refcounted_pfn
> >       mm: Add support for exposing if dev_pagemap supports refcount pinning
> >       kvm: Add additional check to determine if a page is refcounted
> > 
> > 
> >  arch/x86/kvm/mmu.c        |    6 +++---
> >  drivers/nvdimm/pfn_devs.c |    2 ++
> >  include/linux/kvm_host.h  |    2 +-
> >  include/linux/memremap.h  |    5 ++++-
> >  include/linux/mm.h        |   11 +++++++++++
> >  virt/kvm/kvm_main.c       |   34 +++++++++++++++++++++++++---------
> >  6 files changed, 46 insertions(+), 14 deletions(-)
> > 
> > --

