Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeE3LK5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:10:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60792 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752757AbeE3LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:48 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Steve French" <smfrench@gmail.com>,
        "Matthew Wilcox" <mawilcox@microsoft.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.473672722@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 062/153] cifs: Fix missing put_xid in cifs_file_strict_mmap
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit f04a703c3d613845ae3141bfaf223489de8ab3eb upstream.

If cifs_zap_mapping() returned an error, we would return without putting
the xid that we got earlier.  Restructure cifs_file_strict_mmap() and
cifs_file_mmap() to be more similar to each other and have a single
point of return that always puts the xid.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/file.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2530,20 +2530,18 @@ static struct vm_operations_struct cifs_
 
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	int rc, xid;
+	int xid, rc = 0;
 	struct inode *inode = file->f_path.dentry->d_inode;
 
 	xid = GetXid();
 
-	if (!CIFS_I(inode)->clientCanCacheRead) {
+	if (!CIFS_I(inode)->clientCanCacheRead)
 		rc = cifs_invalidate_mapping(inode);
-		if (rc)
-			return rc;
-	}
-
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	FreeXid(xid);
 	return rc;
 }
@@ -2553,15 +2551,15 @@ int cifs_file_mmap(struct file *file, st
 	int rc, xid;
 
 	xid = GetXid();
+
 	rc = cifs_revalidate_file(file);
-	if (rc) {
+	if (rc)
 		cFYI(1, "Validation prior to mmap failed, error=%d", rc);
-		FreeXid(xid);
-		return rc;
-	}
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	FreeXid(xid);
 	return rc;
 }
