Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TjdGJGulHFvDZgAAmS7hNA
	; Sun, 10 Jun 2018 04:13:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 68D78607BB; Sun, 10 Jun 2018 04:13:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 549736074D;
	Sun, 10 Jun 2018 04:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 549736074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753683AbeFJENZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 00:13:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53114 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeFJENX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 00:13:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRriu-0001rF-Uv; Sun, 10 Jun 2018 04:13:06 +0000
Date: Sun, 10 Jun 2018 05:13:00 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/39] ovl: stack file ops
Message-ID: <20180610041243.GJ30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-15-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529144339.16538-15-mszeredi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:43:14PM +0200, Miklos Szeredi wrote:
> Implement file operations on a regular overlay file.  The underlying file
> is opened separately and cached in ->private_data.
> 
> It might be worth making an exception for such files when accounting in
> nr_file to confirm to userspace expectations.  We are only adding a small
> overhead (248bytes for the struct file) since the real inode and dentry are
> pinned by overlayfs anyway.
> 
> This patch doesn't have any effect, since the vfs will use d_real() to find
> the real underlying file to open.  The patch at the end of the series will
> actually enable this functionality.

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

IDGI.  OK, you open a file in the layer you want; good, but why the hell do you
*not* use the dentry/vfsmount from the same layer?

IOW, why does your path_open() get an explicit inode argument at all?  With the
rest of the work done in that series it looks like you should be able to use
vfs_open() instead...  Sure, for ovlfs file you want ->f_path on overlayfs and
not in a layer, but why do the same for those?

And why bother with override_creds at all?  What's wrong with simply passing
->creator_cred to path_open()/vfs_open()/whatnot?
