Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934758AbeB1Q2F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:28:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:56975 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933491AbeB1Q2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:28:03 -0500
Date: Wed, 28 Feb 2018 17:28:00 +0100
From: Jan Kara <jack@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jan Kara <jack@suse.com>, Dan Williams <dan.j.williams@intel.com>,
        Ernesto =?iso-8859-1?Q?A=2E_Fern=E1ndez?=
        <ernesto.mnd.fernandez@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>, Tejun Heo <tj@kernel.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: fix FS_IOMAP dependency
Message-ID: <20180228162800.p2qxrqg7zw6olhfg@quack2.suse.cz>
References: <20180228133659.1933887-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228133659.1933887-1-arnd@arndb.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-02-18 14:36:46, Arnd Bergmann wrote:
> I ran into a randconfig link error on next-20180228 that appears to have
> been caused by an older patch:
> 
> fs/ext2/inode.o: In function `ext2_setattr':
> inode.c:(.text+0x19eb): undefined reference to `iomap_zero_range'
> 
> This adds a compile-time conditional around the code path so the
> compiler can optimize out the reference in configurations that don't
> need it anyway.
> 
> Fixes: 00697eed386d ("ext2: use iomap_zero_range() for zeroing truncated page in DAX path")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch but Dan's patches [1] deal with a breakage like this
in a more complete way so I'd prefer to go with his full series...

								Honza

[1] https://lkml.org/lkml/2018/2/26/1323

> ---
>  fs/ext2/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 5d5e9f7b98d6..6e6db0ab3bd6 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1296,7 +1296,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  
>  	inode_dio_wait(inode);
>  
> -	if (IS_DAX(inode)) {
> +	if (IS_ENABLED(CONFIG_FS_DAX) && IS_DAX(inode)) {
>  		error = iomap_zero_range(inode, newsize,
>  					 PAGE_ALIGN(newsize) - newsize, NULL,
>  					 &ext2_iomap_ops);
> -- 
> 2.9.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
