Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E1C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832522B1C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yvRJT0Ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C832522B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeGFWeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754364AbeGFWeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:34:12 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBF822B1C;
        Fri,  6 Jul 2018 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530916451;
        bh=N5k1ZJGhgZ1AZkeMq0n7ppixrcB2yDA+TCwpQPe1Kpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvRJT0EeKj9V9uqAhFrnUBN78jKZbM0QwaCUgd12YMSL+xPGpN0uerVaERGdUkTOH
         TKq8DxJGzcol9EiuqS1pSQSQY6pn6Kk0iZ0TuCHMIoQ20SFWFWbvWVujNBM6qSjiks
         8BYthCESb6eFRdiXevFXeiCeticskRGLwT0xZkCo=
Date:   Fri, 6 Jul 2018 15:34:10 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 2/2] f2fs: let checkpoint flush dnode page of regular
Message-ID: <20180706223410.GB77984@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180703121253.44560-1-yuchao0@huawei.com>
 <20180703121253.44560-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703121253.44560-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03, Chao Yu wrote:
> Fsyncer will wait on all dnode pages of regular writeback before flushing,
> if there are async dnode pages blocked by IO scheduler, it may decrease
> fsync's performance.

So, it'd be better to keep tracking what we really need to wait for first.

> 
> In this patch, we choose to let f2fs_balance_fs_bg() to trigger checkpoint
> to flush these dnode pages of regular, so async IO of dnode page can be
> elimitnated, making fsyncer only need to wait for sync IO.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c    | 8 +++++++-
>  fs/f2fs/node.h    | 5 +++++
>  fs/f2fs/segment.c | 4 +++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0810c8117d46..eeee582cee32 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1384,6 +1384,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
>  
> +	if (wbc->sync_mode == WB_SYNC_NONE &&
> +			IS_DNODE(page) && is_cold_node(page))
> +		goto redirty_out;
> +
>  	/* get old block addr of this node page */
>  	nid = nid_of_node(page);
>  	f2fs_bug_on(sbi, page->index != nid);
> @@ -1698,10 +1702,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>  	}
>  
>  	if (step < 2) {
> +		if (wbc->sync_mode == WB_SYNC_NONE && step == 1)
> +			goto out;
>  		step++;
>  		goto next_step;
>  	}
> -
> +out:
>  	if (nwritten)
>  		f2fs_submit_merged_write(sbi, NODE);
>  
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index b95e49e4a928..b0da4c26eebb 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -135,6 +135,11 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
>  	return NM_I(sbi)->nat_cnt >= DEF_NAT_CACHE_THRESHOLD;
>  }
>  
> +static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
> +{
> +	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
> +}
> +
>  enum mem_type {
>  	FREE_NIDS,	/* indicates the free nid list */
>  	NAT_ENTRIES,	/* indicates the cached nat entry */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bbe6e1596611..13f5e3665bf0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -503,7 +503,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  	else
>  		f2fs_build_free_nids(sbi, false, false);
>  
> -	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
> +	if (!is_idle(sbi) &&
> +		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
>  		return;
>  
>  	/* checkpoint is the only way to shrink partial cached entries */
> @@ -511,6 +512,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
>  			excess_prefree_segs(sbi) ||
>  			excess_dirty_nats(sbi) ||
> +			excess_dirty_nodes(sbi) ||
>  			f2fs_time_over(sbi, CP_TIME)) {
>  		if (test_opt(sbi, DATA_FLUSH)) {
>  			struct blk_plug plug;
> -- 
> 2.18.0.rc1
