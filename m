Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeFERT4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:19:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbeFERFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Ohly <patrick.ohly@intel.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 4.9 06/61] Revert "ima: limit file hash setting by user to fix and log modes"
Date: Tue,  5 Jun 2018 19:01:27 +0200
Message-Id: <20180605170117.990658896@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

commit f5acb3dcba1ffb7f0b8cbb9dba61500eea5d610b upstream.

Userspace applications have been modified to write security xattrs,
but they are not context aware.  In the case of security.ima, the
security xattr can be either a file hash or a file signature.
Permitting writing one, but not the other requires the application to
be context aware.

In addition, userspace applications might write files to a staging
area, which might not be in policy, and then change some file metadata
(eg. owner) making it in policy.  As a result, these files are not
labeled properly.

This reverts commit c68ed80c97d9720f51ef31fe91560fdd1e121533, which
prevents writing file hashes as security.ima xattrs.

Requested-by: Patrick Ohly <patrick.ohly@intel.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/integrity/ima/ima_appraise.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -389,14 +389,10 @@ int ima_inode_setxattr(struct dentry *de
 	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
 				   xattr_value_len);
 	if (result == 1) {
-		bool digsig;
-
 		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
 			return -EINVAL;
-		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
-		if (!digsig && (ima_appraise & IMA_APPRAISE_ENFORCE))
-			return -EPERM;
-		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
+		ima_reset_appraise_flags(d_backing_inode(dentry),
+			 (xvalue->type == EVM_IMA_XATTR_DIGSIG) ? 1 : 0);
 		result = 0;
 	}
 	return result;
