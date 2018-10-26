Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E13C46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEDD204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEDD204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeJZJSh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:18:37 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:54023 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJZJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:18:36 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w9Q0hKiO007902
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 09:43:20 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9Q0hKej022713;
        Fri, 26 Oct 2018 09:43:20 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w9Q0hKr7031350;
        Fri, 26 Oct 2018 09:43:20 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.151] [10.38.151.151]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-4946118; Fri, 26 Oct 2018 09:42:22 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC23GP.gisp.nec.co.jp ([10.38.151.151]) with mapi id 14.03.0319.002; Fri,
 26 Oct 2018 09:42:21 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH RFC v2 1/1] hugetlbfs: use i_mmap_rwsem for pmd sharing
 and truncate/fault sync
Thread-Topic: [PATCH RFC v2 1/1] hugetlbfs: use i_mmap_rwsem for pmd sharing
 and truncate/fault sync
Thread-Index: AQHUa1UrBn3EhKqrwU6eCRnpmgEdXqUwG/YA
Date:   Fri, 26 Oct 2018 00:42:20 +0000
Message-ID: <20181026004220.GA8637@hori1.linux.bs1.fc.nec.co.jp>
References: <20181024045053.1467-1-mike.kravetz@oracle.com>
 <20181024045053.1467-2-mike.kravetz@oracle.com>
In-Reply-To: <20181024045053.1467-2-mike.kravetz@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <EC126A47AF18E3438874B0F13E115092@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, Oct 23, 2018 at 09:50:53PM -0700, Mike Kravetz wrote:
> hugetlbfs does not correctly handle page faults racing with truncation.
> In addition, shared pmds can cause additional issues.
> 
> Without pmd sharing, issues can occur as follows:
>   A huegtlbfs file is mmap(MAP_SHARED) with a size of 4 pages.  At
>   mmap time, 4 huge pages are reserved for the file/mapping.  So,
>   the global reserve count is 4.  In addition, since this is a shared
>   mapping an entry for 4 pages is added to the file's reserve map.
>   The first 3 of the 4 pages are faulted into the file.  As a result,
>   the global reserve count is now 1.
> 
>   Task A starts to fault in the last page (routines hugetlb_fault,
>   hugetlb_no_page).  It allocates a huge page (alloc_huge_page).
>   The reserve map indicates there is a reserved page, so this is
>   used and the global reserve count goes to 0.
> 
>   Now, task B truncates the file to size 0.  It starts by setting
>   inode size to 0(hugetlb_vmtruncate).  It then unmaps all mapping
>   of the file (hugetlb_vmdelete_list).  Since task A's page table
>   lock is not held at the time, truncation is not blocked.  Truncation
>   removes the 3 pages from the file (remove_inode_hugepages).  When
>   cleaning up the reserved pages (hugetlb_unreserve_pages), it notices
>   the reserve map was for 4 pages.  However, it has only freed 3 pages.
>   So it assumes there is still (4 - 3) 1 reserved pages.  It then
>   decrements the global reserve count by 1 and it goes negative.
> 
>   Task A then continues the page fault process and adds it's newly
>   acquired page to the page cache.  Note that the index of this page
>   is beyond the size of the truncated file (0).  The page fault process
>   then notices the file has been truncated and exits.  However, the
>   page is left in the cache associated with the file.
> 
>   Now, if the file is immediately deleted the truncate code runs again.
>   It will find and free the one page associated with the file.  When
>   cleaning up reserves, it notices the reserve map is empty.  Yet, one
>   page freed.  So, the global reserve count is decremented by (0 - 1) -1.
>   This returns the global count to 0 as it should be.  But, it is
>   possible for someone else to mmap this file/range before it is deleted.
>   If this happens, a reserve map entry for the allocated page is created
>   and the reserved page is forever leaked.
> 
> With pmd sharing, the situation is even worse.  Consider the following:
>   A task processes a page fault on a shared hugetlbfs file and calls
>   huge_pte_alloc to get a ptep.  Suppose the returned ptep points to a
>   shared pmd.
> 
>   Now, anopther task truncates the hugetlbfs file.  As part of truncation,
>   it unmaps everyone who has the file mapped.  If a task has a shared pmd
>   in this range, huge_pmd_unshhare will be called.  If this is not the last

(sorry, nitpicking ..) a few typos ("anophter" and "unshhare").

>   user sharing the pmd, huge_pmd_unshare will clear pud pointing to the
>   pmd.  For the task in the middle of the page fault, the ptep returned by
>   huge_pte_alloc points to another task's page table or worse.  This leads
>   to bad things such as incorrect page map/reference counts or invalid
>   memory references.
> 
> i_mmap_rwsem is currently used for pmd sharing synchronization.  It is also
> held during unmap and whenever a call to huge_pmd_unshare is possible.  It
> is only acquired in write mode.  Expand and modify the use of i_mmap_rwsem
> as follows:
> - i_mmap_rwsem is held in write mode for the duration of truncate
>   processing.
> - i_mmap_rwsem is held in write mode whenever huge_pmd_share is called.

