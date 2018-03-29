Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbeC2MGh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:06:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752732AbeC2MGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:06:22 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: cluster-devel@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 2/2] gfs2: Stop using rhashtable_walk_peek
Date: Thu, 29 Mar 2018 14:06:12 +0200
Message-Id: <20180329120612.6104-3-agruenba@redhat.com>
In-Reply-To: <20180329120612.6104-1-agruenba@redhat.com>
References: <20180329120612.6104-1-agruenba@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rhashtable_walk_peek is problematic because there is no
guarantee that the glock previously returned still exists; when that key
is deleted, rhashtable_walk_peek can end up returning a different key,
which will cause an inconsistent glock dump.  Fix this by keeping track
of the current glock in the seq file iterator functions instead.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 82fb5583445c..097bd3c0f270 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1923,28 +1923,37 @@ void gfs2_glock_exit(void)
 
 static void gfs2_glock_iter_next(struct gfs2_glock_iter *gi, loff_t n)
 {
-	if (n == 0)
-		gi->gl = rhashtable_walk_peek(&gi->hti);
-	else {
-		gi->gl = rhashtable_walk_next(&gi->hti);
-		n--;
+	struct gfs2_glock *gl = gi->gl;
+
+	if (gl) {
+		if (n == 0)
+			return;
+		if (!lockref_put_not_zero(&gl->gl_lockref))
+			gfs2_glock_queue_put(gl);
 	}
 	for (;;) {
-		if (IS_ERR_OR_NULL(gi->gl)) {
-			if (!gi->gl)
-				return;
-			if (PTR_ERR(gi->gl) != -EAGAIN) {
-				gi->gl = NULL;
-				return;
+		gl = rhashtable_walk_next(&gi->hti);
+		if (IS_ERR_OR_NULL(gl)) {
+			if (gl == ERR_PTR(-EAGAIN)) {
+				n = 1;
+				continue;
 			}
-			n = 0;
-		} else if (gi->sdp == gi->gl->gl_name.ln_sbd &&
-			   !__lockref_is_dead(&gi->gl->gl_lockref)) {
-			if (!n--)
-				break;
+			gl = NULL;
+			break;
+		}
+		if (gl->gl_name.ln_sbd != gi->sdp)
+			continue;
+		if (n <= 1) {
+			if (!lockref_get_not_dead(&gl->gl_lockref))
+				continue;
+			break;
+		} else {
+			if (__lockref_is_dead(&gl->gl_lockref))
+				continue;
+			n--;
 		}
-		gi->gl = rhashtable_walk_next(&gi->hti);
 	}
+	gi->gl = gl;
 }
 
 static void *gfs2_glock_seq_start(struct seq_file *seq, loff_t *pos)
@@ -1988,7 +1997,6 @@ static void gfs2_glock_seq_stop(struct seq_file *seq, void *iter_ptr)
 {
 	struct gfs2_glock_iter *gi = seq->private;
 
-	gi->gl = NULL;
 	rhashtable_walk_stop(&gi->hti);
 }
 
@@ -2076,7 +2084,8 @@ static int gfs2_glocks_release(struct inode *inode, struct file *file)
 	struct seq_file *seq = file->private_data;
 	struct gfs2_glock_iter *gi = seq->private;
 
-	gi->gl = NULL;
+	if (gi->gl)
+		gfs2_glock_put(gi->gl);
 	rhashtable_walk_exit(&gi->hti);
 	return seq_release_private(inode, file);
 }
-- 
2.14.3
