Date: Fri, 27 Apr 2018 10:27:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inode: debugfs_create_dir uses mode permission from
 parent
Message-ID: <20180427082737.GA25242@kroah.com>
References: <20180427080712.2380-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427080712.2380-1-tmricht@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:07:12AM +0200, Thomas Richter wrote:
> Currently function debugfs_create_dir() creates a new
> directory in the debugfs (usually mounted /sys/kernel/debug)
> with permission rwxr-xr-x. This is hard coded.
> 
> Change this to use the parent directory permission.
> 
> Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/debugfs/inode.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 13b01351dd1c..80618330d86a 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -512,7 +512,10 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> -	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	if(!parent)
> +		parent = debugfs_mount->mnt_root;
> +	inode->i_mode = S_IFDIR | (d_inode(parent)->i_mode
> +				   & (S_IRWXU | S_IRWXG));
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
>  

This looks ok, but is it going to change the permissions of existing
stuff in ways that might breaks things, right?

Have you done a before/after comparison?

thanks,

greg k-h
