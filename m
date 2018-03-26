Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeCZX0i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 19:26:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCZX0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 19:26:36 -0400
Date: Mon, 26 Mar 2018 16:26:34 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH v9 00/61] XArray v9
Message-ID: <20180326232634.GA10054@bombadil.infradead.org>
References: <20180313132639.17387-1-willy@infradead.org>
 <20180326153648.27f53e9a1398812203745257@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326153648.27f53e9a1398812203745257@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 03:36:48PM -0700, Andrew Morton wrote:
> I looked at this from a for-4.17 POV and ran out of nerve at "[PATCH v9
> 09/61] xarray: Replace exceptional entries".  It's awfully late.

I did post v7 five weeks ago ... it wasn't late at the time.

> "[PATCH v9 08/61] page cache: Use xa_lock" looks sufficiently
> mechanical to be if-it-compiles-it-works, although perhaps that
> shouldn't be in 4.17 either.  Mainly because it commits us to merging
> the rest of XArray and there hasn't been a ton of review and test
> activity.

I think we should commit to that.  The API has had a pretty thorough
review, and nobody's stepped up to say "Hey, no, I prefer the old API,
I don't want to see it change".  Merging patch 8 would move us a good
chunk of the way towards getting the IDA in a position where it can
be converted.  Patch 9 would get us even further, but I'm willing to
respin in order to build on just patch 8.

> It looks like btrfs has changed in -next:
> 
> --- a/fs/btrfs/inode.c~page-cache-use-xa_lock-fix
> +++ a/fs/btrfs/inode.c
> @@ -7445,7 +7445,7 @@ out:
>  
>  bool btrfs_page_exists_in_range(struct inode *inode, loff_t start, loff_t end)
>  {
> -	struct radix_tree_root *root = &inode->i_mapping->page_tree;
> +	struct radix_tree_root *root = &inode->i_mapping->i_pages;
>  	bool found = false;
>  	void **pagep = NULL;
>  	struct page *page = NULL;

btrfs_page_exists_in_range() has been deleted -- David Sterba merged the
patch v8-0006-btrfs-Use-filemap_range_has_page.patch ... which was dropped
from v9 of the patchset, so I'm not sure what you're actually looking at?
