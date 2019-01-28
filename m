Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5342C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8B22175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfA1XmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:42:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbfA1XmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:42:08 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1F9EB29DA;
        Mon, 28 Jan 2019 23:42:07 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:42:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH v2] fs: Allow opening only regular files during
 execve().
Message-Id: <20190128154205.214ae010da6c2f02d379bbc8@linux-foundation.org>
In-Reply-To: <201901220050.x0M0ommA008918@www262.sakura.ne.jp>
References: <d1e2488f-a969-30d4-5023-6fa85a4e3833@I-love.SAKURA.ne.jp>
        <20190121211800.GC2217@ZenIV.linux.org.uk>
        <201901220050.x0M0ommA008918@www262.sakura.ne.jp>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 09:50:48 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> Al Viro wrote:
> > On Mon, Jan 21, 2019 at 07:14:39PM +0900, Tetsuo Handa wrote:
> > > On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> > > > I'm not sure what the fix will be.  Maybe the proc handlers should take a
> > > > different lock instead of cred_guard_mutex.  Or perhaps execve should check that
> > > > the file is a regular file before it attempts to open it.
> > > 
> > > We can easily distinguish open() from execve() and open() from others. ;-)
> > 
> > > +	/* The file or a script interpreter has to be a regular file. */
> > > +	if (unlikely(current->in_execve && !S_ISREG(inode->i_mode))) {
> > > +		error = -EACCES;
> > > +		goto cleanup_file;
> > > +	}
> > 
> > We are *NOT* going to use current->in_execve to propagate that information.
> 
> You mean check FMODE_EXEC instead of current->in_execve ?
> 
> >From f80b32e1c3fbd65672387ee441a32ab58db456f8 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 22 Jan 2019 09:34:35 +0900
> Subject: [PATCH v2] fs: Allow opening only regular files during execve().
> 
> syzbot is hitting lockdep warning [1] due to trying to open a fifo during
> an execve() operation. But we don't need to open non regular files during
> an execve() operation, for all files which we will need are the executable
> file itself and the interpreter programs like /bin/sh and ld-linux.so.2 .
> 
> Since the manpage for execve(2) says that execve() returns EACCES when
> the file or a script interpreter is not a regular file, and the manpage
> for uselib(2) says that uselib() can return EACCES, and we use FMODE_EXEC
> when opening for execve()/uselib(), let's bail out if a non regular file
> is requested with FMODE_EXEC set.
> 
> [1] https://syzkaller.appspot.com/bug?id=b5095bfec44ec84213bac54742a82483aad578ce
> 
> ...
>
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -733,6 +733,12 @@ static int do_dentry_open(struct file *f,
>  		return 0;
>  	}
>  
> +	/* Any file opened for execve()/uselib() has to be a regular file. */
> +	if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) {
> +		error = -EACCES;
> +		goto cleanup_file;
> +	}
> +
>  	if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
>  		error = get_write_access(inode);
>  		if (unlikely(error))

This change sounds legitimate for various other reasons, but it's a
concern that this locking error occurred in the first place.  There's a
problem somewhere (probably the pipe code) which may bite us in other
situations, even with this workaround in place.

