Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeEaWur (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:50:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37950 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeEaWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:50:45 -0400
X-Google-Smtp-Source: ADUXVKIXjnLu/nqc99HCTGA27uTWo4jwblKaFVQJaM33i1vHA4GRcCZ3kXyJlwNeyNrbqqD7QzWR+w==
Date: Thu, 31 May 2018 15:50:36 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Josef Bacik <jbacik@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Zero out unused vma fields in
 shmem_pseudo_vma_init()
In-Reply-To: <20180531135602.20321-1-kirill.shutemov@linux.intel.com>
Message-ID: <alpine.LSU.2.11.1805311522380.13187@eggly.anvils>
References: <20180531135602.20321-1-kirill.shutemov@linux.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Kirill A. Shutemov wrote:

> shmem/tmpfs uses pseudo vma to allocate page with correct NUMA policy.
> 
> The pseudo vma doesn't have vm_page_prot set. We are going to encode
> encryption KeyID in vm_page_prot. Having garbage there causes problems.
> 
> Zero out all unused fields in the pseudo vma.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I won't go so far as to say NAK, but personally I much prefer that we
document what fields actually get used, by initializing only those,
rather than having such a blanket memset.

And you say "We are going to ...": so this should really be part of
some future patchset, shouldn't it?

My opinion might be in the minority: you remind me of a similar
request from Josef some while ago, Cc'ing him.

(I'm very ashamed, by the way, of shmem's pseudo-vma, I think it's
horrid, and just reflects that shmem was an afterthought when NUMA
mempolicies were designed.  Internally, we replaced alloc_pages_vma()
throughout by alloc_pages_mpol(), which has no need for pseudo-vmas,
and the advantage of dropping mmap_sem across the bulk of NUMA page
migration. I shall be updating that work in coming months, and hope
to upstream, but no promise from me on the timing - your need for
vm_page_prot likely much sooner.)

Hugh

> ---
>  mm/shmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 9d6c7e595415..693fb82b4b42 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1404,10 +1404,9 @@ static void shmem_pseudo_vma_init(struct vm_area_struct *vma,
>  		struct shmem_inode_info *info, pgoff_t index)
>  {
>  	/* Create a pseudo vma that just contains the policy */
> -	vma->vm_start = 0;
> +	memset(vma, 0, sizeof(*vma));
>  	/* Bias interleave by inode number to distribute better across nodes */
>  	vma->vm_pgoff = index + info->vfs_inode.i_ino;
> -	vma->vm_ops = NULL;
>  	vma->vm_policy = mpol_shared_policy_lookup(&info->policy, index);
>  }
>  
> -- 
> 2.17.0
