Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115CC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A2E20823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738514;
	bh=Ay/VkHNJ640UtdtvBljFOXHSZ+XUkhF+qdr8DDgRICs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tIiZmt/aCIJ1E6NUiwb5PGqI5yxgGE/5m1WW1OkE4XsuPXXXNipbDNHdNyXamuVHi
	 A85rNi0ckY7+HWwvCHLtYWeuKYD6ymtRj425m1Iz3ox1pIzivIbxgukOQW6Yjs1nPi
	 zDD5e875OmB+enLgxFqyLJ/3XnkEtqSpTQxvLYJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBISzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:55:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfBISsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 071F521919;
        Sat,  9 Feb 2019 18:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738114;
        bh=Ay/VkHNJ640UtdtvBljFOXHSZ+XUkhF+qdr8DDgRICs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRncX8L5He6v5i4hanvY6hk9VGnlpTZUydE0dP+t2p0LaA2RLs2wKgkMm8rYq6r2f
         7Gfb67YX7qOQrXiWXN/y/ctUAEixrYl86SdmjL+VuyneKpdai/8tFzJUa0XRZ5qawo
         5xaO52LSOHZgS6z6j4YntXGDYOypO3jbKKBkeq7Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 41/42] CIFS: Fix error paths in writeback code
Date:   Sat,  9 Feb 2019 13:47:33 -0500
Message-Id: <20190209184734.125935-41-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Shilovsky <pshilov@microsoft.com>

[ Upstream commit 9a66396f1857cc1de06f4f4771797315e1a4ea56 ]

This patch aims to address writeback code problems related to error
paths. In particular it respects EINTR and related error codes and
stores and returns the first error occurred during writeback.

Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h | 19 +++++++++++++++++++
 fs/cifs/cifssmb.c  |  7 ++++---
 fs/cifs/file.c     | 29 +++++++++++++++++++++++------
 fs/cifs/inode.c    | 10 ++++++++++
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 7a4fae0dc566..373639199291 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1563,6 +1563,25 @@ static inline void free_dfs_info_array(struct dfs_info3_param *param,
 	kfree(param);
 }
 
