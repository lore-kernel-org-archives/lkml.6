Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29038C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F7208CE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbeLNWuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:50:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42064 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbeLNWuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:50:12 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gXwHU-0005Lk-Sh; Fri, 14 Dec 2018 22:50:04 +0000
Date:   Fri, 14 Dec 2018 22:50:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v2] binder: fix use-after-free due to ksys_close() during
 fdget()
Message-ID: <20181214225004.GP2217@ZenIV.linux.org.uk>
References: <20181214203815.217014-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214203815.217014-1-tkjos@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:38:15PM -0800, Todd Kjos wrote:
> 44d8047f1d8 ("binder: use standard functions to allocate fds")
> exposed a pre-existing issue in the binder driver.
> 
> fdget() is used in ksys_ioctl() as a performance optimization.
> One of the rules associated with fdget() is that ksys_close() must
> not be called between the fdget() and the fdput(). There is a case
> where this requirement is not met in the binder driver which results
> in the reference count dropping to 0 when the device is still in
> use. This can result in use-after-free or other issues.
> 
> If userpace has passed a file-descriptor for the binder driver using
> a BINDER_TYPE_FDA object, then kys_close() is called on it when
> handling a binder_ioctl(BC_FREE_BUFFER) command. This violates
> the assumptions for using fdget().
> 
> The problem is fixed by deferring the fd close using task_work_add()
> so ksys_close() is called after returning from binder_ioctl().
> 
> Fixes: 44d8047f1d87a ("binder: use standard functions to allocate fds")
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Todd Kjos <tkjos@google.com>

Umm...  IMO you are making it more brittle than needed.  Descriptors
(as in, integers serving as indices in file descriptor tables) are
sensitive to a lot of things and generally you don't want to pass
them around, at least not without a lot more context than you do.

References to struct file are much more robust.  And frankly, ksys_close()
is best not touched - what you want is basically a version of __close_fd()
that would grab a reference to struct file before filp_close() and
passed that reference to you.  Then your delayed ksys_close() would turn
into (equally delayed) fput().

Something like
int rip_fd(int fd, struct file **res)
{
	struct files_struct *files = current->files;
        struct file *file;
        struct fdtable *fdt;

        spin_lock(&files->file_lock);
        fdt = files_fdtable(files);
        if (fd >= fdt->max_fds)
                goto out_unlock;
        file = fdt->fd[fd];
        if (!file)
                goto out_unlock;
        rcu_assign_pointer(fdt->fd[fd], NULL);
        __put_unused_fd(files, fd);
        spin_unlock(&files->file_lock);
	get_file(file);
	*res = file;
        return filp_close(file, files);

out_unlock:
        spin_unlock(&files->file_lock);
	*res = NULL;
	return -ENOENT;
}

used as
	error = rip_fd(fd, &file);
	/* we are committed to arranging fput(file) now, error or not */

Frankly, the main objection to exporting that would be to avoid encouraging
the "we'll just pass the number around" kind of braindamage.  In case of
binder you are locked into that braindamage by an atrocious userland API
design and warnings along the lines of "use that and you *will* have
to explain yourself; yes, we will be watching" might suffice to prevent
additional uses...
