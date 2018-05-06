Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEFUqd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 16:46:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46130 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeEFUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 16:46:31 -0400
Date: Sun, 6 May 2018 21:46:23 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Message-ID: <20180506204622.GL30522@ZenIV.linux.org.uk>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org>
 <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180506005946.GI30522@ZenIV.linux.org.uk>
 <20180506073955.GJ30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506073955.GJ30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 08:39:55AM +0100, Al Viro wrote:
> On Sun, May 06, 2018 at 01:59:51AM +0100, Al Viro wrote:
> 
> > > There is nothing at the moment that needs fixing.
> > 
> > Funny, that...  I'd been going through the damn thing for the
> > last week or so; open-by-fhandle/nfs export support is completely
> > buggered.  And as for the rest... the least said about the error
> > handling, the better - something like rename() hitting an IO
> > error (read one) can not only screw the on-disk data into the
> > ground, it can do seriously bad things to kernel data structures.
> 
> ... and while we are at it, consider the following:

[snip]

Another piece of fun: in
affs_add_entry() we have

        retval = affs_insert_hash(dir, bh);
        mark_buffer_dirty_inode(bh, inode);
        affs_unlock_dir(dir);
        affs_unlock_link(inode);

	d_instantiate(dentry, inode);
done:
        affs_brelse(inode_bh);
        affs_brelse(bh);
        return retval;

and in its callers - things like
        error = affs_add_entry(dir, inode, dentry, ST_USERDIR);
        if (error) {
                clear_nlink(inode);
                mark_inode_dirty(inode);
                iput(inode);
                return error;
        }

	Guess what happens if we hit affs_insert_hash() failure?
d_instantiate() doesn't do anything to in-core inode refcount -
that's caller's responsibility.  affs_new_inode() has allocated
an inode with ->i_count equal to 1; d_instantiate() transfers that
reference into dentry (as ->d_inode).  And then, since we'd got
a non-zero error we do hit iput() (same as we would've if an error
happened early enough in affs_add_entry() to bypass d_instantiate()).
That drives ->i_count to 0, getting inode freed (zero link count
when the last in-core reference is dropped means that there's no
point retaining it in icache).
	So in that case we end up with struct dentry (still hashed
and available for lookups to pick) that has ->d_inode pointing
to freed memory.  Welcome to memory corruption...

	I'm fixing that pile of crap (along with the NFS exports
one and, hopefully, rename mess as well).  HOWEVER, I am not going
to take over the damn thing - David has violated the 11th
commandment (Thou Shalt Never Volunteer), so he gets to joy of
learning that codebase and taking care of it from now on.
