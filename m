Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA9DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33892087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33892087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeH1Rhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:37:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeH1Rhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:37:45 -0400
Received: from localhost (unknown [104.153.224.167])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 52710EC7;
        Tue, 28 Aug 2018 13:46:00 +0000 (UTC)
Date:   Tue, 28 Aug 2018 15:45:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.4.153
Message-ID: <20180828134546.GB9535@kroah.com>
References: <20180828134540.GA9535@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828134540.GA9535@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 523b0d4354fb..208a813be615 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 4
 PATCHLEVEL = 4
-SUBLEVEL = 152
+SUBLEVEL = 153
 EXTRAVERSION =
 NAME = Blurry Fish Butt
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index effc12767cbf..d8d19fe99e45 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -109,8 +109,7 @@ static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
 	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
-	init_new_context_ldt(tsk, mm);
-	return 0;
+	return init_new_context_ldt(tsk, mm);
 }
 static inline void destroy_context(struct mm_struct *mm)
 {
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 27610c2d1821..1007fa80f5a6 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1006,7 +1006,7 @@ static int populate_pmd(struct cpa_data *cpa,
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn >> PAGE_SHIFT,
 					canon_pgprot(pmd_pgprot))));
 
 		start	  += PMD_SIZE;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c319d5eaabcf..28316b292b8a 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -163,6 +163,7 @@ extern const struct file_operations ovl_dir_operations;
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list);
 void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list);
 void ovl_cache_free(struct list_head *list);
+int ovl_check_d_type_supported(struct path *realpath);
 
 /* inode.c */
 int ovl_setattr(struct dentry *dentry, struct iattr *attr);
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 299a6e1d6b77..0c59955c4653 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -43,6 +43,7 @@ struct ovl_readdir_data {
 	struct ovl_cache_entry *first_maybe_whiteout;
 	int count;
 	int err;
+	bool d_type_supported;
 };
 
 struct ovl_dir_file {
@@ -581,3 +582,39 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
 	}
 	mutex_unlock(&upper->d_inode->i_mutex);
 }
+
+static int ovl_check_d_type(struct dir_context *ctx, const char *name,
+			  int namelen, loff_t offset, u64 ino,
+			  unsigned int d_type)
+{
+	struct ovl_readdir_data *rdd =
+		container_of(ctx, struct ovl_readdir_data, ctx);
+
+	/* Even if d_type is not supported, DT_DIR is returned for . and .. */
+	if (!strncmp(name, ".", namelen) || !strncmp(name, "..", namelen))
+		return 0;
+
+	if (d_type != DT_UNKNOWN)
+		rdd->d_type_supported = true;
+
+	return 0;
+}
+
+/*
+ * Returns 1 if d_type is supported, 0 not supported/unknown. Negative values
+ * if error is encountered.
+ */
+int ovl_check_d_type_supported(struct path *realpath)
+{
+	int err;
+	struct ovl_readdir_data rdd = {
+		.ctx.actor = ovl_check_d_type,
+		.d_type_supported = false,
+	};
+
+	err = ovl_dir_read(realpath, &rdd);
+	if (err)
+		return err;
+
+	return rdd.d_type_supported;
+}
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index d70208c0de84..0035cb80ecd1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1054,6 +1054,26 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 			sb->s_flags |= MS_RDONLY;
 			ufs->workdir = NULL;
 		}
+
+		/*
+		 * Upper should support d_type, else whiteouts are visible.
+		 * Given workdir and upper are on same fs, we can do
+		 * iterate_dir() on workdir. This check requires successful
+		 * creation of workdir in previous step.
+		 */
+		if (ufs->workdir) {
+			err = ovl_check_d_type_supported(&workpath);
+			if (err < 0)
+				goto out_put_workdir;
+
+			/*
+			 * We allowed this configuration and don't want to
+			 * break users over kernel upgrade. So warn instead
+			 * of erroring out.
+			 */
+			if (!err)
+				pr_warn("overlayfs: upper fs needs to support d_type.\n");
+		}
 	}
 
 	err = -ENOMEM;
