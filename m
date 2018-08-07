Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE27C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36512089C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36512089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbeHGLYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:24:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbeHGLYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:24:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 475F2AE98;
        Tue,  7 Aug 2018 09:11:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 95EC91E3BF9; Tue,  7 Aug 2018 11:11:20 +0200 (CEST)
Date:   Tue, 7 Aug 2018 11:11:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com, linux-mm@kvack.org, rkrcmar@redhat.com,
        yi.z.zhang@intel.com
Subject: Re: [PATCH V2 2/4] mm: introduce memory type MEMORY_DEVICE_DEV_DAX
Message-ID: <20180807091120.ybne44o2fy2mxcch@quack2.suse.cz>
References: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
 <7e20d862f96662e1a7736dbb747a71949933dcd4.1531241281.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e20d862f96662e1a7736dbb747a71949933dcd4.1531241281.git.yi.z.zhang@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 01:01:59, Zhang Yi wrote:
> Currently, NVDIMM pages will be marked 'PageReserved'. However, unlike
> other reserved PFNs, pages on NVDIMM shall still behave like normal ones
> in many cases, i.e. when used as backend memory of KVM guest. This patch
> introduces a new memory type, MEMORY_DEVICE_DEV_DAX. And set this flag
> while dax driver hotplug the device memory.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> ---
>  drivers/dax/pmem.c       | 1 +
>  include/linux/memremap.h | 9 +++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index fd49b24..fb3f363 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -111,6 +111,7 @@ static int dax_pmem_probe(struct device *dev)
>  		return rc;
>  
>  	dax_pmem->pgmap.ref = &dax_pmem->ref;
> +	dax_pmem->pgmap.type = MEMORY_DEVICE_DEV_DAX;
>  	addr = devm_memremap_pages(dev, &dax_pmem->pgmap);
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 5ebfff6..a36bce8 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -53,11 +53,20 @@ struct vmem_altmap {
>   * wakeup event whenever a page is unpinned and becomes idle. This
>   * wakeup is used to coordinate physical address space management (ex:
>   * fs truncate/hole punch) vs pinned pages (ex: device dma).
> + *
> + * MEMORY_DEVICE_DEV_DAX:
> + * DAX driver hotplug the device memory and move it to memory zone, these
> + * pages will be marked reserved flag. However, some other kernel componet
> + * will misconceive these pages are reserved mmio (ex: we map these dev_dax
> + * or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
> + * MEMORY_DEVICE_FS_DAX, we can differentiate the pages on NVDIMM with the
> + * normal reserved pages.

So I believe the description should be in terms of what kind of memory is
the MEMORY_DEVICE_DEV_DAX type, not how users use this type. See comments
for other memory types...

								Honza

>   */
>  enum memory_type {
>  	MEMORY_DEVICE_PRIVATE = 1,
>  	MEMORY_DEVICE_PUBLIC,
>  	MEMORY_DEVICE_FS_DAX,
> +	MEMORY_DEVICE_DEV_DAX,
>  };
>  
>  /*
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
