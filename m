Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeEKBhI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 21:37:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752113AbeEKBhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 21:37:06 -0400
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
Date: Thu, 10 May 2018 21:36:47 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526002608-27474-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051101-0020-0000-0000-0000041C145B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051101-0021-0000-0000-000042B114E8
Message-Id: <1526002608-27474-3-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110009
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for LSMs and IMA-appraisal to differentiate between the
kexec_load and kexec_file_load_syscalls, an LSM call needs to be added
to the original kexec_load syscall.  From a technical perspective there
is no need for defining a new LSM hook, as the existing
security_kernel_kexec_load() works just fine.  However, the name is
confusing.  For this reason, instead of defining a new LSM hook, this
patch defines security_kexec_load() as a wrapper for the existing LSM
security_kernel_file_read() hook.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().
---
 include/linux/security.h |  6 ++++++
 kernel/kexec.c           | 11 +++++++++++
 security/security.c      |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..26f6d85903ed 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -323,6 +323,7 @@ int security_kernel_module_request(char *kmod_name);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
+int security_kexec_load(void);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -922,6 +923,11 @@ static inline int security_kernel_post_read_file(struct file *file,
 	return 0;
 }
 
+static inline int security_kexec_load(void)
+{
+	return 0;
+}
+
 static inline int security_task_fix_setuid(struct cred *new,
 					   const struct cred *old,
 					   int flags)
diff --git a/kernel/kexec.c b/kernel/kexec.c
index aed8fb2564b3..6b44b0e9a60b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -11,6 +11,7 @@
 #include <linux/capability.h>
 #include <linux/mm.h>
 #include <linux/file.h>
+#include <linux/security.h>
 #include <linux/kexec.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 static inline int kexec_load_check(unsigned long nr_segments,
 				   unsigned long flags)
 {
+	int result;
+
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
 	/*
+	 * Allow LSMs and IMA to differentiate between kexec_load and
+	 * kexec_file_load syscalls.
+	 */
+	result = security_kexec_load();
+	if (result < 0)
+		return result;
+
+	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
 	 */
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..0f3390000156 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1044,6 +1044,12 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
+int security_kexec_load()
+{
+	return security_kernel_read_file(NULL, READING_KEXEC_IMAGE);
+}
+EXPORT_SYMBOL_GPL(security_kexec_load);
+
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
-- 
2.7.5
