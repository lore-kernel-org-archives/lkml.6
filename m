Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E874AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D0E208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D0E208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeGJRLZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 13:11:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933267AbeGJRLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 13:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 873AD81A4EB9;
        Tue, 10 Jul 2018 17:11:23 +0000 (UTC)
Received: from redhat.com (ovpn-123-96.rdu2.redhat.com [10.10.123.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9B982156889;
        Tue, 10 Jul 2018 17:11:21 +0000 (UTC)
Date:   Tue, 10 Jul 2018 13:11:20 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] mm, hmm: Mark hmm_devmem_{add, add_resource}
 EXPORT_SYMBOL_GPL
Message-ID: <20180710171119.GE3505@redhat.com>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152938831573.17797.15264540938029137916.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4hCZ6jJkB=BLfoEn6146k7FG32=3J8ussZDXmAScQJkAg@mail.gmail.com>
 <20180709173417.171c0d75ac3fd55b45881d3f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180709173417.171c0d75ac3fd55b45881d3f@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 17:11:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 17:11:23 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:34:17PM -0700, Andrew Morton wrote:
> On Fri, 6 Jul 2018 16:53:11 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Mon, Jun 18, 2018 at 11:05 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > > The routines hmm_devmem_add(), and hmm_devmem_add_resource() are
> > > now wrappers around the functionality provided by devm_memremap_pages() to
> > > inject a dev_pagemap instance and hook page-idle events. The
> > > devm_memremap_pages() interface is base infrastructure for HMM which has
> > > more and deeper ties into the kernel memory management implementation
> > > than base ZONE_DEVICE.
> > >
> > > Originally, the HMM page structure creation routines copied the
> > > devm_memremap_pages() code and reused ZONE_DEVICE. A cleanup to unify
> > > the implementations was discussed during the initial review:
> > > http://lkml.iu.edu/hypermail/linux/kernel/1701.2/00812.html
> > >
> > > Given that devm_memremap_pages() is marked EXPORT_SYMBOL_GPL by its
> > > authors and the hmm_devmem_{add,add_resource} routines are simple
> > > wrappers around that base, mark these routines as EXPORT_SYMBOL_GPL as
> > > well.
> > >
> > > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > > Cc: Logan Gunthorpe <logang@deltatee.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > Currently OpenAFS is blocked from compiling with the 4.18 series due
> > to the current state of put_page() inadvertently pulling in GPL-only
> > symbols. This series, "PATCH v3 0/8] mm: Rework hmm to use
> > devm_memremap_pages and other fixes" corrects that situation and
> > corrects HMM's usage of EXPORT_SYMBOL_GPL.
> > 
> > If HMM wants to export functionality to out-of-tree proprietary
> > drivers it should do so without consuming GPL-only exports, or
> > consuming internal-only public functions in its exports.
> > 
> > In addition to duplicating devm_memremap_pages(), that should have
> > been EXPORT_SYMBOL_GPL from the beginning, it is also exporting /
> > consuming these GPL-only symbols via HMM's EXPORT_SYMBOL entry points.
> > 
> >     mmu_notifier_unregister_no_release
> >     percpu_ref
> >     region_intersects
> >     __class_create
> > 
> > Those entry points also consume / export functionality that is
> > currently not exported to any other driver.
> > 
> >     alloc_pages_vma
> >     walk_page_range
> > 
> > Andrew, please consider applying this v3 series to fix this up (let me
> > know if you need a resend).
> 
> A resend would be good.  And include the above info in the changelog.
> 
> I can't say I'm terribly happy with the HMM situation.  I was under the
> impression that a significant number of significant in-tree drivers
> would be using HMM but I've heard nothing since, apart from ongoing
> nouveau work, which will be perfectly happy with GPL-only exports.
> 
> So yes, we should revisit the licensing situation and, if only nouveau
> will be using HMM we should revisit HMM's overall usefulness.

So right now i am working on finishing another version of nouveau
patchset. Then i will be working on radeon driver, then on Intel.
I also have been in talk with Mellanox to bring back to life my
mlx5 patchset which converted ODP to use HMM. So this is also on
the radar. AMD GPU will come next.


The nouveau patchset is taking so long because nouveau have under
gone massive rewrite of how it manages channel (commands queue) and
memory. Which was a pre-requisite for doing HMM. This rework has
started going upstream since 4.14, piece by piece and it is still
not finish in 4.18. So work have been going steadily, if people
wants i can point to all the patches.

As this is the DRM subsystem we also need open source userspaca and
again we have been working on this since last year and this takes
time to. Lot of work have been done. I understand that it is not
necessarily obvious to people who do not follow mesa, dri-devel or
nouveau mailing list.

I am sorry this is taking so long but resources to work on this are
scarce. Yet this is important work as new standard develop inside the
C++ committee (everybody love C++ here right ;)) and in other high
level language will rely on features HMM provides to those drivers.

Cheers,
Jérôme