I guess you mean huge_pmd_unshare here, right?

> - i_mmap_rwsem is held in read mode whenever huge_pmd_share is called.
>   Today that is only via huge_pte_alloc.
> - i_mmap_rwsem is held in read mode after huge_pte_alloc, until the caller
>   is finished with the returned ptep.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 21 ++++++++++----
>  mm/hugetlb.c         | 65 +++++++++++++++++++++++++++++++++-----------
>  mm/rmap.c            | 10 +++++++
>  mm/userfaultfd.c     | 11 ++++++--
>  4 files changed, 84 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 32920a10100e..6ee97622a231 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -426,10 +426,16 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			u32 hash;
>  
>  			index = page->index;
> -			hash = hugetlb_fault_mutex_hash(h, current->mm,
> +			/*
> +			 * No need to take fault mutex for truncation as we
> +			 * are synchronized via i_mmap_rwsem.
> +			 */
> +			if (!truncate_op) {
> +				hash = hugetlb_fault_mutex_hash(h, current->mm,
>  							&pseudo_vma,
>  							mapping, index, 0);
> -			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +				mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +			}
>  
>  			/*
>  			 * If page is mapped, it was faulted in after being
> @@ -470,7 +476,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
>  			}
>  
>  			unlock_page(page);
> -			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +			if (!truncate_op)
> +				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		}
>  		huge_pagevec_release(&pvec);
>  		cond_resched();
> @@ -505,8 +512,8 @@ static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>  	i_mmap_lock_write(mapping);
>  	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
>  		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
> -	i_mmap_unlock_write(mapping);
>  	remove_inode_hugepages(inode, offset, LLONG_MAX);
> +	i_mmap_unlock_write(mapping);

I just have an impression that hugetlbfs_punch_hole() could have the
similar race and extending lock range there could be an improvement,
although I might miss something as always.

>  	return 0;
>  }
>  
> @@ -624,7 +631,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		/* addr is the offset within the file (zero based) */
>  		addr = index * hpage_size;
>  
> -		/* mutex taken here, fault path and hole punch */
> +		/*
> +		 * fault mutex taken here, protects against fault path
> +		 * and hole punch.  inode_lock previously taken protects
> +		 * against truncation.
> +		 */
>  		hash = hugetlb_fault_mutex_hash(h, mm, &pseudo_vma, mapping,
>  						index, addr);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7b5c0ad9a6bd..e9da3eee262f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3252,18 +3252,33 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  
>  	for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
>  		spinlock_t *src_ptl, *dst_ptl;
> +		struct vm_area_struct *dst_vma;
> +		struct address_space *mapping;
> +
>  		src_pte = huge_pte_offset(src, addr, sz);
>  		if (!src_pte)
>  			continue;
> +
> +		/*
> +		 * i_mmap_rwsem must be held to call huge_pte_alloc.
> +		 * Continue to hold until finished with dst_pte, otherwise
> +		 * it could go away if part of a shared pmd.
> +		 */
> +		dst_vma = find_vma(dst, addr);
> +		mapping = dst_vma->vm_file->f_mapping;

If vma->vm_file->f_mapping gives the same mapping, you may omit the find_vma()?

> +		i_mmap_lock_read(mapping);
>  		dst_pte = huge_pte_alloc(dst, addr, sz);
>  		if (!dst_pte) {
> +			i_mmap_unlock_read(mapping);
>  			ret = -ENOMEM;
>  			break;
>  		}
>  
>  		/* If the pagetables are shared don't copy or take references */
> -		if (dst_pte == src_pte)
> +		if (dst_pte == src_pte) {
> +			i_mmap_unlock_read(mapping);
>  			continue;
> +		}
>  
>  		dst_ptl = huge_pte_lock(h, dst, dst_pte);
>  		src_ptl = huge_pte_lockptr(h, src, src_pte);

[...]

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1e79fac3186b..db49e734dda8 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1347,6 +1347,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  	bool ret = true;
>  	unsigned long start = address, end;
>  	enum ttu_flags flags = (enum ttu_flags)arg;
> +	bool pmd_sharing_possible = false;
>  
>  	/* munlock has nothing to gain from examining un-locked vmas */
>  	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
> @@ -1376,8 +1377,15 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		 * accordingly.
>  		 */
>  		adjust_range_if_pmd_sharing_possible(vma, &start, &end);
> +		if ((end - start) > (PAGE_SIZE << compound_order(page)))
> +			pmd_sharing_possible = true;

Maybe the similar check is done in adjust_range_if_pmd_sharing_possible()
as the function name claims, so does it make more sense to get this bool
value via the return value?

Thanks,
Naoya Horiguchi
