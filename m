Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oBjhKDxPGVuRfAAAmS7hNA
	; Thu, 07 Jun 2018 16:00:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8E213607E7; Thu,  7 Jun 2018 16:00:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E70260590;
	Thu,  7 Jun 2018 16:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E70260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934480AbeFGQAE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:00:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39344 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933052AbeFGOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zu-RP; Thu, 07 Jun 2018 15:09:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002w4-2s; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Steve French" <smfrench@gmail.com>,
        "Matthew Wilcox" <mawilcox@microsoft.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.910084088@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 164/410] cifs: Fix missing put_xid in cifs_file_strict_mmap
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit f04a703c3d613845ae3141bfaf223489de8ab3eb upstream.

If cifs_zap_mapping() returned an error, we would return without putting
the xid that we got earlier.  Restructure cifs_file_strict_mmap() and
cifs_file_mmap() to be more similar to each other and have a single
point of return that always puts the xid.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/file.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3116,20 +3116,18 @@ static struct vm_operations_struct cifs_
 
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	int rc, xid;
+	int xid, rc = 0;
 	struct inode *inode = file_inode(file);
 
 	xid = get_xid();
 
-	if (!CIFS_CACHE_READ(CIFS_I(inode))) {
+	if (!CIFS_CACHE_READ(CIFS_I(inode)))
 		rc = cifs_zap_mapping(inode);
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
 	free_xid(xid);
 	return rc;
 }
@@ -3139,16 +3137,16 @@ int cifs_file_mmap(struct file *file, st
 	int rc, xid;
 
 	xid = get_xid();
+
 	rc = cifs_revalidate_file(file);
-	if (rc) {
+	if (rc)
 		cifs_dbg(FYI, "Validation prior to mmap failed, error=%d\n",
 			 rc);
-		free_xid(xid);
-		return rc;
-	}
-	rc = generic_file_mmap(file, vma);
-	if (rc == 0)
+	if (!rc)
+		rc = generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops = &cifs_file_vm_ops;
+
 	free_xid(xid);
 	return rc;
 }
