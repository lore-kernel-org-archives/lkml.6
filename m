Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeEWMQo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:16:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754406AbeEWMQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:16:43 -0400
Subject: [PATCH 0/8] afs: Network-namespacing
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:16:41 +0100
Message-ID: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Can you pull these patches on top of Christoph's procfs changes?  The patches
do:

 (*) Rearrange fs/afs/proc.c to get rid of the forward declarations and
     simplify the commenting.

 (*) Supply functions that allow writable net proc files to be created
     (this could be extended to provide writing on non-net proc files).

 (*) Implement network namespacing in AFS and simplify the proc usage,
     using the new convenience functions provided.

I've included another couple of small patches also:

 (*) afs_net::ws_cell should be annotated and accessed for RCU.  This patch
     would conflict with the other patches if separate.

 (*) Fix a sparse warning where sparse can't manage to follow the locking
     in a function.

Note that these patches don't quite complete network namespacing; the last
bit requires the mount API patches to allow propagation of the network
namespace across automounts.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	afs-namespace-20180523

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-namespace

David
---
David Howells (8):
      afs: Move /proc management functions to the end of the file
      afs: Rearrange fs/afs/proc.c by moving fops and open functions down
      afs: Rearrange fs/afs/proc.c to move the show routines up
      afs: Rearrange fs/afs/proc.c to remove remaining predeclarations.
      proc: Add a way to make network proc files writable
      afs: Fix a Sparse warning in xdr_decode_AFSFetchStatus()
      afs: Mark afs_net::ws_cell as __rcu and set using rcu functions
      afs: Implement network namespacing


 fs/afs/cell.c           |   12 -
 fs/afs/cmservice.c      |    2 
 fs/afs/fsclient.c       |   97 +++---
 fs/afs/internal.h       |   45 +--
 fs/afs/main.c           |   33 ++
 fs/afs/netdevices.c     |    6 
 fs/afs/proc.c           |  787 +++++++++++++++++------------------------------
 fs/afs/rxrpc.c          |    2 
 fs/afs/super.c          |   20 +
 fs/proc/generic.c       |   24 +
 fs/proc/internal.h      |    2 
 fs/proc/proc_net.c      |   92 +++++
 include/linux/proc_fs.h |   12 +
 13 files changed, 552 insertions(+), 582 deletions(-)
