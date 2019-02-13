Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48825C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2150B2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfBMKWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:22:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:59016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733047AbfBMKWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:22:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FA1AAEE9;
        Wed, 13 Feb 2019 10:22:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A27971E09C5; Wed, 13 Feb 2019 11:22:02 +0100 (CET)
Date:   Wed, 13 Feb 2019 11:22:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] dax: Check the end of the block-device capacity with
 dax_direct_access()
Message-ID: <20190213102202.GA13313@quack2.suse.cz>
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155000669646.348031.16690970886357498896.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155000669646.348031.16690970886357498896.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 13:24:56, Dan Williams wrote:
> The checks in __bdev_dax_supported() helped mitigate a potential data
> corruption bug in the pmem driver's handling of section alignment
> padding. Strengthen the checks, including checking the end of the range,
> to validate the dev_pagemap, Xarray entries, and sector-to-pfn
> translation established for pmem namespaces.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/super.c |   39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 6e928f37d084..a27395cfcec6 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -86,12 +86,14 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
>  {
>  	struct dax_device *dax_dev;
>  	bool dax_enabled = false;
> +	pgoff_t pgoff, pgoff_end;
>  	struct request_queue *q;
> -	pgoff_t pgoff;
> -	int err, id;
> -	pfn_t pfn;
> -	long len;
>  	char buf[BDEVNAME_SIZE];
> +	void *kaddr, *end_kaddr;
> +	pfn_t pfn, end_pfn;
> +	sector_t last_page;
> +	long len, len2;
> +	int err, id;
>  
>  	if (blocksize != PAGE_SIZE) {
>  		pr_debug("%s: error: unsupported blocksize for dax\n",
> @@ -113,6 +115,15 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
>  		return false;
>  	}
>  
> +	last_page = ALIGN_DOWN(part_nr_sects_read(bdev->bd_part)
> +			- PAGE_SIZE / 512, PAGE_SIZE / 512);

Why not just (i_size_read(bdev->bd_inode) - 1) >> PAGE_SHIFT? Otherwise the
patch looks good to me.

								Honza


> +	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
> +	if (err) {
> +		pr_debug("%s: error: unaligned partition for dax\n",
> +				bdevname(bdev, buf));
> +		return false;
> +	}
> +
>  	dax_dev = dax_get_by_host(bdev->bd_disk->disk_name);
>  	if (!dax_dev) {
>  		pr_debug("%s: error: device does not support dax\n",
> @@ -121,14 +132,15 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
>  	}
>  
>  	id = dax_read_lock();
> -	len = dax_direct_access(dax_dev, pgoff, 1, NULL, &pfn);
> +	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
> +	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
>  	dax_read_unlock(id);
>  
>  	put_dax(dax_dev);
>  
> -	if (len < 1) {
> +	if (len < 1 || len2 < 1) {
>  		pr_debug("%s: error: dax access failed (%ld)\n",
> -				bdevname(bdev, buf), len);
> +				bdevname(bdev, buf), len < 1 ? len : len2);
>  		return false;
>  	}
>  
> @@ -143,13 +155,20 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
>  		 */
>  		WARN_ON(IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API));
>  		dax_enabled = true;
> -	} else if (pfn_t_devmap(pfn)) {
> -		struct dev_pagemap *pgmap;
> +	} else if (pfn_t_devmap(pfn) && pfn_t_devmap(end_pfn)) {
> +		struct dev_pagemap *pgmap, *end_pgmap;
>  
>  		pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
> -		if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
> +		end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
> +		if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
> +				&& pfn_t_to_page(pfn)->pgmap == pgmap
> +				&& pfn_t_to_page(end_pfn)->pgmap == pgmap
> +				&& pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
> +				&& pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))
>  			dax_enabled = true;
>  		put_dev_pagemap(pgmap);
> +		put_dev_pagemap(end_pgmap);
> +
>  	}
>  
>  	if (!dax_enabled) {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
