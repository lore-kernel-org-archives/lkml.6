Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E26C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6540221A6C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1pNXdUsm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6540221A6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeFUTDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeFUTDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:03:06 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B8D21A2F;
        Thu, 21 Jun 2018 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529607785;
        bh=idArg13Ou098hKJheGtDYM/RCAH4aESbOK39vOUIMq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pNXdUsmQqz2P/IyGVI3etG0Sdq5h57h5mILuMxYAq8p+Ekj8KXaRT7ifqEKq6gRo
         QtDjCq2axY5lAwqd0+hFCkYl45PK+H6iEsC0filC09exS0DLeWjZ/MjA96mW+vH6I7
         WbuvvOWFQxFlZUhDRH1k2Kcvyr+3ZL08rCw9r9Lw=
Date:   Thu, 21 Jun 2018 12:03:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Yunlei He <heyunlei@huawei.com>
Subject: Re: [PATCH] f2fs: disable f2fs_check_rb_tree_consistence
Message-ID: <20180621190305.GB77164@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180621033936.108796-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621033936.108796-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21, Chao Yu wrote:
> If there is millions of discard entries cached in rb tree, each
> sanity check of it can cause very long latency as held cmd_lock
> blocking other lock grabbers.
> 
> In other aspect, we have enabled the check very long time, as
> we see, there is no such inconsistent condition caused by bugs.
> 
> But still we do not choose to kill it directly, instead, adding
> an flag to disable the check now, if there is related code change,
> we can reuse it to detect bugs.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 49c687173923..412e907920c2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -309,6 +309,7 @@ struct discard_cmd_control {
>  	atomic_t issing_discard;		/* # of issing discard */
>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
>  	struct rb_root root;			/* root of discard rb-tree */
> +	bool rbtree_check;			/* config for consistence check */
>  };
>  
>  /* for the list of fsync inodes, used only during recovery */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6dbdf2c48fba..8c1d6c546fa0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1199,8 +1199,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  		mutex_lock(&dcc->cmd_lock);
>  		if (list_empty(pend_list))
>  			goto next;
> -		f2fs_bug_on(sbi,
> -			!f2fs_check_rb_tree_consistence(sbi, &dcc->root));
> +		if (dcc->rbtree_check)

		unlikely()?

> +			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
> +								&dcc->root));
>  		blk_start_plug(&plug);
>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>  			f2fs_bug_on(sbi, dc->state != D_PREP);
> @@ -1752,6 +1753,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>  	dcc->undiscard_blks = 0;
>  	dcc->root = RB_ROOT;
> +	dcc->rbtree_check = false;
>  
>  	init_waitqueue_head(&dcc->discard_wait_queue);
>  	SM_I(sbi)->dcc_info = dcc;
> @@ -2381,7 +2383,9 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
>  	issued = 0;
>  
>  	mutex_lock(&dcc->cmd_lock);
> -	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi, &dcc->root));
> +	if (dcc->rbtree_check)

		unlikely()?

> +		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
> +								&dcc->root));
>  
>  	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
>  					NULL, start,
> -- 
> 2.18.0.rc1
