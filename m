Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDMP2D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:28:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750824AbeDMP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:28:01 -0400
Subject: [PATCH] lockdown: fix coordination of kernel module signature
 verification
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: Luca Boccassi <bluca@debian.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Fri, 13 Apr 2018 11:27:52 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041315-0020-0000-0000-000004119D54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041315-0021-0000-0000-000042A5D0B4
Message-Id: <1523633272.3272.30.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If both IMA-appraisal and sig_enforce are enabled, then both signatures
are currently required.  If the IMA-appraisal signature verification
fails, it could rely on the appended signature verification; but with the
lockdown patch set, the appended signature verification assumes that if
IMA-appraisal is enabled, it has verified the signature.  Basically each
signature verification method would be relying on the other to verify the
kernel module signature.

This patch addresses the problem of requiring both kernel module signature
verification methods, when both are enabled, by verifying just the
appended signature.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 kernel/module.c                   | 4 +---
 security/integrity/ima/ima_main.c | 7 ++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 9c1709a05037..60861eb7bc4d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2803,9 +2803,7 @@ static int module_sig_check(struct load_info *info, int flags,
 		if (sig_enforce) {
 			pr_notice("%s is rejected\n", reason);
 			return -EKEYREJECTED;
-		}
-
-		if (can_do_ima_check && is_ima_appraise_enabled())
+		} else if (can_do_ima_check && is_ima_appraise_enabled())
 			return 0;
 		if (kernel_is_locked_down(reason))
 			return -EPERM;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 754ece08e1c6..2155b1f316a4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -480,6 +480,7 @@ static int read_idmap[READING_MAX_ID] = {
 int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
+	bool sig_enforce = is_module_sig_enforced();
 	enum ima_hooks func;
 	u32 secid;
 
@@ -490,7 +491,11 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 	}
 
-	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
+	/*
+	 * If both IMA-appraisal and appended signature verification are
+	 * enabled, rely on the appended signature verification.
+	 */
+	if (sig_enforce && read_id == READING_MODULE)
 		return 0;
 
 	/* permit signed certs */
-- 
2.7.5
