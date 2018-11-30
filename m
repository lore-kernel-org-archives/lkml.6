Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2AEC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733302146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSoj/fI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733302146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeK3Vus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbeK3Vus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:50:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47FAF206B7;
        Fri, 30 Nov 2018 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543574516;
        bh=rBV7QyEig0CVPQfYlMWyaHmDC0pTWAwaI4pafH4PoJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSoj/fI1A8bSAM+1zQpb/xRwmroNhITFihkgldTaxn+RK7remtE36n+VuPtwcaXft
         DhlsI4+DLMrFMEuaW3mYKImZ52g1zsA7WJg1BX4PS3QWOH3u+9xelk91MecuV1obpe
         IKav8SJ7a2c07O77C36iVabQTChZalaQCm5+R6zQ=
Date:   Fri, 30 Nov 2018 11:41:54 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jan Glauber <Jan.Glauber@cavium.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181130104154.GA11991@kroah.com>
References: <20181109143744.GA12128@hc>
 <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc>
 <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com>
 <20181121131900.GA18931@hc>
 <20181123180525.GA21017@arm.com>
 <20181128200806.GC32668@arm.com>
 <20181129184950.GA7290@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129184950.GA7290@hc>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Eric as he touched this code last :)

On Thu, Nov 29, 2018 at 07:25:48PM +0000, Jan Glauber wrote:
> On Wed, Nov 28, 2018 at 08:08:06PM +0000, Will Deacon wrote:
> > I spent some more time looking at this today...
> > 
> > On Fri, Nov 23, 2018 at 06:05:25PM +0000, Will Deacon wrote:
> > > Doing some more debugging, it looks like the usual failure case is where
> > > one CPU clears the inode field in the dentry via:
> > >
> > >       devpts_pty_kill()
> > >               -> d_delete()   // dentry->d_lockref.count == 1
> > >                       -> dentry_unlink_inode()
> > >
> > > whilst another CPU gets a pointer to the dentry via:
> > >
> > >       sys_getdents64()
> > >               -> iterate_dir()
> > >                       -> dcache_readdir()
> > >                               -> next_positive()
> > >
> > > and explodes on the subsequent inode dereference when trying to pass the
> > > inode number to dir_emit():
> > >
> > >       if (!dir_emit(..., d_inode(next)->i_ino, ...))
> > >
> > > Indeed, the hack below triggers a warning, indicating that the inode
> > > is being cleared concurrently.
> > >
> > > I can't work out whether the getdents64() path should hold a refcount
> > > to stop d_delete() in its tracks, or whether devpts_pty_kill() shouldn't
> > > be calling d_delete() like this at all.
> > 
> > So the issue is that opening /dev/pts/ptmx creates a new pty in /dev/pts,
> > which disappears when you close /dev/pts/ptmx. Consequently, when we tear
> > down the dentry for the magic new file, we have to take the i_node rwsem of
> > the *parent* so that concurrent path walkers don't trip over it whilst its
> > being freed. I wrote a simple concurrent program to getdents(/dev/pts/) in
> > one thread, whilst another opens and closes /dev/pts/ptmx: it crashes the
> > kernel in seconds.
> 
> I also made a testcase and verified that your fix is fine. I also tried
> replacing open-close on /dev/ptmx with mkdir-rmdir but that does not
> trigger the error.
> 
> > Patch below, but I'd still like somebody else to look at this, please.
> 
> I wonder why no inode_lock on parent is needed for devpts_pty_new(), but
> I'm obviously not a VFS expert... So your patch looks good to me and
> clearly solves the issue.
> 
> thanks,
> Jan
> 
> > Will
> > 
> > --->8
> > 
> > diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> > index c53814539070..50ddb95ff84c 100644
> > --- a/fs/devpts/inode.c
> > +++ b/fs/devpts/inode.c
> > @@ -619,11 +619,17 @@ void *devpts_get_priv(struct dentry *dentry)
> >   */
> >  void devpts_pty_kill(struct dentry *dentry)
> >  {
> > -       WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
> > +       struct super_block *sb = dentry->d_sb;
> > +       struct dentry *parent = sb->s_root;
> > 
> > +       WARN_ON_ONCE(sb->s_magic != DEVPTS_SUPER_MAGIC);

Side note, I wonder if this is even needed anymore...

> > +
> > +       inode_lock(parent->d_inode);
> >         dentry->d_fsdata = NULL;
> >         drop_nlink(dentry->d_inode);
> >         d_delete(dentry);
> > +       inode_unlock(parent->d_inode);
> > +
> >         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
> >  }

This feels right but getting some feedback from others would be good.

thanks,

greg k-h
