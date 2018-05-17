Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZqN+pcpxFuO3OVYLuI1CvOJwtxhui7lWTbBIlKgdgDczEb+exYb5Z8ANPLvWWXqVABIqJMp
ARC-Seal: i=1; a=rsa-sha256; t=1526568585; cv=none;
        d=google.com; s=arc-20160816;
        b=kRzuHz7UIXDyJfRiJUcn693E/nbpTUD8mrEz2PvtFZIuSnAPdS5+rCnZRQfWzB5a6f
         4dUpYcfComMIftGVIRdyszvQpgyu3Xy30meleOtwjWZGXrmHJxhuVDUGyAtzjESYf6Gc
         atHiS5oe+XUNqzBoUszMhCatnrSjvQC45pGP/RDNEZE+bHx3z4Fa9K57PV/dhfO9vVte
         Z6IO0ci0aUIk/yohvSUkgn3VYE7ocoxz/xIEgG2C4nTe7t3ih9dH7NNpbuDqiYB95q4O
         AvW8WvPdYCjt3s9ARrc+PdOv5ShtX/a+qJKc02gD06Qut55YFd62N+kgPbEYnJ+2TKnS
         tJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=l+YV48iPHy6nsCVGaeerYciWVcTSmqr1bMNZ830R4fI=;
        b=mMikz4w3GxQtvamSIreJTgXlmR37VpQkGTovuBFtgFBji/8HKZcE6b9fLoUJqftnRP
         aSi7nnVTuIdaI8Zy/B7x1ymx2YoyfvHNbfYVHQ3LfZv6EmnFvVJubhbvt8HkxhYZ48+7
         q0fBPzbPYaIRayIBE0TMxknUjAtKencwDUzYIudHwgpCW//ZtqpEpTnSPMpAuAZbr7Hn
         qy/SvdzK886sqriT+EkvBzA3DVJ08Ozr5EysUbMdoMo9d5lNzRoBIPGWrIbD+2d8AFsN
         SJFif882DuNRBPOMVKHibJoYn5EPClPR/RcVXgJXxn1qdbGcP1r1WkR9FA3SMsiKGEeq
         jSFw==
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 4/9] kexec: add call to LSM hook in original kexec_load syscall
Date: Thu, 17 May 2018 10:48:45 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1526568530-9144-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18051714-0012-0000-0000-000005D7A700
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0013-0000-0000-00001954D357
Message-Id: <1526568530-9144-5-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170137
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600723181848817103?=
X-GMAIL-MSGID: =?utf-8?q?1600723181848817103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order for LSMs and IMA-appraisal to differentiate between the
original and new syscalls, both the original and new syscalls must call
an LSM hook.  This patch adds a call to security_kernel_read_blob() in
the original kexec syscall.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>
---
 kernel/kexec.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index aed8fb2564b3..64cebe92a690 100644
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
+	result = security_kernel_read_blob(READING_KEXEC_IMAGE);
+	if (result < 0)
+		return result;
+
+	/*
 	 * Verify we have a legal set of flags
 	 * This leaves us room for future extensions.
 	 */
-- 
2.7.5
