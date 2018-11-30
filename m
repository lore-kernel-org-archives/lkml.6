Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F167C20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F167C20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeLADSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:18:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48204 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeLADSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:18:50 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gSlLY-00024r-Rg; Fri, 30 Nov 2018 16:08:52 +0000
Date:   Fri, 30 Nov 2018 16:08:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181130160852.GN2217@ZenIV.linux.org.uk>
References: <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc>
 <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com>
 <20181121131900.GA18931@hc>
 <20181123180525.GA21017@arm.com>
 <20181128200806.GC32668@arm.com>
 <20181129184950.GA7290@hc>
 <20181130104154.GA11991@kroah.com>
 <875zwe389q.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zwe389q.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:16:49AM -0600, Eric W. Biederman wrote:
> >> > +       inode_lock(parent->d_inode);
> >> >         dentry->d_fsdata = NULL;
> >> >         drop_nlink(dentry->d_inode);
> >> >         d_delete(dentry);
> >> > +       inode_unlock(parent->d_inode);
> >> > +
> >> >         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
> >> >  }
> >
> > This feels right but getting some feedback from others would be good.
> 
> This is going to be special at least because we are not coming through
> the normal unlink path and we are manipulating the dcache.
> 
> This looks plausible.  If this is whats going on then we have had this
> bug for a very long time.  I will see if I can make some time.
> 
> It looks like in the general case everything is serialized by the
> devpts_mutex.  I wonder if just changing the order of operations
> here would be enough.
> 
> AKA: drop_nlink d_delete then dentry->d_fsdata.  Ugh d_fsdata is not
> implicated so that won't help here.

It certainly won't.  The thing is, this
                if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
                              d_inode(next)->i_ino, dt_type(d_inode(next))))
in dcache_readdir() obviously can block, so all we can hold over it is
blocking locks.  Which we do - specifically, ->i_rwsem on our directory.

It's actually worse than missing inode_lock() - consider the effects
of mount --bind /mnt/foo /dev/pts/42.  What happens when that thing
goes away?  Right, a lost mount...

I'll resurrect the "kernel-internal rm -rf done right" series and
post it; devpts is not the only place suffering such problem (binfmt_misc,
etc.)
