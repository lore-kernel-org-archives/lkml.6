Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeERNNK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:13:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERNNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:13:08 -0400
Date: Fri, 18 May 2018 06:13:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH 01/10] mm: pagecache add lock
Message-ID: <20180518131305.GA6361@bombadil.infradead.org>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518074918.13816-3-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 03:49:00AM -0400, Kent Overstreet wrote:
> Add a per address space lock around adding pages to the pagecache - making it
> possible for fallocate INSERT_RANGE/COLLAPSE_RANGE to work correctly, and also
> hopefully making truncate and dio a bit saner.

(moving this section here from the overall description so I can reply
to it in one place)

>  * pagecache add lock
> 
> This is the only one that touches existing code in nontrivial ways.
> The problem it's solving is that there is no existing general mechanism
> for shooting down pages in the page and keeping them removed, which is a
> real problem if you're doing anything that modifies file data and isn't
> buffered writes.
> 
> Historically, the only problematic case has been direct IO, and people
> have been willing to say "well, if you mix buffered and direct IO you
> get what you deserve", and that's probably not unreasonable. But now we
> have fallocate insert range and collapse range, and those are broken in
> ways I frankly don't want to think about if they can't ensure consistency
> with the page cache.

ext4 manages collapse-vs-pagefault with the ext4-specific i_mmap_sem.
You may get pushback on the grounds that this ought to be a
filesystem-specific lock rather than one embedded in the generic inode.

> Also, the mechanism truncate uses (i_size and sacrificing a goat) has
> historically been rather fragile, IMO it might be a good think if we
> switched it to a more general rigorous mechanism.
> 
> I need this solved for bcachefs because without this mechanism, the page
> cache inconsistencies lead to various assertions popping (primarily when
> we didn't think we need to get a disk reservation going by page cache
> state, but then do the actual write and disk space accounting says oops,
> we did need one). And having to reason about what can happen without
> a locking mechanism for this is not something I care to spend brain
> cycles on.
> 
> That said, my patch is kind of ugly, and it requires filesystem changes
> for other filesystems to take advantage of it. And unfortunately, since
> one of the code paths that needs locking is readahead, I don't see any
> realistic way of implementing the locking within just bcachefs code.
> 
> So I'm hoping someone has an idea for something cleaner (I think I recall
> Matthew Wilcox saying he had an idea for how to use xarray to solve this),
> but if not I'll polish up my pagecache add lock patch and see what I can
> do to make it less ugly, and hopefully other people find it palatable
> or at least useful.

My idea with the XArray is that we have a number of reserved entries which
we can use as blocking entries.  I was originally planning on making this
an XArray feature, but I now believe it's a page-cache-special feature.
We can always revisit that decision if it turns out to be useful to
another user.

API:

int filemap_block_range(struct address_space *mapping, loff_t start,
		loff_t end);
void filemap_remove_block(struct address_space *mapping, loff_t start,
		loff_t end);

 - After removing a block, the pagecache is empty between [start, end].
 - You have to treat the block as a single entity; don't unblock only
   a subrange of the range you originally blocked.
 - Lookups of a page within a blocked range return NULL.
 - Attempts to add a page to a blocked range sleep on one of the
   page_wait_table queues.
 - Attempts to block a blocked range will also sleep on one of the
   page_wait_table queues.  Is this restriction acceptable for your use
   case?  It's clearly not a problem for fallocate insert/collapse.  It
   would only be a problem for Direct I/O if people are doing subpage
   directio from within the same page.  I think that's rare enough to
   not be a problem (but please tell me if I'm wrong!)
