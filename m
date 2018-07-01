Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B86C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CA025439
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CA025439
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032544AbeGAQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:46:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbeGAQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:46:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97177ACC;
        Sun,  1 Jul 2018 16:46:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.17 215/220] selinux: move user accesses in selinuxfs out of locked regions
Date:   Sun,  1 Jul 2018 18:23:59 +0200
Message-Id: <20180701160917.128390570@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 0da74120c5341389b97c4ee27487a97224999ee1 upstream.

If a user is accessing a file in selinuxfs with a pointer to a userspace
buffer that is backed by e.g. a userfaultfd, the userspace access can
stall indefinitely, which can block fsi->mutex if it is held.

For sel_read_policy(), remove the locking, since this method doesn't seem
to access anything that requires locking.

For sel_read_bool(), move the user access below the locked region.

For sel_write_bool() and sel_commit_bools_write(), move the user access
up above the locked region.

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
[PM: removed an unused variable in sel_read_policy()]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/selinuxfs.c |   78 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -435,22 +435,16 @@ static int sel_release_policy(struct ino
 static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 	int ret;
 
-	mutex_lock(&fsi->mutex);
-
 	ret = avc_has_perm(&selinux_state,
 			   current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (ret)
-		goto out;
+		return ret;
 
-	ret = simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
-out:
-	mutex_unlock(&fsi->mutex);
-	return ret;
+	return simple_read_from_buffer(buf, count, ppos, plm->data, plm->len);
 }
 
 static int sel_mmap_policy_fault(struct vm_fault *vmf)
@@ -1182,25 +1176,29 @@ static ssize_t sel_read_bool(struct file
 	ret = -EINVAL;
 	if (index >= fsi->bool_num || strcmp(name,
 					     fsi->bool_pending_names[index]))
-		goto out;
+		goto out_unlock;
 
 	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
-		goto out;
+		goto out_unlock;
 
 	cur_enforcing = security_get_bool_value(fsi->state, index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
-		goto out;
+		goto out_unlock;
 	}
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
 			  fsi->bool_pending_values[index]);
-	ret = simple_read_from_buffer(buf, count, ppos, page, length);
-out:
 	mutex_unlock(&fsi->mutex);
+	ret = simple_read_from_buffer(buf, count, ppos, page, length);
+out_free:
 	free_page((unsigned long)page);
 	return ret;
+
+out_unlock:
+	mutex_unlock(&fsi->mutex);
+	goto out_free;
 }
 
 static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
@@ -1213,6 +1211,17 @@ static ssize_t sel_write_bool(struct fil
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -1227,22 +1236,6 @@ static ssize_t sel_write_bool(struct fil
 					     fsi->bool_pending_names[index]))
 		goto out;
 
-	length = -ENOMEM;
-	if (count >= PAGE_SIZE)
-		goto out;
-
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page)) {
-		length = PTR_ERR(page);
-		page = NULL;
-		goto out;
-	}
-
 	length = -EINVAL;
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
@@ -1274,6 +1267,17 @@ static ssize_t sel_commit_bools_write(st
 	ssize_t length;
 	int new_value;
 
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
 	mutex_lock(&fsi->mutex);
 
 	length = avc_has_perm(&selinux_state,
@@ -1283,22 +1287,6 @@ static ssize_t sel_commit_bools_write(st
 	if (length)
 		goto out;
 
-	length = -ENOMEM;
-	if (count >= PAGE_SIZE)
-		goto out;
-
-	/* No partial writes. */
-	length = -EINVAL;
-	if (*ppos != 0)
-		goto out;
-
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page)) {
-		length = PTR_ERR(page);
-		page = NULL;
-		goto out;
-	}
-
 	length = -EINVAL;
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;


