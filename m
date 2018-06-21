Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F9C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB1022417
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csxFjey8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB1022417
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933990AbeFUV3M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbeFUV3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1EaM/i1jLGF7+lD9c29vyKvpm+6T4mHOB7ylOLRXdo4=; b=csxFjey8zI5Ni6w6tEyuaEn4z
        L9mYMfOnv0xJShdI5ZzbnxCSngz9171iy1QFPPKvV/El7FzDLbDftphOqirkVH2h6JZnLnAyjLmUw
        bc40Xsh/8nIyXKU37YZ0ZaqXxkvmO5hV763f8jiSPmz39R1g1DT6EEv/0jtn9u80sRcD62MwlJ9GN
        v9psYBHskGfTu7L8Ph6OJEqGxE1nuPxE9ohqdZ/U78DxM9y2WbXAE0zMnVaejBOwt/5S+MAkNq5ct
        TpoCn4oxt1nlw/ehfFlyNS/lyzZdstb5Mf0bN0U6Ga2A2lE5mR39JQZ1zaUxgdPpIOIGd3PLxfTAn
        Wpw6PJULA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78e-0001b2-3G; Thu, 21 Jun 2018 21:29:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 07/26] devpts: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:16 -0700
Message-Id: <20180621212835.5636-8-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc_max() matches what this driver wants to do.  Also removes a
call to ida_pre_get().  We no longer need the protection of the mutex,
so convert pty_count to an atomic_t and remove the mutex entirely.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/devpts/inode.c | 47 +++++++++++++----------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index e072e955ce33..c53814539070 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -46,7 +46,7 @@ static int pty_limit = NR_UNIX98_PTY_DEFAULT;
 static int pty_reserve = NR_UNIX98_PTY_RESERVE;
 static int pty_limit_min;
 static int pty_limit_max = INT_MAX;
-static int pty_count;
+static atomic_t pty_count = ATOMIC_INIT(0);
 
 static struct ctl_table pty_table[] = {
 	{
@@ -93,8 +93,6 @@ static struct ctl_table pty_root_table[] = {
 	{}
 };
 
-static DEFINE_MUTEX(allocated_ptys_lock);
-
 struct pts_mount_opts {
 	int setuid;
 	int setgid;
@@ -533,44 +531,25 @@ static struct file_system_type devpts_fs_type = {
 
 int devpts_new_index(struct pts_fs_info *fsi)
 {
-	int index;
-	int ida_ret;
-
-retry:
-	if (!ida_pre_get(&fsi->allocated_ptys, GFP_KERNEL))
-		return -ENOMEM;
-
-	mutex_lock(&allocated_ptys_lock);
-	if (pty_count >= (pty_limit -
-			  (fsi->mount_opts.reserve ? 0 : pty_reserve))) {
-		mutex_unlock(&allocated_ptys_lock);
-		return -ENOSPC;
-	}
+	int index = -ENOSPC;
 
-	ida_ret = ida_get_new(&fsi->allocated_ptys, &index);
-	if (ida_ret < 0) {
-		mutex_unlock(&allocated_ptys_lock);
-		if (ida_ret == -EAGAIN)
-			goto retry;
-		return -EIO;
-	}
+	if (atomic_inc_return(&pty_count) >= (pty_limit -
+			  (fsi->mount_opts.reserve ? 0 : pty_reserve)))
+		goto out;
 
-	if (index >= fsi->mount_opts.max) {
-		ida_remove(&fsi->allocated_ptys, index);
-		mutex_unlock(&allocated_ptys_lock);
-		return -ENOSPC;
-	}
-	pty_count++;
-	mutex_unlock(&allocated_ptys_lock);
+	index = ida_alloc_max(&fsi->allocated_ptys, fsi->mount_opts.max - 1,
+			GFP_KERNEL);
+
+out:
+	if (index < 0)
+		atomic_dec(&pty_count);
 	return index;
 }
 
 void devpts_kill_index(struct pts_fs_info *fsi, int idx)
 {
-	mutex_lock(&allocated_ptys_lock);
-	ida_remove(&fsi->allocated_ptys, idx);
-	pty_count--;
-	mutex_unlock(&allocated_ptys_lock);
+	ida_free(&fsi->allocated_ptys, idx);
+	atomic_dec(&pty_count);
 }
 
 /**
-- 
2.17.1

