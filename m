Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1884C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD63C2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548251650;
	bh=NxuxHNoVaS6ozCtTt546XsSK6uwDiEdBsu2S0q3ulF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x02fNrW0wxb3ThA8HYyXF8qTMk+lIbN3sncyFxk0UYz3+6zKHnlhNZ2Zk/KS3p+WV
	 sJ/YxEKn9axSJvcW0vYzChiLxSt5xO6ZnzYZ9nA3nmE2wAszvi5fsB8mb576xz4V8n
	 L53bJO3inhmb/dCvfPLeSlhDo643pqcVpeA1jCwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfAWNyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 08:54:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:53410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfAWNyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 08:54:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87BFAAF6A;
        Wed, 23 Jan 2019 13:54:06 +0000 (UTC)
Date:   Wed, 23 Jan 2019 14:54:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123135405.GA4087@dhcp22.suse.cz>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123110628.GV4087@dhcp22.suse.cz>
 <20190123115535.GA31237@kroah.com>
 <20190123121350.GX4087@dhcp22.suse.cz>
 <20190123122626.GA27968@kroah.com>
 <20190123124024.GY4087@dhcp22.suse.cz>
 <20190123130057.GB21318@kroah.com>
 <20190123130917.GZ4087@dhcp22.suse.cz>
 <20190123134021.GB24700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123134021.GB24700@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 14:40:21, Greg KH wrote:
> On Wed, Jan 23, 2019 at 02:09:17PM +0100, Michal Hocko wrote:
> > On Wed 23-01-19 14:00:57, Greg KH wrote:
> > > On Wed, Jan 23, 2019 at 01:40:24PM +0100, Michal Hocko wrote:
> > > > On Wed 23-01-19 13:26:26, Greg KH wrote:
> > > > > On Wed, Jan 23, 2019 at 01:13:50PM +0100, Michal Hocko wrote:
> > > > > > On Wed 23-01-19 12:55:35, Greg KH wrote:
> > > > > > > On Wed, Jan 23, 2019 at 12:06:28PM +0100, Michal Hocko wrote:
> > > > > > > > On Wed 23-01-19 11:28:14, Greg KH wrote:
> > > > > > > > > When an error happens, debugfs should return an error pointer value, not
> > > > > > > > > NULL.  This will prevent the totally theoretical error where a debugfs
> > > > > > > > > call fails due to lack of memory, returning NULL, and that dentry value
> > > > > > > > > is then passed to another debugfs call, which would end up succeeding,
> > > > > > > > > creating a file at the root of the debugfs tree, but would then be
> > > > > > > > > impossible to remove (because you can not remove the directory NULL).
> > > > > > > > > 
> > > > > > > > > So, to make everyone happy, always return errors, this makes the users
> > > > > > > > > of debugfs much simpler (they do not have to ever check the return
> > > > > > > > > value), and everyone can rest easy.
> > > > > > > > 
> > > > > > > > How come this is safe at all? Say you are creating a directory by
> > > > > > > > debugfs_create_dir and then feed the return value to debugfs_create_files
> > > > > > > > as a parent. In case of error you are giving it an invalid pointer and
> > > > > > > > likely blow up unless I miss something.
> > > > > > > 
> > > > > > > debugfs_create_files checks for invalid parents and will just refuse to
> > > > > > > create the file.  It's always done that.
> > > > > > 
> > > > > > I must be missing something because debugfs_create_files does
> > > > > > 	d_inode(parent)->i_private = data;
> > > > > > as the very first thing and that means that it dereferences an invalid
> > > > > > pointer right there.
> > > > > 
> > > > > debugfs_create_file() -> __debugfs_create_file() -> start_creating()
> > > > > and that function checks if parent is an error, which it aborts on, or
> > > > > if it is NULL, it sets parent to a valid value:
> > > > > 
> > > > >         /* If the parent is not specified, we create it in the root.
> > > > >          * We need the root dentry to do this, which is in the super
> > > > >          * block. A pointer to that is in the struct vfsmount that we
> > > > >          * have around.
> > > > >          */
> > > > >         if (!parent)
> > > > >                 parent = debugfs_mount->mnt_root;
> > > > > 
> > > > > I don't see any line that looks like:
> > > > > >       d_inode(parent)->i_private = data;
> > > > > in Linus's tree right now, what kernel version are you referring to?
> > > > 
> > > > Ohh, my bad. I have looked at debugfs_create_files which is a mq helper
> > > > around debugfs_create_file. But that is a good example why this patch is
> > > > dangerous anyway. blk_mq_debugfs_register simply checks for NULL and
> > > > debugfs_create_files doesn't expect ERR_PTR here. So you would have to
> > > > check each and every user to make sure you can do that.
> > > 
> > > Ah, I already have that patch in my "to add a proper changelog" queue,
> > > it's below and fixes that problem.
> > 
> > OK, fair enough. I am just wondering how many more gems like that are
> > lurking there. Do not get me wrong but a broken error handling is rarely
> > fixed by removing it.
> 
> I think you all are the "lucky" one here :)

That was actually the first random place I've checked.

> I did audit the whole kernel tree already, with the exception of the gpu
> drivers, as they are even more insane than block drivers...
> 
> > And Cc: stable is completely inappropriate IMNSHO. This is just adding a
> > risk without a large benefit.
> 
> What risk?  Again, the _ONLY_ way that NULL is returned here is if you
> are out of memory when you try to create that debugfs file/directory.
> Given that we usually don't even fail small kmallocs, I doubt this can
> even ever happen.

This doesn't matter at all. Failures are real even when rare. Do not
forget fault injection testing which is real on older kernels as well.

Besides that I haven't heard _any_ argument why this should be
backported to stable trees in the first place.
 
> > Moreover all these changes should be posted in a single patch thread so
> > that everybody can see the final outcome.
> 
> No one wants to see a 200+ patch thread and be cc:ed on them all.

I have seen some of them and they are really dubious, some even outright
wrong so this particular one is far far away from being ready to get
mereged even to the linus tree. Not to mention older trees which would
require the same kind of tree wide recheck again.
-- 
Michal Hocko
SUSE Labs
