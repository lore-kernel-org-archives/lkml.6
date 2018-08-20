Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989AFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508D92154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508D92154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeHTMrY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:47:24 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:51357 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeHTMrY (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Mon, 20 Aug 2018 08:47:24 -0400
X-Greylist: delayed 1223 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2018 08:47:24 EDT
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 20 Aug 2018 03:12:12 -0600
Message-Id: <5B7A85DF020000F90002F815@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Mon, 20 Aug 2018 03:11:59 -0600
From:   "Gang He" <ghe@suse.com>
To:     <jlbec@evilplan.org>, "Lei Chen" <lchen@suse.com>,
        <mfasheh@versity.com>
Cc:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Ocfs2-devel] [PATCH] fix crash on
 ocfs2_duplicate_clusters_by_page
References: <20180816112426.12218-1-lchen@suse.com>
In-Reply-To: <20180816112426.12218-1-lchen@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry,


>>> On 2018/8/16 at 19:24, in message <20180816112426.12218-1-lchen@suse.com>,
Larry Chen <lchen@suse.com> wrote:
> ocfs2_duplicate_clusters_by_page may crash if an extent's page is dirty.
> When a page has not been written back, it is still in dirty state. If at
> that moment, ocfs2_duplicate_clusters_by_page is called against this
> page, the crash happens.
> 
> To fix this bug, we can just unlock the page and wait the page until
> it's not dirty.
> 
> I don't know whether the patch is appropriate, so I need comments,
> thanks.
> 
> The following is the core dump:
> 
> kernel BUG at /root/code/ocfs2/refcounttree.c:2961!
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
> To: mfasheh@versity.com,
>     jlbec@evilplan.org 
> Cc: linux-kernel@vger.kernel.org,
>     ocfs2-devel@oss.oracle.com,
>     akpm@linux-foundation.org 
> 
> Signed-off-by: Larry Chen <lchen@suse.com>
> ---
>  fs/ocfs2/refcounttree.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index 7869622af22a..ee3b9dbbc310 100644
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
> @@ -2957,8 +2958,13 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
>  		 * In case PAGE_SIZE <= CLUSTER_SIZE, This page
>  		 * can't be dirtied before we CoW it out.
>  		 */
> -		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize)
> -			BUG_ON(PageDirty(page));
> +		if (PAGE_SIZE <= OCFS2_SB(sb)->s_clustersize) {
> +			if (PageDirty(page)) {
> +				unlock_page(page);
Here, if we find this page is dirty, could we write this page to the disk initiatively? rather than wait for the page become clean by VM mechanism.

Thanks
Gang 

> +				cond_resched();
> +				goto retry;
> +			}
> +		}
>  
>  		if (!PageUptodate(page)) {
>  			ret = block_read_full_page(page, ocfs2_get_block);
> -- 
> 2.13.7
> 
> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com 
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel

