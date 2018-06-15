Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4B55C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7FE2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7FE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755778AbeFOFrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:47:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52552 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755598AbeFOFrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:47:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fThZt-0008AR-I2; Fri, 15 Jun 2018 05:47:17 +0000
Date:   Fri, 15 Jun 2018 06:47:17 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 14/39] ovl: stack file ops
Message-ID: <20180615054717.GC30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-15-mszeredi@redhat.com>
 <20180610041243.GJ30522@ZenIV.linux.org.uk>
 <CAJfpegtEGuBqmJ+6Kzd0456o0xyebe3LBk66xWQcuzsenqKVeg@mail.gmail.com>
 <20180612022926.GY30522@ZenIV.linux.org.uk>
 <20180612024029.GZ30522@ZenIV.linux.org.uk>
 <CAJfpegvUkcUw0GXxFesT6V2f27EXW7jkvBpvnG4XB49BPdvjjA@mail.gmail.com>
 <20180612182423.GA30522@ZenIV.linux.org.uk>
 <20180612183123.GB30522@ZenIV.linux.org.uk>
 <CAJfpegsnvxUNCaE4c1_UDKq169i8WBTMuWzyvyo8UvenqZCUXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsnvxUNCaE4c1_UDKq169i8WBTMuWzyvyo8UvenqZCUXg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:21:30AM +0200, Miklos Szeredi wrote:
> On Tue, Jun 12, 2018 at 8:31 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Jun 12, 2018 at 07:24:23PM +0100, Al Viro wrote:
> 
> >> I hate it, but... consider path_open() objections withdrawn for now.
> 
> Is that an ACK for the pull if I follow up with fixes for mmap botch, etc?

Yes.

> >> Uses of ->vm_file (and rules for those) are too convoluted to untangle
> >> at the moment.  I still would love to get that straightened out, but
> >> it's not this cycle fodder, more's the pity...
> 
> Looked at some other options...  What coda mmap does looks very
> dubious.  It only sets f_mapping, not vm_file.  That's going to get
> into all sorts of trouble when underlying fs tries to look at
> file_inode() or worse, ->private_data.  Looks like that should be
> converted to what overlayfs does, to have a remote chance of actually
> not crashing on most filesystems.  Does anybody actually use coda
> still?

Keep in mind that coda is using the local fs only as cache; IOW, its needs
are much more limited than those of overlayfs - local r/w filesystem,
disk-backed or tmpfs, used pretty much as a scratch space.

> > PS: conversion of ->f_path.dentry is easy and that can probably go this
> > cycle - it's a fairly trivial change, with no functional changes unless
> > overlayfs is used with <filesystem>, fixing really bad shit if it ever
> > gets used thus.  I'm not asking to put that into overlayfs pull *and*
> > it's independent from the "want to kill that fucking kludge" stuff.
> > The latter is too hard for this cycle, unfortunately.
> 
> So this is about adding a file_dentry_check() (or whatever we want to
> call it) helper to be used by all filesystems when dereferecing
> f_path.dentry, right?

file_dentry(), and some of the users should be converted to file_inode().
There's also a missing helper for debugfs uses - more or less a combination
of file_dentry() and debugfs_file_get() (if not a conversion of
debugfs_file_get() to taking struct file - almost all users are of that
form, if not entirely all of them).  I've some of that done in local
branch...
