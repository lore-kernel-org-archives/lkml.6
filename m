Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeC1QAO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 12:00:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751976AbeC1QAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 12:00:13 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cluster-devel@redhat.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Subject: [PATCH] gfs2: Stop using rhashtable_walk_peek
Date: Wed, 28 Mar 2018 18:00:09 +0200
Message-Id: <20180328160009.29633-1-agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rhashtable_walk_peek is problematic because there is no
guarantee that the glock previously returned still exists; when that key
is deleted, rhashtable_walk_peek can end up returning a different key,
which would cause an inconsistent glock dump.  So instead of using
rhashtable_walk_peek, keep track of the current glock in the seq file
iterator functions.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 82fb5583445c..f1fc353875d3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -55,6 +55,7 @@ struct gfs2_glock_iter {
 	struct gfs2_sbd *sdp;		/* incore superblock           */
 	struct rhashtable_iter hti;	/* rhashtable iterator         */
 	struct gfs2_glock *gl;		/* current glock struct        */
+	bool gl_held;
 	loff_t last_pos;		/* last position               */
 };
 
@@ -1923,9 +1924,11 @@ void gfs2_glock_exit(void)
 
 static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
 {
-	if (n == 0)
-		gi->gl = rhashtable_walk_peek(&gi->hti);
-	else {
+	if (n != 0 || !gi->gl) {
+		if (gi->gl_held) {
+			gfs2_glock_queue_put(gi->gl);
+			gi->gl_held = false;
+		}
 		gi->gl = rhashtable_walk_next(&gi->hti);
 		n--;
 	}
@@ -1988,7 +1991,10 @@ static void gfs2_glock_seq_stop(struct seq_file *seq, void *iter_ptr)
 {
 	struct gfs2_glock_iter *gi = seq->private;
 
-	gi->gl = NULL;
+	if (gi->gl) {
+		lockref_get(&gi->gl->gl_lockref);
+		gi->gl_held = true;
+	}
 	rhashtable_walk_stop(&gi->hti);
 }
 
@@ -2061,6 +2067,7 @@ static int __gfs2_glocks_open(struct inode *inode, struct file *file,
 		 */
 		gi->last_pos = -1;
 		gi->gl = NULL;
+		gi->gl_held = false;
 		rhashtable_walk_enter(&gl_hash_table, &gi->hti);
 	}
 	return ret;
@@ -2076,7 +2083,8 @@ static int gfs2_glocks_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct gfs2_glock_iter *gi = seq->private;
 
-	gi->gl = NULL;
+	if (gi->gl_held)
+		gfs2_glock_put(gi->gl);
 	rhashtable_walk_exit(&gi->hti);
 	return seq_release_private(inode, file);
 }
-- 
2.14.3
