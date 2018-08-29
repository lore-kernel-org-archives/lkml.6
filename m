Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A668C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D54E20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D54E20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeH3CYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:24:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeH3CYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:24:34 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9EB18BB6;
        Wed, 29 Aug 2018 22:25:34 +0000 (UTC)
Date:   Wed, 29 Aug 2018 15:25:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Larry Chen <lchen@suse.com>
Cc:     mfasheh@suse.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH] fix crash on ocfs2_duplicate_clusters_by_page
Message-Id: <20180829152533.431fd4972ae046943cabc2e3@linux-foundation.org>
In-Reply-To: <20180829074740.9438-1-lchen@suse.com>
References: <20180829074740.9438-1-lchen@suse.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 15:47:40 +0800 Larry Chen <lchen@suse.com> wrote:

> ocfs2_duplicate_clusters_by_page may crash if one of extent's pages is dirty.
> When a page has not been written back, it is still in dirty state. If 
> ocfs2_duplicate_clusters_by_page is called against the
> dirty page, the crash happens.
> 
> To fix this bug, we can just unlock the page and wait the page until
> it's not dirty.
> 
> The following is the buck trace dump:
> 
> kernel BUG at /root/code/ocfs2/refcounttree.c:2961!
> [exception RIP: ocfs2_duplicate_clusters_by_page+822]
> __ocfs2_move_extent+0x80/0x450 [ocfs2]
> ? __ocfs2_claim_clusters+0x130/0x250 [ocfs2]
> ocfs2_defrag_extent+0x5b8/0x5e0 [ocfs2]
> __ocfs2_move_extents_range+0x2a4/0x470 [ocfs2]
> ocfs2_move_extents+0x180/0x3b0 [ocfs2]
> ? ocfs2_wait_for_recovery+0x13/0x70 [ocfs2]
> ocfs2_ioctl_move_extents+0x133/0x2d0 [ocfs2]
> ocfs2_ioctl+0x253/0x640 [ocfs2]
> do_vfs_ioctl+0x90/0x5f0
> SyS_ioctl+0x74/0x80
> do_syscall_64+0x74/0x140
> entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> 
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -2946,6 +2946,7 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
>  		if (map_end & (PAGE_SIZE - 1))
>  			to = map_end & (PAGE_SIZE - 1);
>  
> +retry:
>  		page = find_or_create_page(mapping, page_index, GFP_NOFS);
>  		if (!page) {
>  			ret = -ENOMEM;
> @@ -2957,8 +2958,15 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
>  		 * In case PAGE_SIZE <= CLUSTER_SIZE, This page
>  		 * can't be dirtied before we CoW it out.
>  		 */

Looks sane, but the below change shows that the above comment is
untrue.  Can we please update the comment as well?


> -		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize)
> -			BUG_ON(PageDirty(page));
> +		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
> +			if (PageDirty(page)) {
> +				/*
> +				 * write_on_page will unlock the page on return
> +				 */
> +				ret = write_one_page(page);
> +				goto retry;
> +			}
> +		}
>  
>  		if (!PageUptodate(page)) {
>  			ret = block_read_full_page(page, ocfs2_get_block);

