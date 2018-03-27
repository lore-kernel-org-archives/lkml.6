Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeC0XPc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 19:15:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeC0XPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 19:15:31 -0400
Date: Tue, 27 Mar 2018 16:15:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        <linux-kernel@vger.kernel.org>, <v9fs-developer@lists.sourceforge.net>,
        Greg Kurz <groug@kaod.org>
Subject: Re: [V9fs-developer] [PATCH] fs/9p: don't set SB_NOATIME by default
Message-Id: <20180327161529.f7d22a36ffc92dc1a3e15d92@linux-foundation.org>
In-Reply-To: <5AB9A377.6080906@huawei.com>
References: <5AB9A377.6080906@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 09:50:47 +0800 jiangyiwen <jiangyiwen@huawei.com> wrote:

> User use some syscall, for example mmap(v9fs_file_mmap), it will not
> update atime even if user's mnt_flags without MNT_NOATIME, because
> v9fs default set SB_NOATIME in v9fs_set_super.
> 
> For supporting access time is updated when user mount with relatime,
> we should not set SB_NOATIME by default.
> 
> ...
>
> --- a/fs/9p/vfs_super.c
> +++ b/fs/9p/vfs_super.c
> @@ -94,7 +94,7 @@ static int v9fs_set_super(struct super_block *s, void *data)
>  	if (v9ses->cache)
>  		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
> 
> -	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC | SB_NOATIME;
> +	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
>  	if (!v9ses->cache)
>  		sb->s_flags |= SB_SYNCHRONOUS;
> 

So strictly speaking, this is a non-backward-compatible change, yes?

Please describe the circumstances under which an existing user might be
harmed by this.  I *think* such harm will occur if the user was already
using 'mount -o relatime', yes?  They previously weren't getting
relatime treatment, but now they will, and things will be a little slower.

If correct, that sounds acceptable.
