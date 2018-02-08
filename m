Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBHQQV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752227AbeBHQQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:19 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/7] afs: Fix missing cursor clearance
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:17 +0000
Message-ID: <151810657734.20070.14877333169410648324.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_select_fileserver() ends the address cursor it is using in the case in
which we get some sort of network error and run out of addresses to iterate
through, before it jumps to try the next server.  This also needs to be
done when the server aborts with some sort of error that means we should
try the next server.

Fix this by:

 (1) Move the iterate_address afs_end_cursor() call to the next_server
     case.

 (2) End the cursor in the failed case.

 (3) Make afs_end_cursor() clear the ->begun flag and ->addr pointer in the
     address cursor.

 (4) Make afs_end_cursor() able to be called on an already cleared cursor.

Without this, something like the following oops may occur:

	AFS: Assertion failed
	18446612134397189888 == 0 is false
	0xffff88007c279f00 == 0x0 is false
	------------[ cut here ]------------
	kernel BUG at fs/afs/rotate.c:360!
	RIP: 0010:afs_select_fileserver+0x79b/0xa30 [kafs]
	Call Trace:
	 afs_statfs+0xcc/0x180 [kafs]
	 ? p9_client_statfs+0x9e/0x110 [9pnet]
	 ? _cond_resched+0x19/0x40
	 statfs_by_dentry+0x6d/0x90
	 vfs_statfs+0x1b/0xc0
	 user_statfs+0x4b/0x80
	 SYSC_statfs+0x15/0x30
	 SyS_statfs+0xe/0x10
	 entry_SYSCALL_64_fastpath+0x20/0x83

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: stable@vger.kernel.org
---

 fs/afs/addr_list.c |   13 ++++++++++---
 fs/afs/rotate.c    |   12 ++++++------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index a537368ba0db..fd9f28b8a933 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -332,11 +332,18 @@ bool afs_iterate_addresses(struct afs_addr_cursor *ac)
  */
 int afs_end_cursor(struct afs_addr_cursor *ac)
 {
-	if (ac->responded && ac->index != ac->start)
-		WRITE_ONCE(ac->alist->index, ac->index);
+	struct afs_addr_list *alist;
+
+	alist = ac->alist;
+	if (alist) {
+		if (ac->responded && ac->index != ac->start)
+			WRITE_ONCE(alist->index, ac->index);
+		afs_put_addrlist(alist);
+	}
 
-	afs_put_addrlist(ac->alist);
+	ac->addr = NULL;
 	ac->alist = NULL;
+	ac->begun = false;
 	return ac->error;
 }
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index d04511fb3879..b473b25c6978 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -334,6 +334,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 
 next_server:
 	_debug("next");
+	afs_end_cursor(&fc->ac);
 	afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
 	fc->cbi = NULL;
 	fc->index++;
@@ -410,16 +411,15 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	/* Iterate over the current server's address list to try and find an
 	 * address on which it will respond to us.
 	 */
-	if (afs_iterate_addresses(&fc->ac)) {
-		_leave(" = t");
-		return true;
-	}
+	if (!afs_iterate_addresses(&fc->ac))
+		goto next_server;
 
-	afs_end_cursor(&fc->ac);
-	goto next_server;
+	_leave(" = t");
+	return true;
 
 failed:
 	fc->flags |= AFS_FS_CURSOR_STOP;
+	afs_end_cursor(&fc->ac);
 	_leave(" = f [failed %d]", fc->ac.error);
 	return false;
 }
