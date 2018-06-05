Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeFEQHC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:07:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751745AbeFEQHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:07:00 -0400
Subject: [PATCH 0/5] afs: Fixes and development
From: David Howells <dhowells@redhat.com>
To: viro@ZenIV.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Jun 2018 17:06:58 +0100
Message-ID: <152821481874.16494.4047053234419671609.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of AFS patches, one fixes, but mostly development.  The fix is:

 (1) Fix AFS to build if CONFIG_PROC_FS=n.

and the development patches:

 (1) Make AFS show all of a server's addresses in /proc/fs/afs/servers.

 (2) Allow DNS upcalls to ask for IPv6 addresses.

 (3) Add directories to the dynamic root pseudo-superblock to represent the
     names of known cells.

     This needs checking as it adds a VFS function to look up a dentry
     without creating one if it doesn't exist.  This is used to find a
     dentry if it exists so that we can delete it.

 (4) Optimise the handling of change notifications from the server
     (callback breaks) to avoid doing a volume lookup for every callback
     broken if there are two or more with the same volume ID.

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

David
---
David Howells (5):
      afs: Handle CONFIG_PROC_FS=n
      afs: Show all of a server's addresses in /proc/fs/afs/servers
      afs: Enable IPv6 DNS lookups
      afs: Display manually added cells in dynamic root mount
      afs: Optimise callback breaking by not repeating volume lookup


 fs/afs/Makefile       |    4 +-
 fs/afs/addr_list.c    |    2 -
 fs/afs/callback.c     |  110 ++++++++++++++++++++++++++++++++++++-------
 fs/afs/cell.c         |   12 +++--
 fs/afs/dynroot.c      |  126 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/afs/internal.h     |   30 +++++++++++-
 fs/afs/main.c         |    2 -
 fs/afs/proc.c         |   10 +++-
 fs/afs/server.c       |    2 -
 fs/afs/super.c        |   19 ++++++-
 fs/namei.c            |   29 +++++++++++
 include/linux/namei.h |    1 
 12 files changed, 310 insertions(+), 37 deletions(-)
