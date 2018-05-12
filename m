Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeELG53 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 02:57:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34138 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeELG52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 02:57:28 -0400
X-Google-Smtp-Source: AB8JxZqo3jllWyfiFIZJbLtQ7X+h34aZQa9t9uSKilnq1kDsmPaqurQleO45WK0PAK/2cTJMhJLB2w==
Date: Fri, 11 May 2018 23:57:24 -0700
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] pstore: Convert internal records to timespec64
Message-ID: <20180512065724.GA19716@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares pstore for converting the VFS layer to timespec64.

Cc: Deepa Dinamani <deepa.kernel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c      | 3 ++-
 fs/pstore/platform.c   | 2 +-
 include/linux/pstore.h | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 5fcb845b9fec..75afe5eb0574 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -392,7 +392,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	inode->i_private = private;
 
 	if (record->time.tv_sec)
-		inode->i_mtime = inode->i_ctime = record->time;
+		inode->i_mtime = inode->i_ctime =
+			timespec64_to_timespec(record->time);
 
 	d_add(dentry, inode);
 
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index dc720573fd53..c238ab8ba31d 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -328,7 +328,7 @@ void pstore_record_init(struct pstore_record *record,
 	record->psi = psinfo;
 
 	/* Report zeroed timestamp if called before timekeeping has resumed. */
-	record->time = ns_to_timespec(ktime_get_real_fast_ns());
+	record->time = ns_to_timespec64(ktime_get_real_fast_ns());
 }
 
 /*
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 61f806a7fe29..a15bc4d48752 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -71,7 +71,7 @@ struct pstore_record {
 	struct pstore_info	*psi;
 	enum pstore_type_id	type;
 	u64			id;
-	struct timespec		time;
+	struct timespec64	time;
 	char			*buf;
 	ssize_t			size;
 	ssize_t			ecc_notice_size;
-- 
2.17.0


-- 
Kees Cook
Pixel Security
