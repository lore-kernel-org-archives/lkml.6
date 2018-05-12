Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeELFBZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:01:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36739 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeELFBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:01:20 -0400
X-Google-Smtp-Source: AB8JxZrYcvLDTFYD/NoTQ1KYLD2i66I0gtXcigNxSgOvlDFr4EEAXSrCElBXwvOwiq9EK831EBwq5A==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        andreas.dilger@intel.com
Subject: [PATCH 2/6] lustre: Use long long type to print inode time
Date: Fri, 11 May 2018 21:59:17 -0700
Message-Id: <20180512045921.18311-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches in the series convert inode timestamps
to use struct timespec64 instead of struct timespec as
part of solving the y2038 problem.

Convert these print formats to use long long types to
avoid warnings and errors on conversion.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
CC: andreas.dilger@intel.com
---
 drivers/staging/lustre/lustre/llite/llite_lib.c | 12 +++++++-----
 drivers/staging/lustre/lustre/lmv/lmv_obd.c     |  7 ++++---
 drivers/staging/lustre/lustre/mdc/mdc_reint.c   |  6 +++---
 drivers/staging/lustre/lustre/obdclass/obdo.c   |  6 +++---
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index 60dbe888e336..dc31966bbf3c 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -1482,8 +1482,9 @@ int ll_setattr_raw(struct dentry *dentry, struct iattr *attr, bool hsm_import)
 	}
 
 	if (attr->ia_valid & (ATTR_MTIME | ATTR_CTIME))
-		CDEBUG(D_INODE, "setting mtime %lu, ctime %lu, now = %llu\n",
-		       LTIME_S(attr->ia_mtime), LTIME_S(attr->ia_ctime),
+		CDEBUG(D_INODE, "setting mtime %llu, ctime %llu, now = %llu\n",
+		       (unsigned long long)LTIME_S(attr->ia_mtime),
+		       (unsigned long long)LTIME_S(attr->ia_ctime),
 		       (s64)ktime_get_real_seconds());
 
 	if (S_ISREG(inode->i_mode))
@@ -1760,9 +1761,10 @@ int ll_update_inode(struct inode *inode, struct lustre_md *md)
 	if (body->mbo_valid & OBD_MD_FLMTIME) {
 		if (body->mbo_mtime > LTIME_S(inode->i_mtime)) {
 			CDEBUG(D_INODE,
-			       "setting ino %lu mtime from %lu to %llu\n",
-			       inode->i_ino, LTIME_S(inode->i_mtime),
-			       body->mbo_mtime);
+			       "setting ino %lu mtime from %llu to %llu\n",
+			       inode->i_ino,
+			       (unsigned long long)LTIME_S(inode->i_mtime),
+			       (unsigned long long)body->mbo_mtime);
 			LTIME_S(inode->i_mtime) = body->mbo_mtime;
 		}
 		lli->lli_mtime = body->mbo_mtime;
diff --git a/drivers/staging/lustre/lustre/lmv/lmv_obd.c b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
index 7198a6384028..88e05a53716e 100644
--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -3029,11 +3029,12 @@ static int lmv_merge_attr(struct obd_export *exp,
 	for (i = 0; i < lsm->lsm_md_stripe_count; i++) {
 		struct inode *inode = lsm->lsm_md_oinfo[i].lmo_root;
 
-		CDEBUG(D_INFO, "" DFID " size %llu, blocks %llu nlink %u, atime %lu ctime %lu, mtime %lu.\n",
+		CDEBUG(D_INFO, "" DFID " size %llu, blocks %llu nlink %u, atime %llu ctime %llu, mtime %llu.\n",
 		       PFID(&lsm->lsm_md_oinfo[i].lmo_fid),
 		       i_size_read(inode), (unsigned long long)inode->i_blocks,
-		       inode->i_nlink, LTIME_S(inode->i_atime),
-		       LTIME_S(inode->i_ctime), LTIME_S(inode->i_mtime));
+		       inode->i_nlink, (unsigned long long)LTIME_S(inode->i_atime),
+		       (unsigned long long)LTIME_S(inode->i_ctime),
+		       (unsigned long long)LTIME_S(inode->i_mtime));
 
 		/* for slave stripe, it needs to subtract nlink for . and .. */
 		if (i)
diff --git a/drivers/staging/lustre/lustre/mdc/mdc_reint.c b/drivers/staging/lustre/lustre/mdc/mdc_reint.c
index 488b98007558..f1ccf8d26ddc 100644
--- a/drivers/staging/lustre/lustre/mdc/mdc_reint.c
+++ b/drivers/staging/lustre/lustre/mdc/mdc_reint.c
@@ -129,9 +129,9 @@ int mdc_setattr(struct obd_export *exp, struct md_op_data *op_data,
 	}
 
 	if (op_data->op_attr.ia_valid & (ATTR_MTIME | ATTR_CTIME))
-		CDEBUG(D_INODE, "setting mtime %ld, ctime %ld\n",
-		       LTIME_S(op_data->op_attr.ia_mtime),
-		       LTIME_S(op_data->op_attr.ia_ctime));
+		CDEBUG(D_INODE, "setting mtime %lld, ctime %lld\n",
+		       (long long)LTIME_S(op_data->op_attr.ia_mtime),
+		       (long long)LTIME_S(op_data->op_attr.ia_ctime));
 	mdc_setattr_pack(req, op_data, ea, ealen);
 
 	ptlrpc_request_set_replen(req);
diff --git a/drivers/staging/lustre/lustre/obdclass/obdo.c b/drivers/staging/lustre/lustre/obdclass/obdo.c
index c4503bc36591..8f4054aa970b 100644
--- a/drivers/staging/lustre/lustre/obdclass/obdo.c
+++ b/drivers/staging/lustre/lustre/obdclass/obdo.c
@@ -60,9 +60,9 @@ void obdo_from_inode(struct obdo *dst, struct inode *src, u32 valid)
 	u32 newvalid = 0;
 
 	if (valid & (OBD_MD_FLCTIME | OBD_MD_FLMTIME))
-		CDEBUG(D_INODE, "valid %x, new time %lu/%lu\n",
-		       valid, LTIME_S(src->i_mtime),
-		       LTIME_S(src->i_ctime));
+		CDEBUG(D_INODE, "valid %x, new time %llu/%llu\n",
+		       valid, (long long)LTIME_S(src->i_mtime),
+		       (long long)LTIME_S(src->i_ctime));
 
 	if (valid & OBD_MD_FLATIME) {
 		dst->o_atime = LTIME_S(src->i_atime);
-- 
2.17.0
