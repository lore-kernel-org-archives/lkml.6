Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE69208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE69208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933611AbeGDLaR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:30:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753600AbeGDLaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:30:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF12DAE07;
        Wed,  4 Jul 2018 11:30:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 047E11E3C02; Wed,  4 Jul 2018 13:30:13 +0200 (CEST)
Date:   Wed, 4 Jul 2018 13:30:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        ross.zwisler@linux.intel.com, mawilcox@microsoft.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.com, chengnt@lenovo.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH 3/3] fs/dax: Assigning NULL to gfn of dax_direct_access
 if useless
Message-ID: <20180704113012.trnfzeefao25clri@quack2.suse.cz>
References: <20180704064058.1344-1-yehs2007@zoho.com>
 <20180704064058.1344-3-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704064058.1344-3-yehs2007@zoho.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-07-18 14:40:58, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Some functions within fs/dax don't need to get gfn from direct_access.
> Assigning NULL to gfn of dax_direct_access is more intuitive and simple
> than offering a useless local variable.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

I like this. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

for the series.

								Honza

> ---
>  fs/dax.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index aaec72de..aa75dfd 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -550,7 +550,6 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>  {
>  	void *vto, *kaddr;
>  	pgoff_t pgoff;
> -	pfn_t pfn;
>  	long rc;
>  	int id;
>  
> @@ -559,7 +558,7 @@ static int copy_user_dax(struct block_device *bdev, struct dax_device *dax_dev,
>  		return rc;
>  
>  	id = dax_read_lock();
> -	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, &pfn);
> +	rc = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size), &kaddr, NULL);
>  	if (rc < 0) {
>  		dax_read_unlock(id);
>  		return rc;
> @@ -961,7 +960,6 @@ int __dax_zero_page_range(struct block_device *bdev,
>  		pgoff_t pgoff;
>  		long rc, id;
>  		void *kaddr;
> -		pfn_t pfn;
>  
>  		rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
>  		if (rc)
> @@ -969,7 +967,7 @@ int __dax_zero_page_range(struct block_device *bdev,
>  
>  		id = dax_read_lock();
>  		rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr,
> -				&pfn);
> +				NULL);
>  		if (rc < 0) {
>  			dax_read_unlock(id);
>  			return rc;
> @@ -1024,7 +1022,6 @@ int __dax_zero_page_range(struct block_device *bdev,
>  		ssize_t map_len;
>  		pgoff_t pgoff;
>  		void *kaddr;
> -		pfn_t pfn;
>  
>  		if (fatal_signal_pending(current)) {
>  			ret = -EINTR;
> @@ -1036,7 +1033,7 @@ int __dax_zero_page_range(struct block_device *bdev,
>  			break;
>  
>  		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
> -				&kaddr, &pfn);
> +				&kaddr, NULL);
>  		if (map_len < 0) {
>  			ret = map_len;
>  			break;
> -- 
> 1.8.3.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
