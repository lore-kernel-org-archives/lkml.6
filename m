Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZoAl29Z8fFAChwQXAjNDzSzdvVDsGm9tTQUIxm9gy+FhNgEHGGl5AV7Yux8FO940OEoA380
ARC-Seal: i=1; a=rsa-sha256; t=1525654574; cv=none;
        d=google.com; s=arc-20160816;
        b=Bw3aXD1+M30CjSSNrINiIqMBGpEgS1ZOxYGLL6lD8rqU0hRWJgx2mKYjyvlI8w4BT+
         f+YT5exqy0fjlf5ZBQELlkdmVNSLUM6Fa0t7sV53vx4NSUOiFv4j6b68ib5jxhhIy3ak
         EGgYZDBFRCmrCZDc4nEAFD5ZMVuM8i4fRNQsSYiNzp0PA2Q1XctnOqWaHiAxmoERBl4v
         DT8DM94s0i8qVNaTXEaWnA727wJIwg/csudIo5iyU/jwfHG2P23IG3GV6q1YO7kBJ8rB
         2tZLzYbkyr+NbAY/PRmBKh199X6iMXtOMLmZ84B6BY+ulUWKytxK9czNZ864DGmK8Qhf
         vAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=HSQ4hSsYbBDVjQsO3CktYH2H/r2cKUs5+swh2GWiRMY=;
        b=BwEOo4TLEfCU6ye3lmmiE5Qo0+Ybc45pkmwck+uxu2t9uuIOBX7tN0cYC+KMUihNQO
         jT9IiK7Jqk40KgdXqtizIzDCCmWU/w/zgKYCi7P5cQGZHe61Q21CebQM7HjibmE+0hmw
         dqzSYhfw9boeoXZEHtudPBUnEiPKAIEH0afrVLzypBGNXgAdzturH4xnIf+a3whR7C4+
         H+llbwGHJ4lV5n86a/iFFMyH30N1mq5MABBSCOpe2EIRggV68OKb97hG+S1UrleobGAu
         f4qxAXl3GMFAvWJl/itMHQYFCA+BAh+5KbMHY+FJNzO+T0ZJWWmPkri6hPxQlCmpHXVd
         /geQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 07 May 2018 10:54:48 +1000
Subject: [PATCH 07/10] staging: lustre: llite: remove redundant lookup in
 dump_pgcache
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152565448820.30131.5319309021208024337.stgit@noble>
In-Reply-To: <152565436690.30131.2229703651041382739.stgit@noble>
References: <152565436690.30131.2229703651041382739.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599764770996554935?=
X-GMAIL-MSGID: =?utf-8?q?1599764770996554935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both the 'next' and the 'show' functions for the dump_page_cache
seqfile perform a lookup based on the current file index.  This is
needless duplication.

The reason appears to be that the state that needs to be communicated
from "next" to "show" is two pointers, but seq_file only provides for
a single pointer to be returned from next and passed to show.

So make use of the new 'seq_private' structure to store the extra
pointer.
So when 'next' (or 'start') find something, it returns the page and
stores the clob in the private area.
'show' accepts the page as an argument, and finds the clob where it
was stored.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/vvp_dev.c |   98 ++++++++++---------------
 1 file changed, 41 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/vvp_dev.c b/drivers/staging/lustre/lustre/llite/vvp_dev.c
index 183ea3d0f336..8bda51fd97a2 100644
--- a/drivers/staging/lustre/lustre/llite/vvp_dev.c
+++ b/drivers/staging/lustre/lustre/llite/vvp_dev.c
@@ -394,6 +394,7 @@ struct seq_private {
 	struct ll_sb_info	*sbi;
 	struct lu_env		*env;
 	u16			refcheck;
+	struct cl_object	*clob;
 };
 
 static void vvp_pgcache_id_unpack(loff_t pos, struct vvp_pgcache_id *id)
@@ -458,19 +459,20 @@ static struct cl_object *vvp_pgcache_obj(const struct lu_env *env,
 	return NULL;
 }
 
