Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932606AbeCITHp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 14:07:45 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44145 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932570AbeCITHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 14:07:39 -0500
X-Google-Smtp-Source: AG47ELvgSeBVv5edRUR3SpWEzG7unw0lDFu9+to6VXtWluEvGLFYEmBfa2BeijUlAHpDNIE9kkxckQ==
Date: Fri, 9 Mar 2018 11:07:36 -0800
From: Kees Cook <keescook@chromium.org>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] exec: Set file unwritable before LSM check
Message-ID: <20180309190736.GA4657@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LSM check should happen after the file has been confirmed to be
unchanging. Without this, we could have a ToCToU issue between the
LSM verification and the actual contents of the file later.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Only loadpin and SELinux implement this hook. From what I can see, this
won't change anything for either of them. IMA calls kernel_read_file(),
but looking there it seems those callers won't be negatively impacted
either. Can folks double-check this and send an Ack please?
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
