Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054F2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B085120877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B085120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeGJAe0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:34:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754579AbeGJAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:34:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3757CCF1;
        Tue, 10 Jul 2018 00:34:18 +0000 (UTC)
Date:   Mon, 9 Jul 2018 17:34:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] mm, hmm: Mark hmm_devmem_{add, add_resource}
 EXPORT_SYMBOL_GPL
Message-Id: <20180709173417.171c0d75ac3fd55b45881d3f@linux-foundation.org>
In-Reply-To: <CAPcyv4hCZ6jJkB=BLfoEn6146k7FG32=3J8ussZDXmAScQJkAg@mail.gmail.com>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
        <152938831573.17797.15264540938029137916.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAPcyv4hCZ6jJkB=BLfoEn6146k7FG32=3J8ussZDXmAScQJkAg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 16:53:11 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Jun 18, 2018 at 11:05 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > The routines hmm_devmem_add(), and hmm_devmem_add_resource() are
> > now wrappers around the functionality provided by devm_memremap_pages() to
> > inject a dev_pagemap instance and hook page-idle events. The
> > devm_memremap_pages() interface is base infrastructure for HMM which has
> > more and deeper ties into the kernel memory management implementation
> > than base ZONE_DEVICE.
> >
> > Originally, the HMM page structure creation routines copied the
> > devm_memremap_pages() code and reused ZONE_DEVICE. A cleanup to unify
> > the implementations was discussed during the initial review:
> > http://lkml.iu.edu/hypermail/linux/kernel/1701.2/00812.html
> >
> > Given that devm_memremap_pages() is marked EXPORT_SYMBOL_GPL by its
> > authors and the hmm_devmem_{add,add_resource} routines are simple
> > wrappers around that base, mark these routines as EXPORT_SYMBOL_GPL as
> > well.
> >
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Currently OpenAFS is blocked from compiling with the 4.18 series due
> to the current state of put_page() inadvertently pulling in GPL-only
> symbols. This series, "PATCH v3 0/8] mm: Rework hmm to use
> devm_memremap_pages and other fixes" corrects that situation and
> corrects HMM's usage of EXPORT_SYMBOL_GPL.
> 
> If HMM wants to export functionality to out-of-tree proprietary
> drivers it should do so without consuming GPL-only exports, or
> consuming internal-only public functions in its exports.
> 
> In addition to duplicating devm_memremap_pages(), that should have
> been EXPORT_SYMBOL_GPL from the beginning, it is also exporting /
> consuming these GPL-only symbols via HMM's EXPORT_SYMBOL entry points.
> 
>     mmu_notifier_unregister_no_release
>     percpu_ref
>     region_intersects
>     __class_create
> 
> Those entry points also consume / export functionality that is
> currently not exported to any other driver.
> 
>     alloc_pages_vma
>     walk_page_range
> 
> Andrew, please consider applying this v3 series to fix this up (let me
> know if you need a resend).

A resend would be good.  And include the above info in the changelog.

I can't say I'm terribly happy with the HMM situation.  I was under the
impression that a significant number of significant in-tree drivers
would be using HMM but I've heard nothing since, apart from ongoing
nouveau work, which will be perfectly happy with GPL-only exports.

So yes, we should revisit the licensing situation and, if only nouveau
will be using HMM we should revisit HMM's overall usefulness.