-static loff_t vvp_pgcache_find(const struct lu_env *env,
-			       struct lu_device *dev, loff_t pos)
+static struct page *vvp_pgcache_find(const struct lu_env *env,
+				     struct lu_device *dev,
+				     struct cl_object **clobp, loff_t *pos)
 {
 	struct cl_object     *clob;
 	struct lu_site       *site;
 	struct vvp_pgcache_id id;
 
 	site = dev->ld_site;
-	vvp_pgcache_id_unpack(pos, &id);
+	vvp_pgcache_id_unpack(*pos, &id);
 
 	while (1) {
 		if (id.vpi_bucket >= CFS_HASH_NHLIST(site->ls_obj_hash))
-			return ~0ULL;
+			return NULL;
 		clob = vvp_pgcache_obj(env, dev, &id);
 		if (clob) {
 			struct inode *inode = vvp_object_inode(clob);
@@ -482,20 +484,22 @@ static loff_t vvp_pgcache_find(const struct lu_env *env,
 			if (nr > 0) {
 				id.vpi_index = vmpage->index;
 				/* Cant support over 16T file */
-				nr = !(vmpage->index > 0xffffffff);
+				if (vmpage->index <= 0xffffffff) {
+					*clobp = clob;
+					*pos = vvp_pgcache_id_pack(&id);
+					return vmpage;
+				}
 				put_page(vmpage);
 			}
 
 			lu_object_ref_del(&clob->co_lu, "dump", current);
 			cl_object_put(env, clob);
-			if (nr > 0)
-				return vvp_pgcache_id_pack(&id);
 		}
 		/* to the next object. */
 		++id.vpi_depth;
 		id.vpi_depth &= 0xf;
 		if (id.vpi_depth == 0 && ++id.vpi_bucket == 0)
-			return ~0ULL;
+			return NULL;
 		id.vpi_index = 0;
 	}
 }
@@ -538,72 +542,52 @@ static void vvp_pgcache_page_show(const struct lu_env *env,
 static int vvp_pgcache_show(struct seq_file *f, void *v)
 {
 	struct seq_private	*priv = f->private;
-	loff_t		   pos;
-	struct cl_object	*clob;
-	struct vvp_pgcache_id    id;
-
-	pos = *(loff_t *)v;
-	vvp_pgcache_id_unpack(pos, &id);
-	clob = vvp_pgcache_obj(priv->env, &priv->sbi->ll_cl->cd_lu_dev, &id);
-	if (clob) {
-		struct inode *inode = vvp_object_inode(clob);
-		struct cl_page *page = NULL;
-		struct page *vmpage;
-		int result;
-
-		result = find_get_pages_contig(inode->i_mapping,
-					       id.vpi_index, 1,
-					       &vmpage);
-		if (result > 0) {
-			lock_page(vmpage);
-			page = cl_vmpage_page(vmpage, clob);
-			unlock_page(vmpage);
-			put_page(vmpage);
-		}
-
-		seq_printf(f, "%8x@" DFID ": ", id.vpi_index,
-			   PFID(lu_object_fid(&clob->co_lu)));
-		if (page) {
-			vvp_pgcache_page_show(priv->env, f, page);
-			cl_page_put(priv->env, page);
-		} else {
-			seq_puts(f, "missing\n");
-		}
-		lu_object_ref_del(&clob->co_lu, "dump", current);
-		cl_object_put(priv->env, clob);
+	struct page		*vmpage = v;
+	struct cl_page		*page;
+
+	seq_printf(f, "%8lx@" DFID ": ", vmpage->index,
+		   PFID(lu_object_fid(&priv->clob->co_lu)));
+	lock_page(vmpage);
+	page = cl_vmpage_page(vmpage, priv->clob);
+	unlock_page(vmpage);
+	put_page(vmpage);
+
+	if (page) {
+		vvp_pgcache_page_show(priv->env, f, page);
+		cl_page_put(priv->env, page);
 	} else {
-		seq_printf(f, "%llx missing\n", pos);
+		seq_puts(f, "missing\n");
 	}
+	lu_object_ref_del(&priv->clob->co_lu, "dump", current);
+	cl_object_put(priv->env, priv->clob);
+
 	return 0;
 }
 
 static void *vvp_pgcache_start(struct seq_file *f, loff_t *pos)
 {
 	struct seq_private	*priv = f->private;
+	struct page *ret;
 
 	if (priv->sbi->ll_site->ls_obj_hash->hs_cur_bits >
-	    64 - PGC_OBJ_SHIFT) {
-		pos = ERR_PTR(-EFBIG);
-	} else {
-		*pos = vvp_pgcache_find(priv->env, &priv->sbi->ll_cl->cd_lu_dev,
-					*pos);
-		if (*pos == ~0ULL)
-			pos = NULL;
-	}
+	    64 - PGC_OBJ_SHIFT)
+		ret = ERR_PTR(-EFBIG);
+	else
+		ret = vvp_pgcache_find(priv->env, &priv->sbi->ll_cl->cd_lu_dev,
+				       &priv->clob, pos);
 
-	return pos;
+	return ret;
 }
 
 static void *vvp_pgcache_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	struct seq_private *priv = f->private;
+	struct page *ret;
 
-	*pos = vvp_pgcache_find(priv->env, &priv->sbi->ll_cl->cd_lu_dev,
-				*pos + 1);
-	if (*pos == ~0ULL)
-		pos = NULL;
-
-	return pos;
+	*pos += 1;
+	ret = vvp_pgcache_find(priv->env, &priv->sbi->ll_cl->cd_lu_dev,
+			       &priv->clob, pos);
+	return ret;
 }
 
 static void vvp_pgcache_stop(struct seq_file *f, void *v)
