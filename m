Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04F220870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548246394;
	bh=2D8uVe4xUmQ/Xh3jfyEeeseeTL7f4cq2Z14puzLzpkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JD+tqYoWdhrlJAGVylNMhZI+Syta3z45hIoZ9P40UQI16ElllSCFRY5E2njFw4ZMl
	 r59oYXwRlOfwjJlg0sBWsfSQlXsz3xqNYe1h3/eXMXNjOISF5FVFD53GPeGYMc+uq7
	 ZRbrLTxXEvG4LzanbtJEN9zZcG+FfF6FLHNn/Ny4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfAWM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAWM0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:26:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5779720861;
        Wed, 23 Jan 2019 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548246388;
        bh=2D8uVe4xUmQ/Xh3jfyEeeseeTL7f4cq2Z14puzLzpkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jc/N/n+oXh/WMJ/6BAeyZeWmh0UuflxPLlA/nl+G9ayNE77iO7aFGoHYXxrIYqnQH
         OygN5CZ96wlUGEGRoG5FzDOK/IgugVa7XNXSp53mNUMrpcwqVqCnpwJWRl2NuXUtPC
         io5rbEqOKF8beBn9eYP+4D9bzLLe0RAJIkWPgZ4c=
Date:   Wed, 23 Jan 2019 13:26:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123122626.GA27968@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123110628.GV4087@dhcp22.suse.cz>
 <20190123115535.GA31237@kroah.com>
 <20190123121350.GX4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123121350.GX4087@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:13:50PM +0100, Michal Hocko wrote:
> On Wed 23-01-19 12:55:35, Greg KH wrote:
> > On Wed, Jan 23, 2019 at 12:06:28PM +0100, Michal Hocko wrote:
> > > On Wed 23-01-19 11:28:14, Greg KH wrote:
> > > > When an error happens, debugfs should return an error pointer value, not
> > > > NULL.  This will prevent the totally theoretical error where a debugfs
> > > > call fails due to lack of memory, returning NULL, and that dentry value
> > > > is then passed to another debugfs call, which would end up succeeding,
> > > > creating a file at the root of the debugfs tree, but would then be
> > > > impossible to remove (because you can not remove the directory NULL).
> > > > 
> > > > So, to make everyone happy, always return errors, this makes the users
> > > > of debugfs much simpler (they do not have to ever check the return
> > > > value), and everyone can rest easy.
> > > 
> > > How come this is safe at all? Say you are creating a directory by
> > > debugfs_create_dir and then feed the return value to debugfs_create_files
> > > as a parent. In case of error you are giving it an invalid pointer and
> > > likely blow up unless I miss something.
> > 
> > debugfs_create_files checks for invalid parents and will just refuse to
> > create the file.  It's always done that.
> 
> I must be missing something because debugfs_create_files does
> 	d_inode(parent)->i_private = data;
> as the very first thing and that means that it dereferences an invalid
> pointer right there.

debugfs_create_file() -> __debugfs_create_file() -> start_creating()
and that function checks if parent is an error, which it aborts on, or
if it is NULL, it sets parent to a valid value:

        /* If the parent is not specified, we create it in the root.
         * We need the root dentry to do this, which is in the super
         * block. A pointer to that is in the struct vfsmount that we
         * have around.
         */
        if (!parent)
                parent = debugfs_mount->mnt_root;

I don't see any line that looks like:
>       d_inode(parent)->i_private = data;
in Linus's tree right now, what kernel version are you referring to?

> > > I do agree that reporting errors is better than a simple catch all NULL
> > > but this should have been done when introduced rather than now when most
> > > callers simply check for NULL as a failure.
> > 
> > I'm fixing up all the "NULL is a failure" callsites in the kernel, see
> > lkml for the first round of those patches.
> 
> You are merely removing them, which doesn't really help for this patch.

It doesn't hurt either, as if you really wanted to handle errors from debugfs
properly, you have to check for IS_ERR() as well, because the filesystem can be
compiled out (and then it returns an error pointer)

> And even if it did, you have marked this patch for stable which would
> obviously depend on all such patches to be applied before.

No, all should still work just fine.

thanks,

greg k-h
