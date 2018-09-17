Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA783ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A842147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Y3LKUTup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A842147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeIRBkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44165 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIRBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id d131-v6so9708346qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cB+35A/7ZQ46TKL7ut14HnfM4ymxRMTCzupJyIEHGgo=;
        b=Y3LKUTupet3ME6w/ALRJfxyt6cVSqhku5s32SnA0PwEyLwiz25xqjSLY9ZPrNSzMf5
         MyRByYjQLW928ETalvNdoiCvj/DcmiwLhT3ruAQu5faSEN1nbnX8T3KlTObIK613oRQm
         F3wBYIizXTc5G+fgmKJ2fzs9oWWIZzTxclU7H4x7CyseZ/05YOK/ZrE5jhrX0LdrecbK
         4HqmLHeF5hawHD/rMdPL6nY45eMWI59sWusQNm7H4ySVLEblS56YkojCrZf9YeclnHtK
         WAAqI8E6BpJg3l4UlxS+uXQldgBBmAYDHwvtuz7vi85LK6Zxp7Mo3gQ20xBwf1Blk7Dz
         A4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cB+35A/7ZQ46TKL7ut14HnfM4ymxRMTCzupJyIEHGgo=;
        b=LNbjJgR0ehbFbbHxQy8iu2Cigb5Xad0ME5oJBWgMcBhXZQO863Z5+ecX/iuIVXzElW
         X2evsqU+rOOhIExKYu3MwbIIc1GlDtZz1ciFF5OgjCIgsorDLBax5FDlYuCrZ3IwNgaK
         h/TY+d/7IwO8Lo0l8v5PAnNnrinewaZOyYBku64NwuvtXjmpqAwO6B1AEdpX4cxmWEzZ
         6SBeXXiD79jUCyyOSon6RgC4B1iiiMW5PD/L/0IFW0l6xudc/QCJk3hNrq1+b5xaGAlM
         DjQYJJCr43d70yuUGpAl81nPKNIAHqiJQpf+THH2fHHBc6dgIpW21hjdrPPS6AxFRD7V
         sqAg==
X-Gm-Message-State: APzg51Ai4r/AipNSMj7GTf2AbHvSxbJFRGFU6a/6JgVnp1rTrULxGG7x
        iln/770OKjqMMSMFDgFMXtije0nF+WM=
X-Google-Smtp-Source: ANB0VdY3fYxkerd9V5a8jDH5E0GnlMXgVp3LFrcWcucbQZMLhENnIg1VJUxjDZTPkqf3PW0hquWDyw==
X-Received: by 2002:a37:84c4:: with SMTP id g187-v6mr18609728qkd.49.1537215072313;
        Mon, 17 Sep 2018 13:11:12 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:11 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 01/17] orangefs: implement xattr cache
Date:   Mon, 17 Sep 2018 20:10:38 +0000
Message-Id: <20180917201054.3530-2-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses the same timeout as the getattr cache.  This substantially
increases performance when writing files with smaller buffer sizes.

When writing, the size is (often) changed, which causes a call to
notify_change which calls security_inode_need_killpriv which needs a
getxattr.  Caching it reduces traffic to the server.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c           |   1 +
 fs/orangefs/orangefs-kernel.h |  10 ++++
 fs/orangefs/super.c           |   9 +++
 fs/orangefs/xattr.c           | 104 ++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 31932879b716..a7a8d3647ffe 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -367,6 +367,7 @@ static int orangefs_set_inode(struct inode *inode, void *data)
 	struct orangefs_object_kref *ref = (struct orangefs_object_kref *) data;
 	ORANGEFS_I(inode)->refn.fs_id = ref->fs_id;
 	ORANGEFS_I(inode)->refn.khandle = ref->khandle;
+	hash_init(ORANGEFS_I(inode)->xattr_cache);
 	return 0;
 }
 
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 17b24ad6b264..0c76b8899fd1 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -193,6 +193,8 @@ struct orangefs_inode_s {
 
 	unsigned long getattr_time;
 	u32 getattr_mask;
+
+	DECLARE_HASHTABLE(xattr_cache, 4);
 };
 
 /* per superblock private orangefs info */
@@ -217,6 +219,14 @@ struct orangefs_stats {
 	unsigned long writes;
 };
 
+struct orangefs_cached_xattr {
+	struct hlist_node node;
+	char key[ORANGEFS_MAX_XATTR_NAMELEN];
+	char val[ORANGEFS_MAX_XATTR_VALUELEN];
+	ssize_t length;
+	unsigned long timeout;
+};
+
 extern struct orangefs_stats orangefs_stats;
 
 /*
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index dfaee90d30bd..4c36481208f5 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -128,6 +128,15 @@ static void orangefs_i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
+	struct orangefs_cached_xattr *cx;
+	struct hlist_node *tmp;
+	int i;
+
+	hash_for_each_safe(orangefs_inode->xattr_cache, i, tmp, cx, node) {
+		hlist_del(&cx->node);
+		kfree(cx);
+	}
+
 	kmem_cache_free(orangefs_inode_cache, orangefs_inode);
 }
 
diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 03bcb871544d..998c3563bcdd 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * (C) 2001 Clemson University and The University of Chicago
+ * Copyright 2018 Omnibond Systems, L.L.C.
  *
  * See COPYING in top-level directory.
  */
@@ -50,6 +51,35 @@ static inline int convert_to_internal_xattr_flags(int setxattr_flags)
 	return internal_flag;
 }
 
