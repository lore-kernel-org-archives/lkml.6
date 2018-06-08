Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sj1HDmzQGltDEwAAmS7hNA
	; Fri, 08 Jun 2018 18:52:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B942607DC; Fri,  8 Jun 2018 18:52:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7B2096074D;
	Fri,  8 Jun 2018 18:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B2096074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932143AbeFHSvn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:51:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53818 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeFHSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:50:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMSq-0006OB-Fn; Fri, 08 Jun 2018 18:50:20 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] IMA: don't propagate opened through the entire thing
Date: Fri,  8 Jun 2018 19:50:16 +0100
Message-Id: <20180608185019.24472-10-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
References: <20180608184842.GD30522@ZenIV.linux.org.uk>
 <20180608185019.24472-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

just check ->f_mode in ima_appraise_measurement()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c                            |  3 +--
 fs/nfsd/vfs.c                         |  2 +-
 include/linux/ima.h                   |  4 ++--
 security/integrity/ima/ima.h          |  4 ++--
 security/integrity/ima/ima_appraise.c |  4 ++--
 security/integrity/ima/ima_main.c     | 16 ++++++++--------
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 592d62a9f549..ce71a69653b1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3366,8 +3366,7 @@ static int do_last(struct nameidata *nd,
 	if (error)
 		goto out;
 opened:
-	error = ima_file_check(file, op->acc_mode,
-				file->f_mode & FMODE_CREATED ? FILE_CREATED : 0);
+	error = ima_file_check(file, op->acc_mode);
 	if (!error && will_truncate)
 		error = handle_truncate(file);
 out:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b0555d7d8200..55a099e47ba2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -763,7 +763,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out_nfserr;
 	}
 
-	host_err = ima_file_check(file, may_flags, 0);
+	host_err = ima_file_check(file, may_flags);
 	if (host_err) {
 		fput(file);
 		goto out_nfserr;
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0e4647e0eb60..d9ba3fc363b7 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,7 +16,7 @@ struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
-extern int ima_file_check(struct file *file, int mask, int opened);
+extern int ima_file_check(struct file *file, int mask);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
@@ -34,7 +34,7 @@ static inline int ima_bprm_check(struct linux_binprm *bprm)
 	return 0;
 }
 
-static inline int ima_file_check(struct file *file, int mask, int opened)
+static inline int ima_file_check(struct file *file, int mask)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 35fe91aa1fc9..2bd42d03910a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -239,7 +239,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, int opened);
+			     int xattr_len);
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -255,7 +255,7 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   struct file *file,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
-					   int xattr_len, int opened)
+					   int xattr_len)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8bd7a0733e51..deec1804a00a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -212,7 +212,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, int opened)
+			     int xattr_len)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -231,7 +231,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 		cause = iint->flags & IMA_DIGSIG_REQUIRED ?
 				"IMA-signature-required" : "missing-hash";
 		status = INTEGRITY_NOLABEL;
-		if (opened & FILE_CREATED)
+		if (file->f_mode & FMODE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
 		if ((iint->flags & IMA_NEW_FILE) &&
 		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 74d0bd7e76d7..1a112389b29c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -173,7 +173,7 @@ void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func, int opened)
+			       enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -299,7 +299,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
-					      xattr_value, xattr_len, opened);
+					      xattr_value, xattr_len);
 		inode_unlock(inode);
 	}
 	if (action & IMA_AUDIT)
@@ -343,7 +343,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK, 0);
+					   0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -369,13 +369,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_task_getsecid(current, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK, 0);
+				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK, 0);
+				   MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -388,14 +388,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_check(struct file *file, int mask, int opened)
+int ima_file_check(struct file *file, int mask)
 {
 	u32 secid;
 
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK, opened);
+					   MAY_APPEND), FILE_CHECK);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
@@ -497,7 +497,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func, 0);
+				   MAY_READ, func);
 }
 
 static int __init init_ima(void)
-- 
2.11.0
