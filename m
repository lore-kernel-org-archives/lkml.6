Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756516AbeDZONm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:13:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754847AbeDZONh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:13:37 -0400
Date: Thu, 26 Apr 2018 10:13:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 09/35] ovl: stack file ops
Message-ID: <20180426141337.GA4308@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
 <20180412150826.20988-10-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412150826.20988-10-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 05:08:00PM +0200, Miklos Szeredi wrote:

[..]
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> new file mode 100644
> index 000000000000..a0b606885c41
> --- /dev/null
> +++ b/fs/overlayfs/file.c
> @@ -0,0 +1,76 @@
> +/*
> + * Copyright (C) 2017 Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/cred.h>
> +#include <linux/file.h>
> +#include <linux/xattr.h>
> +#include "overlayfs.h"
> +
> +static struct file *ovl_open_realfile(const struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct inode *upperinode = ovl_inode_upper(inode);
> +	struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
> +	struct file *realfile;
> +	const struct cred *old_cred;
> +
> +	old_cred = ovl_override_creds(inode->i_sb);
> +	realfile = path_open(&file->f_path, file->f_flags | O_NOATIME,
> +			     realinode, current_cred(), false);
> +	revert_creds(old_cred);
> +
> +	pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
> +		 file, file, upperinode ? 'u' : 'l', file->f_flags,
> +		 realfile, IS_ERR(realfile) ? 0 : realfile->f_flags);
> +
> +	return realfile;
> +}
> +
> +static int ovl_open(struct inode *inode, struct file *file)
> +{
> +	struct dentry *dentry = file_dentry(file);

Hi Miklos,

There is one thing I can't wrap my head around, so I better ask.

file_dentry() will call ovl_d_real() and try to find dentry based on
inode installed in f->f_inode. If ovl_d_real() can't find inode dentry
matching the passed in inode, it warns.

Assume, I have a stacked overlay configuration. Let me call top level
overlay layer ovl1 and lower level overlay layer ovl2. Say I open a 
file foo.txt. Now ovl_open() in ovl1 decides that realinode is a lower
inode and installs that inode f->f_inode of realfile. (This should be
ovl2 layer inode, let me call it ovl2_inode). Now ovl_open() of ovl2 layer
will be called and it will call file_dentry() and will look for dentry
corresponding to ovl2_inode. I am wondering what if a copy up of foo.txt
was triggered in ovl1 and by the time we called ovl_d_real(dentry,
ovl2_inode), it will start comparing with inode of ovl1_upper and never
find ovl2_inode.

IOW, I am not able to figure out how do we protect agains copy up races
when ovl_open() calls file_dentry().

Thanks
Vivek
