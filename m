Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA32C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A031721019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548239299;
	bh=oGKPYHpcbJXci++J8slbBpiwzHCkK1Q3LxNER7lCuXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lPXNN0ZElVRXIA2KRZjPE01o0tqUq1vhgUda+HC0pk/daV8xgmOhkFKWB0tPE1WzV
	 ZNaUimC1EaUYtzIhiAEO2IACCM9Mj7x3kPyXJqxhtSjtIIrpujylVIcbosdjUl8Bwk
	 AHLvIh6nZQNNXXs3Q5g8g4pP5cNKMpm27/ugsK6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfAWK2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAWK2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:28:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2592920861;
        Wed, 23 Jan 2019 10:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548239296;
        bh=oGKPYHpcbJXci++J8slbBpiwzHCkK1Q3LxNER7lCuXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U277tSYxxlcWoL25dwwHsDNvQ8zjCTl6aA6Eww+XrzqNzwyQEEWDu2nXujCYfhlwb
         0sT4WFph/5c3KkmhssLul7FINv4aLo8C0+fP97qYsPzxIAI9xvmriug/+gJCLXOFPV
         zhd6pxosOQMKBcTIeta5/8JQ0JhbsfqP3vbkfeXo=
Date:   Wed, 23 Jan 2019 11:28:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123102814.GB17123@kroah.com>
References: <20190123102702.GA17123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123102702.GA17123@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an error happens, debugfs should return an error pointer value, not
NULL.  This will prevent the totally theoretical error where a debugfs
call fails due to lack of memory, returning NULL, and that dentry value
is then passed to another debugfs call, which would end up succeeding,
creating a file at the root of the debugfs tree, but would then be
impossible to remove (because you can not remove the directory NULL).

So, to make everyone happy, always return errors, this makes the users
of debugfs much simpler (they do not have to ever check the return
value), and everyone can rest easy.

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Reported-by: Gary R Hook <ghook@amd.com>
Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/inode.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 41ef452c1fcf..b16f8035b1af 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
  * @parent: a pointer to the parent dentry of the file.
  *
  * This function will return a pointer to a dentry if it succeeds.  If the file
- * doesn't exist or an error occurs, %NULL will be returned.  The returned
- * dentry must be passed to dput() when it is no longer needed.
+ * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
+ * returned dentry must be passed to dput() when it is no longer needed.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	struct dentry *dentry;
 
 	if (IS_ERR(parent))
-		return NULL;
+		return parent;
 
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
 	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 	if (!d_really_is_positive(dentry)) {
 		dput(dentry);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	return dentry;
 }
@@ -324,7 +324,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
 	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 static struct dentry *end_creating(struct dentry *dentry)
@@ -347,7 +347,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	dentry = start_creating(name, parent);
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -386,7 +386,8 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -464,7 +465,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -495,7 +497,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the file is
  * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, %NULL will be returned.
+ * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
+ * returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -506,7 +509,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -545,7 +548,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
-		return NULL;
+		return dentry;
 
 	inode = debugfs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
@@ -581,8 +584,8 @@ EXPORT_SYMBOL(debugfs_create_automount);
  * This function will return a pointer to a dentry if it succeeds.  This
  * pointer must be passed to the debugfs_remove() function when the symbolic
  * link is to be removed (no automatic cleanup happens if your module is
- * unloaded, you are responsible here.)  If an error occurs, %NULL will be
- * returned.
+ * unloaded, you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR)
+ * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
@@ -594,12 +597,12 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 	struct inode *inode;
 	char *link = kstrdup(target, GFP_KERNEL);
 	if (!link)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	dentry = start_creating(name, parent);
 	if (IS_ERR(dentry)) {
 		kfree(link);
-		return NULL;
+		return dentry;
 	}
 
 	inode = debugfs_get_inode(dentry->d_sb);
@@ -827,7 +830,9 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 	if (dentry && !IS_ERR(dentry))
 		dput(dentry);
 	unlock_rename(new_dir, old_dir);
-	return NULL;
+	if (IS_ERR(dentry))
+		return dentry;
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(debugfs_rename);
 
-- 
2.20.1

