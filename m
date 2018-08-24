Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304ECC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D120666
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io2Otakc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01D120666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeHXT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeHXT6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:58:51 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70B302157C;
        Fri, 24 Aug 2018 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535127809;
        bh=P31b+DPN7NsxK6ZyE5u6BLZQnVKtt0YRPSEZDElIG4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Io2Otakc2+4Vf3YD1nF/V5mibosT9fKtOBCzY/G8C7u9DSni8hr3VVO+D6Xq81+mU
         I9BqGLxLcuKkyy77digkvix1sPDb8IUq6LlZl7qg8wilXSF8uele8fYswc6wZ/2vBA
         WSe4rW8auBQQJGDk7swOYGIJllACNz0hyjDAUzqs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [RFC PATCH 04/10] fs-verity: implement FS_IOC_MEASURE_VERITY ioctl
Date:   Fri, 24 Aug 2018 09:16:36 -0700
Message-Id: <20180824161642.1144-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824161642.1144-1-ebiggers@kernel.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function for filesystems to call to implement the
FS_IOC_MEASURE_VERITY ioctl.  This ioctl retrieves the file measurement
hash that fs-verity calculated for the given file and is enforcing for
reads; i.e., reads that don't match this hash will fail.

This ioctl can be used to implement lightweight auditing or
authentication of file hashes in userspace, as an alternative to an
in-kernel policy such as an IMA policy.

Note that due to fs-verity's use of a Merkle tree, opening a file and
executing this ioctl takes constant time, regardless of the file's size.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/ioctl.c        | 49 ++++++++++++++++++++++++++++++++++++++++
 fs/verity/setup.c        |  4 +++-
 include/linux/fsverity.h |  6 +++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/verity/ioctl.c b/fs/verity/ioctl.c
index 993f2afdcc734..3da9b0f441c13 100644
--- a/fs/verity/ioctl.c
+++ b/fs/verity/ioctl.c
@@ -119,3 +119,52 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *arg)
 	return err;
 }
 EXPORT_SYMBOL_GPL(fsverity_ioctl_enable);
+
+/**
+ * fsverity_ioctl_measure - get a verity file's measurement
+ *
+ * The FS_IOC_MEASURE_VERITY ioctl retrieves the file measurement that the
+ * kernel is enforcing for reads from a verity file.
+ *
+ * No privileges are required to use this ioctl, since it is a read-only
+ * operation on a single regular file.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+int fsverity_ioctl_measure(struct file *filp, void __user *_uarg)
+{
+	const struct inode *inode = file_inode(filp);
+	struct fsverity_digest __user *uarg = _uarg;
+	const struct fsverity_info *vi;
+	const struct fsverity_hash_alg *hash_alg;
+	struct fsverity_digest arg;
+
+	vi = get_fsverity_info(inode);
+	if (!vi)
+		return -ENODATA; /* not a verity file */
+	hash_alg = vi->hash_alg;
+
+	/*
+	 * The user specifies the digest_size their buffer has space for; we can
+	 * return the digest if it fits in the available space.  We write back
+	 * the actual size, which may be shorter than the user-specified size.
+	 */
+
+	if (get_user(arg.digest_size, &uarg->digest_size))
+		return -EFAULT;
+	if (arg.digest_size < hash_alg->digest_size)
+		return -EOVERFLOW;
+
+	memset(&arg, 0, sizeof(arg));
+	arg.digest_algorithm = hash_alg - fsverity_hash_algs;
+	arg.digest_size = hash_alg->digest_size;
+
+	if (copy_to_user(uarg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	if (copy_to_user(uarg->digest, vi->measurement, hash_alg->digest_size))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsverity_ioctl_measure);
diff --git a/fs/verity/setup.c b/fs/verity/setup.c
index 84cc2edeca25b..3f5cb9526dbc9 100644
--- a/fs/verity/setup.c
+++ b/fs/verity/setup.c
@@ -842,7 +842,9 @@ static int __init fsverity_module_init(void)
 		goto error;
 
 	err = -ENOMEM;
-	fsverity_info_cachep = KMEM_CACHE(fsverity_info, SLAB_RECLAIM_ACCOUNT);
+	fsverity_info_cachep = KMEM_CACHE_USERCOPY(fsverity_info,
+						   SLAB_RECLAIM_ACCOUNT,
+						   measurement);
 	if (!fsverity_info_cachep)
 		goto error_free_workqueue;
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index c710b6b5fb4a6..9d3371dbd262f 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -23,6 +23,7 @@ struct fsverity_operations {
 
 /* ioctl.c */
 extern int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
+extern int fsverity_ioctl_measure(struct file *filp, void __user *arg);
 
 /* setup.c */
 extern int fsverity_file_open(struct inode *inode, struct file *filp);
@@ -46,6 +47,11 @@ static inline int fsverity_ioctl_enable(struct file *filp,
 	return -EOPNOTSUPP;
 }
 
+static inline int fsverity_ioctl_measure(struct file *filp, void __user *arg)
+{
+	return -EOPNOTSUPP;
+}
+
 /* setup.c */
 
 static inline int fsverity_file_open(struct inode *inode, struct file *filp)
-- 
2.18.0

