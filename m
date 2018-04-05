Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeDEU3d (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:29:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeDEU3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:29:31 -0400
Subject: [PATCH 00/20] afs: Fixes and development
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:29:29 +0100
Message-ID: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Here are a set of AFS patches, a few fixes, but mostly development.  The fixes
are:

 (1) Fix a bunch of checker warnings.

 (2) Fix overincrement of the usage count on pinned cells.

 (3) Fix directory handling.  We cannot assume that a directory blob isn't
     completely rewritten between version numbers on the server, so we can't
     mix pages from different versions in the local pagecache.  If the
     server's copy of a directory changes, we have to entirely throw out our
     own copy and download afresh.

and the development patches:

 (1) Implement the AFS @sys and @cell filename substitutions.

 (2) Introduce a stats file, /proc/fs/afs/stats.

 (3) Improve validation on dentries by keeping track of the last data version
     we got from the server indicating changes not made locally since the
     server inode was cached.  If we made a local change to a directory with
     no interference from another client, we don't need to invalidate all the
     dentries.

 (4) Locally edit our copy of a directory's contents when we make local
     changes to it (eg. mkdir in it).  This is fine, provided the server
     indicates that the remote copy's data version increased by exactly 1.  It
     doesn't matter if the local data deviates from the remote data in exact
     details, provided we flush the local one if we detect interference.

 (5) Add tracepoints for protocol errors and directory editing.

 (6) Do better aggregation of small disjointed writes (such as ld does) to a
     locally newly created or truncated file when we write that to the server,
     reducing the number of store ops at the expense of writing some of the
     padding back too.

Note that this depends on the fscache-next-20180404 patchset already posted.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	tags/afs-next-20180405

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

David
---
David Howells (20):
      vfs: Remove the const from dir_context::actor
      afs: Fix checker warnings
      afs: Don't over-increment the cell usage count when pinning it
      afs: Prospectively look up extra files when doing a single lookup
      afs: Implement @sys substitution handling
      afs: Implement @cell substitution handling
      afs: Dump bad status record
      afs: Introduce a statistics proc file
      afs: Init inode before accessing cache
      afs: Make it possible to get the data version in readpage
      afs: Rearrange status mapping
      afs: Keep track of invalid-before version for dentry coherency
      afs: Split the dynroot stuff out and give it its own ops tables
      afs: Fix directory handling
      afs: Split the directory content defs into a header
      afs: Adjust the directory XDR structures
      afs: Locally edit directory data for mkdir/create/unlink/...
      afs: Trace protocol errors
      afs: Add stats for data transfer operations
      afs: Do better accretion of small writes on newly created content


 Documentation/filesystems/afs.txt |   28 +
 fs/afs/Makefile                   |    2 
 fs/afs/addr_list.c                |    6 
 fs/afs/afs.h                      |   27 +
 fs/afs/afs_fs.h                   |    2 
 fs/afs/callback.c                 |   29 -
 fs/afs/cell.c                     |   12 
 fs/afs/cmservice.c                |   22 -
 fs/afs/dir.c                      |  936 +++++++++++++++++++++++++------------
 fs/afs/dir_edit.c                 |  505 ++++++++++++++++++++
 fs/afs/dynroot.c                  |  216 +++++++++
 fs/afs/file.c                     |   27 +
 fs/afs/flock.c                    |    2 
 fs/afs/fsclient.c                 |  622 ++++++++++++++++++++-----
 fs/afs/inode.c                    |   69 +--
 fs/afs/internal.h                 |  102 +++-
 fs/afs/main.c                     |   42 ++
 fs/afs/proc.c                     |  306 ++++++++++++
 fs/afs/rotate.c                   |    2 
 fs/afs/rxrpc.c                    |    9 
 fs/afs/security.c                 |   13 -
 fs/afs/server.c                   |   14 -
 fs/afs/super.c                    |   11 
 fs/afs/vlclient.c                 |   28 +
 fs/afs/write.c                    |   41 +-
 fs/afs/xdr_fs.h                   |  103 ++++
 include/linux/fs.h                |    2 
 include/trace/events/afs.h        |  113 ++++
 28 files changed, 2698 insertions(+), 593 deletions(-)
 create mode 100644 fs/afs/dir_edit.c
 create mode 100644 fs/afs/dynroot.c
 create mode 100644 fs/afs/xdr_fs.h
