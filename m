Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F98CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA02077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAA02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeIGObq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:31:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44360 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIGObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:31:46 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 901BFEE6;
        Fri,  7 Sep 2018 09:51:35 +0000 (UTC)
Date:   Fri, 7 Sep 2018 11:51:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     stable <stable@vger.kernel.org>,
        kernel <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: ovl: hash non-dir by lower inode for fsnotify
Message-ID: <20180907095132.GC13327@kroah.com>
References: <2630a5c0-ef57-a4cf-a6f4-b4996c64043b@android.com>
 <20180802060549.GB3272@kroah.com>
 <8c38c2fc-36e6-9aa7-5924-51d7bc2c3d73@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c38c2fc-36e6-9aa7-5924-51d7bc2c3d73@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 08:29:02AM -0700, Mark Salyzyn wrote:
> On 08/01/2018 11:05 PM, Greg KH wrote:
> > On Wed, Aug 01, 2018 at 02:29:01PM -0700, Mark Salyzyn wrote:
> > > 764baba80168ad3adafb521d2ab483ccbc49e344 ovl: hash non-dir by lower inode
> > > for fsnotify is not part of 4.14 stable and yet it was marked for 4.13
> > > stable merge when committed.
> > > 
> > > Please evaluate.
> > Why not try applying it yourself to 4.14.y and note that it does not
> > apply at all and then provide a working backport so that we can skip at
> > least one email cycle here?  :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> Because I am embarrassed by the backport (!) perhaps? :-)
> 
> +linux-kernel list and authors/approvers for clearance.
> 
> I took some liberty with sb = dentry_d_sb and then sprinkled it in, upstream
> passes sb to the function and the conflicts assumed so.
> 
> --------------------------> snip <-------------------------
> 
> From 764baba80168ad3adafb521d2ab483ccbc49e344 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Sun, 4 Feb 2018 15:35:09 +0200
> Subject: ovl: hash non-dir by lower inode for fsnotify
> 
> (cherry pick from commit 764baba80168ad3adafb521d2ab483ccbc49e344)
> 
> Commit 31747eda41ef ("ovl: hash directory inodes for fsnotify")
> fixed an issue of inotify watch on directory that stops getting
> events after dropping dentry caches.
> 
> A similar issue exists for non-dir non-upper files, for example:
> 
> $ mkdir -p lower upper work merged
> $ touch lower/foo
> $ mount -t overlay -o
> lowerdir=lower,workdir=work,upperdir=upper none merged
> $ inotifywait merged/foo &
> $ echo 2 > /proc/sys/vm/drop_caches
> $ cat merged/foo
> 
> inotifywait doesn't get the OPEN event, because ovl_lookup() called
> from 'cat' allocates a new overlay inode and does not reuse the
> watched inode.
> 
> Fix this by hashing non-dir overlay inodes by lower real inode in
> the following cases that were not hashed before this change:
>  - A non-upper overlay mount
>  - A lower non-hardlink when index=off
> 
> A helper ovl_hash_bylower() was added to put all the logic and
> documentation about which real inode an overlay inode is hashed by
> into one place.
> 
> The issue dates back to initial version of overlayfs, but this
> patch depends on ovl_inode code that was introduced in kernel v4.13.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Cc: <stable@vger.kernel.org> #v4.13
> Signed-off-by: Mark Salyzyn <salyzyn@android.com> #v4.14
> ---
>  fs/overlayfs/inode.c | 62 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 28a320464609a..7cfef4152e9a4 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -14,6 +14,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/ratelimit.h>
>  #include "overlayfs.h"
> +#include "ovl_entry.h"
> 
>  int ovl_setattr(struct dentry *dentry, struct iattr *attr)
>  {
> @@ -608,39 +609,63 @@ static bool ovl_verify_inode(struct inode *inode,
> struct dentry *lowerdentry,

As this patch is deemed "good", can you please resend it in a
non-corrupted way so that I can apply it to the 4.14.y tree?

thanks,

greg k-h
