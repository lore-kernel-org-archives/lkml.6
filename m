Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeFBRZf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:25:35 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33505 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFBRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:25:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
Cc: "'gregkh\@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj\@kernel.org'" <tj@kernel.org>,
        "Okajima\, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm\@aristanetworks.com'" <ebiederm@aristanetworks.com>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
Date: Sat, 02 Jun 2018 12:25:13 -0500
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03> (Daisuke
        Hatayama's message of "Mon, 28 May 2018 12:54:03 +0000")
Message-ID: <87wovhqex2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fPAHF-0002an-Mt;;;mid=<87wovhqex2.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19sJDixpRqbrovotgauskCt1ZK8HgEo2rY=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4895]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Hatayama\, Daisuke" <d.hatayama@jp.fujitsu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15026 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.97 (0.0%), parse: 0.87 (0.0%),
        extract_message_metadata: 11 (0.1%), get_uri_detail_list: 2.6 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.17 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 26 (0.2%), check_bayes: 25 (0.2%), b_tokenize:
        10 (0.1%), b_tok_get_all: 8 (0.1%), b_comp_prob: 2.3 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.59 (0.0%), tests_pri_0: 266 (1.8%),
        check_dkim_signature: 0.59 (0.0%), check_dkim_adsp: 3.1 (0.0%),
        tests_pri_500: 14712 (97.9%), poll_dns_idle: 14698 (97.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> writes:

> kernfs_dir_next_pos() overlooks the situation that the dentry
> corresponding to a given pos object has already been inactive. Hence,
> when kernfs_dir_pos() returns the dentry with a hash value larger than
> the original one, kernfs_dir_next_pos() returns the dentry next to the
> one returned by kernfs_dir_pos(). As a result, the dentry returned by
> kernfs_dir_pos() is skipped.
>
> To fix this issue, try to find a next node only when the returned
> object is less than or equal to the original one.
>
> Note that this implementation focuses on getting guarantee that the
> existing nodes are never skipped, not interested in the other nodes
> that are added or removed during the process.
>
> We found this issue during a stress test that repeatedly reads
> /sys/module directory to get a list of the currently loaded kernel
> modules while repeatedly loading and unloading kernel modules
> simultaneously.
>
> v2: Fix the case where nodes with the same hash but with the name
>     larger than the original node could still be skipped. Use
>     kernfs_sd_compare() to compare kernfs_node objects. Imporove patch
>     description.
>

Semantically this looks like the right fix.

The deep bug is that kernfs_dir_pos can always advance the position,
and the code has never looked for or handled that case.  AKA just the
rbtree walk is enough to advance the position.

That said your implementation is buggy.  It is not safe to call
kernfs_sd_compare on orig as kernfs_put has already been called on orig
and thus orig may already be free.

I suggest moving the kernfs_put for orig into kernfs_fop_readdir,
just before the mutex_unlock calls.  That makes your kernfs_sd_compare
safe.

That would then allow moving the code to skip the next entry to also
be vmoed into kernfs_fop_readir.

Perhaps something like this:

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 89d1dc19340b..2d0f71ffb539 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1584,13 +1584,12 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static struct kernfs_node *kernfs_dir_pos(const void *ns,
+static struct kernfs_node *kernfs_dir_pos(
 	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
 {
 	if (pos) {
 		int valid = kernfs_active(pos) &&
 			pos->parent == parent && hash == pos->hash;
-		kernfs_put(pos);
 		if (!valid)
 			pos = NULL;
 	}
@@ -1607,8 +1606,14 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 				break;
 		}
 	}
-	/* Skip over entries which are dying/dead or in the wrong namespace */
-	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
+	return pos;
+}
+
+static struct kernfs_node *kernfs_dir_next_pos(
+	struct kernfs_node *parent, ino_t ino, struct kernfs_node *start)
+{
+	struct kernfs_node *pos = kernfs_dir_pos(parent, ino, start);
+	if (pos && (kernfs_sd_compare(pos, start) <= 0)) {
 		struct rb_node *node = rb_next(&pos->rb);
 		if (!node)
 			pos = NULL;
@@ -1618,27 +1623,11 @@ static struct kernfs_node *kernfs_dir_pos(const void *ns,
 	return pos;
 }
 
-static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
-	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
-{
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
-	return pos;
-}
-
 static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct kernfs_node *parent = kernfs_dentry_node(dentry);
-	struct kernfs_node *pos = file->private_data;
+	struct kernfs_node *pos, *saved = file->private_data;
 	const void *ns = NULL;
 
 	if (!dir_emit_dots(file, ctx))
@@ -1648,23 +1637,30 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
 
-	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
+	for (pos = kernfs_dir_pos(parent, ctx->pos, saved);
 	     pos;
-	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
+	     pos = kernfs_dir_next_pos(parent, ctx->pos, pos)) {
 		const char *name = pos->name;
 		unsigned int type = dt_type(pos);
 		int len = strlen(name);
 		ino_t ino = pos->id.ino;
 
-		ctx->pos = pos->hash;
-		file->private_data = pos;
-		kernfs_get(pos);
+		/* Skip entries not fit for userspace */
+		if (!kernfs_active(pos) || !(pos->ns != ns))
+			continue;
+
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
