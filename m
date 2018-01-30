Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeA3SFg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:05:36 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35709 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbeA3SFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:05:30 -0500
X-Google-Smtp-Source: AH8x224K4tnc4itxgoFoMGepgZg4+cwdlRuIO0mtFCpMoO6s7hsU7PeTeH1dpQNGCeychqG6Z1Y2/A==
From: Dongsu Park <dongsu@kinvolk.io>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Dongsu Park <dongsu@kinvolk.io>, Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag FS_IMA_NO_CACHE
Date: Tue, 30 Jan 2018 19:06:31 +0100
Message-Id: <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1517314847.git.dongsu@kinvolk.io>
References: <cover.1517314847.git.dongsu@kinvolk.io>
In-Reply-To: <cover.1517314847.git.dongsu@kinvolk.io>
References: <cover.1517314847.git.dongsu@kinvolk.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
re-appraised and re-audited each time. Cached integrity results should
not be used.

It is useful in FUSE because the userspace FUSE process can change the
underlying files at any time without notifying the kernel.

Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>
Acked-by: "Serge E. Hallyn" <serge@hallyn.com>
Acked-by: Seth Forshee <seth.forshee@canonical.com>
Tested-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 fs/fuse/inode.c    | 2 +-
 include/linux/fs.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 624f18bb..0a9e5164 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1205,7 +1205,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_IMA_NO_CACHE,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 511fbaab..ced841ba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2075,6 +2075,7 @@ struct file_system_type {
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+#define FS_IMA_NO_CACHE		16	/* Force IMA to re-measure, re-appraise, re-audit files */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
-- 
2.13.6
