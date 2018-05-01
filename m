Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEAGcy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 02:32:54 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39743 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAGcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 02:32:52 -0400
X-Google-Smtp-Source: AB8JxZqscyFQf2sbBzeLHKu1DBEyiTrcl+fDE5Pbo0CwwFngia7Nt2uWJTaF2hM3QfGOIgKKgzhEOA==
Date: Mon, 30 Apr 2018 23:32:42 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: kirill.shutemov@linux.intel.com, hughd@google.com, mhocko@kernel.org,
        hch@infradead.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v5 PATCH] mm: shmem: make stat.st_blksize return huge page
 size if THP is on
In-Reply-To: <1524665633-83806-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.1804302217530.5864@eggly.anvils>
References: <1524665633-83806-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Yang Shi wrote:

> Since tmpfs THP was supported in 4.8, hugetlbfs is not the only
> filesystem with huge page support anymore. tmpfs can use huge page via
> THP when mounting by "huge=" mount option.
> 
> When applications use huge page on hugetlbfs, it just need check the
> filesystem magic number, but it is not enough for tmpfs. Make
> stat.st_blksize return huge page size if it is mounted by appropriate
> "huge=" option to give applications a hint to optimize the behavior with
> THP.
> 
> Some applications may not do wisely with THP. For example, QEMU may mmap
> file on non huge page aligned hint address with MAP_FIXED, which results
> in no pages are PMD mapped even though THP is used. Some applications
> may mmap file with non huge page aligned offset. Both behaviors make THP
> pointless.
> 
> statfs.f_bsize still returns 4KB for tmpfs since THP could be split, and it
> also may fallback to 4KB page silently if there is not enough huge page.
> Furthermore, different f_bsize makes max_blocks and free_blocks
> calculation harder but without too much benefit. Returning huge page
> size via stat.st_blksize sounds good enough.
> 
> Since PUD size huge page for THP has not been supported, now it just
> returns HPAGE_PMD_SIZE.
> 
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>

Sorry, I have no enthusiasm for this patch; but do I feel strongly
enough to override you and everyone else to NAK it? No, I don't
feel that strongly, maybe st_blksize isn't worth arguing over.

We did look at struct stat when designing huge tmpfs, to see if there
were any fields that should be adjusted for it; but concluded none.
Yes, it would sometimes be nice to have a quickly accessible indicator
for when tmpfs has been mounted huge (scanning /proc/mounts for options
can be tiresome, agreed); but since tmpfs tries to supply huge (or not)
pages transparently, no difference seemed right.

So, because st_blksize is a not very useful field of struct stat,
with "size" in the name, we're going to put HPAGE_PMD_SIZE in there
instead of PAGE_SIZE, if the tmpfs was mounted with one of the huge
"huge" options (force or always, okay; within_size or advise, not so
much). Though HPAGE_PMD_SIZE is no more its "preferred I/O size" or
"blocksize for file system I/O" than PAGE_SIZE was.

Which we can expect to speed up some applications and disadvantage
others, depending on how they interpret st_blksize: just like if
we changed it in the same way on non-huge tmpfs.  (Did I actually
try changing st_blksize early on, and find it broke something? If
so, I've now forgotten what, and a search through commit messages
didn't find it; but I guess we'll find out soon enough.)

If there were an mstat() syscall, returning a field "preferred
alignment", then we could certainly agree to put HPAGE_PMD_SIZE in
there; but in stat()'s st_blksize? And what happens when (in future)
mm maps this or that hard-disk filesystem's blocks with a pmd mapping
- should that filesystem then advertise a bigger st_blksize, despite
the same disk layout as before? What happens with DAX?

And this change is not going to help the QEMU suboptimality that
brought you here (or does QEMU align mmaps according to st_blksize?).
QEMU ought to work well with kernels without this change, and kernels
with this change; and I hope it can easily deal with both by avoiding
that use of MAP_FIXED which prevented the kernel's intended alignment.

Hugh

> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> ---
> v4 --> v5:
> * Adopted suggestion from Kirill to use IS_ENABLED and check 'force' and
>   'deny'. Extracted the condition into an inline helper.
> v3 --> v4:
> * Rework the commit log per the education from Michal and Kirill
> * Fix build error if CONFIG_TRANSPARENT_HUGEPAGE is disabled
> v2 --> v3:
> * Use shmem_sb_info.huge instead of global variable per Michal's comment
> v2 --> v1:
> * Adopted the suggestion from hch to return huge page size via st_blksize
>   instead of creating a new flag.
> 
>  mm/shmem.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b859192..e9e888b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -571,6 +571,16 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGE_PAGECACHE */
>  
> +static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
> +{
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE) &&
> +	    (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
> +	    shmem_huge != SHMEM_HUGE_DENY)
> +		return true;
> +	else
> +		return false;
> +}
> +
>  /*
>   * Like add_to_page_cache_locked, but error if expected item has gone.
>   */
> @@ -988,6 +998,7 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
>  {
>  	struct inode *inode = path->dentry->d_inode;
>  	struct shmem_inode_info *info = SHMEM_I(inode);
> +	struct shmem_sb_info *sb_info = SHMEM_SB(inode->i_sb);
>  
>  	if (info->alloced - info->swapped != inode->i_mapping->nrpages) {
>  		spin_lock_irq(&info->lock);
> @@ -995,6 +1006,10 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
>  		spin_unlock_irq(&info->lock);
>  	}
>  	generic_fillattr(inode, stat);
> +
> +	if (is_huge_enabled(sb_info))
> +		stat->blksize = HPAGE_PMD_SIZE;
> +
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
> 
> 
