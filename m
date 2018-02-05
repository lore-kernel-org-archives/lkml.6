Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeBEMtZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:49:25 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33582 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeBEMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:49:10 -0500
X-Google-Smtp-Source: AH8x2249QKD6DCInJXKFKDzA2AyttYwPwPGqgYcZzjnOnzlfR/7+VzCKYx3UNjC8zFV0UtViwL9Gpw==
Date: Mon, 5 Feb 2018 13:49:02 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 4.16
Message-ID: <20180205124902.GA19579@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-linus

This work from Amir adds NFS export capability to overlayfs.  NFS exporting an
overlay filesystem is a challange because we want to keep track of any copy-up
of a file or directory between encoding the file handle and decoding it.

This is achieved by indexing copied up objects by lower layer file handle.  The
index is already used for hard links, this patchset extends the use to NFS file
handle decoding.

There's a VFS patch that splits out d_instantiate_anon() from d_obtain_alias().
This is needed because overlayfs allocates d_fsdata for its dentries, so the
plain d_alloc_anon() call in d_obtain_alias() is not sufficient to create a
fully initialized overlay dentry.  The patch conflicts with f1ee616214cb ("VFS:
don't keep disconnected dentries on d_anon"); fixup by "s/tmp/dentry/g" on the
upstream version.

Thanks,
Miklos

---
Amir Goldstein (50):
      ovl: hash directory inodes for fsnotify
      ovl: fix failure to fsync lower dir
      ovl: take lower dir inode mutex outside upper sb_writers lock
      ovl: fix another overlay: warning prefix
      ovl: take mnt_want_write() for work/index dir setup
      ovl: take mnt_want_write() for removing impure xattr
      ovl: fix inconsistent d_ino for legacy merge dir
      ovl: disable index when no xattr support
      ovl: force r/o mount when index dir creation fails
      ovl: store layer index in ovl_layer
      ovl: factor out ovl_check_origin_fh()
      ovl: simplify arguments to ovl_check_origin_fh()
      ovl: generalize ovl_verify_origin() and helpers
      ovl: update documentation of inodes index feature
      ovl: add support for "nfs_export" configuration
      ovl: verify stored origin fh matches lower dir
      ovl: unbless lower st_ino of unverified origin
      ovl: use directory index entries for consistency verification
      ovl: verify whiteout index entries on mount
      ovl: verify directory index entries on mount
      ovl: cleanup temp index entries
      ovl: create ovl_need_index() helper
      ovl: index all non-dir on copy up for NFS export
      ovl: index directories on copy up for NFS export
      ovl: cleanup dir index when dir nlink drops to zero
      ovl: whiteout index when union nlink drops to zero
      ovl: whiteout orphan index entries on mount
      ovl: factor out ovl_get_index_fh() helper
      ovl: do not pass overlay dentry to ovl_get_inode()
      ovl: use d_splice_alias() in place of d_add() in lookup
      ovl: copy up of disconnected dentries
      ovl: store 'has_upper' and 'opaque' as bit flags
      ovl: document NFS export
      ovl: encode pure upper file handles
      ovl: decode pure upper file handles
      ovl: decode connected upper dir file handles
      ovl: encode non-indexed upper file handles
      ovl: copy up before encoding non-connectable dir file handle
      ovl: encode lower file handles
      ovl: decode lower non-dir file handles
      ovl: decode indexed non-dir file handles
      ovl: decode lower file handles of unlinked but open files
      ovl: decode indexed dir file handles
      ovl: decode pure lower dir file handles
      ovl: hash non-indexed dir by upper inode for NFS export
      ovl: lookup connected ancestor of dir in inode cache
      ovl: lookup indexed ancestor of lower dir
      ovl: wire up NFS export operations
      ovl: fix regression in fsnotify of overlay merge dir
      ovl: check ERR_PTR() return value from ovl_encode_fh()

Miklos Szeredi (1):
      vfs: factor out helpers d_instantiate_anon() and d_alloc_anon()

---
 Documentation/filesystems/overlayfs.txt | 106 ++++-
 fs/dcache.c                             |  88 ++--
 fs/overlayfs/Kconfig                    |  31 +-
 fs/overlayfs/Makefile                   |   3 +-
 fs/overlayfs/copy_up.c                  | 188 +++++++--
 fs/overlayfs/dir.c                      | 175 ++++----
 fs/overlayfs/export.c                   | 715 ++++++++++++++++++++++++++++++++
 fs/overlayfs/inode.c                    | 106 +++--
 fs/overlayfs/namei.c                    | 533 +++++++++++++++++-------
 fs/overlayfs/overlayfs.h                |  66 ++-
 fs/overlayfs/ovl_entry.h                |  11 +-
 fs/overlayfs/readdir.c                  |  57 ++-
 fs/overlayfs/super.c                    | 125 ++++--
 fs/overlayfs/util.c                     | 108 +++--
 include/linux/dcache.h                  |   2 +
 15 files changed, 1905 insertions(+), 409 deletions(-)
 create mode 100644 fs/overlayfs/export.c
