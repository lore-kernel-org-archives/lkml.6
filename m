Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755998AbeDZQIi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756204AbeDZQIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:08:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F221745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 26 Apr 2018 10:08:34 -0600
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH 2/3] f2fs: introduce {create,destroy}_discard_caches for
 cleanup
Message-ID: <20180426160834.GJ68594@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180425093831.124591-1-yuchao0@huawei.com>
 <20180425093831.124591-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425093831.124591-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25, Chao Yu wrote:
> Split discard slab cache related initial/release codes into separated
> function {create,destroy}_discard_caches, later we can maintain those
> independent functions in separated discard.c

No need this as well.

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h    |  2 ++
>  fs/f2fs/segment.c | 24 ++++++++++++++++--------
>  fs/f2fs/super.c   |  8 +++++++-
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9416669b7105..c8d6d27384f1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2856,6 +2856,8 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
>  void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  int build_segment_manager(struct f2fs_sb_info *sbi);
>  void destroy_segment_manager(struct f2fs_sb_info *sbi);
> +int __init create_discard_caches(void);
> +void destroy_discard_caches(void);
>  int __init create_segment_manager_caches(void);
>  void destroy_segment_manager_caches(void);
>  int rw_hint_to_seg_type(enum rw_hint hint);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d5627195aa8e..187f957747be 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3993,7 +3993,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
>  	kfree(sm_info);
>  }
>  
> -int __init create_segment_manager_caches(void)
> +int __init create_discard_caches(void)
>  {
>  	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
>  			sizeof(struct discard_entry));
> @@ -4004,11 +4004,25 @@ int __init create_segment_manager_caches(void)
>  			sizeof(struct discard_cmd));
>  	if (!discard_cmd_slab)
>  		goto destroy_discard_entry;
> +	return 0;
> +destroy_discard_entry:
> +	kmem_cache_destroy(discard_entry_slab);
> +fail:
> +	return -ENOMEM;
> +}
> +
> +void destroy_discard_caches(void)
> +{
> +	kmem_cache_destroy(discard_cmd_slab);
> +	kmem_cache_destroy(discard_entry_slab);
> +}
>  
> +int __init create_segment_manager_caches(void)
> +{
>  	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
>  			sizeof(struct sit_entry_set));
>  	if (!sit_entry_set_slab)
> -		goto destroy_discard_cmd;
> +		goto fail;
>  
>  	inmem_entry_slab = f2fs_kmem_cache_create("inmem_page_entry",
>  			sizeof(struct inmem_pages));
> @@ -4018,10 +4032,6 @@ int __init create_segment_manager_caches(void)
>  
>  destroy_sit_entry_set:
>  	kmem_cache_destroy(sit_entry_set_slab);
> -destroy_discard_cmd:
> -	kmem_cache_destroy(discard_cmd_slab);
> -destroy_discard_entry:
> -	kmem_cache_destroy(discard_entry_slab);
>  fail:
>  	return -ENOMEM;
>  }
> @@ -4029,7 +4039,5 @@ int __init create_segment_manager_caches(void)
>  void destroy_segment_manager_caches(void)
>  {
>  	kmem_cache_destroy(sit_entry_set_slab);
> -	kmem_cache_destroy(discard_cmd_slab);
> -	kmem_cache_destroy(discard_entry_slab);
>  	kmem_cache_destroy(inmem_entry_slab);
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7e6fab673073..252133f5d110 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3084,9 +3084,12 @@ static int __init init_f2fs_fs(void)
>  	err = create_segment_manager_caches();
>  	if (err)
>  		goto free_node_manager_caches;
> -	err = create_checkpoint_caches();
> +	err = create_discard_caches();
>  	if (err)
>  		goto free_segment_manager_caches;
> +	err = create_checkpoint_caches();
> +	if (err)
> +		goto free_discard_caches;
>  	err = create_extent_cache();
>  	if (err)
>  		goto free_checkpoint_caches;
> @@ -3119,6 +3122,8 @@ static int __init init_f2fs_fs(void)
>  	destroy_extent_cache();
>  free_checkpoint_caches:
>  	destroy_checkpoint_caches();
> +free_discard_caches:
> +	destroy_discard_caches();
>  free_segment_manager_caches:
>  	destroy_segment_manager_caches();
>  free_node_manager_caches:
> @@ -3138,6 +3143,7 @@ static void __exit exit_f2fs_fs(void)
>  	f2fs_exit_sysfs();
>  	destroy_extent_cache();
>  	destroy_checkpoint_caches();
> +	destroy_discard_caches();
>  	destroy_segment_manager_caches();
>  	destroy_node_manager_caches();
>  	destroy_inodecache();
> -- 
> 2.15.0.55.gc2ece9dc4de6
