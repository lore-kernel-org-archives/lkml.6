Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFCSvj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 14:51:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54187 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFCSvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 14:51:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'gregkh\@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj\@kernel.org'" <tj@kernel.org>,
        "Okajima\, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm\@aristanetworks.com'" <ebiederm@aristanetworks.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
        <87wovhqex2.fsf@xmission.com>
Date: Sun, 03 Jun 2018 13:51:15 -0500
In-Reply-To: <87wovhqex2.fsf@xmission.com> (Eric W. Biederman's message of
        "Sat, 02 Jun 2018 12:25:13 -0500")
Message-ID: <87po17r9ek.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fPY65-0005B7-Qu;;;mid=<87po17r9ek.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+xC9NmqKJoV5wKOD7pw+6+bPbKnC/e/e8=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15029 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 1.94 (0.0%), parse: 1.34 (0.0%),
        extract_message_metadata: 17 (0.1%), get_uri_detail_list: 5 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.13 (0.0%), tests_pri_-900:
        0.95 (0.0%), tests_pri_-400: 33 (0.2%), check_bayes: 32 (0.2%), b_tokenize:
        14 (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 2.9 (0.0%), b_tok_touch_all:
        3.3 (0.0%), b_finish: 0.64 (0.0%), tests_pri_0: 382 (2.5%),
        check_dkim_signature: 0.57 (0.0%), check_dkim_adsp: 3.2 (0.0%),
        tests_pri_500: 14585 (97.0%), poll_dns_idle: 14577 (97.0%), rewrite_mail:
        0.00 (0.0%)
Subject: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Over the years two bugs have crept into the code that handled the last
returned kernfs directory being deleted, and handled general seeking
in kernfs directories.  The result is that reading the /sys/module
directory while moduled are loading and unloading will sometimes
skip over a module that was present for the entire duration of
the directory read.

The first bug is that kernfs_dir_next_pos was advancing the position
in the directory even when kernfs_dir_pos had found the starting
kernfs directory entry was not usable.  In this case kernfs_dir_pos is
guaranteed to return the directory entry past the starting directory
entry, making it so that advancing the directory position is wrong.

The second bug is that kernfs_dir_pos when the saved kernfs_node
did not validate, was not always returning a directory after
the the target position, but was sometimes returning the directory
entry just before the target position.

To correct these issues and to make the code easily readable and
comprehensible several cleanups are made.

- A function kernfs_dir_next is factored out to make it straight-forward
  to find the next node in a kernfs directory.

- A function kernfs_dir_skip_pos is factored out to skip over directory
  entries that should not be shown to userspace.  This function is called
  from kernfs_fop_readdir directly removing the complication of calling
  it from the other directory advancement functions.

- The kernfs_put of the saved directory entry is moved from kernfs_dir_pos
  to kernfs_fop_readdir.  Keeping it with the kernfs_get when it is saved
  and ensuring the directory position advancment functions can reference
  the saved node without complications.

- The function kernfs_dir_next_pos is modified to only advance the directory
  position in the common case when kernfs_dir_pos validates and returns
  the starting kernfs node.  For all other cases kernfs_dir_pos is guaranteed
  to return a directory position in advance of the starting directory position.

- kernfs_dir_pos is given a significant make over.  It's essense remains the
  same but some siginficant changes were made.

  + The offset is validated to be a valid hash value at the very beginning.
    The validation is updated to handle the fact that neither 0 nor 1 are
    valid hash values.

  + An extra test is added at the end of the rbtree lookup to ensure
    the returned position is at or beyond the target position.

  + kernfs_name_compare is used during the rbtree lookup instead of just comparing
    the hash.  This allows the the passed namespace parameter to be used, and
    if it is available from the saved entry the old saved name as well.

  + The validation of the saved kernfs node now checks for two cases.
    If the saved node is returnable.
    If the name of the saved node is usable during lookup.

In net this should result in a easier to understand, and more correct
version of directory traversal for kernfs directories.

Reported-by: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Fixes: a406f75840e1 ("sysfs: use rb-tree for inode number lookup")
Fixes: 1e5289c97bba ("sysfs: Cache the last sysfs_dirent to improve readdir scalability v2")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Can you test this and please verify it fixes your issue?

 fs/kernfs/dir.c | 109 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc19340b..8148b5fec48d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1584,53 +1584,75 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static struct kernfs_node *kernfs_dir_next(struct kernfs_node *pos)
+{
+	struct rb_node *node = rb_next(&pos->rb);
+	return node ? rb_to_kn(node) : NULL;
+}
+
 static struct kernfs_node *kernfs_dir_pos(const void *ns,
-	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
+	struct kernfs_node *parent, loff_t off, struct kernfs_node *saved)
 {
-	if (pos) {
-		int valid = kernfs_active(pos) &&
-			pos->parent == parent && hash == pos->hash;
-		kernfs_put(pos);
-		if (!valid)
-			pos = NULL;
-	}
-	if (!pos && (hash > 1) && (hash < INT_MAX)) {
-		struct rb_node *node = parent->dir.children.rb_node;
-		while (node) {
-			pos = rb_to_kn(node);
-
-			if (hash < pos->hash)
-				node = node->rb_left;
-			else if (hash > pos->hash)
-				node = node->rb_right;
-			else
-				break;
+	struct kernfs_node *pos;
+	struct rb_node *node;
+	unsigned int hash;
+	const char *name = "";
+
+	/* Is off a valid name hash? */
+	if ((off < 2) || (off >= INT_MAX))
+		return NULL;
+	hash = off;
+
+	/* Is the saved position usable? */
+	if (saved) {
+		/* Proper parent and hash? */
+		if ((parent != saved->parent) || (saved->hash != hash)) {
+			saved = NULL;
+		} else {
+			if (kernfs_active(saved))
+				return saved;
+			name = saved->name;
 		}
 	}
-	/* Skip over entries which are dying/dead or in the wrong namespace */
-	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
-		struct rb_node *node = rb_next(&pos->rb);
-		if (!node)
-			pos = NULL;
+
+	/* Find the closest pos to the hash we are looking for */
+	pos = NULL;
+	node = parent->dir.children.rb_node;
+	while (node) {
+		int result;
+
+		pos = rb_to_kn(node);
+		result = kernfs_name_compare(hash, name, ns, pos);
+		if (result < 0)
+			node = node->rb_left;
+		else if (result > 0)
+			node = node->rb_right;
 		else
-			pos = rb_to_kn(node);
+			break;
 	}
+
+	/* Ensure pos is at or beyond the target position */
+	if (pos && (kernfs_name_compare(hash, name, ns, pos) < 0))
+		pos = kernfs_dir_next(pos);
+
 	return pos;
 }
 
 static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
-	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
+	struct kernfs_node *parent, loff_t off, struct kernfs_node *start)
 {
-	pos = kernfs_dir_pos(ns, parent, ino, pos);
-	if (pos) {
-		do {
-			struct rb_node *node = rb_next(&pos->rb);
-			if (!node)
-				pos = NULL;
-			else
-				pos = rb_to_kn(node);
-		} while (pos && (!kernfs_active(pos) || pos->ns != ns));
-	}
+	struct kernfs_node *pos = kernfs_dir_pos(ns, parent, off, start);
+	if (likely(pos == start))
+		pos = kernfs_dir_next(pos);
+	return pos;
+}
+
+static struct kernfs_node *kernfs_dir_skip_pos(const void *ns,
+					       struct kernfs_node *pos)
+{
+	/* Skip entries we don't want to return to userspace */
+	while (pos && !(kernfs_active(pos) && (pos->ns == ns)))
+		pos = kernfs_dir_next(pos);
 	return pos;
 }
 
@@ -1638,7 +1660,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
-	struct kernfs_node *pos = file->private_data;
+	struct kernfs_node *pos, *saved = file->private_data;
 	const void *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
@@ -1648,23 +1670,26 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
 
-	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
-	     pos;
+	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, saved);
+	     (pos = kernfs_dir_skip_pos(ns, pos));
 	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
 		const char *name = pos->name;
 		unsigned int type = dt_type(pos);
 		int len = strlen(name);
 		ino_t ino = pos->id.ino;
 
-		ctx->pos = pos->hash;
-		file->private_data = pos;
-		kernfs_get(pos);
+		kernfs_put(saved);
+		saved = pos;
+		ctx->pos = saved->hash;
+		file->private_data = saved;
+		kernfs_get(saved);
 
 		mutex_unlock(&kernfs_mutex);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
 		mutex_lock(&kernfs_mutex);
 	}
+	kernfs_put(saved);
 	mutex_unlock(&kernfs_mutex);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
-- 
2.14.1
