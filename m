Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeERQxn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbeERQuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:50:35 -0400
Message-ID: <822b5af73146dd7cc9c18f0cbbe3ae7121af493d.camel@kernel.org>
Subject: Re: [RFC PATCH 07/11] ext4: have sync_fs op report writeback errors
 when passed a since pointer
From: Jeff Layton <jlayton@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@ZenIV.linux.org.uk, andres@anarazel.de
Date: Fri, 18 May 2018 12:50:31 -0400
In-Reply-To: <20180518152250.GC6361@bombadil.infradead.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
         <20180518123415.28181-8-jlayton@kernel.org>
         <20180518152250.GC6361@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-18 at 08:22 -0700, Matthew Wilcox wrote:
> On Fri, May 18, 2018 at 08:34:11AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > When ext4_sync_fs gets a non-NULL since pointer, use it to report
> > errors vs. the errseq_t in the super_block. This allows us to
> > properly report an error to sync_fs when any inode has failed writeback
> > since we last checked for it.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/ext4/super.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 896ddf8c3421..a5f41d31611f 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4898,6 +4898,8 @@ static int ext4_sync_fs(struct super_block *sb, int wait, errseq_t *since)
> >  	}
> >  out:
> >  	ret2 = __sync_blockdev(sb->s_bdev, wait);
> > +	if (since)
> > +		ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
> >  	return ret ? ret : ret2;
> >  }
> 
> This is inconsistent with the ext2 and xfs implementations ...
> 
> I'm worried this is too much complexity to push down to the filesystems.
> When should errors get reported through the return value; when should they
> be reported through the errseq_t?
> 
> Can we hide all of this?  Maybe ext4 could do:
> 
> 	errseq_set(&sb->s_wb_err, __sync_blockdev(sb->s_bdev, wait));
> 	return ret;
> 

I'm not sure I understand what you intend here. If __sync_blockdev
fails, then the error should have already been marked in sb->s_wb_err
(via patch #6). We wouldn't want to record that again at syncfs time.
Note that __sync_blockdev will return errors based on the legacy
AS_EIO/AS_ENOSPC flags.

We really do need to record it in the superblock as soon as possible
after an error occurs. If we want to allow userland to eventually be
able to scrape this value out of the kernel (as we discussed at LSF/MM)
then we can't assume that it'll be doing any sort of syncfs call
beforehand.

The main reason to push this down into the filesystems is to allow them
control over whether to report errors at syncfs time via the superblock
errseq_t or not. If we don't really care about allowing this to be an
opt-in thing, then we could just take the patch that I sent on April
17th:

    [PATCH] fs: track per-sb writeback errors and report them to syncfs

We'd also want patch #6 from this series, I think, but that's more or
less enough to implement this over all filesystems, assuming they use
mapping_set_error to record writeback errors. I'm fine with either
approach.

> (we'd need to make calling errseq_set(x, 0) be a no-op instead of an error)
> 
> and then the caller is the one who takes care of calling
> errseq_check_and_advance() so we don't have to pass 'since' into each
> filesystem.
