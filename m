Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbeEWMRj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:17:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932763AbeEWMR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:17:27 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/8] afs: Mark afs_net::ws_cell as __rcu and set using rcu
 functions
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 23 May 2018 13:17:25 +0100
Message-ID: <152707784586.27887.18287659934370022329.stgit@warthog.procyon.org.uk>
In-Reply-To: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
References: <152707780120.27887.10118775145086304138.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The afs_net::ws_cell member is sometimes used under RCU conditions from
within an seq-readlock.  It isn't, however, marked __rcu and it isn't set
using the proper RCU barrier-imposing functions.

Fix this by annotating it with __rcu and using appropriate barriers to
make sure accesses are correctly ordered.

Without this, the code can produce the following warning:

>> fs/afs/proc.c:151:24: sparse: incompatible types in comparison expression (different address spaces)

Fixes: f044c8847bb6 ("afs: Lay the groundwork for supporting network namespaces")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c     |    8 ++++----
 fs/afs/internal.h |    2 +-
 fs/afs/proc.c     |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index fdf4c36cff79..80fd127239ce 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -341,8 +341,8 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 
 	/* install the new cell */
 	write_seqlock(&net->cells_lock);
-	old_root = net->ws_cell;
-	net->ws_cell = new_root;
+	old_root = rcu_access_pointer(net->ws_cell);
+	rcu_assign_pointer(net->ws_cell, new_root);
 	write_sequnlock(&net->cells_lock);
 
 	afs_put_cell(net, old_root);
@@ -755,8 +755,8 @@ void afs_cell_purge(struct afs_net *net)
 	_enter("");
 
 	write_seqlock(&net->cells_lock);
-	ws = net->ws_cell;
-	net->ws_cell = NULL;
+	ws = rcu_access_pointer(net->ws_cell);
+	RCU_INIT_POINTER(net->ws_cell, NULL);
 	write_sequnlock(&net->cells_lock);
 	afs_put_cell(net, ws);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f8086ec95e24..5d922ad148a8 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -231,7 +231,7 @@ struct afs_net {
 
 	/* Cell database */
 	struct rb_root		cells;
-	struct afs_cell		*ws_cell;
+	struct afs_cell __rcu	*ws_cell;
 	struct work_struct	cells_manager;
 	struct timer_list	cells_timer;
 	atomic_t		cells_outstanding;
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index b45ee7576aa8..362f281b1b16 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -173,7 +173,7 @@ static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
 
 	if (*_pos > 0)
 		return 0;
-	if (!net->ws_cell)
+	if (!rcu_access_pointer(net->ws_cell))
 		return 0;
 
 	rcu_read_lock();
