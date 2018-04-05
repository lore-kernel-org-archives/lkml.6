Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDEUiQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:38:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751543AbeDEU3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:29:53 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/20] afs: Don't over-increment the cell usage count when
 pinning it
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:29:48 +0100
Message-ID: <152296018868.31027.18115871123610925864.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFS cells that are added or set as the workstation cell through /proc are
pinned against removal by setting the AFS_CELL_FL_NO_GC flag on them and
taking a ref.  The ref should be only taken if the flag wasn't already set.

Fix this by making it conditional.

Without this an assertion failure will occur during module removal
indicating that the refcount is too elevated.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/cell.c |    4 ++--
 fs/afs/proc.c |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 69b95faacc5e..721425b98b31 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -334,8 +334,8 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 		return PTR_ERR(new_root);
 	}
 
-	set_bit(AFS_CELL_FL_NO_GC, &new_root->flags);
-	afs_get_cell(new_root);
+	if (!test_and_set_bit(AFS_CELL_FL_NO_GC, &new_root->flags))
+		afs_get_cell(new_root);
 
 	/* install the new cell */
 	write_seqlock(&net->cells_lock);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 1c95756335b7..2f04d37eeef0 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -284,7 +284,8 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 
-		set_bit(AFS_CELL_FL_NO_GC, &cell->flags);
+		if (test_and_set_bit(AFS_CELL_FL_NO_GC, &cell->flags))
+			afs_put_cell(net, cell);
 		printk("kAFS: Added new cell '%s'\n", name);
 	} else {
 		goto inval;
