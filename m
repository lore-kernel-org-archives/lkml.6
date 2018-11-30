Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C66C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0069420867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0069420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeLAC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:26:37 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:33355 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeLAC0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:26:36 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gSkXG-0002vq-QN; Fri, 30 Nov 2018 08:16:55 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gSkXF-0007dP-Hk; Fri, 30 Nov 2018 08:16:54 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Jan Glauber <Jan.Glauber@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby\@suse.com" <jslaby@suse.com>
References: <20181109143744.GA12128@hc> <20181109155856.GC2091@brain-police>
        <20181110111656.GA16667@hc> <20181120182854.GC28838@arm.com>
        <20181120190317.GA29161@arm.com> <20181121131900.GA18931@hc>
        <20181123180525.GA21017@arm.com> <20181128200806.GC32668@arm.com>
        <20181129184950.GA7290@hc> <20181130104154.GA11991@kroah.com>
Date:   Fri, 30 Nov 2018 09:16:49 -0600
In-Reply-To: <20181130104154.GA11991@kroah.com> (gregkh@linuxfoundation.org's
        message of "Fri, 30 Nov 2018 11:41:54 +0100")
Message-ID: <875zwe389q.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gSkXF-0007dP-Hk;;;mid=<875zwe389q.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19WqtPmMJpl665zmz/+ZBVC+i+kw2vNmIg=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: dcache_readdir NULL inode oops
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org> writes:

> Adding Eric as he touched this code last :)
>
> On Thu, Nov 29, 2018 at 07:25:48PM +0000, Jan Glauber wrote:
>> On Wed, Nov 28, 2018 at 08:08:06PM +0000, Will Deacon wrote:
>> > I spent some more time looking at this today...
>> > 
>> > On Fri, Nov 23, 2018 at 06:05:25PM +0000, Will Deacon wrote:
>> > > Doing some more debugging, it looks like the usual failure case is where
>> > > one CPU clears the inode field in the dentry via:
>> > >
>> > >       devpts_pty_kill()
>> > >               -> d_delete()   // dentry->d_lockref.count == 1
>> > >                       -> dentry_unlink_inode()
>> > >
>> > > whilst another CPU gets a pointer to the dentry via:
>> > >
>> > >       sys_getdents64()
>> > >               -> iterate_dir()
>> > >                       -> dcache_readdir()
>> > >                               -> next_positive()
>> > >
>> > > and explodes on the subsequent inode dereference when trying to pass the
>> > > inode number to dir_emit():
>> > >
>> > >       if (!dir_emit(..., d_inode(next)->i_ino, ...))
>> > >
>> > > Indeed, the hack below triggers a warning, indicating that the inode
>> > > is being cleared concurrently.
>> > >
>> > > I can't work out whether the getdents64() path should hold a refcount
>> > > to stop d_delete() in its tracks, or whether devpts_pty_kill() shouldn't
>> > > be calling d_delete() like this at all.
>> > 
>> > So the issue is that opening /dev/pts/ptmx creates a new pty in /dev/pts,
>> > which disappears when you close /dev/pts/ptmx. Consequently, when we tear
>> > down the dentry for the magic new file, we have to take the i_node rwsem of
>> > the *parent* so that concurrent path walkers don't trip over it whilst its
>> > being freed. I wrote a simple concurrent program to getdents(/dev/pts/) in
>> > one thread, whilst another opens and closes /dev/pts/ptmx: it crashes the
>> > kernel in seconds.
>> 
>> I also made a testcase and verified that your fix is fine. I also tried
>> replacing open-close on /dev/ptmx with mkdir-rmdir but that does not
>> trigger the error.
>> 
>> > Patch below, but I'd still like somebody else to look at this, please.
>> 
>> I wonder why no inode_lock on parent is needed for devpts_pty_new(), but
>> I'm obviously not a VFS expert... So your patch looks good to me and
>> clearly solves the issue.
>> 
>> thanks,
>> Jan
>> 
>> > Will
>> > 
>> > --->8
>> > 
>> > diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
>> > index c53814539070..50ddb95ff84c 100644
>> > --- a/fs/devpts/inode.c
>> > +++ b/fs/devpts/inode.c
>> > @@ -619,11 +619,17 @@ void *devpts_get_priv(struct dentry *dentry)
>> >   */
>> >  void devpts_pty_kill(struct dentry *dentry)
>> >  {
>> > -       WARN_ON_ONCE(dentry->d_sb->s_magic != DEVPTS_SUPER_MAGIC);
>> > +       struct super_block *sb = dentry->d_sb;
>> > +       struct dentry *parent = sb->s_root;
>> > 
>> > +       WARN_ON_ONCE(sb->s_magic != DEVPTS_SUPER_MAGIC);
>
> Side note, I wonder if this is even needed anymore...
>
>> > +
>> > +       inode_lock(parent->d_inode);
>> >         dentry->d_fsdata = NULL;
>> >         drop_nlink(dentry->d_inode);
>> >         d_delete(dentry);
>> > +       inode_unlock(parent->d_inode);
>> > +
>> >         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
>> >  }
>
> This feels right but getting some feedback from others would be good.

This is going to be special at least because we are not coming through
the normal unlink path and we are manipulating the dcache.

This looks plausible.  If this is whats going on then we have had this
bug for a very long time.  I will see if I can make some time.

It looks like in the general case everything is serialized by the
devpts_mutex.  I wonder if just changing the order of operations
here would be enough.

AKA: drop_nlink d_delete then dentry->d_fsdata.  Ugh d_fsdata is not
implicated so that won't help here.

I will look more shortly.  I am in the middle in the move so I don't
have time to complete the analysis today.

Eric

