Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7517B2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfAJXUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:20:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbfAJXUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:20:30 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C33FD139E;
        Thu, 10 Jan 2019 23:20:27 +0000 (UTC)
Date:   Thu, 10 Jan 2019 15:20:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v5 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Message-Id: <20190110152026.9e622df4884d4931c79b971d@linux-foundation.org>
In-Reply-To: <1546543673-108536-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1546543673-108536-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Jan 2019 03:27:52 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Swap readahead would read in a few pages regardless if the underlying
> device is busy or not.  It may incur long waiting time if the device is
> congested, and it may also exacerbate the congestion.
> 
> Use inode_read_congested() to check if the underlying device is busy or
> not like what file page readahead does.  Get inode from swap_info_struct.
> Although we can add inode information in swap_address_space
> (address_space->host), it may lead some unexpected side effect, i.e.
> it may break mapping_cap_account_dirty().  Using inode from
> swap_info_struct seems simple and good enough.
> 
> ...
>
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -538,11 +538,18 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  	bool do_poll = true, page_allocated;
>  	struct vm_area_struct *vma = vmf->vma;
>  	unsigned long addr = vmf->address;
> +	struct inode *inode = NULL;
>  
>  	mask = swapin_nr_pages(offset) - 1;
>  	if (!mask)
>  		goto skip;
>  
> +	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
> +		inode = si->swap_file->f_mapping->host;
> +		if (inode_read_congested(inode))
> +			goto skip;
> +	}
> +
>  	do_poll = false;
>  	/* Read a page_cluster sized and aligned cluster around offset. */
>  	start_offset = offset & ~mask;

Neater:

--- a/mm/swap_state.c~mm-swap-check-if-swap-backing-device-is-congested-or-not-fix
+++ a/mm/swap_state.c
@@ -538,14 +538,13 @@ struct page *swap_cluster_readahead(swp_
 	bool do_poll = true, page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
-	struct inode *inode = NULL;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
 
 	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
-		inode = si->swap_file->f_mapping->host;
+		struct inode *inode = si->swap_file->f_mapping->host;
 		if (inode_read_congested(inode))
 			goto skip;
 	}
_

