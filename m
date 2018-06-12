Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E337C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB92A208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 02:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB92A208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935152AbeFLCkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 22:40:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42444 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935004AbeFLCkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 22:40:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fSZEU-0006yj-1U; Tue, 12 Jun 2018 02:40:30 +0000
Date:   Tue, 12 Jun 2018 03:40:30 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 14/39] ovl: stack file ops
Message-ID: <20180612024029.GZ30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk>
 <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
 <20180612022926.GY30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612022926.GY30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:29:26AM +0100, Al Viro wrote:

> It might (or might not) work for the filesystems you'd been testing
> on, but it's a lot of trouble waiting to happen.  Hell, try and use
> ecryptfs as lower layer, see how fast it'll blow up.  Sure, it's
> a dumb testcase, but I don't see how to check if something more
> realistic is trouble-free.
> 
> I'd been trying to come up with some way to salvage that kludge of yours,
> but I don't see any solutions.  We don't have good proxies for "this
> filesystem might be unsafe as lower layer" ;-/

Note that anything that uses file_dentry() anywhere near ->open(),
->read_iter() or ->write_iter() is an instant trouble with your scheme.
Such as
int nfs_open(struct inode *inode, struct file *filp)
{
        struct nfs_open_context *ctx;

        ctx = alloc_nfs_open_context(file_dentry(filp), filp->f_mode, filp);
        if (IS_ERR(ctx)) 
                return PTR_ERR(ctx);
        nfs_file_set_open_context(filp, ctx);
        put_nfs_open_context(ctx);
        nfs_fscache_open_file(inode, filp);
        return 0;
}

You do want to support NFS for lower layers, right?
