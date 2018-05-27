Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeE0WzQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:55:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42650 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeE0WzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:55:14 -0400
From: Colin King <colin.king@canonical.com>
To: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EVM: Fix null dereference on xattr when xattr fails to allocate
Date: Sun, 27 May 2018 23:55:10 +0100
Message-Id: <20180527225510.25612-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where the allocation of xattr fails and xattr is NULL, the
error exit return path via label 'out' will dereference xattr when
kfree'ing xattr-name.  Fix this by only kfree'ing xattr->name and xattr
when xattr is non-null.

Detected by CoverityScan, CID#1469366 ("Dereference after null check")

Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/integrity/evm/evm_secfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index fb8bc950aceb..cf5cd303d7c0 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -253,8 +253,10 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 out:
 	audit_log_format(ab, " res=%d", err);
 	audit_log_end(ab);
-	kfree(xattr->name);
-	kfree(xattr);
+	if (xattr) {
+		kfree(xattr->name);
+		kfree(xattr);
+	}
 	return err;
 }
 
-- 
2.17.0
