Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B23F1C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB9A208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB9A208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeFLSYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:24:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35566 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeFLSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:24:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fSnxv-0001ML-Fs; Tue, 12 Jun 2018 18:24:23 +0000
Date:   Tue, 12 Jun 2018 19:24:23 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 14/39] ovl: stack file ops
Message-ID: <20180612182423.GA30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk>
 <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
 <20180612022926.GY30522@ZenIV.linux.org.uk>
 <20180612024029.GZ30522@ZenIV.linux.org.uk>
 <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:24:39AM +0200, Miklos Szeredi wrote:

> > Note that anything that uses file_dentry() anywhere near ->open(),
> > ->read_iter() or ->write_iter() is an instant trouble with your scheme.
> > Such as
> > int nfs_open(struct inode *inode, struct file *filp)
> > {
> >         struct nfs_open_context *ctx;
> >
> >         ctx = alloc_nfs_open_context(file_dentry(filp), filp->f_mode, filp);
> >         if (IS_ERR(ctx))
> >                 return PTR_ERR(ctx);
> >         nfs_file_set_open_context(filp, ctx);
> >         put_nfs_open_context(ctx);
> >         nfs_fscache_open_file(inode, filp);
> >         return 0;
> > }
> >
> > You do want to support NFS for lower layers, right?
> 
> There's no change regarding how file_dentry() works.  We've just
> pushed these weird files (f_path points to overlay, f_inode points to
> underlay) down into the guts of overlayfs and are not directly
> referenced from the file table anymore.  That shouldn't make *any*
> difference from the lower fs's pov.

*owwww*
I'd managed to push that particular nest of horrors out of mind ;-/
Having dug out my notes from back then and grepped around...  The real
mess is not even /proc/*/maps - it's /proc/*/map_files/* and yes, the
reasons for that kludge are still valid ;-/

Fuck.  OK, so we want to get rid of ->f_path.dentry accesses and see
that they don't come back.  Leaving them around due to "it won't come
anywhere near overlayfs" was a mistake of the same kind as leaving
d_add() in ->lookup() instances where we'd been certain that filesystem
would never get exported over NFS.  Just as we'd got open-by-handle for
e.g. NFS, we'd got nothing to prevent ecryptfs as lower layer in
overlayfs...

I hate it, but... consider path_open() objections withdrawn for now.
Uses of ->vm_file (and rules for those) are too convoluted to untangle
at the moment.  I still would love to get that straightened out, but
it's not this cycle fodder, more's the pity...
