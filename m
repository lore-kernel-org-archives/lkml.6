Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeEaWw7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:52:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeEaWw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:52:58 -0400
Date: Thu, 31 May 2018 15:52:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: Zero out unused vma fields in
 shmem_pseudo_vma_init()
Message-Id: <20180531155256.a5f557c9e620a6d7e85e4ca1@linux-foundation.org>
In-Reply-To: <20180531135602.20321-1-kirill.shutemov@linux.intel.com>
References: <20180531135602.20321-1-kirill.shutemov@linux.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 16:56:02 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:

> shmem/tmpfs uses pseudo vma to allocate page with correct NUMA policy.
> 
> The pseudo vma doesn't have vm_page_prot set. We are going to encode
> encryption KeyID in vm_page_prot. Having garbage there causes problems.
> 
> Zero out all unused fields in the pseudo vma.
> 

So there are no known problems in the current mainline kernel?

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
