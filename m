Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4343C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97720855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfAQVe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:34:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:42674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbfAQVe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:34:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DECBBAD05;
        Thu, 17 Jan 2019 21:34:23 +0000 (UTC)
Date:   Thu, 17 Jan 2019 15:34:21 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ignaz Forster <iforster@suse.de>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2] ima: define ima_post_create_tmpfile() hook and add
 missing call
Message-ID: <20190117213421.ggasuc263dpqh46c@merlin>
References: <1545158873.4206.86.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545158873.4206.86.camel@linux.ibm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:47 18/12, Mimi Zohar wrote:
> If tmpfiles can be made persistent, then newly created tmpfiles need to
> be treated like any other new files in policy.
> 
> This patch indicates which newly created tmpfiles are in policy, causing
> the file hash to be calculated on __fput().

Discussed in overlayfs, this would be better if we use this on inode
and called from vfs_tmpfile() instead of do_tmpfile(). This will cover
the overlayfs case which uses tmpfiles while performing copy_up().
The patch is attached.

Here is the updated patch which works for my cases.
However, it is the the failure case after setting the IMA flags
I am concerned about, though I don't think that should be as harmful.


If tmpfiles can be made persistent, then newly created tmpfiles need to
be treated like any other new files in policy.

This patch indicates which newly created tmpfiles are in policy, causing
the file hash to be calculated on __fput().

Reported-by: Ignaz Forster <ignaz.forster@gmx.de>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/namei.c                        |  1 +
 include/linux/ima.h               |  6 ++++++
 security/integrity/ima/ima_main.c | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 914178cdbe94..373a7ec4b09d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3462,6 +3462,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
+	ima_post_create_tmpfile(inode);
 	return child;
 
 out_err:
diff --git a/include/linux/ima.h b/include/linux/ima.h
index b5e16b8c50b7..32b0c5bdcd99 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -18,6 +18,7 @@ struct linux_binprm;
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
+extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id);
@@ -56,6 +57,11 @@ static inline int ima_file_check(struct file *file, int mask)
 	return 0;
 }
 
+static inline void ima_post_create_tmpfile(struct inode *inode)
+{
+	return;
+}
+
 static inline void ima_file_free(struct file *file)
 {
 	return;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 4ffac4f5c647..357edd140c09 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -396,6 +396,33 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
+/**
+ * ima_post_create_tmpfile - mark newly created tmpfile as new
+ * @file : newly created tmpfile
+ *
+ * No measuring, appraising or auditing of newly created tmpfiles is needed.
+ * Skip calling process_measurement(), but indicate which newly, created
+ * tmpfiles are in policy.
+ */
+void ima_post_create_tmpfile(struct inode *inode)
+{
+	struct integrity_iint_cache *iint;
+	int must_appraise;
+
+	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	if (!must_appraise)
+		return;
+
+	/* Nothing to do if we can't allocate memory */
+	iint = integrity_inode_get(inode);
+	if (!iint)
+		return;
+
+	/* needed for writing the security xattrs */
+	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
+	iint->ima_file_status = INTEGRITY_PASS;
+}
+
 /**
  * ima_post_path_mknod - mark as a new inode
  * @dentry: newly created dentry
@@ -413,9 +440,13 @@ void ima_post_path_mknod(struct dentry *dentry)
 	if (!must_appraise)
 		return;
 
+	/* Nothing to do if we can't allocate memory */
 	iint = integrity_inode_get(inode);
-	if (iint)
-		iint->flags |= IMA_NEW_FILE;
+	if (!iint)
+		return;
+
+	/* needed for re-opening empty files */
+	iint->flags |= IMA_NEW_FILE;
 }
 
 /**
-- 
2.16.4
