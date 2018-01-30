Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeA3EK4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 23:10:56 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34822 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeA3EKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 23:10:54 -0500
X-Google-Smtp-Source: AH8x224YZODcjMLIyrntE1DagRXLR33mFh5LggCqp9XTFb3SjeKFfmrvNXu5En1Kn+/HFmlKESPiKA==
Date: Mon, 29 Jan 2018 20:10:45 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Zi Yan <zi.yan@sent.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in
 do_move_pages_to_node()
In-Reply-To: <20180130030011.4310-1-zi.yan@sent.com>
Message-ID: <alpine.LSU.2.11.1801291943330.2657@eggly.anvils>
References: <20180130030011.4310-1-zi.yan@sent.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018, Zi Yan wrote:
> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> migrate_pages() requires at least down_read(mmap_sem) to protect
> related page tables and VMAs from changing. Let's do it in

Page tables are protected by their locks.  VMAs may change while
migration is active on them, but does that need locking against?

> do_page_moves() for both do_move_pages_to_node() and
> add_page_for_migration().
> 
> Also add this lock requirement in the comment of migrate_pages().
> 
> Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
> ---
>  mm/migrate.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5d0dc7b85f90..52d029953c32 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1354,6 +1354,9 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>   * or free list only if ret != 0.
>   *
>   * Returns the number of pages that were not migrated, or an error code.
> + *
> + * The caller must hold at least down_read(mmap_sem) for to-be-migrated pages
> + * to protect related page tables and VMAs from changing.

I have not been keeping up with Michal's recent migration changes,
but migrate_pages() never used to need mmap_sem held (despite being
called with an mmap_sem held from some of its callsites), and it
would be a backward step to require that now.

There is not even an mm argument to migrate_pages(), so which
mm->mmap_sem do you think would be required for it?  There may be
particular cases in which it is required (when the new_page function
involves the old_page's vma - is that so below?), but in general not.

Hugh

>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> @@ -1457,6 +1460,12 @@ static int store_status(int __user *status, int start, int value, int nr)
>  	return 0;
>  }
>  
> +/*
> + * Migrates the pages from pagelist and put back those not migrated.
> + *
> + * The caller must at least hold down_read(mmap_sem), which is required
> + * for migrate_pages()
> + */
>  static int do_move_pages_to_node(struct mm_struct *mm,
>  		struct list_head *pagelist, int node)
>  {
> @@ -1487,7 +1496,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  	unsigned int follflags;
>  	int err;
>  
> -	down_read(&mm->mmap_sem);
>  	err = -EFAULT;
>  	vma = find_vma(mm, addr);
>  	if (!vma || addr < vma->vm_start || !vma_migratable(vma))
> @@ -1540,7 +1548,6 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	put_page(page);
>  out:
> -	up_read(&mm->mmap_sem);
>  	return err;
>  }
>  
> @@ -1561,6 +1568,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  
>  	migrate_prep();
>  
> +	down_read(&mm->mmap_sem);
>  	for (i = start = 0; i < nr_pages; i++) {
>  		const void __user *p;
>  		unsigned long addr;
> @@ -1628,6 +1636,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  	if (!err)
>  		err = err1;
>  out:
> +	up_read(&mm->mmap_sem);
>  	return err;
>  }
>  
> -- 
> 2.15.1