+static inline bool is_interrupt_error(int error)
+{
+	switch (error) {
+	case -EINTR:
+	case -ERESTARTSYS:
+	case -ERESTARTNOHAND:
+	case -ERESTARTNOINTR:
+		return true;
+	}
+	return false;
+}
+
+static inline bool is_retryable_error(int error)
+{
+	if (is_interrupt_error(error) || error == -EAGAIN)
+		return true;
+	return false;
+}
+
 #define   MID_FREE 0
 #define   MID_REQUEST_ALLOCATED 1
 #define   MID_REQUEST_SUBMITTED 2
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index fce610f6cd24..327a101f7894 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2043,7 +2043,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 
 		for (j = 0; j < nr_pages; j++) {
 			unlock_page(wdata2->pages[j]);
-			if (rc != 0 && rc != -EAGAIN) {
+			if (rc != 0 && !is_retryable_error(rc)) {
 				SetPageError(wdata2->pages[j]);
 				end_page_writeback(wdata2->pages[j]);
 				put_page(wdata2->pages[j]);
@@ -2052,7 +2052,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 
 		if (rc) {
 			kref_put(&wdata2->refcount, cifs_writedata_release);
-			if (rc == -EAGAIN)
+			if (is_retryable_error(rc))
 				continue;
 			break;
 		}
@@ -2061,7 +2061,8 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 		i += nr_pages;
 	} while (i < wdata->nr_pages);
 
-	mapping_set_error(inode->i_mapping, rc);
+	if (rc != 0 && !is_retryable_error(rc))
+		mapping_set_error(inode->i_mapping, rc);
 	kref_put(&wdata->refcount, cifs_writedata_release);
 }
 
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 116f8af0384f..c13effbaadba 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -732,7 +732,8 @@ reopen_success:
 
 	if (can_flush) {
 		rc = filemap_write_and_wait(inode->i_mapping);
-		mapping_set_error(inode->i_mapping, rc);
+		if (!is_interrupt_error(rc))
+			mapping_set_error(inode->i_mapping, rc);
 
 		if (tcon->unix_ext)
 			rc = cifs_get_inode_info_unix(&inode, full_path,
@@ -2117,6 +2118,7 @@ static int cifs_writepages(struct address_space *mapping,
 	pgoff_t end, index;
 	struct cifs_writedata *wdata;
 	int rc = 0;
+	int saved_rc = 0;
 	unsigned int xid;
 
 	/*
@@ -2145,8 +2147,10 @@ retry:
 
 		rc = server->ops->wait_mtu_credits(server, cifs_sb->wsize,
 						   &wsize, &credits);
-		if (rc)
+		if (rc != 0) {
+			done = true;
 			break;
+		}
 
 		tofind = min((wsize / PAGE_SIZE) - 1, end - index) + 1;
 
@@ -2154,6 +2158,7 @@ retry:
 						  &found_pages);
 		if (!wdata) {
 			rc = -ENOMEM;
+			done = true;
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
@@ -2182,7 +2187,7 @@ retry:
 		if (rc != 0) {
 			add_credits_and_wake_if(server, wdata->credits, 0);
 			for (i = 0; i < nr_pages; ++i) {
-				if (rc == -EAGAIN)
+				if (is_retryable_error(rc))
 					redirty_page_for_writepage(wbc,
 							   wdata->pages[i]);
 				else
@@ -2190,7 +2195,7 @@ retry:
 				end_page_writeback(wdata->pages[i]);
 				put_page(wdata->pages[i]);
 			}
-			if (rc != -EAGAIN)
+			if (!is_retryable_error(rc))
 				mapping_set_error(mapping, rc);
 		}
 		kref_put(&wdata->refcount, cifs_writedata_release);
@@ -2200,6 +2205,15 @@ retry:
 			continue;
 		}
 
+		/* Return immediately if we received a signal during writing */
+		if (is_interrupt_error(rc)) {
+			done = true;
+			break;
+		}
+
+		if (rc != 0 && saved_rc == 0)
+			saved_rc = rc;
+
 		wbc->nr_to_write -= nr_pages;
 		if (wbc->nr_to_write <= 0)
 			done = true;
@@ -2217,6 +2231,9 @@ retry:
 		goto retry;
 	}
 
+	if (saved_rc != 0)
+		rc = saved_rc;
+
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = index;
 
@@ -2249,8 +2266,8 @@ cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
 	set_page_writeback(page);
 retry_write:
 	rc = cifs_partialpagewrite(page, 0, PAGE_SIZE);
-	if (rc == -EAGAIN) {
-		if (wbc->sync_mode == WB_SYNC_ALL)
+	if (is_retryable_error(rc)) {
+		if (wbc->sync_mode == WB_SYNC_ALL && rc == -EAGAIN)
 			goto retry_write;
 		redirty_page_for_writepage(wbc, page);
 	} else if (rc != 0) {
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index a81a9df997c1..84d51ca91ef7 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2261,6 +2261,11 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	 * the flush returns error?
 	 */
 	rc = filemap_write_and_wait(inode->i_mapping);
+	if (is_interrupt_error(rc)) {
+		rc = -ERESTARTSYS;
+		goto out;
+	}
+
 	mapping_set_error(inode->i_mapping, rc);
 	rc = 0;
 
@@ -2404,6 +2409,11 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	 * the flush returns error?
 	 */
 	rc = filemap_write_and_wait(inode->i_mapping);
+	if (is_interrupt_error(rc)) {
+		rc = -ERESTARTSYS;
+		goto cifs_setattr_exit;
+	}
+
 	mapping_set_error(inode->i_mapping, rc);
 	rc = 0;
 
-- 
2.19.1

