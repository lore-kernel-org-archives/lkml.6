Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF92DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8933820883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8933820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeIQVGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:06:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeIQVGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:06:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E0A2307D844;
        Mon, 17 Sep 2018 15:38:10 +0000 (UTC)
Received: from max.home.com (unknown [10.36.117.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0317C8B3;
        Mon, 17 Sep 2018 15:38:09 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH] sysfs: Do not return POSIX ACL xattrs via listxattr
Date:   Mon, 17 Sep 2018 17:38:06 +0200
Message-Id: <20180917153806.10771-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 17 Sep 2018 15:38:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 786534b92f3c introduced a regression that caused listxattr to
return the POSIX ACL attribute names even though sysfs doesn't support
POSIX ACLs.  This happens because simple_xattr_list checks for NULL
i_acl / i_default_acl, but inode_init_always initializes those fields to
ACL_NOT_CACHED ((void *)-1).  For example:

    $ getfattr -m- -d /sys
    /sys: system.posix_acl_access: Operation not supported
    /sys: system.posix_acl_default: Operation not supported

Fix this in simple_xattr_list by checking if the filesystem supports
POSIX ACLs.

Fixes: 786534b92f3c ("tmpfs: listxattr should include POSIX ACL xattrs")
Reported-by: Marc Aurele La France <tsi@tuyoix.net>
Tested-by: Marc Aurèle La France <tsi@tuyoix.net>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
CC: Stable <stable@vger.kernel.org> # v4.5+
---
 fs/xattr.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index daa732550088..0d6a6a4af861 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -948,17 +948,19 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	int err = 0;
 
 #ifdef CONFIG_FS_POSIX_ACL
-	if (inode->i_acl) {
-		err = xattr_list_one(&buffer, &remaining_size,
-				     XATTR_NAME_POSIX_ACL_ACCESS);
-		if (err)
-			return err;
-	}
-	if (inode->i_default_acl) {
-		err = xattr_list_one(&buffer, &remaining_size,
-				     XATTR_NAME_POSIX_ACL_DEFAULT);
-		if (err)
-			return err;
+	if (IS_POSIXACL(inode)) {
+		if (inode->i_acl) {
+			err = xattr_list_one(&buffer, &remaining_size,
+					     XATTR_NAME_POSIX_ACL_ACCESS);
+			if (err)
+				return err;
+		}
+		if (inode->i_default_acl) {
+			err = xattr_list_one(&buffer, &remaining_size,
+					     XATTR_NAME_POSIX_ACL_DEFAULT);
+			if (err)
+				return err;
+		}
 	}
 #endif
 
-- 
2.17.1

