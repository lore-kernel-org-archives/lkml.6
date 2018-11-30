Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C410C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC8F20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC8F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeLADmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:42:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeLADmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:42:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02194EBD;
        Fri, 30 Nov 2018 08:32:10 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C67113F5AF;
        Fri, 30 Nov 2018 08:32:09 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 92BDA1AE12BC; Fri, 30 Nov 2018 16:32:28 +0000 (GMT)
Date:   Fri, 30 Nov 2018 16:32:28 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jan Glauber <Jan.Glauber@cavium.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: Re: dcache_readdir NULL inode oops
Message-ID: <20181130163228.GA10964@arm.com>
References: <20181110111656.GA16667@hc>
 <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com>
 <20181121131900.GA18931@hc>
 <20181123180525.GA21017@arm.com>
 <20181128200806.GC32668@arm.com>
 <20181129184950.GA7290@hc>
 <20181130104154.GA11991@kroah.com>
 <875zwe389q.fsf@xmission.com>
 <20181130160852.GN2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130160852.GN2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 04:08:52PM +0000, Al Viro wrote:
> On Fri, Nov 30, 2018 at 09:16:49AM -0600, Eric W. Biederman wrote:
> > >> > +       inode_lock(parent->d_inode);
> > >> >         dentry->d_fsdata = NULL;
> > >> >         drop_nlink(dentry->d_inode);
> > >> >         d_delete(dentry);
> > >> > +       inode_unlock(parent->d_inode);
> > >> > +
> > >> >         dput(dentry);   /* d_alloc_name() in devpts_pty_new() */
> > >> >  }
> > >
> > > This feels right but getting some feedback from others would be good.
> > 
> > This is going to be special at least because we are not coming through
> > the normal unlink path and we are manipulating the dcache.
> > 
> > This looks plausible.  If this is whats going on then we have had this
> > bug for a very long time.  I will see if I can make some time.
> > 
> > It looks like in the general case everything is serialized by the
> > devpts_mutex.  I wonder if just changing the order of operations
> > here would be enough.
> > 
> > AKA: drop_nlink d_delete then dentry->d_fsdata.  Ugh d_fsdata is not
> > implicated so that won't help here.
> 
> It certainly won't.  The thing is, this
>                 if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
>                               d_inode(next)->i_ino, dt_type(d_inode(next))))
> in dcache_readdir() obviously can block, so all we can hold over it is
> blocking locks.  Which we do - specifically, ->i_rwsem on our directory.
> 
> It's actually worse than missing inode_lock() - consider the effects
> of mount --bind /mnt/foo /dev/pts/42.  What happens when that thing
> goes away?  Right, a lost mount...

Ha, I hadn't even considered that scenario. Urgh!

> I'll resurrect the "kernel-internal rm -rf done right" series and
> post it; devpts is not the only place suffering such problem (binfmt_misc,
> etc.)

Thanks. I'm happy to test that it solves this issue if you throw me on cc.

Will
