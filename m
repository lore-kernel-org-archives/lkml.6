Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED6BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B04208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B04208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeGIE6i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:58:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38086 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754413AbeGIEyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:54:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOBm-0003fA-Qe; Mon, 09 Jul 2018 04:54:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 11/27] IMA: don't propagate opened through the entire thing
Date:   Mon,  9 Jul 2018 05:54:01 +0100
Message-Id: <20180709045417.13988-11-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
References: <20180709045320.GF30522@ZenIV.linux.org.uk>
 <20180709045417.13988-1-viro@ZenIV.linux.org.uk>
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
index 955a28a62f78..5e3eefca676a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3400,8 +3400,7 @@ static int do_last(struct nameidata *nd,
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
index 354bb5716ce3..e4c1a236976c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -238,7 +238,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, int opened);
+			     int xattr_len);
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
@@ -254,7 +254,7 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
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
index dca44cf7838e..b286f37712d5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -168,7 +168,7 @@ void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func, int opened)
+			       enum ima_hooks func)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -294,7 +294,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
-					      xattr_value, xattr_len, opened);
+					      xattr_value, xattr_len);
 		inode_unlock(inode);
 	}
 	if (action & IMA_AUDIT)
@@ -338,7 +338,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK, 0);
+					   0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -364,13 +364,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 
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
@@ -383,14 +383,14 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
 
@@ -493,7 +493,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func, 0);
+				   MAY_READ, func);
 }
 
 static int __init init_ima(void)
-- 
2.11.0

