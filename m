Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeC0A3N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 20:29:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54086 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751776AbeC0A3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 20:29:11 -0400
Date: Mon, 26 Mar 2018 17:28:41 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 05/61] Export __set_page_dirty
Message-ID: <20180327002841.GI4807@magnolia>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180313132639.17387-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313132639.17387-6-willy@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803260238
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 06:25:43AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> XFS currently contains a copy-and-paste of __set_page_dirty().  Export
> it from buffer.c instead.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/buffer.c        |  3 ++-
>  fs/xfs/xfs_aops.c  | 15 ++-------------
>  include/linux/mm.h |  1 +
>  3 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 17f13191a552..62bf5445c921 100644
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
> index a0afb6411417..f51350cb98a7 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -1473,19 +1473,8 @@ xfs_vm_set_page_dirty(
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
> index 4d02524a7998..7f7bb4c28497 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1456,6 +1456,7 @@ extern int try_to_release_page(struct page * page, gfp_t gfp_mask);
>  extern void do_invalidatepage(struct page *page, unsigned int offset,
>  			      unsigned int length);
>  
> +void __set_page_dirty(struct page *, struct address_space *, int warn);
>  int __set_page_dirty_nobuffers(struct page *page);
>  int __set_page_dirty_no_writeback(struct page *page);
>  int redirty_page_for_writepage(struct writeback_control *wbc,
> -- 
> 2.16.1
> 
