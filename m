Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C85C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA08214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389666AbeLQVST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:18:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbeLQVST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:18:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHLEltj024239
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:18:18 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pek7ts1ka-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:18:18 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Dec 2018 21:18:15 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 21:18:13 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHLICMZ1573128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 21:18:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E8B242052;
        Mon, 17 Dec 2018 21:18:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8772F4203F;
        Mon, 17 Dec 2018 21:18:11 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Dec 2018 21:18:11 +0000 (GMT)
Subject: [PATCH] ima: define ima_create_tmpfile() hook and add missing call
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ignaz Forster <iforster@suse.de>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Fabian Vogt <fvogt@suse.de>, Al Viro <viro@ZenIV.linux.org.uk>
Date:   Mon, 17 Dec 2018 16:18:11 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121721-0012-0000-0000-000002DA720B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121721-0013-0000-0000-0000211007B0
Message-Id: <1545081491.3730.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=954 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tmpfiles can be made persistent, then newly created tmpfiles need to
be treated like any other new files in policy.

This patch indicates which newly created tmpfiles are in policy, causing
the file hash to be calculated on __fput().

Reported-by: Ignaz Forster <ignaz.forster@gmx.de>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/namei.c                        |  2 ++
 include/linux/ima.h               |  6 ++++++
 security/integrity/ima/ima_main.c | 36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0cab6494978c..0911837979f6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3495,6 +3495,8 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		goto out2;
 	file->f_path.mnt = path.mnt;
 	error = finish_open(file, child, NULL);
+	if (!error)
+		ima_post_create_tmpfile(file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/include/linux/ima.h b/include/linux/ima.h
index b5e16b8c50b7..2cd1577943ce 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -18,6 +18,7 @@ struct linux_binprm;
 #ifdef CONFIG_IMA
 extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
+extern void ima_post_create_tmpfile(const struct file *file);
 extern void ima_file_free(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id);
@@ -56,6 +57,11 @@ static inline int ima_file_check(struct file *file, int mask)
 	return 0;
 }
 
+static inline void ima_post_create_tmpfile(const struct file *file)
+{
+	return 0;
+}
+
 static inline void ima_file_free(struct file *file)
 {
 	return;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bd9bd5f88206..388458c8ec29 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -395,6 +395,34 @@ int ima_file_check(struct file *file, int mask)
 EXPORT_SYMBOL_GPL(ima_file_check);
 
 /**
+ * ima_post_create_tmpfile - mark newly created tmpfile as new
+ * @file : newly created tmpfile
+ *
+ * No measuring, appraising or auditing of newly created tmpfiles is needed.
+ * Skip calling process_measurement(), but indicate which newly, created
+ * tmpfiles are in policy.
+ */
+void ima_post_create_tmpfile(const struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct integrity_iint_cache *iint;
+	int must_appraise;
+
+	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	if (!must_appraise)
+		return;
+
+	/* Nothing to do if we can't allocate memory */
+	iint = integrity_inode_get(inode);
+	if (!iint)
+		return;
+
+	/* needed for writing the security xattrs */
+	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
+	iint->ima_file_status = INTEGRITY_PASS;
+}
+
+/**
  * ima_post_path_mknod - mark as a new inode
  * @dentry: newly created dentry
  *
@@ -411,9 +439,13 @@ void ima_post_path_mknod(struct dentry *dentry)
 	if (!must_appraise)
 		return;
 
+	/* Nothing to do if we can't allocate memory */
 	iint = integrity_inode_get(inode);
-	if (iint)
-		iint->flags |= IMA_NEW_FILE;
+	if (!iint)
+		return;
+
+	/* needed for re-opening empty files */
+	iint->flags |= IMA_NEW_FILE;
 }
 
 /**
-- 
2.7.5

