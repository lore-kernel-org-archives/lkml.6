Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E287FC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04FE214DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04FE214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbeHGL1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:27:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727425AbeHGL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:27:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6E33AD3B;
        Tue,  7 Aug 2018 09:13:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F7121E3BF9; Tue,  7 Aug 2018 11:13:57 +0200 (CEST)
Date:   Tue, 7 Aug 2018 11:13:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, jack@suse.cz, hch@lst.de,
        yu.c.zhang@intel.com, linux-mm@kvack.org, rkrcmar@redhat.com,
        yi.z.zhang@intel.com
Subject: Re: [PATCH V2 3/4] mm: add a function to differentiate the pages is
 from DAX device memory
Message-ID: <20180807091357.zxanrttlp3ml7mq2@quack2.suse.cz>
References: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
 <a0d220839ce0414f13e9394dffcd9abe8689dafe.1531241281.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0d220839ce0414f13e9394dffcd9abe8689dafe.1531241281.git.yi.z.zhang@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-07-18 01:03:51, Zhang Yi wrote:
> DAX driver hotplug the device memory and move it to memory zone, these
> pages will be marked reserved flag, however, some other kernel componet
> will misconceive these pages are reserved mmio (ex: we map these dev_dax
> or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
> MEMORY_DEVICE_FS_DAX, we can use is_dax_page() to differentiate the pages
> is DAX device memory or not.
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>

The patch looks OK to me but I don't really feel too confident about this
part of the kernel... But feel free to add my:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/mm.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6e19265..9f0f690 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -856,6 +856,13 @@ static inline bool is_device_public_page(const struct page *page)
>  		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
>  }
>  
> +static inline bool is_dax_page(const struct page *page)
> +{
> +	return is_zone_device_page(page) &&
> +		(page->pgmap->type == MEMORY_DEVICE_FS_DAX ||
> +		page->pgmap->type == MEMORY_DEVICE_DEV_DAX);
> +}
> +
>  #else /* CONFIG_DEV_PAGEMAP_OPS */
>  static inline void dev_pagemap_get_ops(void)
>  {
> @@ -879,6 +886,11 @@ static inline bool is_device_public_page(const struct page *page)
>  {
>  	return false;
>  }
> +
> +static inline bool is_dax_page(const struct page *page)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
>  
>  static inline void get_page(struct page *page)
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
