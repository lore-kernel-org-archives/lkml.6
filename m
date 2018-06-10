Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XamjKlO9HFujYwAAmS7hNA
	; Sun, 10 Jun 2018 05:55:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BE2DF607BB; Sun, 10 Jun 2018 05:55:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 454E7605A5;
	Sun, 10 Jun 2018 05:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 454E7605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeFJFzs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 01:55:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54516 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeFJFzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 01:55:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRtJG-0004G4-J5; Sun, 10 Jun 2018 05:54:44 +0000
Date: Sun, 10 Jun 2018 06:54:38 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs update for 4.18
Message-ID: <20180610055326.GR30522@ZenIV.linux.org.uk>
References: <20180608121330.GG23785@veci.piliscsaba.redhat.com>
 <20180609065208.GA31572@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609065208.GA31572@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:52:08PM -0700, Christoph Hellwig wrote:
> On Fri, Jun 08, 2018 at 02:13:30PM +0200, Miklos Szeredi wrote:
> > Hi Linus,
> > 
> > Please pull from:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-4.18
> > 
> > This contains two new features:
> > 
> >  1) Stack file operations: this allows removal of several hacks from the
> >     VFS, proper interaction of read-only open files with copy-up,
> >     possibility to implement fs modifying ioctls properly, and others.
> 
> Which includews all kinds of NAKed or at least non-acked VFS changes.

Umm...  The worst of yours had been ->pre_mmap(), right?  He *did* drop that...

> Please get these through Als tree after proper review first.

OK, summary of sort (see fsdevel thread for details):
	* path_open() is dubious; why not simply use vfsmount/dentry from the
right layer when opening an underlying file?  Then it would be vfs_open()...
	* ovl_mmap() is broken, plain and simple.  Failure ends up leaking
a layer struct file *and* doing double fput() on overlayfs one.
	* ovl_mmap() is also trivially DoSable - you can trigger tons and tons
of reopens, each sticking a new (writable layer) struct file into a vma.
We *do* want some scheme avoiding once-per-operations reopens in the
copied-up-after-r/o-open case.  See possible kinda-sorta solution on fsdevel;
I'm not sure I like it, though.

The rest is pretty minor.
