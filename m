Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeBHQQu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752426AbeBHQQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:44 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 6/7] afs: Rearrange afs_select_fileserver() a little
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:43 +0000
Message-ID: <151810660313.20070.10337698103466727210.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange afs_select_fileserver() a little to put the use_server chunk
before the next_server chunk so that with the removal of a couple of gotos
the main path through the function is all one sequence.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/rotate.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index cfe0931e7844..ad1328d85526 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -330,27 +330,6 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 
 	if (!afs_start_fs_iteration(fc, vnode))
 		goto failed;
-	goto use_server;
-
-next_server:
-	_debug("next");
-	afs_end_cursor(&fc->ac);
-	afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
-	fc->cbi = NULL;
-	fc->index++;
-	if (fc->index >= fc->server_list->nr_servers)
-		fc->index = 0;
-	if (fc->index != fc->start)
-		goto use_server;
-
-	/* That's all the servers poked to no good effect.  Try again if some
-	 * of them were busy.
-	 */
-	if (fc->flags & AFS_FS_CURSOR_VBUSY)
-		goto restart_from_beginning;
-
-	fc->ac.error = -EDESTADDRREQ;
-	goto failed;
 
 use_server:
 	_debug("use");
@@ -401,7 +380,6 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 
 	fc->ac.start = READ_ONCE(alist->index);
 	fc->ac.index = fc->ac.start;
-	goto iterate_address;
 
 iterate_address:
 	ASSERT(fc->ac.alist);
@@ -415,6 +393,26 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	_leave(" = t");
 	return true;
 
+next_server:
+	_debug("next");
+	afs_end_cursor(&fc->ac);
+	afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
+	fc->cbi = NULL;
+	fc->index++;
+	if (fc->index >= fc->server_list->nr_servers)
+		fc->index = 0;
+	if (fc->index != fc->start)
+		goto use_server;
+
+	/* That's all the servers poked to no good effect.  Try again if some
+	 * of them were busy.
+	 */
+	if (fc->flags & AFS_FS_CURSOR_VBUSY)
+		goto restart_from_beginning;
+
+	fc->ac.error = -EDESTADDRREQ;
+	goto failed;
+
 failed:
 	fc->flags |= AFS_FS_CURSOR_STOP;
 	afs_end_cursor(&fc->ac);
