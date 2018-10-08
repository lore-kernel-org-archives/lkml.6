Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3FE21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSqgOWPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3FE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeJICGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729209AbeJICGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:04 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0305B204FD;
        Mon,  8 Oct 2018 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024776;
        bh=GIidu9tuPJ0eMqHmckWvxQ+B4MHm2hP2/9lTi50CveQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSqgOWPJS/Kogi2LUdsxOG4FSXv2FZlM3QnrsLrVggL3ve8VshKlvhtoI/IjwW8cg
         csdqdu+QO5e9TVnxNzCipv8ON4I+U3BKvL/Tu7fvytRf/o49lfdGVG6mweQVvoT/Bl
         kw+TjwrxFpp1k+d7lAe2p776mbsmbHx37DaEyvCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.18 150/168] sysfs: Do not return POSIX ACL xattrs via listxattr
Date:   Mon,  8 Oct 2018 20:32:10 +0200
Message-Id: <20181008175625.742222066@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit ffc4c92227db5699493e43eb140b4cb5904c30ff upstream.

Commit 786534b92f3c introduced a regression that caused listxattr to
return the POSIX ACL attribute names even though sysfs doesn't support
POSIX ACLs.  This happens because simple_xattr_list checks for NULL
i_acl / i_default_acl, but inode_init_always initializes those fields
to ACL_NOT_CACHED ((void *)-1).  For example:
    $ getfattr -m- -d /sys
    /sys: system.posix_acl_access: Operation not supported
    /sys: system.posix_acl_default: Operation not supported
Fix this in simple_xattr_list by checking if the filesystem supports POSIX ACLs.

Fixes: 786534b92f3c ("tmpfs: listxattr should include POSIX ACL xattrs")
Reported-by:  Marc Aurèle La France <tsi@tuyoix.net>
Tested-by: Marc Aurèle La France <tsi@tuyoix.net>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: stable@vger.kernel.org # v4.5+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xattr.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -949,17 +949,19 @@ ssize_t simple_xattr_list(struct inode *
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
 


