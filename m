Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755307AbeDWNgV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:36:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755152AbeDWNgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:36:18 -0400
Date: Mon, 23 Apr 2018 09:36:17 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/35] ovl: readd fsync
Message-ID: <20180423133617.GB2794@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
 <20180412150826.20988-14-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412150826.20988-14-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 05:08:04PM +0200, Miklos Szeredi wrote:
> Implement stacked fsync().
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/overlayfs/file.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index b98204c1c19c..4417527667ff 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -222,10 +222,30 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>  	return ret;
>  }
>  
> +static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
> +{
> +	struct fd real;
> +	const struct cred *old_cred;
> +	int ret;
> +
> +	ret = ovl_real_file(file, &real);
> +	if (ret)
> +		return ret;
> +
> +	old_cred = ovl_override_creds(file_inode(file)->i_sb);
> +	ret = vfs_fsync_range(real.file, start, end, datasync);
> +	revert_creds(old_cred);

Can we avoid calling fsync() on real file if it is not upper. Is it worth
optimizing.

Vivek

> +
> +	fdput(real);
> +
> +	return ret;
> +}
> +
>  const struct file_operations ovl_file_operations = {
>  	.open		= ovl_open,
>  	.release	= ovl_release,
>  	.llseek		= ovl_llseek,
>  	.read_iter	= ovl_read_iter,
>  	.write_iter	= ovl_write_iter,
> +	.fsync		= ovl_fsync,
>  };
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-unionfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
