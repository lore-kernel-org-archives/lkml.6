Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeDXSK7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:10:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeDXSK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:10:58 -0400
Date: Tue, 24 Apr 2018 14:10:57 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/35] ovl: copy up file size as well
Message-ID: <20180424181057.GA2700@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
 <20180412150826.20988-8-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412150826.20988-8-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 05:07:58PM +0200, Miklos Szeredi wrote:
> Copy i_size of the underlying inode to the overlay inode in ovl_copyattr().
> 
> This is in preparation for stacking I/O operations on overlay files.
> 
> This patch shouldn't have any observable effect.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/overlayfs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 265cb288417a..10f5f3bf9d96 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/uuid.h>
> +#include <linux/fs.h>
>  #include "ovl_entry.h"
>  
>  enum ovl_path_type {
> @@ -355,6 +356,7 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
>  	to->i_atime = from->i_atime;
>  	to->i_mtime = from->i_mtime;
>  	to->i_ctime = from->i_ctime;
> +	i_size_write(to, i_size_read(from));
>  }

With this change, is following comment in ovl_getattr() stale now.

	 /*
         * We don't initialize inode->size, which just means that
         * inode_newsize_ok() will always check against MAX_LFS_FILESIZE and not
         * check for a swapfile (which this won't be anyway).
	 */

Thanks
Vivek
