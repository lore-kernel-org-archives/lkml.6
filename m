Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932615AbeCITa0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:30:26 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45796 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeCITaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:30:22 -0500
X-Google-Smtp-Source: AG47ELsjaDzxlA7RSD65c0e+e5OwvYhSo1iLxK8JYICVTr9fLu5kIvaopl2c0cwpigd6BcFgJyOIhw==
Date: Fri, 9 Mar 2018 11:30:20 -0800
From: Kees Cook <keescook@chromium.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] exec: Set file unwritable before LSM check
Message-ID: <20180309193020.GA5149@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LSM check should happen after the file has been confirmed to be
unchanging. Without this, we could have a race between the Time of Check
(the call to security_kernel_read_file() which could read the file and
make access policy decisions) and the Time of Use (starting with
kernel_read_file()'s reading of the file contents). In theory, file
contents could change between the two.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: Clarify the ToC/ToU race (Linus)

Only loadpin and SELinux currently implement this hook. From what
I can see, this won't change anything for either of them. IMA calls
kernel_read_file(), but looking there it seems those callers won't be
negatively impacted either. Can folks double-check this and send an
Ack please?
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7eb8d21bcab9..a919a827d181 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -895,13 +895,13 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	if (!S_ISREG(file_inode(file)->i_mode) || max_size < 0)
 		return -EINVAL;
 
-	ret = security_kernel_read_file(file, id);
+	ret = deny_write_access(file);
 	if (ret)
 		return ret;
 
-	ret = deny_write_access(file);
+	ret = security_kernel_read_file(file, id);
 	if (ret)
-		return ret;
+		goto out;
 
 	i_size = i_size_read(file_inode(file));
 	if (max_size > 0 && i_size > max_size) {
-- 
2.7.4


-- 
Kees Cook
Pixel Security
