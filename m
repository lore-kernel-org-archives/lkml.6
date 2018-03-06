Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932941AbeCFTDS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 14:03:18 -0500
Received: from caffeine.csclub.uwaterloo.ca ([129.97.134.17]:35047 "EHLO
        caffeine.csclub.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753466AbeCFTDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 14:03:17 -0500
Date: Tue, 6 Mar 2018 14:03:15 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Len Sorensen <lsorense@csclub.uwaterloo.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ext4 ignoring rootfs default mount options
Message-ID: <20180306190315.puocf5bu3bfz6yct@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While switching a system from using ext3 to ext4 (It's about time) I
discovered that setting default options for the filesystem using tune2fs
-o doesn't work for the root filesystem when mounted by the kernel itself.
Filesystems mounted from userspace with the mount command use the options
set just fine.  The extended option set with tune2fs -E mount_opts=
works fine however.  I am sure those using an initrd works fine (and
hence why almost noone would ever see this bug) since that uses the
mount command from userspace to mount the rootfs.

Specifically we did:

tune2fs -o nodelalloc /dev/sda1

at boot we got:
EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)

Instead using:
tune2fs -E mount_opts=nodelalloc /dev/sda1

at boot we got:
EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: nodelalloc; (null)

which seems better.

For filesystems mounted from userspace with the mount command, either
method works however.  The first option however is what the comment in
fs/ext4/super.c suggests to use.

Of course I also got the messages:
EXT4-fs (sda1): Mount option "nodelalloc" incompatible with ext3
EXT4-fs (sda1): failed to parse options in superblock: nodelalloc
EXT4-fs (sda1): couldn't mount as ext3 due to feature incompatibilities

Those of course all ought to not be there.  If it is ext4, I don't really
care if ext3 doesn't understand the options, it works fine with ext4.
I should not have to explicitly specify that it is ext4 just to avoid
those.  It is not an ext3 filesystem.

And of course the last annoying thing I noticed is that /proc/mounts
doesn't actually tell you that nodelalloc is active when it is set
from the default mount options rather than from the mount command line
(or fstab).  Lots of other non default options are explicitly handled,
but not delalloc.  The only place you see it, is in the dmesg line
telling you what options the filesystem was mounted with.

-- 
Len Sorensen
