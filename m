Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeEaV0D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 17:26:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51134 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeEaV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 17:26:01 -0400
Date: Thu, 31 May 2018 22:25:59 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/32] VFS: Implement fsopen() to prepare for a mount
 [ver #8]
Message-ID: <20180531212559.GK30522@ZenIV.linux.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720684753.9073.7743237635311367354.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152720684753.9073.7743237635311367354.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 01:07:27AM +0100, David Howells wrote:
> +	inode = alloc_anon_inode(fscontext_fs_mnt->mnt_sb);
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> +	inode->i_fop = &fscontext_fs_fops;

That's almost certainly wrong - you need it only if you want it possible to
reopen via /proc/*/fd/*

> +	fc->phase = FS_CONTEXT_CREATE_PARAMS;
> +
> +	ret = -ENOMEM;
> +	path.dentry = d_alloc_pseudo(fscontext_fs_mnt->mnt_sb, &empty_name);
> +	if (!path.dentry)
> +		goto err_inode;
> +	path.mnt = mntget(fscontext_fs_mnt);
> +
> +	d_instantiate(path.dentry, inode);
> +
> +	f = alloc_file(&path, FMODE_READ | FMODE_WRITE, &fscontext_fs_fops);

Re your question on IRC - we might want that fs in longer run, but for now
just go with anon_inode_getfile() here.  Easier that way and we can always
switch later.
