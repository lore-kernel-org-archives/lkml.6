Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeERRp7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:45:59 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41445 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeERRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:45:54 -0400
X-Google-Smtp-Source: AB8JxZqJR8yMicbq0pAFMR00WrOOuaVaWa/j21s6EGc6wnnChjltJA0o2CvLbdmOZ1J/7qhwNj8Jrg==
Date: Fri, 18 May 2018 13:45:49 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, peterz@infradead.org
Subject: Re: [PATCH 01/10] mm: pagecache add lock
Message-ID: <20180518174549.GD31737@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-3-kent.overstreet@gmail.com>
 <20180518131305.GA6361@bombadil.infradead.org>
 <20180518155330.GA16931@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518155330.GA16931@infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:53:30AM -0700, Christoph Hellwig wrote:
> On Fri, May 18, 2018 at 06:13:06AM -0700, Matthew Wilcox wrote:
> > > Historically, the only problematic case has been direct IO, and people
> > > have been willing to say "well, if you mix buffered and direct IO you
> > > get what you deserve", and that's probably not unreasonable. But now we
> > > have fallocate insert range and collapse range, and those are broken in
> > > ways I frankly don't want to think about if they can't ensure consistency
> > > with the page cache.
> > 
> > ext4 manages collapse-vs-pagefault with the ext4-specific i_mmap_sem.
> > You may get pushback on the grounds that this ought to be a
> > filesystem-specific lock rather than one embedded in the generic inode.
> 
> Honestly I think this probably should be in the core.  But IFF we move
> it to the core the existing users of per-fs locks need to be moved
> over first.  E.g. XFS as the very first one, and at least ext4 and f2fs
> that copied the approach, and probably more if you audit deep enough.

I didn't know about i_mmap_sem, thanks

But, using a rw semaphore wouldn't work for dio writes, and I do need dio writes
to block pagecache adds in bcachefs since the dio write could overwrite
uncompressed data or a reservation with compressed data, which means new writes
need a disk reservation.

Also I'm guessing ext4 takes the lock at the top of the read path? That sucks
for reads that are already cached, the generic buffered read path can do cached
reads without taking any per inode locks - that's why I pushed the lock down to
only be taken when we have to add a page to the pagecache.

Definitely less ugly doing it that way though...
