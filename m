Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199FCC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB8A21852
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548848457;
	bh=+uVntEzx9FxaFLxAyBRoVVxPNN/4wCGj0FgM2KObn/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iy9Td/ZNlqCW66b1OZ610RXmuVmldECnKLBgvm9OIHnQVzlVbQqvQVdEHQG1N4HU5
	 VrNT4O/U09UzEOKP1XH3cE0/3q3GH+uW2//1DiBYthzrygPtCIiLYvLdWh4HUsu2Ez
	 B3P0ZeA1FrdsFXOTm/aJeUywQlw+b353/7N+yPxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfA3Lk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfA3Lk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:40:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43AD92175B;
        Wed, 30 Jan 2019 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548848454;
        bh=+uVntEzx9FxaFLxAyBRoVVxPNN/4wCGj0FgM2KObn/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoYmqMDPmJRYw/SekU68n6A5GXgPa3LxypXYqTgIiFadJNKzpO17j2jL+JoOd+u7q
         HkWwFAqoOwEWvmlusmXOp24i7+S68kQ2XnQDpEJh72C1u4/5UBRqA3Q7oBrjz1Xg5A
         8VEIaDzccs+3BMF/gbiraotOXt1Ux5+Li8NTsiOk=
Date:   Wed, 30 Jan 2019 12:40:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Omar Sandoval <osandov@fb.com>,
        syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@fb.com>
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
Message-ID: <20190130114052.GB30781@kroah.com>
References: <00000000000081e6cc0580aa76a2@google.com>
 <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
 <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:26:24PM +0900, Tetsuo Handa wrote:
> On 2019/01/30 20:11, Tetsuo Handa wrote:
> > Hello, Omar.
> > 
> > syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is
> > 
> >         dir = debugfs_lookup(buts->name, blk_debugfs_root);
> >         if (!dir)
> >                 bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > 
> > added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").
> > 
> > Currently, Greg Kroah-Hartman is posting patches:
> > 
> >   When calling debugfs functions, there is no need to ever check the
> >   return value.  The function can work or not, but the code logic should
> >   never do something different based on this.
> > 
> > Omar, what do you want to do for this case?
> > 
> > [1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
> > 
> 
> The function which returned -EINVAL instead of NULL seems to be debugfs_lookup()
> modified by commit ff9fb72bc07705c0 ("debugfs: return error values, not NULL").

Ok, the patch below should fix this up.

thanks,

greg k-h

-------------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] debugfs: debugfs_lookup() should return NULL if not found

Lots of callers of debugfs_lookup() were just checking NULL to see if
the file/directory was found or not.  By changing this in ff9fb72bc077
("debugfs: return error values, not NULL") we caused some subsystems to
easily crash.

Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
Reported-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Jens Axboe <axboe@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index b16f8035b1af..29c68c5d44d5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
  * @parent: a pointer to the parent dentry of the file.
  *
  * This function will return a pointer to a dentry if it succeeds.  If the file
- * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
- * returned dentry must be passed to dput() when it is no longer needed.
+ * doesn't exist or an error occurs, %NULL will be returned.  The returned
+ * dentry must be passed to dput() when it is no longer needed.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 
 	if (IS_ERR(parent))
-		return parent;
+		return NULL;
 
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
 	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
 	if (IS_ERR(dentry))
-		return dentry;
+		return NULL;
 	if (!d_really_is_positive(dentry)) {
 		dput(dentry);
-		return ERR_PTR(-EINVAL);
+		return NULL;
 	}
 	return dentry;
 }
-- 
2.20.1

