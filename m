Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3332BC43613
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F872085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="R7PyxDg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfAFOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 09:06:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47031 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfAFOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 09:05:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so35546207edt.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ftKobouv3Xr94oq8McoPtH22MpjL1yw/58eZ8gL10I=;
        b=R7PyxDg3TAsoYZ6zw5gvF01F8dpwHZNLSL780S4wB/mfy4vLzvJN5ZLksNAm1rK39b
         6BtOmoeiuVZhnlVX+af574340wuMYIZU2QKGIly3eHBIG1iPDMT8u1BUMskukrvJ+v+J
         8867e3ZmeVt3bXV/Qnd088bpiCUMq2OuRwiOo68pOKCgWwKnXGg4dF91igrzTGQLD+bj
         WSyhJKvKSVoNdTIFwPV8qwfrYa0zbJ6Z5xb1HrR4zUGTJqt7w8aBwupmHpdv8Ziw8onC
         h9CBqc+cv3aoLlZJhMErnUX3Xi5dZgauhwtLyARouX9bDE7s6y9p0GbUMgPwPc6ja3Fk
         9q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ftKobouv3Xr94oq8McoPtH22MpjL1yw/58eZ8gL10I=;
        b=erdqx1pRwilqC3mJFSaTY31J7BNy9rdTtdoStXQ9rH7WCDChx90zdRIie64Ri9hvZe
         cCLN63NjQuXJhBnM5heVLvga7kuH6yr8ixCN/OKXUf8RBACGNUXf8cDPrfvW58fno8L0
         BMuruI5tMvjifkKMAstHIZYaKM3HjSCdMlj/R4UlCy4NGPUaUWV4wJ4slESctulZINtB
         3o3wPcJH951GMsY/YYDIL/PinSIf/7be21FqDCUx/BRid2sTcluOE5KpoNN1UMwE0ciN
         c1SE9SpOnBqMyBdCRd6Zfy+4zoyBNtMC4nCNixhXVYrtaEDal4hRErQuAoG7rC6XR03Y
         obvA==
X-Gm-Message-State: AA+aEWZGp7ORlFZsRxInMfAsLREZhbNKcPABXfljyebPl3VqAkrwhPfL
        ptky04RRH3IktWJNdFz2W3/Sdw==
X-Google-Smtp-Source: AFSGD/XDMobth7rSSZ+4NkJIkzsVbcaH7xcVBSM6bNiDh6Eli7r0YmTt7jOW9AlqGgoC3+UilFNP9Q==
X-Received: by 2002:a50:b744:: with SMTP id g62mr53661832ede.14.1546783557013;
        Sun, 06 Jan 2019 06:05:57 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id m13sm26984984edd.2.2019.01.06.06.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 06:05:56 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] binderfs: make each binderfs mount a new instance
Date:   Sun,  6 Jan 2019 15:05:41 +0100
Message-Id: <20190106140541.16442-3-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190106140541.16442-1-christian@brauner.io>
References: <20190106140541.16442-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When currently mounting binderfs in the same ipc namespace twice:

mount -t binder binder /A
mount -t binder binder /B

then the binderfs instances mounted on /A and /B will be the same, i.e.
they will have the same superblock. This was the first approach that seemed
reasonable. However, this leads to some problems and inconsistencies:

/* private binderfs instance in same ipc namespace */
There is no way for a user to request a private binderfs instance in the
same ipc namespace.
This request has been made in a private mail to me by two independent
people.

/* bind-mounts */
If users want the same binderfs instance to appear in multiple places they
can use bind mounts. So there is no value in having a request for a new
binderfs mount giving them the same instance.

/* unexpected behavior */
It's surprising that request to mount binderfs is not giving the user a new
instance like tmpfs, devpts, ramfs, and others do.

/* past mistakes */
Other pseudo-filesystems once made the same mistakes of giving back the
same superblock when actually requesting a new mount (cf. devpts's
deprecated "newinstance" option).
We should not make the same mistake. Once we've committed to always giving
back the same superblock in the same IPC namespace with the next kernel
release we will not be able to make that change so better to do it now.

/* kdbusfs */
It was pointed out to me that kdbusfs - which is conceptually closely
related to binderfs - also allowed users to get a private kdbusfs instance
in the same IPC namespace by making each mount of kdbusfs a separate
instance. I think that makes a lot of sense.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 drivers/android/binderfs.c | 41 ++------------------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 6f68d6217eb3..4990d65d4850 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -379,7 +379,7 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	struct binderfs_info *info;
 	int ret = -ENOMEM;
 	struct inode *inode = NULL;
-	struct ipc_namespace *ipc_ns = sb->s_fs_info;
+	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
 
 	get_ipc_ns(ipc_ns);
 
@@ -450,48 +450,11 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	return ret;
 }
 
-static int binderfs_test_super(struct super_block *sb, void *data)
-{
-	struct binderfs_info *info = sb->s_fs_info;
-
-	if (info)
-		return info->ipc_ns == data;
-
-	return 0;
-}
-
-static int binderfs_set_super(struct super_block *sb, void *data)
-{
-	sb->s_fs_info = data;
-	return set_anon_super(sb, NULL);
-}
-
 static struct dentry *binderfs_mount(struct file_system_type *fs_type,
 				     int flags, const char *dev_name,
 				     void *data)
 {
-	struct super_block *sb;
-	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
-
-	if (!ns_capable(ipc_ns->user_ns, CAP_SYS_ADMIN))
-		return ERR_PTR(-EPERM);
-
-	sb = sget_userns(fs_type, binderfs_test_super, binderfs_set_super,
-			 flags, ipc_ns->user_ns, ipc_ns);
-	if (IS_ERR(sb))
-		return ERR_CAST(sb);
-
-	if (!sb->s_root) {
-		int ret = binderfs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
-		if (ret) {
-			deactivate_locked_super(sb);
-			return ERR_PTR(ret);
-		}
-
-		sb->s_flags |= SB_ACTIVE;
-	}
-
-	return dget(sb->s_root);
+	return mount_nodev(fs_type, flags, data, binderfs_fill_super);
 }
 
 static void binderfs_kill_super(struct super_block *sb)
-- 
2.19.1

