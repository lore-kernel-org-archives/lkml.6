Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeDIPSF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:18:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbeDIPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:18:04 -0400
Date: Mon, 9 Apr 2018 17:18:01 +0200
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: filemap: provide dummy filemap_page_mkwrite() for
 NOMMU
Message-ID: <20180409151801.zqcevugkrixw3di3@quack2.suse.cz>
References: <20180409105555.2439976-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409105555.2439976-1-arnd@arndb.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-04-18 12:55:42, Arnd Bergmann wrote:
> Building orangefs on MMU-less machines now results in a link error because
> of the newly introduced use of the filemap_page_mkwrite() function:
> 
> ERROR: "filemap_page_mkwrite" [fs/orangefs/orangefs.ko] undefined!
> 
> This adds a dummy version for it, similar to the existing
> generic_file_mmap and generic_file_readonly_mmap stubs in the same file,
> to avoid the link error without adding #ifdefs in each file system that
> uses these.
> 
> Cc: Martin Brandenburg <martin@omnibond.com>
> Cc: Mike Marshall <hubcap@omnibond.com>
> Fixes: a5135eeab2e5 ("orangefs: implement vm_ops->fault")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

OK, makes sense. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ab77e19ab09c..9276bdb2343c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2719,7 +2719,6 @@ int filemap_page_mkwrite(struct vm_fault *vmf)
>  	sb_end_pagefault(inode->i_sb);
>  	return ret;
>  }
> -EXPORT_SYMBOL(filemap_page_mkwrite);
>  
>  const struct vm_operations_struct generic_file_vm_ops = {
>  	.fault		= filemap_fault,
> @@ -2750,6 +2749,10 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
>  	return generic_file_mmap(file, vma);
>  }
>  #else
> +int filemap_page_mkwrite(struct vm_fault *vmf)
> +{
> +	return -ENOSYS;
> +}
>  int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
>  {
>  	return -ENOSYS;
> @@ -2760,6 +2763,7 @@ int generic_file_readonly_mmap(struct file * file, struct vm_area_struct * vma)
>  }
>  #endif /* CONFIG_MMU */
>  
> +EXPORT_SYMBOL(filemap_page_mkwrite);
>  EXPORT_SYMBOL(generic_file_mmap);
>  EXPORT_SYMBOL(generic_file_readonly_mmap);
>  
> -- 
> 2.9.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
