Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F79C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8789B2540A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8789B2540A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeGBH5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:57:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:40536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752183AbeGBH5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:57:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04943AD3A;
        Mon,  2 Jul 2018 07:57:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCEEE1E3BDF; Mon,  2 Jul 2018 09:57:27 +0200 (CEST)
Date:   Mon, 2 Jul 2018 09:57:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        willy@infradead.org, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, jack@suse.com, chengnt@lenovo.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH 3/3] fs/ext2/inode: Optimize the condition for iomap_begin
Message-ID: <20180702075727.3s7yymczrmm4xiox@quack2.suse.cz>
References: <20180701061848.7036-1-yehs2007@zoho.com>
 <20180701061848.7036-3-yehs2007@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180701061848.7036-3-yehs2007@zoho.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01-07-18 14:18:48, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> If ext2_get_blocks returns negative result, ext2_iomap_begin
> will return for error case.
> Adjust the judging condition of ret value will be useful for
> code simplification.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

I'm sorry but how exactly is this simpler?

								Honza

> ---
>  fs/ext2/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index ca211bd..9b1004d 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -819,15 +819,15 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	iomap->offset = (loff_t)first_block << blkbits;
>  	iomap->dax_dev = sbi->s_daxdev;
>  
> -	if (ret == 0) {
> -		iomap->type = IOMAP_HOLE;
> -		iomap->addr = IOMAP_NULL_ADDR;
> -		iomap->length = 1 << blkbits;
> -	} else {
> +	if (ret) {
>  		iomap->type = IOMAP_MAPPED;
>  		iomap->addr = (u64)bno << blkbits;
>  		iomap->length = (u64)ret << blkbits;
>  		iomap->flags |= IOMAP_F_MERGED;
> +	} else {
> +		iomap->type = IOMAP_HOLE;
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->length = 1 << blkbits;
>  	}
>  
>  	if (new)
> -- 
> 1.8.3.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
