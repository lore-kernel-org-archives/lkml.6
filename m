Date: Wed, 14 Feb 2018 15:14:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Julia Cartwright <julia@ni.com>
Cc: Richard Weinberger <richard@nod.at>, Adrian Ratiu <adrian.ratiu@ni.com>,
	Xiaolei Li <xiaolei.li@mediatek.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.9.y] ubifs: Massage assert in ubifs_xattr_set() wrt.
 init_xattrs
Message-ID: <20180214141417.GA23456@kroah.com>
References: <20180213171308.23909-1-julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213171308.23909-1-julia@ni.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 11:13:08AM -0600, Julia Cartwright wrote:
> From: Xiaolei Li <xiaolei.li@mediatek.com>
> 
> This is a conceptual cherry-pick of commit
> d8db5b1ca9d4c57e49893d0f78e6d5ce81450cc8 upstream.
> 
> The inode is not locked in init_xattrs when creating a new inode.
> 
> Without this patch, there will occurs assert when booting or creating
> a new file, if the kernel config CONFIG_SECURITY_SMACK is enabled.
> 
> Log likes:
> 
> UBIFS assert failed in ubifs_xattr_set at 298 (pid 1156)
> CPU: 1 PID: 1156 Comm: ldconfig Tainted: G S 4.12.0-rc1-207440-g1e70b02 #2
> Hardware name: MediaTek MT2712 evaluation board (DT)
> Call trace:
> [<ffff000008088538>] dump_backtrace+0x0/0x238
> [<ffff000008088834>] show_stack+0x14/0x20
> [<ffff0000083d98d4>] dump_stack+0x9c/0xc0
> [<ffff00000835d524>] ubifs_xattr_set+0x374/0x5e0
> [<ffff00000835d7ec>] init_xattrs+0x5c/0xb8
> [<ffff000008385788>] security_inode_init_security+0x110/0x190
> [<ffff00000835e058>] ubifs_init_security+0x30/0x68
> [<ffff00000833ada0>] ubifs_mkdir+0x100/0x200
> [<ffff00000820669c>] vfs_mkdir+0x11c/0x1b8
> [<ffff00000820b73c>] SyS_mkdirat+0x74/0xd0
> [<ffff000008082f8c>] __sys_trace_return+0x0/0x4
> 
> Signed-off-by: Xiaolei Li <xiaolei.li@mediatek.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Cc: stable@vger.kernel.org
> (julia: massaged to apply to 4.9.y, which doesn't contain fscrypto support)
> Signed-off-by: Julia Cartwright <julia@ni.com>
> ---
> Hey all-
> 
> We reproduced the issue fixed upstream by Xiaolei Li's commit in 4.9.y,
> with the very similar backtrace:
> 
>    UBIFS assert failed in __ubifs_setxattr at 282 (pid 1362)
>    CPU: 1 PID: 1362 Comm: sed Not tainted 4.9.47-rt37 #1
>    Backtrace:
>       (dump_backtrace) from (show_stack+0x20/0x24)
>       (show_stack) from (dump_stack+0x80/0xa0)
>       (dump_stack) from (__ubifs_setxattr+0x84/0x634)
>       (__ubifs_setxattr) from (init_xattrs+0x70/0xac)
>       (init_xattrs) from (security_inode_init_security+0x100/0x144)
>       (security_inode_init_security) from (ubifs_init_security+0x38/0x6c)
>       (ubifs_init_security) from (ubifs_create+0xe8/0x1fc)
>       (ubifs_create) from (path_openat+0x97c/0x1090)
>       (path_openat) from (do_filp_open+0x48/0x94)
>       (do_filp_open) from (do_sys_open+0x134/0x1d8)
>       (do_sys_open) from (SyS_open+0x30/0x34)
>       (SyS_open) from (ret_fast_syscall+0x0/0x3c)
> 
> Please consider applying this to 4.9.y at the very least, it may apply
> further back as well.

Now queued up, thanks.  It didn't apply to 4.4.y, so I didn't put it
there.

thanks,

greg k-h
