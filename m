Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CA3C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1812081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1812081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeLIWMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:12:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37786 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbeLIWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:12:19 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73B-0002ic-Q5; Sun, 09 Dec 2018 21:55:45 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72e-0003Qr-8j; Sun, 09 Dec 2018 21:55:12 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Serge Hallyn" <serge@hallyn.com>,
        "Christian Brauner" <christian@brauner.io>,
        "Colin Watson" <cjwatson@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.867348958@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 157/328] getxattr: use correct xattr length
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian@brauner.io>

commit 82c9a927bc5df6e06b72d206d24a9d10cced4eb5 upstream.

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

Fixes: 2f6f0654ab61 ("userns: Convert vfs posix_acl support to use kuids and kgids")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199945
Reported-by: Colin Watson <cjwatson@ubuntu.com>
Signed-off-by: Christian Brauner <christian@brauner.io>
Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -466,7 +466,7 @@ getxattr(struct dentry *d, const char __
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(kvalue, size);
+			posix_acl_fix_xattr_to_user(kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {

