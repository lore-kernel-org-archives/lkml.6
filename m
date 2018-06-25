Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EAFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50E324623
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkoP5nWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C50E324623
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbeFYQei (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:34:38 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:41018 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932758AbeFYQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:34:36 -0400
Received: by mail-qt0-f201.google.com with SMTP id 12-v6so12994445qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 09:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=aXlDQQmpWYao8JR4v1byMs0Gmu296f08HhR0cF1tF3s=;
        b=RkoP5nWMNjOxjhTAaUHxn19piqB0CitLA5MFk+euOJGYYvOnSZ6NZLpSLgiesh9CRG
         m2mVQCNFwFZUjbkbf5kg5iDVwtExkzb6i5VFIlmV2Nrx5l8OCGW6PxsPxsNeHisbr3ti
         ofMH5zPPGJRnaA52a77o5vH6oKuqDTGDaD5eTUin+Ic+YxKz5zNO9vw80OFT8eVDbCQs
         EYtN2khBaDI42YRf8QWuJJJRl2yQlfEM5veT0SD152oAIzrmoVIuMnrm6S9W8svaVJhW
         r4qs8/sK4ICP0avSgGm/yOHErrSfSXxIX+A6qWZE/iUsa2jQR8/POUg+OHJMP9HOUshb
         E2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=aXlDQQmpWYao8JR4v1byMs0Gmu296f08HhR0cF1tF3s=;
        b=nNOaqhYLha3C1ABUL5B+49MFKWmPMod/48th3mOwFigQxp4eqf4609utcCfc4d5dNH
         G9DKdNbKldny/lp/cZGdfbajenzox6BAB3YgQYox/y4CIf0XwMgBVFkJkyQs19YkZWpE
         NYmxWWlWhKBQ9mh3Rm3gzmTOBbmgODP7epGiCR5FEsWtgJGDpg09XVpMU+XPSbTyErfZ
         54o5JsYYrA+QcGlwJkXZz9yLw8hePN2NHnNQrpy235Z4x+cJpzO1d5lqnIUKgLF4gGu7
         Gi+VandCpSIkJrgwkSAhBgknctixHENgUu/Ptn6F03ZPsEaOuMoA3l4zTDAIWeRrQ5Rn
         LGMg==
X-Gm-Message-State: APt69E2tDpI6hnxO62LaVg3fgAP3QJ2xPzfZb5aq3NVxSufHBfW+K3J8
        ONh1+Vjm6AiDsduriTjsXlc8rRvyMQ==
X-Google-Smtp-Source: AAOMgpcahIqYFx1AxLu6kC+mFirPHW7S8+OVbX3fKryqbnoPB2Pdd174FjKf0Iuu4TFWF8uYzHYQzYStyA==
MIME-Version: 1.0
X-Received: by 2002:ac8:13c1:: with SMTP id i1-v6mr7244503qtj.25.1529944475282;
 Mon, 25 Jun 2018 09:34:35 -0700 (PDT)
Date:   Mon, 25 Jun 2018 18:34:25 +0200
Message-Id: <20180625163425.216965-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] selinux: move user accesses in selinuxfs out of locked regions
From:   Jann Horn <jannh@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        jannh@google.com
Cc:     security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 security/selinux/selinuxfs.c | 77 ++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f3d374d2ca04..065f8cea84e3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -445,18 +445,13 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
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
 
 static vm_fault_t sel_mmap_policy_fault(struct vm_fault *vmf)
@@ -1188,25 +1183,29 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
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
@@ -1219,6 +1218,17 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
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
@@ -1233,22 +1243,6 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
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
@@ -1280,6 +1274,17 @@ static ssize_t sel_commit_bools_write(struct file *filep,
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
@@ -1289,22 +1294,6 @@ static ssize_t sel_commit_bools_write(struct file *filep,
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
-- 
2.18.0.rc2.346.g013aa6912e-goog

