Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZq2gje+Nh2PTjF8NnJrl7nQfmDfp1a+Y1pciZFaHNbegh9HzAFhwnMvoUope6bwchgPT4l/
ARC-Seal: i=1; a=rsa-sha256; t=1526568584; cv=none;
        d=google.com; s=arc-20160816;
        b=nW22+A81lYDhD+CuWM7vRoIlQ9ddbmXJOG3TNEVSUc4wwozSS7guhNSh1DQhxKcYb5
         S8AJUItjbgUqHufZ7YSZrpzSJimU8ZXWJOFb9oW831I3uw3a4pjTuzuRGVCS4a0lrnGV
         yrNtf+2HbMGsZvc8dS85Nbv2Hgt0PvnvDMwDM5rmPa/37ne23iNfKN7Oi6AVCh1Ym9QS
         Q8jjQjuvc5N03a1W2sJ0UwwGvPoRfLrSLTiHjDMyY91u/vaOX64HB5FpVgCogWVmXOON
         MMApg8ceG5KmeRNiZKJ+DHDaqRUC4ALZG95mZTVIldtPhGHqI8GsupA74D/SX9dMNtsT
         2hLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=MuaEz0MM/omwYDqSPDK1le9qe9T3xkQGB65DOqo9gYI=;
        b=eXpU9siVz9VZHuQZzg3BVL5xhaNVWsknjSDzZjmes4j81X5WpiJAt8hKo3x60f5Vsi
         UWCIZ4a/Hr//HsibrI0YVPqFXpm22pBmIPqLKM5Sz7yhiQ6bP2WSlb4/THen0XL4FRpt
         yXfOwfwN1mvCijf+RCkNAYWCteAv0kKJa4DegQ1eO5f+QaO16MnHVN2V36iuk78yhfVX
         +0Nq13HoEm76lKnJmpeTMqM1l0Me2SFE6qOSm1mL6X5NthEjbIAj6yuIKfdoS8cLyS5e
         tzLSurIN8PeXfq2ZmHnENpjMLCEiVEMQuCZt7injkMzqlNq+naqc2pcirskmyvbZAIIO
         fGKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v2 3/9] security: define security_kernel_read_blob() wrapper
Date: Thu, 17 May 2018 10:48:44 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0012-0000-0000-000005D7A6FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0013-0000-0000-00001954D356
Message-Id: <1526568530-9144-4-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723179870285580?=
X-GMAIL-MSGID: =?utf-8?q?1600723179870285580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order for LSMs and IMA-appraisal to differentiate between the original
and new syscalls (eg. kexec, kernel modules, firmware), both the original
and new syscalls must call an LSM hook.

Commit 2e72d51b4ac3 ("security: introduce kernel_module_from_file hook")
introduced calling security_kernel_module_from_file() in both the original
and new syscalls.  Commit a1db74209483 ("module: replace
copy_module_from_fd with kernel version") replaced these LSM calls with
security_kernel_read_file().

Commit e40ba6d56b41 ("firmware: replace call to fw_read_file_contents()
with kernel version") and commit b804defe4297  ("kexec: replace call to
copy_file_from_fd() with kernel version") replaced their own version of
reading a file from the kernel with the generic
kernel_read_file_from_path/fd() versions, which call the pre and post
security_kernel_read_file LSM hooks.

Missing are LSM calls in the original kexec syscall and firmware sysfs
fallback method.  From a technical perspective there is no justification
for defining a new LSM hook, as the existing security_kernel_read_file()
works just fine.  The original syscalls, however, do not read a file, so
the security hook name is inappropriate.  Instead of defining a new LSM
hook, this patch defines security_kernel_read_blob() as a wrapper for
the existing LSM security_kernel_file_read() hook.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>

Changelog v2:
- Define a generic wrapper named security_kernel_read_blob() for
security_kernel_read_file().

Changelog v1:
- Define and call security_kexec_load(), a wrapper for
security_kernel_read_file().
---
 include/linux/security.h | 6 ++++++
 security/security.c      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 63030c85ee19..4db1967a688b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -323,6 +323,7 @@ int security_kernel_module_request(char *kmod_name);
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
+int security_kernel_read_blob(enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
@@ -922,6 +923,11 @@ static inline int security_kernel_post_read_file(struct file *file,
 	return 0;
 }
 
+static inline int security_kernel_read_blob(enum kernel_read_file_id id)
+{
+	return 0;
+}
+
 static inline int security_task_fix_setuid(struct cred *new,
 					   const struct cred *old,
 					   int flags)
diff --git a/security/security.c b/security/security.c
index 68f46d849abe..8f199b2bf4a2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1044,6 +1044,12 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
+int security_kernel_read_blob(enum kernel_read_file_id id)
+{
+	return security_kernel_read_file(NULL, id);
+}
+EXPORT_SYMBOL_GPL(security_kernel_read_blob);
+
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
-- 
2.7.5
