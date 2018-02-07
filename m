Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeBGPok (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:44:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40522 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754546AbeBGPnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:43:53 -0500
X-Google-Smtp-Source: AH8x226UpBjFiv0bQZ/0uIy7hiuDq8M0LDCbaGzSAyVyr1h2ds9HlQGt1Ej31QuDPRLQ0GZwIsdxag==
From: Dongsu Park <dongsu@kinvolk.io>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alban Crequy <alban@kinvolk.io>, Dongsu Park <dongsu@kinvolk.io>
Subject: [RFC PATCH v5 1/2] ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE
Date: Wed,  7 Feb 2018 16:45:12 +0100
Message-Id: <9b3794980f61bdb5d5f92fe0ae620491be857a8a.1517999503.git.dongsu@kinvolk.io>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1517999503.git.dongsu@kinvolk.io>
References: <cover.1517999503.git.dongsu@kinvolk.io>
In-Reply-To: <cover.1517999503.git.dongsu@kinvolk.io>
References: <cover.1517999503.git.dongsu@kinvolk.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

This patch forces files to be re-measured, re-appraised and re-audited
on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
cached integrity results won't be used.

Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <jmorris@namei.org>
Cc: Christoph Hellwig <hch@infradead.org>
Acked-by: "Serge E. Hallyn" <serge@hallyn.com>
Acked-by: Seth Forshee <seth.forshee@canonical.com>
Tested-by: Dongsu Park <dongsu@kinvolk.io>
Signed-off-by: Alban Crequy <alban@kinvolk.io>
Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
---
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6d78cb26..83edbad8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
+#include <linux/fs.h>
 
 #include "ima.h"
 
@@ -228,9 +229,19 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
 				 IMA_ACTION_FLAGS);
 
-	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
-		/* reset all flags if ima_inode_setxattr was called */
+	/*
+	 * Reset the measure, appraise and audit cached flags either if:
+	 * - ima_inode_setxattr was called, or
+	 * - based on filesystem feature flag
+	 * forcing the file to be re-evaluated.
+	 */
+	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags)) {
 		iint->flags &= ~IMA_DONE_MASK;
+	} else if (inode->i_sb->s_type->fs_flags & FS_IMA_NO_CACHE) {
+		iint->flags &= ~IMA_DONE_MASK;
+		if (action & IMA_MEASURE)
+			iint->measured_pcrs = 0;
+	}
 
 	/* Determine if already appraised/measured based on bitmask
 	 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
-- 
2.13.6
