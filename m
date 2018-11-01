Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A988C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2628720657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtuV9Aas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2628720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKBIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbeKBH7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:59:17 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263BE20854;
        Thu,  1 Nov 2018 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541112857;
        bh=QPS4+r14xY2PLU7NQtFjdCO+Df3ZTP2DJA3gQxzR+Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtuV9AasuSrml0A8JPztrOq51+O31GY8UFxL1dpwNTLtz5Ja43fuK5UofVxQIsC0w
         AZHrv+NsYXyqX3gyQwUT5ZzP28k5EjfArzA1xPd5GXH3UuPggB5gM+PAUSDpON41Tn
         xolj8djUxEZ/ybxzHhX0aZEpu8Cf0RRvK9a17wDY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH v2 06/12] fs-verity: implement FS_IOC_MEASURE_VERITY ioctl
Date:   Thu,  1 Nov 2018 15:52:24 -0700
Message-Id: <20181101225230.88058-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181101225230.88058-1-ebiggers@kernel.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a function for filesystems to call to implement the
FS_IOC_MEASURE_VERITY ioctl.  This ioctl retrieves the file measurement
hash that fs-verity calculated for the given file and is enforcing for
reads; i.e., reads that don't match this hash will fail.  This ioctl can
be used for logging or authentication of file hashes in userspace.

This ioctl is documented in Documentation/filesystem/fsverity.rst;
see there for more information.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/ioctl.c        | 47 ++++++++++++++++++++++++++++++++++++++++
 fs/verity/setup.c        |  4 +++-
 include/linux/fsverity.h |  6 +++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/verity/ioctl.c b/fs/verity/ioctl.c
index c5f0022cb3bef..640aa78e1c00c 100644
--- a/fs/verity/ioctl.c
+++ b/fs/verity/ioctl.c
@@ -115,3 +115,50 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *arg)
 	return err;
 }
 EXPORT_SYMBOL_GPL(fsverity_ioctl_enable);
+
+/**
+ * fsverity_ioctl_measure - get a verity file's measurement
+ *
+ * Retrieve the file measurement that the kernel is enforcing for reads from a
+ * verity file.  See Documentation/filesystems/fsverity.rst, section
+ * 'FS_IOC_MEASURE_VERITY' for details.
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
index 184bdc96abe51..e0b39c518b890 100644
--- a/fs/verity/setup.c
+++ b/fs/verity/setup.c
@@ -819,7 +819,9 @@ static int __init fsverity_module_init(void)
 		goto error;
 
 	err = -ENOMEM;
-	fsverity_info_cachep = KMEM_CACHE(fsverity_info, SLAB_RECLAIM_ACCOUNT);
+	fsverity_info_cachep = KMEM_CACHE_USERCOPY(fsverity_info,
+						   SLAB_RECLAIM_ACCOUNT,
+						   measurement);
 	if (!fsverity_info_cachep)
 		goto error_free_workqueue;
 
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 5de50b52ccc70..c30c4f6ed411c 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -23,6 +23,7 @@ struct fsverity_operations {
 
 /* ioctl.c */
 extern int fsverity_ioctl_enable(struct file *filp, const void __user *arg);
+extern int fsverity_ioctl_measure(struct file *filp, void __user *arg);
 
 /* setup.c */
 extern int fsverity_file_open(struct inode *inode, struct file *filp);
@@ -51,6 +52,11 @@ static inline int fsverity_ioctl_enable(struct file *filp,
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
2.19.1.568.g152ad8e336-goog

