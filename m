Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeEGNRT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:17:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752051AbeEGNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:17:17 -0400
Date: Mon, 7 May 2018 09:17:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/35] ovl: deal with overlay files in ovl_d_real()
Message-ID: <20180507131716.GA18454@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
 <20180507083807.28792-11-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507083807.28792-11-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 10:37:42AM +0200, Miklos Szeredi wrote:
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index e8551c97de51..ad6a5baf226b 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -97,6 +97,10 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
>  	struct dentry *real;
>  	int err;
>  
> +	/* It's an overlay file */
> +	if (inode && d_inode(dentry) == inode)
> +		return dentry;
> +

Hi Miklos,

inode == d_inode(dentry) check is being done again in following code. We
probably can get rid of it now.

        if (!d_is_reg(dentry)) {
                if (!inode || inode == d_inode(dentry))
                        return dentry;
                goto bug;
        }

Vivek

>  	if (flags & D_REAL_UPPER)
>  		return ovl_dentry_upper(dentry);
>  
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-unionfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
