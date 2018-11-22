Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB69DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C9A20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C9A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436882AbeKWAJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:09:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:52666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbeKWAJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:09:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B63BDB047;
        Thu, 22 Nov 2018 13:30:13 +0000 (UTC)
Date:   Thu, 22 Nov 2018 14:30:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 1/7] mm, devm_memremap_pages: Mark
 devm_memremap_pages() EXPORT_SYMBOL_GPL
Message-ID: <20181122133013.GG18011@dhcp22.suse.cz>
References: <154275556908.76910.8966087090637564219.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154275557457.76910.16923571232582744134.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <154275557457.76910.16923571232582744134.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 15:12:54, Dan Williams wrote:
> devm_memremap_pages() is a facility that can create struct page entries
> for any arbitrary range and give drivers the ability to subvert core
> aspects of page management.
> 
> Specifically the facility is tightly integrated with the kernel's memory
> hotplug functionality. It injects an altmap argument deep into the
> architecture specific vmemmap implementation to allow allocating from
> specific reserved pages, and it has Linux specific assumptions about
> page structure reference counting relative to get_user_pages() and
> get_user_pages_fast(). It was an oversight and a mistake that this was
> not marked EXPORT_SYMBOL_GPL from the outset.
> 
> Again, devm_memremap_pagex() exposes and relies upon core kernel
> internal assumptions and will continue to evolve along with 'struct
> page', memory hotplug, and support for new memory types / topologies.
> Only an in-kernel GPL-only driver is expected to keep up with this
> ongoing evolution. This interface, and functionality derived from this
> interface, is not suitable for kernel-external drivers.

As I've said earlier I do not buy this justification because there is
simply no stable API for modules by definition
(Documentation/process/stable-api-nonsense.rst). I do understand
your reasoning that you as an author never intended to export the symbol
this way. That is fair and justified reason for this patch.

Whoever needs a wrapper around arch_add_memory can do so because this
symbol has no restriction for the usage. It will be still the same
fiddling with struct page and deep mm internals. Do we care? I am not
convinced because once we grow any in tree user we have to cope with any
potential abuse like we have in other areas in the past. And out-of-tree
modules? Who cares. Those are on their own completely and have their
ways to go around.

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

That being said
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  kernel/memremap.c                 |    2 +-
>  tools/testing/nvdimm/test/iomap.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 9eced2cc9f94..61dbcaa95530 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -233,7 +233,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>   err_array:
>  	return ERR_PTR(error);
>  }
> -EXPORT_SYMBOL(devm_memremap_pages);
> +EXPORT_SYMBOL_GPL(devm_memremap_pages);
>  
>  unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
>  {
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index ff9d3a5825e1..ed18a0cbc0c8 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -113,7 +113,7 @@ void *__wrap_devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>  		return nfit_res->buf + offset - nfit_res->res.start;
>  	return devm_memremap_pages(dev, pgmap);
>  }
> -EXPORT_SYMBOL(__wrap_devm_memremap_pages);
> +EXPORT_SYMBOL_GPL(__wrap_devm_memremap_pages);
>  
>  pfn_t __wrap_phys_to_pfn_t(phys_addr_t addr, unsigned long flags)
>  {

-- 
Michal Hocko
SUSE Labs
