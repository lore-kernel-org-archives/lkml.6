Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeERPxd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:53:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERPxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:53:31 -0400
Date: Fri, 18 May 2018 08:53:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH 01/10] mm: pagecache add lock
Message-ID: <20180518155330.GA16931@infradead.org>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-3-kent.overstreet@gmail.com>
 <20180518131305.GA6361@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518131305.GA6361@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 06:13:06AM -0700, Matthew Wilcox wrote:
> > Historically, the only problematic case has been direct IO, and people
> > have been willing to say "well, if you mix buffered and direct IO you
> > get what you deserve", and that's probably not unreasonable. But now we
> > have fallocate insert range and collapse range, and those are broken in
> > ways I frankly don't want to think about if they can't ensure consistency
> > with the page cache.
> 
> ext4 manages collapse-vs-pagefault with the ext4-specific i_mmap_sem.
> You may get pushback on the grounds that this ought to be a
> filesystem-specific lock rather than one embedded in the generic inode.

Honestly I think this probably should be in the core.  But IFF we move
it to the core the existing users of per-fs locks need to be moved
over first.  E.g. XFS as the very first one, and at least ext4 and f2fs
that copied the approach, and probably more if you audit deep enough.
