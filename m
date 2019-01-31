Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A260B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548932037;
	bh=UH3QRQQbAx796wukcFak9coDcqmPQCQ2BakTp4gmQ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YQ/Z9OnjLHRdPvfKK0Rx6ECYWkPMlxN/iQLnOyyxq6DHhrqwyf591/DylN5fPrF9W
	 7VWr/05lESFFki8nGSA1UOABJIPG4qDKEOIjFasPLqjheussIx6hxTHsLD/4zxsmNn
	 QKZTQV5zlgefWWJdmyICag78rn7Ts8CyBkRpcroc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfAaKx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:53:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfAaKxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:53:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1061420818;
        Thu, 31 Jan 2019 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548932032;
        bh=UH3QRQQbAx796wukcFak9coDcqmPQCQ2BakTp4gmQ9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PcjV9N3orGWXSlZfZ1MagZC1J8GxgFfFG7leSXA7e0NIbl9e6yVa+97E0RYYUF4Kx
         ZrpnpgHAaVrAGWSP08Dl1RtjMSSLeljYzDHDCIAnA7qzemdLsTwg/jBEhveD0SlhO0
         pfwoCVlVNqh1x5ywuPNNjsVNScA+EJKNKXSfLFuE=
Date:   Thu, 31 Jan 2019 11:53:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Omar Sandoval <osandov@fb.com>,
        syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@fb.com>
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
Message-ID: <20190131105350.GA8271@kroah.com>
References: <00000000000081e6cc0580aa76a2@google.com>
 <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
 <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
 <20190130114052.GB30781@kroah.com>
 <CAGXu5jKezbEYNUEhMZi=4UhKV9m8wiJc1fo+fxNf5CaaBUMP8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKezbEYNUEhMZi=4UhKV9m8wiJc1fo+fxNf5CaaBUMP8w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:09:11PM +1300, Kees Cook wrote:
> On Thu, Jan 31, 2019 at 12:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 30, 2019 at 08:26:24PM +0900, Tetsuo Handa wrote:
> > > On 2019/01/30 20:11, Tetsuo Handa wrote:
> > > > Hello, Omar.
> > > >
> > > > syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is
> > > >
> > > >         dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > > >         if (!dir)
> > > >                 bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > > >
> > > > added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").
> > > >
> > > > Currently, Greg Kroah-Hartman is posting patches:
> > > >
> > > >   When calling debugfs functions, there is no need to ever check the
> > > >   return value.  The function can work or not, but the code logic should
> > > >   never do something different based on this.
> > > >
> > > > Omar, what do you want to do for this case?
> > > >
> > > > [1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
> > > >
> > >
> > > The function which returned -EINVAL instead of NULL seems to be debugfs_lookup()
> > > modified by commit ff9fb72bc07705c0 ("debugfs: return error values, not NULL").
> >
> > Ok, the patch below should fix this up.
> >
> > thanks,
> >
> > greg k-h
> >
> > -------------------------
> >
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Subject: [PATCH] debugfs: debugfs_lookup() should return NULL if not found
> >
> > Lots of callers of debugfs_lookup() were just checking NULL to see if
> > the file/directory was found or not.  By changing this in ff9fb72bc077
> > ("debugfs: return error values, not NULL") we caused some subsystems to
> > easily crash.
> >
> > Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
> > Reported-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
> > Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Jens Axboe <axboe@fb.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  fs/debugfs/inode.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > index b16f8035b1af..29c68c5d44d5 100644
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
> >   * @parent: a pointer to the parent dentry of the file.
> >   *
> >   * This function will return a pointer to a dentry if it succeeds.  If the file
> > - * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
> > - * returned dentry must be passed to dput() when it is no longer needed.
> > + * doesn't exist or an error occurs, %NULL will be returned.  The returned
> > + * dentry must be passed to dput() when it is no longer needed.
> >   *
> >   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
> >   * returned.
> > @@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
> >         struct dentry *dentry;
> >
> >         if (IS_ERR(parent))
> > -               return parent;
> > +               return NULL;
> >
> >         if (!parent)
> >                 parent = debugfs_mount->mnt_root;
> >
> >         dentry = lookup_one_len_unlocked(name, parent, strlen(name));
> >         if (IS_ERR(dentry))
> > -               return dentry;
> > +               return NULL;
> >         if (!d_really_is_positive(dentry)) {
> >                 dput(dentry);
> > -               return ERR_PTR(-EINVAL);
> > +               return NULL;
> >         }
> >         return dentry;
> >  }
> > --
> > 2.20.1
> >
> 
> FYI, this patch does not fix the relay.c crash I bisected... I think
> more clean-up is needed?

Yes, you are right, I sent you a patch for that one, here it is as well.

Note, this would be blowing up anyway if debugfs was not enabled, is
relay.c not built if that is not the case?

Ah, no, it isn't, that makes more sense now.

thanks,

greg k-h

diff --git a/kernel/relay.c b/kernel/relay.c
index 04f248644e06..9e0f52375487 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -428,6 +428,8 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
 	dentry = chan->cb->create_buf_file(tmpname, chan->parent,
 					   S_IRUSR, buf,
 					   &chan->is_global);
+	if (IS_ERR(dentry))
+		dentry = NULL;
 
 	kfree(tmpname);
 
@@ -461,7 +463,7 @@ static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 		dentry = chan->cb->create_buf_file(NULL, NULL,
 						   S_IRUSR, buf,
 						   &chan->is_global);
-		if (WARN_ON(dentry))
+		if (IS_ERR_OR_NULL(dentry))
 			goto free_buf;
 	}
 
