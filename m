Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeCCN4w (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 08:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbeCCN4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 08:56:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B742121783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1520085408.4280.21.camel@kernel.org>
Subject: Re: [PATCH v7 05/61] Export __set_page_dirty
From: Jeff Layton <jlayton@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date: Sat, 03 Mar 2018 08:56:48 -0500
In-Reply-To: <20180219194556.6575-6-willy@infradead.org>
References: <20180219194556.6575-1-willy@infradead.org>
         <20180219194556.6575-6-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-19 at 11:45 -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> XFS currently contains a copy-and-paste of __set_page_dirty().  Export
> it from buffer.c instead.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  fs/buffer.c        |  3 ++-
>  fs/xfs/xfs_aops.c  | 15 ++-------------
>  include/linux/mm.h |  1 +
>  3 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9a73924db22f..0b487cdb7124 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -594,7 +594,7 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
>   *
>   * The caller must hold lock_page_memcg().
>   */
> -static void __set_page_dirty(struct page *page, struct address_space *mapping,
> +void __set_page_dirty(struct page *page, struct address_space *mapping,
>  			     int warn)
>  {
>  	unsigned long flags;
> @@ -608,6 +608,7 @@ static void __set_page_dirty(struct page *page, struct address_space *mapping,
>  	}
>  	spin_unlock_irqrestore(&mapping->tree_lock, flags);
>  }
> +EXPORT_SYMBOL_GPL(__set_page_dirty);
>  
>  /*
>   * Add a page to the dirty page list.
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index 9c6a830da0ee..31f2c4895a46 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1472,19 +1472,8 @@ xfs_vm_set_page_dirty(
>  	newly_dirty = !TestSetPageDirty(page);
>  	spin_unlock(&mapping->private_lock);
>  
> -	if (newly_dirty) {
> -		/* sigh - __set_page_dirty() is static, so copy it here, too */
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&mapping->tree_lock, flags);
> -		if (page->mapping) {	/* Race with truncate? */
> -			WARN_ON_ONCE(!PageUptodate(page));
> -			account_page_dirtied(page, mapping);
> -			radix_tree_tag_set(&mapping->page_tree,
> -					page_index(page), PAGECACHE_TAG_DIRTY);
> -		}
> -		spin_unlock_irqrestore(&mapping->tree_lock, flags);
> -	}
> +	if (newly_dirty)
> +		__set_page_dirty(page, mapping, 1);
>  	unlock_page_memcg(page);
>  	if (newly_dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ad06d42adb1a..47b0fb0a6e41 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1454,6 +1454,7 @@ extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
>  extern void do_invalidatepage(struct page *page, unsigned int offset,
>  			      unsigned int length);
>  
> +void __set_page_dirty(struct page *, struct address_space *, int warn);
>  int __set_page_dirty_nobuffers(struct page *page);
>  int __set_page_dirty_no_writeback(struct page *page);
>  int redirty_page_for_writepage(struct writeback_control *wbc,

Acked-by: Jeff Layton <jlayton@kernel.org>
