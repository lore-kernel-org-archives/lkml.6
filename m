Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeEWA0g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:26:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753742AbeEWA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:26:30 -0400
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH v7 08/14] ima: Introduce is_signed()
Date: Tue, 22 May 2018 21:12:47 -0300
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180523001253.15247-1-bauerman@linux.ibm.com>
References: <20180523001253.15247-1-bauerman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052300-8235-0000-0000-00000D8D5A33
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036241; UDB=6.00530093; IPR=6.00815369;
 MB=3.00021248; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 00:26:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052300-8236-0000-0000-000041176F8B
Message-Id: <20180523001253.15247-9-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of another IMA signature type (modsig), some places
will need to check for both of them. It is cleaner to do that if there's a
helper function to tell whether an xattr_value represents an IMA
signature.

Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h              | 5 +++++
 security/integrity/ima/ima_appraise.c     | 7 +++----
 security/integrity/ima/ima_template_lib.c | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 354bb5716ce3..43d4aaf31f7a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -154,6 +154,11 @@ unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
 
+static inline bool is_signed(const struct evm_ima_xattr_data *xattr_value)
+{
+	return xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG;
+}
+
 /*
  * used to protect h_table and sha_table
  */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a6b2995b7d0b..bcbbd8f86fe1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -325,15 +325,14 @@ int ima_appraise_measurement(enum ima_hooks func,
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
 		if ((ima_appraise & IMA_APPRAISE_FIX) &&
-		    (!xattr_value ||
-		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
+		    !is_signed(xattr_value)) {
 			if (!ima_fix_xattr(dentry, iint))
 				status = INTEGRITY_PASS;
 		}
 
 		/* Permit new files with file signatures, but without data. */
 		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
-		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
+		    is_signed(xattr_value)) {
 			status = INTEGRITY_PASS;
 		}
 
@@ -448,7 +447,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
 			return -EINVAL;
 		ima_reset_appraise_flags(d_backing_inode(dentry),
-			xvalue->type == EVM_IMA_XATTR_DIGSIG);
+					 is_signed(xvalue));
 		result = 0;
 	}
 	return result;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 43752002c222..300912914b17 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -382,7 +382,7 @@ int ima_eventsig_init(struct ima_event_data *event_data,
 {
 	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
 
-	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
+	if (!is_signed(xattr_value))
 		return 0;
 
 	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
