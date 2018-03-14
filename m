Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCNUUt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:20:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752081AbeCNUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:20:47 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 3/4] ima: Improvements in ima_appraise_measurement()
Date: Wed, 14 Mar 2018 17:20:19 -0300
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
References: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031420-0056-0000-0000-0000042D8CC5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003063; UDB=6.00510447; IPR=6.00782394;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 20:20:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031420-0057-0000-0000-0000086F8DCB
Message-Id: <20180314202020.3794-4-bauerman@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

Replace nested ifs in the EVM xattr verification logic with a switch
statement, making the code easier to understand.

Also, add comments to the if statements in the out section and constify the
cause variable.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 0c5f94b7b9c3..dd10ecbdce45 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -215,7 +215,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 			     int xattr_len, int opened)
 {
 	static const char op[] = "appraise_data";
-	char *cause = "unknown";
+	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
 	enum integrity_status status = INTEGRITY_UNKNOWN;
@@ -241,16 +241,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 	}
 
 	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
-	if ((status != INTEGRITY_PASS) &&
-	    (status != INTEGRITY_PASS_IMMUTABLE) &&
-	    (status != INTEGRITY_UNKNOWN)) {
-		if ((status == INTEGRITY_NOLABEL)
-		    || (status == INTEGRITY_NOXATTRS))
-			cause = "missing-HMAC";
-		else if (status == INTEGRITY_FAIL)
-			cause = "invalid-HMAC";
+	switch (status) {
+	case INTEGRITY_PASS:
+	case INTEGRITY_PASS_IMMUTABLE:
+	case INTEGRITY_UNKNOWN:
+		break;
+	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
+	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
+		cause = "missing-HMAC";
+		goto out;
+	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
+		cause = "invalid-HMAC";
 		goto out;
 	}
+
 	switch (xattr_value->type) {
 	case IMA_XATTR_DIGEST_NG:
 		/* first byte contains algorithm id */
@@ -316,17 +320,20 @@ int ima_appraise_measurement(enum ima_hooks func,
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
+		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
-		} else if ((inode->i_size == 0) &&
-			   (iint->flags & IMA_NEW_FILE) &&
-			   (xattr_value &&
-			    xattr_value->type == EVM_IMA_XATTR_DIGSIG)) {
+		}
+
+		/* Permit new files with file signatures, but without data. */
+		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
+		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
 			status = INTEGRITY_PASS;
 		}
+
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else {
