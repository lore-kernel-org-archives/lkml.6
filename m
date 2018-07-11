Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62BEC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939F7208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939F7208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbeGKCYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45550 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbeGKCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4lb-0003IR-9G; Wed, 11 Jul 2018 02:22:07 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [RFC][PATCH 12/42] ->file_open(): lose cred argument
Date:   Wed, 11 Jul 2018 03:21:36 +0100
Message-Id: <20180711022206.12571-12-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/lsm_hooks.h  | 2 +-
 security/apparmor/lsm.c    | 4 ++--
 security/security.c        | 2 +-
 security/selinux/hooks.c   | 4 ++--
 security/smack/smack_lsm.c | 6 +++---
 security/tomoyo/tomoyo.c   | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..a8ee106b865d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1569,7 +1569,7 @@ union security_list_options {
 	int (*file_send_sigiotask)(struct task_struct *tsk,
 					struct fown_struct *fown, int sig);
 	int (*file_receive)(struct file *file);
-	int (*file_open)(struct file *file, const struct cred *cred);
+	int (*file_open)(struct file *file);
 
 	int (*task_alloc)(struct task_struct *task, unsigned long clone_flags);
 	void (*task_free)(struct task_struct *task);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 74f17376202b..8b8b70620bbe 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -395,7 +395,7 @@ static int apparmor_inode_getattr(const struct path *path)
 	return common_perm_cond(OP_GETATTR, path, AA_MAY_GETATTR);
 }
 
-static int apparmor_file_open(struct file *file, const struct cred *cred)
+static int apparmor_file_open(struct file *file)
 {
 	struct aa_file_ctx *fctx = file_ctx(file);
 	struct aa_label *label;
@@ -414,7 +414,7 @@ static int apparmor_file_open(struct file *file, const struct cred *cred)
 		return 0;
 	}
 
-	label = aa_get_newest_cred_label(cred);
+	label = aa_get_newest_cred_label(file->f_cred);
 	if (!unconfined(label)) {
 		struct inode *inode = file_inode(file);
 		struct path_cond cond = { inode->i_uid, inode->i_mode };
diff --git a/security/security.c b/security/security.c
index 235b35f58a65..5dce67070cdf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -974,7 +974,7 @@ int security_file_open(struct file *file)
 {
 	int ret;
 
-	ret = call_int_hook(file_open, 0, file, file->f_cred);
+	ret = call_int_hook(file_open, 0, file);
 	if (ret)
 		return ret;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2b5ee5fbd652..18006be15713 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3862,7 +3862,7 @@ static int selinux_file_receive(struct file *file)
 	return file_has_perm(cred, file, file_to_av(file));
 }
 
-static int selinux_file_open(struct file *file, const struct cred *cred)
+static int selinux_file_open(struct file *file)
 {
 	struct file_security_struct *fsec;
 	struct inode_security_struct *isec;
@@ -3886,7 +3886,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	 * new inode label or new policy.
 	 * This check is not redundant - do not remove.
 	 */
-	return file_path_has_perm(cred, file, open_file_to_av(file));
+	return file_path_has_perm(file->f_cred, file, open_file_to_av(file));
 }
 
 /* task security operations */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 7ad226018f51..e7b6c012431d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1927,9 +1927,9 @@ static int smack_file_receive(struct file *file)
  *
  * Returns 0
  */
-static int smack_file_open(struct file *file, const struct cred *cred)
+static int smack_file_open(struct file *file)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = file->f_cred->security;
 	struct inode *inode = file_inode(file);
 	struct smk_audit_info ad;
 	int rc;
@@ -1937,7 +1937,7 @@ static int smack_file_open(struct file *file, const struct cred *cred)
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
-	rc = smk_bu_credfile(cred, file, MAY_READ, rc);
+	rc = smk_bu_credfile(file->f_cred, file, MAY_READ, rc);
 
 	return rc;
 }
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..9f932e2d6852 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -320,7 +320,7 @@ static int tomoyo_file_fcntl(struct file *file, unsigned int cmd,
  *
  * Returns 0 on success, negative value otherwise.
  */
-static int tomoyo_file_open(struct file *f, const struct cred *cred)
+static int tomoyo_file_open(struct file *f)
 {
 	int flags = f->f_flags;
 	/* Don't check read permission here if called from do_execve(). */
-- 
2.11.0

