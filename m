Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBDDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44ADA20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ADA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbeIHCIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:08:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeIHCIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:08:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 966E9EF6;
        Fri,  7 Sep 2018 21:25:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eddie Horng <eddie.horng@mediatek.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.18 133/145] cap_inode_getsecurity: use d_find_any_alias() instead of d_find_alias()
Date:   Fri,  7 Sep 2018 23:09:59 +0200
Message-Id: <20180907210913.598690193@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eddie.Horng <eddie.horng@mediatek.com>

commit 355139a8dba446cc11a424cddbf7afebc3041ba1 upstream.

The code in cap_inode_getsecurity(), introduced by commit 8db6c34f1dbc
("Introduce v3 namespaced file capabilities"), should use
d_find_any_alias() instead of d_find_alias() do handle unhashed dentry
correctly. This is needed, for example, if execveat() is called with an
open but unlinked overlayfs file, because overlayfs unhashes dentry on
unlink.
This is a regression of real life application, first reported at
https://www.spinics.net/lists/linux-unionfs/msg05363.html

Below reproducer and setup can reproduce the case.
  const char* exec="echo";
  const char *newargv[] = { "echo", "hello", NULL};
  const char *newenviron[] = { NULL };
  int fd, err;

  fd = open(exec, O_PATH);
  unlink(exec);
  err = syscall(322/*SYS_execveat*/, fd, "", newargv, newenviron,
AT_EMPTY_PATH);
  if(err<0)
    fprintf(stderr, "execveat: %s\n", strerror(errno));

gcc compile into ~/test/a.out
mount -t overlay -orw,lowerdir=/mnt/l,upperdir=/mnt/u,workdir=/mnt/w
none /mnt/m
cd /mnt/m
cp /bin/echo .
~/test/a.out

Expected result:
hello
Actually result:
execveat: Invalid argument
dmesg:
Invalid argument reading file caps for /dev/fd/3

The 2nd reproducer and setup emulates similar case but for
regular filesystem:
  const char* exec="echo";
  int fd, err;
  char buf[256];

  fd = open(exec, O_RDONLY);
  unlink(exec);
  err = fgetxattr(fd, "security.capability", buf, 256);
  if(err<0)
    fprintf(stderr, "fgetxattr: %s\n", strerror(errno));

gcc compile into ~/test_fgetxattr

cd /tmp
cp /bin/echo .
~/test_fgetxattr

Result:
fgetxattr: Invalid argument

On regular filesystem, for example, ext4 read xattr from
disk and return to execveat(), will not trigger this issue, however,
the overlay attr handler pass real dentry to vfs_getxattr() will.
This reproducer calls fgetxattr() with an unlinked fd, involkes
vfs_getxattr() then reproduced the case that d_find_alias() in
cap_inode_getsecurity() can't find the unlinked dentry.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Serge E. Hallyn <serge@hallyn.com>
Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Cc: <stable@vger.kernel.org> # v4.14
Signed-off-by: Eddie Horng <eddie.horng@mediatek.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/commoncap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -388,7 +388,7 @@ int cap_inode_getsecurity(struct inode *
 	if (strcmp(name, "capability") != 0)
 		return -EOPNOTSUPP;
 
-	dentry = d_find_alias(inode);
+	dentry = d_find_any_alias(inode);
 	if (!dentry)
 		return -EINVAL;
 


