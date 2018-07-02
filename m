Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60867C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E62725D2F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E62725D2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeGBOlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:41:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752228AbeGBOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:38:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62EcbcR130402
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 10:38:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyjrtgdg3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:38:54 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:38:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 15:38:47 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62EckQv42401852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 14:38:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E02011C04A;
        Mon,  2 Jul 2018 15:38:29 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECAB111C052;
        Mon,  2 Jul 2018 15:38:27 +0100 (BST)
Received: from localhost.ibm.com (unknown [9.80.97.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 15:38:27 +0100 (BST)
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v5 1/8] security: define new LSM hook named security_kernel_load_data
Date:   Mon,  2 Jul 2018 10:37:56 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070214-0020-0000-0000-000002A23940
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070214-0021-0000-0000-000020EE4B08
Message-Id: <1530542283-26145-2-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Differentiate between the kernel reading a file from the kernel loading
data provided by userspace.  This patch defines a new LSM hook named
security_kernel_load_data.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: Serge Hallyn <serge@hallyn.com>

---
Changelog v5:
- Share the kernel_load_data_id and kernel_read_file_id values,
simplifying Loadpin's and other LSMs calling one LSM hook from the
other.

Changelog v4:
- Define new LSM hook named security_kernel_load_data.

Changelog v3:
- Rename security_kernel_read_file to security_kernel_read_data().

Changelog v2:
- Define a generic wrapper named security_kernel_read_blob() for
security_kernel_read_file().

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().

 include/linux/lsm_hooks.h |  6 ++++++
 include/linux/security.h  | 27 +++++++++++++++++++++++++++
 security/security.c       |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 8f1131c8dd54..a08bc2587b96 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -576,6 +576,10 @@
  *	userspace to load a kernel module with the given name.
  *	@kmod_name name of the module requested by the kernel
  *	Return 0 if successful.
+ * @kernel_load_data:
+ *	Load data provided by userspace.
+ *	@id kernel load data identifier
+ *	Return 0 if permission is granted.
  * @kernel_read_file:
  *	Read a file specified by userspace.
  *	@file contains the file structure pointing to the file being read
@@ -1582,6 +1586,7 @@ union security_list_options {
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
 	int (*kernel_module_request)(char *kmod_name);
+	int (*kernel_load_data)(enum kernel_load_data_id id);
 	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
 	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
 				     enum kernel_read_file_id id);
@@ -1872,6 +1877,7 @@ struct security_hook_heads {
 	struct hlist_head cred_getsecid;
 	struct hlist_head kernel_act_as;
 	struct hlist_head kernel_create_files_as;
+	struct hlist_head kernel_load_data;
 	struct hlist_head kernel_read_file;
 	struct hlist_head kernel_post_read_file;
 	struct hlist_head kernel_module_request;
diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..3410acfe139c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -159,6 +159,27 @@ extern int mmap_min_addr_handler(struct ctl_table *table, int write,
 typedef int (*initxattrs) (struct inode *inode,
 			   const struct xattr *xattr_array, void *fs_data);
 
+
+/* Keep the kernel_load_data_id enum in sync with kernel_read_file_id */
+#define __data_id_enumify(ENUM, dummy) LOADING_ ## ENUM,
+#define __data_id_stringify(dummy, str) #str,
+
+enum kernel_load_data_id {
+	__kernel_read_file_id(__data_id_enumify)
+};
+
+static const char * const kernel_load_data_str[] = {
+	__kernel_read_file_id(__data_id_stringify)
+};
+
+static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
+{
+	if ((unsigned)id >= LOADING_MAX_ID)
+		return kernel_load_data_str[LOADING_UNKNOWN];
+
+	return kernel_load_data_str[id];
+}
+
 #ifdef CONFIG_SECURITY
 
 struct security_mnt_opts {
@@ -320,6 +341,7 @@ void security_cred_getsecid(const struct cred *c, u32 *secid);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
+int security_kernel_load_data(enum kernel_load_data_id id);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
@@ -909,6 +931,11 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
+static inline int security_kernel_load_data(enum kernel_load_data_id id)
+{
+	return 0;
+}
+
 static inline int security_kernel_read_file(struct file *file,
 					    enum kernel_read_file_id id)
 {
diff --git a/security/security.c b/security/security.c
index e7d76a8000a5..05fe5b1932d7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1061,6 +1061,11 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
+int security_kernel_load_data(enum kernel_load_data_id id)
+{
+	return call_int_hook(kernel_load_data, 0, id);
+}
+
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-- 
2.7.5

