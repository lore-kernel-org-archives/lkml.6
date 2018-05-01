Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AB8JxZpM+wISO7Z0qbIYOd/YXr9cH6xMgYNqHOY0fj/llrj2Wnd2U3Z0O4EhjNR/rhVTwFzRjwGQ
ARC-Seal: i=1; a=rsa-sha256; t=1525146835; cv=none;
        d=google.com; s=arc-20160816;
        b=Yn/nP0y87X9ng8PpgPEnG0jbhS0Qlfg99A5+5296SlJ3dlj07sPkL9T5qDejzh2l5n
         GbTIEHuulsMoGQNyb0d8PGNrL2EWr9p8shZFzofz4aVYU2C52OfmuW2Mx06CiMYyqMWE
         2FlAzH4zyg4V9xK/FGawu4owgXs+yHuliy+ZQK7WJUFxPQpC7zFAZc016/Vc+6lxpUim
         n1/drwHRoZx7MpX627Xwgf8Yzka7PLBI3Goegxspg9X9F8uxkVotgv+1KkypKkLnxiO9
         NxKJbps1Js9ASmnhDfUrdpWiTMMVIA3JJ5EQbgT2r9qr6ENE9x55qAETAjbmAnG77pRT
         wk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=JLk68CIxaXnIn4aW5OhGugz2n7n4xpBEbqbjP29sgIM=;
        b=ooNczTqh4oiY3bq0fggS75d/OSSsyQdlrf6c20DoiBThRQbsKPY1XrgWZP84oivJ37
         jtl/F7CVmg7QZm6wG/Qs39K6K1drCy3cO4iaduyTfM2VNOtYnei5ugI+NtJFr2CTSCeG
         qFilEZoVCfgi7ZfZ9GvJvDWVuL6g2LmuJG+Rz/Wctt3dq/WYYvP9XAorRQMGefiIXAlv
         HHw8EGZtT8nbJpf+jcg2ESK1cC6GNetOCUMjfyWk8FG0gKU5mQNa6NuFnyfhjI/asVKI
         E1L2Sogs3YzS+TRm59Ll9NQ1Lj+a7TfpzgDl+mQeAQ8rNfhFNM9Zo5r55cuckThfmCy9
         +5gg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Tue, 01 May 2018 13:52:39 +1000
Subject: [PATCH 07/10] staging: lustre: llite: remove redundant lookup in
 dump_pgcache
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152514675907.17843.14660576666864158117.stgit@noble>
In-Reply-To: <152514658325.17843.11455067361317157487.stgit@noble>
References: <152514658325.17843.11455067361317157487.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599232368112343376?=
X-GMAIL-MSGID: =?utf-8?q?1599232368112343376?=
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
 drivers/staging/lustre/lustre/llite/vvp_dev.c |   97 +++++++++++--------------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/vvp_dev.c b/drivers/staging/lustre/lustre/llite/vvp_dev.c
index a2619dc04a7f..39a85e967368 100644
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
@@ -538,71 +542,52 @@ static void vvp_pgcache_page_show(const struct lu_env *env,
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
 
-	*pos = vvp_pgcache_find(priv->env, &priv->sbi->ll_cl->cd_lu_dev, *pos + 1);
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
