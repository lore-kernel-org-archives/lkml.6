Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeBHQQ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:16:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752277AbeBHQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:16:25 -0500
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/7] afs: Need to clear responded flag in addr cursor
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 16:16:23 +0000
Message-ID: <151810658377.20070.11605004826309952797.stgit@warthog.procyon.org.uk>
In-Reply-To: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
References: <151810656463.20070.1477473037254016718.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In afs_select_fileserver(), we need to clear the ->responded flag in the
address list when reusing it.  We should also clear it in
afs_select_current_fileserver().

To this end, just memset() the object before initialising it.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: stable@vger.kernel.org
---

 fs/afs/rotate.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index b473b25c6978..892a4904fd77 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -384,6 +384,7 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	afs_get_addrlist(alist);
 	read_unlock(&server->fs_lock);
 
+	memset(&fc->ac, 0, sizeof(fc->ac));
 
 	/* Probe the current fileserver if we haven't done so yet. */
 	if (!test_bit(AFS_SERVER_FL_PROBED, &server->flags)) {
@@ -398,11 +399,8 @@ bool afs_select_fileserver(struct afs_fs_cursor *fc)
 	else
 		afs_put_addrlist(alist);
 
-	fc->ac.addr  = NULL;
 	fc->ac.start = READ_ONCE(alist->index);
 	fc->ac.index = fc->ac.start;
-	fc->ac.error = 0;
-	fc->ac.begun = false;
 	goto iterate_address;
 
 iterate_address:
@@ -458,12 +456,10 @@ bool afs_select_current_fileserver(struct afs_fs_cursor *fc)
 			return false;
 		}
 
+		memset(&fc->ac, 0, sizeof(fc->ac));
 		fc->ac.alist = alist;
-		fc->ac.addr  = NULL;
 		fc->ac.start = READ_ONCE(alist->index);
 		fc->ac.index = fc->ac.start;
-		fc->ac.error = 0;
-		fc->ac.begun = false;
 		goto iterate_address;
 
 	case 0:
