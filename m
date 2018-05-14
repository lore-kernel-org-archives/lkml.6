Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752722AbeENV1a convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:27:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752219AbeENVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:25:45 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs: Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9746.1526333143.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Mon, 14 May 2018 22:25:43 +0100
Message-ID: <9747.1526333143@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a set of patches that fix a number of bugs in the in-kernel AFS
client, including:

 (1) Fix directory locking to not use individual page locks for directory
     reading/scanning but rather to use a semaphore on the afs_vnode struct
     as the directory contents must be read in a single blob and data from
     different reads must not be mixed as the entire contents may be
     shuffled about between reads.

 (2) Fix address list parsing to handle port specifiers correctly.

 (3) Only give up callback records on a server if we actually talked to
     that server (we might not be able to access a server).

 (4) Fix some callback handling bugs, including refcounting, whole-volume
     callbacks and when callbacks actually get broken in response to a
     CB.CallBack op.

 (5) Fix some server/address rotation bugs, including giving up if we can't
     probe a server; giving up if a server says it doesn't have a volume,
     but there are more servers to try.

 (6) Fix the decoding of fetched statuses to be OpenAFS compatible.

 (7) Fix the handling of server lookups in Cache Manager ops (such as
     CB.InitCallBackState3) to use a UUID if possible and to handle no
     server being found.

 (8) Fix a bug in server lookup where not all addresses are compared.

 (9) Fix the non-encryption of calls that prevents some servers from being
     accessed (this also requires an AF_RXRPC patch that has already gone
     in through the net tree).

There's also a patch that adds tracepoints to log Cache Manager ops that
don't find a matching server, either by UUID or by address.

Thanks,
David
---
The following changes since commit f0ab773f5c96c29a5227234c4b5a820f5591b74d:

  Merge branch 'akpm' (patches from Andrew) (2018-05-11 18:04:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20180514

for you to fetch changes up to 4776cab43fd3111618112737a257dc3ef368eddd:

  afs: Fix the non-encryption of calls (2018-05-14 15:15:19 +0100)

----------------------------------------------------------------
AFS fixes

----------------------------------------------------------------
David Howells (13):
      afs: Fix directory page locking
      afs: Fix address list parsing
      afs: Fix giving up callbacks on server destruction
      afs: Fix refcounting in callback registration
      afs: Fix server rotation's handling of fileserver probe failure
      afs: Fix AFSFetchStatus decoder to provide OpenAFS compatibility
      afs: Fix VNOVOL handling in address rotation
      afs: Fix the handling of CB.InitCallBackState3 to find the server by UUID
      afs: Add a tracepoint to record callbacks from unlisted servers
      afs: Fix the handling of an unfound server in CM operations
      afs: Fix whole-volume callback handling
      afs: Fix CB.CallBack handling
      afs: Fix the non-encryption of calls

Marc Dionne (1):
      afs: Fix afs_find_server search loop

 fs/afs/addr_list.c         | 25 ++++++++------
 fs/afs/callback.c          | 84 +++++++++++++++++++++++++++++++++-------------
 fs/afs/cmservice.c         | 67 ++++++++++++------------------------
 fs/afs/dir.c               | 54 ++++++++++++++---------------
 fs/afs/file.c              |  2 +-
 fs/afs/flock.c             |  6 ++--
 fs/afs/fsclient.c          | 31 ++++++++++++-----
 fs/afs/inode.c             | 19 ++++++-----
 fs/afs/internal.h          | 25 ++++++++++++--
 fs/afs/rotate.c            | 20 +++++++----
 fs/afs/rxrpc.c             | 18 ++++++----
 fs/afs/security.c          |  7 ++--
 fs/afs/server.c            | 21 +++---------
 fs/afs/server_list.c       |  7 ++--
 fs/afs/super.c             |  4 +--
 fs/afs/write.c             |  2 +-
 include/trace/events/afs.h | 42 +++++++++++++++++++++++
 17 files changed, 266 insertions(+), 168 deletions(-)
