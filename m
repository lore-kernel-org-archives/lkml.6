Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935255AbeE2O0d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:26:33 -0400
Received: from smtp4.ccs.ornl.gov ([160.91.203.40]:38208 "EHLO
        smtp4.ccs.ornl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934917AbeE2OW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:27 -0400
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Amir Shehata <amir.shehata@intel.com>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH v2 12/25] staging: lustre: libcfs: invert error handling for cfs_cpt_table_print
Date: Tue, 29 May 2018 10:21:52 -0400
Message-Id: <1527603725-30560-13-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Shehata <amir.shehata@intel.com>

Instead of setting rc to -EFBIG for several cases in the loop lets
just go to the out label on error which returns -E2BIG directly.

Signed-off-by: Amir Shehata <amir.shehata@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-7734
Reviewed-on: http://review.whamcloud.com/18916
Reviewed-by: Olaf Weber <olaf@sgi.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
Changelog:

v1) New patch to replace several patches. Went crazy for the one
    change per patch approach.

 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index 9ff9fe9..bf41ba3 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -190,29 +190,26 @@ struct cfs_cpt_table *
 cfs_cpt_table_print(struct cfs_cpt_table *cptab, char *buf, int len)
 {
 	char *tmp = buf;
-	int rc = 0;
+	int rc;
 	int i;
 	int j;
 
 	for (i = 0; i < cptab->ctb_nparts; i++) {
-		if (len > 0) {
-			rc = snprintf(tmp, len, "%d\t:", i);
-			len -= rc;
-		}
+		if (len <= 0)
+			goto out;
+
+		rc = snprintf(tmp, len, "%d\t:", i);
+		len -= rc;
 
-		if (len <= 0) {
-			rc = -EFBIG;
+		if (len <= 0)
 			goto out;
-		}
 
 		tmp += rc;
 		for_each_cpu(j, cptab->ctb_parts[i].cpt_cpumask) {
 			rc = snprintf(tmp, len, "%d ", j);
 			len -= rc;
-			if (len <= 0) {
-				rc = -EFBIG;
+			if (len <= 0)
 				goto out;
-			}
 			tmp += rc;
 		}
 
@@ -221,11 +218,9 @@ struct cfs_cpt_table *
 		len--;
 	}
 
- out:
-	if (rc < 0)
-		return rc;
-
 	return tmp - buf;
+out:
+	return -E2BIG;
 }
 EXPORT_SYMBOL(cfs_cpt_table_print);
 
-- 
1.8.3.1
