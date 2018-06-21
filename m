Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D09C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F8722439
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OCxuKWyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F8722439
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933825AbeFUVfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:35:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933919AbeFUV3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jX4Y14/+hUoeY3uBNX8+NURE5Dtq1h279x5XpbFxCXo=; b=OCxuKWyjKv7IMO+zmnWFL4RyW
        O67gRciw66T1kwHuhUOb7ax3BdVCnCl5w771PjrjNYlI+N22awCn4lxLmeH9lYuIXqxJeOhkfKrjI
        5e6HczhgOb+zO/HGjUjgmLrzapQ7VKkuVY73FhdVeIDm/EkpKrJt+ggMuYgEzYGmfjEkQ/AHow3Nj
        Zg9KM1qtzrkgymqy2uGpB75QUVVQWAUCBj/Txk8gbwl3onK4o3t1I4hKT5SJEFlliyTxn9h/oENCm
        DuV5KzoYYi2rJapxrmTA/l9lB3WDtp0dbI5cq7OGKHaMm9iuNQE7UU0D53GzYIuKhcMMRw2FBdpjT
        SMdXUWBCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78c-0001al-A8; Thu, 21 Jun 2018 21:29:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/26] fs: Convert unnamed_dev_ida to new API
Date:   Thu, 21 Jun 2018 14:28:14 -0700
Message-Id: <20180621212835.5636-6-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new API is much easier for this user.  Also add kerneldoc for
get_anon_bdev().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/super.c | 63 +++++++++++++++++++-----------------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 50728d9c1a05..3e7a0aea716a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -978,58 +978,42 @@ void emergency_thaw_all(void)
 	}
 }
 
-/*
- * Unnamed block devices are dummy devices used by virtual
- * filesystems which don't use real block-devices.  -- jrs
- */
-
 static DEFINE_IDA(unnamed_dev_ida);
-static DEFINE_SPINLOCK(unnamed_dev_lock);/* protects the above */
-/* Many userspace utilities consider an FSID of 0 invalid.
- * Always return at least 1 from get_anon_bdev.
- */
-static int unnamed_dev_start = 1;
 
+/**
+ * get_anon_bdev - Allocate a block device for filesystems which don't have one.
+ * @p: Pointer to a dev_t.
+ *
+ * Filesystems which don't use real block devices can call this function
+ * to allocate a virtual block device.
+ *
+ * Context: Any context.  Frequently called while holding sb_lock.
+ * Return: 0 on success, -EMFILE if there are no anonymous bdevs left
+ * or -EAGAIN if memory allocation failed.
+ */
 int get_anon_bdev(dev_t *p)
 {
 	int dev;
-	int error;
 
- retry:
-	if (ida_pre_get(&unnamed_dev_ida, GFP_ATOMIC) == 0)
-		return -ENOMEM;
-	spin_lock(&unnamed_dev_lock);
-	error = ida_get_new_above(&unnamed_dev_ida, unnamed_dev_start, &dev);
-	if (!error)
-		unnamed_dev_start = dev + 1;
-	spin_unlock(&unnamed_dev_lock);
-	if (error == -EAGAIN)
-		/* We raced and lost with another CPU. */
-		goto retry;
-	else if (error)
+	/*
+	 * Many userspace utilities consider an FSID of 0 invalid.
+	 * Always return at least 1 from get_anon_bdev.
+	 */
+	dev = ida_alloc_range(&unnamed_dev_ida, 1, (1 << MINORBITS) - 1,
+			GFP_ATOMIC);
+	if (dev == -ENOSPC)
+		return -EMFILE;
+	if (dev < 0)
 		return -EAGAIN;
 
-	if (dev >= (1 << MINORBITS)) {
-		spin_lock(&unnamed_dev_lock);
-		ida_remove(&unnamed_dev_ida, dev);
-		if (unnamed_dev_start > dev)
-			unnamed_dev_start = dev;
-		spin_unlock(&unnamed_dev_lock);
-		return -EMFILE;
-	}
-	*p = MKDEV(0, dev & MINORMASK);
+	*p = MKDEV(0, dev);
 	return 0;
 }
 EXPORT_SYMBOL(get_anon_bdev);
 
 void free_anon_bdev(dev_t dev)
 {
-	int slot = MINOR(dev);
-	spin_lock(&unnamed_dev_lock);
-	ida_remove(&unnamed_dev_ida, slot);
-	if (slot < unnamed_dev_start)
-		unnamed_dev_start = slot;
-	spin_unlock(&unnamed_dev_lock);
+	ida_free(&unnamed_dev_ida, MINOR(dev));
 }
 EXPORT_SYMBOL(free_anon_bdev);
 
@@ -1037,7 +1021,6 @@ int set_anon_super(struct super_block *s, void *data)
 {
 	return get_anon_bdev(&s->s_dev);
 }
-
 EXPORT_SYMBOL(set_anon_super);
 
 void kill_anon_super(struct super_block *sb)
@@ -1046,7 +1029,6 @@ void kill_anon_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	free_anon_bdev(dev);
 }
-
 EXPORT_SYMBOL(kill_anon_super);
 
 void kill_litter_super(struct super_block *sb)
@@ -1055,7 +1037,6 @@ void kill_litter_super(struct super_block *sb)
 		d_genocide(sb->s_root);
 	kill_anon_super(sb);
 }
-
 EXPORT_SYMBOL(kill_litter_super);
 
 static int ns_test_super(struct super_block *sb, void *data)
-- 
2.17.1

