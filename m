Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbeEFHlN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 03:41:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36334 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeEFHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 03:41:12 -0400
Date: Sun, 6 May 2018 08:40:00 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@vger.kernel.org,
        Debian m68k <debian-68k@lists.debian.org>
Subject: Re: moving affs + RDB partition support to staging?
Message-ID: <20180506073955.GJ30522@ZenIV.linux.org.uk>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org>
 <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180506005946.GI30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506005946.GI30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 01:59:51AM +0100, Al Viro wrote:

> > There is nothing at the moment that needs fixing.
> 
> Funny, that...  I'd been going through the damn thing for the
> last week or so; open-by-fhandle/nfs export support is completely
> buggered.  And as for the rest... the least said about the error
> handling, the better - something like rename() hitting an IO
> error (read one) can not only screw the on-disk data into the
> ground, it can do seriously bad things to kernel data structures.

... and while we are at it, consider the following:

mkdir a
mkdir b
touch a/x
ln a/x b

<umount and mount again, to get cold dcache, or just wait for memory
pressure to evict those suckers>

process A: unlink("a/x");
process B: open("b/x");

We had two entries - one in a, another in b; the one in a is ST_FILE one,
the one in b - ST_LINKFILE, with ->original refering to the ST_FILE one.

unlink() needs to kick the entry out of a; since it can't leave an
ST_FILE not included into any directory (and since the file should live on
due to b/x still being there) it ends up removing ST_LINKFILE entry from
b and moving ST_FILE one in its place.  That happens in affs_remove_link().

However, open() gets there just as this surgery is about to begin.
It gets to affs_lookup(), which finds the entry for b/x, reads it,
stashes block number of that entry into dentry->d_fsdata, notices
that it's ST_LINKFILE one, picks the block number of ST_FILE one
out of it and proceeds to look up the inode; that doesn't end up
doing any work (the same inode is in icache due to a/x having been
looked up by unlink(2)).

In the meanwhile, since the hash table of b has been unlocked once
we'd done hash lookup, affs_remove_link() can proceed with the
surgery.  It *does* try to catch dentries with ->d_fsdata containing
the block number of sacrificed ST_LINKFILE and reset that to block
number of ST_FILE that gets moved in its place.  However, it does
so by
static void
affs_fix_dcache(struct inode *inode, u32 entry_ino)
{
        struct dentry *dentry;
        spin_lock(&inode->i_lock);
        hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
                if (entry_ino == (u32)(long)dentry->d_fsdata) {
                        dentry->d_fsdata = (void *)inode->i_ino;
                        break;
                }
        }
        spin_unlock(&inode->i_lock);
}
i.e. looping through dentries that point to our inode.  Except that
*our* dentry isn't attached to inode yet, so we are SOL - it's
left with ->d_fsdata pointing to (destroyed) ST_LINKFILE.

After a while process B closes the file and unlinks it.  Take a look
at affs_remove_header() and you'll see how much fun we are in for -
it uses ->d_fsdata to pick the entry to find and remove...

That's an fs corruptor, plain and simple.  As far as I had been able
to reconstruct the history, leftover after Roman's locking changes
17 years ago.  AFAICS, I'd missed it back then - the races I'd spotted
had been dealt with about a year later (when we started to lock the
victim in vfs_unlink/vfs_rmdir/vfs_rename), but this one went unnoticed...
