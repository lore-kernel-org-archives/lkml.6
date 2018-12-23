Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985FAC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 01:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052321903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 01:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbeLWBNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 20:13:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34568 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbeLWBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 20:13:49 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gasKn-0007my-C5; Sun, 23 Dec 2018 01:13:37 +0000
Date:   Sun, 23 Dec 2018 01:13:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     yangerkun <yangerkun@huawei.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: remove inc_nlink in debugfs_create_automount
Message-ID: <20181223011334.GD2217@ZenIV.linux.org.uk>
References: <20181222084536.21305-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222084536.21305-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 04:45:36PM +0800, yangerkun wrote:
> Remove inc_nlink in debugfs_create_automount, or this inode will never
> be free.

Explain, please.  What exactly would care about i_nlink in debugfs?
It does *NOT* free any kind of backing store on inode eviction, for
a good and simple reason - there is no backing store at all.

And as for the icache retention, debugfs inodes are
	* never looked up in icache
	* never hashed
	* ... and thus never retained in icache past the final
iput()

i_nlink serves as a refcount - for on-disk inodes on filesystems that
allow hardlinks and need to decide if the on-disk inode needs to
follow an in-core one into oblivion.

The lifetime of in-core inode is *NOT* controlled by i_nlink.  They
can very well outlive i_nlink dropping to 0, for starters.  Consider
e.g. the following:

cat >/tmp/a.sh <<'EOF'
echo still not freed >/tmp/a
(sleep 5 && date && stat - && cat) </tmp/a &
date; rm /tmp/a && echo /tmp/a removed
EOF
sh /tmp/a.sh

Output will be
$ Sat Dec 22 19:50:27 EST 2018
/tmp/a removed
$ Sat Dec 22 19:50:32 EST 2018
  File: -
  Size: 12              Blocks: 8          IO Block: 4096   regular file
Device: 808h/2056d      Inode: 13          Links: 0
Access: (0644/-rw-r--r--)  Uid: ( 1000/      al)   Gid: ( 1000/      al)
Access: 2018-12-22 19:50:27.266694223 -0500
Modify: 2018-12-22 19:50:27.266694223 -0500
Change: 2018-12-22 19:50:27.274694262 -0500
 Birth: -
still not freed

Note that this is on a normal filesystem (ext2, in fact), so nothing
special is involved.  The in-core inode had remained alive until
all children with stdin redirected from /tmp/a exited.  As you can
see, link count is zero - that's what fstat(2) reported in ->st_nlink
and that came straight from ->i_nlink of the (very much alive) in-core
inode.

And of course, in-core inodes do get freed just fine without i_nlink
reaching zero.

It's used for 4 things:
	1) deciding whether it makes sense to evict in-core inode
as soon as we have no more (in-core) references pinning them (i.e.
when ->i_count reaches zero).  If there's a chance that somebody
will do an icache lookup finding that one, we might want to keep
it around until memory pressure kicks it out.  And since for
something like normal Unix filesystem such icache lookup can
happen as long as there are links to the (on-disk) inode left
in some directories, default policy is "try to keep it around if
i_nlink is positive *AND* it is reachable from icache in the
first place".  Filesystems might override that, but it's all moot
if the in-core inode is *not* reachable from icache in the first
place.  Which is the case for debugfs and similar beasts.
	2) deciding whether we want to free the on-disk inode
when an in-core one gets evicted.  Note that such freeing can not
happen as long as in-core inode is around - unlinking an open
file does *not* free it; it's still open and IO on such descriptor
works just fine.  There the normal rules are "if we are evicting
an in-core inode and we know that it has no links left, it's
time to free the on-disk counterpart".  Up to individual
filesystems, not applicable to debugfs for obvious reasons.
	3) for the same filesystems, if the link count is
maintained in on-disk inode we'll need to update it on unlink
et.al.  ->i_nlink of in-core inode is handy for keeping track
of that.  Again, not applicable in debugfs
	4) reporting st_nlink to userland on stat/fstat/etc.
That *is* applicable in debugfs and, in fact, it is the only
use of ->i_nlink there.
