Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id c4dKMF0aGVuQYwAAmS7hNA
	; Thu, 07 Jun 2018 11:44:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AB791607E7; Thu,  7 Jun 2018 11:44:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0043260115;
	Thu,  7 Jun 2018 11:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0043260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeFGLoJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:44:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40034 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeFGLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:43:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so18271523wmc.5;
        Thu, 07 Jun 2018 04:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QVtqgS8QVtf7+6CaWKYzxCQ5D2hbtjTqVjARzM4/Fk4=;
        b=tr6hpiEJtMm/mpZqQoyX2VHYKtUrkRQPiLeVwSedwcV0UmF1sIX/aVpuJ3ydnfQpow
         8pD5FKcdhHJoUXrKDeNklgsEM97ksawIcO+d2PuscM2D6PcMzzZjS8uWTMTgE9WiM2Hm
         QV2A7MyYXBDzepPA6202OG9dalaKi166VVbbDhPYhgtQ3hYxLKn3lLz1vp4WkE2D0txo
         zm44IKl+BqEnYn9i0v2NnKxF43Jv9mPf2t1jhVAWx9wemjYO+1PcLCU4dOPIvqYvwuSW
         ArdM52MetoFXav/fzfQh98k6L9/y/Iu0f55CPpgFUEolqjVw4lxH82rwWhQpr5oz/+ZO
         GKHw==
X-Gm-Message-State: APt69E3X8Kkko4TIYf4Gf2RUcdlW3Gcl7udMd9dscFrRAxIt6ERh9ugW
        KKxTy9xHWZr3iK7AH4HuWicFEOQT
X-Google-Smtp-Source: ADUXVKKFbFUOSNJCNMSwFFcMAQmD3svhBC1j8Lm2KjM63bN+AFlnZfUgQ/e0Trtsuq+yA0CbX/kFxw==
X-Received: by 2002:a1c:b2d0:: with SMTP id b199-v6mr1343422wmf.108.1528371833667;
        Thu, 07 Jun 2018 04:43:53 -0700 (PDT)
Received: from localhost.localdomain (u-086-c129.eap.uni-tuebingen.de. [134.2.86.129])
        by smtp.gmail.com with ESMTPSA id v13-v6sm15269280wrq.43.2018.06.07.04.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 04:43:53 -0700 (PDT)
From: Christian Brauner <christian@brauner.io>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: cjwatson@ubuntu.com, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk, serge@hallyn.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 1/1] getxattr: use correct xattr length
Date: Thu,  7 Jun 2018 13:43:48 +0200
Message-Id: <20180607114348.23667-2-christian@brauner.io>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180607114348.23667-1-christian@brauner.io>
References: <20180607114348.23667-1-christian@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running in a container with a user namespace, if you call getxattr
with name = "system.posix_acl_access" and size % 8 != 4, then getxattr
silently skips the user namespace fixup that it normally does resulting in
un-fixed-up data being returned.
This is caused by posix_acl_fix_xattr_to_user() being passed the total
buffer size and not the actual size of the xattr as returned by
vfs_getxattr().
This commit passes the actual length of the xattr as returned by
vfs_getxattr() down.

A reproducer for the issue is:

  touch acl_posix

  setfacl -m user:0:rwx acl_posix

and the compile:

  #define _GNU_SOURCE
  #include <errno.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sys/types.h>
  #include <unistd.h>
  #include <attr/xattr.h>

  /* Run in user namespace with nsuid 0 mapped to uid != 0 on the host. */
  int main(int argc, void **argv)
  {
          ssize_t ret1, ret2;
          char buf1[128], buf2[132];
          int fret = EXIT_SUCCESS;
          char *file;

          if (argc < 2) {
                  fprintf(stderr,
                          "Please specify a file with "
                          "\"system.posix_acl_access\" permissions set\n");
                  _exit(EXIT_FAILURE);
          }
          file = argv[1];

          ret1 = getxattr(file, "system.posix_acl_access",
                          buf1, sizeof(buf1));
          if (ret1 < 0) {
                  fprintf(stderr, "%s - Failed to retrieve "
                                  "\"system.posix_acl_access\" "
                                  "from \"%s\"\n", strerror(errno), file);
                  _exit(EXIT_FAILURE);
          }

          ret2 = getxattr(file, "system.posix_acl_access",
                          buf2, sizeof(buf2));
          if (ret2 < 0) {
                  fprintf(stderr, "%s - Failed to retrieve "
                                  "\"system.posix_acl_access\" "
                                  "from \"%s\"\n", strerror(errno), file);
                  _exit(EXIT_FAILURE);
          }

          if (ret1 != ret2) {
                  fprintf(stderr, "The value of \"system.posix_acl_"
                                  "access\" for file \"%s\" changed "
                                  "between two successive calls\n", file);
                  _exit(EXIT_FAILURE);
          }

          for (ssize_t i = 0; i < ret2; i++) {
                  if (buf1[i] == buf2[i])
                          continue;

                  fprintf(stderr,
                          "Unexpected different in byte %zd: "
                          "%02x != %02x\n", i, buf1[i], buf2[i]);
                  fret = EXIT_FAILURE;
          }

          if (fret == EXIT_SUCCESS)
                  fprintf(stderr, "Test passed\n");
          else
                  fprintf(stderr, "Test failed\n");

          _exit(fret);
  }
and run:

  ./tester acl_posix

On a non-fixed up kernel this should return something like:

  root@c1:/# ./t
  Unexpected different in byte 16: ffffffa0 != 00
  Unexpected different in byte 17: ffffff86 != 00
  Unexpected different in byte 18: 01 != 00

and on a fixed kernel:

  root@c1:~# ./t
  Test passed

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199945
Reported-by: Colin Watson <cjwatson@ubuntu.com>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index f9cb1db187b7..1bee74682513 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -539,7 +539,7 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(kvalue, size);
+			posix_acl_fix_xattr_to_user(kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
-- 
2.17.0
