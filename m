Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeFASqg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbeFASqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:46:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: devel@driverdev.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] ncpfs: remove compat functionality
Date: Fri,  1 Jun 2018 20:45:44 +0200
Message-Id: <20180601184547.20213-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180601184547.20213-1-gregkh@linuxfoundation.org>
References: <20180601184547.20213-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ncpfs is gone from the tree, no need to have the compatibility
thunking layer around, it will not actually go anywhere :)

So delete that logic from fs/compat.c, it is no longer needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/compat.c | 72 +----------------------------------------------------
 1 file changed, 1 insertion(+), 71 deletions(-)

diff --git a/fs/compat.c b/fs/compat.c
index 190b38b39d9e..4a0aaaf53217 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -16,79 +16,12 @@
  */
 
 #include <linux/compat.h>
-#include <linux/ncp_mount.h>
 #include <linux/nfs4_mount.h>
 #include <linux/syscalls.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "internal.h"
 
-struct compat_ncp_mount_data {
-	compat_int_t version;
-	compat_uint_t ncp_fd;
-	__compat_uid_t mounted_uid;
-	compat_pid_t wdog_pid;
-	unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
-	compat_uint_t time_out;
-	compat_uint_t retry_count;
-	compat_uint_t flags;
-	__compat_uid_t uid;
-	__compat_gid_t gid;
-	compat_mode_t file_mode;
-	compat_mode_t dir_mode;
-};
-
-struct compat_ncp_mount_data_v4 {
-	compat_int_t version;
-	compat_ulong_t flags;
-	compat_ulong_t mounted_uid;
-	compat_long_t wdog_pid;
-	compat_uint_t ncp_fd;
-	compat_uint_t time_out;
-	compat_uint_t retry_count;
-	compat_ulong_t uid;
-	compat_ulong_t gid;
-	compat_ulong_t file_mode;
-	compat_ulong_t dir_mode;
-};
-
-static void *do_ncp_super_data_conv(void *raw_data)
-{
-	int version = *(unsigned int *)raw_data;
-
-	if (version == 3) {
-		struct compat_ncp_mount_data *c_n = raw_data;
-		struct ncp_mount_data *n = raw_data;
-
-		n->dir_mode = c_n->dir_mode;
-		n->file_mode = c_n->file_mode;
-		n->gid = c_n->gid;
-		n->uid = c_n->uid;
-		memmove (n->mounted_vol, c_n->mounted_vol, (sizeof (c_n->mounted_vol) + 3 * sizeof (unsigned int)));
-		n->wdog_pid = c_n->wdog_pid;
-		n->mounted_uid = c_n->mounted_uid;
-	} else if (version == 4) {
-		struct compat_ncp_mount_data_v4 *c_n = raw_data;
-		struct ncp_mount_data_v4 *n = raw_data;
-
-		n->dir_mode = c_n->dir_mode;
-		n->file_mode = c_n->file_mode;
-		n->gid = c_n->gid;
-		n->uid = c_n->uid;
-		n->retry_count = c_n->retry_count;
-		n->time_out = c_n->time_out;
-		n->ncp_fd = c_n->ncp_fd;
-		n->wdog_pid = c_n->wdog_pid;
-		n->mounted_uid = c_n->mounted_uid;
-		n->flags = c_n->flags;
-	} else if (version != 5) {
-		return NULL;
-	}
-
-	return raw_data;
-}
-
-
 struct compat_nfs_string {
 	compat_uint_t len;
 	compat_uptr_t data;
@@ -154,7 +87,6 @@ static int do_nfs4_super_data_conv(void *raw_data)
 	return 0;
 }
 
-#define NCPFS_NAME      "ncpfs"
 #define NFS4_NAME	"nfs4"
 
 COMPAT_SYSCALL_DEFINE5(mount, const char __user *, dev_name,
@@ -183,9 +115,7 @@ COMPAT_SYSCALL_DEFINE5(mount, const char __user *, dev_name,
 		goto out2;
 
 	if (kernel_type && options) {
-		if (!strcmp(kernel_type, NCPFS_NAME)) {
-			do_ncp_super_data_conv(options);
-		} else if (!strcmp(kernel_type, NFS4_NAME)) {
+		if (!strcmp(kernel_type, NFS4_NAME)) {
 			retval = -EINVAL;
 			if (do_nfs4_super_data_conv(options))
 				goto out3;
-- 
2.17.1