+static unsigned int xattr_key(const char *key)
+{
+	unsigned int i = 0;
+	while (key)
+		i += *key++;
+	return i % 16;
+}
+
+static struct orangefs_cached_xattr *find_cached_xattr(struct inode *inode,
+    const char *key)
+{
+	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
+	struct orangefs_cached_xattr *cx;
+	struct hlist_head *h;
+	struct hlist_node *tmp;
+	h = &orangefs_inode->xattr_cache[xattr_key(key)];
+	if (hlist_empty(h))
+		return NULL;
+	hlist_for_each_entry_safe(cx, tmp, h, node) {
+/*		if (!time_before(jiffies, cx->timeout)) {
+			hlist_del(&cx->node);
+			kfree(cx);
+			continue;
+		}*/
+		if (!strcmp(cx->key, key))
+			return cx;
+	}
+	return NULL;
+}
 
 /*
  * Tries to get a specified key's attributes of a given
@@ -65,6 +95,7 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, const char *name,
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op = NULL;
+	struct orangefs_cached_xattr *cx;
 	ssize_t ret = -ENOMEM;
 	ssize_t length = 0;
 	int fsuid;
@@ -93,6 +124,27 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, const char *name,
 
 	down_read(&orangefs_inode->xattr_sem);
 
+	cx = find_cached_xattr(inode, name);
+	if (cx && time_before(jiffies, cx->timeout)) {
+		if (cx->length == -1) {
+			ret = -ENODATA;
+			goto out_unlock;
+		} else {
+			if (size == 0) {
+				ret = cx->length;
+				goto out_unlock;
+			}
+			if (cx->length > size) {
+				ret = -ERANGE;
+				goto out_unlock;
+			}
+			memcpy(buffer, cx->val, cx->length);
+			memset(buffer + cx->length, 0, size - cx->length);
+			ret = cx->length;
+			goto out_unlock;
+		}
+	}
+
 	new_op = op_alloc(ORANGEFS_VFS_OP_GETXATTR);
 	if (!new_op)
 		goto out_unlock;
@@ -117,6 +169,15 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, const char *name,
 				     " does not exist!\n",
 				     get_khandle_from_ino(inode),
 				     (char *)new_op->upcall.req.getxattr.key);
+			cx = kmalloc(sizeof *cx, GFP_KERNEL);
+			if (cx) {
+				strcpy(cx->key, name);
+				cx->length = -1;
+				cx->timeout = jiffies +
+				    orangefs_getattr_timeout_msecs*HZ/1000;
+				hash_add(orangefs_inode->xattr_cache, &cx->node,
+				    xattr_key(cx->key));
+			}
 		}
 		goto out_release_op;
 	}
@@ -156,6 +217,23 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, const char *name,
 
 	ret = length;
 
+	if (cx) {
+		strcpy(cx->key, name);
+		memcpy(cx->val, buffer, length);
+		cx->length = length;
+		cx->timeout = jiffies + HZ;
+	} else {
+		cx = kmalloc(sizeof *cx, GFP_KERNEL);
+		if (cx) {
+			strcpy(cx->key, name);
+			memcpy(cx->val, buffer, length);
+			cx->length = length;
+			cx->timeout = jiffies + HZ;
+			hash_add(orangefs_inode->xattr_cache, &cx->node,
+			    xattr_key(cx->key));
+		}
+	}
+
 out_release_op:
 	op_release(new_op);
 out_unlock:
@@ -168,6 +246,9 @@ static int orangefs_inode_removexattr(struct inode *inode, const char *name,
 {
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op = NULL;
+	struct orangefs_cached_xattr *cx;
+	struct hlist_head *h;
+	struct hlist_node *tmp;
 	int ret = -ENOMEM;
 
 	if (strlen(name) >= ORANGEFS_MAX_XATTR_NAMELEN)
@@ -209,6 +290,16 @@ static int orangefs_inode_removexattr(struct inode *inode, const char *name,
 		     "orangefs_inode_removexattr: returning %d\n", ret);
 
 	op_release(new_op);
+
+	h = &orangefs_inode->xattr_cache[xattr_key(name)];
+	hlist_for_each_entry_safe(cx, tmp, h, node) {
+		if (!strcmp(cx->key, name)) {
+			hlist_del(&cx->node);
+			kfree(cx);
+			break;
+		}
+	}
+
 out_unlock:
 	up_write(&orangefs_inode->xattr_sem);
 	return ret;
@@ -226,6 +317,9 @@ int orangefs_inode_setxattr(struct inode *inode, const char *name,
 	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
 	struct orangefs_kernel_op_s *new_op;
 	int internal_flag = 0;
+	struct orangefs_cached_xattr *cx;
+	struct hlist_head *h;
+	struct hlist_node *tmp;
 	int ret = -ENOMEM;
 
 	gossip_debug(GOSSIP_XATTR_DEBUG,
@@ -287,6 +381,16 @@ int orangefs_inode_setxattr(struct inode *inode, const char *name,
 
 	/* when request is serviced properly, free req op struct */
 	op_release(new_op);
+
+	h = &orangefs_inode->xattr_cache[xattr_key(name)];
+	hlist_for_each_entry_safe(cx, tmp, h, node) {
+		if (!strcmp(cx->key, name)) {
+			hlist_del(&cx->node);
+			kfree(cx);
+			break;
+		}
+	}
+
 out_unlock:
 	up_write(&orangefs_inode->xattr_sem);
 	return ret;
-- 
2.19.0

