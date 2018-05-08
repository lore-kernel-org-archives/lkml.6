Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeEHSEv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53805 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbeEHSEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:49 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [RFC][PATCH 0/76] vfs: 'views' for filesystems with more than one root
Date: Tue,  8 May 2018 11:03:20 -0700
Message-Id: <20180508180436.716-1-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The VFS's super_block covers a variety of filesystem functionality. In
particular we have a single structure representing both I/O and
namespace domains.

There are requirements to de-couple this functionality. For example,
filesystems with more than one root (such as btrfs subvolumes) can
have multiple inode namespaces. This starts to confuse userspace when
it notices multiple inodes with the same inode/device tuple on a
filesystem.

In addition, it's currently impossible for a filesystem subvolume to
have a different security context from it's parent. If we could allow
for subvolumes to optionally specify their own security context, we
could use them as containers directly instead of having to go through
an overlay.


I ran into this particular problem with respect to Btrfs some years
ago and sent out a very naive set of patches which were (rightfully)
not incorporated:

https://marc.info/?l=linux-btrfs&m=130074451403261&w=2
https://marc.info/?l=linux-btrfs&m=130532890824992&w=2

During the discussion, one question did come up - why can't
filesystems like Btrfs use a superblock per subvolume? There's a
couple of problems with that:

- It's common for a single Btrfs filesystem to have thousands of
  subvolumes. So keeping a superblock for each subvol in memory would
  get prohibively expensive - imagine having 8000 copies of struct
  super_block for a file system just because we wanted some separation
  of say, s_dev.

- Writeback would also have to walk all of these superblocks -
  again not very good for system performance.

- Anyone wanting to lock down I/O on a filesystem would have to freeze
  all the superblocks. This goes for most things related to I/O really
  - we simply can't afford to have the kernel walking thousands of
  superblocks to sync a single fs.

It's far more efficient then to pull those fields we need for a
subvolume namespace into their own structure.


The following patches attempt to fix this issue by introducing a
structure, fs_view, which can be used to represent a 'view' into a
filesystem. We can migrate super_block fields to this structure one at
a time. Struct super_block gets a default view embedded into
it. Inodes get a new field, i_view, which can be dereferenced to get
the view that an inode belgongs to. By default, we point i_view to the
view on struct super_block. That way existing filesystems don't have
to do anything different.

The patches are careful not to grow the size of struct inode.

For the first patch series, we migrate s_dev over from struct
super_block to struct fs_view. This fixes a long standing bug in how
the kernel reports inode devices to userspace.

The series follows an order:

- We first introduce the fs_view structure and embed it into struct
  super_block. As discussed, struct inode gets a pointer to the
  fs_view, i_view. The only member on fs_view at this point is a
  super_block * so that we can replace i_sb. A helper function is
  provided to get to the super_block from a struct inode.

- Convert the kernel to using our helper function to get to i_sb. This
  is done on in a per-filesystem patch. The other parts of the kernel
  referencing i_sb get their changes batched up in logical groupings.

- Move s_dev from struct super_block to struct fs_view.

- Convert the kernel from inode->i_sb->s_dev to the device from our
  fs_view. In the end, these lines will look like inode_view(inode)->v_dev.

- Add an fs_view struct to each Btrfs root, point inodes to that view
  when we initialize them.


The patches are available via git and are based off Linux
v4.16. There's two branches, with identical code.

- With the inode_sb() changeover patch broken out (as is sent here):

https://github.com/markfasheh/linux fs_view-broken-out

- With the inode_sb() changeover patch in one big change:

https://github.com/markfasheh/linux fs_view


Comments are appreciated.

Thanks,
  --Mark
