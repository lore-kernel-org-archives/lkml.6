Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeA3IO2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 03:14:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:56073 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeA3IO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 03:14:27 -0500
Date: Tue, 30 Jan 2018 09:14:15 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Zi Yan <zi.yan@sent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in
 do_move_pages_to_node()
Message-ID: <20180130081415.GO21609@dhcp22.suse.cz>
References: <20180130030011.4310-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130030011.4310-1-zi.yan@sent.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-01-18 22:00:11, Zi Yan wrote:
> From: Zi Yan <zi.yan@cs.rutgers.edu>
> 
> migrate_pages() requires at least down_read(mmap_sem) to protect
> related page tables and VMAs from changing. Let's do it in
> do_page_moves() for both do_move_pages_to_node() and
> add_page_for_migration().
> 
> Also add this lock requirement in the comment of migrate_pages().

This doesn't make much sense to me, to be honest. We are holding
mmap_sem for _read_ so we allow parallel updates like page faults
or unmaps. Therefore we are isolating pages prior to the migration.

The sole purpose of the mmap_sem in add_page_for_migration is to protect
from vma going away _while_ need it to get the proper page.

Moving the lock up is just wrong because it allows caller to hold the
lock for way too long if a lot of pages is migrated. Not only that,
it is even incorrect because we are doing get_user() (aka page fault)
and while read lock recursion is OK, we might block and deadlock when
there is a writer pending. I haven't checked the current implementation
of semaphores but I believe we do not allow recursive locking.

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

-- 
Michal Hocko
SUSE Labs
