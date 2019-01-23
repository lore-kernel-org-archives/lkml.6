Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F59C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4714121019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548247234;
	bh=Xa/xSUgpdfNdKaKXklXJeYeWDgsOoNzWarFmPoqPj6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OrCoofA4wqZ+/lWZ75r2wfbkbvOUvoQy2gwfAqD+jsqroX7Q26P9flCTqnEvsUp7I
	 mL6CyOtREg7EvmMqXFJL9S+HsdG+Mz+StzUbnBxDL0ivmFDCxxBGaSoIFWRJ9wpG8k
	 8Mwxg+Y/zNgIZcBrOiYQQUbXtdO09egv+uUfjaNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfAWMkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:40:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:41464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfAWMkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:40:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9E7BAD02;
        Wed, 23 Jan 2019 12:40:29 +0000 (UTC)
Date:   Wed, 23 Jan 2019 13:40:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123124024.GY4087@dhcp22.suse.cz>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123110628.GV4087@dhcp22.suse.cz>
 <20190123115535.GA31237@kroah.com>
 <20190123121350.GX4087@dhcp22.suse.cz>
 <20190123122626.GA27968@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123122626.GA27968@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 13:26:26, Greg KH wrote:
> On Wed, Jan 23, 2019 at 01:13:50PM +0100, Michal Hocko wrote:
> > On Wed 23-01-19 12:55:35, Greg KH wrote:
> > > On Wed, Jan 23, 2019 at 12:06:28PM +0100, Michal Hocko wrote:
> > > > On Wed 23-01-19 11:28:14, Greg KH wrote:
> > > > > When an error happens, debugfs should return an error pointer value, not
> > > > > NULL.  This will prevent the totally theoretical error where a debugfs
> > > > > call fails due to lack of memory, returning NULL, and that dentry value
> > > > > is then passed to another debugfs call, which would end up succeeding,
> > > > > creating a file at the root of the debugfs tree, but would then be
> > > > > impossible to remove (because you can not remove the directory NULL).
> > > > > 
> > > > > So, to make everyone happy, always return errors, this makes the users
> > > > > of debugfs much simpler (they do not have to ever check the return
> > > > > value), and everyone can rest easy.
> > > > 
> > > > How come this is safe at all? Say you are creating a directory by
> > > > debugfs_create_dir and then feed the return value to debugfs_create_files
> > > > as a parent. In case of error you are giving it an invalid pointer and
> > > > likely blow up unless I miss something.
> > > 
> > > debugfs_create_files checks for invalid parents and will just refuse to
> > > create the file.  It's always done that.
> > 
> > I must be missing something because debugfs_create_files does
> > 	d_inode(parent)->i_private = data;
> > as the very first thing and that means that it dereferences an invalid
> > pointer right there.
> 
> debugfs_create_file() -> __debugfs_create_file() -> start_creating()
> and that function checks if parent is an error, which it aborts on, or
> if it is NULL, it sets parent to a valid value:
> 
>         /* If the parent is not specified, we create it in the root.
>          * We need the root dentry to do this, which is in the super
>          * block. A pointer to that is in the struct vfsmount that we
>          * have around.
>          */
>         if (!parent)
>                 parent = debugfs_mount->mnt_root;
> 
> I don't see any line that looks like:
> >       d_inode(parent)->i_private = data;
> in Linus's tree right now, what kernel version are you referring to?

Ohh, my bad. I have looked at debugfs_create_files which is a mq helper
around debugfs_create_file. But that is a good example why this patch is
dangerous anyway. blk_mq_debugfs_register simply checks for NULL and
debugfs_create_files doesn't expect ERR_PTR here. So you would have to
check each and every user to make sure you can do that.

> > > > I do agree that reporting errors is better than a simple catch all NULL
> > > > but this should have been done when introduced rather than now when most
> > > > callers simply check for NULL as a failure.
> > > 
> > > I'm fixing up all the "NULL is a failure" callsites in the kernel, see
> > > lkml for the first round of those patches.
> > 
> > You are merely removing them, which doesn't really help for this patch.
> 
> It doesn't hurt either, as if you really wanted to handle errors from debugfs
> properly, you have to check for IS_ERR() as well, because the filesystem can be
> compiled out (and then it returns an error pointer)

I would assume that this would be achieved by a direct config
dependency. E.g. BLK_DEBUG_FS. So the code doesn't even get compiled and
wouldn't ever encounter the ERR_PTR.

Yeah this whole debugfs API is broken and it would take a lot of time to
unclutter it but it definitely is not that simple as what this patch
does.
-- 
Michal Hocko
SUSE Labs
