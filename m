Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEGMSL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:18:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751978AbeEGMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:18:10 -0400
Date: Mon, 7 May 2018 05:17:58 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/3] vfs: dedpue: return s64
Message-ID: <20180507121758.GD18116@bombadil.infradead.org>
References: <20180507082108.28186-1-mszeredi@redhat.com>
 <20180507082108.28186-2-mszeredi@redhat.com>
 <20180507111142.GA18116@bombadil.infradead.org>
 <CAOssrKebppZhRbvM-3qk=S0aY57skYCEn2axknOtF9LcJcu8yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKebppZhRbvM-3qk=S0aY57skYCEn2axknOtF9LcJcu8yA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 01:32:09PM +0200, Miklos Szeredi wrote:
> On Mon, May 7, 2018 at 1:11 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, May 07, 2018 at 10:21:06AM +0200, Miklos Szeredi wrote:
> >> f_op->dedupe_file_range() gets a u64 length to dedup and returns an ssize_t
> >> actual length deduped.  This breaks badly on 32bit archs since the returned
> >> length will be truncated and possibly overflow into the sign bit (xfs and
> >> ocfs2 are affected, btrfs limits actual length to 16MiB).
> >>
> >> Returning s64 should be good, since clone_verify_area() makes sure that the
> >> supplied length doesn't overflow.
> >
> > Why s64 rather than loff_t?  Particularly since the next patch turns
> > the paramters into loff_t.
> 
> Next patch turns the offsets into loff_t and leaves "len" as u64.  A
> size is definitely not an offset, I'd consider changing the type of
> "len" to loff_t a misuse.

Usually a size is the size of something in memory.  The length of
something on storage is definitely an loff_t.  Look at fallocate()
for an example.  You could also argue that lseek where whence is set to
anything other than SEEK_SET is also being used as a length rather than
an absolute offset.  We also already use 'loff_t len' as an argument to
vfs_dedupe_file_range_compare().
