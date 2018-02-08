Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeBHQQH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeBHQQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:06 -0500
Subject: [PATCH 0/7] afs: Fixes and dynamic root
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:04 +0000
Message-ID: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Here are a set of AFS patches, 4 fixes, 2 cleanups and 1 devel patch.  The
fixes are:

 (1) Add a missing put.

 (2) & (3) Reset the address iteration cursor correctly.

 (4) Fix setting up the fileserver iteration cursor.

The cleanups:

 (5) Remove some dead code.

 (6) Rearrange a function to be more logically laid out.

And the development patch:

 (7) Support AFS dynamic root.

With these patches, one should be able to do, say:

	mkdir /afs
	mount -t afs none /afs -o dyn

to create a dynamic root and then, provided you have keyutils installed, do:

	ls /afs/grand.central.org

and:

	ls /afs/umich.edu

to list the root volumes of both those organisations' AFS cells without
requiring any other setup (the kernel upcall to a program in the keyutils
package to do DNS access as does NFS).

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

tagged thusly:

	afs-next-20180208

David
---
David Howells (7):
      afs: Add missing afs_put_cell()
      afs: Fix missing cursor clearance
      afs: Need to clear responded flag in addr cursor
      afs: Fix server list handling
      afs: Remove unused code
      afs: Rearrange afs_select_fileserver() a little
      afs: Support the AFS dynamic root


 Documentation/filesystems/afs.txt |   17 ++
 fs/afs/addr_list.c                |   13 +-
 fs/afs/dir.c                      |  122 ++++++++++++++-
 fs/afs/inode.c                    |   48 ++++--
 fs/afs/internal.h                 |   12 +-
 fs/afs/mntpt.c                    |   20 +--
 fs/afs/rotate.c                   |  293 +++----------------------------------
 fs/afs/server_list.c              |    3 
 fs/afs/super.c                    |  132 +++++++++++------
 fs/afs/vlclient.c                 |   10 +
 fs/afs/volume.c                   |   47 ------
 net/dns_resolver/dns_query.c      |   22 ++-
 12 files changed, 324 insertions(+), 415 deletions(-)
